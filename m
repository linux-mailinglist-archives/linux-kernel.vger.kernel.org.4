Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5462642260
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 05:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiLEEuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 23:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiLEEuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 23:50:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32324BCB7
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 20:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8300B80D5E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B86C433D6;
        Mon,  5 Dec 2022 04:50:13 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        kernel test robot <lkp@intel.com>,
        Peibao Liu <liupeibao@loongson.cn>
Subject: [PATCH] irqchip: loongarch-cpu: Fix a missing prototype warning
Date:   Mon,  5 Dec 2022 12:47:08 +0800
Message-Id: <20221205044708.2054022-1-chenhuacai@loongson.cn>
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

1, Rename loongarch_cpu_irq_of_init() to cpuintc_of_init() in order to
   keep the same style as the ACPI version.
2, Fix a missing prototype warning by adding a "static" modifier.

Fixes: 855d4ca4bdb366aab3d4 ("irqchip: loongarch-cpu: add DT support")
Reported-by: kernel test robot <lkp@intel.com>
Cc: Peibao Liu <liupeibao@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongarch-cpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 00a47c011ec7..9d8f2c406043 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -93,7 +93,7 @@ static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
 };
 
 #ifdef CONFIG_OF
-int __init loongarch_cpu_irq_of_init(struct device_node *of_node,
+static int __init cpuintc_of_init(struct device_node *of_node,
 				struct device_node *parent)
 {
 	cpuintc_handle = of_node_to_fwnode(of_node);
@@ -107,8 +107,7 @@ int __init loongarch_cpu_irq_of_init(struct device_node *of_node,
 
 	return 0;
 }
-IRQCHIP_DECLARE(cpu_intc, "loongson,cpu-interrupt-controller",
-					loongarch_cpu_irq_of_init);
+IRQCHIP_DECLARE(cpu_intc, "loongson,cpu-interrupt-controller", cpuintc_of_init);
 #endif
 
 static int __init liointc_parse_madt(union acpi_subtable_headers *header,
-- 
2.31.1

