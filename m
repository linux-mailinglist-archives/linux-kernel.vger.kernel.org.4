Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543CF618452
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiKCQ0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiKCQ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:26:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E641A83D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:26:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 21so3876074edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuQet8vAfXYjtJovtWvfi564eTZoov1XJZh14ZhEs4I=;
        b=wsi35bkOjtoE5jiCzQyyFwczZBvTI/zY6jsb8O0EOBtHjIwPAu60QjE/JQt7LNB2pq
         3IjSfTuGBNNIHCdwXZv9NckH7pS4VEMLwyki11hMRpI/AVQVFuGasfm1d+CYkzCVVNo1
         NCYSstvyL3pqKZg+gW2KOc+YwGAprgwFjyE8hlIzdVd1BsX5bEHaLC0gq3ywbai7utLW
         HmdfCUIDuehsmpI9bAhq6sqAkRyR8NsCZ212uquz8u/BuNDoCiOCLpFXrz65BnrdhESn
         KnEnGPR6Fx3lzYahS+om6j/RGcdytZrvUfHAx+pX0v4zYUXP3/AUVJymRe/CER0q54h5
         6wLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuQet8vAfXYjtJovtWvfi564eTZoov1XJZh14ZhEs4I=;
        b=dMqNHyzWSr9FTicx94FTtd2LqmKmlJrY8ytS1m7awH3JARATz2OI26Ga3FdJoXptLs
         iUv+A08S1z8Fv+M5h+RKaFSp3jHzEaELaorsb74l0mnvnB4AazAfLqevp2By1kUCvChR
         xY2A6JMR/64007nz+XlCR6Tc5utWgNshmw0ug7JOG13U1mW5exrMQJ3whDtfYBXRhOLv
         GStO1L68dBUP0n8OivNI7FW1qqeUvXgvgwDALsYJV5XhdVPAUJr8C+PM/COs/pUyHk57
         YlyMsKz58I2Z9iSFoDH+A71V8kCcmWOB86TNwONDvI9ljnZA7lATKG4QnFZhYJf/KBgR
         lubw==
X-Gm-Message-State: ACrzQf0LcnaL2aaIqPWNnz8bXMqKu2F0QarSg/rkOtalYY+NmBKpBJ1C
        dc+7qsn98AzBW0C93l2D2HkZ8A==
X-Google-Smtp-Source: AMsMyM7l6bbVNT5FoiQHX+i/YpJcGemSo+fk1p8kQCbAUWR5eEvSYN0LaxRjvO7MXZziNIHeyafC8w==
X-Received: by 2002:a50:eb83:0:b0:462:a2ac:8623 with SMTP id y3-20020a50eb83000000b00462a2ac8623mr31132768edr.360.1667492797225;
        Thu, 03 Nov 2022 09:26:37 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id kx9-20020a170907774900b0078116c361d9sm702507ejc.10.2022.11.03.09.26.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2022 09:26:36 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Paolo Valente <paolo.valente@linaro.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
Subject: [PATCH V6 1/8] block, bfq: split sync bfq_queues on a per-actuator basis
Date:   Thu,  3 Nov 2022 17:26:16 +0100
Message-Id: <20221103162623.10286-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221103162623.10286-1-paolo.valente@linaro.org>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Single-LUN multi-actuator SCSI drives, as well as all multi-actuator
SATA drives appear as a single device to the I/O subsystem [1].  Yet
they address commands to different actuators internally, as a function
of Logical Block Addressing (LBAs). A given sector is reachable by
only one of the actuators. For example, Seagate’s Serial Advanced
Technology Attachment (SATA) version contains two actuators and maps
the lower half of the SATA LBA space to the lower actuator and the
upper half to the upper actuator.

Evidently, to fully utilize actuators, no actuator must be left idle
or underutilized while there is pending I/O for it. The block layer
must somehow control the load of each actuator individually. This
commit lays the ground for allowing BFQ to provide such a per-actuator
control.

