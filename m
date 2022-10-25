Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F67B60CF99
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiJYOvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiJYOvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:51:41 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375CD1A1B22
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:51:40 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b11so4972734pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bw7Z4RPMjDlTxfP4goNyQMmLIpU75uA8NpA0GGnvc1U=;
        b=a+CBb66sbj/Sz7N6QD3LS0g4wzZIu36Wff1DAp/4R6CHM51XXrgt3G/ReeeyqfhQXo
         lU7Ln7fxIHwTcoII7sG7oxtibSdW7/F4TFwDDV4o+tfi4ksSR5Zk3hqBrfu7QrTNo+N4
         Q9tZT04kbu9dFMGvEH7Xm/QZEj9Xi7mrq2Pba+vLo7ouPPiiJixb25LsbqK/IqhuS+Ex
         y9YsldAAinuYOFi9tjLA0mzgnV//NrT6V1DOA8cAlIs3BNjC4RvAPDm692+I0hcS+MyN
         H4Hcf18wj7JWAETiaWA8MsuzK7CRTjw81LXiOVt0KPq755/vc5To8c7WulgTnF3OfijI
         ySwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bw7Z4RPMjDlTxfP4goNyQMmLIpU75uA8NpA0GGnvc1U=;
        b=HdN2vFG2SvNkzTQWhQx/ePcaOGsoswQreSwndHp2D+KvkXjU6Ocw5ERmXVct3DiieU
         KarPzSnmolNvHwt+rBstD3lTaVeDN2O90c+oDY0RN6VqzhXXHl076zS81ymM02U1ie8t
         t5n3S1+QZpnjmeW+yxNFeAPhLEAx93FuPrv+dw+qDtR4rbJ02cp0n9hem+SG2lIbBr9e
         btz+YAV3X8sfD9xkHui1SdnwemBEn1Y7v+UvVh/qqvSnWsqgVxiYgE8Zu7j9RynKIlIp
         bSN57sVg3fIU6PnNK/VdtbE4fCiltKe5qeN52sCdeHqkk13uPepnYBBd4rzJPf1HxdPk
         7N6Q==
X-Gm-Message-State: ACrzQf0R4KMTyWQ4y2gkTrg/BV3WhEuoBmYy+uATHmeD6qPcpjHoP5rU
        ikmTS2QKeNwFYpIWtFqbMwfj
X-Google-Smtp-Source: AMsMyM4AdyvwaIhdFc6WozhcvN3dJoB+2G6kQfzqZ+F6COvPU2adFuHNtkn1Zp6uGiNTUusmMvK/Bw==
X-Received: by 2002:a17:90a:cf06:b0:212:d9ab:811b with SMTP id h6-20020a17090acf0600b00212d9ab811bmr23939171pju.65.1666709499611;
        Tue, 25 Oct 2022 07:51:39 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.236])
        by smtp.gmail.com with ESMTPSA id n14-20020a170903110e00b00180cf894b67sm1318765plh.130.2022.10.25.07.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:51:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 5/5] PCI: endpoint: Use link_up() callback in place of LINK_UP notifier
Date:   Tue, 25 Oct 2022 20:21:01 +0530
Message-Id: <20221025145101.116393-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
References: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a part of the transition towards callback mechanism for signalling the
events from EPC to EPF, let's use the link_up() callback in the place of
the LINK_UP notifier. This also removes the notifier support completely
from the PCI endpoint framework.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 33 ++++++-------------
 drivers/pci/endpoint/pci-epc-core.c           | 12 +++++--
 include/linux/pci-epc.h                       |  8 -----
 include/linux/pci-epf.h                       |  8 ++---
 4 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 868de17e1ad2..f75045f2dee3 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -826,30 +826,21 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 	return 0;
 }
 
-static const struct pci_epc_event_ops pci_epf_test_event_ops = {
-	.core_init = pci_epf_test_core_init,
-};
-
-static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
-				 void *data)
+int pci_epf_test_link_up(struct pci_epf *epf)
 {
-	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 
-	switch (val) {
-	case LINK_UP:
-		queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
-				   msecs_to_jiffies(1));
-		break;
-
-	default:
-		dev_err(&epf->dev, "Invalid EPF test notifier event\n");
-		return NOTIFY_BAD;
-	}
+	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
+			   msecs_to_jiffies(1));
 
