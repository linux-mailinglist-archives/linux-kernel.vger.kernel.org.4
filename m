Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6DC60EF53
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 07:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbiJ0FMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 01:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbiJ0FMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 01:12:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1131552EE;
        Wed, 26 Oct 2022 22:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azZ+jfZo4pIGQ8UltTRfUC0vEMbEDy9ggdEDkQwAnsZv7Sz9yv5ZQc8FFP6G0FXUzx9RL1TgwUXFIZzT7Mt9hVuBZDjEjabWzrCVI3/7PGaZcxUWHWu5D3WeDgY/pObgeK6HbasRkbOgVmRVGUfBXgRXTrCzAWjugWVUcBHmt+iRvhalKm64vU1qFRxbUuJso/TVcb+aMP9gd9sSfmBGNQqkVQlAUjuxaKKurelmm9A+XuKHcv7+yi1M1Dxm2hB16pWafzRoPgko/5Ay/xD+V4o356rQLBH53fkR1meptLvMGLXedmQ8vjZI2LVsb7Z6UYWjd0gJligSorqgUWIbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6ea6zUkMImFRVSquFdYu6dFGgJe/P7KtfzpaacCThA=;
 b=nejsAbwU0zKRCCL6ILjmsIuMbGP/CLyL8TYzb+2r31bIuccdq03o3vR+7bHFyCELlHB8gtj+cT1vymeGO95+fKbLut9jX255TqFVG2LzFG7ODYDZuyNmiuuDQXxq1eEwseDuI7qf9G5K4y3PFwzQN8qeCYtT7FZjGC/ZwnmuQH7pckzklaSUSVbBqmEDlOMJxzGQgmV/E8/UlCV6PlrhR8gZOszlCtoixdJdNHjSOKKRV7Cu5mQiPHnS4VjClAs10rngZI8d3I3KOBlLiAhwqxNBuRPJwLC3q1p8x+fo0Q8aF3IgmNhGGWAnSHiPCk0aBW1XMVWiIsWOL9ogUtEtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6ea6zUkMImFRVSquFdYu6dFGgJe/P7KtfzpaacCThA=;
 b=VzeFbq0zPGZ+AID61Ths+yHtUM17Yolc0myIq3fNARE45+wLy8UxOXTZwQnTqfmW2lvJlGaJBWvpWtOOMR3tGML+0KCh1UEVe7uOBKN0ziGaTem5u3cJHEI3L7wMU9zpdAhA1c1GuOuj/OsfR0jn3mJXI/kZyAtSc8WFOhEW2+fzuZVekGy979+v2B9219CMKTPJgw6j5Ij0HLTUqJbf4ctJ2ZlKw00rpOFbXSpy7FDkk5Sj07qGuWsKFeKlelqxlf35hzfGKZzqZWyyI2b5iZP1m6RIhBGKiOniBBbWbTCVkLb/T0GW+FwcO5sDuw2moDhALLWUKn5cm0OakF5GfA==
Received: from MW4PR03CA0063.namprd03.prod.outlook.com (2603:10b6:303:b6::8)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 05:12:35 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::13) by MW4PR03CA0063.outlook.office365.com
 (2603:10b6:303:b6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Thu, 27 Oct 2022 05:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 05:12:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 26 Oct
 2022 22:12:33 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 22:12:33 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 26 Oct 2022 22:12:30 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mperttunen@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V1 2/2] arm64: tegra: Add ECAM aperture info for all the PCIe controllers
