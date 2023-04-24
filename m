Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CD96EC9B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjDXKEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjDXKEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:04:38 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2562A1712
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 03:04:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b60366047so3446401b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682330676; x=1684922676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V2WsBy9D+hRfwOWkrxwmd3lLjMwOzTRUf9EB9Q/QdtQ=;
        b=QAT8s9jI9J/mNPQLSP2R9Gv0/pCLs36KQ58Jrhu8C6+SrP/N1F/G4CaLqL7IRuYz9m
         o92u1G+OMIkgsdt4DEhrbqxoL4BiGD/GHiQou79/lSFaMsx8t0AIU0c5ARh/U93oJRRO
         hVJ/4lbG3A+A/vWLmsD/lBxcGAuDpvi+5OrPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682330676; x=1684922676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2WsBy9D+hRfwOWkrxwmd3lLjMwOzTRUf9EB9Q/QdtQ=;
        b=Eoy2odpzI/KQu80JPEOsCn2+24kWTGlAtHbP09JYs6L5qIrIwdQCG2iKefUZ/+yF0p
         6yIyjQr2dq4HvJyZdeo4ZlvEjucFbRE2qw03aYdBZnNEPxpbHT/tS7l4xF5QF+5jFmB7
         XEjPk5UmL9sMv1xjZE/79W2RompplRLD9+lw/mG9IKEYdwGjm+DOOE5pUFA/SXzeEc84
         q3NMRx7CW5VEfIr+zIVVcaHfCxgsVdvuofneH5GNIn/D1ZS5Jhdff3aGOVqkFI/QEOfX
         g8FyuMLuFLJ4yzpL+PsSjnYwO+loJ2RrhqyrkI4AFLbzm2YR5chlPmg7jUPUGsE86/Af
         ihQg==
X-Gm-Message-State: AAQBX9dzAy6sadsQFeBhLABcLW/W4ekFv55ELHLHLcS29Qr8LymcMaBY
        G60AxEAf3SxBUOejD2+lCzrcvw==
X-Google-Smtp-Source: AKy350bj/iADyzfE4iDotwQ7l2Rxbf6TbBeW1F3yNWU/4SiigkNJRyIeCg1s+Cm+cSH3JmiMZNXFWQ==
X-Received: by 2002:a05:6a00:cd2:b0:627:6328:79f1 with SMTP id b18-20020a056a000cd200b00627632879f1mr18330546pfv.34.1682330676591;
        Mon, 24 Apr 2023 03:04:36 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1d00:1ac0:e499:fc5b])
        by smtp.gmail.com with ESMTPSA id j18-20020a056a00235200b0063d46ec5777sm7084425pfj.158.2023.04.24.03.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 03:04:36 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v2] arm64: dts: mediatek: mt8192-asurada-hayato: Enable Bluetooth
Date:   Mon, 24 Apr 2023 18:04:09 +0800
Message-ID: <20230424100409.2992418-1-wenst@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hayato's Realtek WiFi/BT module has it's Bluetooth function wired to
UART1.

Add and enable the relevant device nodes for it.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes since v1:
- Dropped unreferenced labels
- Dropped GPIO line name comments
- Fixed pinctrl node names
- Dropped "output-enable" property
- Added spacing between device nodes for consistency

 .../dts/mediatek/mt8192-asurada-hayato-r1.dts | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
index 43a823990a92..6e23428a3ed2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
@@ -40,9 +40,90 @@ CROS_STD_MAIN_KEYMAP
 	>;
 };
 
+&pio {
+	bt_pins: bt-pins {
+		pins-bt-kill {
+			pinmux = <PINMUX_GPIO144__FUNC_GPIO144>;
+			output-low;
+		};
+
+		pins-bt-wake {
+			pinmux = <PINMUX_GPIO22__FUNC_GPIO22>;
+			bias-pull-up;
+		};
+
+		pins-ap-wake-bt {
+			pinmux = <PINMUX_GPIO168__FUNC_GPIO168>;
+			output-low;
+		};
+	};
+
+	uart1_pins: uart1-pins {
+		pins-rx {
+			pinmux = <PINMUX_GPIO94__FUNC_URXD1>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-tx {
+			pinmux = <PINMUX_GPIO95__FUNC_UTXD1>;
+		};
+
+		pins-cts {
+			pinmux = <PINMUX_GPIO166__FUNC_UCTS1>;
+			input-enable;
+		};
+
+		pins-rts {
+			pinmux = <PINMUX_GPIO167__FUNC_URTS1>;
+		};
+	};
+
+	uart1_pins_sleep: uart1-sleep-pins {
+		pins-rx {
+			pinmux = <PINMUX_GPIO94__FUNC_GPIO94>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-tx {
+			pinmux = <PINMUX_GPIO95__FUNC_UTXD1>;
+		};
+
+		pins-cts {
+			pinmux = <PINMUX_GPIO166__FUNC_UCTS1>;
+			input-enable;
+		};
+
+		pins-rts {
+			pinmux = <PINMUX_GPIO167__FUNC_URTS1>;
+		};
+	};
+};
+
 &touchscreen {
 	compatible = "hid-over-i2c";
 	post-power-on-delay-ms = <10>;
 	hid-descr-addr = <0x0001>;
 	vdd-supply = <&pp3300_u>;
 };
+
+&uart1 {
+	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&uart1_pins>;
+	pinctrl-1 = <&uart1_pins_sleep>;
+	/delete-property/ interrupts;
+	interrupts-extended = <&gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&pio 94 IRQ_TYPE_EDGE_FALLING>;
+
+	bluetooth {
+		compatible = "realtek,rtl8822cs-bt";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_pins>;
+
+		enable-gpios = <&pio 144 GPIO_ACTIVE_HIGH>;
+		device-wake-gpios = <&pio 168 GPIO_ACTIVE_HIGH>;
+		host-wake-gpios = <&pio 22 GPIO_ACTIVE_LOW>;
+	};
+};
-- 
2.40.0.634.g4ca3ef3211-goog

