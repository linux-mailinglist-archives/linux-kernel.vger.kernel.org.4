Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D803162DF42
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbiKQPLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbiKQPJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FD9C0B;
        Thu, 17 Nov 2022 07:08:24 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697703;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EfenmU+zRIGl/7wxA8x5IzaYnyBVO3d+It2RSwmkUXU=;
        b=ZqPDfTVD+WF3nFYyfQVK9vSZGCaMQkYUCyrzs0LNX6lQghghENuQhe42KsUb+7sjwokGAw
        iGnDNXQSXtXzAdrvR4kcoQ8cwOk8XxlNUp8YGXbpVWkjSlE4xJr7TKgQufpyUX6/jUKLMM
        Wp95DeJ4NDrvk0tzv+pJUM4RFqNPOuC+qG5aFOvaGXXXg/oTr44Jeb+GYut6btx/Y5m/0c
        kJrtawrJCDqyGJNP+nuRiK5LioBMTF/RN7N+PDOcqo3HOzbJHv2Df/fYMcKL3kkiEHHDUP
        xVDVXgDxW46T+WbU+zBLay2LmGoDUN+ersxmtJvxW/fAqh6FfBrLe86PKOy8kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697703;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EfenmU+zRIGl/7wxA8x5IzaYnyBVO3d+It2RSwmkUXU=;
        b=2Ml3SqQAA7TsIQNq7fuAHqkAodiUEdHfn5A5DAVpmca7cxbFZ0Qzs59iRLN561Dsq/HPmr
        084gYVP02WHC9EAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irqdomain: Move bus token enum into a seperate header
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.237221143@linutronix.de>
References: <20221111122014.237221143@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869770192.4906.14700557122174182957.tip-bot2@tip-bot2>
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

Commit-ID:     aeef20527c87fed37c6f159d9eafd063a099f6ed
Gitweb:        https://git.kernel.org/tip/aeef20527c87fed37c6f159d9eafd063a099f6ed
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:19 +01:00

genirq/irqdomain: Move bus token enum into a seperate header

Split the bus token defines out into a seperate header file to avoid
inclusion of irqdomain.h in msi.h.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20221111122014.237221143@linutronix.de

---
 include/linux/irqdomain.h      | 22 +---------------------
 include/linux/irqdomain_defs.h | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 21 deletions(-)
 create mode 100644 include/linux/irqdomain_defs.h

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 00d577f..a4af7f8 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -31,6 +31,7 @@
 #define _LINUX_IRQDOMAIN_H
 
 #include <linux/types.h>
+#include <linux/irqdomain_defs.h>
 #include <linux/irqhandler.h>
 #include <linux/of.h>
 #include <linux/mutex.h>
@@ -68,27 +69,6 @@ struct irq_fwspec {
 void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 			       unsigned int count, struct irq_fwspec *fwspec);
 
-/*
- * Should several domains have the same device node, but serve
- * different purposes (for example one domain is for PCI/MSI, and the
- * other for wired IRQs), they can be distinguished using a
- * bus-specific token. Most domains are expected to only carry
- * DOMAIN_BUS_ANY.
- */
-enum irq_domain_bus_token {
-	DOMAIN_BUS_ANY		= 0,
-	DOMAIN_BUS_WIRED,
-	DOMAIN_BUS_GENERIC_MSI,
-	DOMAIN_BUS_PCI_MSI,
-	DOMAIN_BUS_PLATFORM_MSI,
-	DOMAIN_BUS_NEXUS,
-	DOMAIN_BUS_IPI,
-	DOMAIN_BUS_FSL_MC_MSI,
-	DOMAIN_BUS_TI_SCI_INTA_MSI,
-	DOMAIN_BUS_WAKEUP,
-	DOMAIN_BUS_VMD_MSI,
-};
-
 /**
  * struct irq_domain_ops - Methods for irq_domain objects
  * @match: Match an interrupt controller device node to a host, returns
diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
new file mode 100644
index 0000000..69035b4
--- /dev/null
+++ b/include/linux/irqdomain_defs.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_IRQDOMAIN_DEFS_H
+#define _LINUX_IRQDOMAIN_DEFS_H
+
+/*
+ * Should several domains have the same device node, but serve
+ * different purposes (for example one domain is for PCI/MSI, and the
+ * other for wired IRQs), they can be distinguished using a
+ * bus-specific token. Most domains are expected to only carry
+ * DOMAIN_BUS_ANY.
+ */
+enum irq_domain_bus_token {
+	DOMAIN_BUS_ANY		= 0,
+	DOMAIN_BUS_WIRED,
+	DOMAIN_BUS_GENERIC_MSI,
+	DOMAIN_BUS_PCI_MSI,
+	DOMAIN_BUS_PLATFORM_MSI,
+	DOMAIN_BUS_NEXUS,
+	DOMAIN_BUS_IPI,
+	DOMAIN_BUS_FSL_MC_MSI,
+	DOMAIN_BUS_TI_SCI_INTA_MSI,
+	DOMAIN_BUS_WAKEUP,
+	DOMAIN_BUS_VMD_MSI,
+};
+
+#endif /* _LINUX_IRQDOMAIN_DEFS_H */
