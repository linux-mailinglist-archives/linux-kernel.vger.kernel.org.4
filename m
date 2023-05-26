Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6727712D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243939AbjEZT35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243615AbjEZT3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:29:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1821D9;
        Fri, 26 May 2023 12:29:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso8122835e9.0;
        Fri, 26 May 2023 12:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685129389; x=1687721389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HlmZBmvK6IIaBS/qVLW3KxEFaAgrXTsTdTdo1nweowk=;
        b=d53VfFrWMZ7SAVM//Fsuotoj3KVhiMsXoAuWha/ynRveKW+5wtydwUHQ0JoHg2dxBF
         15hGKp3oIrxuqpBaVx/5feneUvPV/pKSfoBaZoVaX/rchEOJwXoaspSw5JOjuShkc6Kh
         pD8Ak+HoTk4eJ+J685aH3afCSMFYJzuowH7jY30Ucqy66bVA64Metd0pUxynejtEdOU9
         8Wxlrg9aud61ORpVsyMh6L0Tzw4ECL2jD06JEvYqRSiyC4wOgpPplYJL7ztLPG7W66+N
         TEQ/RM08sz7V42/Algd2ajf4eCORJ7UUvE8LBIeVEpygAgko20VEEU//Yr65t0MaiGIo
         S1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685129389; x=1687721389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlmZBmvK6IIaBS/qVLW3KxEFaAgrXTsTdTdo1nweowk=;
        b=giYVPq9GvT3eqchv0sg7A3MTgf0GKfCaQRNPmhYEX2y4J1bLOI/F9sQtJqhiXzozPV
         c9mbsybx51SvqWvwyfFzJRPNAgCboz4REdGgLLwQTeytDo7j9yXHLtz8WqcaIQTnwp1N
         mlTJFMVX1hmNdTk5sA20EmksRcWC5ZhKmBoRktpD94BlWHMNx8dkRwheRwHg/PBcrIWs
         ch8Po6L1IvFBhR836CgwDUPuFD7CSTdHGyOgUpDWm/nFHpCWOmBuTUHUIOMMZSyBp2B9
         TYvyuo8LUHc5Qk2OsFAAfDQEgnsG3oSFEEd1W2WgIycAxq5iJ23/IYOZwtS0ImZz7HjZ
         ZMjQ==
X-Gm-Message-State: AC+VfDzQIdkZpOdB0B+nuqV1/IaTrYnsvPBYv9XWCbLA1Kw126NQSceV
        ZZMySdAiJh6PCHZmiD/xpDs=
X-Google-Smtp-Source: ACHHUZ6vmPtVr9r7wHBr9cyq3yevyGHVW5ekA0bW6WC5t7PngjTDr9APeK0DR6RfntQQBGFJ5DRBHw==
X-Received: by 2002:a7b:c449:0:b0:3f6:7e6:44ea with SMTP id l9-20020a7bc449000000b003f607e644eamr2379254wmi.18.1685129388977;
        Fri, 26 May 2023 12:29:48 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id q5-20020a5d61c5000000b0030789698eebsm5886170wrv.89.2023.05.26.12.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:29:48 -0700 (PDT)
Date:   Fri, 26 May 2023 21:29:47 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] ARM: dts: bcm-mobile: move status properties to the end
 of nodes
