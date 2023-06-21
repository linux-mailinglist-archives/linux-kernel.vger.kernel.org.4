Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF71B738557
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjFUNgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjFUNf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:35:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272AA1981;
        Wed, 21 Jun 2023 06:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzFWq583LYgLAeHdF3wR/m947y37mOrfvh1oGC1C86qui26/dZeopn7uZySxjogMm5fOYqirz/NkeUM0I1Fs1LtE5NZVZpQVBDOD61hHO12SnVWRoBqio6G0+nc2ii3lkYi3kFnhzPwagOVEWT5SxvK8eqMbXRW6s/V5GwgAKCsALWkKHX8TgNjtb/6U2MDYh8vw/QWADctrj/5SFfr8EbhpdOaZPMcj/DOklk2neu/AZ2j6F+vlMGZlF3BpH8T+aP6RR4mnGp6lvEaR0rgUAhXkys9rcFoGvEFURHf86s6MlXxM9G1IdhApFyDCKo5tqBB7M73B2buOs4ipIehT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibABgDKSNz3uNA72AN/RcL5CymtEHl0cRwB9EHjxoE4=;
 b=OVcKyg6EZNChGNx/qko+1rz8UDQqW0zLX9Y972dSdPQu1rQXe4+Llrat/kGyKV9sn+qc2ZnVjMW64rvNeu1PQo8nkvRHLrwW782P6YtJgNxqm5t5nJ8AqMyBxJOefbxxtROPxXwUcHZ/QQ3dcZLsTXYA6weK3p5osTyc9KwTUfguOXdH67Q/qhZw+mO6Se/f0DvdkQrShjuaSTPWmIhSu4yjAAbwXtmTHym2UKtnh9XjTN2ORSMjVtDOdG2mgmvsU7hi//rR4P8yW7pJZTGHQdp0C7r7/9KxlqihCBzhdp5PkjhkdgJqAPKkseY/0lG+hTF1ZMcCjbgNtZa4GK5rSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibABgDKSNz3uNA72AN/RcL5CymtEHl0cRwB9EHjxoE4=;
 b=PXcUWaE8vNpJsz5QyF2iLp/gh7xSIwkpyKc+Vl51PPKbw2L9/eIpu1liD3HQmnD3KyIkQcBvGxBkvmz5zTYMLOYh9eaXfY0QSVj25tthkxRZIU3WPQCI57fkzgOrqFpWR0egd+CJAAeiZO7GWvkQngcSii8127CuuW1hqhjdyuk7cBWq0Q8YBNEWODFoSQWQF82boUqbsH2sMk0crsDV5bqQT9ks6jeP+8ltbQI8yzjQEzikza18GMzW17tHNBMq6kdCtBHUdZB4i7+mObQKWtYvhQ1RwDk0NUDLrQA72KQlq3nfmQ+5/nlPTSLVNH43xlbfDHPKEofBjlZzyalwQQ==
Received: from MW4PR04CA0307.namprd04.prod.outlook.com (2603:10b6:303:82::12)
 by MW4PR12MB7333.namprd12.prod.outlook.com (2603:10b6:303:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 13:35:50 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::6e) by MW4PR04CA0307.outlook.office365.com
 (2603:10b6:303:82::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 13:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 13:35:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 06:35:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 06:35:36 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 21 Jun 2023 06:35:33 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <talho@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch 1/4] memory: tegra: sort tegra234_mc_clients table as per register offsets
