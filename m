Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A61652420
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiLTQDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiLTQD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:03:29 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE92C6372;
        Tue, 20 Dec 2022 08:03:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASR/zpdyGU58WuVIHJvFR4JYYGs54RQr4pY0pn4eJ1JGdWMnHhP8gq1vjUWtJbhluIT5MJG5xKL6mxXCKDloJTSOb26gAU6v08GFh+AZYVsEv+T5apq8gYmpnGnZznsnQlrMsn7UflsVJ6nC5PToV/qoyLJsKQAGFkuRtluxF07LvLE38+huRA1tmFxBUqp4kWw20lk0gkxlzv2y8wBvrpgIOS5loQuyl/mUyG36BEQ3p1ajctNe7MynRmLfqiL82K4sw0PMVKMi7YDbLLtOHF0Qui+9OGoJ282u5kgV/QTD/6epbhdCEJTCXUDs0TNwfg56kYC2PgT8irclr3xXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhMSgxATmR+4it38bYM1L1k2HXbBm2ivcoeA8x76BNg=;
 b=PYTKmVRkPUdOmi7UTKGtCrnIgkh6OC93FaCZDTf2LTbmncDAtkQo+e2A9SB/PqTP1bIhQIP5idApershJnkzb15iI9hoKHQcbXGPpQLrZhOjD4fYGAB5JLYXa4jU5zGXAjjVPa5+gpFaU35OaKsbdt56G+ncegqp+LCk9oxTh30vF3w0LeeXJjD9t+kHe54cXKh3iNf+Zj21Cfza/gEiI1T9VYz2WV9npFhvQr1Gyq5w+9pa2QHGn6yX5QwmjNbc35hmSGCN759qnEud5kWv6cHcvv4THS+u+mP/WUvoUSUUKkwOThTvKLYgiScwz2W8w5L6LWZu1Nn7PhN+ew+H8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhMSgxATmR+4it38bYM1L1k2HXbBm2ivcoeA8x76BNg=;
 b=cnkJF6ay39ejMxBiLU74gM9Zlriy+uBVlagXQJ5ozE7Qf9vKnZnRVUTmW25yP7KMeUCSDM8eiDOuSPCFGEXGqzCjzj/V+wyshi+TWYRyGJ9uiUGS7ONGBMtKy0JJqY/pm8uSeBAGaPL2ujRrodL+HSaF2uMGtFoSOzJ+iSw3dp8M2s2Ea9j4NEvuR0rKQV3uh3Oef0L5NLTeq/sdbkHYy/veAPeppg4TLpCsEr3UHqA7gNVqNoll+cmI45jS5/w73VMj6e/8yJfyYYFCa8JcGc0TubdCicINo5l4IJ+1Riz73eGg3RB+8C63oQXYWrxnGuHDyau6abSV1m7CWWzNPQ==
Received: from MW4PR04CA0120.namprd04.prod.outlook.com (2603:10b6:303:83::35)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 16:03:27 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::fd) by MW4PR04CA0120.outlook.office365.com
 (2603:10b6:303:83::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 16:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.6 via Frontend Transport; Tue, 20 Dec 2022 16:03:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 08:03:16 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 20 Dec 2022 08:03:16 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 20 Dec 2022 08:03:12 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v1 02/10] memory: tegra: adding iso mc clients for Tegra234
