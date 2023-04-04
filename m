Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6053C6D67CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbjDDPpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbjDDPoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:44:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255C51982;
        Tue,  4 Apr 2023 08:44:41 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-190-097.ewe-ip-backbone.de [91.248.190.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C274B660316D;
        Tue,  4 Apr 2023 16:44:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680623079;
        bh=mn9mvLqb9JfD/v2GbIwIPsZvL+PY+ToYp17NbyJwa6Q=;
        h=From:To:Cc:Subject:Date:From;
        b=lbnmZukKs0voBA2Q6TmJGE9i4FaDZ+rTZ1ouyCAtNtMsDj5dbLP/Pu46k5QbUyerc
         DbxIq42KxDPoEqEJqGysbE7dcPRa3Hb9vBu3gDsEDpX95TmWNrd45e2fySOuE4qak+
         4mcj0uDVW77QrkBXCaLEEuM85QMs7gvpYD1KvSLdDBlaJzsbke1M+FLwxOtxC1uVhr
         aVYU99IcxD5VtwW3g0rHFtZd+4dgqUitBnqw+aeFC5cAXfMP9aQiIJdNaCm8dzYgyU
         Xqc7aVJe8hqRHp7NE8yHHK0mpuhYdu8QXyd1u8o/21LOm2tfP00NiVHmMF3VQOfVaO
         ALTXflyczEb8Q==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 8386E4807E1; Tue,  4 Apr 2023 17:44:37 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv1 1/1] arm64: dts: rockchip: rk3588: add thermal sensor
Date:   Tue,  4 Apr 2023 17:44:29 +0200
Message-Id: <20230404154429.51601-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal sensor IP, which allows monitoring temperatures at
seven different places in the SoC:

* Chip Center
* CPU Cluster 1 (Dual A76 "Big" Cores)
* CPU Cluster 2 (Dual A76 "Big" Cores)
* CPU Cluster 0 (Quad A55 "Little" Cores)
* Power Domain Center
* Graphics Processing Unit
* Neural Processing Unit

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
The driver + dt-binding part has been merged by Daniel Lezcano,
so let's add the DT node.
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 7840767dfcd8..c51f766cbd2e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1589,6 +1589,26 @@ pwm15: pwm@febf0030 {
 		status = "disabled";
 	};
 
+	tsadc: tsadc@fec00000 {
+		compatible = "rockchip,rk3588-tsadc";
+		reg = <0x0 0xfec00000 0x0 0x400>;
+		interrupts = <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru CLK_TSADC>, <&cru PCLK_TSADC>;
+		clock-names = "tsadc", "apb_pclk";
+		assigned-clocks = <&cru CLK_TSADC>;
+		assigned-clock-rates = <2000000>;
+		resets = <&cru SRST_P_TSADC>, <&cru SRST_TSADC>;
+		reset-names = "tsadc-apb", "tsadc";
+		rockchip,hw-tshut-temp = <120000>;
+		rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
+		rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
+		pinctrl-0 = <&tsadc_gpio_func>;
+		pinctrl-1 = <&tsadc_shut>;
+		pinctrl-names = "gpio", "otpout";
+		#thermal-sensor-cells = <1>;
+		status = "disabled";
+	};
+
 	i2c6: i2c@fec80000 {
 		compatible = "rockchip,rk3588-i2c", "rockchip,rk3399-i2c";
 		reg = <0x0 0xfec80000 0x0 0x1000>;
-- 
2.39.2

