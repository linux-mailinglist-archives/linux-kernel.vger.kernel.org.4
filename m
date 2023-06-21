Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8447A738592
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjFUNod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjFUNo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:44:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0DE199C;
        Wed, 21 Jun 2023 06:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDC8dycXV39y4QOvekvXa5ir0EyB2YNwogR7fCpipoec1lia7ep4k+RuY4G6zE5LOKmFE4HfCV+BwSu4rhZKx4ABHglSyV2LL92HuDcTk5wxlHrlds/s9RG8Vn7vs0jTdSoSUuX6oXeS9z5QCPvjwzcl9DhxmLrptmo7XiHt0AMEF+NmPDJUiifx403AJGdgYBlMyLtMYq2L6xhNtRWzvzzRiX7m5Y7b8+lb7oTPWyDuLqlCUfnXWaV00ieAPST+keSvg82RtOWs3Anez2qav/MXMNhYgMMJDLRxsWKahVacMNSTVC7S6GmizAKmK2awy/aM/MzForY0oyY+9r3mdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBCOPXy6SyMTkp6NTNnyOmwrucZGlcvZ/PgZCfxjlnI=;
 b=l+xEBhm7xBmVCzELz9af1d1onPqTiXHlsYXVjah5XsKLeR5yf6ipIKnQClHVaHqyesNX5xoyyYuVQ5PAnY5x7APAZ3h6De8Kdl2A8L3G/SGQSV2uYyfvFIqhmN5vrRpBkCvcMBqEk1eNA0H0FVGBpvLgaE1dBXMUoRSN5pLB8HuohhVGG2sGLxFxtC3oDO+bHHHQGhhxKE/XQNfkod//fxAIbJqlJ1lUbWKKWNaHkA1CNr9t8k922Np3RnuH3ISiFvIopnIa3OcK8q5/mU/I8sLGAMa2klZQ2c8zEaP76NjlaNo4pZoZuafoJtNMCcFXtjU9addMRxEHtH3Y0Rikjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBCOPXy6SyMTkp6NTNnyOmwrucZGlcvZ/PgZCfxjlnI=;
 b=UW4GqXA1pnPZ8UoKQGOai/nCZXsjofNqlUoxRPY4clvvtUjpGXwPbI+uuLbAdf8tSskQRV2SbPJ20Eo/WpmQ7es8jaqtzttt/rhoOR8SpJe+/mzTD7G3Yabmvr1rSLPTrdGtG6KyupLhfjvAFplgubJNyoFBiBONpVmg4OEmwNkqqJageF2Rf3RF/HfksumoilMGewpLtZG5s2I4Lh2mJm9ND3nnLkdOht7kRNiYoBjDVIU4xHCj9z3JumLgWk8Rs42IIGlC0rFDapiZilTFwyQwgiVuEsZPNtqSqna4JHLkzq1HGMjE6D7X/mh+8PhnPXb0h7v8WJcrWE/hIVxQPA==
