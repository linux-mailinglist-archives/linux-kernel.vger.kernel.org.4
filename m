Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A81618458
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiKCQ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiKCQ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:26:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B7F1A83D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:26:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a13so3938494edj.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0bqMU9HIzOHFWGEi5tgrDC+AGs+9ggljEGUZXzxUOo=;
        b=qUtvrLsl23naT+PvbRMt3AkcDQvD3B9m9jT9QYBiWOc3bHmZkWL1FAbBf1ebKXww6u
         aldyZ6EZbcJKTFsNyMSwKkUDRzfHYF82RBx2pAmodfiB+qyKgtF8vpolYRfPvUtRdMmW
         5285x1E+bfYaInkxT2ewRZVojLa3vrowrs90tcoaewCSjR5augzWnB5U0A8l4oqrj4Kf
         OGcXhsq7FlcKfXnpX5StPkhAAeteqKHwKsF80r4dDTu9UgFC/c0aLhFbcESCBlVZHT7e
         bFEcdi+Gjo40TdNiQYW32riXSu/EoqaX9fmA2zfjUY4i9dboRjHCyLfSB101cCXk7Dgi
         v2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0bqMU9HIzOHFWGEi5tgrDC+AGs+9ggljEGUZXzxUOo=;
        b=mEESM7iDWm/5AYw72BMneAb94A0zunh7TnzbtBtdGEpva3R9ETuFkrnGU5ePkL3q9P
         552IeS9oreRU2Q1ZbW/DK94LUh55YPUjjuUoZRQlc5xyYe7PLy4OpUgqjjIdzjp2Nixp
         +F53NYOr84bfUip2k/tTNCY5tiJpW1T5a0nKoJ23TBivcgOnd/OBHWPcNKoVvFvcveuv
         6aAsy/dpr75q8fVh2n214PBiISgBhIsewVxCiMXouhjwSTdUE1AIHzSptorA6bwWHxxA
         jpZ87c7S3BsPF/t/UtvEuyGwka/CnmIMttCZ0xK2Iv+zrYC2H6JOqnpF0TIUDQJuGsiG
         oF4Q==
X-Gm-Message-State: ACrzQf1XJ579XZ7tusLwTPKkelXGmhbLKEf6yySjNuGTn0bX1uN5vlcE
        FcH2RTUVAgHQOXExmO5qY06yoQ==
X-Google-Smtp-Source: AMsMyM6whiM/lVtsI8afmGWcbvecma0D8dFBeM4hEVX5TOB73b9YEo5R0jYQhBFxumzwpQyWvcDt+A==
X-Received: by 2002:aa7:d9d1:0:b0:461:9556:23e6 with SMTP id v17-20020aa7d9d1000000b00461955623e6mr32275265eds.25.1667492803932;
        Thu, 03 Nov 2022 09:26:43 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id kx9-20020a170907774900b0078116c361d9sm702507ejc.10.2022.11.03.09.26.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2022 09:26:43 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Federico Gavioli <f.gavioli97@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V6 6/8] block, bfq: retrieve independent access ranges from request queue
Date:   Thu,  3 Nov 2022 17:26:21 +0100
Message-Id: <20221103162623.10286-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221103162623.10286-1-paolo.valente@linaro.org>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
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

Co-developed-by: Rory Chen <rory.c.chen@seagate.com>
Signed-off-by: Rory Chen <rory.c.chen@seagate.com>
Signed-off-by: Federico Gavioli <f.gavioli97@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 54 ++++++++++++++++++++++++++++++++++++++-------
 block/bfq-iosched.h |  5 +++++
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c94b80e3f685..106c8820cc5c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1831,10 +1831,26 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
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
+	/* no search needed if one or zero ranges present */
+	if (bfqd->num_actuators < 2)
+		return 0;
+
+	/* bio_end_sector(bio) gives the sector after the last one */
+	end = bio_end_sector(bio) - 1;
+
+	for (i = 0; i < bfqd->num_actuators; i++) {
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
 
@@ -2479,7 +2495,6 @@ static void bfq_remove_request(struct request_queue *q,
 
 	if (rq->cmd_flags & REQ_META)
 		bfqq->meta_pending--;
-
 }
 
 static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
@@ -7144,6 +7159,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
 	struct elevator_queue *eq;
+	unsigned int i;
+	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -7187,10 +7204,31 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->queue = q;
 
 	/*
-	 * Multi-actuator support not complete yet, default to single
-	 * actuator for the moment.
+	 * If the disk supports multiple actuators, we copy the independent
+	 * access ranges from the request queue structure.
 	 */
-	bfqd->num_actuators = 1;
+	spin_lock_irq(&q->queue_lock);
+	if (ia_ranges) {
+		/*
+		 * Check if the disk ia_ranges size exceeds the current bfq
+		 * actuator limit.
+		 */
+		if (ia_ranges->nr_ia_ranges > BFQ_MAX_ACTUATORS) {
+			pr_crit("nr_ia_ranges higher than act limit: iars=%d, max=%d.\n",
+				ia_ranges->nr_ia_ranges, BFQ_MAX_ACTUATORS);
+			pr_crit("Falling back to single actuator mode.\n");
+			bfqd->num_actuators = 0;
+		} else {
+			bfqd->num_actuators = ia_ranges->nr_ia_ranges;
+
+			for (i = 0; i < bfqd->num_actuators; i++)
+				bfqd->ia_ranges[i] = ia_ranges->ia_range[i];
+		}
+	} else {
+		bfqd->num_actuators = 0;
+	}
+
+	spin_unlock_irq(&q->queue_lock);
 
 	INIT_LIST_HEAD(&bfqd->dispatch);
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index f1c2e77cbf9a..90130a893c8f 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -811,6 +811,11 @@ struct bfq_data {
 	 */
 	unsigned int num_actuators;
 
+	/*
+	 * Disk independent access ranges for each actuator
+	 * in this device.
+	 */
+	struct blk_independent_access_range ia_ranges[BFQ_MAX_ACTUATORS];
 };
 
 enum bfqq_state_flags {
-- 
2.20.1

