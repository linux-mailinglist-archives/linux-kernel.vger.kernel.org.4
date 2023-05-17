Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AF670727A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjEQToI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEQToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:44:07 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5225E44;
        Wed, 17 May 2023 12:44:05 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2571286248;
        Wed, 17 May 2023 21:44:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684352644;
        bh=JUWlT/mVtLPWa8lH5GJ6Zgl2QWAiiG8X5GfcbkGKLpI=;
        h=From:To:Cc:Subject:Date:From;
        b=ZZ1DJ/f4n8SLdrPsuOSthMfzFfcXRBbY1MUyjl3RaOo2jk97uvGVe4TW34if0xNL7
         vFtPpher2CgWXSJwAGXLTYhmb6s+PHQtFDy/9MmcZaTHg8nO/KcdFQeXpyTzZVShCv
         LP5eXIKR0tsYJcE5IPD2r37NXGPhI4c08L1BMD9va3Pxdxa3E2sLolPUqVCg3JaKeH
         uOectqW7vRoVsZ4iHUQPtIiadMu9v/L5RFhrDouFT5Ty2QY3/+zrnqs6ZthtvrGTwq
         TCQSh6DLOm3GUO3pAa5qZdD/pkFW8t2ur2e70k3kxOvWOvjTFSLHp+WCFC0rszgDnA
         koA+HQcBfiXkw==
From:   Marek Vasut <marex@denx.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marex@denx.de>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v2 1/3] irqchip/stm32-exti: Add STM32MP15xx IWDG2 EXTI to GIC map
Date:   Wed, 17 May 2023 21:43:47 +0200
Message-Id: <20230517194349.105745-1-marex@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EXTI interrupt 46 is mapped to GIC interrupt 151. Add the
missing mapping, which is used for IWDG2 pretimeout interrupt
and wake up source.

Reviewed-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-watchdog@vger.kernel.org
---
V2: Add RB from Antonio
---
 drivers/irqchip/irq-stm32-exti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 6a3f7498ea8ea..f684be77ba378 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -208,6 +208,7 @@ static const u8 stm32mp1_desc_irq[] = {
 	[31] = 53,
 	[32] = 82,
 	[33] = 83,
+	[46] = 151,
 	[47] = 93,
 	[48] = 138,
 	[50] = 139,
-- 
2.39.2

