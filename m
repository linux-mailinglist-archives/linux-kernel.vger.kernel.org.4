Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090AF63A365
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiK1IsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiK1Irz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:47:55 -0500
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B89965EB;
        Mon, 28 Nov 2022 00:47:53 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 5F10D1D73; Mon, 28 Nov 2022 09:47:49 +0100 (CET)
From:   Nikolaus Voss <nikolaus.voss@haag-streit.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, nv@vosn.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Wed, 2 Nov 2022 15:27:19 +0100
Subject: [PATCH 2/2] imx6qdl.dtsi: use MAC-address from nvmem
Message-Id: <20221128084749.5F10D1D73@mail.steuer-voss.de>
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMX6QDL has fuse locations specified for storing the MAC for the
built-in ethernet (Table 5-8 in Reference Manual).
Define the fuse location in ocotp and refer to them in fec-ethernet.

If the cells are not flashed, the driver behavior is unchanged, i.e.
other MAC sources will be probed and a random MAC will be used as a
last resort.

Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 4f7fefc14d0ac..7449d554ef1aa 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1053,6 +1053,8 @@ fec: ethernet@2188000 {
 					 <&clks IMX6QDL_CLK_ENET_REF>;
 				clock-names = "ipg", "ahb", "ptp", "enet_out";
 				fsl,stop-mode = <&gpr 0x34 27>;
+				nvmem-cells = <&fec_mac_addr>;
+				nvmem-cell-names = "mac-address";
 				status = "disabled";
 			};
 
@@ -1186,6 +1188,10 @@ tempmon_calib: calib@38 {
 				tempmon_temp_grade: temp-grade@20 {
 					reg = <0x20 4>;
 				};
+
+				fec_mac_addr: mac-addr@88 {
+					reg = <0x88 6>;
+				};
 			};
 
 			tzasc@21d0000 { /* TZASC1 */
-- 
2.34.1

