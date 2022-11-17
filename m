Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814C862DF18
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbiKQPJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240193AbiKQPIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:08:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DC874CE4;
        Thu, 17 Nov 2022 07:08:04 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697683;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UXKrLsTXnBxcU8Uuv7OZgp4g2eFKodzz2HJBzEFymVE=;
        b=KWu+Vi5dATEwS63ZzQ1/7bB50tKWU5uhbiuQ7w8X+laeD4SYP1zcoUbGLpIEIhIi23RzXS
        c3F/KK7o+7CfFxR/1Wpev4wt41s8TyoReG6QBmbDDZExHJWBsnKwSplwSWqWq2zkXqaLJB
        74kMPihH0bjeJYK3IkffUyTchJuZa2LEUI9Bw6Ii15L+RKYarAYGB1GWiejsABRpSNzEjL
        0ie1VPxpGz6vfNvVC2uOQfABmvsRvgNFiTg3BRWAhEXY7EGy/t+ILTnPbQQ1N9FoKTtSnL
        AEH3UuV4D30jrjuYOgpO4518niPdYt/fCZE59avIBvGS74ywvFxAI/Gll1P6ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697683;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UXKrLsTXnBxcU8Uuv7OZgp4g2eFKodzz2HJBzEFymVE=;
        b=gc4KsrymHXVkU7EKydbV1cFdfUuls+vXxHjZ8QeVYhidgKJTsibzKG/Ca6Zcd+HLmwKIAb
        ZB8z9X05ZGAhHoAQ==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Move pci_msi_enabled() to api.c
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122015.271447896@linutronix.de>
References: <20221111122015.271447896@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869768194.4906.4177814909795041412.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     897a0b6aa8c7ee0015e8d1f781e8e61069aafe16
Gitweb:        https://git.kernel.org/tip/897a0b6aa8c7ee0015e8d1f781e8e61069aafe16
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:55:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:21 +01:00

PCI/MSI: Move pci_msi_enabled() to api.c

To disentangle the maze in msi.c, all exported device-driver MSI APIs are
now to be grouped in one file, api.c.

Move pci_msi_enabled() and make its kernel-doc comprehensive.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122015.271447896@linutronix.de


---
 drivers/pci/msi/api.c | 12 ++++++++++++
 drivers/pci/msi/msi.c | 14 +-------------
 drivers/pci/msi/msi.h |  3 +++
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 93ddc55..49ae3a3 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -307,3 +307,15 @@ void pci_free_irq_vectors(struct pci_dev *dev)
 	pci_disable_msi(dev);
 }
 EXPORT_SYMBOL(pci_free_irq_vectors);
+
+/**
+ * pci_msi_enabled() - Are MSI(-X) interrupts enabled system-wide?
+ *
+ * Return: true if MSI has not been globally disabled through ACPI FADT,
+ * PCI bridge quirks, or the "pci=nomsi" kernel command-line option.
+ */
+int pci_msi_enabled(void)
+{
+	return pci_msi_enable;
+}
+EXPORT_SYMBOL(pci_msi_enabled);
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index d78646d..59c33bc 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -13,7 +13,7 @@
 #include "../pci.h"
 #include "msi.h"
 
-static int pci_msi_enable = 1;
+int pci_msi_enable = 1;
 int pci_msi_ignore_mask;
 
 void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
@@ -864,15 +864,3 @@ void pci_no_msi(void)
 {
 	pci_msi_enable = 0;
 }
-
-/**
- * pci_msi_enabled - is MSI enabled?
- *
- * Returns true if MSI has not been disabled by the command-line option
- * pci=nomsi.
- **/
-int pci_msi_enabled(void)
-{
-	return pci_msi_enable;
-}
-EXPORT_SYMBOL(pci_msi_enabled);
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 77e2587..f3f4ede 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -84,6 +84,9 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
 	return (1 << (1 << desc->pci.msi_attrib.multi_cap)) - 1;
 }
 
+/* Subsystem variables */
+extern int pci_msi_enable;
+
 /* MSI internal functions invoked from the public APIs */
 void pci_msi_shutdown(struct pci_dev *dev);
 void pci_msix_shutdown(struct pci_dev *dev);
