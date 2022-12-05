Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0037643047
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiLES1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiLESZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F2A20F4D;
        Mon,  5 Dec 2022 10:25:18 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6jKEqei99/mkAE+Sajg/9FjEWYa2XFYgsWywP/WSqSc=;
        b=tpF54EBknLuxtsembXbJtTad8fG+rLuga1SmPIUIs7zOVTYt5EP9Xzh7A8t/TcnOQ3pKRN
        gg8heGEsS0PMTLmAyZsUedt/9OUBs98G5n9MfXDCHpd/Q2wzeEWsExtbVdRCnsqdAOx7HU
        ETdTmH5J4cctcXPso1J8iIo9aWC8RMgAfhnH49POjANeFlYTiYoT9osM/toavnoNTctrKu
        iPx8ER4GEjnO2kvveuhEPj6nMuxzJyWzI4RylxF1qNn7P1lMtk98CQz9GhX11uDFm8kF30
        D73PcmUrs+LaxamQjzDI8Fx0jqy+HbAM60F+sjZ5MRch77pU0GiuBZSn0xwl2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6jKEqei99/mkAE+Sajg/9FjEWYa2XFYgsWywP/WSqSc=;
        b=PNP/OFdmAGk/ZhNQle8tUT/7l21UVljBUZdkRV+AEMo66u1m8lKvwatxImXvdH2R47SXKe
        lviaNkRHbDQRneAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Provide msi_create/free_device_irq_domain()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232325.678838546@linutronix.de>
References: <20221124232325.678838546@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471575.4906.5527424450076876220.tip-bot2@tip-bot2>
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

Commit-ID:     27a6dea3ebaab3d6f8ded969ec3af710bcbe0c02
Gitweb:        https://git.kernel.org/tip/27a6dea3ebaab3d6f8ded969ec3af710bcbe0c02
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:25:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:01 +01:00

genirq/msi: Provide msi_create/free_device_irq_domain()

Now that all prerequsites are in place, provide the actual interfaces for
creating and removing per device interrupt domains.

MSI device interrupt domains are created from the provided
msi_domain_template which is duplicated so that it can be modified for the
particular device.

The name of the domain and the name of the interrupt chip are composed by
"$(PREFIX)$(CHIPNAME)-$(DEVNAME)"

  $PREFIX:   The optional prefix provided by the underlying MSI parent domain
             via msi_parent_ops::prefix.
  $CHIPNAME: The name of the irq_chip in the template
  $DEVNAME:  The name of the device

The domain is further initialized through a MSI parent domain callback which
fills in the required functionality for the parent domain or domains further
down the hierarchy. This initialization can fail, e.g. when the requested
feature or MSI domain type cannot be supported.

The domain pointer is stored in the pointer array inside of msi_device_data
which is attached to the domain.

The domain can be removed via the API or left for disposal via devres when
the device is torn down. The API removal is useful e.g. for PCI to have
seperate domains for MSI and MSI-X, which are mutually exclusive and always
occupy the default domain id slot.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232325.678838546@linutronix.de

---
 include/linux/msi.h |   6 ++-
 kernel/irq/msi.c    | 138 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 144 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 08a0e2a..ef46a3e 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -547,6 +547,12 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
 
+bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
+				  const struct msi_domain_template *template,
+				  unsigned int hwsize, void *domain_data,
+				  void *chip_data);
+void msi_remove_device_irq_domain(struct device *dev, unsigned int domid);
+
 int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domid,
 				       unsigned int first, unsigned int last);
 int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 0f7fe56..8b415bd 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -240,6 +240,7 @@ static void msi_device_data_release(struct device *dev, void *res)
 	int i;
 
 	for (i = 0; i < MSI_MAX_DEVICE_IRQDOMAINS; i++) {
+		msi_remove_device_irq_domain(dev, i);
 		WARN_ON_ONCE(!xa_empty(&md->__domains[i].store));
 		xa_destroy(&md->__domains[i].store);
 	}
@@ -848,6 +849,143 @@ bool msi_parent_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 							 msi_child_info);
 }
 
