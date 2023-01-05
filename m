Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C647E65EFEB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjAEPX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjAEPXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:23:01 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE8E5DE57;
        Thu,  5 Jan 2023 07:22:46 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 2EDCC75;
        Thu,  5 Jan 2023 16:22:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1672932164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=72cBbNqSr6yQ92+9me+hKJsaMA8mwYkWgjfNH6oHMXM=;
        b=FXe7iYppD07cJRl07JNEPzDki39/mie1AEdrWVhNLVCHZdS0DatHHkciKbaenIcr7+9veE
        LApYm9QCDiJyg4lyx2yQdtzwixCtJGHCOx5/fBpEEcjM04CSkIpKk1sEbFkMdlRROVbB2u
        Pn0gImf3SezpTYQpMLh7/bkLqd6e8/aFO3iHIHxvJykwGHtpYLu8ZidWj4nFuuOuMqQH/r
        h9y+Xx2F5OxOBqJEqDcyg702f8ycjk8egrcJOVW4hDC1+4pwtNO7cbJYATloL5AmUSdSv8
        tXktaBYs5SLGdxfURH8QW7JWM8oyxS5EyLVQCEICVSVxqMa/4UuWzCMireAbug==
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: ls1028a: sl28: get MAC addresses from VPD
Date:   Thu,  5 Jan 2023 16:22:30 +0100
Message-Id: <20230105152230.2814812-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../fsl-ls1028a-kontron-kbox-a-230-ls.dts       | 12 ++++++++++++
 .../freescale/fsl-ls1028a-kontron-sl28-var1.dts |  2 ++
 .../freescale/fsl-ls1028a-kontron-sl28-var2.dts |  8 ++++++++
 .../freescale/fsl-ls1028a-kontron-sl28-var4.dts |  2 ++
 .../dts/freescale/fsl-ls1028a-kontron-sl28.dts  | 17 +++++++++++++++++
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

