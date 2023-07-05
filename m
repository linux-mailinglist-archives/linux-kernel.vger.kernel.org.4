Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C5274870C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjGEO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjGEO6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:58:06 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7422CFF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:58:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51d804c7d14so7790347a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569083; x=1691161083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fjbN9MhrOokWS8H/YBowH32Th5SmbEyc+P8XzYTH7o=;
        b=uHR0LFTER1l1KHF+aQD2SZFlfTfG6JSXS6PqtYS+SWgorP1+9q/x4kIs+lL2siN3zB
         BPYyDu572METTDtPPrfP1stYa+U6IfqpC9eNgKD/Bi+X00Lj9b6WgAIAc4YwZ8BOlrT9
         uyzLDTrwSxRQsYdiWpx1AskOfHYGr9KAk0Np1Y3HhJvkQWh/buOyTTOI7lNX38qNSXfs
         lX4KWCecfsx2j1QnX4D89ms37s5+8FqRf1MxMdtW9L01hX/g2IlHd1PzEcai/kKGABpE
         4SomMbq0W7q3bRbHTAlR4DFfCwMyV3vQ9677O2KSQR0/38Cp0FQYdHvgbX5Iork6bsnW
         MnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569083; x=1691161083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fjbN9MhrOokWS8H/YBowH32Th5SmbEyc+P8XzYTH7o=;
        b=e+nx0iA3xs3MdOi8tW61m1oa5euDJU5twgneBYSkJqi+uGwLqxquYwbdyl+LXPB7P6
         L4HrJefYcdt5DxPrklA5OsU3UyNWW9IOWYNtBqDWhUnkC9nxyr8pfvdZC10lNqdOc/az
         JcGttMEcH3bGyZv9qZu0SN5vgs40vUvw88d4NIkRFPcSf/cQYrxd0RUBRZBiOlAWleSi
         6mzLrqsPpneprmaWvpYMqdDPTAUwBwdNGt3ovi0hF0kTPmgQOjzLyR7Xdl5u4SFvmarc
         KubE/yQOQh8ZISE0NDvpNGbTlYXRCGzgeTKeHkJ32/vKt1FoGsHpEgR/YWWvaCnMakz+
         FMlA==
X-Gm-Message-State: ABy/qLah7lHtcBu2zr5MZp4TZ3QqIDYebhks2I6OCBv+jwxFDUnecYP1
        fkuLCjyv391JlKbf1dvj0+AJNg==
X-Google-Smtp-Source: APBJJlHgxSBcqzePg1do2YuIG5KsbfCaide4OMeZyfuIezmCGpdIeZjaDF6DF2IgpnfBvvYmplZPtg==
X-Received: by 2002:a17:906:35c5:b0:982:9662:a679 with SMTP id p5-20020a17090635c500b009829662a679mr13352335ejb.9.1688569082959;
        Wed, 05 Jul 2023 07:58:02 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id t19-20020a170906065300b009882e53a42csm14650339ejb.81.2023.07.05.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:58:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: ti: add missing space before {
Date:   Wed,  5 Jul 2023 16:57:55 +0200
Message-Id: <20230705145755.292927-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705145755.292927-1-krzysztof.kozlowski@linaro.org>
References: <20230705145755.292927-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts                 | 2 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi               | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi              | 2 +-
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 2 +-
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi       | 2 +-
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts               | 2 +-
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi       | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 3f9ef4053aa6..7c98c1b855d1 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -212,7 +212,7 @@ &ospi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
 
-	flash@0{
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 1664d9f0241c..a57ea7130ca3 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -733,7 +733,7 @@ timesync_router: pinctrl@a40000 {
 		pinctrl-single,function-mask = <0x000107ff>;
 	};
 
-	usbss0: cdns-usb@f900000{
+	usbss0: cdns-usb@f900000 {
 		compatible = "ti,am64-usb";
 		reg = <0x00 0xf900000 0x00 0x100>;
 		power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
@@ -744,7 +744,7 @@ usbss0: cdns-usb@f900000{
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-		usb0: usb@f400000{
+		usb0: usb@f400000 {
 			compatible = "cdns,usb3";
 			reg = <0x00 0xf400000 0x00 0x10000>,
 			      <0x00 0xf410000 0x00 0x10000>,
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 649628685c32..575435c1a984 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -660,7 +660,7 @@ wiz1_refclk_dig: refclk-dig {
 			assigned-clock-parents = <&k3_clks 293 13>;
 		};
 
-		wiz1_cmn_refclk_dig_div: cmn-refclk-dig-div{
+		wiz1_cmn_refclk_dig_div: cmn-refclk-dig-div {
 			clocks = <&wiz1_refclk_dig>;
 			#clock-cells = <0>;
 		};
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index 04d4739d7245..092ab1e14ba5 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -407,7 +407,7 @@ &ospi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
 
-	flash@0{
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index e7dd947a1814..736ec5fa0ea2 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -440,7 +440,7 @@ mcu_spi2: spi@40320000 {
 		status = "disabled";
 	};
 
-	mcu_navss: bus@28380000{
+	mcu_navss: bus@28380000 {
 		compatible = "simple-mfd";
 		#address-cells = <2>;
 		#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 430b8a2c5df5..7ad152a1b90f 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -499,7 +499,7 @@ &ospi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
 
-	flash@0{
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 657fb1d72512..740ee794d7b9 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -441,7 +441,7 @@ mcu_spi2: spi@40320000 {
 		status = "disabled";
 	};
 
-	mcu_navss: bus@28380000{
+	mcu_navss: bus@28380000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.34.1

