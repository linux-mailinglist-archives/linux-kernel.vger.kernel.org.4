Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB86B6C9C88
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjC0Hnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjC0Hn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316F71B8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679902934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9gEvGzO/t3GSZzHhYPQWJ5afaAW4baouQV1YxDz4Oxo=;
        b=fKi8SaBZ1tGJJpYdX68NkToFQeOLb7pYT98a7h91SIRBk76HcBy1ho5fm1ibcglkW0HCXH
        bJoIMkq63TUcYgIo0ldN6NSrlarXv3KqqLhc/Pq/xELHY3eIywIG8j+qorVr4Xsz/3AByi
        VluL+TNiFYOaIdckqCuX/4rUut7nxX4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-z1iCFoUcM1uT9cCe6nqrhw-1; Mon, 27 Mar 2023 03:42:09 -0400
X-MC-Unique: z1iCFoUcM1uT9cCe6nqrhw-1
Received: by mail-wm1-f69.google.com with SMTP id bd16-20020a05600c1f1000b003ee895f6201so5250378wmb.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679902928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gEvGzO/t3GSZzHhYPQWJ5afaAW4baouQV1YxDz4Oxo=;
        b=Nf7Xg4l/1Y+2c9ocr/3DOPCo5bPIIgpaAdaip4M/OWjAZlZa7H7R66v19lJWjTqQun
         DeCdd68Tz53IV9GZVdojZaZZusZDYsqLn9E4BJ7PmVsgeZLfPgHAWKe2lxiAAeZs+gww
         vmfpSfBc5OUXagXqdgr2WltkkHC2aaJ5P0HWlGO48JAMPRLHbMhGKmhDDkR4NRLK2nfP
         Gph9CRGZYvTrRoZ/W5tk4ap2S77Lkrh3lpwCccdY8RebqueHnjTbjP7HCLbf/MVjKsy8
         zhr/5xUZXax+S0VljUAo0vdtjzyt3IaVBQGHEaWbSEPSvd4wTPpe1cPrsduNsUOgwCED
         pO2Q==
X-Gm-Message-State: AO0yUKX73Je4g0J3xyp7jiEq13El/7HM9knHhu3YaWxaljYMj4AJ22uo
        KcFiX3VxC30s2koLfFZ4eCfHwDckJWSpAYG6WQcwVFsmQohGmS0S/a3Y6scxX5lS5TY/91FuFj5
        okS6KXXLfZQQyFPRmTdOExoZexdjmn0hY1o+iCPHOxuhwfLAD0AzBT7hz7+mgba9uv54TO+vA00
        eBDqP1bCQ=
X-Received: by 2002:a05:600c:b42:b0:3ee:6cdf:c357 with SMTP id k2-20020a05600c0b4200b003ee6cdfc357mr7727996wmr.20.1679902928518;
        Mon, 27 Mar 2023 00:42:08 -0700 (PDT)
X-Google-Smtp-Source: AK7set9/tMR3AjsxF/BVjZ53UH5flNgkScCgYAEe7XzL7RWa18N1EYtYJbvZivLJq7GDux7Kr9leMA==
X-Received: by 2002:a05:600c:b42:b0:3ee:6cdf:c357 with SMTP id k2-20020a05600c0b4200b003ee6cdfc357mr7727965wmr.20.1679902928101;
        Mon, 27 Mar 2023 00:42:08 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z8-20020a05600c0a0800b003edc4788fa0sm7902247wmp.2.2023.03.27.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 00:42:07 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Robert Mader <robert.mader@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Ondrej Jirman <megi@xff.cz>, Martijn Braam <martijn@brixit.nl>,
        =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2] arm64: dts: rk3399-pinephone-pro: Add internal display support
Date:   Mon, 27 Mar 2023 09:41:35 +0200
Message-Id: <20230327074136.1459212-1-javierm@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

