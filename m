Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0C46B8FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCNK1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjCNKZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:25:43 -0400
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AE5C14A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:25:16 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PbV4t0pXgzMqQG6;
        Tue, 14 Mar 2023 11:24:30 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PbV4s4JQPz2MRm;
        Tue, 14 Mar 2023 11:24:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678789470;
        bh=aeN02gbGVsJ9TQ+Q8lY6g/jfYyUsHYo+ngOj0QJxr6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rAqVQT59CsBGWcaDzKj+1suRX8CI4GXvVYqjBeCXs/ARGNCZVgG9LvRGOVn/gCuUw
         vZ2ViIi8mcHPbme7d9pxAGpYjy9MI1NG7QKluPpHXEobN7Akqd0l7nag883MtX3SA9
         ++z55K31OwCpGtXoVYwcJHY1J+oITUyW8ateGqDA=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/23] arm64: dts: colibri-imx8x: eval: Add spi-to-can
Date:   Tue, 14 Mar 2023 11:24:01 +0100
Message-Id: <20230314102410.424773-16-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314102410.424773-1-dev@pschenker.ch>
References: <20230314102410.424773-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add mcp2515 spi-to-can to &lpspi2.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v2:
- Change clock-16mhz-fixed to clock-16mhz
- Remove status="okay"

 .../dts/freescale/imx8x-colibri-eval-v3.dtsi   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
index 68e34516961a..14d479b50656 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
@@ -11,6 +11,13 @@ aliases {
 		rtc1 = &rtc;
 	};
 
+	/* fixed crystal dedicated to mcp25xx */
+	clk16m: clock-16mhz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <16000000>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -39,6 +46,17 @@ rtc_i2c: rtc@68 {
 /* Colibri SPI */
 &lpspi2 {
 	status = "okay";
+
+	mcp2515: can@0 {
+		compatible = "microchip,mcp2515";
+		reg = <0>;
+		interrupt-parent = <&lsio_gpio3>;
+		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-0 = <&pinctrl_can_int>;
+		pinctrl-names = "default";
+		clocks = <&clk16m>;
+		spi-max-frequency = <10000000>;
+	};
 };
 
 /* Colibri UART_B */
-- 
2.39.2

