Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3E16BCEA0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCPLpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCPLpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:45:19 -0400
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273D8A1FF5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:45:17 -0700 (PDT)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199]) by mx-outbound10-239.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 16 Mar 2023 11:45:11 +0000
Received: by mail-il1-f199.google.com with SMTP id q8-20020a92ca48000000b00320ed437f04so671457ilo.19
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1678967110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+5R+OJ4prEWqV9IKGkQwmZCSFuZA1dGQAlASE9lZbk=;
        b=CWaqEc6ZAShC5fJlrctMS8e66fsBQEadVlviF6ImtjoBgdhhrDsbMuaVdgdKiYkZ4Y
         SIn+FEm7IbkZw49tFeQHxBG/bGEGsfp/xPFmoN5nk74dyZC+CTXCPNhnMy9lAfkwCJuO
         619zSlP9hWOfUh67RllvyOGeXg1mInJvf+utI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678967110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+5R+OJ4prEWqV9IKGkQwmZCSFuZA1dGQAlASE9lZbk=;
        b=NobSEBMAswPGdney1L56RWvUkwn2Ij/z9ZX1pDP1CIrDGE9YWHV4oHYKW9btw/3qBi
         Cb+I0jVuARxcuQ8EI84HngQKyKwUOyLKr2i/aOUFpeqRQdGnGyOSklTawg4kPYU0v4GC
         T+ZNUR1RQ6u8h7aTEQn2dbkUDR/5fpNod0V4dqUprRLYX2xgnRepqqzMtdJYVAtKo2Ch
         S+bo/vAAM1ZibpjTKWzaO5XBF9hHBe7SEYPnAt0RiGxYUBXlvXYYoFqfFYjGQrShIiEU
         lmNnepzpiNUzZUoAJAZss6q6OgoC5Mb3xwlVkgnFDMHmFysEo3tRe0XPItFEOZxNCY7k
         p+7g==
X-Gm-Message-State: AO0yUKWFRuZKYTbPAl14fs2WDFKBW4jgwJ16GCTFv94TSvN4nznpIgjb
        Tz8H3oAOh2t+whpzrqlTGymmlemjsMF2+Xm7f2gQGW4dhSK4PGqumqZvKfymFpJt6xYfatEAw0R
        twqZV65SUSjlgQIeoAEPUt9iiWWS7wa60XiX4XkKbUxmZ9j+n3smRhgmJ1JoI
X-Received: by 2002:a05:6a20:1445:b0:cd:c79:50e8 with SMTP id a5-20020a056a20144500b000cd0c7950e8mr3997421pzi.62.1678963682747;
        Thu, 16 Mar 2023 03:48:02 -0700 (PDT)
X-Google-Smtp-Source: AK7set/Xdjsa1n12qCmL60R8PvrCj48h0U4xuoqmiszCDYfValN1OdKRBxMfJRhoA4q6rNbjLG++mw==
X-Received: by 2002:a05:6a20:1445:b0:cd:c79:50e8 with SMTP id a5-20020a056a20144500b000cd0c7950e8mr3997402pzi.62.1678963682425;
        Thu, 16 Mar 2023 03:48:02 -0700 (PDT)
Received: from localhost.localdomain ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id f26-20020aa78b1a000000b005a8c92f7c27sm5108744pfd.212.2023.03.16.03.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 03:48:02 -0700 (PDT)
From:   sabiya.d@mistralsolutions.com
X-Google-Original-From: sabiya.d@ti.com
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sabiya.d@mistralsolutions.com,
        Dasnavis Sabiya <sabiya.d@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am69-sk: Add pinmux for RPi Header
Date:   Thu, 16 Mar 2023 16:17:43 +0530
Message-Id: <20230316104743.482972-3-sabiya.d@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316104743.482972-1-sabiya.d@ti.com>
References: <20230316104743.482972-1-sabiya.d@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1678967110-302799-32625-4106-1
X-BESS-VER: 2019.1_20230310.1716
X-BESS-Apparent-Source-IP: 209.85.166.199
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIytrQ0ALIygIIWxgaJhmmmyc
        aGhonGSSaWRmYWKWmWFilGhsaWSUlm5kq1sQARdgiIQQAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.246833 [from 
        cloudscan9-71.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_RULE7568M, NO_REAL_NAME, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dasnavis Sabiya <sabiya.d@ti.com>

Add pinmux required to bring out the i2c and gpios on 40 pin RPi
expansion header on AM69 SK board.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 72 +++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index bc49ba534790..5d2d96a50921 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -104,6 +104,37 @@ vdd_sd_dv: regulator-tlv71033 {
 	};
 };
 