The phone's display is using a Hannstar LCD panel. Support it by adding a
panel DT node and all needed nodes (backlight, MIPI DSI, regulators, etc).

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Martijn Braam <martijn@brixit.nl>
Co-developed-by: Kamil Trzciński <ayufan@ayufan.eu>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Drop touchscreen node because used the wrong compatible (Ondrej Jirman).
- Fix assigned-clock-parents in vopb node (Ondrej Jirman).
- Add vopl and vopl nodes.

 .../dts/rockchip/rk3399-pinephone-pro.dts     | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index a0795a2b1cb1..5116f156d548 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -29,6 +29,12 @@ chosen {
 		stdout-path = "serial2:115200n8";
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm0 0 1000000 0>;
+		pwm-delay-us = <10000>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -102,6 +108,32 @@ wifi_pwrseq: sdio-wifi-pwrseq {
 		/* WL_REG_ON on module */
 		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 	};
+
+	/* MIPI DSI panel 1.8v supply */
+	vcc1v8_lcd: vcc1v8-lcd {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		regulator-name = "vcc1v8_lcd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc3v3_sys>;
+		gpio = <&gpio3 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&display_pwren1>;
+	};
+
+	/* MIPI DSI panel 2.8v supply */
+	vcc2v8_lcd: vcc2v8-lcd {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		regulator-name = "vcc2v8_lcd";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&vcc3v3_sys>;
+		gpio = <&gpio3 RK_PA1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&display_pwren>;
+	};
 };
 
 &cpu_alert0 {
@@ -139,6 +171,11 @@ &emmc_phy {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	i2c-scl-rising-time-ns = <168>;
@@ -362,6 +399,40 @@ &io_domains {
 	status = "okay";
 };
 
+&mipi_dsi {
+	status = "okay";
+	clock-master;
+
+	ports {
+		mipi_out: port@1 {
+			#address-cells = <0>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			mipi_out_panel: endpoint {
+				remote-endpoint = <&mipi_in_panel>;
+			};
+		};
+	};
+
+	panel@0 {
+		compatible = "hannstar,hsd060bhw4";
+		reg = <0>;
+		backlight = <&backlight>;
+		reset-gpios = <&gpio4 RK_PD1 GPIO_ACTIVE_LOW>;
+		vcc-supply = <&vcc2v8_lcd>; // 2v8
+		iovcc-supply = <&vcc1v8_lcd>; // 1v8
+		pinctrl-names = "default";
+		pinctrl-0 = <&display_rst_l>;
+
+		port {
+			mipi_in_panel: endpoint {
+				remote-endpoint = <&mipi_out_panel>;
+			};
+		};
+	};
+};
+
 &pmu_io_domains {
 	pmu1830-supply = <&vcc_1v8>;
 	status = "okay";
@@ -374,6 +445,20 @@ pwrbtn_pin: pwrbtn-pin {
 		};
 	};
 
+	dsi {
+		display_rst_l: display-rst-l {
+			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		display_pwren: display-pwren {
+			rockchip,pins = <3 RK_PA1 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		display_pwren1: display-pwren1 {
+			rockchip,pins = <3 RK_PA5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
 	pmic {
 		pmic_int_l: pmic-int-l {
 			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
@@ -429,6 +514,10 @@ &sdio0 {
 	status = "okay";
 };
 
+&pwm0 {
+	status = "okay";
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -479,3 +568,25 @@ bluetooth {
 &uart2 {
 	status = "okay";
 };
+
+&vopb {
+	status = "okay";
+	assigned-clocks = <&cru DCLK_VOP0_DIV>, <&cru DCLK_VOP0>, <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
+	assigned-clock-rates = <0>, <0>, <400000000>, <100000000>;
+	assigned-clock-parents = <&cru PLL_GPLL>, <&cru DCLK_VOP0_DIV>;
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&vopl {
+	status = "okay";
+	assigned-clocks = <&cru DCLK_VOP1_DIV>, <&cru DCLK_VOP1>, <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
+	assigned-clock-rates = <0>, <0>, <400000000>, <100000000>;
+	assigned-clock-parents = <&cru PLL_GPLL>, <&cru DCLK_VOP1_DIV>;
+};
+
+&vopl_mmu {
+	status = "okay";
+};

base-commit: da8e7da11e4ba758caf4c149cc8d8cd555aefe5f
-- 
2.39.2

