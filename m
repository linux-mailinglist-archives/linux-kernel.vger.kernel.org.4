Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E46733EBE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjFQGkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbjFQGj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:39:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A662721
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 23:39:50 -0700 (PDT)
Date:   Sat, 17 Jun 2023 06:39:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686983989;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPimK1iyu3ET4oiKhjVVm6mxD6AM4GpcQwzjF03kd2g=;
        b=4329rfiEVMWFCjHvs3PWV9aSPy4tBMs/tQA4uW0eMUYnj3W2eKovJsUDAJiyx/y1XVSsIU
        GExRdyHsMC2ft2uxv2XeQKfqI//+dvEF62m42E+Bi7isdrTAsYX5x8KPYxEMmOxy2jp+v3
        oykRo2IwUIU4dazyqhuS9TsU/gLCUs3j8TuFPTtepyMutltdLLNnwTRA58vI+aIVJA6IW5
        mBgCrtxR1cuNzyKKE0vcCoSqG7a7pifcSerO0y+ZIcK8+iCbaVQxH8DTsoLYaTIjB3POMf
        YsF+Gj2mGufIkPExV6h33SQfcHfZDNhYzoMNnnLQlydOo34RfyifMXcMMIh0ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686983989;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPimK1iyu3ET4oiKhjVVm6mxD6AM4GpcQwzjF03kd2g=;
        b=r0Ylkbjc2f/0KGXwSyA7j5TQJ3tATc7PI52WeKETVQZkRuxigfCoxkBin8syhpAIkK7IPA
        RxUb2kIWmtRwqKCQ==
From:   "irqchip-bot for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/stm32-exti: Fix warning on
 initialized field overwritten
Cc:     Antonio Borneo <antonio.borneo@foss.st.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230601155614.34490-1-antonio.borneo@foss.st.com>
References: <20230601155614.34490-1-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Message-ID: <168698398820.404.1898866830795273439.tip-bot2@tip-bot2>
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

Commit-ID:     48f31e496488a25f443c0df52464da446fb1d10c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/48f31e496488a25f443c0df52464da446fb1d10c
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Thu, 01 Jun 2023 17:56:14 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 17 Jun 2023 07:30:00 +01:00

irqchip/stm32-exti: Fix warning on initialized field overwritten

While compiling with W=1, both gcc and clang complain about a
tricky way to initialize an array by filling it with a non-zero
value and then overrride some of the array elements.
In this case the override is intentional, so just disable the
specific warning for only this part of the code.

Note: the flag "-Woverride-init" is recognized by both compilers,
but the warning msg from clang reports "-Winitializer-overrides".
The doc of clang clarifies that the two flags are synonyms, so use
here only the flag name common on both compilers.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Fixes: c297493336b7 ("irqchip/stm32-exti: Simplify irq description table")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230601155614.34490-1-antonio.borneo@foss.st.com
---
 drivers/irqchip/irq-stm32-exti.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index f684be7..b5fa76c 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -173,6 +173,16 @@ static struct irq_chip stm32_exti_h_chip_direct;
 #define EXTI_INVALID_IRQ       U8_MAX
 #define STM32MP1_DESC_IRQ_SIZE (ARRAY_SIZE(stm32mp1_exti_banks) * IRQS_PER_BANK)
 
+/*
+ * Use some intentionally tricky logic here to initialize the whole array to
+ * EXTI_INVALID_IRQ, but then override certain fields, requiring us to indicate
+ * that we "know" that there are overrides in this structure, and we'll need to
+ * disable that warning from W=1 builds.
+ */
+__diag_push();
+__diag_ignore_all("-Woverride-init",
+		  "logic to initialize all and then override some is OK");
+
 static const u8 stm32mp1_desc_irq[] = {
 	/* default value */
 	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
@@ -267,6 +277,8 @@ static const u8 stm32mp13_desc_irq[] = {
 	[70] = 98,
 };
 
+__diag_pop();
+
 static const struct stm32_exti_drv_data stm32mp1_drv_data = {
 	.exti_banks = stm32mp1_exti_banks,
 	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