+/**
+ * msi_create_device_irq_domain - Create a device MSI interrupt domain
+ * @dev:		Pointer to the device
+ * @domid:		Domain id
+ * @template:		MSI domain info bundle used as template
+ * @hwsize:		Maximum number of MSI table entries (0 if unknown or unlimited)
+ * @domain_data:	Optional pointer to domain specific data which is set in
+ *			msi_domain_info::data
+ * @chip_data:		Optional pointer to chip specific data which is set in
+ *			msi_domain_info::chip_data
+ *
+ * Return: True on success, false otherwise
+ *
+ * There is no firmware node required for this interface because the per
+ * device domains are software constructs which are actually closer to the
+ * hardware reality than any firmware can describe them.
+ *
+ * The domain name and the irq chip name for a MSI device domain are
+ * composed by: "$(PREFIX)$(CHIPNAME)-$(DEVNAME)"
+ *
+ * $PREFIX:   Optional prefix provided by the underlying MSI parent domain
+ *	      via msi_parent_ops::prefix. If that pointer is NULL the prefix
+ *	      is empty.
+ * $CHIPNAME: The name of the irq_chip in @template
+ * $DEVNAME:  The name of the device
+ *
+ * This results in understandable chip names and hardware interrupt numbers
+ * in e.g. /proc/interrupts
+ *
+ * PCI-MSI-0000:00:1c.0     0-edge  Parent domain has no prefix
+ * IR-PCI-MSI-0000:00:1c.4  0-edge  Same with interrupt remapping prefix 'IR-'
+ *
+ * IR-PCI-MSIX-0000:3d:00.0 0-edge  Hardware interrupt numbers reflect
+ * IR-PCI-MSIX-0000:3d:00.0 1-edge  the real MSI-X index on that device
+ * IR-PCI-MSIX-0000:3d:00.0 2-edge
+ *
+ * On IMS domains the hardware interrupt number is either a table entry
+ * index or a purely software managed index but it is guaranteed to be
+ * unique.
+ *
+ * The domain pointer is stored in @dev::msi::data::__irqdomains[]. All
+ * subsequent operations on the domain depend on the domain id.
+ *
+ * The domain is automatically freed when the device is removed via devres
+ * in the context of @dev::msi::data freeing, but it can also be
+ * independently removed via @msi_remove_device_irq_domain().
+ */
+bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
+				  const struct msi_domain_template *template,
+				  unsigned int hwsize, void *domain_data,
+				  void *chip_data)
+{
+	struct irq_domain *domain, *parent = dev->msi.domain;
+	const struct msi_parent_ops *pops;
+	struct msi_domain_template *bundle;
+	struct fwnode_handle *fwnode;
+
+	if (!irq_domain_is_msi_parent(parent))
+		return false;
+
+	if (domid >= MSI_MAX_DEVICE_IRQDOMAINS)
+		return false;
+
+	bundle = kmemdup(template, sizeof(*bundle), GFP_KERNEL);
+	if (!bundle)
+		return false;
+
+	bundle->info.hwsize = hwsize;
+	bundle->info.chip = &bundle->chip;
+	bundle->info.ops = &bundle->ops;
+	bundle->info.data = domain_data;
+	bundle->info.chip_data = chip_data;
+
+	pops = parent->msi_parent_ops;
+	snprintf(bundle->name, sizeof(bundle->name), "%s%s-%s",
+		 pops->prefix ? : "", bundle->chip.name, dev_name(dev));
+	bundle->chip.name = bundle->name;
+
+	fwnode = irq_domain_alloc_named_fwnode(bundle->name);
+	if (!fwnode)
+		goto free_bundle;
+
+	if (msi_setup_device_data(dev))
+		goto free_fwnode;
+
+	msi_lock_descs(dev);
+
+	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid)))
+		goto fail;
+
+	if (!pops->init_dev_msi_info(dev, parent, parent, &bundle->info))
+		goto fail;
+
+	domain = __msi_create_irq_domain(fwnode, &bundle->info, IRQ_DOMAIN_FLAG_MSI_DEVICE, parent);
+	if (!domain)
+		goto fail;
+
+	domain->dev = dev;
+	dev->msi.data->__domains[domid].domain = domain;
+	msi_unlock_descs(dev);
+	return true;
+
+fail:
+	msi_unlock_descs(dev);
+free_fwnode:
+	kfree(fwnode);
+free_bundle:
+	kfree(bundle);
+	return false;
+}
+
+/**
+ * msi_remove_device_irq_domain - Free a device MSI interrupt domain
+ * @dev:	Pointer to the device
+ * @domid:	Domain id
+ */
+void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
+{
+	struct msi_domain_info *info;
+	struct irq_domain *domain;
+
+	msi_lock_descs(dev);
+
+	domain = msi_get_device_domain(dev, domid);
+
+	if (!domain || !irq_domain_is_msi_device(domain))
+		goto unlock;
+
+	dev->msi.data->__domains[domid].domain = NULL;
+	info = domain->host_data;
+	irq_domain_remove(domain);
+	kfree(container_of(info, struct msi_domain_template, info));
+
+unlock:
+	msi_unlock_descs(dev);
+}
+
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec, msi_alloc_info_t *arg)
 {
