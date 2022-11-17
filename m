Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780A962DF45
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbiKQPLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240257AbiKQPJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17C5B7C7;
        Thu, 17 Nov 2022 07:08:27 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/K9lHuiSF7Wxg1kZkD09F7nqwS2mS7RJYeIJN95CV8=;
        b=Ib59n7BaEPcE2T8pQfPHhE7nE9IRvB2k8SWL0O4sluGrZUyJzYyNSRKyHFpDVPa6rRG5Cd
        3wTQ9ZhqKcQjgwVjQDBuzAeGZGE9nXLcbmt/rLthC+tdwz1VGCcnuuUhETGUrOY0043Eri
        ny4xTP6QdovRm2/YFoLH7PYJGaUvTQ7/i5bLT2yMPaGCgcLBkDkFjdPo1yNQx+hezAzQht
        T+gTdeucXBvB1za9fc6VDg4+ZaE9GHLs0dl0XjwvzasbDKQjpQpH3rg9UjpcvfVHZnG0LZ
        lVLYvrob795NwnSALFaqFE2WsvHLB5TL76j+qB2yY1EjQFpcpqpCKBk16rwq5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/K9lHuiSF7Wxg1kZkD09F7nqwS2mS7RJYeIJN95CV8=;
        b=L/h4y9+AMmuorHcTb8831SQ5PGPJFX8Iqk/Bmt22eSHP3YZB8v4yJjy0iEgT8HziT/3bKF
        FD8mdNtk4udG9HBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Provide msi_domain_ops:: Post_free()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.063153448@linutronix.de>
References: <20221111122014.063153448@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869770523.4906.5860379495214796785.tip-bot2@tip-bot2>
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

Commit-ID:     f6d3486a3d2f3c67d732641834eec872fcc66472
Gitweb:        https://git.kernel.org/tip/f6d3486a3d2f3c67d732641834eec872fcc66472
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:19 +01:00

genirq/msi: Provide msi_domain_ops:: Post_free()

To prepare for removing the exposure of __msi_domain_free_irqs() provide a
post_free() callback in the MSI domain ops which can be used to solve
the problem of the only user of __msi_domain_free_irqs() in arch/powerpc.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20221111122014.063153448@linutronix.de

---
 include/linux/msi.h | 4 ++++
 kernel/irq/msi.c    | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 9b552ee..7f6aba9 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -315,6 +315,8 @@ struct msi_domain_info;
  *			function.
  * @domain_free_irqs:	Optional function to override the default free
  *			function.
+ * @msi_post_free:	Optional function which is invoked after freeing
+ *			all interrupts.
  *
  * @get_hwirq, @msi_init and @msi_free are callbacks used by the underlying
  * irqdomain.
@@ -359,6 +361,8 @@ struct msi_domain_ops {
 					     struct device *dev, int nvec);
 	void		(*domain_free_irqs)(struct irq_domain *domain,
 					    struct device *dev);
+	void		(*msi_post_free)(struct irq_domain *domain,
+					 struct device *dev);
 };
 
 /**
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 3ccc7f6..c71c37d 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1026,6 +1026,8 @@ void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
 	ops->domain_free_irqs(domain, dev);
+	if (ops->msi_post_free)
+		ops->msi_post_free(domain, dev);
 	msi_domain_free_msi_descs(info, dev);
 }
 