Date:   Wed, 21 Jun 2023 19:05:24 +0530
Message-ID: <20230621133526.22492-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230621133526.22492-1-sumitg@nvidia.com>
References: <20230621133526.22492-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|MW4PR12MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c37faa4-952b-4d7b-89b1-08db725c6d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSygYxAyd8Z2O2aZs8Ma0LBS0ffauV/tVl8ywvvY8CN+y8INRB2RuybI3h683g3zdIX8j+GxZkD+8DqN0W23rXm+Dmry/mDXqPThs63dHUK+2D8cqOJCDCB8OrF8tqThJzIXRm67XwtHLiR/tQJN+vAvRnqVaA9f+0FjuG3xDa6bd1kCtweyMdqshL5cEZNUyNlv31+u9LyjPFTGg93OxXADWLDMkkuMDMDkod2BL6VVRrRhltUEPzF3EZGYdZm/9bVEVD0cfaJV4dhYjrOLohVXii7AvnW7R4q9gTgxiLo/L1C1PGdibsz/z/N5nas0SvR8bpq1HBTwDuEikCAiRka8Ibole5GlhgpkjyLvIOsN9il40sKMXn5mV9veJxdrlCeV5vzHk+Ln9AMhLxxXfih71SqSnksMGHmLEimfSMB1FYSJzDrgF1yln7ra6OWmbAVK35kwVrkx2g17BRC90xtVRbpKR/TLjcFImxly3a+znUQ2bsQ7gv+xtxf7vKwLQ77HnrX61YtkIIIIQpk975LoEr1ipuAORzXv6UXO9Z1YcW8cAFozX9QN9X6xQuBhVGHYO1dS7YGPEbLQdJj2IBlUq0YChEau0zBwdDQQt8jlysodjCZIgmxdklsZBCg4j/V7q/sBB/ra4lyLkPNMAwDTXufChnmfta+AmFnVVT8tA6xC6smBn3X5TGX+QW22uvcPnR0EqnOaduoJJA2TIVNT7abWpxQhkK0KGwdC75dgMUMWnZdqPsCfq9z84Eux
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(54906003)(110136005)(26005)(41300700001)(1076003)(186003)(7696005)(6666004)(478600001)(70586007)(70206006)(40460700003)(4326008)(316002)(40480700001)(36756003)(336012)(5660300002)(8936002)(36860700001)(107886003)(8676002)(47076005)(2616005)(2906002)(86362001)(82310400005)(83380400001)(30864003)(356005)(7636003)(82740400003)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:35:50.1061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c37faa4-952b-4d7b-89b1-08db725c6d7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333
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

Sort the MC client entries in "tegra234_mc_clients" table as per the
override and security register offsets. This will help to avoid
creating duplicate entries.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/memory/tegra/tegra234.c | 514 ++++++++++++++++----------------
 1 file changed, 259 insertions(+), 255 deletions(-)

diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 8e873a7bc34f..3e44efe4541e 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -12,6 +12,10 @@
 #include <soc/tegra/bpmp.h>
 #include "mc.h"
 
