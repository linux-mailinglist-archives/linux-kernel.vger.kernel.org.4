Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A4F5F45D5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJDOnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJDOnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:43:16 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3191D0C4;
        Tue,  4 Oct 2022 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1664894592; bh=99g94TiL+hFwBhUbQX5X4TMC3lCGyB73fo7yYhcTiA4=;
        h=From:To:Cc:Subject:Date:From;
        b=o/RSqcqX5mVidZgEXMSOC1i5y5uevvYOEdlYRTh36ZM0KKE34mbxp9N/fMLhZyFoP
         xSnnDkdHI7OPurUPgIxPwIQzdzVul6e5Hg4WEbJ39WGLuzWs3wLkrX8MoYtEefFZUm
         fbYdDuhpqxj3B1c44PBz3SQSxJe6KtR047UGuFfw=
From:   Ondrej Jirman <megi@xff.cz>
To:     linux-rockchip@lists.infradead.org
Cc:     Ondrej Jirman <megi@xff.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: rockchip: rk356x: Fix PCIe register map and ranges
Date:   Tue,  4 Oct 2022 16:43:03 +0200
Message-Id: <20221004144304.536023-1-megi@xff.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have two Realtek PCIe wifi cards connected over the 4 port
PCIe bridge to Quartz64-A. The cards fail to work, when nvme
SSD is connected at the same time to the bridge. Without nvme
connected, cards work fine. The issue seems to be related
to mixed use of devices which make use of I/O ranges and memory
ranges.

This mapping is designed to be more straightforward, inspired by
dt-bindings docs for sample pcie3x2 node:

      reg = <0x3 0xc0800000 0x0 0x390000>,
            <0x0 0xfe280000 0x0 0x10000>,
            <0x3 0x80000000 0x0 0x100000>;
      ranges = <0x81000000 0x0 0x80800000 0x3 0x80800000 0x0 0x100000>,
               <0x83000000 0x0 0x80900000 0x3 0x80900000 0x0 0x3f700000>;

I noticed that this is crafted so that there doesn't need to be
any translation other than dropping the high dword bits, and I
modified the ranges for pcie2x1 to follow the same principle.

This change to the regs/ranges makes the issue go away and both
nvme and wifi cards work when connected at the same time to the
bridge.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 319981c3e9f7..e88e8c4fe25b 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -855,7 +855,8 @@ pcie2x1: pcie@fe260000 {
 		compatible = "rockchip,rk3568-pcie";
 		reg = <0x3 0xc0000000 0x0 0x00400000>,
 		      <0x0 0xfe260000 0x0 0x00010000>,
-		      <0x3 0x3f000000 0x0 0x01000000>;
+		      <0x3 0x00000000 0x0 0x01000000>;
+
 		reg-names = "dbi", "apb", "config";
 		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
@@ -884,8 +885,8 @@ pcie2x1: pcie@fe260000 {
 		phys = <&combphy2 PHY_TYPE_PCIE>;
 		phy-names = "pcie-phy";
 		power-domains = <&power RK3568_PD_PIPE>;
-		ranges = <0x01000000 0x0 0x3ef00000 0x3 0x3ef00000 0x0 0x00100000
-			  0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x3ef00000>;
+		ranges =  <0x01000000 0x0 0x01000000 0x3 0x01000000 0x0 0x00100000
+			   0x02000000 0x0 0x02000000 0x3 0x02000000 0x0 0x3e000000>;
 		resets = <&cru SRST_PCIE20_POWERUP>;
 		reset-names = "pipe";
 		#address-cells = <3>;
-- 
2.37.3

