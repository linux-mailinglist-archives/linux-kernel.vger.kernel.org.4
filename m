Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87061732F87
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344882AbjFPLLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344143AbjFPLLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:11:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39752195;
        Fri, 16 Jun 2023 04:11:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B21B961953;
        Fri, 16 Jun 2023 11:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0143DC433C0;
        Fri, 16 Jun 2023 11:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686913891;
        bh=QrQ31h3vw6CokBWh+9T/1oX+PH5ZWIKL0xtxAZwjZCg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=AwPNc65Y397La4809RSEjvhfOZhNBp2EymaBOAHVTzcxmPHCKHNidwdaS7JmCjNPL
         s86HGSYQB7WHSSlcxHrRZGoS0tSXiCU0TDBfKY+8z/pQpHm+FvdcQhDz3v949B8rWT
         kpVQqugCAeiB0o4dsjAJMJ/Q5ZazYjYG4qF6thHox/PUhNfA6VW8AzMpkwV/oebxRs
         ZQIUqF8cBpf17ur04sBhsskCBHczrQolUjt5ivW2JKlXD/PKsK362gwuW65/0hy6iW
         1oYEXvbMNTKfeWktibvu4YuGJqBLz1+1x+5rsWJxWN4NRPEqYKnc5jjDYmQPhY4Q34
         vAh+g0F9ggrUg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 16 Jun 2023 13:11:22 +0200
Subject: [PATCH 2/2] arm64: dts: ls1028a: sl28: get MAC addresses from VPD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230616-feature-sl28-vpd-dt-v1-2-c5458016ba85@kernel.org>
References: <20230616-feature-sl28-vpd-dt-v1-0-c5458016ba85@kernel.org>
In-Reply-To: <20230616-feature-sl28-vpd-dt-v1-0-c5458016ba85@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that it is finally possible to get the MAC addresses from the OTP
memory, use it to set the addresses of the network devices.

There are 8 reserved MAC addresses in total per board. Distribute them
as follows:

+----------+------+------+------+------+------+
|          | var1 | var2 | var3 | var4 | kbox |
+----------+------+------+------+------+------+
| enetc #0 |   +0 |      |      |   +0 |   +0 |
| enetc #1 |      |      |   +0 |   +1 |   +1 |
| enetc #2 |      |   +2 |      |      |   +2 |
| enetc #3 |      |   +3 |      |      |   +3 |
| felix p0 |      |   +0 |      |      |   +4 |
| felix p1 |      |   +1 |      |      |   +5 |
| felix p2 |      |      |      |      |   +6 |
| felix p3 |      |      |      |      |   +7 |
| felix p4 |      |      |      |      |      |
| felix p5 |      |      |      |      |      |
+----------+------+------+------+------+------+

An empty cell means, the port is not available and thus doesn't need an
ethernet address.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 .../dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts | 12 ++++++++++++
 .../dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts     |  2 ++
 .../dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts     |  8 ++++++++
 .../dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts     |  2 ++
 .../boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts     | 17 +++++++++++++++++
 5 files changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
index 73eb6061c73e..af9194eca556 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
@@ -56,10 +56,14 @@ qsgmii_phy3: ethernet-phy@10 {
 };
 
 &enetc_port2 {
+	nvmem-cells = <&base_mac_address 2>;
+	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
 &enetc_port3 {
+	nvmem-cells = <&base_mac_address 3>;
+	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
@@ -80,6 +84,8 @@ &mscc_felix_port0 {
 	managed = "in-band-status";
 	phy-handle = <&qsgmii_phy0>;
 	phy-mode = "qsgmii";
+	nvmem-cells = <&base_mac_address 4>;
+	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
@@ -88,6 +94,8 @@ &mscc_felix_port1 {
 	managed = "in-band-status";
 	phy-handle = <&qsgmii_phy1>;
 	phy-mode = "qsgmii";
+	nvmem-cells = <&base_mac_address 5>;
+	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
@@ -96,6 +104,8 @@ &mscc_felix_port2 {
 	managed = "in-band-status";
 	phy-handle = <&qsgmii_phy2>;
 	phy-mode = "qsgmii";
+	nvmem-cells = <&base_mac_address 6>;
+	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
@@ -104,6 +114,8 @@ &mscc_felix_port3 {
 	managed = "in-band-status";
 	phy-handle = <&qsgmii_phy3>;
 	phy-mode = "qsgmii";
+	nvmem-cells = <&base_mac_address 7>;
+	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
index 7cd29ab970d9..1f34c7553459 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
@@ -55,5 +55,7 @@ &enetc_port0 {
 &enetc_port1 {
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
+	nvmem-cells = <&base_mac_address 0>;
+	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
index 113b1df74bf8..aac41192caa1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
@@ -36,10 +36,14 @@ &enetc_port0 {
 };
 
 &enetc_port2 {
+	nvmem-cells = <&base_mac_address 2>;
+	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
 &enetc_port3 {
+	nvmem-cells = <&base_mac_address 3>;
+	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
@@ -52,6 +56,8 @@ &mscc_felix_port0 {
 	managed = "in-band-status";
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii";
+	nvmem-cells = <&base_mac_address 0>;
+	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
@@ -60,6 +66,8 @@ &mscc_felix_port1 {
 	managed = "in-band-status";
 	phy-handle = <&phy1>;
 	phy-mode = "sgmii";
+	nvmem-cells = <&base_mac_address 1>;
+	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
index 9b5e92fb753e..a4421db3784e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
@@ -43,5 +43,7 @@ vddh: vddh-regulator {
 &enetc_port1 {
 	phy-handle = <&phy1>;
 	phy-mode = "rgmii-id";
+	nvmem-cells = <&base_mac_address 1>;
+	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 4ab17b984b03..8b65af4a7147 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -92,6 +92,8 @@ &enetc_port0 {
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii";
 	managed = "in-band-status";
+	nvmem-cells = <&base_mac_address 0>;
+	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
@@ -154,6 +156,21 @@ partition@3e0000 {
 				label = "bootloader environment";
 			};
 		};
+
+		otp-1 {
+			compatible = "user-otp";
+
+			nvmem-layout {
+				compatible = "kontron,sl28-vpd";
+
+				serial_number: serial-number {
+				};
+
+				base_mac_address: base-mac-address {
+					#nvmem-cell-cells = <1>;
+				};
+			};
+		};
 	};
 };
 

-- 
2.30.2

