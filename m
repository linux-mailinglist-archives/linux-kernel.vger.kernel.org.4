Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965EA6062F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiJTO1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJTO1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:27:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD04453D2C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:27:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67EBC61B9D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05EBC433C1;
        Thu, 20 Oct 2022 14:26:58 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2] irqchip/loongarch: Adjust acpi_cascade_irqdomain_init() and sub-routines
Date:   Thu, 20 Oct 2022 22:25:14 +0800
Message-Id: <20221020142514.1725514-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
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

1, Adjust the return of acpi_cascade_irqdomain_init() and check its
   return value.
2, Combine unnecessary short lines to one long line.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Adjust the return of acpi_cascade_irqdomain_init() and check its
    return value.

 drivers/irqchip/irq-loongarch-cpu.c    | 30 +++++++++++++++-----------
 drivers/irqchip/irq-loongson-eiointc.c | 30 +++++++++++++++-----------
 drivers/irqchip/irq-loongson-pch-pic.c | 15 +++++++------
 3 files changed, 44 insertions(+), 31 deletions(-)

diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 741612ba6a52..fdec3e9cfacf 100644
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
index 16e9af8d8b1e..62867209736c 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -301,9 +301,8 @@ static struct irq_domain *acpi_get_vec_parent(int node, struct acpi_vector_group
 	return NULL;
 }
 
-static int __init
-pch_pic_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int __init pch_pic_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_bio_pic *pchpic_entry = (struct acpi_madt_bio_pic *)header;
 	unsigned int node = (pchpic_entry->address >> 44) & 0xf;
@@ -315,9 +314,8 @@ pch_pic_parse_madt(union acpi_subtable_headers *header,
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
@@ -330,17 +328,23 @@ pch_msi_parse_madt(union acpi_subtable_headers *header,
 
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
 
@@ -386,9 +390,9 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 
 	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, pch_group);
 	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, msi_group);
-	acpi_cascade_irqdomain_init();
+	ret = acpi_cascade_irqdomain_init();
 
-	return 0;
+	return ret;
 
 out_free_handle:
 	irq_domain_free_fwnode(priv->domain_handle);
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index c01b9c257005..7477bbcf89fb 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -325,9 +325,8 @@ int find_pch_pic(u32 gsi)
 	return -1;
 }
 
-static int __init
-pch_lpc_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int __init pch_lpc_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_lpc_pic *pchlpc_entry = (struct acpi_madt_lpc_pic *)header;
 
@@ -336,8 +335,12 @@ pch_lpc_parse_madt(union acpi_subtable_headers *header,
 
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
 
@@ -364,7 +367,7 @@ int __init pch_pic_acpi_init(struct irq_domain *parent,
 	}
 
 	if (acpi_pchpic->id == 0)
-		acpi_cascade_irqdomain_init();
+		ret = acpi_cascade_irqdomain_init();
 
 	return ret;
 }
-- 
2.31.1

