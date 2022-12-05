Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB83643059
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiLES3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiLESZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D312125E;
        Mon,  5 Dec 2022 10:25:22 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ll5Tfh0jN7hL4lzT0LphqWaSeJDo0M/Khv3l0BgvD70=;
        b=mJmWNHci6nZwmG3aoRkhsKAaXwLx92YbpdSv7E2s5DdTFDr3RI65NoJ6jTf9DGbI0mo8n0
        mFXW8r8jmcTfygg59Gsb4T9skPBLykV8MFbsBOzdETTIpGJq4W7PdjnYstGARGNf4Kuvwt
        RZ9/88c48xOXCSCIfcxRE4upXnj3FUFg9uI5kovzerhibVZQ3LoVj/mFvyhMUAP4oEz+QL
        KEBLFJlMrTXvBVR8c9Cpa6gt91X82Oy66ZMdeAqTXr+y+kfjDDtJMZWm85+TwZNfMBJS4J
        I4Ndz3xk1IwAAWlOldryg80HDWLZGEDG8gYcw5VTatn4bGPSH6VFy6/xIkFFCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ll5Tfh0jN7hL4lzT0LphqWaSeJDo0M/Khv3l0BgvD70=;
        b=Qpc6PipJ2ycrnOXiS8Oaw20RHh9mZ9eRC2L0yYutPFQz4xcnRobTwPVmaTt2V3Fs9qfGtF
        9+nmADLd5fmYvKBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irqdomain: Provide IRQ_DOMAIN_FLAG_MSI_DEVICE
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230313.747627287@linutronix.de>
References: <20221124230313.747627287@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026472108.4906.9293890145686822773.tip-bot2@tip-bot2>
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

Commit-ID:     e71c5d0bb1885b73c746b634895b85d135ce2c87
Gitweb:        https://git.kernel.org/tip/e71c5d0bb1885b73c746b634895b85d135ce2c87
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:20:58 +01:00

genirq/irqdomain: Provide IRQ_DOMAIN_FLAG_MSI_DEVICE

Similar to marking parent MSI domains it's required to identify per device
domains. Add flag and helpers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230313.747627287@linutronix.de

---
 include/linux/irqdomain.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index f837db9..24b7668 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -192,6 +192,9 @@ enum {
 	/* Irq domain is a MSI parent domain */
 	IRQ_DOMAIN_FLAG_MSI_PARENT	= (1 << 8),
 
+	/* Irq domain is a MSI device domain */
+	IRQ_DOMAIN_FLAG_MSI_DEVICE	= (1 << 9),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -559,6 +562,11 @@ static inline bool irq_domain_is_msi_parent(struct irq_domain *domain)
 	return domain->flags & IRQ_DOMAIN_FLAG_MSI_PARENT;
 }
 
+static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FLAG_MSI_DEVICE;
+}
+
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
@@ -610,6 +618,11 @@ static inline bool irq_domain_is_msi_parent(struct irq_domain *domain)
 	return false;
 }
 
+static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
+{
+	return false;
+}
+
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
 #else /* CONFIG_IRQ_DOMAIN */
