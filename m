Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590956562EF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 14:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLZNv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 08:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiLZNuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 08:50:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B870271B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 05:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672062569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gw4YKyE6m3dvm+AI9a6ZkGYjDJAM63OXGslSUuAlLo8=;
        b=U8wRbb1XCOV2x17MxYeUvJ46Q+VYOBpkrNKt1jOHEmfXIs4rl31yLfYGXV/lFGozkTwwPL
        gqNawRh5aLKiHggFTG3O9DjUP6oOBl7N+aVFM4zJCt4w6TdxcfXIBRG6HFWmUyrWkyLC5a
        zhK84Z/o8SGxgJzuNHHvNPxa9lr5J3o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-B0sCD1xoMaqWY9RIyEoShQ-1; Mon, 26 Dec 2022 08:49:28 -0500
X-MC-Unique: B0sCD1xoMaqWY9RIyEoShQ-1
Received: by mail-wm1-f70.google.com with SMTP id b47-20020a05600c4aaf00b003d031aeb1b6so8095435wmp.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 05:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gw4YKyE6m3dvm+AI9a6ZkGYjDJAM63OXGslSUuAlLo8=;
        b=p6ez+LNrH/cUpBZN9BP0t7eCUMDFBRIHbwdj7YQOvMYWJEtjDidq081tSoCosWy9Zv
         99aEZ+dlllJXjL0mNiNQqs00/zJ3bIGcl+xpiEl5R5ExZFap7GlCm1AI/SPn/czh2UzF
         1Rt/9+RnVDpY4QwsG6zZWUDSTUF0cfjkgb8U2LmOYEbkrVh54SIhA/WxTQ1jhOimLvhX
         9h32KAfb8MBCbEt63fBrxep5olsm87TPp9SvJd/0XL4tXpmMXpvyKDifCjBX8PhYAdIv
         ig/skxiPrcCjXvklI3/Gc+lnGb7A1H9JAnpG5vnE4siVDnujxMtMLq7y8LgZBSkTp2zo
         ko1A==
X-Gm-Message-State: AFqh2krWf1TrlUg6htB3ifv9i/XYOtlh5SAPsWRmogBvuTS6LxRVJcr5
        nukK/lxBqqKaVoZp4GjId9p6lB6iHKz1PpWo8c+RwTIgD9gvN0skZnbfWEL+inKdooFtX5KVLx/
        G4qouQIc6PMQy7tObjz3dWq7s+D3aHONOwexbR6UDB7RMIxhmqB1rVssW22o/2AskdmCJqMiQ7t
        I=
X-Received: by 2002:a7b:c7d6:0:b0:3d1:ee3a:62ae with SMTP id z22-20020a7bc7d6000000b003d1ee3a62aemr15855545wmk.8.1672062567111;
        Mon, 26 Dec 2022 05:49:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsSXL0Ns8UFml4pgFquWr3xql1Chfes3jlMi8ynWpv2K9/OhcnWWzORV78VW6XaRzrrIKwXrg==
X-Received: by 2002:a7b:c7d6:0:b0:3d1:ee3a:62ae with SMTP id z22-20020a7bc7d6000000b003d1ee3a62aemr15855517wmk.8.1672062566819;
        Mon, 26 Dec 2022 05:49:26 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a18-20020adfed12000000b0027cfd9463d7sm3340947wro.110.2022.12.26.05.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 05:49:26 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ondrej Jirman <megi@xff.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Mader <robert.mader@posteo.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Peter Robinson <pbrobinson@gmail.com>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 4/4] arm64: dts: rk3399-pinephone-pro: Add internal display support
Date:   Mon, 26 Dec 2022 14:49:08 +0100
Message-Id: <20221226134909.2822179-5-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221226134909.2822179-1-javierm@redhat.com>
References: <20221226134909.2822179-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

The phone's display is using Hannstar LCD panel, and Goodix based
touchscreen. Support it.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Martijn Braam <martijn@brixit.nl>
Signed-off-by: Martijn Braam <martijn@brixit.nl>
Co-developed-by: Kamil Trzciński <ayufan@ayufan.eu>
Signed-off-by: Kamil Trzciński <ayufan@ayufan.eu>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Fix regulator node names (Maya Matuszczyk).
- Drop non-existent "poweroff-in-suspend" property (Maya Matuszczyk).
- Remove unnecessary comments in panel node (Maya Matuszczyk).

 .../dts/rockchip/rk3399-pinephone-pro.dts     | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 0e4442b59a55..55048236eef7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -29,6 +29,12 @@ chosen {
 		stdout-path = "serial2:1500000n8";
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
@@ -81,6 +87,32 @@ vcc1v8_codec: vcc1v8-codec-regulator {
 		regulator-max-microvolt = <1800000>;
 		vin-supply = <&vcc3v3_sys>;
 	};
+
+	/* MIPI DSI panel 1.8v supply */
+	vcc1v8_lcd: vcc1v8-lcd-regulator {
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
+	vcc2v8_lcd: vcc2v8-lcd-regulator {
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
 
 &cpu_l0 {
@@ -111,6 +143,11 @@ &emmc_phy {
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
@@ -193,6 +230,9 @@ vcc3v0_touch: LDO_REG2 {
 				regulator-name = "vcc3v0_touch";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			vcca1v8_codec: LDO_REG3 {
@@ -326,6 +366,25 @@ opp07 {
 	};
 };
 
+&i2c3 {
+	i2c-scl-rising-time-ns = <450>;
+	i2c-scl-falling-time-ns = <15>;
+	status = "okay";
+
+	touchscreen@14 {
+		compatible = "goodix,gt917s";
+		reg = <0x14>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <RK_PB5 IRQ_TYPE_EDGE_RISING>;
+		irq-gpios = <&gpio3 RK_PB5 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio3 RK_PB4 GPIO_ACTIVE_HIGH>;
+		AVDD28-supply = <&vcc3v0_touch>;
+		VDDIO-supply = <&vcc3v0_touch>;
+		touchscreen-size-x = <720>;
+		touchscreen-size-y = <1440>;
+	};
+};
+
 &io_domains {
 	bt656-supply = <&vcc1v8_dvp>;
 	audio-supply = <&vcca1v8_codec>;
@@ -334,6 +393,40 @@ &io_domains {
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
@@ -360,6 +453,20 @@ vsel2_pin: vsel2-pin {
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
 	sound {
 		vcc1v8_codec_en: vcc1v8-codec-en {
 			rockchip,pins = <3 RK_PA4 RK_FUNC_GPIO &pcfg_pull_down>;
@@ -367,6 +474,10 @@ vcc1v8_codec_en: vcc1v8-codec-en {
 	};
 };
 
+&pwm0 {
+	status = "okay";
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -396,3 +507,15 @@ &tsadc {
 &uart2 {
 	status = "okay";
 };
+
+&vopb {
+	status = "okay";
+	assigned-clocks = <&cru DCLK_VOP0_DIV>, <&cru DCLK_VOP0>,
+			  <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
+	assigned-clock-rates = <0>, <0>, <400000000>, <100000000>;
+	assigned-clock-parents = <&cru PLL_CPLL>, <&cru DCLK_VOP0_FRAC>;
+};
+
+&vopb_mmu {
+	status = "okay";
+};
-- 
2.38.1

