Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E826EC80D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjDXIqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjDXIqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:46:49 -0400
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4229F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:46:47 -0700 (PDT)
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199]) by mx-outbound10-206.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 24 Apr 2023 08:46:05 +0000
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74de74a90e7so567795985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1682325964; x=1684917964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9p6ILViXkgbP0qQP35EmW/HgzmUgenr3yYXwlIHHq38=;
        b=BrB8frXk7NxqzjsMdWP5oU+QjT+jY1Hp1FJG5Kw1+rLYiEwfCyli1s9VL46JZUrz7v
         an3CV/A7/7yBPnUXeuX7BkYRqCJSJDVqfBKAKQUPgL+gsM2fvHcLKR6qQcj6ymYuX8IL
         epKVUwF21tzUinF8uFxxSHfuMckVpeKXM/EvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682325964; x=1684917964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9p6ILViXkgbP0qQP35EmW/HgzmUgenr3yYXwlIHHq38=;
        b=D68XObbPo+Oe6TmEU7AKgJe499D2m5fxSkVEE3FH52X57Gscgyfo5WQaBYtdN2bXaC
         f+UiHu1Qefye3vRoluYZzuha+49qjkmSLVcNNmfgXzfLsTcCiE9TjM0+g8skHbZaeL9Q
         2ppXmXbcnWDz4LlccWaSlJVVPJ/4IFtPBtd2OAh6XhKsAb9tyUAW+ZspkTrIHid0DXj/
         k0vLGWfOTyJ/55eqIFXCmnlpsNXliQiWU5FuDrKDSQQv6QdWNcVXGwcMZOQ1zUmkqXpR
         39vlZfUzS/H2qrTwxpQLk7FCODvkX3eNQMrRD3wkYZEUuskP+OU5o/A6EPRjFwCwAcWf
         GazA==
X-Gm-Message-State: AAQBX9dNvFRSEatXjw2iXzJH1CEzVn2LEdw2Tj2x1v+g/4zT/NMm1y6E
        Mx91DyeQqUkzPQON8fh6K5TNtUd6bIROQ+0l/1LrR0DqPqBai4yEE7EKAP2q+JMzIvzV8BTFk4H
        GWf0P+A0K4AIEGm3vxBSO4lq3eOgfCdvktF6PONHh3JVIEnHPZaQyo0zTNTcy
X-Received: by 2002:a17:902:ecc6:b0:1a0:422f:39d9 with SMTP id a6-20020a170902ecc600b001a0422f39d9mr15889957plh.39.1682324148173;
        Mon, 24 Apr 2023 01:15:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350b0bTjBJO/SgO/DligBT2a9GLWovrAEzlf/YWoZGJ6lwtGkT7bWQ1+O2qI7KNmg/+XnYO8qIQ==
X-Received: by 2002:a17:902:ecc6:b0:1a0:422f:39d9 with SMTP id a6-20020a170902ecc600b001a0422f39d9mr15889932plh.39.1682324147809;
        Mon, 24 Apr 2023 01:15:47 -0700 (PDT)
Received: from localhost.localdomain ([49.207.195.237])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709029a4a00b001a9293597efsm6089868plv.246.2023.04.24.01.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 01:15:47 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V4 1/3] arm64: dts: ti: k3-j721s2: fix main pinmux range
Date:   Mon, 24 Apr 2023 13:45:34 +0530
Message-Id: <20230424081536.12123-2-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230424081536.12123-1-sinthu.raja@ti.com>
References: <20230424081536.12123-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1682325964-302766-5454-1463-1
X-BESS-VER: 2019.1_20230419.1731
X-BESS-Apparent-Source-IP: 209.85.222.199
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyMTMyA7IygIJGlsZpSYlJpq
        aphubmiRbJKZamiYkWFmmWlhZpxgYGKUq1sQAW0Pk6QQAAAA==
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

PADCONFIG_64 register is non-addressable in the existing main pinmux
region. So only valid registers are included and main pinmux region
is split into two ranges as follows. Also update references to old
nodes with new ones as per the newly split main_pmx* node.

