Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059747330B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345148AbjFPMDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345040AbjFPMDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:03:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC84EE4;
        Fri, 16 Jun 2023 05:03:12 -0700 (PDT)
Date:   Fri, 16 Jun 2023 12:03:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686916991;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/pmNvkTQWeIB6THnRfnyvc2JzpUvZrwf6FOHVx4vhfE=;
        b=PKAZC+bhVu//75FcshxwdBAUcVj4D2ooO1qFUjyXxmVqD+Hy5VP2YuDvAtXILv9fIsvAfW
        wGBybbHyuS37eNflUS66TspDJotABJhB7iU0MwXlaqFRRvj5gZZWP6aZkIFfIT4tcYkMVB
        1kyBksQaOLY0yPOokF0QyxLzsP3Js4in8wz+BSZ+zPSC8d6Bz5+z3Gk0JQxPwpMUOtU06M
        RaikrMp56PD+Q1+WX5QpJkA4cY9U8+pIgDSYzAlWd+QHTste7WSmqoUbBUhXk7NTHqHaIJ
        5JFotXw+dR8t9+e0E3XfpzgqoeWeVm4Okuayv/jfqp7uEmvOYSe4vxsPTczO4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686916991;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/pmNvkTQWeIB6THnRfnyvc2JzpUvZrwf6FOHVx4vhfE=;
        b=kfYvBoKycUpp7hQxxljkAMRJkqTDdshSt3VD3bjKEZ9C/BcqpIl77VfdPOaRkSErQobIzE
        SHMMCmXaltz6zxCA==
From:   "irqchip-bot for Jianmin Lv" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-pch-pic: Fix
 initialization of HT vector register
Cc:     stable@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
        liuyun <liuyun@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230614115936.5950-2-lvjianmin@loongson.cn>
References: <20230614115936.5950-2-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <168691699075.404.770977987858659186.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     f679616565f1cf1a4acb245dbc0032dafcd40637
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/f679616565f1cf1a4acb245dbc0032dafcd40637
Author:        Jianmin Lv <lvjianmin@loongson.cn>
AuthorDate:    Wed, 14 Jun 2023 19:59:32 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 16 Jun 2023 12:59:28 +01:00

irqchip/loongson-pch-pic: Fix initialization of HT vector register

In an ACPI-based dual-bridge system, IRQ of each bridge's
PCH PIC sent to CPU is always a zero-based number, which
means that the IRQ on PCH PIC of each bridge is mapped into
vector range from 0 to 63 of upstream irqchip(e.g. EIOINTC).

      EIOINTC N: [0 ... 63 | 64 ... 255]
                  --------   ----------
                      ^          ^
                      |          |
                  PCH PIC N      |
                             PCH MSI N

For example, the IRQ vector number of sata controller on
PCH PIC of each bridge is 16, which is sent to upstream
irqchip of EIOINTC when an interrupt occurs, which will set
bit 16 of EIOINTC. Since hwirq of 16 on EIOINTC has been
mapped to a irq_desc for sata controller during hierarchy
irq allocation, the related mapped IRQ will be found through
irq_resolve_mapping() in the IRQ domain of EIOINTC.

So, the IRQ number set in HT vector register should be fixed
to be a zero-based number.

Cc: stable@vger.kernel.org
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Co-developed-by: liuyun <liuyun@loongson.cn>
Signed-off-by: liuyun <liuyun@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230614115936.5950-2-lvjianmin@loongson.cn
---
 drivers/irqchip/irq-loongson-pch-pic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index e5fe4d5..921c5c0 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -401,14 +401,12 @@ static int __init acpi_cascade_irqdomain_init(void)
 int __init pch_pic_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_bio_pic *acpi_pchpic)
 {
-	int ret, vec_base;
+	int ret;
 	struct fwnode_handle *domain_handle;
 
 	if (find_pch_pic(acpi_pchpic->gsi_base) >= 0)
 		return 0;
 
-	vec_base = acpi_pchpic->gsi_base - GSI_MIN_PCH_IRQ;
-
 	domain_handle = irq_domain_alloc_fwnode(&acpi_pchpic->address);
 	if (!domain_handle) {
 		pr_err("Unable to allocate domain handle\n");
@@ -416,7 +414,7 @@ int __init pch_pic_acpi_init(struct irq_domain *parent,
 	}
 
 	ret = pch_pic_init(acpi_pchpic->address, acpi_pchpic->size,
-				vec_base, parent, domain_handle, acpi_pchpic->gsi_base);
+				0, parent, domain_handle, acpi_pchpic->gsi_base);
 
 	if (ret < 0) {
 		irq_domain_free_fwnode(domain_handle);
