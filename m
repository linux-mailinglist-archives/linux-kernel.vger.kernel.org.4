Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C6D5B455A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiIJJFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIJJFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:05:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C135E559
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:05:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso3410501wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=b98/tdiTwcvqr19Hh3b2b2FTs+schd1Q4q9W1vv+i7w=;
        b=ohJS3hlCgdsZHY3kYb3U5BKU2/re/UNPkN9oF6OlLGO8sqrImlo8onawrAwuQhqnjK
         hjPX8ycYVFwYyY0uXf5KAOkfL5FE+5oiw7AwDe0vuR7OsdAltEtS+tq2d1vWpjbNJSZW
         k68fQ8hL3lJcA5mTpLH/0lSlfA+21eFkoTOlzF1Dn8zyNpNm9zI4qEinxg0Q3DvlAYHw
         DurNCNO/Tw6mngJtG4K1PEM5UYgkXfhDeys1Ttr61fghb6wACmKw2mnT1PKNJ5D09LXj
         ZGQlRYCXNoDPdi6LkLwFM6DJZqBmCZXuPi+1w37U5fk8CntzcFH6dUxpv/6DxwQ4xWhd
         q8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=b98/tdiTwcvqr19Hh3b2b2FTs+schd1Q4q9W1vv+i7w=;
        b=ZaFeUtrspWRifa8F9go2UdOc+guJt0bf+4M3jgFa0vsxiFz+HO0iL7rA1FQJmVixhw
         n1xM9kIVPyinoV3xVm/3r8l+Wjnn0f3EeDe8cVhy5CZnFbsT5rXjbi8x8U3XUmhhS75O
         IhCMCOSgybECIzyLglS4se8q6GtxXQLQcKF8iDqQ2cXzrgbOa0p8yFVlJUOjkgnoVm54
         9nuE8Ue/sP/ad/HB/B1h/slxPys3ATAnfymEPn96bR4OYQKxc+84C6hMd54Yut3Kn/wA
         A/WPxDZlZamefkPP9nVYNN5RLquhVRW3tZ+F2moH4Z70xw1UFI89c6DUlN5Fbx6NBHpG
         BV3Q==
X-Gm-Message-State: ACgBeo25V2McG4/o2TB7/dLL1rDC8dR9FXKaTI+VoilZkhEQm9RMiBP0
        ecSV8TzByXgcpzXSQKfuindW
X-Google-Smtp-Source: AA6agR4VCabiqZGHOihA6XufU8f13OMt9bFL0OCiGQoZ5lBepE/P6lsxg8w4Q38HSGAyDXQ2uFUnPg==
X-Received: by 2002:a05:600c:5028:b0:3a8:4349:153c with SMTP id n40-20020a05600c502800b003a84349153cmr7870930wmr.130.1662800733313;
        Sat, 10 Sep 2022 02:05:33 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id i81-20020a1c3b54000000b003a8418ee646sm3081677wma.12.2022.09.10.02.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 02:05:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     kw@linux.com, robh@kernel.org, vidyas@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/3] PCI: endpoint: Use callback mechanism for passing events from EPC to EPF
Date:   Sat, 10 Sep 2022 14:35:07 +0530
Message-Id: <20220910090508.61157-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910090508.61157-1-manivannan.sadhasivam@linaro.org>
References: <20220910090508.61157-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using the notifiers for passing the events from EPC to EPF,
let's introduce a callback based mechanism where the EPF drivers can
populate relevant callbacks for EPC events they want to subscribe.

The use of notifiers in kernel is not recommended if there is a real link
between the sender and receiver, like in this case. Also, the existing
atomic notifier forces the notification functions to be in atomic context
while the caller may be in non-atomic context. For instance, the two
in-kernel users of the notifiers, pcie-qcom and pcie-tegra194, both are
calling the notifier functions in non-atomic context (from threaded IRQ
handlers). This creates a sleeping in atomic context issue with the
existing EPF_TEST driver that calls the EPC APIs that may sleep.

For all these reasons, let's get rid of the notifier chains and use the
simple callback mechanism for signalling the events from EPC to EPF
drivers. This preserves the context of the caller and avoids the latency
of going through a separate interface for triggering the notifications.

As a first step of the transition, the core_init() callback is introduced
in this commit, that'll replace the existing CORE_INIT notifier used for
signalling the init complete event from EPC.

During the occurrence of the event, EPC will go over the list of EPF
drivers attached to it and will call the core_init() callback if available.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++-------
 drivers/pci/endpoint/pci-epc-core.c           | 11 ++++++++++-
 include/linux/pci-epf.h                       | 11 ++++++++++-
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index a6f906a96669..868de17e1ad2 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -826,20 +826,17 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 	return 0;
 }
 
+static const struct pci_epc_event_ops pci_epf_test_event_ops = {
+	.core_init = pci_epf_test_core_init,
+};
+
 static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
 				 void *data)
 {
 	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
-	int ret;
 
 	switch (val) {
-	case CORE_INIT:
-		ret = pci_epf_test_core_init(epf);
-		if (ret)
-			return NOTIFY_BAD;
-		break;
-
 	case LINK_UP:
 		queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
 				   msecs_to_jiffies(1));
@@ -1010,6 +1007,8 @@ static int pci_epf_test_probe(struct pci_epf *epf, const struct pci_epf_device_i
 
 	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
 
+	epf->event_ops = &pci_epf_test_event_ops;
+
 	epf_set_drvdata(epf, epf_test);
 	return 0;
 }
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 6cce430d431b..ba54f17ae06f 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -707,10 +707,19 @@ EXPORT_SYMBOL_GPL(pci_epc_linkup);
  */
 void pci_epc_init_notify(struct pci_epc *epc)
 {
+	struct pci_epf *epf;
+
 	if (!epc || IS_ERR(epc))
 		return;
 
-	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
+	mutex_lock(&epc->list_lock);
+	list_for_each_entry(epf, &epc->pci_epf, list) {
+		mutex_lock(&epf->lock);
+		if (epf->event_ops->core_init)
+			epf->event_ops->core_init(epf);
+		mutex_unlock(&epf->lock);
+	}
+	mutex_unlock(&epc->list_lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_init_notify);
 
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 0c94cc1513bc..a06f3b4c8bee 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -18,7 +18,6 @@ struct pci_epf;
 enum pci_epc_interface_type;
 
 enum pci_notify_event {
-	CORE_INIT,
 	LINK_UP,
 };
 
@@ -72,6 +71,14 @@ struct pci_epf_ops {
 					struct config_group *group);
 };
 
+/**
+ * struct pci_epf_event_ops - Callbacks for capturing the EPC events
+ * @core_init: Callback for the EPC initialization complete event
+ */
+struct pci_epc_event_ops {
+	int (*core_init)(struct pci_epf *epf);
+};
+
 /**
  * struct pci_epf_driver - represents the PCI EPF driver
  * @probe: ops to perform when a new EPF device has been bound to the EPF driver
@@ -140,6 +147,7 @@ struct pci_epf_bar {
  * @is_vf: true - virtual function, false - physical function
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
+ * @event_ops: Callbacks for capturing the EPC events
  */
 struct pci_epf {
 	struct device		dev;
@@ -170,6 +178,7 @@ struct pci_epf {
 	unsigned int		is_vf;
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
+	const struct pci_epc_event_ops *event_ops;
 };
 
 /**
-- 
2.25.1

