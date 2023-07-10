Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E280374DB98
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjGJQwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjGJQwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:52:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B12EA;
        Mon, 10 Jul 2023 09:52:34 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-246.ewe-ip-backbone.de [91.248.189.246])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 77AF56607009;
        Mon, 10 Jul 2023 17:52:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689007952;
        bh=SyT5L6QW7HqAZecCA4MRYTD8aoZGBwujAo3dEnVZY78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQgqj1Q//kViqIzttfWnfi8UGG9Ap0+dTd6xwfUQHpnBaBfnkOSWSxiW3ibv4qJNh
         B1WKY1qWNlnxnH/JELYsFpEy2HVJHhSB3mYIuj8Fw0EPpiVD4o1NiedBTDTl4tVo5O
         yL/ofWvms2IAJRCxVnYK/ioKVcwSPrwXYLXQsNevxIDOryWBj6TmDCejSrfHPXxglO
         IvdIuyVyxmxkfOCVMqGOezk9ovTytdjc7EIThi/liFwqRpVckmmt56wka6Dof92eax
         U6qonkSGjyidbNhc0vYxk6EG1VLyKlBzuhuYNl6QDgAnCSqM7im5zQLoA9L0+bPUiT
         9/0A1B3aN0N7g==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 212534805B8; Mon, 10 Jul 2023 18:52:28 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 05/13] arm64: dts: rockchip: rock-5a: add 5V regulator
Date:   Mon, 10 Jul 2023 18:52:20 +0200
Message-Id: <20230710165228.105983-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710165228.105983-1-sebastian.reichel@collabora.com>
References: <20230710165228.105983-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPIO controlled 5V regulator, which is used for supplying
the fan, on-board USB hub and HDMI.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 616a6bcfd60b..87864a991b50 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -38,6 +38,20 @@ vcc5v0_sys: vcc5v0-sys {
 		vin-supply = <&vcc12v_dcin>;
 	};
 
+	vcc_5v0: vcc-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+		enable-active-high;
+		gpio = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc_5v0_en>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
 	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v1_nldo_s3";
@@ -150,6 +164,12 @@ rgmii_phy1: ethernet-phy@1 {
 };
 
 &pinctrl {
+	power {
+		vcc_5v0_en: vcc-5v0-en {
+			rockchip,pins = <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	rtl8211f {
 		rtl8211f_rst: rtl8211f-rst {
 			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.40.1

