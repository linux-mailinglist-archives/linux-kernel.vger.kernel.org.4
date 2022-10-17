Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B876005D0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 05:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiJQDnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 23:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiJQDnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 23:43:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D5850197
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94066B80CC2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C06C433C1;
        Mon, 17 Oct 2022 03:43:03 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 3/4] irqchip/loongson-pch-pic: Add suspend/resume support
Date:   Mon, 17 Oct 2022 11:39:03 +0800
Message-Id: <20221017033904.2421723-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221017033904.2421723-1-chenhuacai@loongson.cn>
References: <20221017033904.2421723-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend/resume support for PCH-PIC irqchip, which is needed for
upcoming suspend/hibernation.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-pch-pic.c | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index c01b9c257005..217513d74664 100644
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
@@ -228,6 +233,46 @@ static void pch_pic_reset(struct pch_pic *priv)
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
@@ -260,6 +305,8 @@ static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
 	pch_pic_handle[nr_pics] = domain_handle;
 	pch_pic_priv[nr_pics++] = priv;
 
+	register_syscore_ops(&pch_pic_syscore_ops);
+
 	return 0;
 
 iounmap_base:
-- 
2.31.1

