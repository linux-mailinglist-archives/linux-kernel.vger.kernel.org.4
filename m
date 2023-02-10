Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379FB691F20
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjBJM2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjBJM2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:28:35 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A527359C;
        Fri, 10 Feb 2023 04:28:33 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ba1so4911292wrb.5;
        Fri, 10 Feb 2023 04:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aW+Xc6jE1tZtkbSgroI6jR5Bd20w7LEpIgHknzDS1U8=;
        b=nWAYKV6nPw+ZVJ5IpixaLlHAfGLDGphE6F1LQ3m9IFP3j+y+uWtoutMtVXS33MQ0ss
         8F1M+67S6rl+ysrnS472YxWaKk5cjH/I7A2unp2HbrdNdV42D0rb1y5Dd9MucYtQmIeR
         73+jlFoMcp2/eeF+vXvktxkbOyZAj2RfOdNM9qfmuU3nCJjTBueK6GLqdXD7YUtk02Kq
         ztEPDa5hmAoW0EG3n4hpfxgDkKCAErU+aVXQwXH1Kdt0sRN4TRJpfIHqqDcFkQffkjFw
         bLDl/XA1Vn3Y9oiDRrLQwIYD52/RoG55WkS3d5HZqzHdL48lAyM/cmqfpf/PSNFISeMD
         XtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aW+Xc6jE1tZtkbSgroI6jR5Bd20w7LEpIgHknzDS1U8=;
        b=3LcoYs+1JmPL7tLkzgg3LF1E1jsvrDfYsA5asYjyA9XVdgo8Q6wQDzH9RIc3jzhIQE
         IUHuiaxlzp4CG1F/SFOzgPK0Z/ZIZWGB7f//Oo0ZY3Fn+dB1a5tEvwtcAqULvzANnmSm
         Wcjndtme8ca3aTKA5qkitMoqAyM+ty4Dl/50Q6T4wa3Lqmu9jg6ThQJzUO2G0SatMomK
         3hTZon2RzMHJJ0r0BE9AdR/Ph9qbT6TSreTYkm3O1V3PIuFqlrXXKXOi0wpkx4d7y2Ib
         sHadqS4uCckkIyiDu3RFnkExXvJC5XRRijqThmBbyOHDIWGuhYZQHsySeUOuuD3fxl9o
         zmMg==
X-Gm-Message-State: AO0yUKXAi9PgFh63JW2Wg8sW4t6zJlt3h4O7pn3y8O0RZDfjL5BVU92Q
        51ATW2hQL4h7szWfHY/RAUQ=
X-Google-Smtp-Source: AK7set+PSi1B1Ua/z60ldCA3JTes+hrolioO/IoKIlJPVXaE3QlJnMPN2LC35dlx3CQ9jKmN23Wn3w==
X-Received: by 2002:adf:ef84:0:b0:2bf:bac7:30d4 with SMTP id d4-20020adfef84000000b002bfbac730d4mr14227649wro.53.1676032112223;
        Fri, 10 Feb 2023 04:28:32 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b002c5493a17efsm1540989wrq.25.2023.02.10.04.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 04:28:31 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Ferass El Hafidi <vitali64pmemail@protonmail.com>
Subject: [PATCH 3/3] arm64: dts: meson: gxbb-kii-pro: add initial audio support
Date:   Fri, 10 Feb 2023 12:28:17 +0000
Message-Id: <20230210122817.1027765-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210122817.1027765-1-christianshewitt@gmail.com>
References: <20230210122817.1027765-1-christianshewitt@gmail.com>
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

Add initial support for HDMI and S/PDIF audio output.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Ferass El Hafidi <vitali64pmemail@protonmail.com>
---
 .../boot/dts/amlogic/meson-gxbb-kii-pro.dts   | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
index 435ae2aa404e..b6ee76011d82 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
@@ -9,11 +9,19 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "videostrong,kii-pro", "amlogic,meson-gxbb";
 	model = "Videostrong KII Pro";
 
+	spdif_dit: audio-codec-0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -35,6 +43,59 @@ button-reset {
 			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "KII-PRO";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_FIFO>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+		};
+
+		dai-link-3 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
+
+			codec-0 {
+				sound-dai = <&spdif_dit>;
+			};
+		};
+
+		dai-link-4 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&aiu {
+	status = "okay";
+	pinctrl-0 = <&spdif_out_y_pins>;
+	pinctrl-names = "default";
 };
 
 &ethmac {
-- 
2.34.1

