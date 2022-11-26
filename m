Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E526563962D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKZNfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKZNey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:34:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077C419033
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:41 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469679;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7vAvqErmjHVG45h+ZJaduBooqBOz5E+TEsLc743Podw=;
        b=nCs8g9N0UKkT+hNMGTcC/TRguju4fwWn+3JY0lzZGtehPpz0L1Kkbu3mgTCdztNwyeh8mz
        GwFBknEHks/3LI2qL2Ojv0+v6qF4ibgj1P7WlSisW2HWbl6YaXttyVzevOjVeRnCsxg4Dl
        lPvXlXaPR7BKdl8kWwLinfnGc+P8iBCh51ZwkzL5g2Qf5JNTxVOZLEXp5+bWHZzg13j/tI
        9AzM2MPaRBwsVvNU5oOVGL9uX8YKy6mHz+epCNCI0AKD93CuaPUaXkGaMgQDbCXO0IxQQX
        b6gNOGEXsVT+ObWzmL6ba21+KtS/bQ4hboYhN42Wul6SbOUzCABmDAGabexltg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469679;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7vAvqErmjHVG45h+ZJaduBooqBOz5E+TEsLc743Podw=;
        b=jYvprGksGlW5BoqU5UpKKNxt9Q4jYDWP4X27c/GBYN10NAD141/VfkjYRrQAV/2dI9ULaM
        r+qOT6IzXCdH9dAA==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-eiointc: Add
 suspend/resume support
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221020073527.541845-3-chenhuacai@loongson.cn>
References: <20221020073527.541845-3-chenhuacai@loongson.cn>
MIME-Version: 1.0
Message-ID: <166946967829.4906.5902688753005377068.tip-bot2@tip-bot2>
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

Commit-ID:     a90335c2dfb4ffe572816f77a3c4f2d1d388d724
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a90335c2dfb4ffe572816f77a3c4f2d1d388d724
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Thu, 20 Oct 2022 15:35:25 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 13:12:12 

irqchip/loongson-eiointc: Add suspend/resume support

Add suspend/resume support for EIOINTC irqchip, which is needed for
upcoming suspend/hibernation.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221020073527.541845-3-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongson-eiointc.c | 33 +++++++++++++++++++++++++-
 1 file changed, 33 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 16e9af8..5cf4b80 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -17,6 +17,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/syscore_ops.h>
 
 #define EIOINTC_REG_NODEMAP	0x14a0
 #define EIOINTC_REG_IPMAP	0x14c0
@@ -301,6 +302,37 @@ static struct irq_domain *acpi_get_vec_parent(int node, struct acpi_vector_group
 	return NULL;
 }
 
+static int eiointc_suspend(void)
+{
+	return 0;
+}
+
+static void eiointc_resume(void)
+{
+	int i, j;
+	struct irq_desc *desc;
+	struct irq_data *irq_data;
+
+	eiointc_router_init(0);
+
+	for (i = 0; i < nr_pics; i++) {
+		for (j = 0; j < VEC_COUNT; j++) {
+			desc = irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
+			if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
+				raw_spin_lock(&desc->lock);
+				irq_data = &desc->irq_data;
+				eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
+				raw_spin_unlock(&desc->lock);
+			}
+		}
+	}
+}
+
+static struct syscore_ops eiointc_syscore_ops = {
+	.suspend = eiointc_suspend,
+	.resume = eiointc_resume,
+};
+
 static int __init
 pch_pic_parse_madt(union acpi_subtable_headers *header,
 		       const unsigned long end)
@@ -380,6 +412,7 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 	parent_irq = irq_create_mapping(parent, acpi_eiointc->cascade);
 	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
 
+	register_syscore_ops(&eiointc_syscore_ops);
 	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
 				  "irqchip/loongarch/intc:starting",
 				  eiointc_router_init, NULL);
