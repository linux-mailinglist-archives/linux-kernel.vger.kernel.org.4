Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF735E5721
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 02:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiIVATH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 20:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIVATF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 20:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFC1A6AFA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 17:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663805942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nRu96DXad/ClErJ/XbFkMXkJihUx9Hma4kYP+hzX0Dk=;
        b=D6XL0KbPKHJZSuHvMHCoYhmMfdxBBzUsPF64S920S803tezmK8FwJgrZqLZdji9MVK2iaq
        HiCvuSqWfZ5Osq3cqiLjK9e6NwC+i2Bb04XER1anaf45SHaurByRVNtuu8Z+v9bWKNKX2Y
        VfIqxuoPNDiYg53dUlN3efWiCWQjDUo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-v-Q3tZWRMSqDeJi9eyvB6Q-1; Wed, 21 Sep 2022 20:18:58 -0400
X-MC-Unique: v-Q3tZWRMSqDeJi9eyvB6Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D611811E81;
        Thu, 22 Sep 2022 00:18:58 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 060D317582;
        Thu, 22 Sep 2022 00:18:52 +0000 (UTC)
Date:   Thu, 22 Sep 2022 08:18:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH V4 5/8] ublk_drv: consider recovery feature in aborting
 mechanism
Message-ID: <Yyup5vt32fULKIJu@T590>
References: <20220921095849.84988-1-ZiyangZhang@linux.alibaba.com>
 <20220921095849.84988-6-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921095849.84988-6-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 05:58:46PM +0800, ZiyangZhang wrote:
> With USER_RECOVERY feature enabled, the monitor_work schedules
> quiesce_work after finding a dying ubq_daemon. The monitor_work
> should also abort all rqs issued to userspace before the ubq_daemon is
> dying. The quiesce_work's job is to:
> (1) quiesce request queue.
> (2) check if there is any INFLIGHT rq. If so, we retry until all these
>     rqs are requeued and become IDLE. These rqs should be requeued by
> 	ublk_queue_rq(), task work, io_uring fallback wq or monitor_work.
> (3) complete all ioucmds by calling io_uring_cmd_done(). We are safe to
>     do so because no ioucmd can be referenced now.
> (5) set ub's state to UBLK_S_DEV_QUIESCED, which means we are ready for
>     recovery. This state is exposed to userspace by GET_DEV_INFO.
> 
> The driver can always handle STOP_DEV and cleanup everything no matter
> ub's state is LIVE or QUIESCED. After ub's state is UBLK_S_DEV_QUIESCED,
> user can recover with new process.
> 
> Note: we do not change the default behavior with reocvery feature
> disabled. monitor_work still schedules stop_work and abort inflight
> rqs. And finally ublk_device is released.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>

This version is close to be ready, just some debug logging needs
be removed, see inline comment. Also I'd suggest you to learn to
use bpftrace a bit, then basically you needn't to rely on kernel
logging.

If these logging is removed, you will see how simple the patch becomes
compared with previous version.