Received: from PH8PR21CA0005.namprd21.prod.outlook.com (2603:10b6:510:2ce::21)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 13:44:23 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::d9) by PH8PR21CA0005.outlook.office365.com
 (2603:10b6:510:2ce::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9 via Frontend
 Transport; Wed, 21 Jun 2023 13:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23 via Frontend Transport; Wed, 21 Jun 2023 13:44:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 06:44:15 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 21 Jun 2023 06:44:14 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 21 Jun 2023 06:44:12 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <talho@nvidia.com>, <sumitg@nvidia.com>,
        Johnny Liu <johnliu@nvidia.com>
Subject: [Patch RESEND 2/4] memory: tegra: Add clients used by DRM in Tegra234
Date:   Wed, 21 Jun 2023 19:13:58 +0530
Message-ID: <20230621134400.23070-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230621134400.23070-1-sumitg@nvidia.com>
References: <20230621134400.23070-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 8389b1b6-317d-4415-070a-08db725d9f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsECdCaMGRZ9KDkoQ1qQ9mAYXcDJzwPJMVPHkWIiY+GCZ30PrV34Po4x81mW77MCLq35SzGDjShlZNULkn300QQUtS2RSxlnML4gfqHN/x2+wxuo9DC86SsvvnJB4zA1D1BzidAFc7EG9s/Ujir6BcJ3BPtqCrQ+aNZWir1JIX7KMp65SpRGcL4SaDm1Dq32g6mufzuvOPfVrNo8mdJMy6rA9du/CE7Fxy6IBYE7dgF9wAUWnCAGQFcGyKqVCNChUEkz3alTshxgY6GJbsSTvhFyLtHGb3w0dCzG80GeZQfe/uID+H8BOG/VfUBbz1+4FRNb70aMMkjbXnMU5KHEwiWxqsbCvBEMd6bjUcfbNw5MPt8/JaUdZKbpqIb4CsHXZKL2OcCA5tnbjwb4+lYJwmTeuXbJLHK8Fkj8J1yt5hQPsYKGKndOcTmI2Yt0W1AIJLSzwbWpXQ//Vy7WubHPlUqC8EnmT2SjrsonJPGkP1IZH59ASGoI8YTMO+SEwVN3UUlFwnhzSKbyIXLry252Y7s4dphXrA6dnTnb8xXiFZNedGOm0Vn3tB54sndh9dBspWKiIMSeo8ELxYGZAmJVxhU9EO/SbxboXBW2+UUUmUDIfVBr1VCRdWj8mZ5dOPaLRSGe4d3RcXVV5QxtyzHiFlMfyWgVk83Vrmokv255xvArJHdekW0CMA/bfEGd4alKOtZ0cvL104Ifh3ET8diMCxdwx6atAG+FnH9hqZ5y0Mpr2t0GX/ETvCAZrQ2NDFnI
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(356005)(7636003)(82740400003)(40480700001)(2906002)(426003)(36860700001)(47076005)(83380400001)(36756003)(86362001)(107886003)(2616005)(1076003)(82310400005)(26005)(186003)(7696005)(40460700003)(336012)(6666004)(110136005)(54906003)(478600001)(70586007)(70206006)(41300700001)(8676002)(316002)(8936002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:44:22.7894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8389b1b6-317d-4415-070a-08db725d9f0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries for VIC, NVDEC, NVENC, NVJPG memory controller
clients into the 'tegra_234_mc_clients' table.

Signed-off-by: Johnny Liu <johnliu@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/memory/tegra/tegra234.c | 120 ++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 3e44efe4541e..bc73be7fe143 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -29,6 +29,18 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0xac,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_NVENCSRD,
+		.name = "nvencsrd",
+		.bpmp_id = TEGRA_ICC_BPMP_NVENC,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_NVENC,
+		.regs = {
+			.sid = {
+				.override = 0xe0,
+				.security = 0xe4,
+			},
+		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_PCIE6AR,
 		.name = "pcie6ar",
@@ -65,6 +77,18 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x154,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_NVENCSWR,
+		.name = "nvencswr",
+		.bpmp_id = TEGRA_ICC_BPMP_NVENC,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_NVENC,
+		.regs = {
+			.sid = {
+				.override = 0x158,
+				.security = 0x15c,
+			},
+		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA0RDB,
 		.name = "dla0rdb",
@@ -357,6 +381,30 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x33c,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_VICSRD,
+		.name = "vicsrd",
+		.bpmp_id = TEGRA_ICC_BPMP_VIC,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_VIC,
+		.regs = {
+			.sid = {
+				.override = 0x360,
+				.security = 0x364,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_VICSWR,
+		.name = "vicswr",
+		.bpmp_id = TEGRA_ICC_BPMP_VIC,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_VIC,
+		.regs = {
+			.sid = {
+				.override = 0x368,
+				.security = 0x36c,
+			},
+		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA1RDB1,
 		.name = "dla0rdb1",
@@ -401,6 +449,30 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x38c,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_NVDECSRD,
+		.name = "nvdecsrd",
+		.bpmp_id = TEGRA_ICC_BPMP_NVDEC,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_NVDEC,
+		.regs = {
+			.sid = {
+				.override = 0x3c0,
+				.security = 0x3c4,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_NVDECSWR,
+		.name = "nvdecswr",
+		.bpmp_id = TEGRA_ICC_BPMP_NVDEC,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_NVDEC,
+		.regs = {
+			.sid = {
+				.override = 0x3c8,
+				.security = 0x3cc,
+			},
+		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_APER,
 		.name = "aper",
@@ -437,6 +509,30 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x3e4,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_NVJPGSRD,
+		.name = "nvjpgsrd",
+		.bpmp_id = TEGRA_ICC_BPMP_NVJPG_0,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_NVJPG,
+		.regs = {
+			.sid = {
+				.override = 0x3f0,
+				.security = 0x3f4,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_NVJPGSWR,
+		.name = "nvjpgswr",
+		.bpmp_id = TEGRA_ICC_BPMP_NVJPG_0,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_NVJPG,
+			.regs = {
+			.sid = {
+				.override = 0x3f8,
+				.security = 0x3fc,
+			},
+		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_NVDISPLAYR,
 		.name = "nvdisplayr",
@@ -781,6 +877,30 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x77c,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_NVJPG1SRD,
+		.name = "nvjpg1srd",
+		.bpmp_id = TEGRA_ICC_BPMP_NVJPG_1,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_NVJPG1,
+		.regs = {
+			.sid = {
+				.override = 0x918,
+				.security = 0x91c,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_NVJPG1SWR,
+		.name = "nvjpg1swr",
+		.bpmp_id = TEGRA_ICC_BPMP_NVJPG_1,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_NVJPG1,
+		.regs = {
+			.sid = {
+				.override = 0x920,
+				.security = 0x924,
+			},
+		},
 	}, {
 		.id = TEGRA_ICC_MC_CPU_CLUSTER0,
 		.name = "sw_cluster0",
-- 
2.17.1

