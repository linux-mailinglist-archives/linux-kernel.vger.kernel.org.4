Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B820A65FFBD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjAFLpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjAFLox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:44:53 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB10D7288B;
        Fri,  6 Jan 2023 03:44:42 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g13so1612558lfv.7;
        Fri, 06 Jan 2023 03:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTcl600pDzrnpdfWBl9TTlz9m8e040eSk0hBjsXBcRU=;
        b=KNnS6I5xYipooWbgpn7CNe+94PFxkqXg/rWma/WYNFXBP8rcC05koHrfEEUePGLNGa
         HDww6+kbZ5xI1QP21zRiZvkpWVLk44vSxUHQL6YXl2W87Hj7ZaC4CPwy9dpJ6yW5FKXt
         mE4//IJq/Ek0Uq9O72a95oZCGGoqvqFT73LkOQTjsIvV8anAQ5keKO6H5oNa+kfc+R8G
         GwePEqSzqMbNiXj5g54WoLi17QaUv1JL6SpnN8zW2X8/tpliEedkK7HvOo62vSYqNMjT
         rZ0+6ifN5duIdOwp3foLGiHO6EBBCmMxZ9P7lo5SBj9W7azdHS5tyhXSL3q42rK8vFxP
         p0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTcl600pDzrnpdfWBl9TTlz9m8e040eSk0hBjsXBcRU=;
        b=lVWV9aPOOIPKzFLe8eo2K3tVaU8tkGydAsrxgA6++MCu1uQ+3Kf0T2TJDgMlz9fb9v
         tH0AQcS0RhvygcrobbkpMu5oci2UznIhg0RzcB1oq+NQnW/fgvC0OYQnsQZnO+tgbQDv
         OVblIkoOkPkaoD4zj0Pdj+01wxeKeFYZPojlonUWtecfhH2nntsySVYgEqa6NgFmsLnT
         FwQIKXAGHaJ6hi5gP2nudFUVjEP+P+BF1SfCpKhlIJZhV5GxDpy3WDTSUN0gzZBx4Orn
         6FVisUIv6WjACWWKIRjYkUJOKOUB4ozQUDN4mcKvhI45ruSSqeRxzwo3wnfyyDaiVms3
         e0Iw==
X-Gm-Message-State: AFqh2krdotkHLgOtJi7UN2GyyRBv1JC0gKGPhGSVfmMeQuOxVYXJnbnt
        iZso3/ltPn393TMmygkPNsQ+kbOHSh5xRg==
X-Google-Smtp-Source: AMrXdXvFufon134Onw4Dr4xScWBuvH2nQ1XKTYmgj/BTXI9cXbUafI8ih9OHQwdTqtWVqfPizBb/Bg==
X-Received: by 2002:ac2:5ec9:0:b0:4b5:b6e8:bb53 with SMTP id d9-20020ac25ec9000000b004b5b6e8bb53mr14473916lfq.24.1673005480945;
        Fri, 06 Jan 2023 03:44:40 -0800 (PST)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id u3-20020ac258c3000000b004b5872a7003sm129747lfo.98.2023.01.06.03.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 03:44:40 -0800 (PST)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Add display backlight
Date:   Fri,  6 Jan 2023 13:44:03 +0200
Message-Id: <20230106114403.275865-4-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106114403.275865-1-matti.lehtimaki@gmail.com>
References: <20230106114403.275865-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Uses ti,lp8556 backlight with clk-pwm.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 .../dts/qcom-apq8026-samsung-matisse-wifi.dts | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
index 15b9590ba07b..848cfda64e5a 100644
--- a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
@@ -23,6 +23,14 @@ aliases {
 		display0 = &framebuffer0;
 	};
 
+	backlight_pwm: pwm {
+		compatible = "clk-pwm";
+		#pwm-cells = <2>;
+		clocks = <&mmcc CAMSS_GP0_CLK>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight_pwm_default_state>;
+	};
+
 	chosen {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -80,6 +88,45 @@ key-volume-up {
 		};
 	};
 
+	i2c-backlight {
+		compatible = "i2c-gpio";
+		sda-gpios = <&tlmm 20 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&tlmm 21 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight_i2c_default_state>;
+
+		i2c-gpio,delay-us = <4>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		backlight@2c {
+			compatible = "ti,lp8556";
+			reg = <0x2c>;
+
+			dev-ctrl = /bits/ 8 <0x80>;
+			init-brt = /bits/ 8 <0x3f>;
+			pwm-period = <100000>;
+
+			pwms = <&backlight_pwm 0 100000>;
+			pwm-names = "lp8556";
+
+			rom-a0h {
+				rom-addr = /bits/ 8 <0xa0>;
+				rom-val = /bits/ 8 <0x44>;
+			};
+			rom-a1h {
+				rom-addr = /bits/ 8 <0xa1>;
+				rom-val = /bits/ 8 <0x6c>;
+			};
+			rom-a5h {
+				rom-addr = /bits/ 8 <0xa5>;
+				rom-val = /bits/ 8 <0x24>;
+			};
+		};
+	};
+
 	reg_tsp_1p8v: regulator-tsp-1p8v {
 		compatible = "regulator-fixed";
 		regulator-name = "tsp_1p8v";
@@ -418,6 +465,18 @@ accel_int_default_state: accel-int-default-state {
 		bias-disable;
 	};
 
+	backlight_i2c_default_state: backlight-i2c-default-state {
+		pins = "gpio20", "gpio21";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	backlight_pwm_default_state: backlight-pwm-default-state {
+		pins = "gpio33";
+		function = "gp0_clk";
+	};
+
 	muic_int_default_state: muic-int-default-state {
 		pins = "gpio67";
 		function = "gpio";
-- 
2.34.1

