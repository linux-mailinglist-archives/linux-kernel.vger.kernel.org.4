Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC76870C1B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjEVPAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjEVPAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:00:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64935CF;
        Mon, 22 May 2023 08:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8gYYKSixPE1iYmdl3RFTFO40yJObEFgY+vEpkby5qwMs87MZr9/fLhZoDkImhFpt5jFHOuAEJ1zMqr6YwBMwvuy0WI00KJ1g5itMw6xBTGMhdZZDN8pmwHULjG/N4q9oYnlN+IrRRqrBbJSBlugGK1+VxJHsygrBokBpKZJECdtvgzc031a+gkgf9QrhVI3Rjhd4LrNm4n1tQ8PfoDJCU9ycWSebXpLcy97GMRBHjP5CE976yDSAQVCt7oRhIXhNGyM8jGoAYY5sIjl+V3vlZ9geGC398p2Ruu3t6Mx7BGwEm5jPArO5e3HQD7P2l+EMmqJLWuC165F5PvSmA1t3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKaDwKWgGj34kfV7+Xy4ofeKe4phzNS1X5wo8c80Ag4=;
 b=MudnKY4L8WPyCcE5sx3tQdEVsqqZMf5dmkRAURTrTbkfpKNpH3rlNXdSIRqPNNMpe2wpbuP3SMb3AICVvVeAu2SoLMkVFasSZOFjAul4kdL/f8uUj26KB6YyQ99qb3Szrr/viTltP76miwFoqFNlY37gwF2Z45JxfWI6GcZyiT55gXhzuEGXLw3NiyokTfEFB4swMzvEblbTPCGg/kA2MG9QKE9PbmrR+UzNOyKcF6tP2mzeQ4WGVMTYagpHQc4nczsPUsc8fZVARKRnZEEqAxDphBixKAQOSFhCIUsQvN+m1kLNJTAz1OlDoi03UmCVyq8tqfXZZDD21Kh0v8Xm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKaDwKWgGj34kfV7+Xy4ofeKe4phzNS1X5wo8c80Ag4=;
 b=Xi4fag9hCpdCtZLXAfY70/1f/QLcumc77rSMR89VXsDo6yCNgOW1TvTlU/aCBOehErnXaLIBVLGWCgrjGGXTeWgTfs/segKgMk3i3yOeZesgIl2Ost/+rWYcWxbbqVpQaDg4YcJUhhb+fTexPFZc1tkyZi1tM4WtMqmyJY52qM0=
Received: from DM6PR01CA0022.prod.exchangelabs.com (2603:10b6:5:296::27) by
 PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.25; Mon, 22 May
 2023 15:00:37 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::3e) by DM6PR01CA0022.outlook.office365.com
 (2603:10b6:5:296::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 15:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 15:00:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 10:00:29 -0500
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
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 3/6] arm64: zynqmp: Set qspi tx-buswidth to 4
Date:   Mon, 22 May 2023 16:59:50 +0200
Message-ID: <1f1b0028106d83aa06e0777e91862a07df100fa1.1684767562.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1684767562.git.michal.simek@amd.com>
References: <cover.1684767562.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7340; i=michal.simek@amd.com; h=from:subject:message-id; bh=Gl+tyTMoFNKlU3UiJWQaU4vwmFqPHKaLGnnaY76ai98=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTs5rj5jhabvv30DDy29aHh04Dgy7ysuRe4c2eXLz2+7 YImR1RjRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIC2uG+Y5ngnYqnfgQMVk3 UrncUL2lfsvKNwwLpjst+tG9SSJ1was7bcufP+t3Zr3ZDgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c799cc-27f3-4ab5-691d-08db5ad54d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnUbs3+f+T2KgaQlrhZS95pc6jCCuAl8XckWr8+aaZ24HdaarJIH16lH9kCarykdaslZCL65JGe7M9CCALA021d7tI9/18Gnz7N/2LRrEAtEtsk2T2e/ud8eQebdUJM2lT9ma7tL2HOER5BzlTUbxrzx1bjrxdUkMnCezzafOijXh/Vtmev2q4nTY1EEOqSxWc9keRRVOt0PWds+wFiaR9gz2UPklPEJmWw/GFAkkDZYeIZx98qxSVIbgOjiPuDMVp9UBHPG+PtKMjJ6kRwchqy4pbAqXn4blJlWNC8XrOgnme+WC23f+SXmJ14a88QFPtZK/7oZMNuXZyfuyx2lvn9ZuKDWXBfXrTMxWHzQj5x/DhQ96bUE7IXuU9gdGed5PyT9asDrV/g13VtSLknDIUqKU3XCYHWW2+AoWBB4kJ6tWmy5lQsgxI0Emp3b87sEQsqctbpkVbidGY8roUAWhAPwe9TTHo2ZgclNzudUrpyP10DaHrJrNmKLai5OGKv0dZ4cOrZog32e62iBkEhiDiP7r80/iWxG6ihPeU8bdTvbHksVokAbiYdih5pM9a0gLbC9MZlX5pbneRV8e2YkKROiuyH6jTgA9Az5dxaHQ4f6vOgc7jL4YLM6TbnbvmOpO7mEeQHJraOfGO0unCmBw78CmqDt9pHRq1x8A7tQu8XaD0nVlXxr1WXadNDeWekJxs5FvGBAv5Obavs2DD7vtbxsztjtk03AobYAmdy52FjidnFx2J/1SCVPIKJln43oZ+IWjNgkMmb8M/q86+5Q3OxS7N6ZGB8taKzHYE1Y8qg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(8676002)(8936002)(47076005)(5660300002)(7416002)(44832011)(83380400001)(36860700001)(82310400005)(16526019)(186003)(336012)(26005)(426003)(2616005)(81166007)(86362001)(356005)(82740400003)(40460700003)(41300700001)(40480700001)(70206006)(6666004)(478600001)(70586007)(4326008)(316002)(110136005)(36756003)(54906003)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 15:00:37.5629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c799cc-27f3-4ab5-691d-08db5ad54d6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794
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
Using all 4 lines will increase the tx data transfer rate, as now the
tx data will be transferred on four lines instead on single line.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Update commit message to skip spi-nor part - reported by Laurent

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts     | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index c1ab1ab690df..84e18fdce775 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -124,7 +124,7 @@ spi_flash: flash@0 { /* MT25QU512A */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0>;
-		spi-tx-bus-width = <1>;
+		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <40000000>; /* 40MHz */
 		partition@0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
index 48d6a7202406..04079d1704f1 100644
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
index e80484f9b137..3dec57cf18be 100644
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
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index af3331c133ad..d9d1de5f313c 100644
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
index 05be71eab722..6636e76545a5 100644
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
index a074d8e2b86d..8767f147cbe3 100644
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
index 91c9b77f6b1f..e185709c0d84 100644
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
index 954044d9899f..7fceebd1815c 100644
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
index ab5e34b43642..27b2416cb6d8 100644
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
index f31365a14f73..6224365826d8 100644
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
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
index e615286b8eff..c406017b0348 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
@@ -47,7 +47,7 @@ &qspi {
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor";
 		reg = <0x0>;
-		spi-tx-bus-width = <1>;
+		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <108000000>;
 	};
-- 
2.36.1

