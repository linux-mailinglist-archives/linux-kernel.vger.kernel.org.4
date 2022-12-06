Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6743F643E46
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiLFIQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiLFIQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:16:06 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2CC18B3F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:16:04 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s5so19131965edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvbZSEnSEzLdu7kZISISG4TIgUpixjenItLENz+8BsE=;
        b=PVgbkqownST6/r10EIuSEAdT/wjZjhnykquUPS+xrzqoZRgWOZJ/b2so/ZeGldvSJP
         8nAzoAPeh1J7+B8x83x2f31CJv8D3xqJrucZGstQLbAMCoC/9a3NX98k5taIKZfYcbMj
         xKxzpoNQ0O6txtlxmWTiwdJ0WqJEP81bWAlcfRhOkOZL3/VJ/Pj4wS/oryBKFgoBZjBU
         R97dmBWH4oSnqeBB1+EO5DQ0BsRjrVtTTsTZRQv7DZ8nGlArlrkfFVRG5dCrmSM5x9Q0
         1A01MJsO9DDUBpfmLHixM9vLTJRbtFiDbayxLZ72Q0CW59VPbdjdqP9cJdYA1zKtn5G3
         9dKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvbZSEnSEzLdu7kZISISG4TIgUpixjenItLENz+8BsE=;
        b=zBafkE1M7T7/+hg3fdAo/CBxEFEod1/fhZRhkXs6ZNyEyLgxBXzWZWpe/pbXmg8t7z
         huQid1ek5PYufWdbBWYcq7SS9WLIxR1LqSKy81c91WueZNbIaqgdsH4bXGS0+6Rq1DPb
         yAH+HSM6ShhqAPIkcxO11YtDw/7eb9Mtc9kB50R68JMjGU4tFMakM2oq1CpFi1dSyBln
         hlKg2Qo3ludwNe4KUr6+dAnt6b2EbuVxhtXhB2KfPLExS8GAradselGqcNYK0KovLFME
         OuJiHTURknoJXORtkuNDO/H2aMTH23Sdow6DA0502jlP3v9Dtct3f2F3J5fjwFgDkYbt
         W9Dg==
X-Gm-Message-State: ANoB5pmGYyp51Q/JKMsL66KA1PSr5cfGDZPVV7Mj1Es21wcUw63N3W+L
        a602TY+h8V+GX8hSPl4M9LiVSw==
X-Google-Smtp-Source: AA0mqf4Db5CvDp4j0j9msdYeia7RPZtmZzMbZ2z9Q0F9T8+Synjl4lsttVryR1nBG3A5A09qHfvA5Q==
X-Received: by 2002:a05:6402:5003:b0:462:a25f:f0f2 with SMTP id p3-20020a056402500300b00462a25ff0f2mr24239475eda.156.1670314562684;
        Tue, 06 Dec 2022 00:16:02 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906329800b007b29d292852sm7161944ejw.148.2022.12.06.00.16.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:16:02 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V7 5/8] block, bfq: split also async bfq_queues on a per-actuator basis
Date:   Tue,  6 Dec 2022 09:15:48 +0100
Message-Id: <20221206081551.28257-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221206081551.28257-1-paolo.valente@linaro.org>
References: <20221206081551.28257-1-paolo.valente@linaro.org>
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

From: Davide Zini <davidezini2@gmail.com>

Similarly to sync bfq_queues, also async bfq_queues need to be split
on a per-actuator basis.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Davide Zini <davidezini2@gmail.com>
---
 block/bfq-iosched.c | 41 +++++++++++++++++++++++------------------
 block/bfq-iosched.h |  8 ++++----
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c5caeefba156..6b1376ab8980 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2680,14 +2680,16 @@ static void bfq_bfqq_end_wr(struct bfq_queue *bfqq)
 void bfq_end_wr_async_queues(struct bfq_data *bfqd,
 			     struct bfq_group *bfqg)
 {
-	int i, j;
-
-	for (i = 0; i < 2; i++)
-		for (j = 0; j < IOPRIO_NR_LEVELS; j++)
-			if (bfqg->async_bfqq[i][j])
-				bfq_bfqq_end_wr(bfqg->async_bfqq[i][j]);
-	if (bfqg->async_idle_bfqq)
-		bfq_bfqq_end_wr(bfqg->async_idle_bfqq);
+	int i, j, k;
+
+	for (k = 0; k < bfqd->num_actuators; k++) {
+		for (i = 0; i < 2; i++)
+			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
+				if (bfqg->async_bfqq[i][j][k])
+					bfq_bfqq_end_wr(bfqg->async_bfqq[i][j][k]);
+		if (bfqg->async_idle_bfqq[k])
+			bfq_bfqq_end_wr(bfqg->async_idle_bfqq[k]);
+	}
 }
 
 static void bfq_end_wr(struct bfq_data *bfqd)
@@ -5636,18 +5638,18 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 static struct bfq_queue **bfq_async_queue_prio(struct bfq_data *bfqd,
 					       struct bfq_group *bfqg,
-					       int ioprio_class, int ioprio)
+					       int ioprio_class, int ioprio, int act_idx)
 {
 	switch (ioprio_class) {
 	case IOPRIO_CLASS_RT:
-		return &bfqg->async_bfqq[0][ioprio];
+		return &bfqg->async_bfqq[0][ioprio][act_idx];
 	case IOPRIO_CLASS_NONE:
 		ioprio = IOPRIO_BE_NORM;
 		fallthrough;
 	case IOPRIO_CLASS_BE:
-		return &bfqg->async_bfqq[1][ioprio];
+		return &bfqg->async_bfqq[1][ioprio][act_idx];
 	case IOPRIO_CLASS_IDLE:
-		return &bfqg->async_idle_bfqq;
+		return &bfqg->async_idle_bfqq[act_idx];
 	default:
 		return NULL;
 	}
@@ -5820,7 +5822,8 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 	bfqg = bfq_bio_bfqg(bfqd, bio);
 	if (!is_sync) {
 		async_bfqq = bfq_async_queue_prio(bfqd, bfqg, ioprio_class,
-						  ioprio);
+						  ioprio,
+						  bfq_actuator_index(bfqd, bio));
 		bfqq = *async_bfqq;
 		if (bfqq)
 			goto out;
@@ -7037,13 +7040,15 @@ static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
  */
 void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 {
-	int i, j;
+	int i, j, k;
 
-	for (i = 0; i < 2; i++)
-		for (j = 0; j < IOPRIO_NR_LEVELS; j++)
-			__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j]);
+	for (k = 0; k < bfqd->num_actuators; k++) {
+		for (i = 0; i < 2; i++)
+			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
+				__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j][k]);
 
-	__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq);
+		__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq[k]);
+	}
 }
 
 /*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index a685aa32b037..1450990dba32 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -976,8 +976,8 @@ struct bfq_group {
 
 	void *bfqd;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
-	struct bfq_queue *async_idle_bfqq;
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_MAX_ACTUATORS];
+	struct bfq_queue *async_idle_bfqq[BFQ_MAX_ACTUATORS];
 
 	struct bfq_entity *my_entity;
 
@@ -993,8 +993,8 @@ struct bfq_group {
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
-	struct bfq_queue *async_idle_bfqq;
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_MAX_ACTUATORS];
+	struct bfq_queue *async_idle_bfqq[BFQ_MAX_ACTUATORS];
 
 	struct rb_root rq_pos_tree;
 };
-- 
2.20.1

