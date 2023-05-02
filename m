Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2161F6F450F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjEBNgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbjEBNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:36:12 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5309161AD;
        Tue,  2 May 2023 06:36:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keXFBIvuB+Jgrlo+01BVAqEjtayT83RnCOkt83b8nvfU+VbqkWq2pM6NQyfoLdTlEAZWwPs7cEdzXZT7a8BFrEkTDuFj+MzqdU5Qg6z5YHZuPA81OOqjIOMLLCH+/E7aPzCRUpOzAtVxY8F30C+ddhDW6xU6ZRs0OU1kwJOdNjjOyD6Bb3RejbgFALwOAOJwAFauaSTajVedu1HElqeHP8x7c/SCY2vBuEigCNCXtY72DwpoyXRlXuvJ/KPUYUDYF7csh/HfhnfLY0nJvDU8C80pRk5qpQNgtfsx2Tbs46AGSg+0pR+QTLGQg9DfN5DU5qGROztTbgEqMWQuUyX1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=885VZJghLNW2oFSVPTM9Yo+R8XtYlSoG0xKntIh+45Y=;
 b=Ajqp7T62tiJ53jgEqYK1Zk6rJ1kZSs7VX6gko6RQj46CCmQvUbIIJKaI4CFTfVMLYURENX36VK0cdlyWoyAaKllMAkPqPpNAbA5nqvG0tyJBIy+ZNZSK2TN5sypfb0ZkjGlHqqJhjTkxhyJ1BF+qGWmfu38J96BLwheQKisBibAVwMC87NG8AFZRXj/d1uw50mJYvwus7roEn6Qv8DFiX/2R4jBqFcAB9C/sxi2mQNFfe7GB/PO4BBLMNtYXGTm1mLYGzmSpf8XDNkDoUWSJVSdxEnq5wrqzOH0QDoZBCtBqM7Nm2uzI0GHSao7a4AfkibNbZgRrtqHR8EskXBb/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=885VZJghLNW2oFSVPTM9Yo+R8XtYlSoG0xKntIh+45Y=;
 b=t5yTHy6jULd76FQn8OwvuKdMynrYCfcwuTayQW2gSsTTICefT+uiWcfrAK7jTc5mKgkyaj78uQMJ2ND/Tcfb0Gr61JLpeJHiv+XNbkzJMQ9KpcMVTExhkbx+xb59Tt5tirTYvbGDcaVbooE22P9KBiwuFfJadgr+pjmR1Id/GAY=
Received: from DM6PR03CA0007.namprd03.prod.outlook.com (2603:10b6:5:40::20) by
 CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.31; Tue, 2 May 2023 13:36:07 +0000
Received: from DS1PEPF0000E63B.namprd02.prod.outlook.com
 (2603:10b6:5:40:cafe::f) by DM6PR03CA0007.outlook.office365.com
 (2603:10b6:5:40::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63B.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 13:36:07 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:36:05 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 03/23] arm64: zynqmp: Set qspi tx-buswidth to 4
