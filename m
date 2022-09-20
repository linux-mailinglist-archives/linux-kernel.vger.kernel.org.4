Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF925BDA50
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiITCmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiITCmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:42:09 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2DC3C16E;
        Mon, 19 Sep 2022 19:42:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQGxJtb_1663641719;
Received: from 30.97.56.91(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQGxJtb_1663641719)
          by smtp.aliyun-inc.com;
          Tue, 20 Sep 2022 10:42:00 +0800
Message-ID: <341e500b-487d-f16a-8ba6-399e2972b685@linux.alibaba.com>
Date:   Tue, 20 Sep 2022 10:41:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V3 6/7] ublk_drv: add START_USER_RECOVERY and
 END_USER_RECOVERY support
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
 <20220913041707.197334-7-ZiyangZhang@linux.alibaba.com>
 <Yyhom5s4AxK+wSu4@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <Yyhom5s4AxK+wSu4@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/19 21:03, Ming Lei wrote:
> On Tue, Sep 13, 2022 at 12:17:06PM +0800, ZiyangZhang wrote:
>> START_USER_RECOVERY and END_USER_RECOVERY are two new control commands
>> to support user recovery feature.
>>
>> After a crash, user should send START_USER_RECOVERY, it will:
>> (1) check if (a)current ublk_device is UBLK_S_DEV_QUIESCED which was
>>     set by quiesce_work and (b)the file struct is released.
>> (2) reinit all ubqs, including:
>>     (a) put the task_struct and reset ->ubq_daemon to NULL.
>>     (b) reset all ublk_io.
>> (3) reset ub->mm to NULL.
>>
>> Then, user should start a new process and send FETCH_REQ on each
>> ubq_daemon.
>>
>> Finally, user should send END_USER_RECOVERY, it will:
>> (1) wait for all new ubq_daemons getting ready.
>> (2) update ublksrv_pid
>> (3) unquiesce the request queue and expect incoming ublk_queue_rq()
>> (4) convert ub's state to UBLK_S_DEV_LIVE
>>
>> Note: we can handle STOP_DEV between START_USER_RECOVERY and
>> END_USER_RECOVERY. This is helpful to users who cannot start new process
>> after sending START_USER_RECOVERY ctrl-cmd.
>>
>> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
>> ---
>>  drivers/block/ublk_drv.c | 116 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 116 insertions(+)
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 4409a130d0b6..3a3af80ee938 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -1961,6 +1961,116 @@ static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
>>  	return ret;
>>  }
>>  
>> +static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
>> +{
>> +	int i;
>> +
>> +	WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
>> +	/* All old ioucmds have to be completed */
>> +	WARN_ON_ONCE(ubq->nr_io_ready);
>> +	pr_devel("%s: prepare for recovering qid %d\n", __func__, ubq->q_id);
>> +	/* old daemon is PF_EXITING, put it now */
>> +	put_task_struct(ubq->ubq_daemon);
>> +	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
>> +	ubq->ubq_daemon = NULL;
>> +
>> +	for (i = 0; i < ubq->q_depth; i++) {
>> +		struct ublk_io *io = &ubq->ios[i];
>> +
>> +		/* forget everything now and be ready for new FETCH_REQ */
>> +		io->flags = 0;
>> +		io->cmd = NULL;
>> +		io->addr = 0;
>> +	}
>> +}
>> +
>> +static int ublk_ctrl_start_recovery(struct io_uring_cmd *cmd)
>> +{
>> +	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
>> +	struct ublk_device *ub;
>> +	int ret = -EINVAL;
>> +	int i;
>> +
>> +	ub = ublk_get_device_from_id(header->dev_id);
>> +	if (!ub)
>> +		return ret;
>> +
>> +	mutex_lock(&ub->mutex);
>> +	if (!ublk_can_use_recovery(ub))
>> +		goto out_unlock;
>> +	/*
>> +	 * START_RECOVERY is only allowd after:
>> +	 *
>> +	 * (1) UB_STATE_OPEN is not set, which means the dying process is exited
>> +	 *     and related io_uring ctx is freed so file struct of /dev/ublkcX is
>> +	 *     released.
>> +	 *
>> +	 * (2) UBLK_S_DEV_QUIESCED is set, which means the quiesce_work:
>> +	 *     (a)has quiesced request queue
>> +	 *     (b)has requeued every inflight rqs whose io_flags is ACTIVE
>> +	 *     (c)has requeued/aborted every inflight rqs whose io_flags is NOT ACTIVE
>> +	 *     (d)has completed/camceled all ioucmds owned by ther dying process
>> +	 */
>> +	if (test_bit(UB_STATE_OPEN, &ub->state) ||
>> +			ub->dev_info.state != UBLK_S_DEV_QUIESCED) {
>> +		ret = -EBUSY;
>> +		goto out_unlock;
>> +	}
>> +	pr_devel("%s: start recovery for dev id %d.\n", __func__, header->dev_id);
>> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
>> +		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
>> +	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
>> +	ub->mm = NULL;
>> +	ub->nr_queues_ready = 0;
> 
> I am wondering why you don't move the above(queue reinit, clearing ub->mm)
> into ublk_ch_release(), and looks it is more clean to clear this stuff
> there. Meantime I guess one control command might be enough for user
> recovery.


OK, START_USER_RECOVERY just does cleanup stuff for a new process and
ublk_ch_release() does the similar thing since it is always called when chardev
is released. And our new process must open the chardev after it is released.

So (queue reinit, clearing ub->mm) can be done in ublk_ch_release().

Regards,
Zhang.