BFQ associates an I/O-request sync bfq_queue with each process doing
synchronous I/O, or with a group of processes, in case of queue
merging. Then BFQ serves one bfq_queue at a time. While in service, a
bfq_queue is emptied in request-position order. Yet the same process,
or group of processes, may generate I/O for different actuators. In
this case, different streams of I/O (each for a different actuator)
get all inserted into the same sync bfq_queue. So there is basically
no individual control on when each stream is served, i.e., on when the
I/O requests of the stream are picked from the bfq_queue and
dispatched to the drive.

This commit enables BFQ to control the service of each actuator
individually for synchronous I/O, by simply splitting each sync
bfq_queue into N queues, one for each actuator. In other words, a sync
bfq_queue is now associated to a pair (process, actuator). As a
consequence of this split, the per-queue proportional-share policy
implemented by BFQ will guarantee that the sync I/O generated for each
actuator, by each process, receives its fair share of service.

This is just a preparatory patch. If the I/O of the same process
happens to be sent to different queues, then each of these queues may
undergo queue merging. To handle this event, the bfq_io_cq data
structure must be properly extended. In addition, stable merging must
be disabled to avoid loss of control on individual actuators. Finally,
also async queues must be split. These issues are described in detail
and addressed in next commits. As for this commit, although multiple
per-process bfq_queues are provided, the I/O of each process or group
of processes is still sent to only one queue, regardless of the
actuator the I/O is for. The forwarding to distinct bfq_queues will be
enabled after addressing the above issues.

[1] https://www.linaro.org/blog/budget-fair-queueing-bfq-linux-io-scheduler-optimizations-for-multi-actuator-sata-hard-drives/

Signed-off-by: Gabriele Felici <felicigb@gmail.com>
Signed-off-by: Carmine Zaccagnino <carmine@carminezacc.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c  |  95 ++++++++++++++++------------
 block/bfq-iosched.c | 151 +++++++++++++++++++++++++++++---------------
 block/bfq-iosched.h |  51 ++++++++++++---
 3 files changed, 194 insertions(+), 103 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 144bca006463..d243c429d9c0 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -700,6 +700,48 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	bfq_put_queue(bfqq);
 }
 
