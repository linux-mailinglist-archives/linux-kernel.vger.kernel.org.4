Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172CE71A36A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjFAP5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFAP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:57:20 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA30AB3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:57:19 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351FHZik010627;
        Thu, 1 Jun 2023 17:56:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=J2XhhDlTFWe9QBoqWhVSk0LMiIjX30rM1uG7DPXXW5A=;
 b=klyqao+EHAhU8SFZOwnVtxMsM6VugNVH/EObvuG5duZlvFM74gJ285xS8cuur170CBNc
 2UHC6W0gWtouEYboUdW/5CjV9XWv7lk2ipt7DjdAsSk2naih4ChgFu9ykAL2q7Utv+Lt
 bm/JHqZOYdU9pVct3SmDtZGUh/ftCglDjL62ZCgCbsMkP9liRq9FUB97R/l7uSV4dSu1
 s/4LI9tzJP3x4X09dFF7PCPDBbqaxltt1iCKePet8ENQyfe52vJsZJHp+MidNHE4EQVA
 Vh2GE46fICar2lG87CQ8E38xPM9BaVjSin7h5q+XTTlxRniBUEfu0WsrPQBYNtjU6SZM Kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qx31524mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 17:56:32 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A2FA310002A;
        Thu,  1 Jun 2023 17:56:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 97D6325AEE2;
        Thu,  1 Jun 2023 17:56:30 +0200 (CEST)
Received: from localhost (10.48.0.39) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 1 Jun
 2023 17:56:30 +0200
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <llvm@lists.linux.dev>
CC:     Antonio Borneo <antonio.borneo@foss.st.com>
Subject: [PATCH] irqchip/stm32-exti: Fix warning on initialized field overwritten
Date:   Thu, 1 Jun 2023 17:56:14 +0200
Message-ID: <20230601155614.34490-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.39]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/irqchip/irq-stm32-exti.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 6a3f7498ea8e..8bbb2b114636 100644
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
@@ -266,6 +276,8 @@ static const u8 stm32mp13_desc_irq[] = {
 	[70] = 98,
 };
 
+__diag_pop();
+
 static const struct stm32_exti_drv_data stm32mp1_drv_data = {
 	.exti_banks = stm32mp1_exti_banks,
 	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),

base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
-- 
2.40.1

