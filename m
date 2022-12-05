Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A39C643057
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiLES2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiLESZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1435021256;
        Mon,  5 Dec 2022 10:25:22 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264720;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FuHGXJQ2eCwfFqjBR9ci6mT+JzX/TmthXfIpZNRGFo=;
        b=U6KwUJtfluYtJFm3kZ+2+PYYOxxFAD2HFsxpoPCd4LLKL4stHQcpjvirbNjVhxADitGEwC
        PKnY/2A6rxEPS34WkbWV9rh2iheyYpnyvdyODGXWydQq/QbMWrPPPUr4ZBCstSe/MWT9I9
        89b8kVf2pqwoT+WYjuLrn+fXv1lITvJG6BQKIrzfBWViBx/b9SsIqspGAxGg8dB7jxGxWM
        +2Su4A3V/knzZ6d2sgDkeaiM7fxzEV6kit4JFMnD4xluevMnSwjA2W9U7EonnLUOFmTpRB
        1IcNpoNVRacliTPLFrQWAeJM9PFHQ3+QK7yXA+v7kl91AHMhd+AkjQ17BJGH2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264720;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FuHGXJQ2eCwfFqjBR9ci6mT+JzX/TmthXfIpZNRGFo=;
        b=Ui/xR3JD0AWUZeykhNOrVOalNw0voGfYOSpfe1A0O/mKlf65XPzu6Kf+BVNXNVkfZAg1uT
        KHLBpTW4I6SR1tBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Add pointers for per device irq domains
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230313.923860399@linutronix.de>
References: <20221124230313.923860399@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026472045.4906.13119084508984817791.tip-bot2@tip-bot2>
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

Commit-ID:     64258eaa442b0b7d7eac8942cf27863ad9e6028e
Gitweb:        https://git.kernel.org/tip/64258eaa442b0b7d7eac8942cf27863ad9e6028e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:20:59 +01:00

genirq/msi: Add pointers for per device irq domains

With the upcoming per device MSI interrupt domain support it is necessary
to store the domain pointers per device.

Instead of delegating that storage to device drivers or subsystems add a
domain pointer to the msi_dev_domain array in struct msi_device_data.

This pointer is also used to take care of tearing down the irq domains when
msi_device_data is cleaned up via devres.

The interfaces into the MSI core will be changed from irqdomain pointer
based interfaces to domain id based interfaces to support multiple MSI
domains on a single device (e.g. PCI/MSI[-X] and PCI/IMS.

Once the per device domain support is complete the irq domain pointer in
struct device::msi.domain will not longer contain a pointer to the "global"
MSI domain. It will contain a pointer to the MSI parent domain instead.

It would be a horrible maze of conditionals to evaluate all over the place
which domain pointer should be used, i.e. the "global" one in
device::msi::domain or one from the internal pointer array.

To avoid this evaluate in msi_setup_device_data() whether the irq domain
which is associated to a device is a "global" or a parent MSI domain. If it
is global then copy the pointer into the first entry of the msi_dev_domain
array.

This allows to convert interfaces and implementation to domain ids while
keeping everything existing working.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230313.923860399@linutronix.de

---
 include/linux/msi.h |  3 +++
 kernel/irq/msi.c    |  9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index f7b9c41..fdbc80d 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -77,6 +77,7 @@ struct msi_desc;
 struct pci_dev;
 struct platform_msi_priv_data;
 struct device_attribute;
+struct irq_domain;
 
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 #ifdef CONFIG_GENERIC_MSI_IRQ
@@ -177,9 +178,11 @@ enum msi_desc_filter {
 /**
  * struct msi_dev_domain - The internals of MSI domain info per device
  * @store:		Xarray for storing MSI descriptor pointers
+ * @irqdomain:		Pointer to a per device interrupt domain
  */
 struct msi_dev_domain {
 	struct xarray		store;
+	struct irq_domain	*domain;
 };
 
 /**
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c2bc94e..de65acc 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -220,6 +220,15 @@ int msi_setup_device_data(struct device *dev)
 	for (i = 0; i < MSI_MAX_DEVICE_IRQDOMAINS; i++)
 		xa_init(&md->__domains[i].store);
 
+	/*
+	 * If @dev::msi::domain is set and is a global MSI domain, copy the
+	 * pointer into the domain array so all code can operate on domain
+	 * ids. The NULL pointer check is required to keep the legacy
+	 * architecture specific PCI/MSI support working.
+	 */
+	if (dev->msi.domain && !irq_domain_is_msi_parent(dev->msi.domain))
+		md->__domains[MSI_DEFAULT_DOMAIN].domain = dev->msi.domain;
+
 	mutex_init(&md->mutex);
 	dev->msi.data = md;
 	devres_add(dev, md);
