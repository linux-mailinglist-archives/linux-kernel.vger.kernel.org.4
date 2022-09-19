Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4865BC5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiISJzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiISJz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:55:29 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C0FE026;
        Mon, 19 Sep 2022 02:55:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQAvv2x_1663581307;
Received: from 30.97.56.99(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQAvv2x_1663581307)
          by smtp.aliyun-inc.com;
          Mon, 19 Sep 2022 17:55:08 +0800
Message-ID: <9a682fac-f022-1f4d-5c2c-e1f0a84746d8@linux.alibaba.com>
Date:   Mon, 19 Sep 2022 17:55:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V3 5/7] ublk_drv: consider recovery feature in aborting
 mechanism
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
 <20220913041707.197334-6-ZiyangZhang@linux.alibaba.com>
 <Yyg3KLfQaxbS1miq@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <Yyg3KLfQaxbS1miq@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/19 17:32, Ming Lei wrote:
> On Tue, Sep 13, 2022 at 12:17:05PM +0800, ZiyangZhang wrote:
>> With USER_RECOVERY feature enabled, the monitor_work schedules
>> quiesce_work after finding a dying ubq_daemon. The quiesce_work's job
>> is to:
>> (1) quiesce request queue.
>> (2) check if there is any INFLIGHT rq with UBLK_IO_FLAG_ACTIVE unset.
>>     If so, we retry until all these rqs are requeued by ublk_queue_rq()
>>     and task_work and become IDLE.
> 
> These requests should be being handled by task work or the io_uring
> fallback wq, and suggest to add the words here.

Will do so.

> 
>> (3) requeue/abort inflight rqs issued to the crash ubq_daemon before. If
>>     UBLK_F_USER_RECOVERY_REISSUE is set, rq is requeued; or it is
>>     aborted.
>> (4) complete all ioucmds by calling io_uring_cmd_done(). We are safe to
>>     do so because no ioucmd can be referenced now.
>> (5) set ub's state to UBLK_S_DEV_QUIESCED, which means we are ready for
>>     recovery. This state is exposed to userspace by GET_DEV_INFO.
>>
>> The driver can always handle STOP_DEV and cleanup everything no matter
>> ub's state is LIVE or QUIESCED. After ub's state is UBLK_S_DEV_QUIESCED,
>> user can recover with new process by sending START_USER_RECOVERY.
>>
>> Note: we do not change the default behavior with reocvery feature
>> disabled. monitor_work still schedules stop_work and abort inflight
>> rqs. Finally ublk_device is released.
> 
> This version looks much better than before.

Thanks :)

