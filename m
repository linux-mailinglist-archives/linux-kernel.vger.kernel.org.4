Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED41712D82
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243984AbjEZTaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243944AbjEZTaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:30:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B61189;
        Fri, 26 May 2023 12:30:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30ae141785bso156759f8f.3;
        Fri, 26 May 2023 12:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685129410; x=1687721410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G9shYcdtaK4nijtLijnuwb1GLVaQieDPGIiKrHSPS3I=;
        b=IEnOpkLquA63V7aL9EwvWkRW6y8hC7xY8mwkfZk7v3EJDiXlADO6zvp1gNXx8uTnYy
         Icg08VwMyfo9AoZW16q3BJJ5IaKv2JZFKHC1mabW/IX1yKBxZXLTxRZ19lG4Dx0H2YHL
         5mfkuSgkSI98hBgdITES9oXk+oDkJmldCIHW/OGOBDBwx+qUKCjD1LMjIy4X9UEoqBr5
         +kzAezdiOwNDOAxcnMhVgBMU5rAFKgCSOuKKWsrWXgLIgSmsfTVADoWax83nly0KDMVM
         VO+II6rn49PSs58M96SMdsNNxNCRWlx4/gCY5/ORiBOR3AFJe5WpPc70l8fOxTuDrbCz
         4ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685129410; x=1687721410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9shYcdtaK4nijtLijnuwb1GLVaQieDPGIiKrHSPS3I=;
        b=NqgESx5iMkGKYhnqrFX391pDpQDJoHJv6N6BGodaFx7zB26dyS3wPKVg9+dDPxH3Fy
         AF2MUT3BiFXtYvQvfPFoGAQ4lnvecbpM5vuzQ+zM32baFFqN/iSKAF8ebGV/jIjL7471
         lyOdKhH3yjgP0mNO5E7oY3HgWhV7GaxU25FIP8HRdSsz/EOmFVP4EvFGK/Ku3n/fsNhM
         N8FeJM0JXYSkUgEjexiH+SvvD4Xe56w4GYVtker+4oG8snGkcD+JIV/3+WiInjb0x0lO
         bUWYA/LrawmkY4NMxc2U9dzADr2bz/3F9lXHACwwKwFw5RwThmrVx7Ou4lTg6SKp0Ie8
         QBBQ==
X-Gm-Message-State: AC+VfDwSQ0c+j2iPqJCb2sG4Wji+AByuz9mJ8IoP6tuDXZ5UsmuEv9F5
        65SocaSLFW/7VZMmSnDFy3w=
X-Google-Smtp-Source: ACHHUZ6XP1SNefrjxMwWDglY89pvDlMfDtYW+68R8ofvcxI8I/zXrTM5z9bLVpEODMux7ZSl5a+O+g==
X-Received: by 2002:adf:dbc6:0:b0:2f1:e162:d48 with SMTP id e6-20020adfdbc6000000b002f1e1620d48mr2189372wrj.47.1685129410516;
        Fri, 26 May 2023 12:30:10 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id x3-20020adfdcc3000000b0030ade1b9400sm1263164wrm.30.2023.05.26.12.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:30:10 -0700 (PDT)
Date:   Fri, 26 May 2023 21:30:08 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] ARM: dts: bcm11351/21664: add UART, I2C node labels
Message-ID: <4c8bb3a725dad9048665d39d0ca728b52152e59e.1685127525.git.stano.jakubek@gmail.com>
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

Add node labels to serial (UART) and I2C nodes for BCM11351 and BCM21664.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 arch/arm/boot/dts/bcm11351.dtsi | 16 ++++++++--------
 arch/arm/boot/dts/bcm21664.dtsi | 14 +++++++-------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 773d717de7f0..b271a9bf06a9 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -49,7 +49,7 @@ smc@3404c000 {
 		reg = <0x3404c000 0x400>; /* 1 KiB in SRAM */
 	};
 
