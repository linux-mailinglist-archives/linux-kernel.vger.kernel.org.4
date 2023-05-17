Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE7270727E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjEQToN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjEQToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:44:07 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054811B7;
        Wed, 17 May 2023 12:44:07 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E6C4C8624E;
        Wed, 17 May 2023 21:44:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684352645;
        bh=IE0HGdKCuoH9lgoiitzVjdPvmo8bKfxPWC16LngE2Ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYQj4CHVH/GJDtvMmmjufwX0FtN5j1I/FGHXrvyAA5Y94rmeQulI89AouflwEaSK/
         8radGsCmSblsxZZd0Jz31Qh5FBNY4I5G7Pv1Odm5k1diI/ZyKwHP/aI0sioP4HJ+zA
         uP5PSUXKMg52sE8EfjHwrExcSoRGhJ8pctchFNp60Z4xYfVLEAqgo0osMARXkdYU8K
         M1B8DwZw4MNBIzKnUN7SPHCwPPg8AMjl8Ru+TUtm48a1C79njbw882HLJNXryo2Erf
         ywvAsYwiWoq2vUg99VaW9ZLpSW0cTiK6JNFklwVkmSiWZmpVXwykQn5jI3ZqXOdpzR
         JzZqT8bOyb/pA==
From:   Marek Vasut <marex@denx.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
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
Subject: [PATCH v2 3/3] ARM: dts: stm32: Add IWDG2 EXTI interrupt mapping and mark as wakeup source
Date:   Wed, 17 May 2023 21:43:49 +0200
Message-Id: <20230517194349.105745-3-marex@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517194349.105745-1-marex@denx.de>
References: <20230517194349.105745-1-marex@denx.de>
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

The IWDG2 is capable of generating pre-timeout interrupt, which can be used
to wake the system up from suspend to mem. Add the EXTI interrupt mapping
and mark the IWDG2 as wake up source.

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
V2: No change
---
 arch/arm/boot/dts/stm32mp151.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 664825418c32c..accbeef4df6da 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1541,6 +1541,8 @@ iwdg2: watchdog@5a002000 {
 			reg = <0x5a002000 0x400>;
 			clocks = <&rcc IWDG2>, <&rcc CK_LSI>;
 			clock-names = "pclk", "lsi";
+			interrupts-extended = <&exti 46 IRQ_TYPE_LEVEL_HIGH>;
+			wakeup-source;
 			status = "disabled";
 		};
 
-- 
2.39.2

