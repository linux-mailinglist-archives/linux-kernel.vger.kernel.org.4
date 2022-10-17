Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B719E6005CD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 05:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiJQDlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 23:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiJQDlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 23:41:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8290E50051
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:41:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40EE5B80D4B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7CEC433D7;
        Mon, 17 Oct 2022 03:41:39 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 1/4] irqchip/loongson-htvec: Add suspend/resume support
Date:   Mon, 17 Oct 2022 11:39:01 +0800
Message-Id: <20221017033904.2421723-2-chenhuacai@loongson.cn>
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

Add suspend/resume support for HTVEC irqchip, which is needed for
upcoming suspend/hibernation.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-htvec.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 1bb414ec6e78..cd4f1a0a1ea8 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/syscore_ops.h>
 
 /* Registers */
 #define HTVEC_EN_OFF		0x20
@@ -29,6 +30,7 @@ struct htvec {
 	void __iomem		*base;
 	struct irq_domain	*htvec_domain;
 	raw_spinlock_t		htvec_lock;
+	u32			saved_vec_en[HTVEC_MAX_PARENT_IRQ];
 };
 
 static struct htvec *htvec_priv;
@@ -156,6 +158,29 @@ static void htvec_reset(struct htvec *priv)
 	}
 }
 
+static int htvec_suspend(void)
+{
+	int i;
+
+	for (i = 0; i < htvec_priv->num_parents; i++)
+		htvec_priv->saved_vec_en[i] = readl(htvec_priv->base + HTVEC_EN_OFF + 4 * i);
+
+	return 0;
+}
+
+static void htvec_resume(void)
+{
+	int i;
+
+	for (i = 0; i < htvec_priv->num_parents; i++)
+		writel(htvec_priv->saved_vec_en[i], htvec_priv->base + HTVEC_EN_OFF + 4 * i);
+}
+
+static struct syscore_ops htvec_syscore_ops = {
+	.suspend = htvec_suspend,
+	.resume = htvec_resume,
+};
+
 static int htvec_init(phys_addr_t addr, unsigned long size,
 		int num_parents, int parent_irq[], struct fwnode_handle *domain_handle)
 {
@@ -188,6 +213,8 @@ static int htvec_init(phys_addr_t addr, unsigned long size,
 
 	htvec_priv = priv;
 
+	register_syscore_ops(&htvec_syscore_ops);
+
 	return 0;
 
 iounmap_base:
-- 
2.31.1

