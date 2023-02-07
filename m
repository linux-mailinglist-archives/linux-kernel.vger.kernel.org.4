Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEA068D8B1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjBGNLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjBGNL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:11:29 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499083C28A;
        Tue,  7 Feb 2023 05:10:41 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id EAFD1135F;
        Tue,  7 Feb 2023 14:10:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1675775434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=a0uudd7B3zGUk4WoVfCbKYsiN7E884gNWnQbXIg9Jl0=;
        b=JMZL58uAX2KyEtOvNLjxTnLE8QaLOU71QCPn7l91F1xy3OOoFMeWMbdGQD5ZVPbdlMk/6M
        M7lhcJP0DPSjwVBW5AIGDMCjpaA2JgS5ziu/AtAcpxTR5ylBXvvbbiQhR9Z/oPDGPzEHis
        9DJJ2b6NgzCiMhUJ85Y8a2qJm7pbBfyYWWb57UIkazKqndJv4sqO47ASWQ7ooZNe4thGWg
        Jtt8MYn4FqG0tvZ3ebwQJxnyRE7me1wnVvNXklWwO33JgyJzVUALBOFxndbAWLURdorlUR
        P2uy6rd/nPawFt3Hf6v5d3n+FP9TOS5nV7ieouD06oMhW++2aHEv1GInEKkwMg==
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH] Revert "arm64: dts: ls1028a: sl28: get MAC addresses from VPD"
Date:   Tue,  7 Feb 2023 14:10:20 +0100
Message-Id: <20230207131020.2458027-1-michael@walle.cc>
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

With commit b203e6f1e833 ("arm64: dts: ls1028a: sl28: get MAC addresses
from VPD"), the network adapter now depends on the nvmem device to be
present, which isn't the case and thus breaks networking on this board.
Revert it.

Fixes: b203e6f1e833 ("arm64: dts: ls1028a: sl28: get MAC addresses from VPD")
Signed-off-by: Michael Walle <michael@walle.cc>
---
Shawn, unfortunately, the driver was NAKed, so this will break our
KernelCI setup. Alternatively, the original commit can just be dropped
from your tree, if that's how you do things like this. I've learned that
the correct way is to get the driver in and then in the next release enable
the driver and add it to the dts. Next time :)
---
 .../fsl-ls1028a-kontron-kbox-a-230-ls.dts       | 12 ------------
 .../freescale/fsl-ls1028a-kontron-sl28-var1.dts |  2 --
 .../freescale/fsl-ls1028a-kontron-sl28-var2.dts |  8 --------
 .../freescale/fsl-ls1028a-kontron-sl28-var4.dts |  2 --
 .../dts/freescale/fsl-ls1028a-kontron-sl28.dts  | 17 -----------------
 5 files changed, 41 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
index af9194eca556..73eb6061c73e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
@@ -56,14 +56,10 @@ qsgmii_phy3: ethernet-phy@10 {
 };
 
 &enetc_port2 {
-	nvmem-cells = <&base_mac_address 2>;
-	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
 &enetc_port3 {
-	nvmem-cells = <&base_mac_address 3>;
-	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
@@ -84,8 +80,6 @@ &mscc_felix_port0 {
 	managed = "in-band-status";
 	phy-handle = <&qsgmii_phy0>;
 	phy-mode = "qsgmii";
-	nvmem-cells = <&base_mac_address 4>;
-	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
@@ -94,8 +88,6 @@ &mscc_felix_port1 {
 	managed = "in-band-status";
 	phy-handle = <&qsgmii_phy1>;
 	phy-mode = "qsgmii";
-	nvmem-cells = <&base_mac_address 5>;
-	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
@@ -104,8 +96,6 @@ &mscc_felix_port2 {
 	managed = "in-band-status";
 	phy-handle = <&qsgmii_phy2>;
 	phy-mode = "qsgmii";
-	nvmem-cells = <&base_mac_address 6>;
-	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
@@ -114,8 +104,6 @@ &mscc_felix_port3 {
 	managed = "in-band-status";
 	phy-handle = <&qsgmii_phy3>;
 	phy-mode = "qsgmii";
-	nvmem-cells = <&base_mac_address 7>;
-	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
index 1f34c7553459..7cd29ab970d9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
@@ -55,7 +55,5 @@ &enetc_port0 {
 &enetc_port1 {
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
-	nvmem-cells = <&base_mac_address 0>;
-	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
index aac41192caa1..113b1df74bf8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
@@ -36,14 +36,10 @@ &enetc_port0 {
 };
 
 &enetc_port2 {
-	nvmem-cells = <&base_mac_address 2>;
-	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
 &enetc_port3 {
-	nvmem-cells = <&base_mac_address 3>;
-	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
@@ -56,8 +52,6 @@ &mscc_felix_port0 {
 	managed = "in-band-status";
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii";
-	nvmem-cells = <&base_mac_address 0>;
-	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
@@ -66,8 +60,6 @@ &mscc_felix_port1 {
 	managed = "in-band-status";
 	phy-handle = <&phy1>;
 	phy-mode = "sgmii";
-	nvmem-cells = <&base_mac_address 1>;
-	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
index a4421db3784e..9b5e92fb753e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
@@ -43,7 +43,5 @@ vddh: vddh-regulator {
 &enetc_port1 {
 	phy-handle = <&phy1>;
 	phy-mode = "rgmii-id";
-	nvmem-cells = <&base_mac_address 1>;
-	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 8b65af4a7147..4ab17b984b03 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -92,8 +92,6 @@ &enetc_port0 {
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii";
 	managed = "in-band-status";
-	nvmem-cells = <&base_mac_address 0>;
-	nvmem-cell-names = "mac-address";
 	status = "okay";
 };
 
@@ -156,21 +154,6 @@ partition@3e0000 {
 				label = "bootloader environment";
 			};
 		};
-
-		otp-1 {
-			compatible = "user-otp";
-
-			nvmem-layout {
-				compatible = "kontron,sl28-vpd";
-
-				serial_number: serial-number {
-				};
-
-				base_mac_address: base-mac-address {
-					#nvmem-cell-cells = <1>;
-				};
-			};
-		};
 	};
 };
 
-- 
2.30.2

