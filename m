Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E7E5F4019
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJDJnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiJDJm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:42:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBED522BFE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:40:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sd10so27670361ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zG87mohz6k0XA1QdodAbH2Cpuu/lMxi9cdgejBiMJhc=;
        b=whHSXOJv5IvqbNa0REEKKOp25OIK8cw23JVFfaHWCdxjYVxQ0IgOFLbvXEy6zUhNx9
         l1gsdUxIXdMtzwung4rt6t7VUFUQ9G3g+loFxfZZQktzmsR57L9T5NitLuYvMUeZK7r5
         xUnXTLAcN8eMZaebC/2DWtt/v7oGQw3r2EJQSyXR8o6kq4JUZbt4Vba20Q+vi2l6dY08
         jR8jW76mKoqWGLHsYVP9GujPLpZFRI6skTZ21AaTcNBQizhZTuayu9y4jaSQ3y5AyiGE
         O3TxQpVn7N/DTGQLLl3ksCFwbnk4zZZ6jabIADqztv7i/P/t5DjXK+wWIOiovk1p8aXV
         FP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zG87mohz6k0XA1QdodAbH2Cpuu/lMxi9cdgejBiMJhc=;
        b=ey27Jiw0keDw7yy+SlpqI+dLdYxwsnTtpo4XP9QQTEkafEGxQdbV4JnTnTtdPna/A0
         5RnJOPhn9kmS4E/lJswCTymwQAq0HcREJRbgrPdOT6HsQo+1eHcfyZ2v/KVfzwRopYt9
         noOnCV1+UZnDSylP2JS9JTK9hIcK+LRt7CTvglTdaTCP40BJr381A5IlC5qVsOvoexWz
         slERPeTmw3k+NTjiF9Uy3ibKgwnkNBNmyB7O3RpwEnktIF5kIC+EoG/aT+nYcrDfYT8e
         ISKMtG52Sw6b4TUqmaJIlZRutgcWfv7+g2iDhU8wJ6DSnuOxiVRnwyLudFj/aYstfrat
         sYug==
X-Gm-Message-State: ACrzQf0kNeFH/cf+Xqh5K1cnUyuXKwTFpFi0YamzIBmkOdiL7HOhgEHl
        RhGC/c4IImv2TVxj9lDX3lrEtg==
X-Google-Smtp-Source: AMsMyM4J+CS5sm9pShCLGc0AxUh/rglmeYSkVG99GpLn/CpcIVaMhURGTU+u+NUdhio1cOCTa76Qqg==
X-Received: by 2002:a17:907:b1b:b0:781:320f:b76c with SMTP id h27-20020a1709070b1b00b00781320fb76cmr18340780ejl.671.1664876421398;
        Tue, 04 Oct 2022 02:40:21 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906200900b00780f6071b5dsm6774853ejo.188.2022.10.04.02.40.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:40:21 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V3 4/8] block, bfq: split also async bfq_queues on a per-actuator basis
Date:   Tue,  4 Oct 2022 11:40:06 +0200
Message-Id: <20221004094010.80090-5-paolo.valente@linaro.org>
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
index dede0e948836..a1a5eea731c7 100644
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
index 0ff6be18f72a..a7808c6a2cbe 100644
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