+static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
+			       struct bfq_queue *sync_bfqq,
+			       struct bfq_io_cq *bic,
+			       struct bfq_group *bfqg,
+			       unsigned int act_idx)
+{
+	if (!sync_bfqq->new_bfqq && !bfq_bfqq_coop(sync_bfqq)) {
+		/* We are the only user of this bfqq, just move it */
+		if (sync_bfqq->entity.sched_data != &bfqg->sched_data)
+			bfq_bfqq_move(bfqd, sync_bfqq, bfqg);
+	} else {
+		struct bfq_queue *bfqq;
+
+		/*
+		 * The queue was merged to a different queue. Check
+		 * that the merge chain still belongs to the same
+		 * cgroup.
+		 */
+		for (bfqq = sync_bfqq; bfqq; bfqq = bfqq->new_bfqq)
+			if (bfqq->entity.sched_data !=
+			    &bfqg->sched_data)
+				break;
+		if (bfqq) {
+			/*
+			 * Some queue changed cgroup so the merge is
+			 * not valid anymore. We cannot easily just
+			 * cancel the merge (by clearing new_bfqq) as
+			 * there may be other processes using this
+			 * queue and holding refs to all queues below
+			 * sync_bfqq->new_bfqq. Similarly if the merge
+			 * already happened, we need to detach from
+			 * bfqq now so that we cannot merge bio to a
+			 * request from the old cgroup.
+			 */
+			bfq_put_cooperator(sync_bfqq);
+			bfq_release_process_ref(bfqd, sync_bfqq);
+			bic_set_bfqq(bic, NULL, 1, act_idx);
+		}
+	}
+}
+
+
 /**
  * __bfq_bic_change_cgroup - move @bic to @bfqg.
  * @bfqd: the queue descriptor.
@@ -714,53 +756,24 @@ static void *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
 				     struct bfq_io_cq *bic,
 				     struct bfq_group *bfqg)
 {
-	struct bfq_queue *async_bfqq = bic_to_bfqq(bic, 0);
-	struct bfq_queue *sync_bfqq = bic_to_bfqq(bic, 1);
 	struct bfq_entity *entity;
+	unsigned int act_idx;
 
-	if (async_bfqq) {
-		entity = &async_bfqq->entity;
-
-		if (entity->sched_data != &bfqg->sched_data) {
-			bic_set_bfqq(bic, NULL, 0);
-			bfq_release_process_ref(bfqd, async_bfqq);
-		}
-	}
+	for (act_idx = 0; act_idx < bfqd->num_actuators; act_idx++) {
+		struct bfq_queue *async_bfqq = bic_to_bfqq(bic, 0, act_idx);
+		struct bfq_queue *sync_bfqq = bic_to_bfqq(bic, 1, act_idx);
 
-	if (sync_bfqq) {
-		if (!sync_bfqq->new_bfqq && !bfq_bfqq_coop(sync_bfqq)) {
-			/* We are the only user of this bfqq, just move it */
-			if (sync_bfqq->entity.sched_data != &bfqg->sched_data)
-				bfq_bfqq_move(bfqd, sync_bfqq, bfqg);
-		} else {
-			struct bfq_queue *bfqq;
+		if (async_bfqq) {
+			entity = &async_bfqq->entity;
 
-			/*
-			 * The queue was merged to a different queue. Check
-			 * that the merge chain still belongs to the same
-			 * cgroup.
-			 */
-			for (bfqq = sync_bfqq; bfqq; bfqq = bfqq->new_bfqq)
-				if (bfqq->entity.sched_data !=
-				    &bfqg->sched_data)
-					break;
-			if (bfqq) {
-				/*
-				 * Some queue changed cgroup so the merge is
-				 * not valid anymore. We cannot easily just
-				 * cancel the merge (by clearing new_bfqq) as
-				 * there may be other processes using this
-				 * queue and holding refs to all queues below
-				 * sync_bfqq->new_bfqq. Similarly if the merge
-				 * already happened, we need to detach from
-				 * bfqq now so that we cannot merge bio to a
-				 * request from the old cgroup.
-				 */
-				bfq_put_cooperator(sync_bfqq);
-				bfq_release_process_ref(bfqd, sync_bfqq);
-				bic_set_bfqq(bic, NULL, 1);
+			if (entity->sched_data != &bfqg->sched_data) {
+				bic_set_bfqq(bic, NULL, 0, act_idx);
+				bfq_release_process_ref(bfqd, async_bfqq);
 			}
 		}
+
+		if (sync_bfqq)
+			bfq_sync_bfqq_move(bfqd, sync_bfqq, bic, bfqg, act_idx);
 	}
 
 	return bfqg;
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7ea427817f7f..5c69394bbb65 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -377,14 +377,19 @@ static const unsigned long bfq_late_stable_merging = 600;
 #define RQ_BIC(rq)		((struct bfq_io_cq *)((rq)->elv.priv[0]))
 #define RQ_BFQQ(rq)		((rq)->elv.priv[1])
 
-struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync)
+struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic,
+			      bool is_sync,
+			      unsigned int actuator_idx)
 {
-	return bic->bfqq[is_sync];
+	return bic->bfqq[is_sync][actuator_idx];
 }
 
 static void bfq_put_stable_ref(struct bfq_queue *bfqq);
 
