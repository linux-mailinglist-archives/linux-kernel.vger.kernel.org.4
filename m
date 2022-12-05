Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389BC643054
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbiLES2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiLESZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC34E2124D;
        Mon,  5 Dec 2022 10:25:21 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264720;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8BhJMBOGAfhpi5lKYkdWInx8QY9zmvpuj0sqwlUK/84=;
        b=1+mTLT8ho0bOb9/lIOBxlLqO9WO2ElaqGrmWthK49NoP3Szew225SxT9N1YvGGMUnctuNM
        xSoijBIVuR3LZ6dhtslOUelVK+t7xayTRDrXb6JsypnJyffQLzmWGDbEzSUrZl6lwyIVO3
        XK6J2eanJxs/UmBRVFYhwPwMH4zNRZ9ATOei+RFuJ4P0btv2SLFNhs6qK6CZbDrQtnCZDy
        kelNmGiYSKiQ+QqzQhdSk/TXxkU+sH270GgQTGZRCcRTSoLK4ob86GEhJ2yBRgP7M8POFy
        cshcAYxSb6bqi1aW52GjQyViBQRxHeYKcsZW/OkUip013Qity4UNHk8OZ73JUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264720;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8BhJMBOGAfhpi5lKYkdWInx8QY9zmvpuj0sqwlUK/84=;
        b=Kz3Jrqqy7c9j5a0xEXiM+1akmMDjd0Km8MM2QZlO5d8CUFrrFZR+gmrTLG2DDe9r9K4+UE
        K/83YUCD+zBQy/BA==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Make msi_get_virq() device domain aware
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230314.044613697@linutronix.de>
References: <20221124230314.044613697@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471995.4906.14550334218511486751.tip-bot2@tip-bot2>
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

Commit-ID:     98043704f375f63a47efeff123ab92fcf34b95e6
Gitweb:        https://git.kernel.org/tip/98043704f375f63a47efeff123ab92fcf34b95e6
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:20:59 +01:00

genirq/msi: Make msi_get_virq() device domain aware

In preparation of the upcoming per device multi MSI domain support, change
the interface to support lookups based on domain id and zero based index
within the domain.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230314.044613697@linutronix.de

---
 include/linux/msi_api.h | 14 +++++++++++++-
 kernel/irq/msi.c        | 19 +++++++++++++------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/linux/msi_api.h b/include/linux/msi_api.h
index 4dbbce6..8640171 100644
--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -18,6 +18,18 @@ enum msi_domain_ids {
 	MSI_MAX_DEVICE_IRQDOMAINS,
 };
 
-unsigned int msi_get_virq(struct device *dev, unsigned int index);
+unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigned int index);
+
+/**
+ * msi_get_virq - Lookup the Linux interrupt number for a MSI index on the default interrupt domain
+ * @dev:	Device for which the lookup happens
+ * @index:	The MSI index to lookup
+ *
+ * Return: The Linux interrupt number on success (> 0), 0 if not found
+ */
+static inline unsigned int msi_get_virq(struct device *dev, unsigned int index)
+{
+	return msi_domain_get_virq(dev, MSI_DEFAULT_DOMAIN, index);
+}
 
 #endif
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index ec08d1f..e1593c1 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -337,26 +337,32 @@ struct msi_desc *msi_next_desc(struct device *dev, unsigned int domid,
 EXPORT_SYMBOL_GPL(msi_next_desc);
 
 /**
- * msi_get_virq - Return Linux interrupt number of a MSI interrupt
+ * msi_domain_get_virq - Lookup the Linux interrupt number for a MSI index on a interrupt domain
  * @dev:	Device to operate on
+ * @domid:	Domain ID of the interrupt domain associated to the device
  * @index:	MSI interrupt index to look for (0-based)
  *
  * Return: The Linux interrupt number on success (> 0), 0 if not found
  */
-unsigned int msi_get_virq(struct device *dev, unsigned int index)
+unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigned int index)
 {
 	struct msi_desc *desc;
 	unsigned int ret = 0;
+	bool pcimsi = false;
 	struct xarray *xa;
-	bool pcimsi;
 
 	if (!dev->msi.data)
 		return 0;
 
-	pcimsi = dev_is_pci(dev) ? to_pci_dev(dev)->msi_enabled : false;
+	if (WARN_ON_ONCE(index > MSI_MAX_INDEX || domid >= MSI_MAX_DEVICE_IRQDOMAINS))
+		return 0;
+
+	/* This check is only valid for the PCI default MSI domain */
+	if (dev_is_pci(dev) && domid == MSI_DEFAULT_DOMAIN)
+		pcimsi = to_pci_dev(dev)->msi_enabled;
 
 	msi_lock_descs(dev);
-	xa = &dev->msi.data->__domains[MSI_DEFAULT_DOMAIN].store;
+	xa = &dev->msi.data->__domains[domid].store;
 	desc = xa_load(xa, pcimsi ? 0 : index);
 	if (desc && desc->irq) {
 		/*
@@ -371,10 +377,11 @@ unsigned int msi_get_virq(struct device *dev, unsigned int index)
 			ret = desc->irq;
 		}
 	}
+
 	msi_unlock_descs(dev);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(msi_get_virq);
+EXPORT_SYMBOL_GPL(msi_domain_get_virq);
 
 #ifdef CONFIG_SYSFS
 static struct attribute *msi_dev_attrs[] = {