Date:   Thu, 27 Oct 2022 10:42:14 +0530
Message-ID: <20221027051214.22003-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221027051214.22003-1-vidyas@nvidia.com>
References: <20221027051214.22003-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT035:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee14d97-3f7e-42b1-cd2c-08dab7d9dc42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iy774vYiPCu555vC95TUIVvnlwSMgzpype8W+ILJEl8NTrLygYt82YM3w/aDN2aQh9KhfAP4jUMCMYsUMV3nt9/d7LSw5RcFwF9LIkOFygzM8RoOgLqF1tzTykNAimC7jBarOE0+I/AeIHkd2CTkFoasenKGI8vEd37zBjA6I12qOwpAH/EzVprWVIk6ldUUeQ28zKxyeiTwKTDym7Bm7b7J95t5ODMTlz1/CEUC7GXNlFEqNNS51Rw74s0/WNSST1kHQ/FbZN78WCFPDrSZXAwc5O1k0zNsJHgubsgScqNvcV2sSUZLYKKn6jGqo0zWFC46J1fzG/Q/WVJN5p4yi/qbSSKA9KlE17StNALOK8shiHcnpjZVTkVWtZtc/giIjiWIRaQwoPvbLgscYWVGCxWkMUbXanro1ev6aC4zNeZnvJSLin3AxERy0g9K0eGOqjrmTiZyAvyMT2P7PBZAbQtKzZLEcNl5pJVS9wAIPL91tKgG7aBwTVDsinOBm4DE7TAdklldep8PV1RJf6mpNH81MkAVPMgkhLVfg9XL4+8miZZr69tBXfua8dH92fr7omy3loWnKx4I8JkR8OQm8KUVv4oAWEZC6XrESXdTQDVaH2r/BbMWvrXBkxz6U8N+BGgCEHONfN9Z2D+Z7lTQhEFXhOju45Mdn9Qq3t1Yq357nMJ6RRf+2Yq8T/g1TSlv8cj6pFAhbTcL6OXe5xuCuYm4zvT9iAA+rm9MVrG6LpXvXsmN2HF/J81ery0EBeW4m+/ekmGWWE1QXK0kIxfIFg==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(70586007)(8676002)(70206006)(41300700001)(36756003)(4326008)(8936002)(5660300002)(6636002)(478600001)(54906003)(316002)(356005)(40480700001)(7636003)(83380400001)(110136005)(6666004)(26005)(82740400003)(36860700001)(86362001)(7696005)(336012)(47076005)(426003)(40460700003)(1076003)(186003)(2616005)(2906002)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 05:12:35.6560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee14d97-3f7e-42b1-cd2c-08dab7d9dc42
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ECAM aperture information for all the PCIe controllers of
Tegra234.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 55 ++++++++++++++----------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 85b0dea33117..f5d20f7253b0 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -2044,8 +2044,9 @@
 		reg = <0x00 0x140a0000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x2a000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x2a040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x2a080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x2a080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x35 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2097,8 +2098,9 @@
 		reg = <0x00 0x140c0000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x2c000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x2c040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x2c080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x2c080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x38 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2150,8 +2152,9 @@
 		reg = <0x00 0x140e0000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x2e000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x2e040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x2e080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x2e080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x3b 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2203,8 +2206,9 @@
 		reg = <0x00 0x14100000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x30000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x30040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x30080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x30080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x20 0xb0000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2256,8 +2260,9 @@
 		reg = <0x00 0x14120000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x32000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x32040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x32080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x32080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x20 0xf0000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2309,8 +2314,9 @@
 		reg = <0x00 0x14140000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x34000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x34040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x34080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x34080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x21 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2362,8 +2368,9 @@
 		reg = <0x00 0x14160000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x36000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x36040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x36080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x36080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x24 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2415,8 +2422,9 @@
 		reg = <0x00 0x14180000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x38000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x38040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x38080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x38080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x27 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2468,8 +2476,9 @@
 		reg = <0x00 0x141a0000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x3a000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x3a040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x3a080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x3a080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x2b 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2521,8 +2530,9 @@
 		reg = <0x00 0x141c0000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x3c000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x3c040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x3c080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x3c080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x2e 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2574,8 +2584,9 @@
 		reg = <0x00 0x141e0000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x3e000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x3e040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x3e080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x3e080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x32 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
-- 
2.17.1

