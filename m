Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE3D5B65ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIMDAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiIMDAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:00:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CBB140A9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 20:00:06 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MRSlm56VHzmVGh;
        Tue, 13 Sep 2022 10:56:20 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 11:00:04 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 13 Sep
 2022 11:00:03 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <ogabbay@kernel.org>
Subject: [PATCH -next v2] habanalabs/gaudi2: fix free irq in error path in gaudi2_enable_msix()
Date:   Tue, 13 Sep 2022 11:07:14 +0800
Message-ID: <20220913030714.974259-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two variables to store completion irq and event queue irq. And add
a new lable to free event queue irq in error path in gaudi2_enable_msix().

Fixes: d7bb1ac89b2f ("habanalabs: add gaudi2 asic-specific code")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v2:
  print correct irq in error prints.
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 98336a1a84b0..8f521d8a1aa1 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -3518,6 +3518,7 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
 	int rc, irq, i, j, user_irq_init_cnt;
+	int completion_irq, event_queue_irq;
 	irq_handler_t irq_handler;
 	struct hl_cq *cq;
 
@@ -3532,26 +3533,28 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
 		return rc;
 	}
 
-	irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
+	completion_irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
 	cq = &hdev->completion_queue[GAUDI2_RESERVED_CQ_CS_COMPLETION];
-	rc = request_irq(irq, hl_irq_handler_cq, 0, gaudi2_irq_name(GAUDI2_IRQ_NUM_COMPLETION), cq);
+	rc = request_irq(completion_irq, hl_irq_handler_cq, 0,
+			 gaudi2_irq_name(GAUDI2_IRQ_NUM_COMPLETION), cq);
 	if (rc) {
-		dev_err(hdev->dev, "Failed to request IRQ %d", irq);
+		dev_err(hdev->dev, "Failed to request IRQ %d", completion_irq);
 		goto free_irq_vectors;
 	}
 
-	irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_EVENT_QUEUE);
-	rc = request_irq(irq, hl_irq_handler_eq, 0, gaudi2_irq_name(GAUDI2_IRQ_NUM_EVENT_QUEUE),
-			&hdev->event_queue);
+	event_queue_irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_EVENT_QUEUE);
+	rc = request_irq(event_queue_irq, hl_irq_handler_eq, 0,
+			 gaudi2_irq_name(GAUDI2_IRQ_NUM_EVENT_QUEUE),
+			 &hdev->event_queue);
 	if (rc) {
-		dev_err(hdev->dev, "Failed to request IRQ %d", irq);
+		dev_err(hdev->dev, "Failed to request IRQ %d", event_queue_irq);
 		goto free_completion_irq;
 	}
 
 	rc = gaudi2_dec_enable_msix(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to enable decoder IRQ");
-		goto free_completion_irq;
+		goto free_event_queue_irq;
 	}
 
 	for (i = GAUDI2_IRQ_NUM_USER_FIRST, j = prop->user_dec_intr_count, user_irq_init_cnt = 0;
@@ -3582,9 +3585,11 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
 
 	gaudi2_dec_disable_msix(hdev, GAUDI2_IRQ_NUM_SHARED_DEC1_ABNRM + 1);
 
+free_event_queue_irq:
+	free_irq(event_queue_irq, &hdev->event_queue);
+
 free_completion_irq:
-	irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
-	free_irq(irq, cq);
+	free_irq(completion_irq, cq);
 
 free_irq_vectors:
 	pci_free_irq_vectors(hdev->pdev);
-- 
2.25.1

