Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E29C61FA85
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiKGQv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiKGQvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:51:08 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C4EF24089;
        Mon,  7 Nov 2022 08:50:50 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,145,1665414000"; 
   d="scan'208";a="141793956"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Nov 2022 01:50:50 +0900
Received: from mulinux.home (unknown [10.226.92.51])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id BA14640078CD;
        Tue,  8 Nov 2022 01:50:45 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v2 2/2] arm64: dts: renesas: r9a09g011: Fix I2C SoC specific strings
Date:   Mon,  7 Nov 2022 16:50:27 +0000
Message-Id: <20221107165027.54150-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107165027.54150-1-fabrizio.castro.jz@renesas.com>
References: <20221107165027.54150-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preferred form for Renesas' compatible strings is:
"<vendor>,<family>-<module>"

Somehow the compatible string for the r9a09g011 I2C IP was upstreamed
as renesas,i2c-r9a09g011 instead of renesas,r9a09g011-i2c, which
is really confusing, especially considering the generic fallback
is renesas,rzv2m-i2c.

The first user of renesas,i2c-r9a09g011 in the kernel is not yet in
a kernel release, it will be in v6.1, therefore it can still be
fixed in v6.1.
Even if we don't fix it before v6.2, I don't think there is any
harm in making such a change.

s/renesas,i2c-r9a09g011/renesas,r9a09g011-i2c/g for consistency.

Fixes: 54ac6794df9d ("arm64: dts: renesas: r9a09g011: Add i2c nodes")
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---

v2 - Improved changelog, as suggested by Geert and Krzysztof

 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index 1948d2e6bcae..2ccd48ee9880 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -126,7 +126,7 @@ cpg: clock-controller@a3500000 {
 		i2c0: i2c@a4030000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "renesas,i2c-r9a09g011", "renesas,rzv2m-i2c";
+			compatible = "renesas,r9a09g011-i2c", "renesas,rzv2m-i2c";
 			reg = <0 0xa4030000 0 0x80>;
 			interrupts = <GIC_SPI 232 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 236 IRQ_TYPE_EDGE_RISING>;
@@ -140,7 +140,7 @@ i2c0: i2c@a4030000 {
 		i2c2: i2c@a4030100 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "renesas,i2c-r9a09g011", "renesas,rzv2m-i2c";
+			compatible = "renesas,r9a09g011-i2c", "renesas,rzv2m-i2c";
 			reg = <0 0xa4030100 0 0x80>;
 			interrupts = <GIC_SPI 234 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 238 IRQ_TYPE_EDGE_RISING>;
-- 
2.34.1

