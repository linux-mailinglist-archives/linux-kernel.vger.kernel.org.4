Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E3460D382
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiJYSZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiJYSZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:25:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC15E8C6B;
        Tue, 25 Oct 2022 11:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxkZaaysgNLMaCCtox0UyGyieRnRRcAQpMAzZJHyGtJP2PJwUeyqBXQOHOfC8QiijXsV9xB+8YHB5roipMnTGifR/0uqTalMCeD+/Zi+FlYxcUr2hwG7F+cv4pSswYURzgkPOLBqWMTe1OjuVD+20tJ3NbGhXkZ0WN1gJP8npvuSyxFg0DGrILBK2T/blYcNrvXlwMueoGTMYxCA3xmSGFqgEtBXxwA8M2ixdXr2PkCGCjXbya9aQhck+DV0zdwjAXqq9+Qw/Bc+pyk4p4JjEvWJJGPf0NYAIXCdQwl0iAVDwhBOD2BA/UOOaLVkaP4IYieQD/WP4ylvV2V6/222Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/EpMgctLAuasImnw1cb05gvryCcjcH+QQgTQg/PixE=;
 b=E4XWVXZY9eWi/o0aHTjz87Fq5W0AXvFX68/tjIGzw5H99zjWMUKOLxWl/Y+qmJf0vfWHVrRH9+gMN3q4wfbgU6Wz+ym/xNfRh2TtXrOkzchrlIiQdQRv3NXDmgFVmzm36xm2KAI74wuVTEQ4QTHZwS7ho+aAAFmCwszeNmBbbAJZkedK1sRsCIU0MPNjNHdPZTus7VQnk6836FAGf701EaUM3cwe7KcIX7UIQVAy7Uf0oSIVCez9gfXCv/4FjijPngN10UBwMI+8aAU/Cg6S+4vwSac7KDBPz4xFE0ySEXdioMrGZz+okDnaAuQHdwujdlDB9ZfxbO/98UsDK2teWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/EpMgctLAuasImnw1cb05gvryCcjcH+QQgTQg/PixE=;
 b=pI+4atrNtC26cJVRO/sBDfQg3GD/CDCFkXVcgYyQKY15xw3103A4aQyzNfk3DhLegKbUCODILIlXE5pB6M8tZSKvN430FsZ/pnnj7NkRheaiovTj7M1mOylLW2+LTup8sbsAO8UdI9zHbh8SorfD3+sDCCsM12/yx0VMTrq6HUfBlHBb4LDMDMf0z4IaDaLb403KfFdpa4kjcQJRpNjHEK4hJI4Nk1JM0MMHIAWzjubQE0KdU5ykZCM+L/1IfffUVXuRJQU8Ul2ZbpDCLPi20UjyxZRjlf03mLuEVAnK7PyTu5m9z7XjsMdSzKetnjouij4iYpuW8PVHcN6UuoSMVA==
Received: from BN9PR03CA0181.namprd03.prod.outlook.com (2603:10b6:408:f9::6)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 18:25:29 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::12) by BN9PR03CA0181.outlook.office365.com
 (2603:10b6:408:f9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Tue, 25 Oct 2022 18:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 18:25:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 25 Oct
 2022 11:25:15 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 25 Oct
 2022 11:25:14 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 25 Oct 2022 11:25:11 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mperttunen@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH] arm64: tegra: Fix non-prefetchable aperture of PCIe C3 controller
Date:   Tue, 25 Oct 2022 23:55:08 +0530
Message-ID: <20221025182508.10687-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT053:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: 248484b5-b6f8-4dff-705b-08dab6b64bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0fISQ/T1nc3EqRkL+g2TedmizQAqtC5QdKJ1ZJpGYYLJHR4tzaf3Qu3k9arQeQac5OtxJB1+ySniBoWCwO0mE7eOoc7C1tWVJ9/17F7I08yHSPkVXSKC+5dKLO1YFOdaRjuKifp2Mo5UvkIx37QHhXwNkbR1i8Nr8KSGItjRDex1JsbpklcrIdOmCZv2ZlfZcz/GHr32qZrchTTr4+lXNtTkSeKItHNOsNdJ5yuWOG9d5ko3dRWN9hDAu97YCIgJQ2Hf6emQULxmBDoSymGCHyJlqTND/mhglUhGzlKCG6JgPkmke9HxgOcfmOHRR9qFGQiqU018yspiiJ4cJcX/lrtQcEmJ7KZnM/VBtLv8dBK90+ongLdrY2KJJheRcFcEIn3cc3ySUsENZ5luGt0k2XoTw1gPX6qfWs2aClZ1Vq/B0vO504IUslo3l3ipJN4ztYiZrLEelIoZK4nyUiVQfGnrauanBoDNlN7xHG1fSbwWVmPBpRDbeAg0MIogmldTPGZkiSvuQ2w7t7A43Esb0La19mVXp4szQC3I00yR2XZPRxlnTF8Rjum3fTJJbn9/iC8SW+R/aOdx4ZWcgllvM1QYNECELAidwSZHBe/+SdhSVvdMnHSwqWKKRAWwoTZ3yc94Gq+/s6mMONyqHsSuMCMcw/Sfc1CgjmtaHC4EsWFrux6fScQX3ZZaT7BCwb0N+2RRDfulcXA+yYRAccqni9WRBhRatS7AGgdieKOeFYrzbFy1a5K0e8wmhl+W+lJv7ZNPdLMy1//3DtL2lfSag==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(356005)(8936002)(41300700001)(2906002)(5660300002)(110136005)(316002)(54906003)(36756003)(70206006)(70586007)(4326008)(8676002)(86362001)(6636002)(82740400003)(6666004)(40480700001)(1076003)(2616005)(478600001)(40460700003)(186003)(7636003)(336012)(36860700001)(47076005)(82310400005)(426003)(26005)(83380400001)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:25:29.4997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 248484b5-b6f8-4dff-705b-08dab6b64bb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the starting address of the non-prefetchable aperture of PCIe C3
controller.

Fixes: ec142c44b026 ("arm64: tegra: Add P2U and PCIe controller nodes to Tegra234 DT")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 5d7df32fd159..85b0dea33117 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -2343,7 +2343,7 @@
 		bus-range = <0x0 0xff>;
 
 		ranges = <0x43000000 0x21 0x00000000 0x21 0x00000000 0x0 0x28000000>, /* prefetchable memory (640 MB) */
-			 <0x02000000 0x0  0x40000000 0x21 0xe8000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
+			 <0x02000000 0x0  0x40000000 0x21 0x28000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
 			 <0x01000000 0x0  0x34100000 0x00 0x34100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
 
 		interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE3R &emc>,
-- 
2.17.1