+&wkup_pmx0 {
+	mcu_i2c0_pins_default: mcu-i2c0-pins-default {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x108, PIN_INPUT_PULLUP, 0) /* (M35) MCU_I2C0_SCL */
+			J784S4_WKUP_IOPAD(0x10C, PIN_INPUT_PULLUP, 0) /* (G34) MCU_I2C0_SDA */
+		>;
+	};
+
+	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x100, PIN_INPUT, 0) /* (N33) WKUP_I2C0_SCL */
+			J784S4_WKUP_IOPAD(0x104, PIN_INPUT, 0) /* (N35) WKUP_I2C0_SDA */
+		>;
+	};
+
+	mcu_rpi_header_gpio0_pins_default: mcu-rpi-header-gpio0-pins-default {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x190, PIN_INPUT, 7) /* (M33) WKUP_GPIO0_49 */
+			J784S4_WKUP_IOPAD(0x180, PIN_INPUT, 7) /* (N34) WKUP_GPIO0_66 */
+			J784S4_WKUP_IOPAD(0x0C4, PIN_INPUT, 7) /* (J34) WKUP_GPIO0_1 */
+			J784S4_WKUP_IOPAD(0x0C8, PIN_INPUT, 7) /* (J35) WKUP_GPIO0_2 */
+			J784S4_WKUP_IOPAD(0x0C0, PIN_INPUT, 7) /* (H38) WKUP_GPIO0_0 */
+			J784S4_WKUP_IOPAD(0x120, PIN_INPUT, 7) /* (M37) WKUP_GPIO0_56 */
+			J784S4_WKUP_IOPAD(0x17C, PIN_INPUT, 7) /* (M36) WKUP_GPIO0_57 */
+			J784S4_WKUP_IOPAD(0x0FC, PIN_INPUT, 7) /* (K37) WKUP_GPIO0_15 */
+			J784S4_WKUP_IOPAD(0x0CC, PIN_INPUT, 7) /* (J36) WKUP_GPIO0_3 */
+			J784S4_WKUP_IOPAD(0x184, PIN_INPUT, 7) /* (M34) WKUP_GPIO0_67 */
+		>;
+	};
+};
+
 &main_pmx0 {
 	main_uart8_pins_default: main-uart8-pins-default {
 		pinctrl-single,pins = <
@@ -137,6 +168,25 @@ vdd_sd_dv_pins_default: vdd-sd-dv-pins-default {
 			J784S4_IOPAD(0x0C4, PIN_INPUT, 7) /* (AD36) ECAP0_IN_APWM_OUT.GPIO0_49 */
 		>;
 	};
+
+	rpi_header_gpio0_pins_default: rpi-header-gpio0-pins-default {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0BC, PIN_INPUT, 7) /* (AD33) MCASP1_AFSX.GPIO0_47 */
+			J784S4_IOPAD(0x06C, PIN_INPUT, 7) /* (AJ37) MCASP4_AFSX.GPIO0_27 */
+			J784S4_IOPAD(0x0B4, PIN_INPUT, 7) /* (AL34) MCASP1_AXR4.GPIO0_45 */
+			J784S4_IOPAD(0x0C0, PIN_INPUT, 7) /* (AD38) MCASP1_AXR0.GPIO0_48 */
+			J784S4_IOPAD(0x00C, PIN_INPUT, 7) /* (AF33) MCAN13_TX.GPIO0_3 */
+			J784S4_IOPAD(0x0B8, PIN_INPUT, 7) /* (AC34) MCASP1_ACLKX.GPIO0_46 */
+			J784S4_IOPAD(0x090, PIN_INPUT, 7) /* (AC35) MCASP0_AXR8.GPIO0_36 */
+			J784S4_IOPAD(0x0A8, PIN_INPUT, 7) /* (AF34) MCASP0_AXR14.GPIO0_42 */
+			J784S4_IOPAD(0x0A4, PIN_INPUT, 7) /* (AJ36) MCASP0_AXR13.GPIO0_41 */
+			J784S4_IOPAD(0x034, PIN_INPUT, 7) /* (AJ34) PMIC_WAKE0n.GPIO0_13 */
+			J784S4_IOPAD(0x0CC, PIN_INPUT, 7) /* (AM37) SPI0_CS0.GPIO0_51 */
+			J784S4_IOPAD(0x08C, PIN_INPUT, 7) /* (AE35) MCASP0_AXR7.GPIO0_35 */
+			J784S4_IOPAD(0x008, PIN_INPUT, 7) /* (AJ33) MCAN12_RX.GPIO0_2 */
+			J784S4_IOPAD(0x004, PIN_INPUT, 7) /* (AG36) MCAN12_TX.GPIO0_1 */
+		>;
+	};
 };
 
 &main_uart8 {
@@ -145,6 +195,20 @@ &main_uart8 {
 	pinctrl-0 = <&main_uart8_pins_default>;
 };
 
+&mcu_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_i2c0_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+};
+
 &main_i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -175,6 +239,14 @@ &main_sdhci1 {
 	vqmmc-supply = <&vdd_sd_dv>;
 };
 
+&wkup_gpio0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_rpi_header_gpio0_pins_default>;
+};
+
 &main_gpio0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&rpi_header_gpio0_pins_default>;
 };
-- 
2.25.1

