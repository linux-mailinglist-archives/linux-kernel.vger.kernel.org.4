Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF3A62DF3E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240471AbiKQPKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240293AbiKQPJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E5EB63;
        Thu, 17 Nov 2022 07:08:25 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697704;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PVoWKIGb6vmjAvnq149933QDV7tjekCdGYfIfsLk9ck=;
        b=FxtwRxeDUnGKG5AkGaL35xKR19LvlUDeI1e15SKNfMPcB4i3ipmo/y/pBDN/xDNLCP5VAh
        lX9S50sufxK8AetoSuWh1sk+TrWZg9Pnidet5OZtMGuO4c0GVIaSzv4zPaDXErj4k/I+c8
        2QOrhaxB4eS51JZQHzeGdYjm3pBzCEM2dJgA9xKie8RL/cO0rnMXtUVtwoo3kOG9DnI7gd
        a4WTplStY0o/hMJ9oQkA/Jp+apLSbAZKvTY0ADjZOwHBaGB6fnrA5bwhpL6UTyaA88bhMV
        +wUBkbAnqRAWeHB8XsGRTPebr3H30TraXGTPtGCoDD/phFHc9n6GUbLptmrbdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697704;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PVoWKIGb6vmjAvnq149933QDV7tjekCdGYfIfsLk9ck=;
        b=luseQRVY/F8cl8lUJTIY+tfhVZ9VFvsNF9OhONrmbFQcu5xrO1rBb9lE1tDSRxZeCQkC6s
        /ma+FftRcAqdksBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Make __msi_domain_free_irqs() static
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.179595843@linutronix.de>
References: <20221111122014.179595843@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869770303.4906.13442736094650418814.tip-bot2@tip-bot2>
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

Commit-ID:     057c97a1cd665ebb38841418adcd35f57b33cc21
Gitweb:        https://git.kernel.org/tip/057c97a1cd665ebb38841418adcd35f57b33cc21
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:19 +01:00

genirq/msi: Make __msi_domain_free_irqs() static

Now that the last user is gone, confine it to the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20221111122014.179595843@linutronix.de

---
 include/linux/msi.h | 4 ----
 kernel/irq/msi.c    | 3 ++-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 7f6aba9..ee735ff 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -335,9 +335,6 @@ struct msi_domain_info;
  * are set to the default implementation if NULL and even when
  * MSI_FLAG_USE_DEF_DOM_OPS is not set to avoid breaking existing users and
  * because these callbacks are obviously mandatory.
- *
- * __msi_domain_free_irqs() is exposed for PPC pseries to handle extra
- * work after all interrupts and descriptors have been freed.
  */
 struct msi_domain_ops {
 	irq_hw_number_t	(*get_hwirq)(struct msi_domain_info *info,
@@ -432,7 +429,6 @@ int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device 
 				       int nvec);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec);
-void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c71c37d..a2efa00 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -463,6 +463,7 @@ static inline void msi_sysfs_remove_desc(struct device *dev, struct msi_desc *de
 
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec);
+static void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
@@ -978,7 +979,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nve
 	return ret;
 }
 
-void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+static void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct irq_data *irqd;
