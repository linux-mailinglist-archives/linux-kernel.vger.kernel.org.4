Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCD462ED49
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 06:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiKRFsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 00:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiKRFr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:47:58 -0500
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C254AF09;
        Thu, 17 Nov 2022 21:47:53 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1468061|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00347335-0.000155753-0.996371;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.QAMPFOU_1668750470;
Received: from SunxiBot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.QAMPFOU_1668750470)
          by smtp.aliyun-inc.com;
          Fri, 18 Nov 2022 13:47:51 +0800
From:   Michael Wu <michael@allwinnertech.com>
To:     ulf.hansson@linaro.org, wenchao.chen@unisoc.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc:mmc-hsq:use fifo to dispatch mmc_request
Date:   Fri, 18 Nov 2022 13:47:25 +0800
Message-Id: <20221118054725.80414-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current next_tag selection will cause a large delay in some requests and
destroy the scheduling results of the block scheduling layer. Because the
issued mrq tags cannot ensure that each time is sequential, especially when
the IO load is heavy. In the fio performance test, we found that 4k random
read data was sent to mmc_hsq to start calling request_atomic It takes
nearly 200ms to process the request, while mmc_hsq has processed thousands
of other requests. So we use fifo here to ensure the first in, first out
feature of the request and avoid adding additional delay to the request.

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 drivers/mmc/host/mmc_hsq.c | 40 ++++++++++++++------------------------
 drivers/mmc/host/mmc_hsq.h |  5 +++++
 2 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index 9d35453e7371..d2a1a96ed5bd 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -13,9 +13,6 @@
 
 #include "mmc_hsq.h"
 
-#define HSQ_NUM_SLOTS	64
-#define HSQ_INVALID_TAG	HSQ_NUM_SLOTS
-
 static void mmc_hsq_retry_handler(struct work_struct *work)
 {
 	struct mmc_hsq *hsq = container_of(work, struct mmc_hsq, retry_work);
@@ -73,7 +70,6 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 
 static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
 {
-	struct hsq_slot *slot;
 	int tag;
 
 	/*
@@ -82,29 +78,12 @@ static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
 	 */
 	if (!remains) {
 		hsq->next_tag = HSQ_INVALID_TAG;
+		hsq->tag_tail = HSQ_INVALID_TAG;
 		return;
 	}
 
-	/*
-	 * Increasing the next tag and check if the corresponding request is
-	 * available, if yes, then we found a candidate request.
-	 */
-	if (++hsq->next_tag != HSQ_INVALID_TAG) {
-		slot = &hsq->slot[hsq->next_tag];
-		if (slot->mrq)
-			return;
-	}
-
-	/* Othersie we should iterate all slots to find a available tag. */
-	for (tag = 0; tag < HSQ_NUM_SLOTS; tag++) {
-		slot = &hsq->slot[tag];
-		if (slot->mrq)
-			break;
-	}
-
-	if (tag == HSQ_NUM_SLOTS)
-		tag = HSQ_INVALID_TAG;
-
+	tag = hsq->tag_slot[hsq->next_tag];
+	hsq->tag_slot[hsq->next_tag] = HSQ_INVALID_TAG;
 	hsq->next_tag = tag;
 }
 
@@ -233,8 +212,14 @@ static int mmc_hsq_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	 * Set the next tag as current request tag if no available
 	 * next tag.
 	 */
-	if (hsq->next_tag == HSQ_INVALID_TAG)
+	if (hsq->next_tag == HSQ_INVALID_TAG) {
 		hsq->next_tag = tag;
+		hsq->tag_tail = tag;
+		hsq->tag_slot[hsq->tag_tail] = HSQ_INVALID_TAG;
+	} else {
+		hsq->tag_slot[hsq->tag_tail] = tag;
+		hsq->tag_tail = tag;
+	}
 
 	hsq->qcnt++;
 
@@ -339,8 +324,10 @@ static const struct mmc_cqe_ops mmc_hsq_ops = {
 
 int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
 {
+	int i;
 	hsq->num_slots = HSQ_NUM_SLOTS;
 	hsq->next_tag = HSQ_INVALID_TAG;
+	hsq->tag_tail = HSQ_INVALID_TAG;
 
 	hsq->slot = devm_kcalloc(mmc_dev(mmc), hsq->num_slots,
 				 sizeof(struct hsq_slot), GFP_KERNEL);
@@ -351,6 +338,9 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
 	hsq->mmc->cqe_private = hsq;
 	mmc->cqe_ops = &mmc_hsq_ops;
 
+	for (i = 0; i < HSQ_NUM_SLOTS; i++)
+		hsq->tag_slot[i] = HSQ_INVALID_TAG;
+
 	INIT_WORK(&hsq->retry_work, mmc_hsq_retry_handler);
 	spin_lock_init(&hsq->lock);
 	init_waitqueue_head(&hsq->wait_queue);
diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
index ffdd9cd172c3..a783366285a9 100644
--- a/drivers/mmc/host/mmc_hsq.h
+++ b/drivers/mmc/host/mmc_hsq.h
@@ -2,6 +2,9 @@
 #ifndef LINUX_MMC_HSQ_H
 #define LINUX_MMC_HSQ_H
 
+#define HSQ_NUM_SLOTS	64
+#define HSQ_INVALID_TAG	HSQ_NUM_SLOTS
+
 struct hsq_slot {
 	struct mmc_request *mrq;
 };
@@ -17,6 +20,8 @@ struct mmc_hsq {
 	int next_tag;
 	int num_slots;
 	int qcnt;
+	int tag_tail;
+	int tag_slot[HSQ_NUM_SLOTS];
 
 	bool enabled;
 	bool waiting_for_idle;
-- 
2.29.0