Date:   Tue, 2 May 2023 15:35:31 +0200
Message-ID: <0cc9dce0330abf3df46252ab63a3930bded23e4b.1683034376.git.michal.simek@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63B:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e61c285-21aa-4de4-9e13-08db4b122f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZL45kF3MHOfrYF6k03e8RsZtBq19QPfeHIxdISxCW3eEalCpNDvmY99qYHeik0YmQKqbDCxFYz1XlvltBE/4ObU/WPP5l6KL4D9e7/iNDB/Gm/t1KIIoronTnguf2pyI92WamjAv0Sm8mEcRYdF8jrg0FW8+CRhYNUH9Z5bsOxNhx2Fl4Ol/6DRwShT/gvO4TNXKAo5ethPSWJYpgWZSyo+x41uh3dQiABClyc1OxRevSUfj18ZUBDBz7y5hGWti2BycK8de7WhTPx1Bi2/HEoLixWwXL6EVz2j47RvqqLBv02vamW36kR5EXAQnA16S/JdUFOvIVp+c0BbN9RZ+1gpOA854GbZnA3Lci+5IinIRRCPSt0/CiAydTclEj5EsJDebQhh7k688LR6cs6qX2OP/o5UkNEXjb/gnwpmRtRLdsV2ozU/2wvYtNB7qdCWMtKnTw3G0I6BtYQHyv286IM3UlIfIOIYp6PtshXgaAgQ+g2Yd7G0RHp7NyBTknT5hAdSLh1hDtpRnPEVmAROw5yy1Wz8EoeySDMp8DWFulnrSog5+feCk027ZAoE1W4XOUgBwlyTmcag+VmFoC112mMHUaxoHDYvUP5VTfn+xTMCIGy4uA/gncdFa9f2dAYOpSSn5k4DQfww9YCD6TrxVK0GFiuF+kiulqWBURFOKrCyZLzKiElnu4nwxxIKSQ9MWVznY6uzVrMlODzlewjz4MOpj2u+28/FMhMUvW0OAJYCm7C7ujVRPKF1/130VhREd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(7416002)(44832011)(36756003)(40480700001)(16526019)(186003)(40460700003)(5660300002)(26005)(2906002)(356005)(86362001)(478600001)(110136005)(54906003)(41300700001)(336012)(426003)(81166007)(70206006)(70586007)(47076005)(82740400003)(316002)(4326008)(83380400001)(82310400005)(8676002)(8936002)(2616005)(36860700001)(6666004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:36:07.4412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e61c285-21aa-4de4-9e13-08db4b122f41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>

All ZynqMP boards are setting up tx-buswidth to 1. Due to this the
framework only issues 1-1-1 write commands to the GQSPI driver. But the
GQSPI controller is capable of handling 1-4-4 write commands, so updated
the tx-buswidth to 4.
This would enable the spi-nor framework to issue 1-4-4 write commands
instead of 1-1-1. This will increase the tx data transfer rate, as now the
tx data will be transferred on four lines instead on single line.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index 34412304d09f..dcc17e3ea961 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -85,7 +85,7 @@ flash@0 { /* MT25QU512A */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0>;
-		spi-tx-bus-width = <1>;
+		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <40000000>; /* 40MHz */
 		partition@0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
index f1598527e5ec..4d301ea0bdcb 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
@@ -44,7 +44,7 @@ flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x0>;
-		spi-tx-bus-width = <1>;
+		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
 	};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
index 04efa1683eaa..485a7b21157a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
@@ -45,7 +45,7 @@ flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x0>;
-		spi-tx-bus-width = <1>;
+		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
 	};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
index e971ba8c1418..676b8550a625 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
@@ -47,7 +47,7 @@ &qspi {
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor";
 		reg = <0x0>;
-		spi-tx-bus-width = <1>;
+		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <108000000>;
 	};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index 5fa9604f05d1..35fe7857459a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -355,7 +355,7 @@ flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x0>;
-		spi-tx-bus-width = <1>;
+		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
 	};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
index 6e0106bf1294..311cb2f81c7b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
@@ -173,7 +173,7 @@ flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x0>;
-		spi-tx-bus-width = <1>;
+		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>; /* also DUAL configuration possible */
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
 	};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 78043d9de7cc..5b6403865541 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -957,7 +957,7 @@ flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x0>;
-		spi-tx-bus-width = <1>;
+		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
 	};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index c1779c88ec34..a74a2061431a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -444,7 +444,7 @@ flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x0>;
-		spi-tx-bus-width = <1>;
+		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
 	};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index b857c1950496..73972d83ed4d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -456,7 +456,7 @@ flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x0>;
-		spi-tx-bus-width = <1>;
+		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
 	};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index e4e09afbdc1a..5a54d066db86 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -964,7 +964,7 @@ flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x0>;
-		spi-tx-bus-width = <1>;
+		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
 	};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 791b2ac9fbdb..3b37df98700c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -794,7 +794,7 @@ flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x0>;
-		spi-tx-bus-width = <1>;
+		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
 	};
-- 
2.36.1

