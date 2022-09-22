Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34885E58F5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 05:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiIVDBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 23:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiIVDBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:01:08 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F279E886;
        Wed, 21 Sep 2022 20:01:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQQW0TC_1663815658;
Received: from 30.97.56.134(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQQW0TC_1663815658)
          by smtp.aliyun-inc.com;
          Thu, 22 Sep 2022 11:00:59 +0800
Message-ID: <36b9ac37-358f-8f45-4f06-64ddf18f36dd@linux.alibaba.com>
Date:   Thu, 22 Sep 2022 11:00:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V4 7/8] ublk_drv: allow new process to open ublk chardev
 with recovery feature enabled
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20220921095849.84988-1-ZiyangZhang@linux.alibaba.com>
 <20220921095849.84988-8-ZiyangZhang@linux.alibaba.com>
 <YyvKuiRAmiMYMS7b@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <YyvKuiRAmiMYMS7b@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/22 10:38, Ming Lei wrote:
> On Wed, Sep 21, 2022 at 05:58:48PM +0800, ZiyangZhang wrote:
>> With recovery feature enabled, if ublk chardev is ready to be released
>> and quiesce_work has been scheduled, we:
>> (1) cancel monitor_work to avoid UAF on ubq && ublk_io.
>> (2) reinit all ubqs, including:
>>     (a) put the task_struct and reset ->ubq_daemon to NULL.
>>     (b) reset all ublk_io.
>> (3) reset ub->mm to NULL.
>> Then ublk chardev is released and new process can open it.
>>
>> RESTART_DEV is introduced as a new ctrl-cmd for recovery feature.
>> After the chardev is opened and all ubqs are ready, user should send
>> RESTART_DEV to:
>> (1) wait until all new ubq_daemons getting ready.
>> (2) update ublksrv_pid
>> (3) unquiesce the request queue and expect incoming ublk_queue_rq()
>> (4) convert ub's state to UBLK_S_DEV_LIVE
>> (5) reschedule monitor_work
>>
>> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
>> ---
>>  drivers/block/ublk_drv.c      | 109 +++++++++++++++++++++++++++++++++-
>>  include/uapi/linux/ublk_cmd.h |   1 +
>>  2 files changed, 109 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index dc33ebc20c01..871cd48503a2 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -912,10 +912,67 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
>>  	return 0;
>>  }
>>  
>> +static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
>> +{
>> +	int i;
>> +
>> +	WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
>> +	pr_devel("%s: prepare for recovering qid %d\n", __func__, ubq->q_id);
>> +	/* old daemon is PF_EXITING, put it now */
>> +	put_task_struct(ubq->ubq_daemon);
>> +	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
>> +	ubq->ubq_daemon = NULL;
> 
> Then we can kill the task put & reset in ublk_deinit_queue(), and call
> ublk_queue_reinit() unconditionally in ublk_ch_release(). 

ublk_queue_reinit() can only be called if ub->dev_info.state == UBLK_S_DEV_QUIESCED.
If we have done ublk_deinit_queue(), we cannot not be in UBLK_S_DEV_QUIESCED state.

> 
>> +
>> +	for (i = 0; i < ubq->q_depth; i++) {
>> +		struct ublk_io *io = &ubq->ios[i];
>> +
>> +		/* forget everything now and be ready for new FETCH_REQ */
>> +		io->flags = 0;
>> +		io->cmd = NULL;
>> +		io->addr = 0;
>> +	}
>> +	ubq->nr_io_ready = 0;
> 
> I guess the above line should have been WARN_ON_ONCE(!ubq->nr_io_ready)?


Before V4, It was WARN_ON_ONCE(!ubq->nr_io_ready). But ublk_cancel_queue() is called
in __ublk_quiesce_dev() now. In ublk_cancel_queue(), ->nr_io_ready is only decreased
if io->flags is ACTIVE. If some ioucmds has been sent to userspace and then a crash
happens, some ublk_ios' flags are ACTIVE while others are NOT. So here ->nr_io_ready
might not be zero.

ublk_cancel_queue() was called only before/after ublk device is started/stopped.
So in the past, ubq->nr_io_ready is always zero. But now I think
WARN_ON_ONCE(ubq->nr_io_ready) in ublk_cancel_queue() should also be removed
for the above reason.

> 
>> +}
>> +
>>  static int ublk_ch_release(struct inode *inode, struct file *filp)
>>  {
>>  	struct ublk_device *ub = filp->private_data;
>> +	int i;
>> +
>> +	/* lockless fast path */
>> +	if (!unlikely(ublk_can_use_recovery(ub) && ub->dev_info.state == UBLK_S_DEV_QUIESCED))
>> +		goto out_clear;
>> +
>> +	mutex_lock(&ub->mutex);
>> +	/*
>> +	 * USER_RECOVERY is only allowd after UBLK_S_DEV_QUIESCED is set,
>> +	 * which means that:
>> +	 *     (a) request queue has been quiesced
>> +	 *     (b) no inflight rq exists
>> +	 *     (c) all ioucmds owned by ther dying process are completed
>> +	 */
>> +	if (!(ublk_can_use_recovery(ub) && ub->dev_info.state == UBLK_S_DEV_QUIESCED))
>> +		goto out_unlock;
>> +	pr_devel("%s: reinit queues for dev id %d.\n", __func__, ub->dev_info.dev_id);
>> +	/* we are going to release task_struct of ubq_daemon and resets
>> +	 * ->ubq_daemon to NULL. So in monitor_work, check on ubq_daemon causes UAF.
>> +	 * Besides, monitor_work is not necessary in QUIESCED state since we have
>> +	 * already scheduled quiesce_work and quiesced all ubqs.
>> +	 *
>> +	 * Do not let monitor_work schedule itself if state it QUIESCED. And we cancel
>> +	 * it here and re-schedule it in RESTART_DEV to avoid UAF.
>> +	 */
>> +	cancel_delayed_work_sync(&ub->monitor_work);
> 
> monitor_work isn't supposed to be done here, which should be called after
> ublk_wait_tagset_rqs_idle(ub) returns.

So we do not need to cancel monbitor_work here and re-schedule it in RESTART_DEV?
I am worried about UAF in monitor_work's check on ubq_daemon since ubq_daemon is
invalid during user recovery.

> 
>>  
>> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
>> +		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
>> +	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
>> +	ub->mm = NULL;
>> +	ub->nr_queues_ready = 0;
>> +	init_completion(&ub->completion);
> 
> The above can be done as generic code for both non-recovery and recovery
> code.

OK, it should be moved.

> 
>> + out_unlock:
>> +	mutex_unlock(&ub->mutex);
>> + out_clear:
>>  	clear_bit(UB_STATE_OPEN, &ub->state);
>>  	return 0;
>>  }
>> @@ -1199,9 +1256,14 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
>>  		ubq->ubq_daemon = current;
>>  		get_task_struct(ubq->ubq_daemon);
>>  		ub->nr_queues_ready++;
>> +		pr_devel("%s: ub %d qid %d is ready.\n",
>> +				__func__, ub->dev_info.dev_id, ubq->q_id);
>>  	}
>> -	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
>> +	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues) {
>> +		pr_devel("%s: ub %d all ubqs are ready.\n",
>> +				__func__, ub->dev_info.dev_id);
>>  		complete_all(&ub->completion);
>> +	}
> 
> Too many logging.

