Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8793622C62
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKINae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKINac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:30:32 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC742019B;
        Wed,  9 Nov 2022 05:30:30 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id l2so17066227pld.13;
        Wed, 09 Nov 2022 05:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zjQRWzJpx4uKm8iJ+nIwVXHWHWl/OebEaK25zVjJp5Q=;
        b=TB5CBRdR1cxUTFU4q2BKdK/r/IgVOEn7j7WXhRTfQXCAog//OR02R5Y5AdictV23Mf
         ieGDdxxRmb001kcc1HKJ7+vftqkFtE/lF8VBSQfC2rpfcEIhJZ7myZ7yl1QFFwiRzPQu
         /EUtafTofOeOGreT2Q77N5LsVmxK5zcsqkND1eegFtik+XQWyFLy8Y/TvhrI2aA3aWbi
         tLYRnEBlqNXj05YZnvriK1nqBI1DD82GDiJuk/r0xPN3230/8p+7gBIg9/xRzuvjgEEi
         oBAMI/WWKOpzfQqzwlpoqiv8robdjOaumlffmFIadLNOTf2ni6I9xObd/SHDsDdgHX9K
         h/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjQRWzJpx4uKm8iJ+nIwVXHWHWl/OebEaK25zVjJp5Q=;
        b=EULZ9rYQdmttw6wPeyf6WYEjE4yPIevrACkMAKWY0T2C4RhhcO+9FEgfA6QoGuVAVd
         jdthT7ISkm6Z1F+cuDGWKdOIQnKF7wZsDIfFPmHubTl0QjZGSRQWnm+9QICUf7bKp3sk
         dPlFLLiwe/9UBdJwyuboGjt1aU6BrlQwxPiguDRc+B/FLaBRWj0beR/UW7JZRy6OXx8W
         9ynAT1zw5Ou/KMoGLTG5aONmE6r6M7K6o/zsaLM5p0F4bR2N5sPx6SH3cCncTKqj26VV
         H5Z9KERJ6l2ldS/B+p66vUQSdISL+Weq51+QriAOztqhXFO72GKiGdLwunagzbjf0X5X
         vkbQ==
X-Gm-Message-State: ACrzQf1C7QGjVEzUo+YElr8Jcc3/sWprN2So8SEU6PRMG99bk2u3zFZ7
        gcm02WT+M+hZZzDi7qP1UGU=
X-Google-Smtp-Source: AMsMyM5p34qVGjl3P9So08FjN2eZhuENoflAUFx/ZRx1RgCNlwD/BaKNYQl3qOIwiF+ngf2aoektaA==
X-Received: by 2002:a17:90b:1490:b0:212:68bf:fcc5 with SMTP id js16-20020a17090b149000b0021268bffcc5mr45099700pjb.52.1668000629769;
        Wed, 09 Nov 2022 05:30:29 -0800 (PST)
Received: from VirtualBox.. ([222.71.102.99])
        by smtp.gmail.com with ESMTPSA id w188-20020a627bc5000000b005672daedc8fsm8277118pfc.81.2022.11.09.05.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 05:30:29 -0800 (PST)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com, Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH] block, bfq: do the all counting of pending-request if CONFIG_BFQ_GROUP_IOSCHED is enabled
Date:   Wed,  9 Nov 2022 21:29:14 +0800
Message-Id: <20221109132914.438777-1-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'bfqd->num_groups_with_pending_reqs' is used when
CONFIG_BFQ_GROUP_IOSCHED is enabled, so let the variables and processes
take effect when ONFIG_BFQ_GROUP_IOSCHED is enabled.

Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 block/bfq-iosched.c |  5 ++++-
 block/bfq-iosched.h |  6 ++++++
 block/bfq-wf2q.c    | 10 ++++++----
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 2381cf220ba2..5a648433fd89 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6192,8 +6192,9 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 		 * mechanism).
 		 */
 		bfqq->budget_timeout = jiffies;
-
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 		bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
+#endif
 		bfq_weights_tree_remove(bfqq);
 	}
 
@@ -7051,7 +7052,9 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->idle_slice_timer.function = bfq_idle_slice_timer;
 
 	bfqd->queue_weights_tree = RB_ROOT_CACHED;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 	bfqd->num_groups_with_pending_reqs = 0;
+#endif
 
 	INIT_LIST_HEAD(&bfqd->active_list);
 	INIT_LIST_HEAD(&bfqd->idle_list);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 9fa89577322d..d6b9fad28a3b 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -197,8 +197,10 @@ struct bfq_entity {
 	/* flag, set to request a weight, ioprio or ioprio_class change  */
 	int prio_changed;
 
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 	/* flag, set if the entity is counted in groups_with_pending_reqs */
 	bool in_groups_with_pending_reqs;
+#endif
 
 	/* last child queue of entity created (for non-leaf entities) */
 	struct bfq_queue *last_bfqq_created;
@@ -491,6 +493,7 @@ struct bfq_data {
 	 */
 	struct rb_root_cached queue_weights_tree;
 
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 	/*
 	 * Number of groups with at least one process that
 	 * has at least one request waiting for completion. Note that
@@ -538,6 +541,7 @@ struct bfq_data {
 	 * with no request waiting for completion.
 	 */
 	unsigned int num_groups_with_pending_reqs;
+#endif
 
 	/*
 	 * Per-class (RT, BE, IDLE) number of bfq_queues containing
@@ -1074,8 +1078,10 @@ void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		      bool expiration);
 void bfq_del_bfqq_busy(struct bfq_queue *bfqq, bool expiration);
 void bfq_add_bfqq_busy(struct bfq_queue *bfqq);
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq);
 void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq);
+#endif
 
 /* --------------- end of interface of B-WF2Q+ ---------------- */
 
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index b02b53658ed4..a29187ecdc39 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1610,16 +1610,15 @@ void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 				    bfqq == bfqd->in_service_queue, expiration);
 }
 
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
 {
 	struct bfq_entity *entity = &bfqq->entity;
 
 	if (!entity->in_groups_with_pending_reqs) {
 		entity->in_groups_with_pending_reqs = true;
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
 		if (!(bfqq_group(bfqq)->num_queues_with_pending_reqs++))
 			bfqq->bfqd->num_groups_with_pending_reqs++;
-#endif
 	}
 }
 
@@ -1629,12 +1628,11 @@ void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
 
 	if (entity->in_groups_with_pending_reqs) {
 		entity->in_groups_with_pending_reqs = false;
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
 		if (!(--bfqq_group(bfqq)->num_queues_with_pending_reqs))
 			bfqq->bfqd->num_groups_with_pending_reqs--;
-#endif
 	}
 }
+#endif
 
 /*
  * Called when the bfqq no longer has requests pending, remove it from
@@ -1659,7 +1657,9 @@ void bfq_del_bfqq_busy(struct bfq_queue *bfqq, bool expiration)
 	bfq_deactivate_bfqq(bfqd, bfqq, true, expiration);
 
 	if (!bfqq->dispatched) {
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 		bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
+#endif
 		/*
 		 * Next function is invoked last, because it causes bfqq to be
 		 * freed. DO NOT use bfqq after the next function invocation.
@@ -1683,7 +1683,9 @@ void bfq_add_bfqq_busy(struct bfq_queue *bfqq)
 	bfqd->busy_queues[bfqq->ioprio_class - 1]++;
 
 	if (!bfqq->dispatched) {
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 		bfq_add_bfqq_in_groups_with_pending_reqs(bfqq);
+#endif
 		if (bfqq->wr_coeff == 1)
 			bfq_weights_tree_add(bfqq);
 	}
-- 
2.34.1

