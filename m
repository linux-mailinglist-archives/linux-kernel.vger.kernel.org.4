Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C5C5BCBDF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiISMeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiISMdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA86E2DABC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663590830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z1BUi6Zq90RpHqDF/XNvlXbXJalSrQUfR4/O2e4291s=;
        b=IpbbrGki+4QwfylQIzlCw56UhHBuNTokak3ec8VMMAtVaosCbuRF9F8aJZHp/8WyYiqVrR
        PGwfKHIho5LzF/QBUUoQB1jOujDR4S38TYMnua1yzBHuEXdDLHBulHgn2WVKmb+t6kDeA2
        eSbMBzyZaKK+nU6C3WAD3j4c9aWyBVs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-a3wcJUJdP62QpjQnEmWPyQ-1; Mon, 19 Sep 2022 08:33:45 -0400
X-MC-Unique: a3wcJUJdP62QpjQnEmWPyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 767D43C14852;
        Mon, 19 Sep 2022 12:33:44 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DE19208BDC0;
        Mon, 19 Sep 2022 12:33:38 +0000 (UTC)
Date:   Mon, 19 Sep 2022 20:33:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, ming.lei@redhat.com
Subject: Re: [PATCH V3 5/7] ublk_drv: consider recovery feature in aborting
 mechanism
Message-ID: <YyhhnbrHTJpW4Xcm@T590>
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
 <20220913041707.197334-6-ZiyangZhang@linux.alibaba.com>
 <Yyg3KLfQaxbS1miq@T590>
 <9a682fac-f022-1f4d-5c2c-e1f0a84746d8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a682fac-f022-1f4d-5c2c-e1f0a84746d8@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 05:55:05PM +0800, Ziyang Zhang wrote:
