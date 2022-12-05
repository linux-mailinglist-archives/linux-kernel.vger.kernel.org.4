Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A2C643042
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiLES1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiLESZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4404520BF1;
        Mon,  5 Dec 2022 10:25:18 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XR2b+oBEkv1IoXrZjbS0CUasH3iptsRSfKUf738Nkqk=;
        b=03QieEaPCluMzVztArbmF05qjwgO+3Q+doVB29ta7daUcDeA5M00ZVP6+9PqrUIylRpsDA
        wTEHKkfsjcj7cOY3LvpvW/YikGJz2DVZYIi0xjuCKjL/lCL6syWjWy8cWA4iuxHbRPRTPS
        aeGlNNn7Sttn2PsZhFeoK2ILi1x6xPYLiVf0ShBZrymJ7Vvoq2A7r9TZr2GvnKz/w9JW+l
        M8Dv/g6J+imGStZ1k3DboJhKnHkw3V/XA1S6G+qyJZoLgvXogbPS8ZsMMAg2klBneNkK2U
        l071Skyn4IQ3kGIPKxQ15jrhci6FQDGo4XqKfyQJzaocp9ldpPDMZ6b93W6q/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XR2b+oBEkv1IoXrZjbS0CUasH3iptsRSfKUf738Nkqk=;
        b=usxJ0RaYG9gH6PTbeszm9lRG/MUP4tmqA6+pJKiqt3n6qpbd20HKnh/HMTDiwELsW4WBMC
        uOVDlW6+1WXZDRBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Split __pci_write_msi_msg()
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232325.857982142@linutronix.de>
References: <20221124232325.857982142@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471509.4906.8592924192716625387.tip-bot2@tip-bot2>
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

Commit-ID:     8bf5fb3f8fde23ae4ef69f0120f6cf56ad5a462d
Gitweb:        https://git.kernel.org/tip/8bf5fb3f8fde23ae4ef69f0120f6cf56ad5a462d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:02 +01:00

PCI/MSI: Split __pci_write_msi_msg()

The upcoming per device MSI domains will create different domains for MSI
and MSI-X. Split the write message function into MSI and MSI-X helpers so
they can be used by those new domain functions seperately.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232325.857982142@linutronix.de

---
 drivers/pci/msi/msi.c | 104 +++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 50 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index d107bde..76a3d44 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -180,6 +180,58 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 	}
 }
 
+static inline void pci_write_msg_msi(struct pci_dev *dev, struct msi_desc *desc,
+				     struct msi_msg *msg)
+{
+	int pos = dev->msi_cap;
+	u16 msgctl;
+
+	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
+	msgctl &= ~PCI_MSI_FLAGS_QSIZE;
+	msgctl |= desc->pci.msi_attrib.multiple << 4;
+	pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
+
+	pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO, msg->address_lo);
+	if (desc->pci.msi_attrib.is_64) {
+		pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,  msg->address_hi);
+		pci_write_config_word(dev, pos + PCI_MSI_DATA_64, msg->data);
+	} else {
+		pci_write_config_word(dev, pos + PCI_MSI_DATA_32, msg->data);
+	}
+	/* Ensure that the writes are visible in the device */
+	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
+}
+
+static inline void pci_write_msg_msix(struct msi_desc *desc, struct msi_msg *msg)
+{
+	void __iomem *base = pci_msix_desc_addr(desc);
+	u32 ctrl = desc->pci.msix_ctrl;
+	bool unmasked = !(ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
+
+	if (desc->pci.msi_attrib.is_virtual)
+		return;
+	/*
+	 * The specification mandates that the entry is masked
+	 * when the message is modified:
+	 *
+	 * "If software changes the Address or Data value of an
+	 * entry while the entry is unmasked, the result is
+	 * undefined."
+	 */
+	if (unmasked)
+		pci_msix_write_vector_ctrl(desc, ctrl | PCI_MSIX_ENTRY_CTRL_MASKBIT);
+
+	writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
+	writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
+	writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
+
+	if (unmasked)
+		pci_msix_write_vector_ctrl(desc, ctrl);
+
+	/* Ensure that the writes are visible in the device */
+	readl(base + PCI_MSIX_ENTRY_DATA);
+}
+
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
@@ -187,63 +239,15 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 	if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
 		/* Don't touch the hardware now */
 	} else if (entry->pci.msi_attrib.is_msix) {
-		void __iomem *base = pci_msix_desc_addr(entry);
-		u32 ctrl = entry->pci.msix_ctrl;
-		bool unmasked = !(ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
-
-		if (entry->pci.msi_attrib.is_virtual)
-			goto skip;
-
-		/*
-		 * The specification mandates that the entry is masked
-		 * when the message is modified:
-		 *
-		 * "If software changes the Address or Data value of an
-		 * entry while the entry is unmasked, the result is
-		 * undefined."
-		 */
-		if (unmasked)
-			pci_msix_write_vector_ctrl(entry, ctrl | PCI_MSIX_ENTRY_CTRL_MASKBIT);
-
-		writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
-		writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
-		writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
-
-		if (unmasked)
-			pci_msix_write_vector_ctrl(entry, ctrl);
-
-		/* Ensure that the writes are visible in the device */
-		readl(base + PCI_MSIX_ENTRY_DATA);
+		pci_write_msg_msix(entry, msg);
 	} else {
-		int pos = dev->msi_cap;
-		u16 msgctl;
-
-		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
-		msgctl &= ~PCI_MSI_FLAGS_QSIZE;
-		msgctl |= entry->pci.msi_attrib.multiple << 4;
-		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
-
-		pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO,
-				       msg->address_lo);
-		if (entry->pci.msi_attrib.is_64) {
-			pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,
-					       msg->address_hi);
-			pci_write_config_word(dev, pos + PCI_MSI_DATA_64,
-					      msg->data);
-		} else {
-			pci_write_config_word(dev, pos + PCI_MSI_DATA_32,
-					      msg->data);
-		}
-		/* Ensure that the writes are visible in the device */
-		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
+		pci_write_msg_msi(dev, entry, msg);
 	}
 
-skip:
 	entry->msg = *msg;
 
 	if (entry->write_msi_msg)
 		entry->write_msi_msg(entry, entry->write_msi_msg_data);
-
 }
 
 void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
