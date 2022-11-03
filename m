Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5255618C8C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiKCXHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKCXHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:07:11 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F9301B9F8;
        Thu,  3 Nov 2022 16:07:05 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.96,135,1665414000"; 
   d="scan'208";a="138901822"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Nov 2022 08:07:05 +0900
Received: from mulinux.home (unknown [10.226.92.174])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id DA382400B9CF;
        Fri,  4 Nov 2022 08:07:00 +0900 (JST)
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
Subject: [PATCH 1/3] arm64: dts: renesas: r9a09g011: Fix unit address format error
Date:   Thu,  3 Nov 2022 23:06:46 +0000
Message-Id: <20221103230648.53748-2-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103230648.53748-1-fabrizio.castro.jz@renesas.com>
References: <20221103230648.53748-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the HW User Manual for RZ/V2M states in the "Address Map"
section that the interrupt controller is assigned addresses starting
from 0x82000000, the memory locations from 0x82000000 0x0x8200FFFF
are marked as reserved in the "Interrupt Controller (GIC)" section
and are currently not used by the device tree, leading to the below
warning:

arch/arm64/boot/dts/renesas/r9a09g011.dtsi:51.38-63.5: Warning
(simple_bus_reg): /soc/interrupt-controller@82000000: simple-bus unit
address format error, expected "82010000"

Fix the unit address accordingly.

Fixes: fb1929b98f2e ("arm64: dts: renesas: Add initial DTSI for RZ/V2M SoC")
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index 9859c717bd10..1948d2e6bcae 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -48,7 +48,7 @@ soc: soc {
 		#size-cells = <2>;
 		ranges;
 
-		gic: interrupt-controller@82000000 {
+		gic: interrupt-controller@82010000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
 			#address-cells = <0>;
-- 
2.34.1

