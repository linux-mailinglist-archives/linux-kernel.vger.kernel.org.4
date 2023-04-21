Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637E66EA8C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjDULDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDULDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:03:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331389013
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 04:03:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso2592376b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 04:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682075017; x=1684667017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m0I1sPCdYN0SbjWyDhk4aoTpPCovY0PSzi4d7N1NDJg=;
        b=mc1zwRaK4FAH7g6eSmoxngIMQ+5NXpyIKsfLdgr5W8xUrUlq9W7TbZkKtInZhi+DfH
         +otn/a7Mxi6OW2qTj0rtw+7PHVob4Hzgl+wa8tfdAwGGhx5SPWFzGlHv/cNk6hzFBOUP
         y+jq2HY6gxEhJJlakAZcN6zK4wg1LXE4/we4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682075017; x=1684667017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0I1sPCdYN0SbjWyDhk4aoTpPCovY0PSzi4d7N1NDJg=;
        b=YBjGKrr2MFPkNN36QAQ4stKI2PLUZcnQUaGktkwEHFNRzYNZbA3HCdnW5b1oQMe8au
         LWGesKJZ84O8IqJbWtmq6AJ/puKIH7vWk6ZWXr4txAEMqIhtyRnFs+oGR7M9RDQJJh1Y
         KXBGEP8dnT2I39ZxCCzArMMlNrucft9Xfz473OqTMjU8WGPtvB4Vv1bp01thq2AeXNNg
         NfNBVzwrNez/6qQMEWU3cu65tZKHB9Q0yy5SvjR00g7lbQA8j0ypEG1l34KxiRzDJjUr
         P7kRZu5Sgls/UMzd79wHuoqCUZr9lv4VRQiySmNSaoBIYECF/vB475n2eqYuvWOTQ6ZR
         3Cqw==
X-Gm-Message-State: AAQBX9dRT8pw7f/WarBkrGCeUAp8i17vkgiTezxJlxalrtvifavcuqqH
        N13Ws6MgWXHW6sVVHMmaMQmcnXjanal/EVo1DGs=
X-Google-Smtp-Source: AKy350bwnnxLR6pYSUpKWU0Q4r+z54dq3jUrc4qFIiJZ2/JeH/C++AywzL44Oskd0E07kjJUUHSwww==
X-Received: by 2002:a05:6a20:4323:b0:ef:acca:9e19 with SMTP id h35-20020a056a20432300b000efacca9e19mr6865535pzk.14.1682075017705;
        Fri, 21 Apr 2023 04:03:37 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:47fa:fa8d:a971:f6ac])
        by smtp.gmail.com with ESMTPSA id fb31-20020a056a002d9f00b005e5b11335b3sm2801286pfb.57.2023.04.21.04.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 04:03:37 -0700 (PDT)
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
Subject: [PATCH] arm64: dts: mediatek: mt8192-asurada-hayato: Enable Bluetooth
Date:   Fri, 21 Apr 2023 19:03:27 +0800
Message-ID: <20230421110327.2395804-1-wenst@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hayato's Realtek WiFi/BT module has it's Bluetooth function wired to
UART1.

Add and enable the relevant device nodes for it.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../dts/mediatek/mt8192-asurada-hayato-r1.dts | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
index 43a823990a92..6a7d7870525b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
@@ -40,9 +40,89 @@ CROS_STD_MAIN_KEYMAP
 	>;
 };
 
+&pio {
+	bt_pins: bt-pins {
+		bt_kill: pins-bt-kill {
+			pinmux = <PINMUX_GPIO144__FUNC_GPIO144>; /* BT_KILL_L */
+			output-low;
+		};
+
+		bt_wake: pins-bt-wake {
+			pinmux = <PINMUX_GPIO22__FUNC_GPIO22>;  /* bt to wake ap */
+			bias-pull-up;
+		};
+
+		ap_wake_bt: pins-ap-wake-bt {
+			pinmux = <PINMUX_GPIO168__FUNC_GPIO168>; /* AP_WAKE_BT_H */
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
+			output-enable;
+		};
+	};
+
+	uart1_pins_sleep: uart1-pins-sleep {
+		pins-rx {
+			pinmux = <PINMUX_GPIO94__FUNC_GPIO94>;
+			input-enable;
+			bias-pull-up;
+		};
+		pins-tx {
+			pinmux = <PINMUX_GPIO95__FUNC_UTXD1>;
+		};
+		pins-cts {
+			pinmux = <PINMUX_GPIO166__FUNC_UCTS1>;
+			input-enable;
+		};
+		pins-rts {
+			pinmux = <PINMUX_GPIO167__FUNC_URTS1>;
+			output-enable;
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
+	bluetooth: bluetooth {
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