+/*
+ * MC Client entries are sorted in the increasing order of the
+ * override and security register offsets.
+ */
 static const struct tegra_mc_client tegra234_mc_clients[] = {
 	{
 		.id = TEGRA234_MEMORY_CLIENT_HDAR,
@@ -25,6 +29,106 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0xac,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE6AR,
+		.name = "pcie6ar",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_6,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE6,
+		.regs = {
+			.sid = {
+				.override = 0x140,
+				.security = 0x144,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE6AW,
+		.name = "pcie6aw",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_6,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE6,
+		.regs = {
+			.sid = {
+				.override = 0x148,
+				.security = 0x14c,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE7AR,
+		.name = "pcie7ar",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_7,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE7,
+		.regs = {
+			.sid = {
+				.override = 0x150,
+				.security = 0x154,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_DLA0RDB,
+		.name = "dla0rdb",
+		.sid = TEGRA234_SID_NVDLA0,
+		.regs = {
+			.sid = {
+				.override = 0x160,
+				.security = 0x164,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_DLA0RDB1,
+		.name = "dla0rdb1",
+		.sid = TEGRA234_SID_NVDLA0,
+		.regs = {
+			.sid = {
+				.override = 0x168,
+				.security = 0x16c,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_DLA0WRB,
+		.name = "dla0wrb",
+		.sid = TEGRA234_SID_NVDLA0,
+		.regs = {
+			.sid = {
+				.override = 0x170,
+				.security = 0x174,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_DLA1RDB,
+		.name = "dla0rdb",
+		.sid = TEGRA234_SID_NVDLA1,
+		.regs = {
+			.sid = {
+				.override = 0x178,
+				.security = 0x17c,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE7AW,
+		.name = "pcie7aw",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_7,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE7,
+		.regs = {
+			.sid = {
+				.override = 0x180,
+				.security = 0x184,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE8AR,
+		.name = "pcie8ar",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_8,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE8,
+		.regs = {
+			.sid = {
+				.override = 0x190,
+				.security = 0x194,
+			},
+		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_HDAW,
 		.name = "hdaw",
@@ -37,6 +141,102 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x1ac,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE8AW,
+		.name = "pcie8aw",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_8,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE8,
+		.regs = {
+			.sid = {
+				.override = 0x1d8,
+				.security = 0x1dc,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE9AR,
+		.name = "pcie9ar",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_9,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE9,
+		.regs = {
+			.sid = {
+				.override = 0x1e0,
+				.security = 0x1e4,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE6AR1,
+		.name = "pcie6ar1",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_6,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE6,
+		.regs = {
+			.sid = {
+				.override = 0x1e8,
+				.security = 0x1ec,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE9AW,
+		.name = "pcie9aw",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_9,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE9,
+		.regs = {
+			.sid = {
+				.override = 0x1f0,
+				.security = 0x1f4,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE10AR,
+		.name = "pcie10ar",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_10,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE10,
+		.regs = {
+			.sid = {
+				.override = 0x1f8,
+				.security = 0x1fc,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE10AW,
+		.name = "pcie10aw",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_10,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE10,
+		.regs = {
+			.sid = {
+				.override = 0x200,
+				.security = 0x204,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE10AR1,
+		.name = "pcie10ar1",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_10,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE10,
+		.regs = {
+			.sid = {
+				.override = 0x240,
+				.security = 0x244,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_PCIE7AR1,
+		.name = "pcie7ar1",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_7,
+		.type = TEGRA_ICC_NISO,
+		.sid = TEGRA234_SID_PCIE7,
+		.regs = {
+			.sid = {
+				.override = 0x248,
+				.security = 0x24c,
+			},
+		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEARD,
 		.name = "mgbeard",
@@ -157,6 +357,26 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x33c,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_DLA1RDB1,
+		.name = "dla0rdb1",
+		.sid = TEGRA234_SID_NVDLA1,
+		.regs = {
+			.sid = {
+				.override = 0x370,
+				.security = 0x374,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_DLA1WRB,
+		.name = "dla0wrb",
+		.sid = TEGRA234_SID_NVDLA1,
+		.regs = {
+			.sid = {
+				.override = 0x378,
+				.security = 0x37c,
+			},
+		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_VI2W,
 		.name = "vi2w",
@@ -181,18 +401,6 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x38c,
 			},
 		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_VI2FALW,
-		.name = "vi2falw",
-		.bpmp_id = TEGRA_ICC_BPMP_VI2FAL,
-		.type = TEGRA_ICC_ISO_VIFAL,
-		.sid = TEGRA234_SID_ISO_VI2FALC,
-		.regs = {
-			.sid = {
-				.override = 0x3e0,
-				.security = 0x3e4,
-			},
-		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_APER,
 		.name = "aper",
@@ -218,27 +426,27 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = TEGRA234_MEMORY_CLIENT_NVDISPLAYR,
-		.name = "nvdisplayr",
-		.bpmp_id = TEGRA_ICC_BPMP_DISPLAY,
-		.type = TEGRA_ICC_ISO_DISPLAY,
-		.sid = TEGRA234_SID_ISO_NVDISPLAY,
+		.id = TEGRA234_MEMORY_CLIENT_VI2FALW,
+		.name = "vi2falw",
+		.bpmp_id = TEGRA_ICC_BPMP_VI2FAL,
+		.type = TEGRA_ICC_ISO_VIFAL,
+		.sid = TEGRA234_SID_ISO_VI2FALC,
 		.regs = {
 			.sid = {
-				.override = 0x490,
-				.security = 0x494,
+				.override = 0x3e0,
+				.security = 0x3e4,
 			},
 		},
 	}, {
-		.id = TEGRA234_MEMORY_CLIENT_NVDISPLAYR1,
-		.name = "nvdisplayr1",
+		.id = TEGRA234_MEMORY_CLIENT_NVDISPLAYR,
+		.name = "nvdisplayr",
 		.bpmp_id = TEGRA_ICC_BPMP_DISPLAY,
 		.type = TEGRA_ICC_ISO_DISPLAY,
 		.sid = TEGRA234_SID_ISO_NVDISPLAY,
 		.regs = {
 			.sid = {
-				.override = 0x508,
-				.security = 0x50c,
+				.override = 0x490,
+				.security = 0x494,
 			},
 		},
 	}, {
@@ -305,6 +513,18 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x504,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_NVDISPLAYR1,
+		.name = "nvdisplayr1",
+		.bpmp_id = TEGRA_ICC_BPMP_DISPLAY,
+		.type = TEGRA_ICC_ISO_DISPLAY,
+		.sid = TEGRA234_SID_ISO_NVDISPLAY,
+		.regs = {
+			.sid = {
+				.override = 0x508,
+				.security = 0x50c,
+			},
+		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA0RDA,
 		.name = "dla0rda",
@@ -335,26 +555,6 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x604,
 			},
 		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_DLA0RDB,
-		.name = "dla0rdb",
-		.sid = TEGRA234_SID_NVDLA0,
-		.regs = {
-			.sid = {
-				.override = 0x160,
-				.security = 0x164,
-			},
-		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_DLA0RDA1,
-		.name = "dla0rda1",
-		.sid = TEGRA234_SID_NVDLA0,
-		.regs = {
-			.sid = {
-				.override = 0x748,
-				.security = 0x74c,
-			},
-		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA0FALWRB,
 		.name = "dla0falwrb",
@@ -365,26 +565,6 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x60c,
 			},
 		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_DLA0RDB1,
-		.name = "dla0rdb1",
-		.sid = TEGRA234_SID_NVDLA0,
-		.regs = {
-			.sid = {
-				.override = 0x168,
-				.security = 0x16c,
-			},
-		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_DLA0WRB,
-		.name = "dla0wrb",
-		.sid = TEGRA234_SID_NVDLA0,
-		.regs = {
-			.sid = {
-				.override = 0x170,
-				.security = 0x174,
-			},
-		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA1RDA,
 		.name = "dla0rda",
@@ -415,26 +595,6 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x624,
 			},
 		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_DLA1RDB,
-		.name = "dla0rdb",
-		.sid = TEGRA234_SID_NVDLA1,
-		.regs = {
-			.sid = {
-				.override = 0x178,
-				.security = 0x17c,
-			},
-		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_DLA1RDA1,
-		.name = "dla0rda1",
-		.sid = TEGRA234_SID_NVDLA1,
-		.regs = {
-			.sid = {
-				.override = 0x750,
-				.security = 0x754,
-			},
-		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_DLA1FALWRB,
 		.name = "dla0falwrb",
@@ -445,26 +605,6 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x62c,
 			},
 		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_DLA1RDB1,
-		.name = "dla0rdb1",
-		.sid = TEGRA234_SID_NVDLA1,
-		.regs = {
-			.sid = {
-				.override = 0x370,
-				.security = 0x374,
-			},
-		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_DLA1WRB,
-		.name = "dla0wrb",
-		.sid = TEGRA234_SID_NVDLA1,
-		.regs = {
-			.sid = {
-				.override = 0x378,
-				.security = 0x37c,
-			},
-		},
 	}, {
 		.id = TEGRA234_MEMORY_CLIENT_PCIE0R,
 		.name = "pcie0r",
@@ -610,171 +750,35 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 			},
 		},
 	}, {
-		.id = TEGRA234_MEMORY_CLIENT_PCIE5R1,
-		.name = "pcie5r1",
-		.bpmp_id = TEGRA_ICC_BPMP_PCIE_5,
-		.type = TEGRA_ICC_NISO,
-		.sid = TEGRA234_SID_PCIE5,
-		.regs = {
-			.sid = {
-				.override = 0x778,
-				.security = 0x77c,
-			},
-		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_PCIE6AR,
-		.name = "pcie6ar",
-		.bpmp_id = TEGRA_ICC_BPMP_PCIE_6,
-		.type = TEGRA_ICC_NISO,
-		.sid = TEGRA234_SID_PCIE6,
-		.regs = {
-			.sid = {
-				.override = 0x140,
-				.security = 0x144,
-			},
-		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_PCIE6AW,
-		.name = "pcie6aw",
-		.bpmp_id = TEGRA_ICC_BPMP_PCIE_6,
-		.type = TEGRA_ICC_NISO,
-		.sid = TEGRA234_SID_PCIE6,
-		.regs = {
-			.sid = {
-				.override = 0x148,
-				.security = 0x14c,
-			},
-		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_PCIE6AR1,
-		.name = "pcie6ar1",
-		.bpmp_id = TEGRA_ICC_BPMP_PCIE_6,
-		.type = TEGRA_ICC_NISO,
-		.sid = TEGRA234_SID_PCIE6,
-		.regs = {
-			.sid = {
-				.override = 0x1e8,
-				.security = 0x1ec,
-			},
-		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_PCIE7AR,
-		.name = "pcie7ar",
-		.bpmp_id = TEGRA_ICC_BPMP_PCIE_7,
-		.type = TEGRA_ICC_NISO,
-		.sid = TEGRA234_SID_PCIE7,
-		.regs = {
-			.sid = {
-				.override = 0x150,
-				.security = 0x154,
-			},
-		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_PCIE7AW,
-		.name = "pcie7aw",
-		.bpmp_id = TEGRA_ICC_BPMP_PCIE_7,
-		.type = TEGRA_ICC_NISO,
-		.sid = TEGRA234_SID_PCIE7,
-		.regs = {
-			.sid = {
-				.override = 0x180,
-				.security = 0x184,
-			},
-		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_PCIE7AR1,
-		.name = "pcie7ar1",
-		.bpmp_id = TEGRA_ICC_BPMP_PCIE_7,
-		.type = TEGRA_ICC_NISO,
-		.sid = TEGRA234_SID_PCIE7,
-		.regs = {
-			.sid = {
-				.override = 0x248,
-				.security = 0x24c,
-			},
-		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_PCIE8AR,
-		.name = "pcie8ar",
-		.bpmp_id = TEGRA_ICC_BPMP_PCIE_8,
-		.type = TEGRA_ICC_NISO,
-		.sid = TEGRA234_SID_PCIE8,
-		.regs = {
-			.sid = {
-				.override = 0x190,
-				.security = 0x194,
-			},
-		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_PCIE8AW,
-		.name = "pcie8aw",
-		.bpmp_id = TEGRA_ICC_BPMP_PCIE_8,
-		.type = TEGRA_ICC_NISO,
-		.sid = TEGRA234_SID_PCIE8,
-		.regs = {
-			.sid = {
-				.override = 0x1d8,
-				.security = 0x1dc,
-			},
-		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_PCIE9AR,
-		.name = "pcie9ar",
-		.bpmp_id = TEGRA_ICC_BPMP_PCIE_9,
-		.type = TEGRA_ICC_NISO,
-		.sid = TEGRA234_SID_PCIE9,
-		.regs = {
-			.sid = {
-				.override = 0x1e0,
-				.security = 0x1e4,
-			},
-		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_PCIE9AW,
-		.name = "pcie9aw",
-		.bpmp_id = TEGRA_ICC_BPMP_PCIE_9,
-		.type = TEGRA_ICC_NISO,
-		.sid = TEGRA234_SID_PCIE9,
-		.regs = {
-			.sid = {
-				.override = 0x1f0,
-				.security = 0x1f4,
-			},
-		},
-	}, {
-		.id = TEGRA234_MEMORY_CLIENT_PCIE10AR,
-		.name = "pcie10ar",
-		.bpmp_id = TEGRA_ICC_BPMP_PCIE_10,
-		.type = TEGRA_ICC_NISO,
-		.sid = TEGRA234_SID_PCIE10,
+		.id = TEGRA234_MEMORY_CLIENT_DLA0RDA1,
+		.name = "dla0rda1",
+		.sid = TEGRA234_SID_NVDLA0,
 		.regs = {
 			.sid = {
-				.override = 0x1f8,
-				.security = 0x1fc,
+				.override = 0x748,
+				.security = 0x74c,
 			},
 		},
 	}, {
-		.id = TEGRA234_MEMORY_CLIENT_PCIE10AW,
-		.name = "pcie10aw",
-		.bpmp_id = TEGRA_ICC_BPMP_PCIE_10,
-		.type = TEGRA_ICC_NISO,
-		.sid = TEGRA234_SID_PCIE10,
+		.id = TEGRA234_MEMORY_CLIENT_DLA1RDA1,
+		.name = "dla0rda1",
+		.sid = TEGRA234_SID_NVDLA1,
 		.regs = {
 			.sid = {
-				.override = 0x200,
-				.security = 0x204,
+				.override = 0x750,
+				.security = 0x754,
 			},
 		},
 	}, {
-		.id = TEGRA234_MEMORY_CLIENT_PCIE10AR1,
-		.name = "pcie10ar1",
-		.bpmp_id = TEGRA_ICC_BPMP_PCIE_10,
+		.id = TEGRA234_MEMORY_CLIENT_PCIE5R1,
+		.name = "pcie5r1",
+		.bpmp_id = TEGRA_ICC_BPMP_PCIE_5,
 		.type = TEGRA_ICC_NISO,
-		.sid = TEGRA234_SID_PCIE10,
+		.sid = TEGRA234_SID_PCIE5,
 		.regs = {
 			.sid = {
-				.override = 0x240,
-				.security = 0x244,
+				.override = 0x778,
+				.security = 0x77c,
 			},
 		},
 	}, {
-- 
2.17.1

