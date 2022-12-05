Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F42A64304B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiLES1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiLESZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D7E20BD6;
        Mon,  5 Dec 2022 10:25:18 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anBZzE86rmX6ksCPkRXFcLquPa86Pm1QePctOotQD54=;
        b=i14WGrnIvklzGVctKVfs0i8liUrthgRI5vbasymlNr78syCB4rxWomaIQU4xzNSfGXcwl+
        6GJXQ2cvWGkut1yTTgkImL3hCUZA8T69auxLEmXh2Y5JtRiO48ARK8BfDRlrWEu/uEJMud
        TuFlQVOhP4z4yS+/UYAYkmotkXOnBskgRy/3740qV4f7h0I3eoAC5I10/lSILzsR4apH9i
        oSX8Jx0+Ouu+bvm5p/OPxlSAQdcMuHY5Yk4KQ7xtWL9X55Oa2Eu9pgYIL/BiOJb2z4mlrz
        4dysWN4h1xWtefXEjUr9r626U55Pw1qw7zR+FVUdeYVcvWprGVerPZtQDQZQtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anBZzE86rmX6ksCPkRXFcLquPa86Pm1QePctOotQD54=;
        b=6sAJpufH41qIsjgCZfPTrmDAucNscfyzxkInQ0y8uafz4mxb7MHrwAQnnO1ComSq6+yzgD
        rDXl/XTG/bcvvOAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Provide struct msi_parent_ops
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232325.382485843@linutronix.de>
References: <20221124232325.382485843@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471701.4906.12340517029717748769.tip-bot2@tip-bot2>
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

Commit-ID:     b78780d93b068706d04f8f2f02bd08db5da01479
Gitweb:        https://git.kernel.org/tip/b78780d93b068706d04f8f2f02bd08db5da01479
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:25:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:01 +01:00

genirq/msi: Provide struct msi_parent_ops

MSI parent domains must have some control over the MSI domains which are
built on top. On domain creation they need to fill in e.g. architecture
specific chip callbacks or msi domain ops to make the outermost domain
parent agnostic which is obviously required for architecture independence
etc.

The structure contains:

    1) A bitfield which exposes the supported functional features. This
       allows to check for features and is also used in the initialization
       callback to mask out unsupported features when the actual domain
       implementation requests a broader range, e.g. on x86 PCI multi-MSI
       is only supported by remapping domains but not by the underlying
       vector domain. The PCI/MSI code can then always request multi-MSI
       support, but the resulting feature set after creation might not
       have it set.

    2) An optional string prefix which is put in front of domain and chip
       names during creation of the MSI domain. That allows to keep the
       naming schemes e.g. on x86 where PCI-MSI domains have a IR- prefix
       when interrupt remapping is enabled.

    3) An initialization callback to sanity check the domain info of
       the to be created MSI domain, to restrict features and to
       apply changes in MSI ops and interrupt chip callbacks to
       accomodate to the particular MSI parent implementation and/or
       the underlying hierarchy.

Add a conveniance function to delegate the initialization from the
MSI parent domain to an underlying domain in the hierarchy.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232325.382485843@linutronix.de

---
 include/linux/irqdomain.h |  5 +++++-
 include/linux/msi.h       | 21 +++++++++++++++++++-
 kernel/irq/msi.c          | 41 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 67 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 24b7668..a668cc0 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -46,6 +46,7 @@ struct irq_desc;
 struct cpumask;
 struct seq_file;
 struct irq_affinity_desc;
+struct msi_parent_ops;
 
 #define IRQ_DOMAIN_IRQ_SPEC_PARAMS 16
 
@@ -134,6 +135,7 @@ struct irq_domain_chip_generic;
  * @pm_dev:	Pointer to a device that can be utilized for power management
  *		purposes related to the irq domain.
  * @parent:	Pointer to parent irq_domain to support hierarchy irq_domains
+ * @msi_parent_ops: Pointer to MSI parent domain methods for per device domain init
  *
  * Revmap data, used internally by the irq domain code:
  * @revmap_size:	Size of the linear map table @revmap[]
@@ -157,6 +159,9 @@ struct irq_domain {
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_domain		*parent;
 #endif
+#ifdef CONFIG_GENERIC_MSI_IRQ
+	const struct msi_parent_ops	*msi_parent_ops;
+#endif
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
 	irq_hw_number_t			hwirq_max;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index a4339eb..9bf3cba 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -500,6 +500,27 @@ enum {
 
 };
 
+/**
+ * struct msi_parent_ops - MSI parent domain callbacks and configuration info
+ *
+ * @supported_flags:	Required: The supported MSI flags of the parent domain
+ * @prefix:		Optional: Prefix for the domain and chip name
+ * @init_dev_msi_info:	Required: Callback for MSI parent domains to setup parent
+ *			domain specific domain flags, domain ops and interrupt chip
+ *			callbacks when a per device domain is created.
+ */
+struct msi_parent_ops {
+	u32		supported_flags;
+	const char	*prefix;
+	bool		(*init_dev_msi_info)(struct device *dev, struct irq_domain *domain,
+					     struct irq_domain *msi_parent_domain,
+					     struct msi_domain_info *msi_child_info);
+};
+
+bool msi_parent_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				  struct irq_domain *msi_parent_domain,
+				  struct msi_domain_info *msi_child_info);
+
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
 			    bool force);
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 8e653f0..c368116 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -788,6 +788,47 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 	return domain;
 }
 
+/**
+ * msi_parent_init_dev_msi_info - Delegate initialization of device MSI info down
+ *				  in the domain hierarchy
+ * @dev:		The device for which the domain should be created
+ * @domain:		The domain in the hierarchy this op is being called on
+ * @msi_parent_domain:	The IRQ_DOMAIN_FLAG_MSI_PARENT domain for the child to
+ *			be created
+ * @msi_child_info:	The MSI domain info of the IRQ_DOMAIN_FLAG_MSI_DEVICE
+ *			domain to be created
+ *
+ * Return: true on success, false otherwise
+ *
+ * This is the most complex problem of per device MSI domains and the
+ * underlying interrupt domain hierarchy:
+ *
+ * The device domain to be initialized requests the broadest feature set
+ * possible and the underlying domain hierarchy puts restrictions on it.
+ *
+ * That's trivial for a simple parent->child relationship, but it gets
+ * interesting with an intermediate domain: root->parent->child.  The
+ * intermediate 'parent' can expand the capabilities which the 'root'
+ * domain is providing. So that creates a classic hen and egg problem:
+ * Which entity is doing the restrictions/expansions?
+ *
+ * One solution is to let the root domain handle the initialization that's
+ * why there is the @domain and the @msi_parent_domain pointer.
+ */
+bool msi_parent_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				  struct irq_domain *msi_parent_domain,
+				  struct msi_domain_info *msi_child_info)
+{
+	struct irq_domain *parent = domain->parent;
+
+	if (WARN_ON_ONCE(!parent || !parent->msi_parent_ops ||
+			 !parent->msi_parent_ops->init_dev_msi_info))
+		return false;
+
+	return parent->msi_parent_ops->init_dev_msi_info(dev, parent, msi_parent_domain,
+							 msi_child_info);
+}
+
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec, msi_alloc_info_t *arg)
 {
