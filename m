Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61B55F3F56
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiJDJTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiJDJSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:18:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1D22CE3C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:18:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a26so27521129ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WoylzFzOyqfX9lJkgY5mImGhkHNCINakNCYCsw+s7Ug=;
        b=l+UIb4gZXZG3uGXDlB18D6HZRF8vRFCQApKatTByEppalxPDlWiHfl1aaj9TGcWOxz
         2uSfdtWdM3CZYbNaHcB6h5iOBdAU/lD0De8VguByFCwZ9I7v9AZvQkjNghAWIIMF9L0f
         mY05CFAqwg0uCyVfFSHemj+5whXaPlI+C2Cl2oFVOpgu/GtBE3NFUBiE/BKv/njoqzBj
         U1NYPiIno9laBz02HdFJHy/7A3Cp4AwP3v+2o0QNceRisj7GAjlGhH+ZwT1PwpWif5AS
         /sew+Za9n+/PVmc+LfW8Jkgyy3U1kTsMCFK776jwXvXZqE/rXOOT3HDhpx9zowOJGxNk
         KvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WoylzFzOyqfX9lJkgY5mImGhkHNCINakNCYCsw+s7Ug=;
        b=yrE/yH7+P0j6DHC8CG6K152WaoA1qjYs56yAm5n3JoDCp095gIT0OxobhVcxfj/5AV
         sYcP2PrtBjhvw5T9WoWs1DQhCF7vzC50wCVXKswfi5VvYTmLr0nf/prGMBOurTZJzoWd
         c/ZJ9o1i9mPKSahpiQLESqYAiiAnJbHVbOvTyDbQjT25/lIvbnkLzvblBxdSkMuMmgtd
         QV+5JvtYczN37jDEWK9jSxm2BOFJ1R62ipneNW7Tf7Hnqz0QwEN45jggyfTMn08KQ9Z9
         ZIVe7t0U2lZKr5Bj+Vr/pE9MDwUomqe3ed99qEIq4QeNkIcFRr6M7AYK117+ITyiXQ62
         EnmA==
X-Gm-Message-State: ACrzQf3MS5ZnyutUEbYsodkTnKiEQ9p5TkfiUERTo62z+0nRf3tb/Zoh
        0J6XZ0aEWHA7owk5Gc0oZcJWmA==
X-Google-Smtp-Source: AMsMyM4852Ofi1vOzRjJJ5cGlC6fQY+Aht9yTkCucAzISP3WafSTRuiWRaIySIwH1OfRF1Naq8C9hg==
X-Received: by 2002:a17:906:845b:b0:78c:7971:1799 with SMTP id e27-20020a170906845b00b0078c79711799mr4911645ejy.715.1664875128978;
        Tue, 04 Oct 2022 02:18:48 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090618b100b007826c0a05ecsm6597926ejf.209.2022.10.04.02.18.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:18:48 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V2 4/8] block, bfq: split also async bfq_queues on a per-actuator basis
Date:   Tue,  4 Oct 2022 11:18:12 +0200
Message-Id: <20221004091816.79799-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221004091816.79799-1-paolo.valente@linaro.org>
References: <20221004091816.79799-1-paolo.valente@linaro.org>
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
index fa24f9074e6f..acc2282cf196 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2671,14 +2671,16 @@ static void bfq_bfqq_end_wr(struct bfq_queue *bfqq)
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
+	for (k = 0; k < BFQ_NUM_ACTUATORS; k++) {
+		for (i = 0; i < 2; i++)
+			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
+				if (bfqg->async_bfqq[i][j][k])
+					bfq_bfqq_end_wr(bfqg->async_bfqq[i][j][k]);
+		if (bfqg->async_idle_bfqq[k])
+			bfq_bfqq_end_wr(bfqg->async_idle_bfqq[k]);
+	}
 }
 
 static void bfq_end_wr(struct bfq_data *bfqd)
@@ -5598,18 +5600,18 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
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
@@ -5783,7 +5785,8 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 
 	if (!is_sync) {
 		async_bfqq = bfq_async_queue_prio(bfqd, bfqg, ioprio_class,
-						  ioprio);
+						  ioprio,
+						  bfq_actuator_index(bfqd, bio));
 		bfqq = *async_bfqq;
 		if (bfqq)
 			goto out;
@@ -6998,13 +7001,15 @@ static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
  */
 void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 {
-	int i, j;
+	int i, j, k;
 
-	for (i = 0; i < 2; i++)
-		for (j = 0; j < IOPRIO_NR_LEVELS; j++)
-			__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j]);
+	for (k = 0; k < BFQ_NUM_ACTUATORS; k++) {
+		for (i = 0; i < 2; i++)
+			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
+				__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j][k]);
 
-	__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq);
+	__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq[k]);
+	}
 }
 
 /*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index e1ed18a9400d..8862c12e8031 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -961,8 +961,8 @@ struct bfq_group {
 
 	void *bfqd;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
-	struct bfq_queue *async_idle_bfqq;
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_NUM_ACTUATORS];
+	struct bfq_queue *async_idle_bfqq[BFQ_NUM_ACTUATORS];
 
 	struct bfq_entity *my_entity;
 
@@ -978,8 +978,8 @@ struct bfq_group {
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
-	struct bfq_queue *async_idle_bfqq;
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_NUM_ACTUATORS];
+	struct bfq_queue *async_idle_bfqq[BFQ_NUM_ACTUATORS];
 
 	struct rb_root rq_pos_tree;
 };
-- 
2.20.1

