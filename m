Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED635E7431
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiIWGej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIWGeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:34:36 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D326392;
        Thu, 22 Sep 2022 23:34:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VQViWnv_1663914871;
Received: from 30.97.56.82(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQViWnv_1663914871)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 14:34:32 +0800
Message-ID: <882f5629-a6e2-5fcc-7d26-b3de77ca2985@linux.alibaba.com>
Date:   Fri, 23 Sep 2022 14:34:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [RESEND PATCH V5 6/7] ublk_drv: add START_USER_RECOVERY and
 END_USER_RECOVERY support
Content-Language: en-US
To:     ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220923061505.52007-1-ZiyangZhang@linux.alibaba.com>
 <20220923061505.52007-7-ZiyangZhang@linux.alibaba.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20220923061505.52007-7-ZiyangZhang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/23 14:15, ZiyangZhang wrote:
> START_USER_RECOVERY and END_USER_RECOVERY are two new control commands
> to support user recovery feature.
> 
> After a crash, user should send START_USER_RECOVERY, it will:
> (1) check if (a)current ublk_device is UBLK_S_DEV_QUIESCED which was
>     set by quiesce_work and (b)chardev is released
> (2) reinit all ubqs, including:
>     (a) put the task_struct and reset ->ubq_daemon to NULL.
>     (b) reset all ublk_io.
> (3) reset ub->mm to NULL.
> 
> Then, user should start a new process and send FETCH_REQ on each
> ubq_daemon.
> 
> Finally, user should send END_USER_RECOVERY, it will:
> (1) wait for all new ubq_daemons getting ready.
> (2) update ublksrv_pid
> (3) unquiesce the request queue and expect incoming ublk_queue_rq()
> (4) convert ub's state to UBLK_S_DEV_LIVE
> 
> Note: we can handle STOP_DEV between START_USER_RECOVERY and
> END_USER_RECOVERY. This is helpful to users who cannot start new process
> after sending START_USER_RECOVERY ctrl-cmd.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>

Let me explain why we still need two ctrl-cmds: START_USER_RECOVERY
and END_USER_RECOVERY:

(1) They are easy to use and understand. Just like calling
    a)ADD_DEV, b)start daemon c)START_DEV, we can recover a device by
    a)START_USER_RECOVERY b)start new daemon c)END_USER_RECOVERY.
    IMO, START_USER_RECOVERY can guide user whether to start a new daemon.
    Without it, user must directly start a new daemon. He may fail here
    because /dev/ublkc* is not released. So a retry is necessary here.
    But I think that let the user retry by sending START_USER_RECOVERY
    instead of opening /dev/ublkc* is more reasonable.

(2) Handling put_task_struct(ubq_daemon) is hard in ublk_ch_release().
    Assume all ioucmds have been issued back to userspace and a crash happens,
    ublk_ch_release() can be called immediately here and ubq_daemon is
    freed. But monoitor_work may be running now. Dealing with UAF on
    ubq_daemon in monitor_work may be difficult. But handling
    put_task_struct(ubq_daemon) in START_USER_RECOVERY solves the problem
    because monitor_work is sure to be canceled. Besides, here is no race
    with ublk_deinit_queue() since it cannot be called if ub's state is
    QUIESCED.

Regards,
Zhang
