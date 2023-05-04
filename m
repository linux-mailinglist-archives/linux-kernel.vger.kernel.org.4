Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765576F65E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjEDHfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjEDHf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:35:27 -0400
Received: from egress-ip33b.ess.de.barracuda.com (egress-ip33b.ess.de.barracuda.com [18.185.115.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2F93C06
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:35:02 -0700 (PDT)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198]) by mx-outbound19-253.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 04 May 2023 07:34:48 +0000
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6433bffb49eso243865b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1683185687; x=1685777687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vNLUoEmjoTXOO3mziGIxbt/WLJCyKmqPe2UuUWuFYc=;
        b=cqAMdnI7lfCFAofFRQ1ePAFu5LSruBSsZWX1nwKJY3O7BrDuk7/lyTiLnLA0Y4ZHJv
         Mz+a4C/bSmkur5LJdLBLw6VK7AjhZidYzUHYXMbe23JnvPEg0Z2D2FZO84cRsqZaswaR
         EHmepWZzW1515MvXPZZiNM1P0XpzgJwC6rwPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683185687; x=1685777687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vNLUoEmjoTXOO3mziGIxbt/WLJCyKmqPe2UuUWuFYc=;
        b=Kfctok3mIaG4jCa8xXLJFUOSFDZbyYLS8jlA1rROrLesaMdRk91LpaEvVmS+L0b64b
         31FMXUmtPSGW23n3XkH3CBgZen6JyrvgvfHCou83q/0OThXeD06+j85Zr0UJ+7judC73
         N7fXN/Ls+wBxgbVWa8molCMNjKaMCChKn54hK7AhcwaedmoMeUV8MbEOLLAc53eOWPe9
         mRLgBTYdRkFHdSkGW/l0wauTvgVPlbLdjdckuFUt9BL651doO9/AvyBYe5ldLrpO6esB
         tZ7HHrEmZoCBmF8HGm9AK+qKxfP/UnZvV3YyfgNKX49d9DRP1Ew4VqU9J1OxvL9dN8UX
         O8AA==
X-Gm-Message-State: AC+VfDx0wVHN0xaBvln3c+kNUAgPjmxh8ZxjJkkXrOV1YRZAsaaDuUT5
        cpUhsM9xK3IrHN26IYAXqcgKz5dstv81qturOWZqllkBQodYuOsIK8nKvPqneIdZ4nJxFoCuEsE
        hfAbAZhnVdxVNfCUUTjZ7znyzskwbCMO7NLo5ZubSuCNg6Gig2krI5cCOGFka
X-Received: by 2002:a05:6a00:10c2:b0:63d:368b:76b4 with SMTP id d2-20020a056a0010c200b0063d368b76b4mr1426966pfu.17.1683185686888;
        Thu, 04 May 2023 00:34:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ro8cnVsskkmjoVX2AQ/z0grX13MYCQte/P+10Hqo65N82GEpvqU9O7V8AJkLkJItF+7mb/g==
X-Received: by 2002:a05:6a00:10c2:b0:63d:368b:76b4 with SMTP id d2-20020a056a0010c200b0063d368b76b4mr1426950pfu.17.1683185686550;
        Thu, 04 May 2023 00:34:46 -0700 (PDT)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id q22-20020aa79616000000b0063f1a1e3003sm22884865pfg.166.2023.05.04.00.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 00:34:46 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V5 2/2] arm64: dts: ti: k3-am68-sk-base-board: Add pinmux for RPi Header
Date:   Thu,  4 May 2023 13:04:32 +0530
Message-Id: <20230504073432.6438-3-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230504073432.6438-1-sinthu.raja@ti.com>
References: <20230504073432.6438-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1683185687-305117-5471-1408-1
X-BESS-VER: 2019.1_20230502.2000
X-BESS-Apparent-Source-IP: 209.85.210.198
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyMTU3BrIygILGyWkmZoYp5o
        aG5oYWSWZmqYnmBsYGBsmmKYZJBpbGKUq1sQAriYrKQQAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.247924 [from 
        cloudscan20-201.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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

No changes in V5.

Changes in V4:
 * Correct the pinctrl node offsets as per the newly split wkup_pmx*
   and main_pmx* nodes.

 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 77 ++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index 67bcf906ded1..67cbbfdc16b6 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -173,6 +173,32 @@ J721S2_IOPAD(0x0a0, PIN_INPUT, 0) /* (AB25) MCASP0_AXR12.MCAN7_RX */
 			J721S2_IOPAD(0x09c, PIN_INPUT, 0) /* (T24) MCASP0_AXR11.MCAN7_TX */
 		>;
 	};