> On 2022/9/19 17:32, Ming Lei wrote:
> > On Tue, Sep 13, 2022 at 12:17:05PM +0800, ZiyangZhang wrote:
> >> With USER_RECOVERY feature enabled, the monitor_work schedules
> >> quiesce_work after finding a dying ubq_daemon. The quiesce_work's job
> >> is to:
> >> (1) quiesce request queue.
> >> (2) check if there is any INFLIGHT rq with UBLK_IO_FLAG_ACTIVE unset.
> >>     If so, we retry until all these rqs are requeued by ublk_queue_rq()
> >>     and task_work and become IDLE.
> > 
> > These requests should be being handled by task work or the io_uring
> > fallback wq, and suggest to add the words here.
> 
> Will do so.
> 
> > 
> >> (3) requeue/abort inflight rqs issued to the crash ubq_daemon before. If
> >>     UBLK_F_USER_RECOVERY_REISSUE is set, rq is requeued; or it is
> >>     aborted.
> >> (4) complete all ioucmds by calling io_uring_cmd_done(). We are safe to
> >>     do so because no ioucmd can be referenced now.
> >> (5) set ub's state to UBLK_S_DEV_QUIESCED, which means we are ready for
> >>     recovery. This state is exposed to userspace by GET_DEV_INFO.
> >>
> >> The driver can always handle STOP_DEV and cleanup everything no matter
> >> ub's state is LIVE or QUIESCED. After ub's state is UBLK_S_DEV_QUIESCED,
> >> user can recover with new process by sending START_USER_RECOVERY.
> >>
> >> Note: we do not change the default behavior with reocvery feature
> >> disabled. monitor_work still schedules stop_work and abort inflight
> >> rqs. Finally ublk_device is released.
> > 
> > This version looks much better than before.
> 
> Thanks :)
> 
> > 
> >>
> >> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> >> ---
> >>  drivers/block/ublk_drv.c | 168 +++++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 161 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> >> index b067f33a1913..4409a130d0b6 100644
> >> --- a/drivers/block/ublk_drv.c
> >> +++ b/drivers/block/ublk_drv.c
> >> @@ -121,7 +121,7 @@ struct ublk_queue {
> >>  
> >>  	unsigned long io_addr;	/* mapped vm address */
> >>  	unsigned int max_io_sz;
> >> -	bool abort_work_pending;
> >> +	bool force_abort;
> >>  	unsigned short nr_io_ready;	/* how many ios setup */
> >>  	struct ublk_device *dev;
> >>  	struct ublk_io ios[0];
> >> @@ -163,6 +163,7 @@ struct ublk_device {
> >>  	 * monitor each queue's daemon periodically
> >>  	 */
> >>  	struct delayed_work	monitor_work;
> >> +	struct work_struct	quiesce_work;
> >>  	struct work_struct	stop_work;
> >>  };
> >>  
> >> @@ -660,6 +661,11 @@ static void __ublk_fail_req(struct ublk_io *io, struct request *req)
> >>  	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
> >>  
> >>  	if (!(io->flags & UBLK_IO_FLAG_ABORTED)) {
> >> +		pr_devel("%s: abort rq: qid %d tag %d io_flags %x\n",
> >> +				__func__,
> >> +				((struct ublk_queue *)req->mq_hctx->driver_data)->q_id,
> > 
> > req->mq_hctx->queue_num is cleaner.
> 
> Ok.
> 
> > 
> >> +				req->tag,
> >> +				io->flags);
> >>  		io->flags |= UBLK_IO_FLAG_ABORTED;
> >>  		blk_mq_end_request(req, BLK_STS_IOERR);
> >>  	}
> >> @@ -820,6 +826,21 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> >>  	res = ublk_setup_iod(ubq, rq);
> >>  	if (unlikely(res != BLK_STS_OK))
> >>  		return BLK_STS_IOERR;
> >> +    /* With recovery feature enabled, force_abort is set in
> >> +     * ublk_stop_dev() before calling del_gendisk() if ub's state
> >> +     * is QUIESCED. We have to abort all requeued and new rqs here
> >> +     * to let del_gendisk() move on. Besides, we do not call
> >> +     * io_uring_cmd_complete_in_task() to avoid UAF on io_uring ctx.
> >> +     *
> >> +     * Note: force_abort is guaranteed to be seen because it is set
> >> +     * before request queue is unqiuesced.
> >> +     */
> >> +	if (unlikely(ubq->force_abort)) {
> >> +		pr_devel("%s: abort rq: qid %d tag %d io_flags %x\n",
> >> +				__func__, ubq->q_id, rq->tag,
> >> +				ubq->ios[rq->tag].flags);
> >> +		return BLK_STS_IOERR;
> >> +	}
> >>  
> >>  	blk_mq_start_request(bd->rq);
> >>  
> >> @@ -1003,6 +1024,101 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
> >>  	ublk_put_device(ub);
> >>  }
> >>  
> >> +static bool ublk_check_inflight_rq(struct request *rq, void *data)
> >> +{
> >> +	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> >> +	struct ublk_io *io = &ubq->ios[rq->tag];
> >> +	bool *busy = data;
> >> +
> >> +	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
> >> +		*busy = true;
> >> +		return false;
> >> +	}
> >> +	return true;
> >> +}
> >> +
> >> +static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
> >> +{
> >> +	bool busy = false;
> >> +
> >> +	WARN_ON_ONCE(!blk_queue_quiesced(ub->ub_disk->queue));
> >> +	while (true) {
> >> +		blk_mq_tagset_busy_iter(&ub->tag_set,
> >> +				ublk_check_inflight_rq, &busy);
> >> +		if (busy)
> >> +			msleep(UBLK_REQUEUE_DELAY_MS);
> >> +		else
> >> +			break;
> >> +	}
> >> +}
> >> +
> >> +static void ublk_quiesce_queue(struct ublk_device *ub,
> >> +		struct ublk_queue *ubq)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i = 0; i < ubq->q_depth; i++) {
> >> +		struct ublk_io *io = &ubq->ios[i];
> >> +
> >> +		if (!(io->flags & UBLK_IO_FLAG_ACTIVE)) {
> >> +			struct request *rq = blk_mq_tag_to_rq(
> >> +					ub->tag_set.tags[ubq->q_id], i);
> >> +
> >> +			WARN_ON_ONCE(!rq);
> >> +			pr_devel("%s: %s rq: qid %d tag %d io_flags %x\n", __func__,
> >> +					ublk_queue_can_use_recovery_reissue(ubq) ?
> >> +					"requeue" : "abort",
> >> +					ubq->q_id, i, io->flags);
> >> +			if (ublk_queue_can_use_recovery_reissue(ubq))
> >> +				blk_mq_requeue_request(rq, false);
> > 
> > This way is too violent.
> > 
> > There may be just one queue dying, but you requeue all requests
> > from any queue. I'd suggest to take the approach in ublk_daemon_monitor_work(),
> > such as, just requeuing requests in dying queue.
> 
> If we want to start a new process after a crash for USER_RECOVERY, all old ubq_daemons
> must exit and rqs of all queues have to be requeued/aborted. We cannot let live
> ubq_daemons run any more because they do not belong to the new process.

IMO, the old process really can exist, and recently even I got such
requirement for switching queue from one thread to another.

What we should do is to get all inflight requests done, and cancel all io
commands, no matter if the ubq pthread is dead or live.

> 
> BTW, I really wonder why there could be just one queue dying? All queues must be dying
> shortly after any ubq_daemon is dying since they are all pthreads in the same process.

You can't assume it is always so. Maybe one pthread is dead first, and
others are dying later, maybe just one is dead.

If one queue's pthread is live, you may get trouble by simply requeuing
the request, that is why I suggest to re-use the logic of
ublk_daemon_monitor_work/ublk_abort_queue().

For stopping device, request queue is frozen in del_gendisk() and all
in-flight requests are drained, and monitor work provides such
guarantee.

For user recovery, monitor work should help you too by aborting one
queue if it is dying until all requests are drained.

> 
> > 
> > That said you still can re-use the logic in ublk_abort_queue()/ublk_daemon_monitor_work()
> > for making progress, just changing aborting request with requeue in
> > ublk_abort_queue().
> 
> I get your point, but it may be hard to reuse the logic in ublk_daemon_monitor_work()
> because:
> (1) we have to quiesce request queue in ublk_quiesce_dev(). This has to be done with
>     ub_mutex.
> (2) ublk_quiesce_dev() cannot be run after rqs are requeued/aborted.

I don't get your point, the request queue needs to be quiesced once, then
either inflight requests are requeued if the queue is dying, or completed by
the queue's pthread if it is live. As you mentioned, in reality, most times,
all pthreads will be killed, but timing can be different, and I think
you can not requeue one request if the ubq pthread isn't dying.

 

Thanks, 
Ming