> 
>>
>> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
>> ---
>>  drivers/block/ublk_drv.c | 168 +++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 161 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index b067f33a1913..4409a130d0b6 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -121,7 +121,7 @@ struct ublk_queue {
>>  
>>  	unsigned long io_addr;	/* mapped vm address */
>>  	unsigned int max_io_sz;
>> -	bool abort_work_pending;
>> +	bool force_abort;
>>  	unsigned short nr_io_ready;	/* how many ios setup */
>>  	struct ublk_device *dev;
>>  	struct ublk_io ios[0];
>> @@ -163,6 +163,7 @@ struct ublk_device {
>>  	 * monitor each queue's daemon periodically
>>  	 */
>>  	struct delayed_work	monitor_work;
>> +	struct work_struct	quiesce_work;
>>  	struct work_struct	stop_work;
>>  };
>>  
>> @@ -660,6 +661,11 @@ static void __ublk_fail_req(struct ublk_io *io, struct request *req)
>>  	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
>>  
>>  	if (!(io->flags & UBLK_IO_FLAG_ABORTED)) {
>> +		pr_devel("%s: abort rq: qid %d tag %d io_flags %x\n",
>> +				__func__,
>> +				((struct ublk_queue *)req->mq_hctx->driver_data)->q_id,
> 
> req->mq_hctx->queue_num is cleaner.

Ok.

> 
>> +				req->tag,
>> +				io->flags);
>>  		io->flags |= UBLK_IO_FLAG_ABORTED;
>>  		blk_mq_end_request(req, BLK_STS_IOERR);
>>  	}
>> @@ -820,6 +826,21 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>>  	res = ublk_setup_iod(ubq, rq);
>>  	if (unlikely(res != BLK_STS_OK))
>>  		return BLK_STS_IOERR;
>> +    /* With recovery feature enabled, force_abort is set in
>> +     * ublk_stop_dev() before calling del_gendisk() if ub's state
>> +     * is QUIESCED. We have to abort all requeued and new rqs here
>> +     * to let del_gendisk() move on. Besides, we do not call
>> +     * io_uring_cmd_complete_in_task() to avoid UAF on io_uring ctx.
>> +     *
>> +     * Note: force_abort is guaranteed to be seen because it is set
>> +     * before request queue is unqiuesced.
>> +     */
>> +	if (unlikely(ubq->force_abort)) {
>> +		pr_devel("%s: abort rq: qid %d tag %d io_flags %x\n",
>> +				__func__, ubq->q_id, rq->tag,
>> +				ubq->ios[rq->tag].flags);
>> +		return BLK_STS_IOERR;
>> +	}
>>  
>>  	blk_mq_start_request(bd->rq);
>>  
>> @@ -1003,6 +1024,101 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
>>  	ublk_put_device(ub);
>>  }
>>  
>> +static bool ublk_check_inflight_rq(struct request *rq, void *data)
>> +{
>> +	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
>> +	struct ublk_io *io = &ubq->ios[rq->tag];
>> +	bool *busy = data;
>> +
>> +	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
>> +		*busy = true;
>> +		return false;
>> +	}
>> +	return true;
>> +}
>> +
>> +static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
>> +{
>> +	bool busy = false;
>> +
>> +	WARN_ON_ONCE(!blk_queue_quiesced(ub->ub_disk->queue));
>> +	while (true) {
>> +		blk_mq_tagset_busy_iter(&ub->tag_set,
>> +				ublk_check_inflight_rq, &busy);
>> +		if (busy)
>> +			msleep(UBLK_REQUEUE_DELAY_MS);
>> +		else
>> +			break;
>> +	}
>> +}
>> +
>> +static void ublk_quiesce_queue(struct ublk_device *ub,
>> +		struct ublk_queue *ubq)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ubq->q_depth; i++) {
>> +		struct ublk_io *io = &ubq->ios[i];
>> +
>> +		if (!(io->flags & UBLK_IO_FLAG_ACTIVE)) {
>> +			struct request *rq = blk_mq_tag_to_rq(
>> +					ub->tag_set.tags[ubq->q_id], i);
>> +
>> +			WARN_ON_ONCE(!rq);
>> +			pr_devel("%s: %s rq: qid %d tag %d io_flags %x\n", __func__,
>> +					ublk_queue_can_use_recovery_reissue(ubq) ?
>> +					"requeue" : "abort",
>> +					ubq->q_id, i, io->flags);
>> +			if (ublk_queue_can_use_recovery_reissue(ubq))
>> +				blk_mq_requeue_request(rq, false);
> 
> This way is too violent.
> 
> There may be just one queue dying, but you requeue all requests
> from any queue. I'd suggest to take the approach in ublk_daemon_monitor_work(),
> such as, just requeuing requests in dying queue.

If we want to start a new process after a crash for USER_RECOVERY, all old ubq_daemons
must exit and rqs of all queues have to be requeued/aborted. We cannot let live
ubq_daemons run any more because they do not belong to the new process.

BTW, I really wonder why there could be just one queue dying? All queues must be dying
shortly after any ubq_daemon is dying since they are all pthreads in the same process.

> 
> That said you still can re-use the logic in ublk_abort_queue()/ublk_daemon_monitor_work()
> for making progress, just changing aborting request with requeue in
> ublk_abort_queue().

I get your point, but it may be hard to reuse the logic in ublk_daemon_monitor_work()
because:
(1) we have to quiesce request queue in ublk_quiesce_dev(). This has to be done with
    ub_mutex.
(2) ublk_quiesce_dev() cannot be run after rqs are requeued/aborted.

> 
>> +			else
>> +				__ublk_fail_req(io, rq);
>> +		} else {
>> +			pr_devel("%s: done old cmd: qid %d tag %d\n",
>> +					__func__, ubq->q_id, i);
>> +			io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0);
>> +			io->flags &= ~UBLK_IO_FLAG_ACTIVE;
>> +		}
>> +		ubq->nr_io_ready--;
>> +	}
>> +	WARN_ON_ONCE(ubq->nr_io_ready);
>> +}
>> +
>> +static void ublk_quiesce_dev(struct ublk_device *ub)
>> +{
>> +	int i;
>> +
>> +	mutex_lock(&ub->mutex);
>> +	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
>> +		goto unlock;
>> +
>> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
>> +		struct ublk_queue *ubq = ublk_get_queue(ub, i);
>> +
>> +		if (!ubq_daemon_is_dying(ubq))
>> +			goto unlock;
>> +	}
>> +	blk_mq_quiesce_queue(ub->ub_disk->queue);
>> +	ublk_wait_tagset_rqs_idle(ub);
>> +	pr_devel("%s: quiesce ub: dev_id %d\n",
>> +			__func__, ub->dev_info.dev_id);
>> +
>> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
>> +		ublk_quiesce_queue(ub, ublk_get_queue(ub, i));
>> +
>> +	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
>> + unlock:
>> +	mutex_unlock(&ub->mutex);
>> +}
>> +
>> +static void ublk_quiesce_work_fn(struct work_struct *work)
>> +{
>> +	struct ublk_device *ub =
>> +		container_of(work, struct ublk_device, quiesce_work);
>> +
>> +	ublk_quiesce_dev(ub);
>> +}
>> +
>>  static void ublk_daemon_monitor_work(struct work_struct *work)
>>  {
>>  	struct ublk_device *ub =
>> @@ -1013,10 +1129,14 @@ static void ublk_daemon_monitor_work(struct work_struct *work)
>>  		struct ublk_queue *ubq = ublk_get_queue(ub, i);
>>  
>>  		if (ubq_daemon_is_dying(ubq)) {
>> -			schedule_work(&ub->stop_work);
>> -
>> -			/* abort queue is for making forward progress */
>> -			ublk_abort_queue(ub, ubq);
>> +			if (ublk_queue_can_use_recovery(ubq)) {
>> +				schedule_work(&ub->quiesce_work);
>> +			} else {
>> +				schedule_work(&ub->stop_work);
>> +
>> +				/* abort queue is for making forward progress */
>> +				ublk_abort_queue(ub, ubq);
>> +			}
> 
> If quiesce work are always scheduled exclusively with stop work,
> the two can be defined as union, but not one big deal.

OK.

Regards,
Zhang
