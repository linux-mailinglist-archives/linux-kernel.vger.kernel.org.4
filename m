Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DA262DF49
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbiKQPLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiKQPJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D7610FF7;
        Thu, 17 Nov 2022 07:08:29 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697707;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LyHlI/t1kqikxkbw7l9K1KAQSUdfreCZ0zx+OpwNRoQ=;
        b=N+u4tjrL/StNbjJ/jjGfiVMrrMgiio+BVu1GvbBVplaxuZwJ2DkUCwPIl/XkNAcP4QNh9d
        bP6KJ615KDDT1HQliJudMuZ+O3tXF5ssDK8UFZqn3SV0kuoYu/hG/J79BDO7LOQkRzTFbf
        nTFaB0tNVWoIcYnLLEUGnk386fNbB/RS0GbcLlPb9VoEUabJC6hJFBGpwHpUCcRYQuTi/H
        PN/O2m70NpkzKJQdoTJb0MZc0OqpFd7bZWfYeJUUyqysRpsJD+GFUgrPLGVoXXETwA2G9B
        fBXyfzM/iIojgZJif7KRqhr/pV8rhLLFnFpItReKM9TWgzdqmr8/KiClwnlrxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697707;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LyHlI/t1kqikxkbw7l9K1KAQSUdfreCZ0zx+OpwNRoQ=;
        b=GQQVfyPxIgd2MM2GBYfkRS4/fGrjqU9B84vdlR12EuAi3TSS+P4kQrATAjlm4qWjnQv8ys
        EkAiAcVdLBUPbLAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Make __msi_domain_alloc_irqs() static
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.004725919@linutronix.de>
References: <20221111122014.004725919@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869770630.4906.17217504433732664741.tip-bot2@tip-bot2>
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

Commit-ID:     762687ceb31fc296e2e1406559e8bb50251c5277
Gitweb:        https://git.kernel.org/tip/762687ceb31fc296e2e1406559e8bb50251c5277
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:18 +01:00

genirq/msi: Make __msi_domain_alloc_irqs() static

Nothing outside of the core code requires this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20221111122014.004725919@linutronix.de

---
 include/linux/msi.h | 7 ++-----
 kernel/irq/msi.c    | 6 ++++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 969ce46..9b552ee 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -334,9 +334,8 @@ struct msi_domain_info;
  * MSI_FLAG_USE_DEF_DOM_OPS is not set to avoid breaking existing users and
  * because these callbacks are obviously mandatory.
  *
- * This is NOT meant to be abused, but it can be useful to build wrappers
- * for specialized MSI irq domains which need extra work before and after
- * calling __msi_domain_alloc_irqs()/__msi_domain_free_irqs().
+ * __msi_domain_free_irqs() is exposed for PPC pseries to handle extra
+ * work after all interrupts and descriptors have been freed.
  */
 struct msi_domain_ops {
 	irq_hw_number_t	(*get_hwirq)(struct msi_domain_info *info,
@@ -425,8 +424,6 @@ int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
 struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
-int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			    int nvec);
 int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
 				       int nvec);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 8a6d0dc..3ccc7f6 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -462,6 +462,8 @@ static inline void msi_sysfs_remove_desc(struct device *dev, struct msi_desc *de
 #endif /* !CONFIG_SYSFS */
 
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec);
+
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
 {
@@ -852,8 +854,8 @@ static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflag
 	return 0;
 }
 
-int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			    int nvec)
+static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
+				   int nvec)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
