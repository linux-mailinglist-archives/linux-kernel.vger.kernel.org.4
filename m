Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C0F64303F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiLES0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiLESZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C0D20F43;
        Mon,  5 Dec 2022 10:25:15 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264713;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwPPuygad2dm+YekM03MhwAgkTa+Yr8on0OV8pVs/90=;
        b=v9hBxAs2pLwOYoG3zHfSuZJgR49AmfJByDwYSrEHKyWe5hrkIHLzB5HNUcVIO+G+RJpekZ
        cDVRD+6IVp7Nn4PLEfVJUUtXJ8EVNg3DJkSuOS7ezUehX6MeANMK9XQJBC+jDvlhBGEBjK
        ddYpomxBCNLWAVYtVQ7lbh15mKoLR9bv+f6VHPwau7JVmnmwuHc/UkPf0vW9sQxHEh3fJ7
        QKuP8TMuyi4hKZA1RX2EbA04Mf9xxCdmLVNgK4j/e3qjABFDt/QjX65Q2AEsHG2SdhqJ0U
        ul3CLiCXZuRjZglzoYpkHm4iAgWBZ8FXZa6i/i8sCCyF6dfc/My1g2oyq8GYIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264713;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwPPuygad2dm+YekM03MhwAgkTa+Yr8on0OV8pVs/90=;
        b=d+6CqQxzy+USydbLkf/fwoHVt0RSjds44+KCfgjOIPQtTrCcXkTgGTOTL/SeroZ0D5WweG
        WGWj/h/hSt5AlcAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Provide msi_domain_ops:: Prepare_desc()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.444560717@linutronix.de>
References: <20221124232326.444560717@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471294.4906.3537011108248785194.tip-bot2@tip-bot2>
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

Commit-ID:     828b3c25195d7681ea894c70057324c673755dfc
Gitweb:        https://git.kernel.org/tip/828b3c25195d7681ea894c70057324c673755dfc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:03 +01:00

genirq/msi: Provide msi_domain_ops:: Prepare_desc()

The existing MSI domain ops msi_prepare() and set_desc() turned out to be
unsuitable for implementing IMS support.

msi_prepare() does not operate on the MSI descriptors. set_desc() lacks
an irq_domain pointer and has a completely different purpose.

Introduce a prepare_desc() op which allows IMS implementations to amend an
MSI descriptor which was allocated by the core code, e.g. by adjusting the
iomem base or adding some data based on the allocated index. This is way
better than requiring that all IMS domain implementations preallocate the
MSI descriptor and then allocate the interrupt.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.444560717@linutronix.de

---
 include/linux/msi.h | 6 +++++-
 kernel/irq/msi.c    | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index dca3b80..cb0bee3 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -410,6 +410,8 @@ struct msi_domain_info;
  * @msi_init:		Domain specific init function for MSI interrupts
  * @msi_free:		Domain specific function to free a MSI interrupts
  * @msi_prepare:	Prepare the allocation of the interrupts in the domain
+ * @prepare_desc:	Optional function to prepare the allocated MSI descriptor
+ *			in the domain
  * @set_desc:		Set the msi descriptor for an interrupt
  * @domain_alloc_irqs:	Optional function to override the default allocation
  *			function.
@@ -421,7 +423,7 @@ struct msi_domain_info;
  * @get_hwirq, @msi_init and @msi_free are callbacks used by the underlying
  * irqdomain.
  *
- * @msi_check, @msi_prepare and @set_desc are callbacks used by the
+ * @msi_check, @msi_prepare, @prepare_desc and @set_desc are callbacks used by the
  * msi_domain_alloc/free_irqs*() variants.
  *
  * @domain_alloc_irqs, @domain_free_irqs can be used to override the
@@ -444,6 +446,8 @@ struct msi_domain_ops {
 	int		(*msi_prepare)(struct irq_domain *domain,
 				       struct device *dev, int nvec,
 				       msi_alloc_info_t *arg);
+	void		(*prepare_desc)(struct irq_domain *domain, msi_alloc_info_t *arg,
+					struct msi_desc *desc);
 	void		(*set_desc)(msi_alloc_info_t *arg,
 				    struct msi_desc *desc);
 	int		(*domain_alloc_irqs)(struct irq_domain *domain,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 0536db7..077d1d1 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1257,6 +1257,9 @@ static int __msi_domain_alloc_irqs(struct device *dev, struct irq_domain *domain
 		if (WARN_ON_ONCE(allocated >= ctrl->nirqs))
 			return -EINVAL;
 
+		if (ops->prepare_desc)
+			ops->prepare_desc(domain, &arg, desc);
+
 		ops->set_desc(&arg, desc);
 
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
