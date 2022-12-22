Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734A8654433
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiLVPWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbiLVPWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:22:13 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C680C2B255
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:22:10 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id m18so5668304eji.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bhr5qDaT2JKIRy4QvSZClVOncStleytag0NJgoail6A=;
        b=ePqAcSTv4XFlYItKTMjsdafeWPV1Hl+RIsok1DKy20O+kji7kTZb1NLBcjy8LSb5GO
         DKVimmhqpbvQvpGX3lkLIcV5qEzhTN+gHlzlVBYTRtwcP4XiiWXeG6OxUO8L6GC5CRjI
         KXSUPKuyEeqtb7mtcqdXGyalgJiLm3TULo5K6Eu/CX+Jb65fdcRb6YalpGGvyCOX+3km
         osFRw39wFQnsEu6dv4CBaXwNeRRTtG3Zdy3azOPmX8GjJtg3kdPGAaDByIvcuBetEfzE
         X/osZqdwjxHbrFjOv4285WvB4hSevd8RHOcvEKmBHli9hHeY3CS26iqJKjryyjcYY1X3
         DNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bhr5qDaT2JKIRy4QvSZClVOncStleytag0NJgoail6A=;
        b=78dD290lGwrkucI98RS+kS78dJ6+zlSt1xYmZUInMgTl9vAXjGapXCNJBnTi+lPBGD
         nJvM8cK/awgJaqNeWH65oUGrPlnRYeP8V5wCEkZOoH8+sHmWx6LuhrSGduDFjgYzAi8j
         pQxO0nLSxXHFjnITIlFKkTvoOGeEvK6b90HGcHNawWMSmBVG16EqjSIR/dzHj1taWdLk
         +cSwN7YN9FCeMo0wgd0akbd+Az6yj1Ug3OHa3QFBZxlAYHEs1rOBIlrShT+pSSbh7xCz
         HQjqKBZiJ1r98bAqJIBsFBUDjCASz2TPpvBuI5/L1ebuJytd2a54Bwox53Uv4NwxjOG6
         FFGQ==
X-Gm-Message-State: AFqh2kqDtdPhzfhy3gUdbWP0z5/k5+UO4/2tjbokqwDTpPjj/LLjeze2
        E920ok3c0GBvOlIHqAjf5yZfPg==
X-Google-Smtp-Source: AMrXdXtbgI4HP9ON1BOA05QZAkYnwABg7Urk8RYFc/CPmTwTPH+kKnb/ofkilCaMyH68fi7bo6a7Xw==
X-Received: by 2002:a17:906:700f:b0:7c1:6bd9:571e with SMTP id n15-20020a170906700f00b007c16bd9571emr4149992ejj.13.1671722530401;
        Thu, 22 Dec 2022 07:22:10 -0800 (PST)
Received: from MBP-di-Paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906201100b007c08439161dsm355670ejo.50.2022.12.22.07.22.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Dec 2022 07:22:10 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Federico Gavioli <f.gavioli97@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V12 6/8] block, bfq: retrieve independent access ranges from request queue
Date:   Thu, 22 Dec 2022 16:21:55 +0100
Message-Id: <20221222152157.61789-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221222152157.61789-1-paolo.valente@linaro.org>
References: <20221222152157.61789-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
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

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Co-developed-by: Rory Chen <rory.c.chen@seagate.com>
Signed-off-by: Rory Chen <rory.c.chen@seagate.com>
Signed-off-by: Federico Gavioli <f.gavioli97@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 59 +++++++++++++++++++++++++++++++++++++++------
 block/bfq-iosched.h |  8 +++++-
 2 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f29444d53e6a..1db7fb18f99e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1797,10 +1797,25 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
  */
 static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct bio *bio)
 {
-	/*
-	 * Multi-actuator support not complete yet, so always return 0
-	 * for the moment (to keep incomplete mechanisms off).
-	 */
+	unsigned int i;
+	sector_t end;
+
+	/* no search needed if one or zero ranges present */
+	if (bfqd->num_actuators == 1)
+		return 0;
+
+	/* bio_end_sector(bio) gives the sector after the last one */
+	end = bio_end_sector(bio) - 1;
+
+	for (i = 0; i < bfqd->num_actuators; i++) {
+		if (end >= bfqd->sector[i] &&
+		    end < bfqd->sector[i] + bfqd->nr_sectors[i])
+			return i;
+	}
+
+	WARN_ONCE(true,
+		  "bfq_actuator_index: bio sector out of ranges: end=%llu\n",
+		  end);
 	return 0;
 }
 
@@ -7109,6 +7124,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
 	struct elevator_queue *eq;
+	unsigned int i;
+	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -7151,12 +7168,38 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
 	bfqd->queue = q;
 
+	bfqd->num_actuators = 1;
 	/*
-	 * Multi-actuator support not complete yet, unconditionally
-	 * set to only one actuator for the moment (to keep incomplete
-	 * mechanisms off).
+	 * If the disk supports multiple actuators, copy independent
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
+		} else {
+			bfqd->num_actuators = ia_ranges->nr_ia_ranges;
+
+			for (i = 0; i < bfqd->num_actuators; i++) {
+				bfqd->sector[i] = ia_ranges->ia_range[i].sector;
+				bfqd->nr_sectors[i] =
+					ia_ranges->ia_range[i].nr_sectors;
+			}
+		}
+	}
+
+	/* Otherwise use single-actuator dev info */
+	if (bfqd->num_actuators == 1) {
+		bfqd->sector[0] = 0;
+		bfqd->nr_sectors[0] = get_capacity(q->disk);
+	}
+	spin_unlock_irq(&q->queue_lock);
 
 	INIT_LIST_HEAD(&bfqd->dispatch);
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index de2b2af643e5..830dda1f9322 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -814,7 +814,13 @@ struct bfq_data {
 	 * case of single-actuator drives.
 	 */
 	unsigned int num_actuators;
-
+	/*
+	 * Disk independent access ranges for each actuator
+	 * in this device.
+	 */
+	sector_t sector[BFQ_MAX_ACTUATORS];
+	sector_t nr_sectors[BFQ_MAX_ACTUATORS];
+	struct blk_independent_access_range ia_ranges[BFQ_MAX_ACTUATORS];
 };
 
 enum bfqq_state_flags {
-- 
2.20.1