-void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync)
+void bic_set_bfqq(struct bfq_io_cq *bic,
+		  struct bfq_queue *bfqq,
+		  bool is_sync,
+		  unsigned int actuator_idx)
 {
 	/*
 	 * If bfqq != NULL, then a non-stable queue merge between
@@ -399,7 +404,7 @@ void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync)
 	 * we cancel the stable merge if
 	 * bic->stable_merge_bfqq == bfqq.
 	 */
-	bic->bfqq[is_sync] = bfqq;
+	bic->bfqq[is_sync][actuator_idx] = bfqq;
 
 	if (bfqq && bic->stable_merge_bfqq == bfqq) {
 		/*
@@ -672,9 +677,9 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 {
 	struct bfq_data *bfqd = data->q->elevator->elevator_data;
 	struct bfq_io_cq *bic = bfq_bic_lookup(data->q);
-	struct bfq_queue *bfqq = bic ? bic_to_bfqq(bic, op_is_sync(opf)) : NULL;
 	int depth;
 	unsigned limit = data->q->nr_requests;
+	unsigned int act_idx;
 
 	/* Sync reads have full depth available */
 	if (op_is_sync(opf) && !op_is_write(opf)) {
@@ -684,14 +689,21 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 		limit = (limit * depth) >> bfqd->full_depth_shift;
 	}
 
-	/*
-	 * Does queue (or any parent entity) exceed number of requests that
-	 * should be available to it? Heavily limit depth so that it cannot
-	 * consume more available requests and thus starve other entities.
-	 */
-	if (bfqq && bfqq_request_over_limit(bfqq, limit))
-		depth = 1;
+	for (act_idx = 0; act_idx < bfqd->num_actuators; act_idx++) {
+		struct bfq_queue *bfqq =
+			bic ? bic_to_bfqq(bic, op_is_sync(opf), act_idx) : NULL;
 
+		/*
+		 * Does queue (or any parent entity) exceed number of
+		 * requests that should be available to it? Heavily
+		 * limit depth so that it cannot consume more
+		 * available requests and thus starve other entities.
+		 */
+		if (bfqq && bfqq_request_over_limit(bfqq, limit)) {
+			depth = 1;
+			break;
+		}
+	}
 	bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
 		__func__, bfqd->wr_busy_queues, op_is_sync(opf), depth);
 	if (depth)
@@ -2142,7 +2154,7 @@ static void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	 * We reset waker detection logic also if too much time has passed
  	 * since the first detection. If wakeups are rare, pointless idling
 	 * doesn't hurt throughput that much. The condition below makes sure
-	 * we do not uselessly idle blocking waker in more than 1/64 cases. 
+	 * we do not uselessly idle blocking waker in more than 1/64 cases.
 	 */
 	if (bfqd->last_completed_rq_bfqq !=
 	    bfqq->tentative_waker_bfqq ||
@@ -2454,6 +2466,16 @@ static void bfq_remove_request(struct request_queue *q,
 
 }
 
+/* get the index of the actuator that will serve bio */
+static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct bio *bio)
+{
+	/*
+	 * Multi-actuator support not complete yet, so always return 0
+	 * for the moment.
+	 */
+	return 0;
+}
+
 static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
@@ -2478,7 +2500,8 @@ static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 		 */
 		bfq_bic_update_cgroup(bic, bio);
 
-		bfqd->bio_bfqq = bic_to_bfqq(bic, op_is_sync(bio->bi_opf));
+		bfqd->bio_bfqq = bic_to_bfqq(bic, op_is_sync(bio->bi_opf),
+					     bfq_actuator_index(bfqd, bio));
 	} else {
 		bfqd->bio_bfqq = NULL;
 	}
@@ -3174,7 +3197,7 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 	/*
 	 * Merge queues (that is, let bic redirect its requests to new_bfqq)
 	 */
