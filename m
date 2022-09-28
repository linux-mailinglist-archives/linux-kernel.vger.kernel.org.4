Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9BB5EDDD9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiI1Nhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiI1Nh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:37:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B608E0FE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:37:24 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:37:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664372243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezA3nOAK0hQ5krIIxLg2+ffpT67T6wPcZS73xL5As4M=;
        b=2/beQCKmNnmkHNidykrnIAvJ4FFGuTw/uDpcAXPXU/5/4zNQLNZ2iplJR1GO2mPFn+cRuV
        8ieXvT1r6Yw2qj4oS58QFSJYo1ZhvE9i76VWLWNOIYofP5hsHjwjsFmvzyUb9kpz/2seiq
        jLeBwTmv6Hs9uTdYy6PWAhpMJNF6JqP/8z0VkViVLo1qww/Jcgmb60OlsFr/g3rbZATaat
        Ewru0F42vtKpp80iqvErA3dqFgNaoMv/jEdQQDT+oRJGPvmvWbhoNd0I5yk2N4b9MUfBGM
        6Kqak2HNq1aGzQBS92nEnLK3Ft/nsigMthcs4p4k6+kG1w/RVpCNk0F0JNN4hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664372243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezA3nOAK0hQ5krIIxLg2+ffpT67T6wPcZS73xL5As4M=;
        b=xptjYPb83iHQNw+Xz4V7RC3B2L9Qc1nT1p8qDEJ5v81gYc9xOZRZGqGZpz3KhA+B+Ovh2A
        zgZcFSw5uGQovSDw==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: Make irqchip_init() usable on
 pure ACPI systems
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220927124557.3246737-1-chenhuacai@loongson.cn>
References: <20220927124557.3246737-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Message-ID: <166437224234.401.12622502106684377053.tip-bot2@tip-bot2>
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

Commit-ID:     612d5494aef9bd2ab68d585a8c0ac2b16d12d520
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/612d5494aef9bd2ab68d585a8c0ac2b16d12d520
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Tue, 27 Sep 2022 20:45:57 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 28 Sep 2022 14:11:28 +01:00

irqchip: Make irqchip_init() usable on pure ACPI systems

Pure ACPI systems (e.g., LoongArch) do not need OF_IRQ, but still
require irqchip_init() to perform the ACPI irqchip probing,
even when OF_IRQ isn't selected.

Relax the dependency to enable the generic irqchip support when
ACPI_GENERIC_GSI is configured.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>
[maz: revamped commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220927124557.3246737-1-chenhuacai@loongson.cn
---
 drivers/irqchip/Kconfig | 2 +-
 include/linux/of_irq.h  | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 66b9fa4..93ad04d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -3,7 +3,7 @@ menu "IRQ chip support"
 
 config IRQCHIP
 	def_bool y
-	depends on OF_IRQ
+	depends on (OF_IRQ || ACPI_GENERIC_GSI)
 
 config ARM_GIC
 	bool
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 83fccd0..d6d3eae 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -37,9 +37,8 @@ extern unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data);
 extern int of_irq_to_resource(struct device_node *dev, int index,
 			      struct resource *r);
 
-extern void of_irq_init(const struct of_device_id *matches);
-
 #ifdef CONFIG_OF_IRQ
+extern void of_irq_init(const struct of_device_id *matches);
 extern int of_irq_parse_one(struct device_node *device, int index,
 			  struct of_phandle_args *out_irq);
 extern int of_irq_count(struct device_node *dev);
@@ -57,6 +56,9 @@ extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
 extern void of_msi_configure(struct device *dev, struct device_node *np);
 u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in);
 #else
+static inline void of_irq_init(const struct of_device_id *matches)
+{
+}
 static inline int of_irq_parse_one(struct device_node *device, int index,
 				   struct of_phandle_args *out_irq)
 {
