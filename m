Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A258643061
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiLES3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiLESZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898392098A;
        Mon,  5 Dec 2022 10:25:23 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=667oBIoslqo0oieRpBWYXvRNbW6Fv1di387HPtPfYSQ=;
        b=fpSUpg5TCAgpyu6t1UpTSo96VLuH8HuX2QH4HhUUzVDfKiN136uqTNiT5/QM05Ovd22vNL
        FNkJz9FJtY3w0d3WE1wLzxXJNYBUSSWjINgt/Ht/xX5I0B/zEq1ncifUkBVuBWj/NdOpFI
        +evlw/9QC7txsf1xKRcuowf0UQVsNm4pmq775n9M0MdGNBLuuYJs7WAQlfEqbeCp5kDTSw
        DqNcu19kzyqcp6EhbZp6gPpblQ0ttidIZ+kAAFJq9zjJvEeshjZg4egtcZtcNPvuSRSqwI
        iQupxG6smkw8UUZGPyKgLOPRexM0MNalqqs+IqHdrJj2iJyAE6GsmfPRjDZAEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=667oBIoslqo0oieRpBWYXvRNbW6Fv1di387HPtPfYSQ=;
        b=pCtoYlvwFk8hm+gMgq4hTlni8qZo80b12kQxJgHvHUuKCb6QpIhhodeOF80dtT5AWpZsKH
        huwPW0niK0qlMqDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irqdomain: Rename irq_domain::dev to
 irq_domain:: Pm_dev
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230313.574541683@linutronix.de>
References: <20221124230313.574541683@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026472181.4906.14684993456898030611.tip-bot2@tip-bot2>
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

Commit-ID:     6a9fc4190ca23fcf327de666e1a98dbdcdd2d210
Gitweb:        https://git.kernel.org/tip/6a9fc4190ca23fcf327de666e1a98dbdcdd2d210
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:20:58 +01:00

genirq/irqdomain: Rename irq_domain::dev to irq_domain:: Pm_dev

irq_domain::dev is a misnomer as it's usually the rule that a device
pointer points to something which is directly related to the instance.

irq_domain::dev can point to some other device for power management to
ensure that this underlying device is not powered down when an interrupt is
allocated.

The upcoming per device MSI domains really require a pointer to the device
which instantiated the irq domain and not to some random other device which
is required for power management down the chain.

Rename irq_domain::dev to irq_domain::pm_dev and fixup the few sites which
use that pointer.

Conversion was done with the help of coccinelle.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230313.574541683@linutronix.de

---
 drivers/irqchip/irq-gic.c | 4 ++--
 include/linux/irqdomain.h | 6 +++---
 kernel/irq/chip.c         | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4c7bae0..08834e5 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -401,8 +401,8 @@ static void gic_irq_print_chip(struct irq_data *d, struct seq_file *p)
 {
 	struct gic_chip_data *gic = irq_data_get_irq_chip_data(d);
 
-	if (gic->domain->dev)
-		seq_printf(p, gic->domain->dev->of_node->name);
+	if (gic->domain->pm_dev)
+		seq_printf(p, gic->domain->pm_dev->of_node->name);
 	else
 		seq_printf(p, "GIC-%d", (int)(gic - &gic_data[0]));
 }
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index b1fdd8d..aa76da8 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -131,7 +131,7 @@ struct irq_domain_chip_generic;
  * @gc:		Pointer to a list of generic chips. There is a helper function for
  *		setting up one or more generic chips for interrupt controllers
  *		drivers using the generic chip library which uses this pointer.
- * @dev:	Pointer to a device that can be utilized for power management
+ * @pm_dev:	Pointer to a device that can be utilized for power management
  *		purposes related to the irq domain.
  * @parent:	Pointer to parent irq_domain to support hierarchy irq_domains
  *
@@ -153,7 +153,7 @@ struct irq_domain {
 	struct fwnode_handle		*fwnode;
 	enum irq_domain_bus_token	bus_token;
 	struct irq_domain_chip_generic	*gc;
-	struct device			*dev;
+	struct device			*pm_dev;
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_domain		*parent;
 #endif
@@ -206,7 +206,7 @@ static inline void irq_domain_set_pm_device(struct irq_domain *d,
 					    struct device *dev)
 {
 	if (d)
-		d->dev = dev;
+		d->pm_dev = dev;
 }
 
 #ifdef CONFIG_IRQ_DOMAIN
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 8ac37e8..49e7bc8 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1561,10 +1561,10 @@ int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	return 0;
 }
 
-static struct device *irq_get_parent_device(struct irq_data *data)
+static struct device *irq_get_pm_device(struct irq_data *data)
 {
 	if (data->domain)
-		return data->domain->dev;
+		return data->domain->pm_dev;
 
 	return NULL;
 }
@@ -1578,7 +1578,7 @@ static struct device *irq_get_parent_device(struct irq_data *data)
  */
 int irq_chip_pm_get(struct irq_data *data)
 {
-	struct device *dev = irq_get_parent_device(data);
+	struct device *dev = irq_get_pm_device(data);
 	int retval = 0;
 
 	if (IS_ENABLED(CONFIG_PM) && dev)
@@ -1597,7 +1597,7 @@ int irq_chip_pm_get(struct irq_data *data)
  */
 int irq_chip_pm_put(struct irq_data *data)
 {
-	struct device *dev = irq_get_parent_device(data);
+	struct device *dev = irq_get_pm_device(data);
 	int retval = 0;
 
 	if (IS_ENABLED(CONFIG_PM) && dev)
