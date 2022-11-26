Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D36163962C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiKZNfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKZNeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:34:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D2E1E3CA
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:39 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469678;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXelOIeTnWq/B7d3kCrEAia7XJOKqe4hI/29PU5/F1Y=;
        b=cFbnYhY/Q028CslfIk8bkXqqRJUQZqPEYwW6t8+Iyxrqi2mHQU2vPFp2f+UNOUdWJz3Fd7
        tCECl3X6s4uFQoDQb3zp6nifML4Vf2SbrFBo5Ri702X+cFPu3JtcBn+bJvnpYLmu048FL6
        wmPXGvj1wS/dhZxsUS+mV/FQlwDZuFxetdx9k0RX3mCYicS2P98mBsAVKnJ7XxxBfTonkO
        TCWJJNupPAOd5c1yxupjDVxg08d5CGFOCvpguwompy4VvhpTTLCRIUcXlW6N5e2qj0b1DY
        25RK88jH6xWHQIwZtBELSUvH7eXAukaY7VGJjlyIn7omSmNhi9mdEPzOp2Nniw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469678;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXelOIeTnWq/B7d3kCrEAia7XJOKqe4hI/29PU5/F1Y=;
        b=QYI2LFuKpJmIPN54MtLLa/t3Xh48S5D2D6iF9YCCyXuVYT5v1IZTCueXmGQ7AftHBpyjpz
        L5x6FYvmKU8VdzBQ==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-pch-pic: Add
 suspend/resume support
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221020073527.541845-4-chenhuacai@loongson.cn>
References: <20221020073527.541845-4-chenhuacai@loongson.cn>
MIME-Version: 1.0
Message-ID: <166946967714.4906.17115244088149452663.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     1ed008a2c3310ada91e86bd96b354212a9025a61
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1ed008a2c3310ada91e86bd96b354212a9025a61
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Thu, 20 Oct 2022 15:35:26 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 13:12:13 

irqchip/loongson-pch-pic: Add suspend/resume support

Add suspend/resume support for PCH-PIC irqchip, which is needed for
upcoming suspend/hibernation.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221020073527.541845-4-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongson-pch-pic.c | 47 +++++++++++++++++++++++++-
 1 file changed, 47 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index a26a3f5..1fd015e 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/syscore_ops.h>
 
 /* Registers */
 #define PCH_PIC_MASK		0x20
@@ -42,6 +43,9 @@ struct pch_pic {
 	raw_spinlock_t		pic_lock;
 	u32			vec_count;
 	u32			gsi_base;
+	u32			saved_vec_en[PIC_REG_COUNT];
+	u32			saved_vec_pol[PIC_REG_COUNT];
+	u32			saved_vec_edge[PIC_REG_COUNT];
 };
 
 static struct pch_pic *pch_pic_priv[MAX_IO_PICS];
@@ -145,6 +149,7 @@ static struct irq_chip pch_pic_irq_chip = {
 	.irq_ack		= pch_pic_ack_irq,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_set_type		= pch_pic_set_type,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
 static int pch_pic_domain_translate(struct irq_domain *d,
@@ -234,6 +239,46 @@ static void pch_pic_reset(struct pch_pic *priv)
 	}
 }
 
+static int pch_pic_suspend(void)
+{
+	int i, j;
+
+	for (i = 0; i < nr_pics; i++) {
+		for (j = 0; j < PIC_REG_COUNT; j++) {
+			pch_pic_priv[i]->saved_vec_pol[j] =
+				readl(pch_pic_priv[i]->base + PCH_PIC_POL + 4 * j);
+			pch_pic_priv[i]->saved_vec_edge[j] =
+				readl(pch_pic_priv[i]->base + PCH_PIC_EDGE + 4 * j);
+			pch_pic_priv[i]->saved_vec_en[j] =
+				readl(pch_pic_priv[i]->base + PCH_PIC_MASK + 4 * j);
+		}
+	}
+
+	return 0;
+}
+
+static void pch_pic_resume(void)
+{
+	int i, j;
+
+	for (i = 0; i < nr_pics; i++) {
+		pch_pic_reset(pch_pic_priv[i]);
+		for (j = 0; j < PIC_REG_COUNT; j++) {
+			writel(pch_pic_priv[i]->saved_vec_pol[j],
+					pch_pic_priv[i]->base + PCH_PIC_POL + 4 * j);
+			writel(pch_pic_priv[i]->saved_vec_edge[j],
+					pch_pic_priv[i]->base + PCH_PIC_EDGE + 4 * j);
+			writel(pch_pic_priv[i]->saved_vec_en[j],
+					pch_pic_priv[i]->base + PCH_PIC_MASK + 4 * j);
+		}
+	}
+}
+
+static struct syscore_ops pch_pic_syscore_ops = {
+	.suspend =  pch_pic_suspend,
+	.resume =  pch_pic_resume,
+};
+
 static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
 			struct irq_domain *parent_domain, struct fwnode_handle *domain_handle,
 			u32 gsi_base)
@@ -266,6 +311,8 @@ static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
 	pch_pic_handle[nr_pics] = domain_handle;
 	pch_pic_priv[nr_pics++] = priv;
 
+	register_syscore_ops(&pch_pic_syscore_ops);
+
 	return 0;
 
 iounmap_base:
