Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F3D5BDAA9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiITDFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiITDE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F326F17A98
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 20:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663643096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zthd1v7mg0AxGd19SL7xBVj6NZ5pDyKndukMP8N3y94=;
        b=d/0EI31S9syJ+wYtiWXoZ1WXInfhhsTTnN5ETQh9kveh3D3bUejnSX9SLEIlcsDAY+di0U
        lqoSmLn4Zd8P49nsEFdSYTqKbEUuY2uBt7nO7kvfXLjFsp/1MXemQYCt2aqZIjcKX4pCIy
        KOzvchyfjtOEjKA2nLqirATzP+Oq4IU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-8L36tjWjOiqUDIxfTqcp6w-1; Mon, 19 Sep 2022 23:04:50 -0400
X-MC-Unique: 8L36tjWjOiqUDIxfTqcp6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E1188027F5;
        Tue, 20 Sep 2022 03:04:50 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DBAA40C6EC2;
        Tue, 20 Sep 2022 03:04:44 +0000 (UTC)
Date:   Tue, 20 Sep 2022 11:04:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH V3 5/7] ublk_drv: consider recovery feature in aborting
 mechanism
Message-ID: <Yyktx/xz0qTNxnT4@T590>
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
 <20220913041707.197334-6-ZiyangZhang@linux.alibaba.com>
 <Yyg3KLfQaxbS1miq@T590>
 <9a682fac-f022-1f4d-5c2c-e1f0a84746d8@linux.alibaba.com>
 <YyhhnbrHTJpW4Xcm@T590>
 <dbc78e92-ede7-fc63-1bee-83794bf1e33b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbc78e92-ede7-fc63-1bee-83794bf1e33b@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:49:33AM +0800, Ziyang Zhang wrote:
> On 2022/9/19 20:33, Ming Lei wrote:
> >>>> +
> >>>> +static void ublk_quiesce_queue(struct ublk_device *ub,
> >>>> +		struct ublk_queue *ubq)
> >>>> +{
> >>>> +	int i;
> >>>> +
> >>>> +	for (i = 0; i < ubq->q_depth; i++) {
> >>>> +		struct ublk_io *io = &ubq->ios[i];
> >>>> +
> >>>> +		if (!(io->flags & UBLK_IO_FLAG_ACTIVE)) {
> >>>> +			struct request *rq = blk_mq_tag_to_rq(
> >>>> +					ub->tag_set.tags[ubq->q_id], i);
> >>>> +
> >>>> +			WARN_ON_ONCE(!rq);
> >>>> +			pr_devel("%s: %s rq: qid %d tag %d io_flags %x\n", __func__,
> >>>> +					ublk_queue_can_use_recovery_reissue(ubq) ?
> >>>> +					"requeue" : "abort",
> >>>> +					ubq->q_id, i, io->flags);
> >>>> +			if (ublk_queue_can_use_recovery_reissue(ubq))
> >>>> +				blk_mq_requeue_request(rq, false);
> >>>
> >>> This way is too violent.
> >>>
> >>> There may be just one queue dying, but you requeue all requests
> >>> from any queue. I'd suggest to take the approach in ublk_daemon_monitor_work(),
> >>> such as, just requeuing requests in dying queue.
> >>
> >> If we want to start a new process after a crash for USER_RECOVERY, all old ubq_daemons
> >> must exit and rqs of all queues have to be requeued/aborted. We cannot let live
> >> ubq_daemons run any more because they do not belong to the new process.
> > 
> > IMO, the old process really can exist, and recently even I got such
> > requirement for switching queue from one thread to another.
> 
> For now, only one process can open /dev/ublkcX, so a new process is necessary now.
> 
> If you think "per ubq_daemon" recovery is reasonable, I can do that in the future
> if multiple processes is supported. But I really suggest that we can keep current
> design as the first step which assumes all ubq_daemons are exited and a new process
> is started, and that really meets our requirement.
> 
> BTW, START_USER_RECOVERY has to be reconsidered because we may need to pass a ubq_id
> with it.
> 
> > 
> > What we should do is to get all inflight requests done, and cancel all io
> > commands, no matter if the ubq pthread is dead or live.
> > 
> >>
> >> BTW, I really wonder why there could be just one queue dying? All queues must be dying
> >> shortly after any ubq_daemon is dying since they are all pthreads in the same process.
> > 
> > You can't assume it is always so. Maybe one pthread is dead first, and
> > others are dying later, maybe just one is dead.
> 
> Yes, I know there may be only one pthread is dead while others keep running, but now
> ublk_drv only support one process opening the same /dev/ublkcX, so other pthreads
> must dead(no matter they are aborted by signal or themselves) later.
> 
> > 
> > If one queue's pthread is live, you may get trouble by simply requeuing
> > the request, that is why I suggest to re-use the logic of
> > ublk_daemon_monitor_work/ublk_abort_queue().
> 
> Actually, if any ubq_daemon is live, no rqs are requeued, please see the check in
> ublk_quiesce_dev(). It always makes sure that ALL ubq_daemons are dying, then it
> starts quiesce jobs.

OK, looks I miss this point, but you should have quiesced queue at the
beginning of ublk_quiesce_dev(), then the transition period can be kept
as short as possible. Otherwise, if one queue pthread isn't dying, the
device can be kept in this part-working state forever.

> 
> > 
> > For stopping device, request queue is frozen in del_gendisk() and all
> > in-flight requests are drained, and monitor work provides such
> > guarantee.
> > 
> > For user recovery, monitor work should help you too by aborting one
> > queue if it is dying until all requests are drained.
> 
> Monitor work can schedule quiesce_work if it finds a dying ubq_daemon.
> Then quiesce_work calls ublk_quiesce_dev(). I do this because ublk_quiesce_dev()
> has to wait all inflight rqs with ACTIVE set being requeued.
> 
> > 
> >>
> >>>
> >>> That said you still can re-use the logic in ublk_abort_queue()/ublk_daemon_monitor_work()
> >>> for making progress, just changing aborting request with requeue in
> >>> ublk_abort_queue().
> >>
> >> I get your point, but it may be hard to reuse the logic in ublk_daemon_monitor_work()
> >> because:
> >> (1) we have to quiesce request queue in ublk_quiesce_dev(). This has to be done with
> >>     ub_mutex.
> >> (2) ublk_quiesce_dev() cannot be run after rqs are requeued/aborted.

Follows the delta patch against patch 5 for showing the idea:


diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4409a130d0b6..60c5786c4711 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -656,7 +656,8 @@ static void ublk_complete_rq(struct request *req)
  * Also aborting may not be started yet, keep in mind that one failed
  * request may be issued by block layer again.
  */
-static void __ublk_fail_req(struct ublk_io *io, struct request *req)
+static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
+		struct request *req)
 {
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
 
@@ -667,7 +668,10 @@ static void __ublk_fail_req(struct ublk_io *io, struct request *req)
 				req->tag,
 				io->flags);
 		io->flags |= UBLK_IO_FLAG_ABORTED;
-		blk_mq_end_request(req, BLK_STS_IOERR);
+		if (ublk_queue_can_use_recovery_reissue(ubq))
+			blk_mq_requeue_request(req, false);
+		else
+			blk_mq_end_request(req, BLK_STS_IOERR);
 	}
 }
 
