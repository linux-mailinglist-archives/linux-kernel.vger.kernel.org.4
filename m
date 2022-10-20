Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0317A6058BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiJTHft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiJTHfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:35:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF728148F65
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:35:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B693B80B45
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE48C433C1;
        Thu, 20 Oct 2022 07:35:30 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] irqchip/loongarch: Adjust acpi_cascade_irqdomain_init() and sub-routines
Date:   Thu, 20 Oct 2022 15:33:46 +0800
Message-Id: <20221020073346.536494-1-chenhuacai@loongson.cn>
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

1, Adjust prototype of acpi_cascade_irqdomain_init() because we don't
   need its return value.
2, Combine unnecessary short lines to one long line.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongarch-cpu.c    | 19 +++++++------------
 drivers/irqchip/irq-loongson-eiointc.c | 19 +++++++------------
 drivers/irqchip/irq-loongson-pch-pic.c | 11 ++++-------
 3 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 741612ba6a52..093609c8eaa7 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -92,31 +92,26 @@ static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
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
 
 	return eiointc_acpi_init(irq_domain, eiointc_entry);
 }
 
-static int __init acpi_cascade_irqdomain_init(void)
+static void __init acpi_cascade_irqdomain_init(void)
 {
-	acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC,
-			      liointc_parse_madt, 0);
-	acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC,
-			      eiointc_parse_madt, 0);
-	return 0;
+	acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC, liointc_parse_madt, 0);
+	acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC, eiointc_parse_madt, 0);
 }
 
 static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 16e9af8d8b1e..efead0bfb1ca 100644
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
@@ -328,13 +326,10 @@ pch_msi_parse_madt(union acpi_subtable_headers *header,
 	return -EINVAL;
 }
 
-static int __init acpi_cascade_irqdomain_init(void)
+static void __init acpi_cascade_irqdomain_init(void)
 {
-	acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC,
-			      pch_pic_parse_madt, 0);
-	acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC,
-			      pch_msi_parse_madt, 1);
-	return 0;
+	acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC, pch_pic_parse_madt, 0);
+	acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
 }
 
 int __init eiointc_acpi_init(struct irq_domain *parent,
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index c01b9c257005..d2cf54a87bee 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -325,20 +325,17 @@ int find_pch_pic(u32 gsi)
 	return -1;
 }
 
-static int __init
-pch_lpc_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
+static int __init pch_lpc_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
 {
 	struct acpi_madt_lpc_pic *pchlpc_entry = (struct acpi_madt_lpc_pic *)header;
 
 	return pch_lpc_acpi_init(pch_pic_priv[0]->pic_domain, pchlpc_entry);
 }
 
-static int __init acpi_cascade_irqdomain_init(void)
+static void __init acpi_cascade_irqdomain_init(void)
 {
-	acpi_table_parse_madt(ACPI_MADT_TYPE_LPC_PIC,
-			      pch_lpc_parse_madt, 0);
-	return 0;
+	acpi_table_parse_madt(ACPI_MADT_TYPE_LPC_PIC, pch_lpc_parse_madt, 0);
 }
 
 int __init pch_pic_acpi_init(struct irq_domain *parent,
-- 
2.31.1

