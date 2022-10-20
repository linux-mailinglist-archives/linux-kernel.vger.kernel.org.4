Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F64606478
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiJTP1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJTP1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:27:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2571C6BE1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:27:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a10so35051049wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYfAQbFPbPuWxP8oBowD8Zx074eHcmT9s7z7LBjxk8g=;
        b=x7nyCWzb/g0xaRw8Sw4ioqnvViRmpZC5TFCaUE3mceNp8hrtqM72tSSnIhwfp4gYSS
         wMpWscagUxxB8ypNoJAX1zaEtPIbXnLAEpGtqU/w5TngbPsCyVJiuYlVFYOwT7EXYyY/
         9iQk8cpnwJFA//EPh7XEXiM7OPqyN4ZrKUx+50JpPCMvqB6Qlwrh+kvk2ALXQML52LlP
         HECkoxoM55g43K1iHzGt/nb/+sWPIH1ghUuVjPuuIVVaKmKbSZqBNa9QTIj7jBoaC5XP
         iTWrpyQdWAk/2JcwgeqHx9kfshE9sVCMc2A5qS3xJmbrIOe+HIT09IPmdTnMNAVqRWgr
         pPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYfAQbFPbPuWxP8oBowD8Zx074eHcmT9s7z7LBjxk8g=;
        b=VYQEAuVkj7znau4VgeajDpJmW0TPPs6VkSVFviURogx/7Cbl6YMsuujaA99uog0TeT
         b9Ke0BJ4EfFWY65J9Z/Ll9W+PxcmFLH5ArD84Bl8MKi1PES/NEu+S64giIdgTV7uNMpK
         8venwEsG3B68rpyETMnw2JGNdlsqD1KJAyQBILIjjk4V7d/rV9GVmpEDJ0Qy71wGTC1E
         Avgl8O0ugcsmqrMAxvgpGTvnZHcLBX+ai3gdXfXUSuIAecwPCZNc7VmCtToAU4TyMPG/
         DnNJccqYupp1ZlqbWg6njX3xVg2QqdhRu/sukXp0Q5kkNy3pURImMTeBYnz0bhx/fROn
         JoEw==
X-Gm-Message-State: ACrzQf11yPj4th2sxLTqWK37Xxxo0nCZq+D3/LdNVCzjElNwLgghu0wC
        qvYMB8teZK1F6/eyGkEzlIuXbQ==
X-Google-Smtp-Source: AMsMyM6I7VjSHFvmndKprKshvhI7uy37XhpKK7des4R5mNXogSUN46w2swVoazd9SZZUC7/2Wag+og==
X-Received: by 2002:a5d:584b:0:b0:232:b68c:9e6 with SMTP id i11-20020a5d584b000000b00232b68c09e6mr8755800wrf.111.1666279621326;
        Thu, 20 Oct 2022 08:27:01 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id l10-20020a1ced0a000000b003c409244bb0sm134337wmh.6.2022.10.20.08.26.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 08:27:00 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        glen.valante@linaro.org, arie.vanderhoeven@seagate.com,
        rory.c.chen@seagate.com, Federico Gavioli <f.gavioli97@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V4 6/8] block, bfq: retrieve independent access ranges from request queue
Date:   Thu, 20 Oct 2022 17:26:41 +0200
Message-Id: <20221020152643.21199-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221020152643.21199-1-paolo.valente@linaro.org>
References: <20221020152643.21199-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
index 7c9b5cae05b5..d0109bfc2ed0 100644
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
@@ -7137,6 +7152,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
 	struct elevator_queue *eq;
+	unsigned int i;
+	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -7180,10 +7197,31 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
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
index 5fca86a82411..326d68d65cc9 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -815,6 +815,11 @@ struct bfq_data {
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

