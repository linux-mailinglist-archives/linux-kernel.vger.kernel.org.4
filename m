Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09B470C1AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbjEVPAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjEVPAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:00:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81002CD;
        Mon, 22 May 2023 08:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/gikopee53XcwMYA3MYtO2laOjKUiSGLw1KeCxVXHaJrUp977mmN+gOsCCiU9C4fbIxqLgLJp6IitgvXqpCBDQcHzkvXd9ZEVYbJVyUrCQHJVPUHTYYjc7hgWX/gs9eZfR756prFz16wRB05x2WcYT4WNefcmkBZF2K9SUGshCVmegxgGw64yoNHk+LhUSk5bDZPdoILMFDoNGsyUcIHGigDTK7xkLBqT/g0B8mSiGWZaeHyZD5Bnz9PH6zchurULjvObL2q5zRM7SzdHtFBrL1lwZN0MzE1DzmFUUNBoOeQ4fD4QCVt55EMANvS1eRYQu0BNe9LZNukjAM9sFHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydAb1yU6hNZ3Rl+t8PAUQ74+pAfq9e0yNJ5JoGRMUok=;
 b=S3UYWZRwuRSmEXPGV68qxc5pqILFTxtinQ9RmSAC4pD6aLsRIg6ltQTq85WdNm0yNb+XdVIKJtZWBgC3IV+t4Qxay4rVEWXka7bP9fVwtiPZUwiu2pcbxSGwl8z2CsQnVDl5bdtALBViWNbcr1o6pmgVMy42Lmd98Jst/YLlslfbfXkTBgyj//RbhQGy0/cddhpKU32oRYjSsMT+EMGTBH1oHAwPPoI5UttvTq+CCcVAWngTS27ufTRWNXwqjAVcyZ7l9qxi3p4rbwSIZRAJSYlKfnH+CMajo3HMsH7PxyjbeQoCTRizZOdLq0NaFYXjvb9fcST+7hBp7sy5gToH3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydAb1yU6hNZ3Rl+t8PAUQ74+pAfq9e0yNJ5JoGRMUok=;
 b=FOW1J2NNMRY9CTA9UDjoVG6wE6tSDzOcTmlrR8kMYX1x99MazIp7ZOJaCKeDDQ6bqsg9I9qwM79agNj9LxEaZjq511XM3tj1c99KffVSrsaXWBmXne5nSO4kXTnSLXEbeYEAQKwsDCsc9tR/yNyWavbGLuNs3QI1HQcYprLLKYo=
Received: from DM6PR03CA0030.namprd03.prod.outlook.com (2603:10b6:5:40::43) by
 SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 15:00:02 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::56) by DM6PR03CA0030.outlook.office365.com
 (2603:10b6:5:40::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 15:00:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 15:00:02 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 09:59:59 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 1/6] arm64: zynqmp: Describe TI phy as ethernet-phy-id
