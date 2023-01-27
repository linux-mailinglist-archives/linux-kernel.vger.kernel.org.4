Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1997167E0FD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjA0KDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjA0KCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:02:55 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BFB46A1;
        Fri, 27 Jan 2023 02:02:52 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bk16so4450892wrb.11;
        Fri, 27 Jan 2023 02:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+i0eLMTWjOI2xC42he9R9s//kUQXBFdMh3V8zfod4pQ=;
        b=CEDqIzPAE0IuViSWoc4Jbuq4+Ywymqqxss4De4eoB/GtIMGKJemPE0LXqNAkw4gv8/
         PS0n7qDXtOdkuGVn7ZMsP+LSXOY8qExML2zTkr2gvws+g+qUwR1V57R69jpYoD0GzWHq
         jBTv19svOOwtUeYVaYs9C2xtSS85lii6GTlJRxcNgpzxshGilz9DnUnx9LxLEJQ088Pa
         L5y+g4FpMFShtPBf9s4e4ZN5KuRs4zU/DOE/QWTEiJgr+MWXfsNpneChEweXin8qf3Jq
         NJFF49FXjHCP9fO40daUS2qowGQFJ5I8m+1jSWMTbj+RQNdI4tn8I5IppYxuPdPAdo+f
         X70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+i0eLMTWjOI2xC42he9R9s//kUQXBFdMh3V8zfod4pQ=;
        b=efcFj6Hb5CMffK2rooQEyNGWw62/GXc36MiWDz0iaPotzUtVHl87QEy32y12Mo3qTS
         W5YtZWJMaJTWQZjT8n4v9S2F27jNB5EMQ6yJOK5udbK64bT/hFo8dvY9r+PEWAmWIALV
         ShrpnU3VZyT6Dwn3RBIrW1Cgg6B+7xbfgNU+EjRjp7b77+mYsQKvgzzPGGgDlHOKv4i9
         HmGIaAzqTN6zdXH3ZYnohVMvBh4EO4vAVifZSRvBlbcYzaD9q2jFA0PObfnBEWVcsU7W
         P+MflzYWefHpo8IBSckeurCaUsvm5tw9BEDCdFusxqTLsLgVo9ZJGTtt603YRNkfYYi1
         f97A==
X-Gm-Message-State: AO0yUKXzD6XBxgctkYoDVyUjz8uUkOL4pHGa5RenJhRlijBt/xgdk4Zq
        Bo+7g1hzxFiegrg0wnidbyA=
X-Google-Smtp-Source: AK7set/sExxhpwfnb0/OUAoqxgO6THNrfla6W5lL0Vl3QVhcUlTPuU3lQDcCiY7dvm2OuFiwjR64aA==
X-Received: by 2002:adf:a1dc:0:b0:2bf:b4ca:6bac with SMTP id v28-20020adfa1dc000000b002bfb4ca6bacmr9050741wrv.59.1674813771093;
        Fri, 27 Jan 2023 02:02:51 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id l7-20020adffe87000000b002bfbe30e8f8sm3493858wrr.98.2023.01.27.02.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:02:50 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 4/4] arm64: dts: meson: add support for BananaPi M2-Pro
Date:   Fri, 27 Jan 2023 10:02:36 +0000
Message-Id: <20230127100236.3385154-5-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127100236.3385154-1-christianshewitt@gmail.com>
References: <20230127100236.3385154-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPI-M2-PRO is based upon the BPI-M5 design except for a different
physical board layout and the following changes:

- USB 3.0 ports reduced from 4x to 2x
- 3.5mm Combined CVBS/Audio Jack removed
- RTL8821BU WiFi/BT module (internal USB connected)

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../dts/amlogic/meson-sm1-bananapi-m2-pro.dts | 98 +++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 97b42e2100e0..644451794aca 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -60,6 +60,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-wetek-core2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-s4-s805x2-aq222.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air-gbit.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m2-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m5.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-h96-max.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
new file mode 100644
index 000000000000..4890d5d9a4f7
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2021 BayLibre SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include "meson-sm1-bananapi.dtsi"
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+
+/ {
+	compatible = "bananapi,bpi-m2-pro", "amlogic,sm1";
+	model = "Banana Pi BPI-M2-PRO";
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "BPI-M2-PRO";
+		audio-aux-devs = <&tdmout_b>;
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT";
+
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-3 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-4 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&clkc_audio {
+	status = "okay";
+};
+
+&frddr_a {
+	status = "okay";
+};
+
+&frddr_b {
+	status = "okay";
+};
+
+&frddr_c {
+	status = "okay";
+};
+
+&tdmif_b {
+	status = "okay";
+};
+
+&tdmout_b {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
-- 
2.34.1