They will be removed.

> 
>>  	mutex_unlock(&ub->mutex);
>>  }
>>  
>> @@ -1903,6 +1965,48 @@ static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
>>  	return ret;
>>  }
>>  
>> +static int ublk_ctrl_restart_dev(struct io_uring_cmd *cmd)
>> +{
>> +	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
>> +	int ublksrv_pid = (int)header->data[0];
>> +	struct ublk_device *ub;
>> +	int ret = -EINVAL;
>> +
>> +	ub = ublk_get_device_from_id(header->dev_id);
>> +	if (!ub)
>> +		return ret;
>> +
>> +	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
>> +			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
>> +	/* wait until new ubq_daemon sending all FETCH_REQ */
>> +	wait_for_completion_interruptible(&ub->completion);
>> +	pr_devel("%s: All new ubq_daemons(nr: %d) are ready, dev id %d\n",
>> +			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
>> +
>> +	mutex_lock(&ub->mutex);
>> +	if (!ublk_can_use_recovery(ub))
>> +		goto out_unlock;
>> +
>> +	if (ub->dev_info.state != UBLK_S_DEV_QUIESCED) {
>> +		ret = -EBUSY;
>> +		goto out_unlock;
>> +	}
>> +	ub->dev_info.ublksrv_pid = ublksrv_pid;
>> +	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
>> +			__func__, ublksrv_pid, header->dev_id);
>> +	blk_mq_unquiesce_queue(ub->ub_disk->queue);
>> +	pr_devel("%s: queue unquiesced, dev id %d.\n",
>> +			__func__, header->dev_id);
>> +	blk_mq_kick_requeue_list(ub->ub_disk->queue);
>> +	ub->dev_info.state = UBLK_S_DEV_LIVE;
>> +	schedule_delayed_work(&ub->monitor_work, UBLK_DAEMON_MONITOR_PERIOD);
>> +	ret = 0;
>> + out_unlock:
>> +	mutex_unlock(&ub->mutex);
>> +	ublk_put_device(ub);
>> +	return ret;
>> +}
>> +
>>  static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
>>  		unsigned int issue_flags)
>>  {
>> @@ -1944,6 +2048,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
>>  	case UBLK_CMD_SET_PARAMS:
>>  		ret = ublk_ctrl_set_params(cmd);
>>  		break;
>> +	case UBLK_CMD_RESTART_DEV:
>> +		ret = ublk_ctrl_restart_dev(cmd);
>> +		break;
>>  	default:
>>  		break;
>>  	}
>> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
>> index 332370628757..a088f374c0f6 100644
>> --- a/include/uapi/linux/ublk_cmd.h
>> +++ b/include/uapi/linux/ublk_cmd.h
>> @@ -17,6 +17,7 @@
>>  #define	UBLK_CMD_STOP_DEV	0x07
>>  #define	UBLK_CMD_SET_PARAMS	0x08
>>  #define	UBLK_CMD_GET_PARAMS	0x09
>> +#define UBLK_CMD_RESTART_DEV	0x10
> 
> Maybe RESET_DEV or RECOVERY_DEV is better given userspace does not
> send STOP_DEV command
OK.

Regards,
Zhang
