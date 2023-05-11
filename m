Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1025F6FE87D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 02:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbjEKAUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 20:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbjEKAUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 20:20:14 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC765276;
        Wed, 10 May 2023 17:20:11 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C6EF1860B5;
        Thu, 11 May 2023 02:20:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683764410;
        bh=cMWsdqqR/k7zantlDh1d1yj4kxNqX+XUZVoR17bWKo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ch+8Y/AjeEeKXxuF3ahse8H8zIlH4LQJJUSTLe4Y/vZusBqGliN/ODbZhRN0WCNj6
         WsEQ1l1h00UlJWwqlEumSx4LSgetYoDmJT2kylxtI0baZYtUy5M6LrbXEQiZM5iM/w
         s0ACHA9TVZzk4/3lUjKH1Xub1KJAPV0mGfJwUAFRevJwUsb64TWN5S5SdmJInwjKZY
         9QXd6jyYWM5J7+yNHFd6m7lodcIAjWVhQlhJpU7rwR9v2GT5YS8Yjb2jHPqVrmD920
         tphfAg1IeN12JsW3MMfrLaLJDFuLWzeWjQ+XcLO9tf+FXnDlR9fHMvgEy1CfMudjqt
         NVgAGNBLfGduA==
From:   Marek Vasut <marex@denx.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marex@denx.de>,
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
Subject: [PATCH 3/3] ARM: dts: stm32: Add IWDG2 EXTI interrupt mapping and mark as wakeup source
Date:   Thu, 11 May 2023 02:19:49 +0200
Message-Id: <20230511001949.179521-3-marex@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511001949.179521-1-marex@denx.de>
References: <20230511001949.179521-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 arch/arm/boot/dts/stm32mp151.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 63f4c78fcc1dc..792324b6f9b6a 100644
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

