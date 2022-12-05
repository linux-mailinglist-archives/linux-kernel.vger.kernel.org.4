Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BE3643041
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiLES1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiLESZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2C320F52;
        Mon,  5 Dec 2022 10:25:18 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XrkqEXK++v8CUKFEcz/xwkxbE6fFLQhXnmRSphJvL8=;
        b=hwRPErUyGZ5BozB0dtj9EvdvJz6S2s9LALOLgpIS2ITZMg55C7eQJUzi49fR6tOoMia52c
        1Jd7bqbiZDIRE4UP3+bxqANaZFL7SNvyk2DunjNluu0tIgDGBaxdbDQWiK4UTwA96tTMOs
        5OJthlOkkxZWfSsAzsQPv/7l1xO15LUHpzKxKd/1OHDkUOmcCLG+8Xe2Tg7sZtY2sVOyZL
        GhMtOOj0hyMt2B/RJVZBJSSzviNqzF3d39sTLZ4DrPxSbzbtL9JNyhxldAHhW1lSfUIsgU
        5tP40vhf4ULEDtwNc+RxdTSZuRPa+V7Gey1rvHIJEggD9yNIyOj7TnMuKlCHOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XrkqEXK++v8CUKFEcz/xwkxbE6fFLQhXnmRSphJvL8=;
        b=va2yoTmSD3poYzPrcMZrPYHDhhBwgplnKZpMqKZEVnVMtvt+hm72aPWDRb6g9huXkyIdUm
        Tby5F3CDH70FC0BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Split msi_create_irq_domain()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232325.559086358@linutronix.de>
References: <20221124232325.559086358@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471622.4906.12099453928840073878.tip-bot2@tip-bot2>
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

Commit-ID:     a80c0aceeaffdb3afe9536fe747480e85841da7f
Gitweb:        https://git.kernel.org/tip/a80c0aceeaffdb3afe9536fe747480e85841da7f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:25:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:01 +01:00

genirq/msi: Split msi_create_irq_domain()

Split the functionality of msi_create_irq_domain() so it can
be reused for creating per device irq domains.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232325.559086358@linutronix.de

---
 kernel/irq/msi.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 0a38905..0f7fe56 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -758,17 +758,10 @@ static void msi_domain_update_chip_ops(struct msi_domain_info *info)
 		chip->irq_set_affinity = msi_domain_set_affinity;
 }
 
-/**
- * msi_create_irq_domain - Create an MSI interrupt domain
- * @fwnode:	Optional fwnode of the interrupt controller
- * @info:	MSI domain info
- * @parent:	Parent irq domain
- *
- * Return: pointer to the created &struct irq_domain or %NULL on failure
- */
-struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
-					 struct msi_domain_info *info,
-					 struct irq_domain *parent)
+static struct irq_domain *__msi_create_irq_domain(struct fwnode_handle *fwnode,
+						  struct msi_domain_info *info,
+						  unsigned int flags,
+						  struct irq_domain *parent)
 {
 	struct irq_domain *domain;
 
@@ -787,7 +780,7 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		msi_domain_update_chip_ops(info);
 
-	domain = irq_domain_create_hierarchy(parent, IRQ_DOMAIN_FLAG_MSI, 0,
+	domain = irq_domain_create_hierarchy(parent, flags | IRQ_DOMAIN_FLAG_MSI, 0,
 					     fwnode, &msi_domain_ops, info);
 
 	if (domain) {
@@ -800,6 +793,21 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 }
 
 /**
+ * msi_create_irq_domain - Create an MSI interrupt domain
+ * @fwnode:	Optional fwnode of the interrupt controller
+ * @info:	MSI domain info
+ * @parent:	Parent irq domain
+ *
+ * Return: pointer to the created &struct irq_domain or %NULL on failure
+ */
+struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
+					 struct msi_domain_info *info,
+					 struct irq_domain *parent)
+{
+	return __msi_create_irq_domain(fwnode, info, 0, parent);
+}
+
+/**
  * msi_parent_init_dev_msi_info - Delegate initialization of device MSI info down
  *				  in the domain hierarchy
  * @dev:		The device for which the domain should be created
