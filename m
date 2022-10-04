Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0052B5F3F58
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJDJTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiJDJSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:18:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426EC2D1FA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:18:52 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a26so27521379ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6dSVs4xQpUHh3qCkage29CljklBjSrm1dvdJzwRte/4=;
        b=i+UI4R+Qtu4sVuhDa6ht1Pb+UTLOauK0tAz+3yNwSkxafwe64+LAaiVV8N+I7FXK+C
         mK9wDARNEZq9UfCWMvcP9rbhnhb9dlm/QBZShvLTyIye8KDqJBQtauW/XRACgDxI7YJr
         Nfpac30YlTJ4dBBWS05OEKwnsq4FdVhj4L1fOc0FrRctPhKG8jtryLtCdXA2GxIpYgOX
         Yq9r8uJs6G1pw4Q/sQSrT8tW9eGvN8wZEuRbiSXkSZNQWdH/0Lr/CYFc7OZKuoLaYQBu
         22g2nJC9DgTs0bRarW0j5k+CoEVpLeNeXnxn8kztxAJ5NX+rEENPTiuS5ocwDVzDP+zb
         mZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6dSVs4xQpUHh3qCkage29CljklBjSrm1dvdJzwRte/4=;
        b=pNUgDjVo4MF1zrjJsgySacrAAF3dovltNG6UYaTDCfA37xQ6pU20gCvaggf1M1mH2a
         +yik9qmBzBoGP1FGLwOyZihjbPzXZf6JJTKZaPZqZrV3XCshqZEVZQCmX9kDcNSw4SI0
         s22UeQ97m8pfVipdrUx2QkuUcEOlZxB422RbxzdIygdVgeLxpYhqp4KwkcbbqJcZjVu4
         CwncO2kC08kptYrWWrjM7busjISfm8S5MjNHmmU+pO9LZtbQMP1DEaOG3Per6raOd1tV
         EmTpdJgg56g5Drpkv5hAhIybefPr9zgbvD56W0RN51CBPf/rpd1R/qqsf9N5azp5aw0m
         FE3A==
X-Gm-Message-State: ACrzQf0dn/hHA9sx6l8ae/nMqpm9j02v94rV5QIcn1TiYPXrQHo/PRL4
        m4aihZ37aO8wy41kuZioznGWXQ==
X-Google-Smtp-Source: AMsMyM7O5gzBe3/w/2CSVCqOolXfDqOcmnoO6wvHfqIiYWAep9i43JSJ9KVEJSEo1K0hEdKkbEm/vw==
X-Received: by 2002:a17:907:2cc8:b0:77d:6f62:7661 with SMTP id hg8-20020a1709072cc800b0077d6f627661mr18783839ejc.233.1664875131825;
        Tue, 04 Oct 2022 02:18:51 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090618b100b007826c0a05ecsm6597926ejf.209.2022.10.04.02.18.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:18:51 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Federico Gavioli <f.gavioli97@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V2 6/8] block, bfq: retrieve independent access ranges from request queue
Date:   Tue,  4 Oct 2022 11:18:14 +0200
Message-Id: <20221004091816.79799-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221004091816.79799-1-paolo.valente@linaro.org>
References: <20221004091816.79799-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Federico Gavioli <f.gavioli97@gmail.com>

This patch implements the code to gather the content of the
independent_access_ranges structure from the request_queue and copy
it into the queue's bfq_data. This copy is done at queue initialization.

We copy the access ranges into the bfq_data to avoid taking the queue
lock each time we access the ranges.

This implementation, however, puts a limit to the maximum independent
ranges supported by the scheduler. Such a limit is equal to the constant
BFQ_MAX_ACTUATORS. This limit was placed to avoid the allocation of
dynamic memory.

Reviewed-by: Damien Le Moal <Damien.LeMoal@wdc.com>
Co-developed-by: Rory Chen <rory.c.chen@seagate.com>
Signed-off-by: Federico Gavioli <f.gavioli97@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Rory Chen <rory.c.chen@seagate.com>
---
 block/bfq-cgroup.c  |  2 +-
 block/bfq-iosched.c | 58 ++++++++++++++++++++++++++++++++++++++-------
 block/bfq-iosched.h | 12 ++++++++++
 3 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index c5866f57b3aa..872036d059d7 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -764,7 +764,7 @@ static void *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
 	struct bfq_entity *entity;
 	unsigned int act_idx;
 
