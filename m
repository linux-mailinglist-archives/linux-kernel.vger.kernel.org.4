Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B6C62DF41
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbiKQPK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbiKQPJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6803D781B9;
        Thu, 17 Nov 2022 07:08:23 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697702;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4S6xFRuOywIYX/+zBaY5VavIV99OHhyBsrjYOQXPfns=;
        b=c5mLPeXPVhWRN43HFHwkKfbKxqglmNPh8BliQ1LOt747Dn4j/ObGkTH1FV/3M87yiekQ/X
        3HZOuGLU9OPVpkFvUSz1tbEZ3iQCLjJjgvWMve2bmRRnJDF1PnSxxGVZzuVHR6sp1i6tFY
        KxahdlKWNImkdCBPkBvCe00F78uG1D3oBq1QUJuCZ6mIQqiPoCHSvxZ3sXI75b9aTrFccx
        RQW5xeGHCx9nG1JtugeEQqa4BF01urQHhRmEpD2Nnrqc4YddpUsH8kqqNSlP243pYZhs+4
        TCmTNF8sLIZ68XVtl2oo7VNr/akxSX9TZubO+WDIAY2SWWojIyUa175HNkeDiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697702;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4S6xFRuOywIYX/+zBaY5VavIV99OHhyBsrjYOQXPfns=;
        b=2LdQxk06VzLDsKk8xDgMWHbgUf7Tem2OUwpJUy96ntQUZwiOHF2r6atDuGEa+ZWD0vpqzK
        vccfFwaJYPX0UzBQ==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Add bus token to struct msi_domain_info
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.294554462@linutronix.de>
References: <20221111122014.294554462@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869770083.4906.6897829331118703189.tip-bot2@tip-bot2>
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

Commit-ID:     22db089a4437a72277677f99717af499560b13f2
Gitweb:        https://git.kernel.org/tip/22db089a4437a72277677f99717af499560b13f2
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:19 +01:00

genirq/msi: Add bus token to struct msi_domain_info

Add a bus token member to struct msi_domain_info and let
msi_create_irq_domain() set the bus token.

That allows to remove the bus token updates at the call sites.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20221111122014.294554462@linutronix.de

---
 include/linux/msi.h | 19 +++++++++++--------
 kernel/irq/msi.c    |  7 +++++--
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index ee735ff..2dfd7b2 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -16,6 +16,7 @@
  * abuse. The only function which is relevant for drivers is msi_get_virq().
  */
 
+#include <linux/irqdomain_defs.h>
 #include <linux/cpumask.h>
 #include <linux/xarray.h>
 #include <linux/mutex.h>
@@ -365,6 +366,7 @@ struct msi_domain_ops {
 /**
  * struct msi_domain_info - MSI interrupt domain data
  * @flags:		Flags to decribe features and capabilities
+ * @bus_token:		The domain bus token
  * @ops:		The callback data structure
  * @chip:		Optional: associated interrupt chip
  * @chip_data:		Optional: associated interrupt chip data
@@ -374,14 +376,15 @@ struct msi_domain_ops {
  * @data:		Optional: domain specific data
  */
 struct msi_domain_info {
-	u32			flags;
-	struct msi_domain_ops	*ops;
-	struct irq_chip		*chip;
-	void			*chip_data;
-	irq_flow_handler_t	handler;
-	void			*handler_data;
-	const char		*handler_name;
-	void			*data;
+	u32				flags;
+	enum irq_domain_bus_token	bus_token;
+	struct msi_domain_ops		*ops;
+	struct irq_chip			*chip;
+	void				*chip_data;
+	irq_flow_handler_t		handler;
+	void				*handler_data;
+	const char			*handler_name;
+	void				*data;
 };
 
 /* Flags for msi_domain_info */
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index a2efa00..b46b747 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -694,8 +694,11 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 	domain = irq_domain_create_hierarchy(parent, IRQ_DOMAIN_FLAG_MSI, 0,
 					     fwnode, &msi_domain_ops, info);
 
-	if (domain && !domain->name && info->chip)
-		domain->name = info->chip->name;
+	if (domain) {
+		if (!domain->name && info->chip)
+			domain->name = info->chip->name;
+		irq_domain_update_bus_token(domain, info->bus_token);
+	}
 
 	return domain;
 }
