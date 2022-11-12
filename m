Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251C3626A6B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiKLQEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbiKLQEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:04:32 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC121409B;
        Sat, 12 Nov 2022 08:04:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so4942780wmg.2;
        Sat, 12 Nov 2022 08:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryja4COVOHIl0RDlGLdndcpFHG6CZ7IIZjln1Zob1wI=;
        b=W2+hFqYRrsHwvKIwFlXxU5UeP4Hn1PIXuemAtrwiCMuoPIps/J5IVBDmvBBC4QGkK4
         CJ4sb8OTYws5/48bkUAK0jT2+pQLyZFuTR72CQG/j4Byb9OmhHG2NpcmEBdFLbkixVOB
         2QpBaPlJfxIyTGFSpliQdcGPJLlXE4gSNJAvc3L9qQP2TFgg5ZAF3RG48z+iF4U9dTjD
         4eOa/JQ09vIXymtES2xkBSZW/FG/EZIXkXDp4a0E9QUeJmYOxODQSS3dIYVmevD4FMT6
         Tf8mOVHPnr7KkC8NaqFZ2XVn5CJIQWi12qxYvUC2/94qD750jO+OWr6GJgXw2n7i4ZnU
         GYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryja4COVOHIl0RDlGLdndcpFHG6CZ7IIZjln1Zob1wI=;
        b=mV/9NxnltUg5CXrrhiW6eoVdHiszzvdEcCEVXUst10NEEtuU3+++ScNgBIRXD+B44v
         L0bygiy/GwZFlSbDlHxAS38jWV5kZEAO8XBJwCkLgDjRg8hGQlAOLn3JOyTfO5pCuDCd
         fHQJuzqFGqUG59lI07NveJmW8BLTLsD10kFokW6U5U3H52/lp4Y2vv++fHWUB+kbTz7q
         0WIAWmSYPK22V9WT/zMMFOEcfzU/Eer9M6LeKgvcYm+n6OPsA3Mpc2Q/E1e6Ut1BGbs3
         H/O18fK6W2A6x9qFFEWNc+4+hIP9jMxNbxIHT8BRckn3YBPA2s0ObMCRYNrdPAiKgtlL
         3fBQ==
X-Gm-Message-State: ANoB5pn484sva+UZR66l2LzKyAB0QYpNE/yPocx13SPPf7Ila35Z4fnk
        Zh+3MtPJEIROyiTgI/rAqHc6VwcVyXE=
X-Google-Smtp-Source: AA0mqf7R3EjsE/f2MM3c5yicPRNoufA1vOUCZrRluhmusrV6myk9zahbFvRQoaRlG3nOijvjuvx5mA==
X-Received: by 2002:a7b:cd0e:0:b0:3cf:ca45:3b19 with SMTP id f14-20020a7bcd0e000000b003cfca453b19mr4057679wmj.179.1668269069370;
        Sat, 12 Nov 2022 08:04:29 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003cf87623c16sm14605752wmb.4.2022.11.12.08.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 08:04:28 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] arm64: dts: rockchip: Enable video output and HDMI on SOQuartz
Date:   Sat, 12 Nov 2022 17:03:59 +0100
Message-Id: <20221112160404.70868-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112160404.70868-1-frattaroli.nicolas@gmail.com>
References: <20221112160404.70868-1-frattaroli.nicolas@gmail.com>
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

This patch adds and enables the necessary device tree nodes to
enable video output and HDMI functionality on the SOQuartz module.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../boot/dts/rockchip/rk3566-soquartz.dtsi    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
index 6e99f049501c..0bfb0cea7d6b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3566.dtsi"
 
 / {
@@ -28,6 +29,17 @@ gmac1_clkin: external-gmac1-clock {
 		#clock-cells = <0>;
 	};
 
+	hdmi-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -148,6 +160,24 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi {
+	avdd-0v9-supply = <&vdda0v9_image>;
+	avdd-1v8-supply = <&vcca1v8_image>;
+	status = "okay";
+};
+
+&hdmi_in {
+	hdmi_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi>;
+	};
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -619,3 +649,20 @@ &usb2phy0_otg {
 &usb_host0_xhci {
 	status = "disabled";
 };
+
+&vop {
+	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
+	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi_in_vp0>;
+	};
+};
-- 
2.38.1

