Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B543E5E73C0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiIWGPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIWGPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:15:50 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DD4F9611;
        Thu, 22 Sep 2022 23:15:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQVS0aR_1663913740;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQVS0aR_1663913740)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 14:15:45 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RESEND PATCH V5 0/7] ublk_drv: add USER_RECOVERY support
Date:   Fri, 23 Sep 2022 14:14:58 +0800
Message-Id: <20220923061505.52007-1-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ublk_drv is a driver simply passes all blk-mq rqs to userspace
target(such as ublksrv[1]). For each ublk queue, there is one
ubq_daemon(pthread). All ubq_daemons share the same process
which opens /dev/ublkcX. The ubq_daemon code infinitely loops on
io_uring_enter() to send/receive io_uring cmds which pass
information of blk-mq rqs.

Since the real IO handler(the process/thread opening /dev/ublkcX) is
in userspace, it could crash if:
(1) the user kills -9 it because of IO hang on backend, system
    reboot, etc...
(2) the process/thread catches a exception(segfault, divisor error,
oom...) Therefore, the kernel driver has to deal with a dying
ubq_daemon or the process.

Now, if one ubq_daemon(pthread) or the process crashes, ublk_drv
must abort the dying ubq, stop the device and release everything.
This is not a good choice in practice because users do not expect
aborted requests, I/O errors and a released device. They may want
a recovery machenism so that no requests are aborted and no I/O
error occurs. Anyway, users just want everything works as usual.

This patchset implements USER_RECOVERY support. If the process
or any ubq_daemon(pthread) crashes(exits accidentally), we allow
user to provide new process and ubq_daemons.

Note: The responsibility of recovery belongs to the user who opens
/dev/ublkcX. After a crash, the kernel driver only switch the
device's state to be ready for recovery(START_USER_RECOVERY) or
termination(STOP_DEV). The state is defined as UBLK_S_DEV_QUIESCED.
This patchset does not provide how to detect such a crash in userspace.
The user has may ways to do so. For example, user may:
(1) send GET_DEV_INFO on specific dev_id and check if its state is
    UBLK_S_DEV_QUIESCED.
(2) 'ps' on ublksrv_pid.

Recovery feature is quite useful for real products. In detail,
we support this scenario:
(1) The /dev/ublkc0 is opened by process 0.
(2) Fio is running on /dev/ublkb0 exposed by ublk_drv and all
    rqs are handled by process 0.
(3) Process 0 suddenly crashes(e.g. segfault);
(4) Fio is still running and submit IOs(but these IOs cannot
    be dispatched now)
(5) User starts process 1 and attach it to /dev/ublkc0
(6) All rqs are handled by process 1 now and IOs can be
    completed now.

Note: The backend must tolerate double-write because we re-issue
a rq sent to the old process 0 before.

We provide a sample script here to simulate the above steps:

***************************script***************************
LOOPS=10

__ublk_get_pid() {
	pid=`./ublk list -n 0 | grep "pid" | awk '{print $7}'`
	echo $pid
}

ublk_recover_kill()
{
	for CNT in `seq $LOOPS`; do
		dmesg -C
                pid=`__ublk_get_pid`
                echo -e "*** kill $pid now ***"
		kill -9 $pid
		sleep 6
                echo -e "*** recover now ***"
                ./ublk recover -n 0
		sleep 6
	done
}

ublk_test()
{
        echo -e "*** add ublk device ***"
        ./ublk add -t null -d 4 -i 1
        sleep 2
        echo -e "*** start fio ***"
        fio --bs=4k \
            --filename=/dev/ublkb0 \
            --runtime=140s \
            --rw=read &
        sleep 4
        ublk_recover_kill
        wait
        echo -e "*** delete ublk device ***"
        ./ublk del -n 0
}

for CNT in `seq 4`; do
        modprobe -rv ublk_drv
        modprobe ublk_drv
        echo -e "************ round $CNT ************"
        ublk_test
        sleep 5
done
***************************script***************************

You may run it with our modified ublksrv[2] which supports
recovery feature. No I/O error occurs and you can verify it
by typing
    $ perf-tools/bin/tpoint block:block_rq_error

The basic idea of USER_RECOVERY is quite straightfoward:
(1) quiesce ublk queues and requeue/abort rqs.
(2) release/free everything belongs to the dying process.
    Note: Since ublk_drv does save information about user process,
    this work is important because we don't expect any resource
    lekage. Particularly, ioucmds from the dying ubq_daemons
    need to be completed(freed).