-	return NOTIFY_OK;
+	return 0;
 }
 
+static const struct pci_epc_event_ops pci_epf_test_event_ops = {
+	.core_init = pci_epf_test_core_init,
+	.link_up = pci_epf_test_link_up,
+};
+
 static int pci_epf_test_alloc_space(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
@@ -976,12 +967,8 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		epf_test->dma_supported = false;
 
-	if (linkup_notifier || core_init_notifier) {
-		epf->nb.notifier_call = pci_epf_test_notifier;
-		pci_epc_register_notifier(epc, &epf->nb);
-	} else {
+	if (!linkup_notifier && !core_init_notifier)
 		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
-	}
 
 	return 0;
 }
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 8bb60528f530..c0954fddcc14 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -690,10 +690,19 @@ EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
  */
 void pci_epc_linkup(struct pci_epc *epc)
 {
+	struct pci_epf *epf;
+
 	if (!epc || IS_ERR(epc))
 		return;
 
-	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
+	mutex_lock(&epc->list_lock);
+	list_for_each_entry(epf, &epc->pci_epf, list) {
+		mutex_lock(&epf->lock);
+		if (epf->event_ops && epf->event_ops->link_up)
+			epf->event_ops->link_up(epf);
+		mutex_unlock(&epf->lock);
+	}
+	mutex_unlock(&epc->list_lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkup);
 
@@ -784,7 +793,6 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 	mutex_init(&epc->lock);
 	mutex_init(&epc->list_lock);
 	INIT_LIST_HEAD(&epc->pci_epf);
-	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
 
 	device_initialize(&epc->dev);
 	epc->dev.class = pci_epc_class;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index fe729dfe509b..301bb0e53707 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -135,7 +135,6 @@ struct pci_epc_mem {
  * @group: configfs group representing the PCI EPC device
  * @lock: mutex to protect pci_epc ops
  * @function_num_map: bitmap to manage physical function number
- * @notifier: used to notify EPF of any EPC events (like linkup)
  */
 struct pci_epc {
 	struct device			dev;
@@ -151,7 +150,6 @@ struct pci_epc {
 	/* mutex to protect against concurrent access of EP controller */
 	struct mutex			lock;
 	unsigned long			function_num_map;
-	struct atomic_notifier_head	notifier;
 };
 
 /**
@@ -194,12 +192,6 @@ static inline void *epc_get_drvdata(struct pci_epc *epc)
 	return dev_get_drvdata(&epc->dev);
 }
 
-static inline int
-pci_epc_register_notifier(struct pci_epc *epc, struct notifier_block *nb)
-{
-	return atomic_notifier_chain_register(&epc->notifier, nb);
-}
-
 struct pci_epc *
 __devm_pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 		      struct module *owner);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index a06f3b4c8bee..bc613f0df7e3 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -17,10 +17,6 @@
 struct pci_epf;
 enum pci_epc_interface_type;
 
-enum pci_notify_event {
-	LINK_UP,
-};
-
 enum pci_barno {
 	NO_BAR = -1,
 	BAR_0,
@@ -74,9 +70,11 @@ struct pci_epf_ops {
 /**
  * struct pci_epf_event_ops - Callbacks for capturing the EPC events
  * @core_init: Callback for the EPC initialization complete event
+ * @link_up: Callback for the EPC link up event
  */
 struct pci_epc_event_ops {
 	int (*core_init)(struct pci_epf *epf);
+	int (*link_up)(struct pci_epf *epf);
 };
 
 /**
@@ -135,7 +133,6 @@ struct pci_epf_bar {
  * @driver: the EPF driver to which this EPF device is bound
  * @id: Pointer to the EPF device ID
  * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
- * @nb: notifier block to notify EPF of any EPC events (like linkup)
  * @lock: mutex to protect pci_epf_ops
  * @sec_epc: the secondary EPC device to which this EPF device is bound
  * @sec_epc_list: to add pci_epf as list of PCI endpoint functions to secondary
@@ -164,7 +161,6 @@ struct pci_epf {
 	struct pci_epf_driver	*driver;
 	const struct pci_epf_device_id *id;
 	struct list_head	list;
-	struct notifier_block   nb;
 	/* mutex to protect against concurrent access of pci_epf_ops */
 	struct mutex		lock;
 
-- 
2.25.1

