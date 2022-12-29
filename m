Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DFB65919D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiL2UiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiL2Uht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:37:49 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFC817071
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:37:47 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id m18so47346360eji.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG80s5GgWMdUv/CK4RkTzoQTp3+Pav/YrlTEzf358PQ=;
        b=uUcUwBRYbgiQL3lPnPqmt6JxVVgfN3Lxhu0NoRxVUwtEvZt2ycR/qSJEygXeEES/bA
         fu3mEmKq1Q9EeTi0WaC4LSKtfBygyz/049+wm5dE86w39YJ/jHqpyGFwSEFkx1eOgwbt
         qENFw56E6rgspHmZtC8lPh/89BbLQS6IsNp278UqFKERDfjbhPtwwMEoKuH5TBHw6AAk
         pHK4eTgb2FSVFZDjuYMKLrpS2n4+2c/LIM6AJq8fKd1nrY1l50jnJ1+Y6IPLVEUrNp9T
         KakqRKHNBhoXAQa50dcMausl5nhNf8EEmVMAL4KYk1UTPwWWENMbDaCZpgvwTsmHdV4k
         OmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG80s5GgWMdUv/CK4RkTzoQTp3+Pav/YrlTEzf358PQ=;
        b=CdOM8xrllA7f+7omt/JytiToORcjZBKSgRjCZF5iUumRYR3hlDxBxQdeogMBNRKMOn
         QjVYxrzEaTqS7v2bl0mWrs4FcZ/051rJyVz4LnzdzcaFEY3B6KnRD8AjxwOW1ZKIdNiU
         HV0xCfUSsdHTanlGsBabtzyXfaflLXmTKjLm1KRadoR0IgzN8Jphmu6eX/JQbCektoc8
         ucQ66jhHEYwS+h8vWd7br67vpt1P0jv0upmbB5EHfNECAo1T35iVTMxOtasHBBjzccek
         hKqkGrZQCG9h0rKmLiSak3z6dITP7rrANTsA9osRieNzc8WADMLULLRACgMitIAgPwTc
         gNBw==
X-Gm-Message-State: AFqh2kqWvmOtnXEDkNFafHQogQ/Z9fV+App7l5zvQYF+n5KKbNavFXgD
        LWwFyI+gEZIOZOUcF5caoeY5+g==
X-Google-Smtp-Source: AMrXdXuU8VGNWj2uhtCIzvj/qvHrrRA087ANrQYyQ2yTmv/xxtgxqJNMfGwuI08NHGhNT/kzQSyOmw==
X-Received: by 2002:a17:907:a407:b0:84c:7974:8a73 with SMTP id sg7-20020a170907a40700b0084c79748a73mr8259069ejc.57.1672346266979;
        Thu, 29 Dec 2022 12:37:46 -0800 (PST)
Received: from localhost.localdomain (mob-109-118-160-216.net.vodafone.it. [109.118.160.216])
        by smtp.gmail.com with ESMTPSA id d16-20020a170906371000b0073d7b876621sm8872814ejc.205.2022.12.29.12.37.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Dec 2022 12:37:46 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Federico Gavioli <f.gavioli97@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V13 6/8] block, bfq: retrieve independent access ranges from request queue
Date:   Thu, 29 Dec 2022 21:37:05 +0100
Message-Id: <20221229203707.68458-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221229203707.68458-1-paolo.valente@linaro.org>
References: <20221229203707.68458-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 9abd920467cf..86ac721ac136 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1793,10 +1793,25 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
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
 
@@ -7105,6 +7120,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
 	struct elevator_queue *eq;
+	unsigned int i;
+	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -7147,12 +7164,38 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
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

