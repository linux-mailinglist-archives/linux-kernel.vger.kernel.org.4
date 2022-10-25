Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E324460D389
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiJYS1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJYS1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:27:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A0DEF5B9;
        Tue, 25 Oct 2022 11:27:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6WVIzaqA3+uCedrx81PI+qGqI9/QzfZsVCqDlo+DxO3N0H7V7TOhHRyS+4EGEoSRDHtVo4uKN/5A8EsBZZ2jdGiZYGu+Mlg11he7mnL8h2weflUZWg95W2tbtROluOdQavuWRzoKbOq3a4VIHwdSbEYuagkC844/stIVqeU70xVtBQQCfmhZTkFifZOxST0A/NbDcNY61bZ9S8iZrQocHEdXvtydpjSMCTu+WB9Pub3YxRugMDfu4MMZ1771Zh+ww5jZq8Ih5C9vE7ml6dCYMa5pKVEHj46s9zGSAOdgZLaSYykaeX/xkWdlVHaXdCMLKYZT1BcEJhJ2JiO+vMEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6ea6zUkMImFRVSquFdYu6dFGgJe/P7KtfzpaacCThA=;
 b=AgYgmn3GbUE377hH5DAOHESUOV8UeZnJ89zs0x3GXk50nhsdeeVJhT0bgyJpuCTtGGPqRQ6VhsOdrJKnOaeHgI6h6APgqZdWpyFHf8FRymVrKfCMQep64hg/M4p9Jubr4f6lBKz2PiR04pM5KMNj1pJG6/EpbDOTQmINjL69JRg+drsjIaK1QfY0B0AiRSj6tuWcVBc5CtRf2tBFdfLHySl7bTXCmSfUDczCIAwCs41PDKhaYW5699OYEYgI+iEIxULO0Dt8Gu1RSDX2HEdInBTjqG41y7T7avyJF8neoa2XliedN+AsGlPlbqeH2cdpuz4sInbBjCJPzIKPhih58Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6ea6zUkMImFRVSquFdYu6dFGgJe/P7KtfzpaacCThA=;
 b=uizSUinKffqXQM/9SopXr7PeiJU2HcXXDJ92XCFCwGIDS+RHKu/E8sb0GK/TD37AxjM5/UfYWH40P2u0J5kaDOzR+CZ80Zcrcc6VUKQhUjuC2sTZzHEF1kbc6kn4ub8bSbG2Im4CN1NkQ0QOWkGSk17GXPkTSHFo+5ewuNTDhalbiorQ2R8jAVOr7k2h5OIUSWeaKRVu4ST+v3wQk9ggbP/xwHLeRHxFJChKqQ+4ErapvIJc3zP5xWfnyiWy9KynTouTzTkkEYbb57PnfXmOlAen6RheF7wA0+bdCAhflKW9DBK3awTEqmszoYE1iLV0mjdioTP2IgD2qav3JeARSA==
Received: from BN0PR02CA0007.namprd02.prod.outlook.com (2603:10b6:408:e4::12)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 18:27:28 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::bd) by BN0PR02CA0007.outlook.office365.com
 (2603:10b6:408:e4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Tue, 25 Oct 2022 18:27:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 18:27:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 25 Oct
 2022 11:27:11 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 25 Oct
 2022 11:27:10 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 25 Oct 2022 11:27:07 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mperttunen@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH] arm64: tegra: Add ECAM aperture info for all the PCIe controllers
Date:   Tue, 25 Oct 2022 23:57:04 +0530
Message-ID: <20221025182704.13029-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 590d66c1-8dc8-426c-2317-08dab6b6926b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5rfgng4mqDVsPfiQrRgehWny/MORA7Hj34tJrqKjYeTdihMzlbB7K8eJlysf9pNklh8dAZ+WmkZaklt8jGspMa8CirrSsohtGhEkJRZSzrPZhO283IOn+xUQiTdLgQzvyXqo7KBLkN/NZsfOfKmbbl6p3DirmjKr/IrNIzGA8KYkLZ/q/ntewh5mImvmOdm8M8/64agfRgbQZ/KOgqjT4SFNRAcoAAu02cyUKkZ3qKMkrlZuMUaHyA5nIIl1w1vTHaAVFWgdx/r04XCuzkj2vgGmQXVCfXt6mQtAhLJerOBVwG1HdByBJz3qypQUZ8TF9mr6RWTs4A73xg8D3mPiaW9YLxtTayxpplpY5C4aBG1iVI2105q16IhULBCJML42k0ZqbDXWGOs9TeLM5Ic5oJz+o7KJBfz1VZRiRswZosWSv857SqxO2kbJFqh7LhHE0j+Mcb0GoMb3ce2V3+/3E1FwSTtMk3yBeywz4J4NrX3v0A3NrE+7GwhgYSMawQEYvGHFijwErtYDq91oq7xm30duDZwlD5qa+9vIbXxkYptttijqwo/nL4TGRycGYL275Aot1YId6VFZ8rjZK4FD5VFLU2bSxuveOfITuRA6h2ZNLyWObMzqp4cKL2RuNWr5N2OxctXwpxLt0JUvxzZBkc8zyhgAqvTHpsddmtps3rOfrtKVbW8i9ebMpyRaxUFyNovJ3BlRawFBW21cE50eG5CXGTfd3/oQOncT9TafTZNtVpNNu+mCUvvU5tk+i1EjMjpq8kN/Xf/1TPLjXF+/g==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(7696005)(336012)(2616005)(186003)(1076003)(426003)(26005)(36860700001)(6666004)(47076005)(83380400001)(2906002)(5660300002)(8936002)(40480700001)(40460700003)(6636002)(54906003)(110136005)(82310400005)(4326008)(70586007)(8676002)(41300700001)(70206006)(316002)(478600001)(86362001)(36756003)(82740400003)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:27:28.1113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 590d66c1-8dc8-426c-2317-08dab6b6926b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

