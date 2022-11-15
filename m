Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A76C629D50
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiKOP01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbiKOP0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:26:24 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E87E1E3D5;
        Tue, 15 Nov 2022 07:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668525983; x=1700061983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IGihFppS2au5FTiJUnJrlcOJRBfXk4goCN+sJ4nWs/0=;
  b=JrfOzFjLLUGa6+xfwru0Zon+wv6VFYvg74w3ukyzTZGVUhQSGwIyah1p
   d2umYKfTjtkPYqnagUvB4bAMv4+Y7/d0Wa+qzSMjK3srWakw/c7X36OAe
   zZ1pZjsNFfYaMIZLHSxuQJ3TiNgmmCFX1UZB7GUZrUwLPNOVO052aqS3S
   uR2YKhDXBIDhL9CbvuryjVpusJb3e1jbIh0prJcG9GbXEQwic+3fVOXu0
   6n04gNR3wwe9pRh6SooRFKho1NyGWaNpbh1wuI+OkqejfFEHfh2wgro81
   DIXOVsMAIRmuG0xM5rVR44fJd5fKhKmenAOE94S889trs2xnkms6cycAn
   w==;
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="189118719"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Nov 2022 08:26:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 15 Nov 2022 08:26:12 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 15 Nov 2022 08:26:11 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] riscv: dts: microchip: remove unused pcie clocks
Date:   Tue, 15 Nov 2022 15:25:47 +0000
Message-ID: <20221115152546.1425309-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221115152546.1425309-1-conor.dooley@microchip.com>
References: <20221115152546.1425309-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe root port in the designs that ship with these boards are
connected via one, not two Fabric Interface Controllers (FIC).

The 0x20_0000_0000 is fic0, so remove the fic1 clocks from the dt node.
The same clock provides both, so this is harmless but inaccurate.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs-m100pfs-fabric.dtsi    | 4 ++--
 arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-m100pfs-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-m100pfs-fabric.dtsi
index 7b9ee13b6a3a..8230f06ddf48 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-m100pfs-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-m100pfs-fabric.dtsi
@@ -30,8 +30,8 @@ pcie: pcie@2000000000 {
 				<0 0 0 3 &pcie_intc 2>,
 				<0 0 0 4 &pcie_intc 3>;
 		interrupt-map-mask = <0 0 0 7>;
-		clocks = <&fabric_clk1>, <&fabric_clk1>, <&fabric_clk3>;
-		clock-names = "fic0", "fic1", "fic3";
+		clocks = <&fabric_clk1>, <&fabric_clk3>;
+		clock-names = "fic0", "fic3";
 		ranges = <0x3000000 0x0 0x8000000 0x20 0x8000000 0x0 0x80000000>;
 		msi-parent = <&pcie>;
 		msi-controller;
diff --git a/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
index 67303bc0e451..9a56de7b91d6 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
@@ -30,8 +30,8 @@ pcie: pcie@2000000000 {
 				<0 0 0 3 &pcie_intc 2>,
 				<0 0 0 4 &pcie_intc 3>;
 		interrupt-map-mask = <0 0 0 7>;
-		clocks = <&fabric_clk1>, <&fabric_clk1>, <&fabric_clk3>;
-		clock-names = "fic0", "fic1", "fic3";
+		clocks = <&fabric_clk1>, <&fabric_clk3>;
+		clock-names = "fic0", "fic3";
 		ranges = <0x3000000 0x0 0x8000000 0x20 0x8000000 0x0 0x80000000>;
 		msi-parent = <&pcie>;
 		msi-controller;
-- 
2.38.0

