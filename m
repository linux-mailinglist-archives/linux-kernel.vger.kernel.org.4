Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9554473858E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjFUNoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjFUNoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:44:20 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5597E6E;
        Wed, 21 Jun 2023 06:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwBvBZyjSF23cVUbPGO8OWlZGT7O6XGQKM0VcD1iyyWCYWO7sok0r5wcF++MmUYlhWGPMrfFRYgp48nkAXHJ2YfQ1ul0s6IWuJ1fQtJOdOxQM2eFcMho2im/+++25alup+b74xVcCJacsPHB0abLktkR6c87IQUAkK0pW9zOIGpnuX5usVSCD9TMYSXFoOnNQFoL2CmWsFKhm8GFQ64O9PQj5xMokuXS9of20wdDBTVghhr06m0a3aegfwi/Y4uGzpTWd6zz0rrt7v36EYWfDo3zD3zqxocgEY0qScLqTs+FziFiYQIElR8OmmVqugaKu8pufCyQaUCYkoqxx+bqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibABgDKSNz3uNA72AN/RcL5CymtEHl0cRwB9EHjxoE4=;
 b=J2eNJ3ZRgeuJaljgBFV2ADcJcZzEpoL5CXv8W54phCgAKuacChbxfWK0XryQoI3ZDWXyPrIU8hc2sn7RsJm/j/gihpowFuT8IXKgea+lSj61qvJ11Q+2FjBHk+MNkD1MEF8ChzHZAysjmRAk4h/nbVNbZ5bvWcIPrIpTR0DbrghKzuUQZ3bQvMH2H5EhzvQdwEMwC2QARqoRBK2MkhKHujoa273yvCEFo3FaYC985AUxcuGevFtrSafSgOv58qSG4P0HtX0c00wRSEcjeAiL2VGkZ4+MZ5I8gogL+1yXhpNEgUgSknw4xp4ekq9maKjHQjb/5U11beHGXEQuqMbeEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibABgDKSNz3uNA72AN/RcL5CymtEHl0cRwB9EHjxoE4=;
 b=iHWL1woSIpbK9+z9ZSajbOcWwI5S8AVg+lqsOaVkxlb253PowESIYUEcL/LItpvoNGOJ+MDGZ++frE1wb9f96km0JNN5jp5RriFuL7chnh+6fWzdoUKF6yv8xWAuxgnQi+dUPFbRN1jf9cfhakIJ5x/DbtG3eTTKZ44Di0pEFidbBfBNTRU9FDcAsQvLtpIbk83U+xl+5Q1GR4bgpyYPbgKgIa0jez0DQSdjSoOsbZIlaXvn21bdwD5SwN4S2vVLn021UVSfhtNvT5u3vOkJBZdf+aSUnHo3+Xa6eTYoxMYx67xvuYj7Lnj6Y0rLBT1WVZG8TEWzeTDt+T09heFcEA==
Received: from SA0PR11CA0037.namprd11.prod.outlook.com (2603:10b6:806:d0::12)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 13:44:16 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::2d) by SA0PR11CA0037.outlook.office365.com
 (2603:10b6:806:d0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Wed, 21 Jun 2023 13:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 13:44:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 06:44:10 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 21 Jun 2023 06:44:09 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 21 Jun 2023 06:44:07 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <talho@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch RESEND 1/4] memory: tegra: sort tegra234_mc_clients table as per register offsets
Date:   Wed, 21 Jun 2023 19:13:57 +0530
Message-ID: <20230621134400.23070-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230621134400.23070-1-sumitg@nvidia.com>
References: <20230621134400.23070-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f26f89-4be9-4041-6ab7-08db725d9b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXTrn/PmFHRSIW5uZjZ9CKZC8uM2QOEY7lrx+8cofp1h/aJu+5tmyUK6aNUKw2cQzEGIhNY1UkpVNTq6ULCQ5tAPHAgVriDX0V+2VgNVFtSrGhgWcEaKw5eDK3tPU8WwzAJ1TEgKeXmh5qyu9sxfDVGfSZ42T0K/0wzLZzUQ9eAM2SB1EgkZI1JgMXsbUQ1WAwe4ZbgthUfSHYW9FQo+OnIeG9f+Lal2sGqcVhEL9d7zSb4EfJ+xtaAWniAAx1SO2lq13ESxUHM4KjYg/56rPG3WkN8Ih421Rj+PS8ntbEX4g1665fbuxDgbCjgqhqpq9+jp0LjJObeeDJ0X9VXKraH6usOKo8FeUreuIEvN7s9nHKpoDvp1V5wlATiiIQXsx3gA+ueQJklCE5jQ9zZd5vbir5DDIXnH5rgwIMb0JUidqPhlIIRBWA9oNK+u2mEhFBKZIl3XxwV/gYFZ38byzcCbSl3Yym7FZFacnIJPHe9NhLb20jubN1T/dBWnIj/9BrYcPMtB/njvlaMJ7FTzrmLm/uNN5aVTrenyPzm1IojRYYUz8mTJUecWb18gaePJO/QvwwLKaxbm8AzbtWfe67/Ttp2+13LeA/YOE8WIDw6CkyUSSSWMsJ+7qvSC6dMuHTIAizi39F0gJd75AJ9IWXyGD7UDJfGaPZHc3US5meFL5HjZcRDPVP+DOdf2dUK7ms+HRpumZmqMFFW/bnaodQlV6QiYfCVN9Fvkc6AlLE99lSEBioFn40j8crxMXiFA
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(336012)(83380400001)(82310400005)(426003)(2616005)(8936002)(8676002)(41300700001)(4326008)(70206006)(5660300002)(70586007)(316002)(40460700003)(86362001)(36756003)(26005)(186003)(1076003)(107886003)(82740400003)(47076005)(36860700001)(6666004)(2906002)(478600001)(30864003)(7696005)(40480700001)(7636003)(110136005)(54906003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:44:15.9827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f26f89-4be9-4041-6ab7-08db725d9b00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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