+
+	main_i2c4_pins_default: main-i2c4-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x010, PIN_INPUT_PULLUP, 8) /* (AF28) MCAN13_RX.I2C4_SDA */
+			J721S2_IOPAD(0x014, PIN_INPUT_PULLUP, 8) /* (AD25) MCAN14_TX.I2C4_SCL */
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
 
 &wkup_pmx2 {
@@ -214,12 +240,46 @@ J721S2_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (C23) WKUP_GPIO0_4.MCU_MCAN1_TX*/
 		>;
 	};
 
+	mcu_i2c0_pins_default: mcu-i2c0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x098, PIN_INPUT, 0) /*(H24) WKUP_GPIO0_63.MCU_I2C0_SCL*/
+			J721S2_WKUP_IOPAD(0x09C, PIN_INPUT, 0) /*(H27) WKUP_GPIO0_64.MCU_I2C0_SDA*/
+		>;
+	};
+
 	mcu_i2c1_pins_default: mcu-i2c1-pins-default {
 		pinctrl-single,pins = <
 			J721S2_WKUP_IOPAD(0x078, PIN_INPUT, 0) /* (F24) WKUP_GPIO0_8.MCU_I2C1_SCL */
 			J721S2_WKUP_IOPAD(0x07c, PIN_INPUT, 0) /* (H26) WKUP_GPIO0_9.MCU_I2C1_SDA */
 		>;
 	};
+
+	mcu_rpi_header_gpio0_pins0_default: mcu-rpi-header-gpio0-pins0-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x118, PIN_INPUT, 7) /* (G25) WKUP_GPIO0_66 */
+			J721S2_WKUP_IOPAD(0x05C, PIN_INPUT, 7) /* (E24) MCU_SPI1_D0.WKUP_GPIO0_1 */
+			J721S2_WKUP_IOPAD(0x060, PIN_INPUT, 7) /* (C28) MCU_SPI1_D1.WKUP_GPIO0_2 */
+			J721S2_WKUP_IOPAD(0x058, PIN_INPUT, 7) /* (D26) MCU_SPI1_CLK.WKUP_GPIO0_0 */
+			J721S2_WKUP_IOPAD(0x094, PIN_INPUT, 7) /* (D25) MCU_SPI1_CS2.WKUP_GPIO0_15*/
+			J721S2_WKUP_IOPAD(0x0B8, PIN_INPUT, 7) /* (G27) WKUP_GPIO0_56 */
+			J721S2_WKUP_IOPAD(0x114, PIN_INPUT, 7) /* (J26) WKUP_GPIO0_57 */
+			J721S2_WKUP_IOPAD(0x11C, PIN_INPUT, 7) /* (J27) WKUP_GPIO0_67 */
+			J721S2_WKUP_IOPAD(0x064, PIN_INPUT, 7) /* (C27) MCU_SPI1_CS0.WKUP_GPIO0_3 */
+		>;
+	};
+};
+
+&wkup_pmx3 {
+	mcu_rpi_header_gpio0_pins1_default: mcu-rpi-header-gpio0-pins1-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x000, PIN_INPUT, 7) /* (K26) WKUP_GPIO0_49 */
+		>;
+	};
+};
+
+&main_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rpi_header_gpio0_pins_default>;
 };
 
 &main_gpio2 {
@@ -235,7 +295,8 @@ &main_gpio6 {
 };
 
 &wkup_gpio0 {
-	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_rpi_header_gpio0_pins0_default &mcu_rpi_header_gpio0_pins1_default>;
 };
 
 &wkup_gpio1 {
@@ -271,6 +332,20 @@ exp1: gpio@21 {
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

