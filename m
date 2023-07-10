Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4F674DB93
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjGJQwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjGJQwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:52:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820D0120;
        Mon, 10 Jul 2023 09:52:32 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-246.ewe-ip-backbone.de [91.248.189.246])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 37F3B6607007;
        Mon, 10 Jul 2023 17:52:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689007950;
        bh=nz6AzM1vVIWarNK31rOaCRC6uCmfJnBWhfD7X/Ejsi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=do0Fu59LJ1U8ZzCz9kJuuQV8REOb2zpF9Abxu7mP88d9i9UN4sGGndCIh6imj8OM6
         1QqokxYlJHXC4w6cRCCsKvSKlVBf1T1Qza9hbcTU2SJ252a5nYcy8GlI3Fd9lXaE5f
         sA+kNZiGJ+uFh2HiGvNzGR4mmYAitd5C2OmtpC2IjenvKAW81ePNr1mSRKsAJ2bcU6
         y6wppcAr4tX5f8/84UwqCwIl51nBjHoteNUn2mryMAEWkKUArtv/zmmuwxUipd2eTH
         L7jPRGUsrbA+Q8s9TBFjYC9F2CvO5Rp/9oyUZOMVBj8vi4Zxij50COgVuyv0SXSEN+
         Bch/In6BEL7gg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 1F3854805A0; Mon, 10 Jul 2023 18:52:28 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 04/13] arm64: dts: rockchip: rock-5a: add vdd_cpu_big regulators
Date:   Mon, 10 Jul 2023 18:52:19 +0200
Message-Id: <20230710165228.105983-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710165228.105983-1-sebastian.reichel@collabora.com>
References: <20230710165228.105983-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK8602 and RK8603 voltage regulators on the Rock 5A board provide
the power lines vdd_cpu_big0 and vdd_cpu_big1, respectively.

Add the necessary device tree nodes and bind them to the corresponding
CPU big core nodes.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 9b5c47b78eea..616a6bcfd60b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -49,6 +49,22 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3 {
 	};
 };
 
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu_big0_s0>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu_big0_s0>;
+};
+
+&cpu_b2 {
+	cpu-supply = <&vdd_cpu_big1_s0>;
+};
+
+&cpu_b3 {
+	cpu-supply = <&vdd_cpu_big1_s0>;
+};
+
 &cpu_l0 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
@@ -65,6 +81,46 @@ &cpu_l3 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0m2_xfer>;
+	status = "okay";
+
+	vdd_cpu_big0_s0: regulator@42 {
+		compatible = "rockchip,rk8602";
+		reg = <0x42>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu_big0_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <1050000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vdd_cpu_big1_s0: regulator@43 {
+		compatible = "rockchip,rk8603", "rockchip,rk8602";
+		reg = <0x43>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu_big1_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <1050000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
 &gmac1 {
 	clock_in_out = "output";
 	phy-handle = <&rgmii_phy1>;
-- 
2.40.1