-	bic_set_bfqq(bic, new_bfqq, 1);
+	bic_set_bfqq(bic, new_bfqq, 1, bfqq->actuator_idx);
 	bfq_mark_bfqq_coop(new_bfqq);
 	/*
 	 * new_bfqq now belongs to at least two bics (it is a shared queue):
@@ -4808,11 +4831,12 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 	 */
 	if (bfq_bfqq_wait_request(bfqq) ||
 	    (bfqq->dispatched != 0 && bfq_better_to_idle(bfqq))) {
+		unsigned int act_idx = bfqq->actuator_idx;
 		struct bfq_queue *async_bfqq =
-			bfqq->bic && bfqq->bic->bfqq[0] &&
-			bfq_bfqq_busy(bfqq->bic->bfqq[0]) &&
-			bfqq->bic->bfqq[0]->next_rq ?
-			bfqq->bic->bfqq[0] : NULL;
+			bfqq->bic && bfqq->bic->bfqq[0][act_idx] &&
+			bfq_bfqq_busy(bfqq->bic->bfqq[0][act_idx]) &&
+			bfqq->bic->bfqq[0][act_idx]->next_rq ?
+			bfqq->bic->bfqq[0][act_idx] : NULL;
 		struct bfq_queue *blocked_bfqq =
 			!hlist_empty(&bfqq->woken_list) ?
 			container_of(bfqq->woken_list.first,
@@ -4904,7 +4928,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 		    icq_to_bic(async_bfqq->next_rq->elv.icq) == bfqq->bic &&
 		    bfq_serv_to_charge(async_bfqq->next_rq, async_bfqq) <=
 		    bfq_bfqq_budget_left(async_bfqq))
-			bfqq = bfqq->bic->bfqq[0];
+			bfqq = bfqq->bic->bfqq[0][act_idx];
 		else if (bfqq->waker_bfqq &&
 			   bfq_bfqq_busy(bfqq->waker_bfqq) &&
 			   bfqq->waker_bfqq->next_rq &&
@@ -5365,49 +5389,59 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfq_release_process_ref(bfqd, bfqq);
 }
 
-static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
+static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic,
+			      bool is_sync,
+			      unsigned int actuator_idx)
 {
-	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync);
+	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync, actuator_idx);
 	struct bfq_data *bfqd;
 
 	if (bfqq)
 		bfqd = bfqq->bfqd; /* NULL if scheduler already exited */
 
 	if (bfqq && bfqd) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&bfqd->lock, flags);
 		bfqq->bic = NULL;
 		bfq_exit_bfqq(bfqd, bfqq);
-		bic_set_bfqq(bic, NULL, is_sync);
-		spin_unlock_irqrestore(&bfqd->lock, flags);
+		bic_set_bfqq(bic, NULL, is_sync, actuator_idx);
 	}
 }
 
 static void bfq_exit_icq(struct io_cq *icq)
 {
 	struct bfq_io_cq *bic = icq_to_bic(icq);
+	struct bfq_data *bfqd = bic_to_bfqd(bic);
+	unsigned long flags;
+	unsigned int act_idx;
+	unsigned int num_actuators;
 
-	if (bic->stable_merge_bfqq) {
-		struct bfq_data *bfqd = bic->stable_merge_bfqq->bfqd;
-
+	/*
+	 * bfqd is NULL if scheduler already exited, and in that case
+	 * this is the last time these queues are accessed.
+	 */
+	if (bfqd) {
+		spin_lock_irqsave(&bfqd->lock, flags);
+		num_actuators = bfqd->num_actuators;
+	} else {
 		/*
-		 * bfqd is NULL if scheduler already exited, and in
-		 * that case this is the last time bfqq is accessed.
+		 * bfqd->num_actuators not available any longer, cycle
+		 * over all possible per-actuator bfqqs in next
+		 * loop. We rely on bic being zeroed on creation, and
+		 * therefore on its unused per-actuator fields being
+		 * NULL.
 		 */
-		if (bfqd) {
-			unsigned long flags;
+		num_actuators = BFQ_MAX_ACTUATORS;
+	}
 
-			spin_lock_irqsave(&bfqd->lock, flags);
-			bfq_put_stable_ref(bic->stable_merge_bfqq);
-			spin_unlock_irqrestore(&bfqd->lock, flags);
-		} else {
-			bfq_put_stable_ref(bic->stable_merge_bfqq);
-		}
+	if (bic->stable_merge_bfqq)
+		bfq_put_stable_ref(bic->stable_merge_bfqq);
+
+	for (act_idx = 0; act_idx < num_actuators; act_idx++) {
+		bfq_exit_icq_bfqq(bic, true, act_idx);
+		bfq_exit_icq_bfqq(bic, false, act_idx);
 	}
 
-	bfq_exit_icq_bfqq(bic, true);
-	bfq_exit_icq_bfqq(bic, false);
+	if (bfqd)
+		spin_unlock_irqrestore(&bfqd->lock, flags);
 }
 
 /*
@@ -5484,23 +5518,25 @@ static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
 
 	bic->ioprio = ioprio;
 
-	bfqq = bic_to_bfqq(bic, false);
+	bfqq = bic_to_bfqq(bic, false, bfq_actuator_index(bfqd, bio));
 	if (bfqq) {
 		bfq_release_process_ref(bfqd, bfqq);
 		bfqq = bfq_get_queue(bfqd, bio, false, bic, true);
-		bic_set_bfqq(bic, bfqq, false);
+		bic_set_bfqq(bic, bfqq, false, bfq_actuator_index(bfqd, bio));
 	}
 
-	bfqq = bic_to_bfqq(bic, true);
+	bfqq = bic_to_bfqq(bic, true, bfq_actuator_index(bfqd, bio));
 	if (bfqq)
 		bfq_set_next_ioprio_data(bfqq, bic);
 }
 
 static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-			  struct bfq_io_cq *bic, pid_t pid, int is_sync)
+			  struct bfq_io_cq *bic, pid_t pid, int is_sync,
+			  unsigned int act_idx)
 {
 	u64 now_ns = ktime_get_ns();
 
+	bfqq->actuator_idx = act_idx;
 	RB_CLEAR_NODE(&bfqq->entity.rb_node);
 	INIT_LIST_HEAD(&bfqq->fifo);
 	INIT_HLIST_NODE(&bfqq->burst_list_node);
@@ -5739,6 +5775,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 	struct bfq_group *bfqg;
 
 	bfqg = bfq_bio_bfqg(bfqd, bio);
+
 	if (!is_sync) {
 		async_bfqq = bfq_async_queue_prio(bfqd, bfqg, ioprio_class,
 						  ioprio);
@@ -5753,7 +5790,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 
 	if (bfqq) {
 		bfq_init_bfqq(bfqd, bfqq, bic, current->pid,
-			      is_sync);
+			      is_sync, bfq_actuator_index(bfqd, bio));
 		bfq_init_entity(&bfqq->entity, bfqg);
 		bfq_log_bfqq(bfqd, bfqq, "allocated");
 	} else {
@@ -6068,7 +6105,8 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 		 * then complete the merge and redirect it to
 		 * new_bfqq.
 		 */
-		if (bic_to_bfqq(RQ_BIC(rq), 1) == bfqq)
+		if (bic_to_bfqq(RQ_BIC(rq), 1,
+				bfq_actuator_index(bfqd, rq->bio)) == bfqq)
 			bfq_merge_bfqqs(bfqd, RQ_BIC(rq),
 					bfqq, new_bfqq);
 
@@ -6622,7 +6660,7 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq)
 		return bfqq;
 	}
 