> ---
>  drivers/block/ublk_drv.c | 137 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 125 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index b940e490ebab..9610afe11463 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -120,7 +120,7 @@ struct ublk_queue {
>  
>  	unsigned long io_addr;	/* mapped vm address */
>  	unsigned int max_io_sz;
> -	bool abort_work_pending;
> +	bool force_abort;
>  	unsigned short nr_io_ready;	/* how many ios setup */
>  	struct ublk_device *dev;
>  	struct ublk_io ios[0];
> @@ -162,6 +162,7 @@ struct ublk_device {
>  	 * monitor each queue's daemon periodically
>  	 */
>  	struct delayed_work	monitor_work;
> +	struct work_struct	quiesce_work;
>  	struct work_struct	stop_work;
>  };
>  
> @@ -628,11 +629,17 @@ static void ublk_complete_rq(struct request *req)
>   * Also aborting may not be started yet, keep in mind that one failed
>   * request may be issued by block layer again.
>   */
> -static void __ublk_fail_req(struct ublk_io *io, struct request *req)
> +static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
> +		struct request *req)
>  {
>  	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
>  
>  	if (!(io->flags & UBLK_IO_FLAG_ABORTED)) {
> +		pr_devel("%s: abort rq: qid %d tag %d io_flags %x\n",
> +				__func__,
> +				req->mq_hctx->queue_num,
> +				req->tag,
> +				io->flags);

No necessary to add the above log.

>  		io->flags |= UBLK_IO_FLAG_ABORTED;
>  		blk_mq_end_request(req, BLK_STS_IOERR);
>  	}
> @@ -676,10 +683,6 @@ static inline void __ublk_rq_task_work(struct request *req)
>  	struct ublk_io *io = &ubq->ios[tag];
>  	unsigned int mapped_bytes;
>  
> -	pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
> -			__func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
> -			ublk_get_iod(ubq, req->tag)->addr);
> -
>  	/*
>  	 * Task is exiting if either:
>  	 *
> @@ -746,6 +749,9 @@ static inline void __ublk_rq_task_work(struct request *req)
>  			mapped_bytes >> 9;
>  	}
>  
> +	pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
> +			__func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
> +			ublk_get_iod(ubq, req->tag)->addr);
>  	ubq_complete_io_cmd(io, UBLK_IO_RES_OK);
>  }
>  
> @@ -790,6 +796,21 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	res = ublk_setup_iod(ubq, rq);
>  	if (unlikely(res != BLK_STS_OK))
>  		return BLK_STS_IOERR;
> +	/* With recovery feature enabled, force_abort is set in
> +	 * ublk_stop_dev() before calling del_gendisk(). We have to
> +	 * abort all requeued and new rqs here to let del_gendisk()
> +	 * move on. Besides, we cannot not call io_uring_cmd_complete_in_task()
> +	 * to avoid UAF on io_uring ctx.
> +	 *
> +	 * Note: force_abort is guaranteed to be seen because it is set
> +	 * before request queue is unqiuesced.
> +	 */
> +	if (unlikely(ubq->force_abort)) {
> +		pr_devel("%s: abort rq: qid %d tag %d io_flags %x\n",
> +				__func__, ubq->q_id, rq->tag,
> +				ubq->ios[rq->tag].flags);

same with above.

> +		return BLK_STS_IOERR;
> +	}
>  
>  	blk_mq_start_request(bd->rq);
>  
> @@ -967,7 +988,7 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
>  			 */
>  			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
>  			if (rq)
> -				__ublk_fail_req(io, rq);
> +				__ublk_fail_req(ubq, io, rq);
>  		}
>  	}
>  	ublk_put_device(ub);
> @@ -983,7 +1004,10 @@ static void ublk_daemon_monitor_work(struct work_struct *work)
>  		struct ublk_queue *ubq = ublk_get_queue(ub, i);
>  
>  		if (ubq_daemon_is_dying(ubq)) {
> -			schedule_work(&ub->stop_work);
> +			if (ublk_queue_can_use_recovery(ubq))
> +				schedule_work(&ub->quiesce_work);
> +			else
> +				schedule_work(&ub->stop_work);
>  
>  			/* abort queue is for making forward progress */
>  			ublk_abort_queue(ub, ubq);
> @@ -991,12 +1015,13 @@ static void ublk_daemon_monitor_work(struct work_struct *work)
>  	}
>  
>  	/*
> -	 * We can't schedule monitor work after ublk_remove() is started.
> +	 * We can't schedule monitor work after ub's state is not UBLK_S_DEV_LIVE.
> +	 * after ublk_remove() or __ublk_quiesce_dev() is started.
>  	 *
>  	 * No need ub->mutex, monitor work are canceled after state is marked
> -	 * as DEAD, so DEAD state is observed reliably.
> +	 * as not LIVE, so new state is observed reliably.
>  	 */
> -	if (ub->dev_info.state != UBLK_S_DEV_DEAD)
> +	if (ub->dev_info.state == UBLK_S_DEV_LIVE)
>  		schedule_delayed_work(&ub->monitor_work,
>  				UBLK_DAEMON_MONITOR_PERIOD);
>  }
> @@ -1050,12 +1075,97 @@ static void ublk_cancel_dev(struct ublk_device *ub)
>  		ublk_cancel_queue(ublk_get_queue(ub, i));
>  }
>  
> -static void ublk_stop_dev(struct ublk_device *ub)
> +static bool ublk_check_inflight_rq(struct request *rq, void *data)
> +{
> +	bool *idle = data;
> +
> +	if (blk_mq_request_started(rq)) {
> +		pr_devel("%s: rq qid %d tag %d is not IDLE.\n",
> +				__func__, rq->mq_hctx->queue_num,
> +				rq->tag);

Please remove above log, otherwise it may overflow printk buffer.
Also you can observe pending requests info from blk-mq debugfs.

> +		*idle = false;
> +		return false;
> +	}
> +	return true;
> +}
> +
> +static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
> +{
> +	bool idle;
> +
> +	WARN_ON_ONCE(!blk_queue_quiesced(ub->ub_disk->queue));
> +	while (true) {
> +		idle = true;
> +		blk_mq_tagset_busy_iter(&ub->tag_set,
> +				ublk_check_inflight_rq, &idle);
> +		if (idle)
> +			break;
> +		pr_devel("%s: not all tags are idle, ub: dev_id %d\n",
> +				__func__, ub->dev_info.dev_id);

The above logging isn't useful, we can conclude easily that
the wait isn't done by checking stack trace or debugfs log.

> +		msleep(UBLK_REQUEUE_DELAY_MS);
> +	}
> +}
> +
> +static void __ublk_quiesce_dev(struct ublk_device *ub)
>  {
> +	pr_devel("%s: quiesce ub: dev_id %d state %s\n",
> +			__func__, ub->dev_info.dev_id,
> +			ub->dev_info.state == UBLK_S_DEV_LIVE ?
> +			"LIVE" : "QUIESCED");
> +	blk_mq_quiesce_queue(ub->ub_disk->queue);
> +	ublk_wait_tagset_rqs_idle(ub);
> +	pr_devel("%s: all tags are idle, ub: dev_id %d\n",
> +			__func__, ub->dev_info.dev_id);

The above logging can be removed too.

> +	ublk_cancel_dev(ub);
> +	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
> +}
> +
> +static void ublk_quiesce_work_fn(struct work_struct *work)
> +{
> +	struct ublk_device *ub =
> +		container_of(work, struct ublk_device, quiesce_work);
> +
>  	mutex_lock(&ub->mutex);
>  	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
>  		goto unlock;
> +	pr_devel("%s: start __ublk_quiesce_dev: dev_id %d\n",
> +			__func__, ub->dev_info.dev_id);

The above logging isn't needed, since you do add one
at the beginning of __ublk_quiesce_dev().


Thanks,
Ming