main_pmx0 -> 64 pins (WKUP_PADCONFIG 0 - 63)
main_pmx1 -> 7 pins (WKUP_PADCONFIG 65 - 71)

Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 15 +++++++++++----
 .../boot/dts/ti/k3-j721s2-common-proc-board.dts  | 16 +++++++++++-----
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi       | 11 ++++++++++-
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index 27a43a8ecffd..711757997804 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -136,10 +136,8 @@ J721S2_IOPAD(0x0e4, PIN_INPUT, 0) /* (AE24) I2C0_SDA */
 		>;
 	};
 
-	main_mmc1_pins_default: main-mmc1-pins-default {
+	main_mmc1_pins0_default: main-mmc1-pins0-default {
 		pinctrl-single,pins = <
-			J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
-			J721S2_IOPAD(0x108, PIN_INPUT, 0) /* (N24) MMC1_CMD */
 			J721S2_IOPAD(0x0fc, PIN_INPUT, 0) /* (M23) MMC1_DAT0 */
 			J721S2_IOPAD(0x0f8, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
 			J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
@@ -175,6 +173,15 @@ J721S2_IOPAD(0x09c, PIN_INPUT, 0) /* (T24) MCASP0_AXR11.MCAN7_TX */
 	};
 };
 
+&main_pmx1 {
+	main_mmc1_pins1_default: main-mmc1-pins1-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x000, PIN_INPUT, 0) /* (P23) MMC1_CLK */
+			J721S2_IOPAD(0x004, PIN_INPUT, 0) /* (N24) MMC1_CMD */
+		>;
+	};
+};
+
 &wkup_pmx0 {
 	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
 		pinctrl-single,pins = <
@@ -278,7 +285,7 @@ &main_sdhci0 {
 
 &main_sdhci1 {
 	/* SD card */
-	pinctrl-0 = <&main_mmc1_pins_default>;
+	pinctrl-0 = <&main_mmc1_pins0_default &main_mmc1_pins1_default>;
 	pinctrl-names = "default";
 	disable-wp;
 	vmmc-supply = <&vdd_mmc1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index b4b9edfe2d12..6141ae487cba 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -126,11 +126,8 @@ J721S2_IOPAD(0x060, PIN_INPUT_PULLUP, 13) /* (AC27) MCASP2_AXR1.I2C3_SDA */
 		>;
 	};
 
-	main_mmc1_pins_default: main-mmc1-pins-default {
+	main_mmc1_pins0_default: main-mmc1-pins0-default {
 		pinctrl-single,pins = <
-			J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
-			J721S2_IOPAD(0x108, PIN_INPUT, 0) /* (N24) MMC1_CMD */
-			J721S2_IOPAD(0x100, PIN_INPUT, 0) /* (###) MMC1_CLKLB */
 			J721S2_IOPAD(0x0fc, PIN_INPUT, 0) /* (M23) MMC1_DAT0 */
 			J721S2_IOPAD(0x0f8, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
 			J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
@@ -146,6 +143,15 @@ J721S2_IOPAD(0x020, PIN_INPUT, 7) /* (AA23) MCAN15_RX.GPIO0_8 */
 	};
 };
 
+&main_pmx1 {
+	main_mmc1_pins1_default: main-mmc1-pins1-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x000, PIN_INPUT, 0) /* (P23) MMC1_CLK */
+			J721S2_IOPAD(0x004, PIN_INPUT, 0) /* (N24) MMC1_CMD */
+		>;
+	};
+};
+
 &wkup_pmx0 {
 	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
 		pinctrl-single,pins = <
@@ -296,7 +302,7 @@ &main_sdhci0 {
 
 &main_sdhci1 {
 	/* SD card */
-	pinctrl-0 = <&main_mmc1_pins_default>;
+	pinctrl-0 = <&main_mmc1_pins0_default &main_mmc1_pins1_default>;
 	pinctrl-names = "default";
 	disable-wp;
 	vmmc-supply = <&vdd_mmc1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 2dd7865f7654..a8d9336d1848 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -66,7 +66,16 @@ main_gpio_intr: interrupt-controller@a00000 {
 	main_pmx0: pinctrl@11c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-		reg = <0x0 0x11c000 0x0 0x120>;
+		reg = <0x0 0x11c000 0x0 0x100>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	main_pmx1: pinctrl@11c104 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x0 0x11c104 0x0 0x1C>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
-- 
2.36.1

