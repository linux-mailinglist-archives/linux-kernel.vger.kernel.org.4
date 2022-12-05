Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7612164304C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiLES1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiLESZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1013209B9;
        Mon,  5 Dec 2022 10:25:18 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a6lgWraUK0O+Un0Ey0jc2BOkuVZzIzpe+yTTWTlh7vM=;
        b=PMml47iC+zWXbEmElvo0HReiaBw8Jo3TEXxuc0PJSGlyGFSkDWcWk28qobNT0H6GYLpNu+
        z4ZHDYNA4hwaXab6x3qDDOt9mXDbKC6IQEFsyYWMb40driC96uLCdUyYOjhjpZXrne79iE
        BpZ6+6dvhXB1b7XbAnsGlB/py8vtiiTEWJa0zJgPuw0TmdWTt1Niet+moLH6SsuB/RV3fc
        aVAICh4D+I7TzrwCmyTptnRHyzGJyDNRdc7ruXw0zyb+dxiY5b4g5uBeNa6gq6xdtQfldE
        +k80imGFOyXHzyg8hQkIl+NZFdLPWPjdQsLpg2RqgZ4+siOMU3JI7nVMq+iUrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a6lgWraUK0O+Un0Ey0jc2BOkuVZzIzpe+yTTWTlh7vM=;
        b=p7uwjYV/8OKstei4oNi8c8ekHNC59EXlhJCHsQe0VcQn8NoN+it49uVjaO5KXSs5z2BsX9
        SbTnOsOJh5sHaeCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Rearrange MSI domain flags
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232325.322714918@linutronix.de>
References: <20221124232325.322714918@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471726.4906.7224680850415194332.tip-bot2@tip-bot2>
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

Commit-ID:     2d958b02b04f18955b0e15eda531461153c399d4
Gitweb:        https://git.kernel.org/tip/2d958b02b04f18955b0e15eda531461153c399d4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:25:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:01 +01:00

genirq/msi: Rearrange MSI domain flags

These flags got added as necessary and have no obvious structure. For
feature support checks and masking it's convenient to have two blocks of
flags:

   1) Flags to control the internal behaviour like allocating/freeing
      MSI descriptors. Those flags do not need any support from the
      underlying MSI parent domain. They are mostly under the control
      of the outermost domain which implements the actual MSI support.

   2) Flags to expose features, e.g. PCI multi-MSI or requirements
      which can depend on a underlying domain.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232325.322714918@linutronix.de

---
 include/linux/msi.h | 49 ++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 43b8866..a4339eb 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -24,6 +24,8 @@
 #include <linux/xarray.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
+#include <linux/bits.h>
+
 #include <asm/msi.h>
 
 /* Dummy shadow structures if an architecture does not define them */
@@ -440,7 +442,16 @@ struct msi_domain_info {
 	void				*data;
 };
 
-/* Flags for msi_domain_info */
+/*
+ * Flags for msi_domain_info
+ *
+ * Bit 0-15:	Generic MSI functionality which is not subject to restriction
+ *		by parent domains
+ *
+ * Bit 16-31:	Functionality which depends on the underlying parent domain and
+ *		can be masked out by msi_parent_ops::init_dev_msi_info() when
+ *		a device MSI domain is initialized.
+ */
 enum {
 	/*
 	 * Init non implemented ops callbacks with default MSI domain
@@ -452,33 +463,41 @@ enum {
 	 * callbacks.
 	 */
 	MSI_FLAG_USE_DEF_CHIP_OPS	= (1 << 1),
-	/* Support multiple PCI MSI interrupts */
-	MSI_FLAG_MULTI_PCI_MSI		= (1 << 2),
-	/* Support PCI MSIX interrupts */
-	MSI_FLAG_PCI_MSIX		= (1 << 3),
 	/* Needs early activate, required for PCI */
-	MSI_FLAG_ACTIVATE_EARLY		= (1 << 4),
+	MSI_FLAG_ACTIVATE_EARLY		= (1 << 2),
 	/*
 	 * Must reactivate when irq is started even when
 	 * MSI_FLAG_ACTIVATE_EARLY has been set.
 	 */
-	MSI_FLAG_MUST_REACTIVATE	= (1 << 5),
-	/* Is level-triggered capable, using two messages */
-	MSI_FLAG_LEVEL_CAPABLE		= (1 << 6),
+	MSI_FLAG_MUST_REACTIVATE	= (1 << 3),
 	/* Populate sysfs on alloc() and destroy it on free() */
-	MSI_FLAG_DEV_SYSFS		= (1 << 7),
-	/* MSI-X entries must be contiguous */
-	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 8),
+	MSI_FLAG_DEV_SYSFS		= (1 << 4),
 	/* Allocate simple MSI descriptors */
-	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	= (1 << 9),
+	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	= (1 << 5),
 	/* Free MSI descriptors */
-	MSI_FLAG_FREE_MSI_DESCS		= (1 << 10),
+	MSI_FLAG_FREE_MSI_DESCS		= (1 << 6),
 	/*
 	 * Quirk to handle MSI implementations which do not provide
 	 * masking. Currently known to affect x86, but has to be partially
 	 * handled in the core MSI code.
 	 */
-	MSI_FLAG_NOMASK_QUIRK		= (1 << 11),
+	MSI_FLAG_NOMASK_QUIRK		= (1 << 7),
+
+	/* Mask for the generic functionality */
+	MSI_GENERIC_FLAGS_MASK		= GENMASK(15, 0),
+
+	/* Mask for the domain specific functionality */
+	MSI_DOMAIN_FLAGS_MASK		= GENMASK(31, 16),
+
+	/* Support multiple PCI MSI interrupts */
+	MSI_FLAG_MULTI_PCI_MSI		= (1 << 16),
+	/* Support PCI MSIX interrupts */
+	MSI_FLAG_PCI_MSIX		= (1 << 17),
+	/* Is level-triggered capable, using two messages */
+	MSI_FLAG_LEVEL_CAPABLE		= (1 << 18),
+	/* MSI-X entries must be contiguous */
+	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 19),
+
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
