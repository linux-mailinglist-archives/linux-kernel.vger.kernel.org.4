Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340CE6B07C8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjCHNCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjCHNAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:00:39 -0500
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABCCC489D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:00:00 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWsgF5GVGzMrFx3;
        Wed,  8 Mar 2023 13:53:13 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWsgF1gfyzMsl0y;
        Wed,  8 Mar 2023 13:53:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678279993;
        bh=5RB53IT0WY1PvkcckhRtNGskmrWIYH6BxeJz78MvpDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hjc6hENRWR9con21FyxWDlA3DAFSikakaL9TcSg4k6INL96TQr/YIgdfDtqVTI4RI
         L0hut5cKLmf6m6r24JCEsvIBAUReAdBek2b7wq24c0O0M3M3gum6RPcLAkJv7IVG/g
         22dzI1EvIl6M58Gs9TOgb2VJJFitnYaTVUcdr5d0=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 12/25] arm64: dts: colibri-imx8x: Add SPI
Date:   Wed,  8 Mar 2023 13:52:46 +0100
Message-Id: <20230308125300.58244-13-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308125300.58244-1-dev@pschenker.ch>
References: <20230308125300.58244-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add Colibri SPI to the board. lpspi2 is being exposed on the SoM edge.
Add settings to the module-level but finally enable it on the eval-board
dtsi.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi | 5 +++++
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi         | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
index 870375301243..77222d76bd95 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
@@ -41,6 +41,11 @@ rtc_i2c: rtc@68 {
 	};
 };
 
+/* Colibri SPI */
+&lpspi2 {
+	status = "okay";
+};
+
 /* Colibri UART_B */
 &lpuart0 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 31c771c1b788..cfa2c569e01c 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -91,6 +91,13 @@ &lpuart3 {
 	pinctrl-0 = <&pinctrl_lpuart3>, <&pinctrl_lpuart3_ctrl>;
 };
 
+/* Colibri SPI */
+&lpspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi2>;
+	cs-gpios = <&lsio_gpio1 0 GPIO_ACTIVE_LOW>;
+};
+
 /* On-module eMMC */
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-- 
2.39.2

