Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1726F450D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjEBNgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbjEBNgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:36:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4796D6182;
        Tue,  2 May 2023 06:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3Yg99UvQcvYvNPbGtwYwNXRZz3vtiOyfPlb7P0LOmqj6RktX7rNoUhkYVtYGSE0m4l+nxJI8lerGODVLzcSbmXopPSG7SK8TRwphXV1cB5HTlhGzWtEqrcKDZ3ZKqqMuzYH10VQxf6lkEN3Yi+oPeZYIQiyEc1wOR8ELhj6mRZM/K1M33oUpjluYeX76N0fk5Wosz+4XL01wIYDCy5NtrM7PJ6XVz0Ixf61ikVVyrbNsVTd3fhc22XuouBilYFVgwtGEIaB01vylyIoro/KfyjZA+M1Lh2EdwGDsI+VSwxthM3hLL1/hR24n9I1hsnMX/nL9Qa7x2XSSntSMQnxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLin278g9u67R1wd6WpzWcVg/T/Fu3xxijD1Z6Dui0s=;
 b=DAOgnhwK0mCHecTSPQRk3OQP4lKYm4egLf43aGl9dfNVBEk0Zgc6d5a34RkNWhDXDPQ90YNFMhKnUkC5N2ZrWq/j4uxtWUKtnmfTF2wlbLDJR0Vt4YoLr1wR0N0ld9VGY1VXVo46NHD3iFYocVl8uO4kPX3iwgX3lKuHlrb0V1nKiNncK3BfPay/kbXmGGJGEuKcRIgmuRPN7+iZQyYDHGYrxE3cRbuzZObEJU/NAHg4iwxLLGOXsWgTEjap01ZJpVxxbrPPPcrm5U1rtaR9PF7fVEoH24c2vyC3D+Lz3KpK3jrHkunr8NrvWB95axk2+eSpElfq4B9r98548RnOhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLin278g9u67R1wd6WpzWcVg/T/Fu3xxijD1Z6Dui0s=;
 b=c0IXmBpFd7LyeIrBGTvDYbg7V5whA5qlb2Qgs6sL0rkrwjJ4LAbyViFR+vY0CAWbkLXbcmND7np91+lCipU/ibf4uHHIQ0w58FpVNmuSZ0ohEFDCNFMvXAb+Rh7xwnOoHKoKBb7mogZ/WJjhJ2n0vuVldn34ogA4Qc4s3ckFkSM=
Received: from DM6PR02CA0168.namprd02.prod.outlook.com (2603:10b6:5:332::35)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.28; Tue, 2 May
 2023 13:36:00 +0000
Received: from DS1PEPF0000E638.namprd02.prod.outlook.com
 (2603:10b6:5:332:cafe::70) by DM6PR02CA0168.outlook.office365.com
 (2603:10b6:5:332::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Tue, 2 May 2023 13:35:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E638.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 13:35:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:35:58 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 01/23] arm64: zynqmp: Describe TI phy as ethernet-phy-id
Date:   Tue, 2 May 2023 15:35:29 +0200
Message-ID: <9eefc40c727928e0c7b794a3a2e061ecf6ea230c.1683034376.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1683034376.git.michal.simek@amd.com>
References: <cover.1683034376.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E638:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 5009ebc9-6b32-40b8-3277-08db4b122a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKmO0Mb44MBVcvBlDvYFwqfJ6PCtR7OwQ/IIT2A1lQb2bOkICjnFeKgc2wA2B1J99ivBcUt3kZ7gOb6awXQalTNERTnwyxgZS8E9HRfBzYr2gzX1cNGgt1jOA9DoPmcPYUg19XlxXqw/ZW1sl6Wk/3XRhNaHBQOqrxaBGEBY49D8W1k/MfGPxEkI6l2cYN2mGWXOq8uaEv5JgueW9RdmeJPlMA/BQrNtcHW5jszDbgnxWolw806a2uxV3aBcTW5MIXoiGfIHusxLKOP7M3ci0WYjm9almyBBXaE4jMbJ6ndb51raIaL/SH1cwJNLuXi4Nz/xBa4+GGgBzArokkhrHwA/dOaA59XTZobRzy1NmdvQqKsJ7t+E7yguHxbRI0v7NZmePnmeLtP6qCzSg7JUgudoFokVKOJGGmazx7wGJJ9rAXrwr9FiGy/QYThr0R9tn6TedFS/VR5aEpKwl7b+CKKE43TNn2C1q5KiwXQ1CLygvlNCvt90n64/4i8mxsIhJCK1G/pJbGCahvtcatjXogqaKaaMm/YxCvzPFkPqs2up5CrDW3KCp3LflivV758JUiUMMrClLnZd1KeRVCk7R54Wmf/ki1oOaJr0rTK+V2o7hx5s9mFfZw91JQ4Bsx/OEAq50Tjqh5eDvCBeFEmmyQFTX/WquQfy/xYun1Z2dCbyQR7lZo779qPSVAgMrIH5aa/6jJDWaB0i2lyVq+wPld+pIRvIbRroefnpQT9QztvMoRb+CaIOU1IGpP/Q2Xkd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(2616005)(83380400001)(478600001)(36860700001)(186003)(16526019)(4326008)(54906003)(70586007)(70206006)(110136005)(26005)(47076005)(426003)(6666004)(336012)(44832011)(316002)(8676002)(40460700003)(82740400003)(8936002)(7416002)(5660300002)(356005)(41300700001)(2906002)(40480700001)(81166007)(82310400005)(86362001)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:35:59.6946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5009ebc9-6b32-40b8-3277-08db4b122a82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E638.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI DP83867 is using strapping based on MIO pins. Tristate setup can influce
PHY address. That's why switch description with ethernet-phy-id compatible
string which enable calling reset. PHY itself setups phy address after
power up or reset.
Phy reset is done via gpio.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Checkpatch is reporting issue
warning: DT compatible string "ethernet-phy-id2000.a231" appears un-documented
but it should be fully aligned with
Documentation/devicetree/bindings/net/ethernet-phy.yaml
---
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 23 +++++++++++------
 .../boot/dts/xilinx/zynqmp-zcu102-revB.dts    | 25 +++++++++++--------
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 22 ++++++++++------
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 22 ++++++++++------
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 22 ++++++++++------
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 22 ++++++++++------
 6 files changed, 90 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 13c43324f1d2..c193579400cf 100644
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
  * Michal Simek <michal.simek@xilinx.com>
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
index f7d718ff116b..00b930f20718 100644
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
  * Michal Simek <michal.simek@xilinx.com>
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
index 485585c491f4..11c1eaef9f53 100644
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
  * Michal Simek <michal.simek@xilinx.com>
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
index 44ec9edd2452..c06c138fa3e5 100644
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
  * Michal Simek <michal.simek@xilinx.com>
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
index 09773b7200f8..52cdec33f190 100644
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
  * Michal Simek <michal.simek@xilinx.com>
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
index e0305dcbb010..699cc9ce7898 100644
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
  * Michal Simek <michal.simek@xilinx.com>
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

