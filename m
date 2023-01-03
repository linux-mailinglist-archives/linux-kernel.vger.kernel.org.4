Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8D165C261
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbjACOz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbjACOzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:55:32 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D86FD19
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:55:31 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qk9so74210019ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia/o1TRvqYroHXBLDuv3zNcB1AlF7EjIkmp8+qRWGx4=;
        b=Q2mLTn6+vYMncdNXqI5oGBQzLnF1xJQkxcfDAugyWiA49wdfTot4RxgErceq75Q4op
         RY0qfQh4a4OWsf6t2/sgKDEZ1yWUex5qEXKFEJBS0GLcjI0Wq4OOcfoOSxxy5vUiIwCf
         l9adK9xHEsxCZpBDrO9nCT7sdK3s6QcK76IlF8mbjPHmx7C605YXBCGhomed1nM8E/l3
         Vb5Qb67AMKKSfeORtnKqCbibFdVP2wqgt9kEh3H3Kuo/rDYHcYckUzvKe5ASn5DZRPrs
         IxSRwDZYP1AmYtUM5OrP0kDApvIJpZG5+z7jxq8l6PCRU2bhw/2pTfGua/T2RoXmXCAb
         1D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ia/o1TRvqYroHXBLDuv3zNcB1AlF7EjIkmp8+qRWGx4=;
        b=AkNme/p4RBxOTvhw9S97yqC7FWCc1hFb1QKYwal99usWojjxPnvXgz2z3ij0XrKgZD
         +5T+NqjDdiZ8ZY83wDLItr6v/b8cbRdE+sTAu/gVB1ev1Urrbxg2lIMncGLLCStUrB0K
         RTAeYQIQ1CLPBrCe18ynbUeP/jLcqYQb0Gy15yG+l9nL8/AbjeG2XWipatDaKwR6+LBV
         vcKKLuIKa0visVabD8ItHs1LVi1yagkoGOyxn/7Wb1nUy9umKL/SJ7B8ggEwG1kL6zGb
         UJOcqinll2Od4CipRMnU/OVIyKvnjjAosGtrTS1gxxgYKsdxoR3vax2PLqDGwu4j6Wv3
         9lAA==
X-Gm-Message-State: AFqh2ko4uVIMBCGlQzFGEBdDbdzCA/ofkQckURBbQyJ6zOylaIz5DLhp
        TUvbnlsHSmHmRaCBUyw+Z7ZSOA==
X-Google-Smtp-Source: AMrXdXvHwQTTBT6srp/7zJbFaMc2hyL9cAdnyfpOaZTMTIx1yJNZ4L+e6sIYRZrpo5De+rVq+P2NpA==
X-Received: by 2002:a17:906:1ccc:b0:7c0:d88b:4323 with SMTP id i12-20020a1709061ccc00b007c0d88b4323mr33040365ejh.61.1672757729794;
        Tue, 03 Jan 2023 06:55:29 -0800 (PST)
Received: from localhost.localdomain (mob-5-91-46-2.net.vodafone.it. [5.91.46.2])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090604d100b007c16fdc93ddsm14122595eja.81.2023.01.03.06.55.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2023 06:55:29 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V13 REBASED 5/8] block, bfq: split also async bfq_queues on a per-actuator basis
Date:   Tue,  3 Jan 2023 15:55:00 +0100
Message-Id: <20230103145503.71712-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230103145503.71712-1-paolo.valente@linaro.org>
References: <20230103145503.71712-1-paolo.valente@linaro.org>
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

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Davide Zini <davidezini2@gmail.com>
---
 block/bfq-iosched.c | 41 +++++++++++++++++++++++------------------
 block/bfq-iosched.h |  8 ++++----
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9675a32af0f4..0859981726ac 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2620,14 +2620,16 @@ static void bfq_bfqq_end_wr(struct bfq_queue *bfqq)
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
@@ -5575,18 +5577,18 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
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
@@ -5759,7 +5761,8 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 	bfqg = bfq_bio_bfqg(bfqd, bio);
 	if (!is_sync) {
 		async_bfqq = bfq_async_queue_prio(bfqd, bfqg, ioprio_class,
-						  ioprio);
+						  ioprio,
+						  bfq_actuator_index(bfqd, bio));
 		bfqq = *async_bfqq;
 		if (bfqq)
 			goto out;
@@ -6982,13 +6985,15 @@ static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
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
index 5a6f888930ad..de2b2af643e5 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -980,8 +980,8 @@ struct bfq_group {
 
 	struct bfq_data *bfqd;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
-	struct bfq_queue *async_idle_bfqq;
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_MAX_ACTUATORS];
+	struct bfq_queue *async_idle_bfqq[BFQ_MAX_ACTUATORS];
 
 	struct bfq_entity *my_entity;
 
@@ -998,8 +998,8 @@ struct bfq_group {
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

