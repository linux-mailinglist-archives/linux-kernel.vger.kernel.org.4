Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA8463A76B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiK1Lx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiK1Lx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:53:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAC2B1CC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:53:55 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:53:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669636434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YtL6Af3VEuxIb9nNzbuRAY2P4xAKy98cTKdZ26I/ZOc=;
        b=dA3+gYirGFrVzWE9AjDbLyXKXd40FOdOA6LQdKGtdW45zp5CqsH6QFerBIRPeOf1Tww8nG
        QjAww+iJk0P4indm2rsiJObsL6VmExfI9EmddwaM1CC2Lvf17O+MtT8BxSn/BS6JrLhOGe
        vXUEl7YucssNOiYa2PqRXbT+FRZxry1uOu5AJ/TS0ehQXZLo75iukw31mi9VhGS5buFIJ2
        rL17tQxKln5IFx0zn6DP2PkumS06NM1kHzAJd1BmsKikYrpPPYjd8mj41bOAKjcGLkGdkb
        VYKyISw1G4Iub2RrEIUU80mkSXtK4tzd7898q0jwjBbQ+9yGEAsNihra9N1E3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669636434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YtL6Af3VEuxIb9nNzbuRAY2P4xAKy98cTKdZ26I/ZOc=;
        b=335OyTM8u9SRutGFxaEtesnzhrENQ5FFoRI+QGiLjqPtGOIocDud8y6jEtl458kL1jJP7j
        lwTtNbKwoLpkTMBg==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongarch: Adjust
 acpi_cascade_irqdomain_init() and sub-routines
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221020142514.1725514-1-chenhuacai@loongson.cn>
References: <20221020142514.1725514-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Message-ID: <166963643290.4906.12034977441732808858.tip-bot2@tip-bot2>
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

Commit-ID:     3d12938dbc048ecb193fec69898d95f6b4813a4b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3d12938dbc048ecb193fec69898d95f6b4813a4b
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Thu, 20 Oct 2022 22:25:14 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 28 Nov 2022 11:49:31 

irqchip/loongarch: Adjust acpi_cascade_irqdomain_init() and sub-routines

1, Adjust the return of acpi_cascade_irqdomain_init() and check its
   return value.
2, Combine unnecessary short lines to one long line.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221020142514.1725514-1-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongarch-cpu.c    | 30 +++++++++++++++----------
 drivers/irqchip/irq-loongson-eiointc.c | 30 ++++++++++++++-----------
 drivers/irqchip/irq-loongson-pch-pic.c | 15 +++++++------
 3 files changed, 44 insertions(+), 31 deletions(-)

diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 741612b..fdec3e9 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -92,18 +92,16 @@ static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
-static int __init
-liointc_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int __init liointc_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_lio_pic *liointc_entry = (struct acpi_madt_lio_pic *)header;
 
 	return liointc_acpi_init(irq_domain, liointc_entry);
 }
 
-static int __init
-eiointc_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int __init eiointc_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_eio_pic *eiointc_entry = (struct acpi_madt_eio_pic *)header;
 
@@ -112,16 +110,24 @@ eiointc_parse_madt(union acpi_subtable_headers *header,
 
 static int __init acpi_cascade_irqdomain_init(void)
 {
-	acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC,
-			      liointc_parse_madt, 0);
-	acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC,
-			      eiointc_parse_madt, 0);
+	int r;
+
+	r = acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC, liointc_parse_madt, 0);
+	if (r < 0)
+		return r;
+
+	r = acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC, eiointc_parse_madt, 0);
+	if (r < 0)
+		return r;
+
 	return 0;
 }
 
 static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
 				   const unsigned long end)
 {
+	int ret;
+
 	if (irq_domain)
 		return 0;
 
@@ -139,9 +145,9 @@ static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
 	set_handle_irq(&handle_cpu_irq);
 	acpi_set_irq_model(ACPI_IRQ_MODEL_LPIC, lpic_get_gsi_domain_id);
 	acpi_set_gsi_to_irq_fallback(lpic_gsi_to_irq);
-	acpi_cascade_irqdomain_init();
+	ret = acpi_cascade_irqdomain_init();
 
-	return 0;
+	return ret;
 }
 
 IRQCHIP_ACPI_DECLARE(cpuintc_v1, ACPI_MADT_TYPE_CORE_PIC,
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 5cf4b80..d15fd38 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -333,9 +333,8 @@ static struct syscore_ops eiointc_syscore_ops = {
 	.resume = eiointc_resume,
 };
 
-static int __init
-pch_pic_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int __init pch_pic_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_bio_pic *pchpic_entry = (struct acpi_madt_bio_pic *)header;
 	unsigned int node = (pchpic_entry->address >> 44) & 0xf;
@@ -347,9 +346,8 @@ pch_pic_parse_madt(union acpi_subtable_headers *header,
 	return -EINVAL;
 }
 
-static int __init
-pch_msi_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
 	struct irq_domain *parent = acpi_get_vec_parent(eiointc_priv[nr_pics - 1]->node, msi_group);
@@ -362,17 +360,23 @@ pch_msi_parse_madt(union acpi_subtable_headers *header,
 
 static int __init acpi_cascade_irqdomain_init(void)
 {
-	acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC,
-			      pch_pic_parse_madt, 0);
-	acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC,
-			      pch_msi_parse_madt, 1);
+	int r;
+
+	r = acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC, pch_pic_parse_madt, 0);
+	if (r < 0)
+		return r;
+
+	r = acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
+	if (r < 0)
+		return r;
+
 	return 0;
 }
 
 int __init eiointc_acpi_init(struct irq_domain *parent,
 				     struct acpi_madt_eio_pic *acpi_eiointc)
 {
-	int i, parent_irq;
+	int i, ret, parent_irq;
 	unsigned long node_map;
 	struct eiointc_priv *priv;
 
@@ -419,9 +423,9 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 
 	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, pch_group);
 	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, msi_group);
-	acpi_cascade_irqdomain_init();
+	ret = acpi_cascade_irqdomain_init();
 
-	return 0;
+	return ret;
 
 out_free_handle:
 	irq_domain_free_fwnode(priv->domain_handle);
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index 1fd015e..437f1af 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -378,9 +378,8 @@ int find_pch_pic(u32 gsi)
 	return -1;
 }
 
-static int __init
-pch_lpc_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int __init pch_lpc_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_lpc_pic *pchlpc_entry = (struct acpi_madt_lpc_pic *)header;
 
@@ -389,8 +388,12 @@ pch_lpc_parse_madt(union acpi_subtable_headers *header,
 
 static int __init acpi_cascade_irqdomain_init(void)
 {
-	acpi_table_parse_madt(ACPI_MADT_TYPE_LPC_PIC,
-			      pch_lpc_parse_madt, 0);
+	int r;
+
+	r = acpi_table_parse_madt(ACPI_MADT_TYPE_LPC_PIC, pch_lpc_parse_madt, 0);
+	if (r < 0)
+		return r;
+
 	return 0;
 }
 
@@ -417,7 +420,7 @@ int __init pch_pic_acpi_init(struct irq_domain *parent,
 	}
 
 	if (acpi_pchpic->id == 0)
-		acpi_cascade_irqdomain_init();
+		ret = acpi_cascade_irqdomain_init();
 
 	return ret;
 }
