Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAA66B89D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 05:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCNEq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 00:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCNEqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 00:46:53 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFBA5FA58
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 21:46:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cn6so1607897pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 21:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678769203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CebAT6G7pMdHj4gkjeeBHR/+GUK4hl9hBpqAKTE774=;
        b=FgMOxdg4dDWnSfrnTfGPhTA5M1vKWe4fy2jD+/oVY5VI27AEDiZhPu06FUJRVCCCKw
         RG26JdNLbhv8CAREUDAZ6SZy8VvdBbOrdFqVHgo77k7wvNtq77toKuWJ/+tR/TURzm/u
         q5l6qj9sRzoRBb9MjumS3m7CeVYVogI1kvoACxtvxmetYhd09LMI6CSj1Q3b9bxbH1fT
         jgwZ32AvdfJvXn21wJ7j1b8fKA+PJWsm+gRUF2tH05jMMm3r62K3sfRb5p4C4IJPmjp/
         32adKedKxjObDwBAZff1MfJSkNVFREBCAi9Y89Kgia0DVn/amb6FfBSwsDprTR1FNrfP
         7twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678769203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CebAT6G7pMdHj4gkjeeBHR/+GUK4hl9hBpqAKTE774=;
        b=OQkV1G8Xdh+6MMUZ+RvawkBVicI2BzI9xFYMhXyl7FZmBMb6CW/eb4uFBB2lZqabaT
         rpT83k+yU1xkfrvDhlTn/9Ds4fk4+F3RZII7fo4yoUVNoMvHOZ2peIwQTzGn0MT24bXj
         1aISaKHg3EX/WZC8ZQuZF5+9mjUBqhvtD0es10bHLGyp+YXwI/pk24yj1wOpEK/3kMrq
         O/xdAwkdBUtDZvjt7tcDPFWkyLaC0R42vNHnPTJkcTqyxtgKl8m/aFZwAx4InLiGqVPZ
         4UFb51M62GEigWmvKtKffotOMMcr0321/FcRyYR6/HtxBUD9nDSZVeVcPUrS6gnNwdS1
         1Q5w==
X-Gm-Message-State: AO0yUKUM1DlZd0btnwXUEx8Ex+j56HtiIjBXic/e+q73vB8tm+EqcoFz
        3PakTekvyEy13qyuy+YUGzKK
X-Google-Smtp-Source: AK7set9a2BdntGr5M+RdWZ8NYVIVa/I2q5l3ypxOz9a6dtZZoLbiWS4smqDpkipmlACYEa0ZVSaprA==
X-Received: by 2002:a17:903:32cf:b0:19a:8e52:ce0 with SMTP id i15-20020a17090332cf00b0019a8e520ce0mr42868896plr.58.1678769203156;
        Mon, 13 Mar 2023 21:46:43 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id lh13-20020a170903290d00b0019c2b1c4ad4sm690125plb.6.2023.03.13.21.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 21:46:42 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/7] PCI: endpoint: Add linkdown notifier support
Date:   Tue, 14 Mar 2023 10:16:19 +0530
Message-Id: <20230314044623.10254-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314044623.10254-1-manivannan.sadhasivam@linaro.org>
References: <20230314044623.10254-1-manivannan.sadhasivam@linaro.org>
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

Add support to notify the EPF device about the linkdown event from the
EPC device.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 26 ++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 9440d9811eea..e3a6b5554c1c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -706,6 +706,32 @@ void pci_epc_linkup(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkup);
 
+/**
+ * pci_epc_linkdown() - Notify the EPF device that EPC device has dropped the
+ *			connection with the Root Complex.
+ * @epc: the EPC device which has dropped the link with the host
+ *
+ * Invoke to Notify the EPF device that the EPC device has dropped the
+ * connection with the Root Complex.
+ */
+void pci_epc_linkdown(struct pci_epc *epc)
+{
+	struct pci_epf *epf;
+
+	if (!epc || IS_ERR(epc))
+		return;
+
+	mutex_lock(&epc->list_lock);
+	list_for_each_entry(epf, &epc->pci_epf, list) {
+		mutex_lock(&epf->lock);
+		if (epf->event_ops && epf->event_ops->link_down)
+			epf->event_ops->link_down(epf);
+		mutex_unlock(&epf->lock);
+	}
+	mutex_unlock(&epc->list_lock);
+}
+EXPORT_SYMBOL_GPL(pci_epc_linkdown);
+
 /**
  * pci_epc_init_notify() - Notify the EPF device that EPC device's core
  *			   initialization is completed.
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 301bb0e53707..63a6cc5e5282 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -203,6 +203,7 @@ void pci_epc_destroy(struct pci_epc *epc);
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 		    enum pci_epc_interface_type type);
 void pci_epc_linkup(struct pci_epc *epc);
+void pci_epc_linkdown(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index bc613f0df7e3..f8e5a63d0c83 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -71,10 +71,12 @@ struct pci_epf_ops {
  * struct pci_epf_event_ops - Callbacks for capturing the EPC events
  * @core_init: Callback for the EPC initialization complete event
  * @link_up: Callback for the EPC link up event
+ * @link_down: Callback for the EPC link down event
  */
 struct pci_epc_event_ops {
 	int (*core_init)(struct pci_epf *epf);
 	int (*link_up)(struct pci_epf *epf);
+	int (*link_down)(struct pci_epf *epf);
 };
 
 /**
-- 
2.25.1

