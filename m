Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE66967E827
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjA0OXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjA0OWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:22:50 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440FD841B0;
        Fri, 27 Jan 2023 06:22:41 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so3604412wmq.0;
        Fri, 27 Jan 2023 06:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+77rbk+LDQVY8LBXczWlnz0WIcfcLWhxX1pA+0THIM=;
        b=DIeRH1fBk0Zr4EXjV4aqhp5gScRisiOALZ2XOFLU7Q0n8nO7/EziamoLUfm/eDSYWd
         827I/fLTu+v+S+nCJD/e9D7oCXv3FCGu0H5i6AuILcmle9F/COzaU8OsZFRDwV12OvC8
         zEE2sJxidMPnx7SXOEeELgPrwwuqj9HfzY178FGQQNHkFufhgxI32BbOdnON2+amNJME
         UMD3kPy1aFWnxjRWtPm4uOhmcWAdWhtRMqQO9fX6Lk+/6dVIvs7yeqVwIVa1VS0dFIq6
         BHq26IY9/rjAiwJPsNItdr6zbTQ5xQXbtzHI1ws5evkSxB5ns2cmWfb6/yTy9TSjEvJU
         djyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+77rbk+LDQVY8LBXczWlnz0WIcfcLWhxX1pA+0THIM=;
        b=czjzz4989pzYyTi21vR4LBZYj4VK74KT1jtDitoFDWYV+uM1WCuT0/amuBOUK3eaYt
         do6J3P96y4sg8dSKcYkzjg41v2f5Bp8sJm64HkFVT1Ky8uB3Ly+vdHkr+m3pMPraRX1B
         UjN7LD2RUSHcKrG5JfECOpPsXk5GYAhYNmTnwEGiQXTiubOluLj3BRwwOYObULEjBPZm
         eOBBtvWAlmcI0N/ozxaqZi+YTXUlo8cMqwoYI9yU7GcbgOI6dg5nRts5yWNxps55X46L
         rUvjVDdeYpgk/w8tde9mravmLuVqaowrlVawxoAvbI7+uQdZbY+NFcJ+zpv3fA7f/DDr
         6UCQ==
X-Gm-Message-State: AFqh2ko+MlQXBhE6vHjXMIL63v0itBEwiyZZ9G7rw9mVIv/RBFzF07Wn
        41VWCj24aN2iglVJZ6hRTWM=
X-Google-Smtp-Source: AMrXdXtx3MnOapAVHXeUKN5GkcF+H2YwoBHQnjNyk30TwP6ay34MaBM1nFR/iFba9qEOoRsF9nSNhQ==
X-Received: by 2002:a05:600c:2108:b0:3cf:98e5:f72 with SMTP id u8-20020a05600c210800b003cf98e50f72mr47632385wml.3.1674829359774;
        Fri, 27 Jan 2023 06:22:39 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c11-20020adfa30b000000b002bfb5ebf8cfsm4301039wrb.21.2023.01.27.06.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 06:22:39 -0800 (PST)
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
Subject: [PATCH v2 5/5] arm64: dts: meson: add support for BananaPi M2-Pro
Date:   Fri, 27 Jan 2023 14:22:21 +0000
Message-Id: <20230127142221.3718184-6-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127142221.3718184-1-christianshewitt@gmail.com>
References: <20230127142221.3718184-1-christianshewitt@gmail.com>
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
 .../dts/amlogic/meson-sm1-bananapi-m2-pro.dts | 97 +++++++++++++++++++
 2 files changed, 98 insertions(+)
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
index 000000000000..586034316ec3
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
@@ -0,0 +1,97 @@
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

