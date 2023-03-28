Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8DB6CB845
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjC1Hel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjC1HeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:34:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E61740D1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679988799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3RKROZr4GzDPgqMOFWqSLDrRs2RHwcu0c+oEbFcDZ1s=;
        b=VXLxhGwmdRMsdQ5YLXj/5mWi/XBO22/+EIiJ/GDTKvAHpnW5+rDn3S7rak9Ils/OnODCT7
        jXlFRJkKJ+2aBYPMtyXUyeJWSS6nR/iPtWpObpFGB3cTp2uqIGSV7B04fMVhRwEZarZBJp
        rrYFw9MO9cS+ULOxXaa02BNTokD45Cs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-fTb0YieTMtCcuiRcoYXFtg-1; Tue, 28 Mar 2023 03:33:18 -0400
X-MC-Unique: fTb0YieTMtCcuiRcoYXFtg-1
Received: by mail-wm1-f72.google.com with SMTP id m5-20020a05600c4f4500b003ee8db23ef9so6681857wmq.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679988796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RKROZr4GzDPgqMOFWqSLDrRs2RHwcu0c+oEbFcDZ1s=;
        b=wT2l+sRbKDw9MF3yy1xz8UAZMj8vKXO6o7Bv+rSvJajMpv1Unj5Ty5+r47kcAeOCzh
         uUlzMIvGx4UkNqUelZuMVmJY8KwrDv2d9j8U6f+7v91vE7nEjBX5nqrl0kCL1JB++fxe
         yJDr7iphzzOfYOo00tDuc6yR5LsRsoN77VfxmAeE7OBcNCjlTXoAauWfpEgCscIN+i+e
         mjdGCtDXMNmFRfNe15nIBJljyN732EGQw2reukeu7sReDYoO7s64/tY7QzhJClOE2JN6
         XITDxllrmDiitcftjTwYZfe9seOghW5nkANpwysC/hQOHQ2cYr5fp0dGJUaLmfw/crDR
         c5zA==
X-Gm-Message-State: AO0yUKUmw6Kn9Q89crgh59VmX036Bwv7k6R1BkvFlT6zNG6W8LQ2Ow7V
        IF9uzbRMUjdQvGP3Bc0gfJrPGKVc5s0T0yO6UnKQ26wEFhSMNgDbDdLmb0pwyYpwEhlgpwgBTwB
        OyZs7BoDc52uJQYAphiiDL5KPIbg4oWf7/vUJJT9pH+nI9CdKDC+hVaHfIRI1ztT23MIlSO8LDL
        Fdqwvwf6M=
X-Received: by 2002:a05:600c:287:b0:3ed:cc22:23db with SMTP id 7-20020a05600c028700b003edcc2223dbmr11833342wmk.3.1679988796701;
        Tue, 28 Mar 2023 00:33:16 -0700 (PDT)
X-Google-Smtp-Source: AK7set+E7Hunz2KKt4RZvQ903yvOLNFadeK9bEOzN8DCEVH3HEHCePFn8XpKOb8OMCb77RgGdWB2qw==
X-Received: by 2002:a05:600c:287:b0:3ed:cc22:23db with SMTP id 7-20020a05600c028700b003edcc2223dbmr11833309wmk.3.1679988796327;
        Tue, 28 Mar 2023 00:33:16 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b003ef6bc71cccsm7527075wmq.27.2023.03.28.00.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 00:33:16 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Tom <tom@tom-fitzhenry.me.uk>,
        Robert Mader <robert.mader@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Martijn Braam <martijn@brixit.nl>, Ondrej Jirman <megi@xff.cz>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 1/2] arm64: dts: rk3399-pinephone-pro: Add internal display support
Date:   Tue, 28 Mar 2023 09:33:08 +0200
Message-Id: <20230328073309.1743112-2-javierm@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230328073309.1743112-1-javierm@redhat.com>
References: <20230328073309.1743112-1-javierm@redhat.com>
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

From: Martijn Braam <martijn@brixit.nl>

The phone's display is using a Hannstar LCD panel. Support it by adding a
panel DT node and all needed nodes (backlight, MIPI DSI, regulators, etc).

Signed-off-by: Martijn Braam <martijn@brixit.nl>
Co-developed-by: Kamil Trzciński <ayufan@ayufan.eu>
Signed-off-by: Kamil Trzciński <ayufan@ayufan.eu>
Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Ondrej Jirman <megi@xff.cz>
---

Changes in v3:
- Fix some ./scripts/checkpatch.pl --strict warnings.
- Add Ondrej Jirman Tested-by tag.
- Change PWM period to 50000 since 20 kHz is recommended (Ondrej Jirman).
- Remove useless comments for the panel regulators (Ondrej Jirman).
- Drop unneeded pinctrl pull down conf for pins that either already have
  a pull-down resistor or are already driven by the SoC (Ondrej Jirman).
- Remove "pwm-delay-us" property not supported in mainline (Ondrej Jirman).

Changes in v2:
- Drop touchscreen node because used the wrong compatible (Ondrej Jirman).
- Fix assigned-clock-parents in vopb node (Ondrej Jirman).
- Add vopl and vopl nodes.

 .../dts/rockchip/rk3399-pinephone-pro.dts     | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index a0795a2b1cb1..539b36e8bff5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -29,6 +29,11 @@ chosen {
 		stdout-path = "serial2:115200n8";
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm0 0 50000 0>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -102,6 +107,30 @@ wifi_pwrseq: sdio-wifi-pwrseq {
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
+	};
 };
 
 &cpu_alert0 {
@@ -139,6 +168,11 @@ &emmc_phy {
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
@@ -362,6 +396,39 @@ &io_domains {
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
+		vcc-supply = <&vcc2v8_lcd>;
+		iovcc-supply = <&vcc1v8_lcd>;
+		pinctrl-names = "default";
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
@@ -429,6 +496,10 @@ &sdio0 {
 	status = "okay";
 };
 
+&pwm0 {
+	status = "okay";
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -479,3 +550,27 @@ bluetooth {
 &uart2 {
 	status = "okay";
 };
+
+&vopb {
+	status = "okay";
+	assigned-clocks = <&cru DCLK_VOP0_DIV>, <&cru DCLK_VOP0>,
+			  <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
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
+	assigned-clocks = <&cru DCLK_VOP1_DIV>, <&cru DCLK_VOP1>,
+			  <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
+	assigned-clock-rates = <0>, <0>, <400000000>, <100000000>;
+	assigned-clock-parents = <&cru PLL_GPLL>, <&cru DCLK_VOP1_DIV>;
+};
+
+&vopl_mmu {
+	status = "okay";
+};
-- 
2.40.0