@@ -1018,7 +1022,7 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 			 */
 			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
 			if (rq)
-				__ublk_fail_req(io, rq);
+				__ublk_fail_req(ubq, io, rq);
 		}
 	}
 	ublk_put_device(ub);
@@ -1026,12 +1030,10 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 
 static bool ublk_check_inflight_rq(struct request *rq, void *data)
 {
-	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
-	struct ublk_io *io = &ubq->ios[rq->tag];
-	bool *busy = data;
+	bool *idle = data;
 
-	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
-		*busy = true;
+	if (blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT) {
+		*idle = false;
 		return false;
 	}
 	return true;
@@ -1039,16 +1041,15 @@ static bool ublk_check_inflight_rq(struct request *rq, void *data)
 
 static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
 {
-	bool busy = false;
+	bool idle = true;
 
 	WARN_ON_ONCE(!blk_queue_quiesced(ub->ub_disk->queue));
 	while (true) {
 		blk_mq_tagset_busy_iter(&ub->tag_set,
-				ublk_check_inflight_rq, &busy);
-		if (busy)
-			msleep(UBLK_REQUEUE_DELAY_MS);
-		else
+				ublk_check_inflight_rq, &idle);
+		if (idle)
 			break;
+		msleep(UBLK_REQUEUE_DELAY_MS);
 	}
 }
 
@@ -1069,10 +1070,7 @@ static void ublk_quiesce_queue(struct ublk_device *ub,
 					ublk_queue_can_use_recovery_reissue(ubq) ?
 					"requeue" : "abort",
 					ubq->q_id, i, io->flags);
-			if (ublk_queue_can_use_recovery_reissue(ubq))
-				blk_mq_requeue_request(rq, false);
-			else
-				__ublk_fail_req(io, rq);
+			__ublk_fail_req(ubq, io, rq);
 		} else {
 			pr_devel("%s: done old cmd: qid %d tag %d\n",
 					__func__, ubq->q_id, i);
@@ -1092,12 +1090,6 @@ static void ublk_quiesce_dev(struct ublk_device *ub)
 	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
 		goto unlock;
 
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-		struct ublk_queue *ubq = ublk_get_queue(ub, i);
-
-		if (!ubq_daemon_is_dying(ubq))
-			goto unlock;
-	}
 	blk_mq_quiesce_queue(ub->ub_disk->queue);
 	ublk_wait_tagset_rqs_idle(ub);
 	pr_devel("%s: quiesce ub: dev_id %d\n",
@@ -1129,14 +1121,13 @@ static void ublk_daemon_monitor_work(struct work_struct *work)
 		struct ublk_queue *ubq = ublk_get_queue(ub, i);
 
 		if (ubq_daemon_is_dying(ubq)) {
-			if (ublk_queue_can_use_recovery(ubq)) {
+			if (ublk_queue_can_use_recovery(ubq))
 				schedule_work(&ub->quiesce_work);
-			} else {
+			else
 				schedule_work(&ub->stop_work);
 
-				/* abort queue is for making forward progress */
-				ublk_abort_queue(ub, ubq);
-			}
+			/* abort queue is for making forward progress */
+			ublk_abort_queue(ub, ubq);
 		}
 	}
 




Thanks,
Ming