Date:   Mon, 22 May 2023 16:59:48 +0200
Message-ID: <b49904649a363f40dc9c4d3fa275e42129562082.1684767562.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1684767562.git.michal.simek@amd.com>
References: <cover.1684767562.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9210; i=michal.simek@amd.com; h=from:subject:message-id; bh=ooOFZq7YpwQIOB8aQx8w/uikgHqfOBfWzAkbMGmFRAs=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTs5tiyacGf/de+3PEhyUmmecmWfQum2hw515Q3P5fL7 L30BzHVjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjAROxmG+aU6935JP0x/uXHF +vc2uy6vDXru9p9hfupRFv40z1Cue8L8jExdq4WbVJvuAwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: f99d787e-309e-46b9-cee5-08db5ad53839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCUCX4p1qePh+rftDEedoQHKm9AcD2ExGiDaUyc8KMvlU8cBsDh5xP7gIeUSNWEbSgT+laGFDabZYPIKgRCGy2/fV/ORcBVRtkJESVKHKYSkNQABGsc+LtjaPgNtbY/x0LZAB8fJiPtTZkQVtegWyTZsydSr8CJlWuUNEGYkb0YGvPGtijivtEm7SZnJWgUGzp70xWlMhhm+Ey2vLr2w22ZityW0rtHDtuS3UXfGHfCn0FLwSJQSpD2auU112B4pKh5AhQtKzhtXjP2xClKFOrSl2EK09ZKu8I2zolMFYjO3uRT13is9dEbM/6NvppKiKit6IQzlhLq5xoy1+RyzuXOgcfeLhzaZ+F/WnwQaLVBOvVtNOWOG0lwgzx1m79yHRKv5DFiKHBYNuqrkUFct2X6rKjY5ymkCidjBJ/W34E+fNqBQkPZ8IALhoooOSDka9zPw2vd4EbjVEHVUrujWEXPV/T+7UHp1eD0jw9QmsxU4z/lbtFYsgUPZjJPSOaZUyI1wVstnZTJnUYQpLetksmosUunLEjFEG7KIrCL9HMv5PBSUAIDCduiKlstWrdKYfDX/IIvuc471chiq7nMc4pPeNEDE1V2iz+DWTPr9Tbzx1Symona1P7Y9z1xBrECQsFiWvJkUpg0qt7ZcIiAE/mSwJLatvPeSgLqblYX1+ulfHt5AXANyTHF0+U8HGvCWbzuppDNZoHCi3jRmOd0EwlUD1rz8Ao6SV2LC/EXY0pJ35+ctQZbz/GZl3zRbUnqW4W90kDUM5I8tP1L9JvnhWxmuChYwpNpB7Xh+HrKxnxE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(478600001)(82740400003)(356005)(81166007)(82310400005)(4326008)(70586007)(70206006)(110136005)(54906003)(6666004)(36860700001)(83380400001)(47076005)(316002)(41300700001)(336012)(426003)(40460700003)(2616005)(40480700001)(86362001)(8936002)(5660300002)(8676002)(36756003)(16526019)(7416002)(186003)(44832011)(2906002)(26005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 15:00:02.0122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f99d787e-309e-46b9-cee5-08db5ad53839
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI DP83867 is using strapping based on MIO pins. Tristate setup can
influence PHY address. That's why switch description with ethernet-phy-id
compatible string which enable calling reset. PHY itself setups phy address
after power up or reset. Phy reset is done via gpio.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- fix typo in commit message

Checkpatch is reporting issue
warning: DT compatible string "ethernet-phy-id2000.a231" appears un-documented
but it should be fully aligned with
Documentation/devicetree/bindings/net/ethernet-phy.yaml

c&p more details from v1 version:
Phy has some pins which is using for strapping for phy address after phy
reset or power on. Pretty much it is resistor array which based on
datasheet is decoded to certain phy address.
And because some phy pins are also used as data pin for RGMII they are
connected via MIO pins on a silicon. That's why IO block output setting
really matter here because it changes resistor array and it moves phy
address.
That's why there is a need to do proper IO pin setup and after it call phy
reset to get it to address which was decided by PCB designer.

---
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 23 +++++++++++------
 .../boot/dts/xilinx/zynqmp-zcu102-revB.dts    | 25 +++++++++++--------
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 22 ++++++++++------
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 22 ++++++++++------
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 22 ++++++++++------
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 22 ++++++++++------
 6 files changed, 90 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 230ef94d5dcb..f36353a51863 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP ZCU102 RevA
  *
- * (C) Copyright 2015 - 2021, Xilinx, Inc.
+ * (C) Copyright 2015 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -200,13 +201,19 @@ &gem3 {
 	phy-mode = "rgmii-id";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gem3_default>;
-	phy0: ethernet-phy@21 {
-		reg = <21>;
-		ti,rx-internal-delay = <0x8>;
-		ti,tx-internal-delay = <0xa>;
-		ti,fifo-depth = <0x1>;
-		ti,dp83867-rxctrl-strap-quirk;
-		/* reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>; */
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@21 {
+			#phy-cells = <1>;
+			compatible = "ethernet-phy-id2000.a231";
+			reg = <21>;
+			ti,rx-internal-delay = <0x8>;
+			ti,tx-internal-delay = <0xa>;
+			ti,fifo-depth = <0x1>;
+			ti,dp83867-rxctrl-strap-quirk;
+			reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>;
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
index 63419deb5b33..3c28130909bc 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP ZCU102 RevB
  *
- * (C) Copyright 2016 - 2021, Xilinx, Inc.
+ * (C) Copyright 2016 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -16,16 +17,20 @@ / {
 
 &gem3 {
 	phy-handle = <&phyc>;
-	phyc: ethernet-phy@c {
-		reg = <0xc>;
-		ti,rx-internal-delay = <0x8>;
-		ti,tx-internal-delay = <0xa>;
-		ti,fifo-depth = <0x1>;
-		ti,dp83867-rxctrl-strap-quirk;
-		/* reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>; */
+	mdio: mdio {
+		phyc: ethernet-phy@c {
+			#phy-cells = <0x1>;
+			compatible = "ethernet-phy-id2000.a231";
+			reg = <0xc>;
+			ti,rx-internal-delay = <0x8>;
+			ti,tx-internal-delay = <0xa>;
+			ti,fifo-depth = <0x1>;
+			ti,dp83867-rxctrl-strap-quirk;
+			reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>;
+		};
+		/* Cleanup from RevA */
+		/delete-node/ ethernet-phy@21;
 	};
-	/* Cleanup from RevA */
-	/delete-node/ ethernet-phy@21;
 };
 
 /* Fix collision with u61 */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index d178a4f898c9..3fd47725c2c8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP ZCU104
  *
- * (C) Copyright 2017 - 2021, Xilinx, Inc.
+ * (C) Copyright 2017 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -109,12 +110,19 @@ &gem3 {
 	phy-mode = "rgmii-id";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gem3_default>;
-	phy0: ethernet-phy@c {
-		reg = <0xc>;
-		ti,rx-internal-delay = <0x8>;
-		ti,tx-internal-delay = <0xa>;
-		ti,fifo-depth = <0x1>;
-		ti,dp83867-rxctrl-strap-quirk;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@c {
+			#phy-cells = <1>;
+			compatible = "ethernet-phy-id2000.a231";
+			reg = <0xc>;
+			ti,rx-internal-delay = <0x8>;
+			ti,tx-internal-delay = <0xa>;
+			ti,fifo-depth = <0x1>;
+			ti,dp83867-rxctrl-strap-quirk;
+			reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>;
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index 38b11594c074..4f6429caecff 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP ZCU104
  *
- * (C) Copyright 2017 - 2021, Xilinx, Inc.
+ * (C) Copyright 2017 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -114,12 +115,19 @@ &gem3 {
 	phy-mode = "rgmii-id";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gem3_default>;
-	phy0: ethernet-phy@c {
-		reg = <0xc>;
-		ti,rx-internal-delay = <0x8>;
-		ti,tx-internal-delay = <0xa>;
-		ti,fifo-depth = <0x1>;
-		ti,dp83867-rxctrl-strap-quirk;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@c {
+			#phy-cells = <1>;
+			compatible = "ethernet-phy-id2000.a231";
+			reg = <0xc>;
+			ti,rx-internal-delay = <0x8>;
+			ti,tx-internal-delay = <0xa>;
+			ti,fifo-depth = <0x1>;
+			ti,dp83867-rxctrl-strap-quirk;
+			reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>;
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 8af0879806cf..8c3fa3fe28d5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP ZCU106
  *
- * (C) Copyright 2016 - 2021, Xilinx, Inc.
+ * (C) Copyright 2016 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -212,12 +213,19 @@ &gem3 {
 	phy-mode = "rgmii-id";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gem3_default>;
-	phy0: ethernet-phy@c {
-		reg = <0xc>;
-		ti,rx-internal-delay = <0x8>;
-		ti,tx-internal-delay = <0xa>;
-		ti,fifo-depth = <0x1>;
-		ti,dp83867-rxctrl-strap-quirk;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@c {
+			#phy-cells = <1>;
+			reg = <0xc>;
+			compatible = "ethernet-phy-id2000.a231";
+			ti,rx-internal-delay = <0x8>;
+			ti,tx-internal-delay = <0xa>;
+			ti,fifo-depth = <0x1>;
+			ti,dp83867-rxctrl-strap-quirk;
+			reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>;
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index f76687914e30..0d9b6081dff6 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx ZynqMP ZCU111
  *
- * (C) Copyright 2017 - 2021, Xilinx, Inc.
+ * (C) Copyright 2017 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -172,12 +173,19 @@ &gem3 {
 	phy-mode = "rgmii-id";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gem3_default>;
-	phy0: ethernet-phy@c {
-		reg = <0xc>;
-		ti,rx-internal-delay = <0x8>;
-		ti,tx-internal-delay = <0xa>;
-		ti,fifo-depth = <0x1>;
-		ti,dp83867-rxctrl-strap-quirk;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@c {
+			#phy-cells = <1>;
+			compatible = "ethernet-phy-id2000.a231";
+			reg = <0xc>;
+			ti,rx-internal-delay = <0x8>;
+			ti,tx-internal-delay = <0xa>;
+			ti,fifo-depth = <0x1>;
+			ti,dp83867-rxctrl-strap-quirk;
+			reset-gpios = <&tca6416_u22 6 GPIO_ACTIVE_LOW>;
+		};
 	};
 };
 
-- 
2.36.1