Message-ID: <d7060071cb1f4b36b06b6507a09b32c7751ca7f0.1685127525.git.stano.jakubek@gmail.com>
References: <cover.1685127525.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1685127525.git.stano.jakubek@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move some DT "status" properties so that they're the last specified
property (before sub-nodes).

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 arch/arm/boot/dts/bcm11351.dtsi   | 8 ++++----
 arch/arm/boot/dts/bcm21664.dtsi   | 6 +++---
 arch/arm/boot/dts/bcm23550.dtsi   | 6 +++---
 arch/arm/boot/dts/bcm28155-ap.dts | 8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index f395e95e0177..773d717de7f0 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -51,42 +51,42 @@ smc@3404c000 {
 
 	serial@3e000000 {
 		compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
-		status = "disabled";
 		reg = <0x3e000000 0x1000>;
 		clocks = <&slave_ccu BCM281XX_SLAVE_CCU_UARTB>;
 		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		status = "disabled";
 	};
 
 	serial@3e001000 {
 		compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
-		status = "disabled";
 		reg = <0x3e001000 0x1000>;
 		clocks = <&slave_ccu BCM281XX_SLAVE_CCU_UARTB2>;
 		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		status = "disabled";
 	};
 
 	serial@3e002000 {
 		compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
-		status = "disabled";
 		reg = <0x3e002000 0x1000>;
 		clocks = <&slave_ccu BCM281XX_SLAVE_CCU_UARTB3>;
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		status = "disabled";
 	};
 
 	serial@3e003000 {
 		compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
-		status = "disabled";
 		reg = <0x3e003000 0x1000>;
 		clocks = <&slave_ccu BCM281XX_SLAVE_CCU_UARTB4>;
 		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		status = "disabled";
 	};
 
 	L2: l2-cache@3ff20000 {
diff --git a/arch/arm/boot/dts/bcm21664.dtsi b/arch/arm/boot/dts/bcm21664.dtsi
index 19ade84e42c1..9e3835a0a7ef 100644
--- a/arch/arm/boot/dts/bcm21664.dtsi
+++ b/arch/arm/boot/dts/bcm21664.dtsi
@@ -51,32 +51,32 @@ smc@3404e000 {
 
 	serial@3e000000 {
 		compatible = "brcm,bcm21664-dw-apb-uart", "snps,dw-apb-uart";
-		status = "disabled";
 		reg = <0x3e000000 0x118>;
 		clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB>;
 		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		status = "disabled";
 	};
 
 	serial@3e001000 {
 		compatible = "brcm,bcm21664-dw-apb-uart", "snps,dw-apb-uart";
-		status = "disabled";
 		reg = <0x3e001000 0x118>;
 		clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB2>;
 		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		status = "disabled";
 	};
 
 	serial@3e002000 {
 		compatible = "brcm,bcm21664-dw-apb-uart", "snps,dw-apb-uart";
-		status = "disabled";
 		reg = <0x3e002000 0x118>;
 		clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB3>;
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		status = "disabled";
 	};
 
 	L2: cache-controller@3ff20000 {
diff --git a/arch/arm/boot/dts/bcm23550.dtsi b/arch/arm/boot/dts/bcm23550.dtsi
index ed3ce2fabca6..445eadb8d871 100644
--- a/arch/arm/boot/dts/bcm23550.dtsi
+++ b/arch/arm/boot/dts/bcm23550.dtsi
@@ -129,32 +129,32 @@ slaves@3e000000 {
 
 		uartb: serial@0 {
 			compatible = "snps,dw-apb-uart";
-			status = "disabled";
 			reg = <0x00000000 0x118>;
 			clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB>;
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			status = "disabled";
 		};
 
 		uartb2: serial@1000 {
 			compatible = "snps,dw-apb-uart";
-			status = "disabled";
 			reg = <0x00001000 0x118>;
 			clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB2>;
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			status = "disabled";
 		};
 
 		uartb3: serial@2000 {
 			compatible = "snps,dw-apb-uart";
-			status = "disabled";
 			reg = <0x00002000 0x118>;
 			clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB3>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			status = "disabled";
 		};
 
 		bsc1: i2c@16000 {
diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index c496e33a71a6..0a8ad1d673d8 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -21,23 +21,23 @@ serial@3e000000 {
 	};
 
 	i2c@3e016000 {
-		status = "okay";
 		clock-frequency = <400000>;
+		status = "okay";
 	};
 
 	i2c@3e017000 {
-		status = "okay";
 		clock-frequency = <400000>;
+		status = "okay";
 	};
 
 	i2c@3e018000 {
-		status = "okay";
 		clock-frequency = <400000>;
+		status = "okay";
 	};
 
 	i2c@3500d000 {
-		status = "okay";
 		clock-frequency = <100000>;
+		status = "okay";
 
 		pmu: pmu@8 {
 			reg = <0x08>;
-- 
2.25.1