-	bic_set_bfqq(bic, NULL, 1);
+	bic_set_bfqq(bic, NULL, 1, bfqq->actuator_idx);
 
 	bfq_put_cooperator(bfqq);
 
@@ -6636,7 +6674,8 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
 						   bool split, bool is_sync,
 						   bool *new_queue)
 {
-	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync);
+	unsigned int act_idx = bfq_actuator_index(bfqd, bio);
+	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync, act_idx);
 
 	if (likely(bfqq && bfqq != &bfqd->oom_bfqq))
 		return bfqq;
@@ -6648,7 +6687,7 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
 		bfq_put_queue(bfqq);
 	bfqq = bfq_get_queue(bfqd, bio, is_sync, bic, split);
 
-	bic_set_bfqq(bic, bfqq, is_sync);
+	bic_set_bfqq(bic, bfqq, is_sync, act_idx);
 	if (split && is_sync) {
 		if ((bic->was_in_burst_list && bfqd->large_burst) ||
 		    bic->saved_in_large_burst)
@@ -7090,8 +7129,10 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	 * Our fallback bfqq if bfq_find_alloc_queue() runs into OOM issues.
 	 * Grab a permanent reference to it, so that the normal code flow
 	 * will not attempt to free it.
+	 * Set zero as actuator index: we will pretend that
+	 * all I/O requests are for the same actuator.
 	 */
-	bfq_init_bfqq(bfqd, &bfqd->oom_bfqq, NULL, 1, 0);
+	bfq_init_bfqq(bfqd, &bfqd->oom_bfqq, NULL, 1, 0, 0);
 	bfqd->oom_bfqq.ref++;
 	bfqd->oom_bfqq.new_ioprio = BFQ_DEFAULT_QUEUE_IOPRIO;
 	bfqd->oom_bfqq.new_ioprio_class = IOPRIO_CLASS_BE;
@@ -7110,6 +7151,12 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
 	bfqd->queue = q;
 
+	/*
+	 * Multi-actuator support not complete yet, default to single
+	 * actuator for the moment.
+	 */
+	bfqd->num_actuators = 1;
+
 	INIT_LIST_HEAD(&bfqd->dispatch);
 
 	hrtimer_init(&bfqd->idle_slice_timer, CLOCK_MONOTONIC,
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 71f721670ab6..bfcbd8ea9000 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -33,6 +33,14 @@
  */
 #define BFQ_SOFTRT_WEIGHT_FACTOR	100
 
+/*
+ * Maximum number of actuators supported. This constant is used simply
+ * to define the size of the static array that will contain
+ * per-actuator data. The current value is hopefully a good upper
+ * bound to the possible number of actuators of any actual drive.
+ */
+#define BFQ_MAX_ACTUATORS 32
+
 struct bfq_entity;
 
 /**
@@ -225,12 +233,14 @@ struct bfq_ttime {
  * struct bfq_queue - leaf schedulable entity.
  *
  * A bfq_queue is a leaf request queue; it can be associated with an
- * io_context or more, if it  is  async or shared  between  cooperating
- * processes. @cgroup holds a reference to the cgroup, to be sure that it
- * does not disappear while a bfqq still references it (mostly to avoid
- * races between request issuing and task migration followed by cgroup
- * destruction).
- * All the fields are protected by the queue lock of the containing bfqd.
+ * io_context or more, if it is async or shared between cooperating
+ * processes. Besides, it contains I/O requests for only one actuator
+ * (an io_context is associated with a different bfq_queue for each
+ * actuator it generates I/O for). @cgroup holds a reference to the
+ * cgroup, to be sure that it does not disappear while a bfqq still
+ * references it (mostly to avoid races between request issuing and
+ * task migration followed by cgroup destruction).  All the fields are
+ * protected by the queue lock of the containing bfqd.
  */
 struct bfq_queue {
 	/* reference counter */
@@ -395,6 +405,9 @@ struct bfq_queue {
 	 * the woken queues when this queue exits.
 	 */
 	struct hlist_head woken_list;
+
+	/* index of the actuator this queue is associated with */
+	unsigned int actuator_idx;
 };
 
 /**
@@ -403,8 +416,17 @@ struct bfq_queue {
 struct bfq_io_cq {
 	/* associated io_cq structure */
 	struct io_cq icq; /* must be the first member */
-	/* array of two process queues, the sync and the async */
-	struct bfq_queue *bfqq[2];
+	/*
+	 * Matrix of associated process queues: first row for async
+	 * queues, second row sync queues. Each row contains one
+	 * column for each actuator. An I/O request generated by the
+	 * process is inserted into the queue pointed by bfqq[i][j] if
+	 * the request is to be served by the j-th actuator of the
+	 * drive, where i==0 or i==1, depending on whether the request
+	 * is async or sync. So there is a distinct queue for each
+	 * actuator.
+	 */
+	struct bfq_queue *bfqq[2][BFQ_MAX_ACTUATORS];
 	/* per (request_queue, blkcg) ioprio */
 	int ioprio;
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
@@ -768,6 +790,13 @@ struct bfq_data {
 	 */
 	unsigned int word_depths[2][2];
 	unsigned int full_depth_shift;
+
+	/*
+	 * Number of independent actuators. This is equal to 1 in
+	 * case of single-actuator drives.
+	 */
+	unsigned int num_actuators;
+
 };
 
 enum bfqq_state_flags {
@@ -964,8 +993,10 @@ struct bfq_group {
 
 extern const int bfq_timeout;
 
-struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync);
-void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync);
+struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync,
+				unsigned int actuator_idx);
+void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync,
+				unsigned int actuator_idx);
 struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic);
 void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-- 
2.20.1