-	for (act_idx = 0; act_idx < BFQ_MAX_ACTUATORS; act_idx++) {
+	for (act_idx = 0; act_idx < bfqd->num_ia_ranges; act_idx++) {
 		struct bfq_queue *async_bfqq = bic_to_bfqq(bic, 0, act_idx);
 		struct bfq_queue *sync_bfqq = bic_to_bfqq(bic, 1, act_idx);
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 99c305df6cce..dd9886b91e4c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -689,7 +689,7 @@ static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 		limit = (limit * depth) >> bfqd->full_depth_shift;
 	}
 
-	for (act_idx = 0; act_idx < BFQ_MAX_ACTUATORS; act_idx++) {
+	for (act_idx = 0; act_idx < bfqd->num_ia_ranges; act_idx++) {
 		struct bfq_queue *bfqq =
 			bic ? bic_to_bfqq(bic, op_is_sync(op), act_idx) : NULL;
 
@@ -1829,10 +1829,25 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
 /* get the index of the actuator that will serve bio */
 static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct bio *bio)
 {
-	/*
-	 * Multi-actuator support not complete yet, so always return 0
-	 * for the moment.
-	 */
+	struct blk_independent_access_range *iar;
+	unsigned int i;
+	sector_t end;
+
+	if (bfqd->num_ia_ranges == 1)
+		return 0;
+
+	/* bio_end_sector(bio) gives the sector after the last one */
+	end = bio_end_sector(bio) - 1;
+
+	for (i = 0; i < bfqd->num_ia_ranges; i++) {
+		iar = &(bfqd->ia_ranges[i]);
+		if (end >= iar->sector && end < iar->sector + iar->nr_sectors)
+			return i;
+	}
+
+	WARN_ONCE(true,
+		  "bfq_actuator_index: bio sector out of ranges: end=%llu\n",
+		  end);
 	return 0;
 }
 
@@ -2477,7 +2492,6 @@ static void bfq_remove_request(struct request_queue *q,
 
 	if (rq->cmd_flags & REQ_META)
 		bfqq->meta_pending--;
-
 }
 
 static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
@@ -2673,7 +2687,7 @@ void bfq_end_wr_async_queues(struct bfq_data *bfqd,
 {
 	int i, j, k;
 
-	for (k = 0; k < BFQ_MAX_ACTUATORS; k++) {
+	for (k = 0; k < bfqd->num_ia_ranges; k++) {
 		for (i = 0; i < 2; i++)
 			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
 				if (bfqg->async_bfqq[i][j][k])
@@ -5432,7 +5446,7 @@ static void bfq_exit_icq(struct io_cq *icq)
 	if (bfqd)
 		spin_lock_irqsave(&bfqd->lock, flags);
 
-	for (act_idx = 0; act_idx < BFQ_MAX_ACTUATORS; act_idx++) {
+	for (act_idx = 0; act_idx < bfqd->num_ia_ranges; act_idx++) {
 		if (bic->stable_merge_bfqq[act_idx])
 			bfq_put_stable_ref(bic->stable_merge_bfqq[act_idx]);
 
@@ -7003,7 +7017,7 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 {
 	int i, j, k;
 
-	for (k = 0; k < BFQ_MAX_ACTUATORS; k++) {
+	for (k = 0; k < bfqd->num_ia_ranges; k++) {
 		for (i = 0; i < 2; i++)
 			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
 				__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j][k]);
@@ -7120,6 +7134,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
 	struct elevator_queue *eq;
+	unsigned int i;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -7162,6 +7177,31 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
 	bfqd->queue = q;
 
+	/*
+	 * If the disk supports multiple actuators, we copy the independent
+	 * access ranges from the request queue structure.
+	 */
+	spin_lock_irq(&q->queue_lock);
+	if (q->ia_ranges) {
+		/*
+		 * Check if the disk ia_ranges size exceeds the current bfq
+		 * actuator limit.
+		 */
+		if (q->ia_ranges->nr_ia_ranges > BFQ_MAX_ACTUATORS) {
+			pr_crit("nr_ia_ranges higher than act limit: iars=%d, max=%d.\n",
+					q->ia_ranges->nr_ia_ranges, BFQ_MAX_ACTUATORS);
+			pr_crit("Falling back to single actuator mode.\n");
+			bfqd->num_ia_ranges = 1;
+		} else {
+			bfqd->num_ia_ranges = q->ia_ranges->nr_ia_ranges;
+
+			for (i = 0; i < bfqd->num_ia_ranges; i++)
+				bfqd->ia_ranges[i] = q->ia_ranges->ia_range[i];
+		}
+	} else
+		bfqd->num_ia_ranges = 1;
+	spin_unlock_irq(&q->queue_lock);
+
 	INIT_LIST_HEAD(&bfqd->dispatch);
 
 	hrtimer_init(&bfqd->idle_slice_timer, CLOCK_MONOTONIC,
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 2687e9a85a41..0c78feea15d7 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -796,6 +796,18 @@ struct bfq_data {
 	 */
 	unsigned int word_depths[2][2];
 	unsigned int full_depth_shift;
+
+	/*
+	 * Number of independent access ranges. This is equal to 1 in
+	 * case of single actuator drives.
+	 */
+	unsigned int num_ia_ranges;
+
+	/*
+	 * Disk independent access ranges for each actuator
+	 * in this device.
+	 */
+	struct blk_independent_access_range ia_ranges[BFQ_MAX_ACTUATORS];
 };
 
 enum bfqq_state_flags {
-- 
2.20.1

