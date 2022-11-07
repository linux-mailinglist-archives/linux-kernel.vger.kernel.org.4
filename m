Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A7D61F3E2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiKGNCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiKGNCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:02:07 -0500
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2EA1C425;
        Mon,  7 Nov 2022 05:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1667826120; bh=Z5HZQ0FJ5zop6RxxhYVUF6pwXoF1Wmv4094FaI/3RFs=;
        h=From:To:Cc:Subject:Date:From;
        b=n8Q020NDFCcVdsopFtB8ts4Gk0wCoh5ew+3NXPQL6DBMcHNBJz8cYvtO4pGdraY8x
         KRiHiA89QGcLSSNvckYb2RwEmDEa6NwaKMNvBHTOqiLptjOrwZRBiFrlP8itzXuzS8
         pmwwV2vKj5YyWNyzSKJZY9tklB8a2fXP6EVLwBLE=
From:   Ondrej Jirman <megi@xff.cz>
To:     linux-rockchip@lists.infradead.org
Cc:     Ondrej Jirman <megi@xff.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Chris Morgan <macromorgan@hotmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] arm64: dts: rockchip: rk356x: Fix PCIe register map and ranges
Date:   Mon,  7 Nov 2022 14:01:56 +0100
Message-Id: <20221107130157.1425882-1-megi@xff.cz>
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

I have two Realtek PCIe wifi cards connected over the 4 port PCIe bridge
to Quartz64-A. The cards fail to work, when nvme SSD is connected at the
same time to the bridge. Without nvme connected, cards work fine. The
issue seems to be related to mixed use of devices which make use of I/O
ranges and memory ranges.

This patch changes I/O, MEM and config mappings so that these use the
32bit outbound address space at  0xf4000000, and 64bit MEM range uses
the whole 0x3_0000_0000 outbound address range.

These values were suggested by pgwipeout:

  https://lore.kernel.org/lkml/875ygbsrf3.fsf@bloch.sibelius.xs4all.nl/T/#m84b5f6992cc26dffe0d3783c0d8c9c86e5e10c10

This is identical to how BSP does the mappings.

This change to the regs/ranges makes the issue go away and both nvme and
wifi cards work when connected at the same time to the bridge. I tested
the nvme with large amount of reads/writes, both behind the PCIe bridge
and when directly connected to Quartz64-A board.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
v3:
- changed ranges to the ones suggested by pgwipeout

 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 164708f1eb67..726c948ccbf0 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -951,7 +951,8 @@ pcie2x1: pcie@fe260000 {
 		compatible = "rockchip,rk3568-pcie";
 		reg = <0x3 0xc0000000 0x0 0x00400000>,
 		      <0x0 0xfe260000 0x0 0x00010000>,
-		      <0x3 0x3f000000 0x0 0x01000000>;
+		      <0x0 0xf4000000 0x0 0x00100000>;
+
 		reg-names = "dbi", "apb", "config";
 		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
@@ -973,15 +974,17 @@ pcie2x1: pcie@fe260000 {
 				<0 0 0 4 &pcie_intc 3>;
 		linux,pci-domain = <0>;
 		num-ib-windows = <6>;
-		num-ob-windows = <2>;
+		num-ob-windows = <8>;
 		max-link-speed = <2>;
 		msi-map = <0x0 &gic 0x0 0x1000>;
 		num-lanes = <1>;
 		phys = <&combphy2 PHY_TYPE_PCIE>;
 		phy-names = "pcie-phy";
 		power-domains = <&power RK3568_PD_PIPE>;
-		ranges = <0x01000000 0x0 0x3ef00000 0x3 0x3ef00000 0x0 0x00100000
-			  0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x3ef00000>;
+		ranges = <0x01000000 0x0 0xf4100000 0x0 0xf4100000 0x0 0x00100000>,
+			<0x02000000 0x0 0xf4200000 0x0 0xf4200000 0x0 0x01e00000>,
+			<0x03000000 0x0 0x40000000 0x3 0x00000000 0x0 0x40000000>;
+
 		resets = <&cru SRST_PCIE20_POWERUP>;
 		reset-names = "pipe";
 		#address-cells = <3>;
-- 
2.38.1

