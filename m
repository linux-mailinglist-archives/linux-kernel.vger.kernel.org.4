Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A24E677D41
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjAWN66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjAWN6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:58:55 -0500
Received: from egress-ip33a.ess.de.barracuda.com (egress-ip33a.ess.de.barracuda.com [18.185.115.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A717252A0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:58:54 -0800 (PST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197]) by mx-outbound15-196.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Jan 2023 13:58:51 +0000
Received: by mail-pl1-f197.google.com with SMTP id j16-20020a170902da9000b00194c056109eso7197392plx.18
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNEEHA4J8wWaZfY/M6sbtDmfE0EKkuZ8Jdo0T8IZQKI=;
        b=JVdboZi1JlgdaQLbniENY74UXJa8rThK2Phh6QZE5fEJGQTbCuzzfJD9RUG7HygEwK
         dCq3AiLB4HjD+ZUD7SwyrneTlmFTK7zE9xFRNNY1It0Ulvbr63co8OFeKMBqRgtW5fzP
         AWynt1aonZEZ/i0RmcVj437Z6wMH2/jsahcy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNEEHA4J8wWaZfY/M6sbtDmfE0EKkuZ8Jdo0T8IZQKI=;
        b=my0pKi7uKgIPv77AvvbWV8HxYmmE+yiJHEytxTi5SrQXShlPv0UzcPkO3VLXZJVGF3
         M0kgtJiZMmKi1KTYRpftnJMpx6Vbz1S1mrk6Ddf5I07ad/xjZArHbe5slqBxlJXX4DUv
         6FXx4nVfhj+fb8wNfHxijJ3jXr7rdHoATCpyYbziDYQcROlMDUyM9eaHnkgNT8BNv1dP
         B/WFG8nyUSZSYiFYloyct0hBi41DjAkYF7T9MTptHOdU8n5lRbQtdp7nQ/MlR9VmKrWQ
         r6O4IwpGJwN4B+TWJ1dOeW97bKsXx9+/yBVbLm+nOoVHUGzREbNz1v0qwBWpq9l879fG
         dQ9A==
X-Gm-Message-State: AFqh2krD1agfNcOKjvY+eveFhGYlgFzj1qWMMbHlJJw987MvyKPzzPJr
        EsbFhE0IYulYhZe7yM/j5dmG0JqUA7RN3FbKRXLgvVR2MvLYHq/XcZ0VqU7GWg7Q0GAVnSM8Ram
        FMiGldE7YCDgkDapRVg6vTnxnJLWP94vwvZ5K8ttA0DFNM922QUyHLCk4OZnK
X-Received: by 2002:a17:903:2289:b0:194:9290:fa6f with SMTP id b9-20020a170903228900b001949290fa6fmr35161888plh.25.1674482330557;
        Mon, 23 Jan 2023 05:58:50 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv4gl5imbkFxKE+7jqQCCtrX4dBCqwj0n2etZHvt+tKsScBKIVYV3Vk/7p3U65U7j44aSO/KQ==
X-Received: by 2002:a17:903:2289:b0:194:9290:fa6f with SMTP id b9-20020a170903228900b001949290fa6fmr35161866plh.25.1674482330242;
        Mon, 23 Jan 2023 05:58:50 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902b48300b0019309be03e7sm474478plr.66.2023.01.23.05.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:58:49 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am68-sk-base-board: Add pinmux for RPi Header
Date:   Mon, 23 Jan 2023 19:28:31 +0530
Message-Id: <20230123135831.4184-3-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230123135831.4184-1-sinthu.raja@ti.com>
References: <20230123135831.4184-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1674482331-304036-5639-9240-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.214.197
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245654 [from 
        cloudscan13-140.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Add pinmux required to bring out the i2c and gpios on 40-pin RPi
expansion header on the AM68 SK board.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---
 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 70 ++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index 2091cd2431fb..722cd19b74e0 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -173,6 +173,32 @@ J721S2_IOPAD(0x0a0, PIN_INPUT, 0) /* (AB25) MCASP0_AXR12.MCAN7_RX */
 			J721S2_IOPAD(0x09c, PIN_INPUT, 0) /* (T24) MCASP0_AXR11.MCAN7_TX */
 		>;
 	};
+
+	main_i2c4_pins_default: main-i2c4-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x010, PIN_INPUT_PULLUP, 7) /* (AF28) MCAN13_RX.I2C4_SDA */
+			J721S2_IOPAD(0x014, PIN_INPUT_PULLUP, 7) /* (AD25) MCAN14_TX.I2C4_SCL */
+		>;
+	};
+
+	rpi_header_gpio0_pins_default: rpi-header-gpio0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x0a8, PIN_INPUT, 7) /* (U24)  MCASP0_AXR14.GPIO0_42 */
+			J721S2_IOPAD(0x090, PIN_INPUT, 7) /* (W24) MCASP0_AXR8.GPIO0_36 */
+			J721S2_IOPAD(0x0bc, PIN_INPUT, 7) /* (V28) MCASP1_AFSX.GPIO0_47 */
+			J721S2_IOPAD(0x06c, PIN_INPUT, 7) /* (V26) MCAN1_TX.GPIO0_27 */
+			J721S2_IOPAD(0x004, PIN_INPUT, 7) /* (W25) MCAN12_TX.GPIO0_1 */
+			J721S2_IOPAD(0x008, PIN_INPUT, 7) /* (AC24) MCAN12_RX.GPIO0_2 */
+			J721S2_IOPAD(0x0b8, PIN_INPUT, 7) /* (AA24) MCASP1_ACLKX.GPIO0_46 */
+			J721S2_IOPAD(0x00c, PIN_INPUT, 7) /* (AE28) MCAN13_TX.GPIO0_3 */
+			J721S2_IOPAD(0x034, PIN_INPUT, 7) /* (AD24) PMIC_WAKE0.GPIO0_13 */
+			J721S2_IOPAD(0x0a4, PIN_INPUT, 7) /* (T23) MCASP0_AXR13.GPIO0_41 */
+			J721S2_IOPAD(0x0c0, PIN_INPUT, 7) /* (T28) MCASP1_AXR0.GPIO0_48 */
+			J721S2_IOPAD(0x0b4, PIN_INPUT, 7) /* (U25) MCASP1_AXR4.GPIO0_45 */
+			J721S2_IOPAD(0x0cc, PIN_INPUT, 7) /* (AE27) SPI0_CS0.GPIO0_51 */
+			J721S2_IOPAD(0x08c, PIN_INPUT, 7) /* (T25) MCASP0_AXR7.GPIO0_35 */
+		>;
+	};
 };
 
 &wkup_pmx0 {
@@ -214,12 +240,39 @@ J721S2_WKUP_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (C23) WKUP_GPIO0_4.MCU_MCAN1_TX*/
 		>;
 	};
 