-	serial@3e000000 {
+	uartb: serial@3e000000 {
 		compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
 		reg = <0x3e000000 0x1000>;
 		clocks = <&slave_ccu BCM281XX_SLAVE_CCU_UARTB>;
@@ -59,7 +59,7 @@ serial@3e000000 {
 		status = "disabled";
 	};
 
-	serial@3e001000 {
+	uartb2: serial@3e001000 {
 		compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
 		reg = <0x3e001000 0x1000>;
 		clocks = <&slave_ccu BCM281XX_SLAVE_CCU_UARTB2>;
@@ -69,7 +69,7 @@ serial@3e001000 {
 		status = "disabled";
 	};
 
-	serial@3e002000 {
+	uartb3: serial@3e002000 {
 		compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
 		reg = <0x3e002000 0x1000>;
 		clocks = <&slave_ccu BCM281XX_SLAVE_CCU_UARTB3>;
@@ -79,7 +79,7 @@ serial@3e002000 {
 		status = "disabled";
 	};
 
-	serial@3e003000 {
+	uartb4: serial@3e003000 {
 		compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
 		reg = <0x3e003000 0x1000>;
 		clocks = <&slave_ccu BCM281XX_SLAVE_CCU_UARTB4>;
@@ -161,7 +161,7 @@ pinctrl@35004800 {
 		reg = <0x35004800 0x430>;
 	};
 
-	i2c@3e016000 {
+	bsc1: i2c@3e016000 {
 		compatible = "brcm,bcm11351-i2c", "brcm,kona-i2c";
 		reg = <0x3e016000 0x80>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
@@ -171,7 +171,7 @@ i2c@3e016000 {
 		status = "disabled";
 	};
 
-	i2c@3e017000 {
+	bsc2: i2c@3e017000 {
 		compatible = "brcm,bcm11351-i2c", "brcm,kona-i2c";
 		reg = <0x3e017000 0x80>;
 		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
@@ -181,7 +181,7 @@ i2c@3e017000 {
 		status = "disabled";
 	};
 
-	i2c@3e018000 {
+	bsc3: i2c@3e018000 {
 		compatible = "brcm,bcm11351-i2c", "brcm,kona-i2c";
 		reg = <0x3e018000 0x80>;
 		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
@@ -191,7 +191,7 @@ i2c@3e018000 {
 		status = "disabled";
 	};
 
-	i2c@3500d000 {
+	pmu_bsc: i2c@3500d000 {
 		compatible = "brcm,bcm11351-i2c", "brcm,kona-i2c";
 		reg = <0x3500d000 0x80>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/bcm21664.dtsi b/arch/arm/boot/dts/bcm21664.dtsi
index 9e3835a0a7ef..2eb7f5b0c1dc 100644
--- a/arch/arm/boot/dts/bcm21664.dtsi
+++ b/arch/arm/boot/dts/bcm21664.dtsi
@@ -49,7 +49,7 @@ smc@3404e000 {
 		reg = <0x3404e000 0x400>; /* 1 KiB in SRAM */
 	};
 
-	serial@3e000000 {
+	uartb: serial@3e000000 {
 		compatible = "brcm,bcm21664-dw-apb-uart", "snps,dw-apb-uart";
 		reg = <0x3e000000 0x118>;
 		clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB>;
@@ -59,7 +59,7 @@ serial@3e000000 {
 		status = "disabled";
 	};
 
-	serial@3e001000 {
+	uartb2: serial@3e001000 {
 		compatible = "brcm,bcm21664-dw-apb-uart", "snps,dw-apb-uart";
 		reg = <0x3e001000 0x118>;
 		clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB2>;
@@ -69,7 +69,7 @@ serial@3e001000 {
 		status = "disabled";
 	};
 
-	serial@3e002000 {
+	uartb3: serial@3e002000 {
 		compatible = "brcm,bcm21664-dw-apb-uart", "snps,dw-apb-uart";
 		reg = <0x3e002000 0x118>;
 		clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB3>;
@@ -144,7 +144,7 @@ sdio4: mmc@3f1b0000 {
 		status = "disabled";
 	};
 
-	i2c@3e016000 {
+	bsc1: i2c@3e016000 {
 		compatible = "brcm,bcm21664-i2c", "brcm,kona-i2c";
 		reg = <0x3e016000 0x70>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
@@ -154,7 +154,7 @@ i2c@3e016000 {
 		status = "disabled";
 	};
 
-	i2c@3e017000 {
+	bsc2: i2c@3e017000 {
 		compatible = "brcm,bcm21664-i2c", "brcm,kona-i2c";
 		reg = <0x3e017000 0x70>;
 		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
@@ -164,7 +164,7 @@ i2c@3e017000 {
 		status = "disabled";
 	};
 
-	i2c@3e018000 {
+	bsc3: i2c@3e018000 {
 		compatible = "brcm,bcm21664-i2c", "brcm,kona-i2c";
 		reg = <0x3e018000 0x70>;
 		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
@@ -174,7 +174,7 @@ i2c@3e018000 {
 		status = "disabled";
 	};
 
-	i2c@3e01c000 {
+	bsc4: i2c@3e01c000 {
 		compatible = "brcm,bcm21664-i2c", "brcm,kona-i2c";
 		reg = <0x3e01c000 0x70>;
 		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

