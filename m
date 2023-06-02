Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90627200C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbjFBLt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbjFBLth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:49:37 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C080E4D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:49:08 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5149e65c218so2865456a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 04:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685706516; x=1688298516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5f2NzEmcmTRcbM6hAaos0VU2nOjwvX3dKkaSzu4inyY=;
        b=YMZgY2r4p5PUODu7nF7gyQ1MAxc7lPnuJINS2nLNHjT4gvveXJWl7P1cdaS73QaSQB
         Lrmto9GuHgqdmS5PjiavOqOdzeBcdASij0ZJ05DLMxMAqp7Z0iik8IX5UbDDa3wpBSYP
         wKtA81bAhBMXhnKMNe+Cgc+aO2hEIZOyHk9EsCcV5kyxNwQTTcaW4Ez4CMZnqcrxfrAh
         B7+KN8pLOHpWaR2RQwXMqvEOuWNRc8wBa5z8OP4Sz9sjsBvv8AocVaJi1MX0f5Oef1x0
         0sGi+gE8AK1EVHjQ8LUw2FgjwjDtYtMjAe3ufCx/1G+no5eeOf8DxDUAOqHTgeI42f6Y
         g0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685706516; x=1688298516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5f2NzEmcmTRcbM6hAaos0VU2nOjwvX3dKkaSzu4inyY=;
        b=NMR5C0v342l90eMdn5uR6WDaSlUQSTs6KDPkedn9EPDm3ZrTEgLExZ9uVGgAXAYeHY
         nNqWHlijafeEUO5GcVAw2+yAGyIfTKRSPMCULR8cFomckXE0nZo35K0OfHFg9lPuZ3BT
         n+K7EUouLzpM2StSzg2EsSzhCAMFNJIfoLO69w+l0rNYOQOpw07tg1v6HRRClFBCF4Rw
         7BwkI1ufQY8kMdXK4T8WgxMuYGwfEkBf2cpm3EvmFn3ulHlt4YFZ8GyVVZ3/i7EinpLE
         UOxfFmMKNG9QBa2n1sNCC/MXsNt/HAiCPN73Eqo4Km5udhpdygIyGsCX0cLm6ppfKnya
         x/yA==
X-Gm-Message-State: AC+VfDxBtG9olxbT+4z8FpxVUO4b6oT2eX+nxtukgLVNQ0jUOzyHNLM5
        cb0QiMdsRpTDFuezdB6Q2kfq
X-Google-Smtp-Source: ACHHUZ6HLw8fdSjuXPHCuTEOgExHLw//KqfpW6dM2TxpwtcsemdxR/ONmFaQxgTjDx1MZaicvN+Hew==
X-Received: by 2002:a17:907:7e8c:b0:96f:c676:a917 with SMTP id qb12-20020a1709077e8c00b0096fc676a917mr11580346ejc.35.1685706516599;
        Fri, 02 Jun 2023 04:48:36 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.79])
        by smtp.gmail.com with ESMTPSA id qu25-20020a170907111900b00974530bb44dsm658924ejb.183.2023.06.02.04.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:48:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dlemoal@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 5/9] PCI: endpoint: Add BME notifier support
Date:   Fri,  2 Jun 2023 17:17:52 +0530
Message-Id: <20230602114756.36586-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to notify the EPF device about the Bus Master Enable (BME)
event received by the EPC device from the Root complex.

Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 26 ++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index e0570b52698d..6c54fa5684d2 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -758,6 +758,32 @@ void pci_epc_init_notify(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_init_notify);
 
+/**
+ * pci_epc_bme_notify() - Notify the EPF device that the EPC device has received
+ *			  the BME event from the Root complex
+ * @epc: the EPC device that received the BME event
+ *
+ * Invoke to Notify the EPF device that the EPC device has received the Bus
+ * Master Enable (BME) event from the Root complex
+ */
+void pci_epc_bme_notify(struct pci_epc *epc)
+{
+	struct pci_epf *epf;
+
+	if (!epc || IS_ERR(epc))
+		return;
+
+	mutex_lock(&epc->list_lock);
+	list_for_each_entry(epf, &epc->pci_epf, list) {
+		mutex_lock(&epf->lock);
+		if (epf->event_ops && epf->event_ops->bme)
+			epf->event_ops->bme(epf);
+		mutex_unlock(&epf->lock);
+	}
+	mutex_unlock(&epc->list_lock);
+}
+EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
+
 /**
  * pci_epc_destroy() - destroy the EPC device
  * @epc: the EPC device that has to be destroyed
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 63a6cc5e5282..5cb694031072 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -205,6 +205,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 void pci_epc_linkup(struct pci_epc *epc);
 void pci_epc_linkdown(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
+void pci_epc_bme_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
 int pci_epc_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index f8e5a63d0c83..f34b3b32a0e7 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -72,11 +72,13 @@ struct pci_epf_ops {
  * @core_init: Callback for the EPC initialization complete event
  * @link_up: Callback for the EPC link up event
  * @link_down: Callback for the EPC link down event
+ * @bme: Callback for the EPC BME (Bus Master Enable) event
  */
 struct pci_epc_event_ops {
 	int (*core_init)(struct pci_epf *epf);
 	int (*link_up)(struct pci_epf *epf);
 	int (*link_down)(struct pci_epf *epf);
+	int (*bme)(struct pci_epf *epf);
 };
 
 /**
-- 
2.25.1