Date:   Tue, 20 Dec 2022 21:32:32 +0530
Message-ID: <20221220160240.27494-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221220160240.27494-1-sumitg@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT013:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b4a30b-d3a9-43b3-6e1b-08dae2a3baed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWVUruIHguJl4hjE25jlO8AHz76vCtgLce1miDx/GyrguMvjDGAlvb1rSFYFkTVKhEq+k++7RrPMgAMZeuZ391w0m1DWGIYJMQ3y9olGC4G0NxxzCelN0JLdZzv/T+1TKs2etT8d99+o4ITA2QCfNF8k8shvuiB/XPVgxxRJ0tj2wBqKOeVLBA7hK+HH/iF1zD8uD6eyBMb/aeWMHSY94FQBIANvoCa5HokqmmUjuRXWTJ6nZFZ9s6jTzMLzpOVVcmYeh6P5OJyviWypgA5yxxlwRanT8APnbKnvJPuqUuG4adkfOwzsQhuiyCUohrNyZT/FZJnxyPQZB/y5cHzRxY888Y73kuf6C5MA7CIh5vGDkRzyAJx/h3aDH4Wqk5YnwB6UfLcbbdO4c32Tk/EvhtuWxF4cjimajS6YnGEzMRSwrQmMULozR76VT8AJeAdzQ+VPiil4lPdMYpjMJ5dK65JNVVZ53FS3nhF7tsXkgEprQ/NL9YEyB9dWqFUWAWd+/xFPjcmB/hj11VT7v/O7/B6J+WsBbmQ8eS3KKpAYJ2RuRUrgNue+XE7MLgmwe6VjtgY73CjwepgfravdT26USyRLVKCMBkr6WEHklFYuAJs+FTOfFIGO0NWeLvZSqjDuFH7+8pP8ER8U+/ugg6kr6kEhohVXZO0ut7aT1PBig6bwtaeMP6iMVYEFxVC/VS7VRGWP4PXXao/L3coZ6ox44z6jI74SpW/yzmKr6l/xEPE=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(6666004)(47076005)(426003)(5660300002)(8936002)(107886003)(40480700001)(83380400001)(26005)(186003)(2906002)(41300700001)(336012)(36756003)(921005)(82310400005)(356005)(40460700003)(7636003)(110136005)(36860700001)(1076003)(2616005)(70206006)(70586007)(478600001)(316002)(82740400003)(54906003)(7696005)(4326008)(8676002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 16:03:26.9234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b4a30b-d3a9-43b3-6e1b-08dae2a3baed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Isochronous (ISO) MC clients to the mc_clients
table for Tegra234. ISO clients have guaranteed bandwidth
requirement.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/memory/tegra/tegra234.c | 108 ++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 65d4e32ee118..2e37b37da9be 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -14,6 +14,30 @@
 
 static const struct tegra_mc_client tegra234_mc_clients[] = {
 	{
+		.id = TEGRA234_MEMORY_CLIENT_HDAR,
+		.name = "hdar",
+		.bpmp_id = TEGRA_ICC_BPMP_HDA,
+		.type = TEGRA_ICC_ISO_AUDIO,
+		.sid = TEGRA234_SID_HDA,
+		.regs = {
+			.sid = {
+				.override = 0xa8,
+				.security = 0xac,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_HDAW,
+		.name = "hdaw",
+		.bpmp_id = TEGRA_ICC_BPMP_HDA,
+		.type = TEGRA_ICC_ISO_AUDIO,
+		.sid = TEGRA234_SID_HDA,
+		.regs = {
+			.sid = {
+				.override = 0x1a8,
+				.security = 0x1ac,
+			},
+		},
+	}, {
 		.id = TEGRA234_MEMORY_CLIENT_MGBEARD,
 		.name = "mgbeard",
 		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
@@ -133,6 +157,90 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 				.security = 0x33c,
 			},
 		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_VI2W,
+		.name = "vi2w",
+		.bpmp_id = TEGRA_ICC_BPMP_VI2,
+		.type = TEGRA_ICC_ISO_VI,
+		.sid = TEGRA234_SID_ISO_VI2,
+		.regs = {
+			.sid = {
+				.override = 0x380,
+				.security = 0x384,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_VI2FALR,
+		.name = "vi2falr",
+		.bpmp_id = TEGRA_ICC_BPMP_VI2FAL,
+		.type = TEGRA_ICC_ISO_VIFAL,
+		.sid = TEGRA234_SID_ISO_VI2FALC,
+		.regs = {
+			.sid = {
+				.override = 0x388,
+				.security = 0x38c,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_VI2FALW,
+		.name = "vi2falw",
+		.bpmp_id = TEGRA_ICC_BPMP_VI2FAL,
+		.type = TEGRA_ICC_ISO_VIFAL,
+		.sid = TEGRA234_SID_ISO_VI2FALC,
+		.regs = {
+			.sid = {
+				.override = 0x3e0,
+				.security = 0x3e4,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_APER,
+		.name = "aper",
+		.bpmp_id = TEGRA_ICC_BPMP_APE,
+		.type = TEGRA_ICC_ISO_AUDIO,
+		.sid = TEGRA234_SID_APE,
+		.regs = {
+			.sid = {
+				.override = 0x3d0,
+				.security = 0x3d4,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_APEW,
+		.name = "apew",
+		.bpmp_id = TEGRA_ICC_BPMP_APE,
+		.type = TEGRA_ICC_ISO_AUDIO,
+		.sid = TEGRA234_SID_APE,
+		.regs = {
+			.sid = {
+				.override = 0x3d8,
+				.security = 0x3dc,
+			},
+		},
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_NVDISPLAYR,
+		.name = "nvdisplayr",
+		.bpmp_id = TEGRA_ICC_BPMP_DISPLAY,
+		.type = TEGRA_ICC_ISO_DISPLAY,
+		.sid = TEGRA234_SID_ISO_NVDISPLAY,
+		.regs = {
+			.sid = {
+				.override = 0x490,
+				.security = 0x494,
+			},
+		},
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
 		.id = TEGRA234_MEMORY_CLIENT_BPMPR,
 		.name = "bpmpr",
-- 
2.17.1

