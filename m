Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F2D6BCE96
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjCPLlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCPLlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:41:24 -0400
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CA459D1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:41:22 -0700 (PDT)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69]) by mx-outbound40-126.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 16 Mar 2023 11:41:19 +0000
Received: by mail-pj1-f69.google.com with SMTP id m9-20020a17090a7f8900b0023769205928so2421278pjl.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1678966879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdueyagCDU+rbLAuQs1asrXFjnhTGxhiEoDTXnftt8w=;
        b=I1xa4CLaDEV9PQ/pYUqJXdKcaQ+usB3uFUPRs01lUtmKe3NGINGD6+RgKSfR7Tj7Hi
         qSLGjb5gQXEiH7ILFYtwc6aV5Ik6OyqLcv8J1HAj3YRwYuqemtnJORUitAUQ1RJbbUYk
         kQJ6Z6V+s3SxS38GzjimnRQSql9TmEAWZbydk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678966879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdueyagCDU+rbLAuQs1asrXFjnhTGxhiEoDTXnftt8w=;
        b=S8gphVCauG4SuestbQ94/+AVoA/RI0L+on0O/rT1KNvpoII12dS2oJMkZcQ8uEzdJz
         YH5zciP4tO2ygsoIW6jVe+hZIPl2I7zvcjyYA5bDKYbU5BQebUXQizoYNzaNNpDP/7ca
         AALqlV0JNhRgnrcl85A5b5PHcEZvP10+QkybnBKRFjl5k8h0+5oq0tdCvMx8uaoVWcJj
         /3XVOz71e2Czk7M4jeJCbaFhD6kaxWgkZiguV4ORXEI6MiFhQEAhDkr5z2Hko46THch7
         o2Cz0JKOQTxfRJAWhgbR1j6lw6OoT8N9ML3ex7iTtF6doh5QQ14PvX3VVVHMSdkfnW+s
         HjnA==
X-Gm-Message-State: AO0yUKWZkTDUC1Nq30Bdre1bujzUQ8yar6oxFhy7uS+Lw3T3xtBCMx/T
        Z4q6BWRAk842ljNraTWfMk32YbWRZAy1C+qqXWv2lS8jMkQUIGxrfAUXsk0U6qDCu1P7B2ziKAo
        MuYtcL64oPQI3Y6/I5Pzqnpod6QbIsG5xRxbJQtKbyr0vlfnnlDk6yMd3QTBP
X-Received: by 2002:a05:6a20:d49b:b0:cc:d514:62cf with SMTP id im27-20020a056a20d49b00b000ccd51462cfmr3233533pzb.43.1678966879019;
        Thu, 16 Mar 2023 04:41:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set9OlADws5PVaeSR7peTMYf8XVMbtBhpPHyeeOxqw9yHPOxcgCbFzP5eKB3MiJdarB9Gty+MrA==
X-Received: by 2002:a05:6a20:d49b:b0:cc:d514:62cf with SMTP id im27-20020a056a20d49b00b000ccd51462cfmr3233511pzb.43.1678966878650;
        Thu, 16 Mar 2023 04:41:18 -0700 (PDT)
Received: from localhost.localdomain ([49.207.217.20])
        by smtp.gmail.com with ESMTPSA id j9-20020aa78dc9000000b00571f66721aesm5284534pfr.42.2023.03.16.04.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 04:41:18 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V3 2/2] arm64: dts: ti: k3-am68-sk-base-board: Add pinmux for RPi Header
Date:   Thu, 16 Mar 2023 17:11:02 +0530
Message-Id: <20230316114102.3602-3-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230316114102.3602-1-sinthu.raja@ti.com>
References: <20230316114102.3602-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1678966872-310366-5552-16177-2
X-BESS-VER: 2019.1_20230310.1716
X-BESS-Apparent-Source-IP: 209.85.216.69
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyMbI0ArIygIKWBslp5hZGFq
        aJZskmyWYmxikWaRZmBpaWpmYGZgapqUq1sQCyTTixQQAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.246833 [from 
        cloudscan22-104.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

No Changes in V3.

 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 70 ++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index 27a43a8ecffd..118308cfdd75 100644
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
@@ -271,6 +325,20 @@ exp1: gpio@21 {
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

