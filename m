Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9AF6EF2B6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbjDZKuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbjDZKtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:49:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E406C114
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f199696149so30998705e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682506183; x=1685098183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHZCc6iP5cyLl1hYj/g5I+gkLg+6HSQEelOpwfLOUMc=;
        b=Pie75K4s8BIhiYlJtqo1aE33z9rRXKp084j6G7Y2Ilh2Ph6Rgn1HkDVTomOwlo+cSG
         rGxapLjA39BkiPoer7JDCuJSZf0dntpYgt1/BHq6Sc6gGJQ8JzPbkMLO7gjCpo4qhdRP
         W5QYOkT1CEwSt4M5gTyZXkn0PnF/BTxMXENZ5DEMlRw7Qf9J3zLNuqZBvRxke1STito4
         O4WR+cOiMnOZqDl9gyfVm0+GX8Gxj+3uTRWsqqBuXYNkN/q5ZdR4hlxl4a1ZINI799AQ
         QLZBP+ZbvVMXgBKF0IYPzm97622vw8ase2z3m0PqbCStnx9t9hTZfJx4GwVTk4iXjNvo
         cT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682506183; x=1685098183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHZCc6iP5cyLl1hYj/g5I+gkLg+6HSQEelOpwfLOUMc=;
        b=UAdEhe3pUT9F4yq5NIrH354lfDgjXsMDPSXyNJ7GjZG9Cfj1PQEvw/pBMfdvHBdil7
         mQq6uXVwl/8tnTiz8+3OjWMk8Gx2To7191MQFjcPtZ9Wb4BMzfz9nW9J7/jhZH6SBkic
         BXxRujCZT9p80IHlD+oeGuwV4YynYWyxr44N7BsUcH3CQooJW5g/dTq3Htpz0vRzvtyq
         ugsnMUH5Uu27Jo/jso4VnzKpoyyqR0PTu314dWb/3cUJjovC0q9RKzMtK+kcCMycN/+v
         zocdYeKEAJ0kUnP9XIiE8H2CtVWcVLDgpEOlpbw5tSKcdQEIU8hBaRX0MNkMat/loVoW
         U8vg==
X-Gm-Message-State: AAQBX9f4YmvdTHgcXgtTSm4q4SF5n9gOnYBhNfO7npw/F3ohGSW9U5oW
        EFZ1khuZMCGaxNYtE09Rvq0I/w==
X-Google-Smtp-Source: AKy350b+nkeh2k3kvh6FTUFlfqz2hgtLY5Nrp0IeTIDIAO1j9FguHfr/KBTgS3go1H7rvFSBHL6iDA==
X-Received: by 2002:a05:600c:21d7:b0:3f1:7a57:45cd with SMTP id x23-20020a05600c21d700b003f17a5745cdmr12735166wmj.28.1682506183332;
        Wed, 26 Apr 2023 03:49:43 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 25-20020a05600c025900b003ed2c0a0f37sm17601988wmj.35.2023.04.26.03.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 03:49:42 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 26 Apr 2023 12:49:06 +0200
Subject: [PATCH v6 06/12] arm64: dts: mediatek: add mmc support for
 mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v6-6-8d6b1cfe7f29@baylibre.com>
References: <20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5035; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=KUgwewXk1EivxDw0z0iI41cPCEtipZA2btoK/tgfO1Y=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkSQG/umbZhwtoBekc0Z2zrbAmgbW+PJfC5PmhHcFL
 +xNsY1uJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZEkBvwAKCRArRkmdfjHURZxAD/
 sH7glPjJVGqd4zDlFQlqHk13vRY2wKNLumy5NScLHrqU4b8P5vqMZLUhfdIGJhLB6NFBeX9pjFkJB7
 kH57Z9R8WsDVGc3sv5HnICc27mRmrXjMIS9zRIrrxxMigydLfTv2Zcbog3V9NIjJ1JcN4vrNxdLsev
 SafpnNi6Uy+D+9VO0YUfKtgFrq0ikbQ5HAw4qi3vOYK95kJnNLFn9XvxbIgAvEjaO0qIo6tmDQzUoq
 mLoue4Tyb5UqU76XNSnqzTWPedGP4Qa8pGVJUxGTrREE7RuVpPZ0imjO+I90VPzYJRvrgXo2nU6UOC
 KWEYbEfulOeMhGKwsC/d0e1Zf8jjoIVjhrnsMsv8+A3StGJItSiPIB8ldZWRx1mJxI5GbnsSQLu7Cd
 9Um7SlmVN1m8Mr/AkPWQn4TlgUGvoY1mYunNULMHZR9wETEZ8s+8yXT1vsrzrme0iDoWQ+0D5RmZhu
 85drnIja/FVz5kyT8P/Jz+jasaHVRoff9U/9EpAE/tz5Gc5M3VVLTh14eT8eXWmjc6qlsde7SaQYPY
 DjdO8Rrex4qHi4+8L6VpdEly8Ht1zKi91c4Jo2BKfuvjFAFWM0c/MQ8Pqr12xR1xQysB6/22d4ka5f
 HpvxhpEViJ/H7Mnh/N4aKA1gPPbZ3UYkYRYTxv3mo4z7eUNEgVzAWaih4RZg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add EMMC support on mmc0 (internal memory)
