Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9819766A0F6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjAMRpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjAMRoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:44:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6909487F26
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:32:22 -0800 (PST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <bst@pengutronix.de>)
        id 1pGNub-0002gm-DC; Fri, 13 Jan 2023 18:32:17 +0100
From:   Bastian Krause <bst@pengutronix.de>
Date:   Fri, 13 Jan 2023 18:32:10 +0100
Subject: [PATCH 2/2] ARM: dts: imx6qdl: support child mfd cells for the reset
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-syscon-child-mfd-v1-2-0dd31b7de373@pengutronix.de>
References: <20230113-syscon-child-mfd-v1-0-0dd31b7de373@pengutronix.de>
In-Reply-To: <20230113-syscon-child-mfd-v1-0-0dd31b7de373@pengutronix.de>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Bastian Krause <bst@pengutronix.de>
X-Mailer: b4 0.11.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: bst@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual syscon-reboot-mode child node can be added by a board
device-tree or fixed up by the bootloader. For the child node to be
probed, the compatible needs to include simple-mfd. The binding now
specifies this, so have the SoC dtsi adhere to it.

Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Bastian Krause <bst@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ff1e0173b39be..b16be39458aa6 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -865,7 +865,8 @@ epit2: epit@20d4000 { /* EPIT2 */
 			};
 
 			src: reset-controller@20d8000 {
-				compatible = "fsl,imx6q-src", "fsl,imx51-src";
+				compatible = "fsl,imx6q-src", "fsl,imx51-src",
+					     "syscon", "simple-mfd";
 				reg = <0x020d8000 0x4000>;
 				interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 96 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.30.2