+	mcu_i2c0_pins_default: mcu-i2c0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x100, PIN_INPUT, 0) /*(H24) WKUP_GPIO0_63.MCU_I2C0_SCL*/
+			J721S2_WKUP_IOPAD(0x104, PIN_INPUT, 0) /*(H27) WKUP_GPIO0_64.MCU_I2C0_SDA*/
+		>;
+	};
+
 	mcu_i2c1_pins_default: mcu-i2c1-pins-default {
 		pinctrl-single,pins = <
 			J721S2_WKUP_IOPAD(0x0e0, PIN_INPUT, 0) /* (F24) WKUP_GPIO0_8.MCU_I2C1_SCL */
 			J721S2_WKUP_IOPAD(0x0e4, PIN_INPUT, 0) /* (H26) WKUP_GPIO0_9.MCU_I2C1_SDA */
 		>;
 	};
+
+	mcu_rpi_header_gpio0_pins_default: mcu-rpi-header-gpio0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x180, PIN_INPUT, 7) /* (G25) WKUP_GPIO0_66 */
+			J721S2_WKUP_IOPAD(0x190, PIN_INPUT, 7) /* (K26) WKUP_GPIO0_49 */
+			J721S2_WKUP_IOPAD(0x0c4, PIN_INPUT, 7) /* (E24) MCU_SPI1_D0.WKUP_GPIO0_1 */
+			J721S2_WKUP_IOPAD(0x0c8, PIN_INPUT, 7) /* (C28) MCU_SPI1_D1.WKUP_GPIO0_2 */
+			J721S2_WKUP_IOPAD(0x0c0, PIN_INPUT, 7) /* (D26) MCU_SPI1_CLK.WKUP_GPIO0_0 */
+			J721S2_WKUP_IOPAD(0x0fc, PIN_INPUT, 7) /* (D25) MCU_SPI1_CS2.WKUP_GPIO0_15*/
+			J721S2_WKUP_IOPAD(0x120, PIN_INPUT, 7) /* (G27) WKUP_GPIO0_56 */
+			J721S2_WKUP_IOPAD(0x17c, PIN_INPUT, 7) /* (J26) WKUP_GPIO0_57 */
+			J721S2_WKUP_IOPAD(0x184, PIN_INPUT, 7) /* (J27) WKUP_GPIO0_67 */
+			J721S2_WKUP_IOPAD(0x0cc, PIN_INPUT, 7) /* (C27) MCU_SPI1_CS0.WKUP_GPIO0_3 */
+		>;
+	};
+};
+
+&main_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rpi_header_gpio0_pins_default>;
 };
 
 &main_gpio2 {
@@ -235,7 +288,8 @@ &main_gpio6 {
 };
 
 &wkup_gpio0 {
-	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_rpi_header_gpio0_pins_default>;
 };
 
 &wkup_gpio1 {
@@ -273,6 +327,20 @@ exp1: gpio@21 {
 	};
 };
 
+&main_i2c4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c4_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&mcu_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_i2c0_pins_default>;
+	clock-frequency = <400000>;
+};
+
 &main_sdhci0 {
 	/* Unused */
 	status = "disabled";
-- 
2.36.1

