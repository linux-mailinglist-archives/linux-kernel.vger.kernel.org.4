Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EC45F4011
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiJDJng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiJDJm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:42:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6505925B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:40:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a13so18097327edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1rcy36nQ6e25xC0qV4v6m146ogmoM1vbmtvfmSvO+8k=;
        b=DuFrOqLmY4jQB98JENOoMxfc3HiboNqsah1xFLBNdVOkmVM56IX856ajdyG0tqc36+
         LCdHxRefSa2sw+cTqMTpGeRypHOZDcVExeCqj9nrjF8BTxu8y6hVZRkas7IKtILhyKgm
         0RPWQVjbH9EI6lBe2awBSw0uirG6gXddyf5+s5SFWqF6fGX8vjcMfMIoM6nosVnwbPDI
         r0dWB5NPQG3WUQWQpyFis+ACRGQgzk4ch35OUGwxtXK16RAysHgeWLX9QmYnMwRES4wY
         MQNUHR97nzB73RModG3NEWqJYCY5RyxC9s0AJBhZyILs2VZprkY3G9eImj7Zdt1zPU+0
         3Qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1rcy36nQ6e25xC0qV4v6m146ogmoM1vbmtvfmSvO+8k=;
        b=5O8cdRW6Bs8MehTjJDrDzg5YuNkaRtpFzEWBSEaI9eEnolnw+uI2Z38D+d2MyTiNVE
         G6dX2KerfozHEBTy6y4p5cGXSyivV8zLyq45bWDswSoZFtbclO7Y1RqYZT7e678i60Ex
         MenThev9E8xOSbQaxJyGDsgISlTUTg1y4r8eRavCpKjZh+uwTWduO6xocsGXX//4eWXa
         ayY7mZg79E1lEU0zd5KfGuhENFRXAZtAQBE4UXXej7s5NkiwxXIClSgIvSFsujGMUroR
         3H6/wMkmAPOZ2rzEFCYAMkCGPjw/r1M3sporZq35OkY+cNo/ln5C79wyDXZiJrXCkcQN
         9YxQ==
X-Gm-Message-State: ACrzQf0c/RlgswXcU/Cve7Qv1S/pNVMS+EmJ2iFhgfJIoqKhu5XH2ryc
        gmy8jYGeJozF3y7+IoDQFmBEGw==
X-Google-Smtp-Source: AMsMyM5JOlJRZO4N+CpgfUcp+FzNeiEaOq+HOKBVgngVXU11Q04AViRJWMt5iQKWe4tKllcOi9Ea0w==
X-Received: by 2002:a05:6402:2549:b0:452:8292:b610 with SMTP id l9-20020a056402254900b004528292b610mr22557636edb.199.1664876423475;
        Tue, 04 Oct 2022 02:40:23 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906200900b00780f6071b5dsm6774853ejo.188.2022.10.04.02.40.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:40:23 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Federico Gavioli <f.gavioli97@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V3 6/8] block, bfq: retrieve independent access ranges from request queue
Date:   Tue,  4 Oct 2022 11:40:08 +0200
Message-Id: <20221004094010.80090-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221004094010.80090-1-paolo.valente@linaro.org>
References: <20221004094010.80090-1-paolo.valente@linaro.org>
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
 block/bfq-iosched.c | 59 ++++++++++++++++++++++++++++++++++++++-------
 block/bfq-iosched.h | 12 +++++++++
 3 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 3b4a0363d617..080d9160217b 100644
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
index d8a15427a96d..9203b4604da8 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -689,7 +689,7 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 		limit = (limit * depth) >> bfqd->full_depth_shift;
 	}
 
-	for (act_idx = 0; act_idx < BFQ_MAX_ACTUATORS; act_idx++) {
+	for (act_idx = 0; act_idx < bfqd->num_ia_ranges; act_idx++) {
 		struct bfq_queue *bfqq =
 			bic ? bic_to_bfqq(bic, op_is_sync(opf), act_idx) : NULL;
 
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
@@ -7120,6 +7134,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
 	struct elevator_queue *eq;
+	unsigned int i;
+	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -7162,6 +7178,31 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
 	bfqd->queue = q;
 
+	/*
+	 * If the disk supports multiple actuators, we copy the independent
+	 * access ranges from the request queue structure.
+	 */
+	spin_lock_irq(&q->queue_lock);
+	if (ia_ranges) {
+		/*
+		 * Check if the disk ia_ranges size exceeds the current bfq
+		 * actuator limit.
+		 */
+		if (ia_ranges->nr_ia_ranges > BFQ_MAX_ACTUATORS) {
+			pr_crit("nr_ia_ranges higher than act limit: iars=%d, max=%d.\n",
+					ia_ranges->nr_ia_ranges, BFQ_MAX_ACTUATORS);
+			pr_crit("Falling back to single actuator mode.\n");
+			bfqd->num_ia_ranges = 1;
+		} else {
+			bfqd->num_ia_ranges = ia_ranges->nr_ia_ranges;
+
+			for (i = 0; i < bfqd->num_ia_ranges; i++)
+				bfqd->ia_ranges[i] = ia_ranges->ia_range[i];
+		}
+	} else
+		bfqd->num_ia_ranges = 1;
+	spin_unlock_irq(&q->queue_lock);
+
 	INIT_LIST_HEAD(&bfqd->dispatch);
 
 	hrtimer_init(&bfqd->idle_slice_timer, CLOCK_MONOTONIC,
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index f9ccf468edc2..34f7603bb62f 100644
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