- Add SD-UHS support on mmc1 (external memory)

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 138 ++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index a238bd0092d2..cd920d09c3fe 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -95,6 +95,42 @@ &i2c0 {
 	status = "okay";
 };
 
+&mmc0 {
+	assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL>;
+	assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	hs400-ds-delay = <0x12012>;
+	max-frequency = <200000000>;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	no-sd;
+	no-sdio;
+	non-removable;
+	pinctrl-0 = <&mmc0_default_pins>;
+	pinctrl-1 = <&mmc0_uhs_pins>;
+	pinctrl-names = "default", "state_uhs";
+	vmmc-supply = <&mt6357_vemc_reg>;
+	vqmmc-supply = <&mt6357_vio18_reg>;
+	status = "okay";
+};
+
+&mmc1 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cd-gpios = <&pio 76 GPIO_ACTIVE_LOW>;
+	max-frequency = <200000000>;
+	pinctrl-0 = <&mmc1_default_pins>;
+	pinctrl-1 = <&mmc1_uhs_pins>;
+	pinctrl-names = "default", "state_uhs";
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	vmmc-supply = <&mt6357_vmch_reg>;
+	vqmmc-supply = <&mt6357_vio18_reg>;
+	status = "okay";
+};
+
 &mt6357_pmic {
 	interrupts-extended = <&pio 145 IRQ_TYPE_LEVEL_HIGH>;
 	interrupt-controller;
@@ -118,6 +154,108 @@ pins {
 		};
 	};
 
+	mmc0_default_pins: mmc0-default-pins {
+		clk-pins {
+			pinmux = <MT8365_PIN_99_MSDC0_CLK__FUNC_MSDC0_CLK>;
+			bias-pull-down;
+		};
+
+		cmd-dat-pins {
+			pinmux = <MT8365_PIN_103_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
+				 <MT8365_PIN_102_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
+				 <MT8365_PIN_101_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
+				 <MT8365_PIN_100_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
+				 <MT8365_PIN_96_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
+				 <MT8365_PIN_95_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
+				 <MT8365_PIN_94_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
+				 <MT8365_PIN_93_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
+				 <MT8365_PIN_98_MSDC0_CMD__FUNC_MSDC0_CMD>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		rst-pins {
+			pinmux = <MT8365_PIN_97_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_uhs_pins: mmc0-uhs-pins {
+		clk-pins {
+			pinmux = <MT8365_PIN_99_MSDC0_CLK__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_10mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		cmd-dat-pins {
+			pinmux = <MT8365_PIN_103_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
+				 <MT8365_PIN_102_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
+				 <MT8365_PIN_101_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
+				 <MT8365_PIN_100_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
+				 <MT8365_PIN_96_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
+				 <MT8365_PIN_95_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
+				 <MT8365_PIN_94_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
+				 <MT8365_PIN_93_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
+				 <MT8365_PIN_98_MSDC0_CMD__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_10mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		ds-pins {
+			pinmux = <MT8365_PIN_104_MSDC0_DSL__FUNC_MSDC0_DSL>;
+			drive-strength = <MTK_DRIVE_10mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		rst-pins {
+			pinmux = <MT8365_PIN_97_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
+			drive-strength = <MTK_DRIVE_10mA>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_default_pins: mmc1-default-pins {
+		cd-pins {
+			pinmux = <MT8365_PIN_76_CMDAT8__FUNC_GPIO76>;
+			bias-pull-up;
+		};
+
+		clk-pins {
+			pinmux = <MT8365_PIN_88_MSDC1_CLK__FUNC_MSDC1_CLK>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		cmd-dat-pins {
+			pinmux = <MT8365_PIN_89_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
+				 <MT8365_PIN_90_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
+				 <MT8365_PIN_91_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
+				 <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
+				 <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD>;
+			input-enable;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc1_uhs_pins: mmc1-uhs-pins {
+		clk-pins {
+			pinmux = <MT8365_PIN_88_MSDC1_CLK__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		cmd-dat-pins {
+			pinmux = <MT8365_PIN_89_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
+				 <MT8365_PIN_90_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
+				 <MT8365_PIN_91_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
+				 <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
+				 <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		pins {
 			pinmux = <MT8365_PIN_35_URXD0__FUNC_URXD0>,

-- 
2.25.1

