Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA78D5BCD22
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiISN0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiISN0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:26:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C58ABE2B;
        Mon, 19 Sep 2022 06:25:57 -0700 (PDT)
Date:   Mon, 19 Sep 2022 13:25:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663593955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QmMIGV/ESjZSo5qRWaCTG/Tey5ErL0FYbgOCaxrKzE=;
        b=G1HKPU5HU3RMZIppQwekM10vHDmt3yCH4Ben9cTtoox45fFcCIhG3BO5dv1Onkif/KFZaU
        TelKrJKJUybcG1xTEd7CKwlqbn+1nOwf0lQ5CIuONd/z+Lb9FJV4aPrWx+pjsvGVnJEvL1
        wLMuKVyYITZrIOiSh/eZeDZ0P/tZdt/Zl+b6yQnWmWRGpXVA09g4r11ZvSQ1TouRqqFC3V
        S5h8XTTBAipWhsgUmk7JXV5mtNmdi/SoMP5HVpbzW7mxA26vISlZ20Ci+FaQy5yhk0tGiW
        gJBin2NuGqqe2f7NGKOleJtn4M6J+u9DhuH+D6+qga851tX3RY9NEsyqnse3dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663593955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QmMIGV/ESjZSo5qRWaCTG/Tey5ErL0FYbgOCaxrKzE=;
        b=4wcetC8nw4bKAO8i4/1UxFmD36wOZ5iHGuf1bTllCT5DO+24D4/Ty7zgCrOzi1HTrXn2Vr
        PNSHNi1JUuVH4rBw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Provide generic_handle_domain_irq_safe().
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <YnkfWFzvusFFktSt@linutronix.de>
References: <YnkfWFzvusFFktSt@linutronix.de>
MIME-Version: 1.0
Message-ID: <166359395444.401.2028340203117719081.tip-bot2@tip-bot2>
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

Commit-ID:     6a164c646999847b843e651f71c53dfaceb2c2b4
Gitweb:        https://git.kernel.org/tip/6a164c646999847b843e651f71c53dfaceb2c2b4
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 09 May 2022 16:04:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Sep 2022 15:08:38 +02:00

genirq: Provide generic_handle_domain_irq_safe().

commit 509853f9e1e7b ("genirq: Provide generic_handle_irq_safe()")
addressed the problem of demultiplexing interrupt handlers which are force
threaded on PREEMPT_RT enabled kernels which means that the demultiplexed
handler is invoked with interrupts enabled which triggers a lockdep
warning due to a non-irq safe lock acquisition.

The same problem exists for the irq domain based interrupt handling via
generic_handle_domain_irq() which has been reported against the AMD
pin-ctrl driver.

Provide generic_handle_domain_irq_safe() which can used from any context.

[ tglx: Split the usage sites out and massaged changelog ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/YnkfWFzvusFFktSt@linutronix.de
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215954
---
 include/linux/irqdesc.h |  1 +
 kernel/irq/irqdesc.c    | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 1cd4e36..844a8e3 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -169,6 +169,7 @@ int generic_handle_irq_safe(unsigned int irq);
  * conversion failed.
  */
 int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq);
+int generic_handle_domain_irq_safe(struct irq_domain *domain, unsigned int hwirq);
 int generic_handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq);
 #endif
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 5db0230..a91f900 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -705,6 +705,30 @@ int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
 }
 EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
 
+ /**
+ * generic_handle_irq_safe - Invoke the handler for a HW irq belonging
+ *			     to a domain from any context.
+ * @domain:	The domain where to perform the lookup
+ * @hwirq:	The HW irq number to convert to a logical one
+ *
+ * Returns:	0 on success, a negative value on error.
+ *
+ * This function can be called from any context (IRQ or process
+ * context). If the interrupt is marked as 'enforce IRQ-context only' then
+ * the function must be invoked from hard interrupt context.
+ */
+int generic_handle_domain_irq_safe(struct irq_domain *domain, unsigned int hwirq)
+{
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+	ret = handle_irq_desc(irq_resolve_mapping(domain, hwirq));
+	local_irq_restore(flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(generic_handle_domain_irq_safe);
+
 /**
  * generic_handle_domain_nmi - Invoke the handler for a HW nmi belonging
  *                             to a domain.
