Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B632F62DF1F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbiKQPJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240285AbiKQPIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:08:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0711E7721F;
        Thu, 17 Nov 2022 07:08:08 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697686;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U0EA+g4Bcyz2I47A6x9+qV6VZ1P347eeX/eR5+TVmlc=;
        b=oLdys8GrKc1rBQWSF81TyiXDk1FW3/Mpborfl6iOC6ihd5p8cQP3LIvikCv1y9om198Egm
        1lwJ3s04SeztseFpjlv+VYOCvHueoMnfx9Sre212VmJCbshKgYT8Y3dR8JuaCk/gffgxuS
        sYF6DX8wErU928PPLrOKhBDxXokPG7Y0uWQoUY6plGu12iohYHZdD13yzuJ428SsQnH12D
        +AajRqUkOtEmGuM2RUFJpYiaC+99PZIkd2eU0NhcIwuz80SXY6qvITscT8EstNqWMeWUiD
        WZsX3AWIzA9AriToMRo+byQ1Q8KYJbs/h7sPG8NYEiHf5tqGGFy6NL1WWlQdyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697686;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U0EA+g4Bcyz2I47A6x9+qV6VZ1P347eeX/eR5+TVmlc=;
        b=jTQUljMiEQonEh0A1SUtxKm1P2jpyyYx7CKlYAlqA606+UxM8/luK7cXsjJKJyadEWKd2F
        N1h5Z2VAIF6BmmAg==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Move pci_msix_vec_count() to api.c
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122015.099461602@linutronix.de>
References: <20221111122015.099461602@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869768535.4906.5642923343631874738.tip-bot2@tip-bot2>
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

Commit-ID:     7b50f62776672e7b328455eddc90ceb01b64ac3e
Gitweb:        https://git.kernel.org/tip/7b50f62776672e7b328455eddc90ceb01b64ac3e
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:21 +01:00

PCI/MSI: Move pci_msix_vec_count() to api.c

To disentangle the maze in msi.c, all exported device-driver MSI APIs are
now to be grouped in one file, api.c.

Move pci_msix_vec_count() and make its kernel-doc comprehensive.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122015.099461602@linutronix.de


---
 drivers/pci/msi/api.c | 20 ++++++++++++++++++++
 drivers/pci/msi/msi.c | 20 --------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 2ff2a9c..83ea38f 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -60,6 +60,26 @@ void pci_disable_msi(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_disable_msi);
 
 /**
+ * pci_msix_vec_count() - Get number of MSI-X interrupt vectors on device
+ * @dev: the PCI device to operate on
+ *
+ * Return: number of MSI-X interrupt vectors available on this device
+ * (i.e., the device's MSI-X capability structure "table size"), -EINVAL
+ * if the device is not MSI-X capable, other errnos otherwise.
+ */
+int pci_msix_vec_count(struct pci_dev *dev)
+{
+	u16 control;
+
+	if (!dev->msix_cap)
+		return -EINVAL;
+
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
+	return msix_table_size(control);
+}
+EXPORT_SYMBOL(pci_msix_vec_count);
+
+/**
  * pci_enable_msix_range() - Enable MSI-X interrupt mode on device
  * @dev:     the PCI device to operate on
  * @entries: input/output parameter, array of MSI-X configuration entries
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index ed8caf5..1226d66 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -701,26 +701,6 @@ void pci_msi_shutdown(struct pci_dev *dev)
 	pcibios_alloc_irq(dev);
 }
 
-/**
- * pci_msix_vec_count - return the number of device's MSI-X table entries
- * @dev: pointer to the pci_dev data structure of MSI-X device function
- * This function returns the number of device's MSI-X table entries and
- * therefore the number of MSI-X vectors device is capable of sending.
- * It returns a negative errno if the device is not capable of sending MSI-X
- * interrupts.
- **/
-int pci_msix_vec_count(struct pci_dev *dev)
-{
-	u16 control;
-
-	if (!dev->msix_cap)
-		return -EINVAL;
-
-	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
-	return msix_table_size(control);
-}
-EXPORT_SYMBOL(pci_msix_vec_count);
-
 static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
 			     int nvec, struct irq_affinity *affd, int flags)
 {