(3) allow new ubq_daemons issue FETCH_REQ.
    Note: ublk_ch_uring_cmd() checks some states and flags. We
    have to set them to a correct value.

Here is steps to reocver:
(0) requests dispatched after the corresponding ubq_daemon is dying 
    are requeued.
(1) monitor_work finds one dying ubq_daemon, and it should
    schedule quiesce_work and requeue/abort requests issued to
    userspace before the ubq_daemon is dying.
(2) quiesce_work must (a)quiesce request queue to ban any incoming
    ublk_queue_rq(), (b)wait unitl all rqs are IDLE, (c)complete old
	  ioucmds. Then the ublk device is ready for recovery or stop.
(3) The user sends START_USER_RECOVERY ctrl-cmd to /dev/ublk-control
    with a dev_id X (such as 3 for /dev/ublkc3).
(4) Then ublk_drv should perpare for a new process to attach /dev/ublkcX.
    All ublk_io structures are cleared and ubq_daemons are reset.
(5) Then, user should start a new process and ubq_daemons(pthreads) and
    send FETCH_REQ by io_uring_enter() to make all ubqs be ready. The
    user must correctly setup queues, flags and so on(how to persist
    user's information is not related to this patchset).
(6) The user sends END_USER_RECOVERY ctrl-cmd to /dev/ublk-control with a
    dev_id X.
(7) After receiving END_USER_RECOVERY, ublk_drv waits for all ubq_daemons
    getting ready. Then it unquiesces request queue and new rqs are
    allowed.

You should use ublksrv[2] and tests[3] provided by us. We add 3 additional
tests to verify that recovery feature works. Our code will be PR-ed to
Ming's repo soon.

[1] https://github.com/ming1/ubdsrv
[2] https://github.com/old-memories/ubdsrv/tree/recovery-v1
[3] https://github.com/old-memories/ubdsrv/tree/recovery-v1/tests/generic

Since V4:
(1) remove ublk_cancel_dev() refactor patch 
(2) keep START_USER_RECOVERY and END_USER_RECOVERY
(3) avoid UAF on ubq_daemon in monitor_work
(4) add one helper for requeuing/ending rqs

Since V3:
(1) do not kick requeue list in ublk_queue_rq() or io_uring fallback wq
    with a dying ubq_daemon but kicking the list once while unquiescing dev
(2) add comment on requeing rqs in ublk_queue_rq(), or io_uring fallback wq
    with a dying ubq_daemon
(3) split support for UBLK_F_USER_RECOVERY_REISSUE into a single patch
(4) let monitor_work abort/requeue rqs issued to userspace instead of
    quiesce_work with recovery enabled
(5) alway wait until no INFLIGHT rq exists in ublk_quiesce_dev()
(6) move ublk re-init stuff into ublk_ch_release()
(7) let ublk_quiesce_dev() go on as long as one ubq_daemon is dying
(8) add only one ctrl-cmd and rename it as RESTART_DEV
(9) check ub.dev_info->flags instead of iterating on all ubqs
(10) do not disable recoevry feature, but always qiuesce dev in
     ublk_stop_dev() and then unquiesce it
(11) add doc on USER_RECOVERY feature
 
Since V2:
(1) run ublk_quiesce_dev() in a standalone work.
(2) do not run monitor_work after START_USER_RECOVERY is handled.
(3) refactor recovery feature code so that it does not affect current code.

Since V1:
(1) refactor cover letter. Add intruduction on "how to detect a crash" and
    "why we need recovery feature".
(2) do not refactor task_work and ublk_queue_rq().
(3) allow users freely stop/recover the device.
(4) add comment on ublk_cancel_queue().
(5) refactor monitor_work and aborting machenism since we add recovery
    machenism in monitor_work.

ZiyangZhang (7):
  ublk_drv: check 'current' instead of 'ubq_daemon'
  ublk_drv: define macros for recovery feature and check them
  ublk_drv: requeue rqs with recovery feature enabled
  ublk_drv: consider recovery feature in aborting mechanism
  ublk_drv: support UBLK_F_USER_RECOVERY_REISSUE
  ublk_drv: add START_USER_RECOVERY and END_USER_RECOVERY support
  Documentation: document ublk user recovery feature

 Documentation/block/ublk.rst  |  32 ++++
 drivers/block/ublk_drv.c      | 297 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |   8 +-
 3 files changed, 322 insertions(+), 15 deletions(-)

-- 
2.27.0

