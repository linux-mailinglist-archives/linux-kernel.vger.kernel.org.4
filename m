Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEED6C97DC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 22:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCZUpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 16:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCZUpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 16:45:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4CD5FEE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:45:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id er18so16724276edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679863522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zKeqvPxm46B8O4W9qzQW2dMP+9bNVOZP8XOxlGMFt78=;
        b=e/6HJAScT4RiWqlfn8XQ3KWA+0e55h9JsVVPIYhIF6NSHAAYuUJuqqAqIgZaBJjKIY
         jDcWTFbI34Cq08FT/AW+ngu6EivgEN5dU2Zr2Pj00tDLi5qNQlNFmJYFTR/SB3WHvjqT
         O0kikH5paSq8UX1KK8TnNwD4bOVmyszHMO/kPW9e15vCg/ct/UHRDKw/NIT2Z8i9IQg6
         NmM9FDONp2kW8xo01KPwUWxShJDzHdjErq0HYWq2OdGQ+pwDNIH8GrT4r0uNHuIb0vIm
         2pAcpzz85qCnHTIJAOn+0pdH3N2QWYfB/29FpoL4sXi2MM7+oiJ4kOMb275bwd6axEnm
         Urlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679863522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKeqvPxm46B8O4W9qzQW2dMP+9bNVOZP8XOxlGMFt78=;
        b=yZEXxVOwG/28ZONp2x68jWdYDYEXPU1CuYoe0Ir2LiRXBxA8CPY0xEmJgLm920hWAb
         Re9PS3/P8Dqq9qKQnqQjCUNEiBIEH2KrXDOL+8AAVCJ7BoM3AuibwaYDrsJLwivdd+gp
         7CuzFgmZThN6RjAGW38d3pTrPC8O3c5ClpDaZip9DAgA0j90uf8UXvb/g/aES+KByvfc
         axUvPjgYwq2+SwXzfiTsmJ+OXO9bmQ4fIjjAfL5bJgM2Kv+vBaIgFTWPU9Rq9GSZsu6C
         vFB+b8n9pu6FGqmHGAFmaVcIErUfsXexIqUa5nsdFVxU48tHJS7RSh5HDpEMKqVqmjuL
         uVzg==
X-Gm-Message-State: AAQBX9eMuwhU6S6xkrnTnc4Nnj03yyzq+Lhy897DNNw3rZ18GRC4wAvG
        guhBVliHQuYRLvD7QdhLX4ns1w==
X-Google-Smtp-Source: AKy350YvH7Ps1wazgDh82qJwbf2I7lTAQe/OGi0P5E2EuabFszjUkUyN/w0BWr357mArwQ7wiKJ2Aw==
X-Received: by 2002:a17:907:724d:b0:93f:3027:ee5f with SMTP id ds13-20020a170907724d00b0093f3027ee5fmr7636908ejc.70.1679863522281;
        Sun, 26 Mar 2023 13:45:22 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6b51:4748:3f3f:ffcf])
        by smtp.gmail.com with ESMTPSA id ga5-20020a170906b84500b0093e23d03d72sm4090982ejb.177.2023.03.26.13.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 13:45:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] arm64: dts: rockchip: correct panel supplies
Date:   Sun, 26 Mar 2023 22:45:18 +0200
Message-Id: <20230326204520.80859-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Anbernic and Odroid Go have different panels and take differently
named supplies, so move all the supplies to DTS defining actual panel to
fix warnings like:

  rk3326-odroid-go3.dtb: panel@0: 'IOVCC-supply' is a required property
  rk3326-odroid-go3.dtb: panel@0: 'iovcc-supply', 'vdd-supply' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts | 2 ++
 arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi      | 2 --
 arch/arm64/boot/dts/rockchip/rk3326-odroid-go2-v11.dts  | 2 ++
 arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts      | 2 ++
 arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts      | 1 +
 5 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts b/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts
index 61b31688b469..ce318e05f0a6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts
@@ -24,6 +24,8 @@ vibrator {
 
 &internal_display {
 	compatible = "elida,kd35t133";
+	iovcc-supply = <&vcc_lcd>;
+	vdd-supply = <&vcc_lcd>;
 };
 
 &pwm0 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi
index 04eba432fb0e..80fc53c807a4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi
@@ -235,10 +235,8 @@ mipi_out_panel: endpoint {
 	internal_display: panel@0 {
 		reg = <0>;
 		backlight = <&backlight>;
-		iovcc-supply = <&vcc_lcd>;
 		reset-gpios = <&gpio3 RK_PC0 GPIO_ACTIVE_LOW>;
 		rotation = <270>;
-		vdd-supply = <&vcc_lcd>;
 
 		port {
 			mipi_in_panel: endpoint {
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2-v11.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2-v11.dts
index 139c898e590e..d94ac81eb4e6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2-v11.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2-v11.dts
@@ -83,6 +83,8 @@ button-sw21 {
 
 &internal_display {
 	compatible = "elida,kd35t133";
+	iovcc-supply = <&vcc_lcd>;
+	vdd-supply = <&vcc_lcd>;
 };
 
 &rk817 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index 4702183b673c..aa6f5b12206b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -59,6 +59,8 @@ battery: battery {
 
 &internal_display {
 	compatible = "elida,kd35t133";
+	iovcc-supply = <&vcc_lcd>;
+	vdd-supply = <&vcc_lcd>;
 };
 
 &rk817_charger {
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts
index 1b9769ccfdeb..35bbaf559ca3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts
@@ -144,6 +144,7 @@ button-sw22 {
 &internal_display {
 	compatible = "elida,kd50t048a", "sitronix,st7701";
 	reset-gpios = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
+	IOVCC-supply = <&vcc_lcd>;
 	VCC-supply = <&vcc_lcd>;
 };
 
-- 
2.34.1

