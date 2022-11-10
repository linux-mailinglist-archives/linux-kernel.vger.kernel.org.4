Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33BB624733
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiKJQjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiKJQjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:39:06 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B1441991;
        Thu, 10 Nov 2022 08:39:04 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id t1so1483963wmi.4;
        Thu, 10 Nov 2022 08:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryja4COVOHIl0RDlGLdndcpFHG6CZ7IIZjln1Zob1wI=;
        b=BLZJOyoXuVI6cjgESTBwZFBVdWRXXaAWplg4Uh7VZQmXzWYbQBFckHCrSZ3RmUy31o
         5jdnQXtx4Z+HQAkEDm9JjGPPYUzagENkau4N777uZ2KuiveVjW5uJE+Pb9iYXFZHGBq1
         i8d02fZLyXqNaZv/5nK+JdU44LIMdnyB+hl0qTXj3P9IA3ArA4WM83T0HomhR5dOUbyD
         7Elq+j35UU32D7xs9cnubywoMW5UeLJST5ehdeY7twIFnvN369n3RLnfBLBLuYRKPalJ
         swLXeDv/Ka0b5fd668hPSP0+HYtOVyTAuYrFZTxXhwPuzcqB3qswKkRyzLbP+gXkFWJj
         YcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryja4COVOHIl0RDlGLdndcpFHG6CZ7IIZjln1Zob1wI=;
        b=pSFGysGjD0ylBpr2M/LXX2HJxZwTzlJoiROzHRdW/CabQXRMfu+06x1asSp9CuOfwJ
         8X3Q+LEijOdQOHfTU0xDd91w0VURScODGT6JERtzlTrpBXiTgLUibk6/VP4kwyQSvNTJ
         +GjwadODHMJal0Dwl5hCJPJb4lVkGpI3DE9XlAdgTmqnVM3xL3AGVvqYGNCfhu8U4t4k
         uH9QHOew2eIUhsFxDz0RpaRq7b2hVJSFWamkknDoTxPyc2IR/MFwQb/YkboY3jjzxgmc
         a3j7Ju6xG3ik4x1g/E7dEbtX3q2ZSjWCMOfzLsIBsJTajhu2oPeQMQa7wzBDLkYQUHvO
         eBCw==
X-Gm-Message-State: ACrzQf3O2luCV/pLk+RSqQjWDlHEtbgF7FF2AEyttHHgqmo41sHoi87K
        rMa9mvuv2y79J+HOvyXLff4=
X-Google-Smtp-Source: AMsMyM6jsF26ePp2sOngoBUlnVedO++lHRQA6eU6Uvp3knVI1RzhtwfviyZ1qK18HnEEy6ZWkeNGQA==
X-Received: by 2002:a05:600c:2044:b0:3cf:570f:db5e with SMTP id p4-20020a05600c204400b003cf570fdb5emr49885420wmg.57.1668098343445;
        Thu, 10 Nov 2022 08:39:03 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id f24-20020a1cc918000000b003b4935f04a4sm128730wmb.5.2022.11.10.08.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:39:03 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: rockchip: Enable video output and HDMI on SOQuartz
Date:   Thu, 10 Nov 2022 17:38:43 +0100
Message-Id: <20221110163845.42309-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110163845.42309-1-frattaroli.nicolas@gmail.com>
References: <20221110163845.42309-1-frattaroli.nicolas@gmail.com>
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

