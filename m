Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5D965243F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiLTQGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbiLTQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:05:54 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5C3193F7;
        Tue, 20 Dec 2022 08:05:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjFdNs/FCI3a52qVf9TwtCSCqK6IC7Ibn90VK1ZlAEwqwqScD7Nr62q3R08iyEq2v1Wlh9n1V3zUYsPYIocusaOPAqiMO5fovq8iBXSPOFg63IeexG42TSRM5irWMzuo0sY1tjyJvw0Gc44VhYW68JIGKtlSjrU7MvjqG507iXGAtAAYWyuoiF28j1liTn2qI2dIShkfT+EVn+48m5cA3ySI7wnC1GeM/oJVtPyWzvg69nrSjy5Asjlz05jARMWwgeqVMA/AbmE6yzQtCeZoE89FMorL3965OO2LKcYSZJpuQ5GXe0CzNG1XUesu3Ltht757OBBtFN+asVMuzdN7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayHXz0RFp/GJvsgROWUbEQSYUAeWvM24puZbQyCdLkg=;
 b=iBU2p6vyEGl8OBaeJlNE2+F4rELEAnVMCdHuJvQBpH1YPZCWxbhjzYJbFlEWN1Tq1Zcoet3QcUzVQzzz95h676sAZg38SXTHM3zRlbYEt/lHYgC3kqTlfsUmdw5YuoHGs1zhmeHEjyFTJO34mOYxrM9SX65EZzvVfGR2lBZluOjRkN0lVy6fZpI6NKIy2lW9MOl6jDpF0Hay+XL/D0JW7v819RvPLg8h+TGTZhJDSDmCKTCCyCBIap7DiemUxHjCTwCxWfMJVhxjMOWzew4PPGJpX/EeSFoPtA5n9Z4pjv2JZaMLgsvf0LEOnRCnLWePXDKxFOmc3tg5Y/OgvUg9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayHXz0RFp/GJvsgROWUbEQSYUAeWvM24puZbQyCdLkg=;
 b=ldeVJvZK6ZAB0998z49+fee1hwuRaDR0qiikvKqYvy9yZVTr09VmZGWAQvyvNLPE14ns1O2eCcK2CQQrWBgNQpFWJ4QlE5jhgeL/U2B8T7A0vpXvalQN4JD3kZDxIFijx0XOgtL4WO8ee48+/73w1t5ESW1aLC++Z2NRJg576BJbpBRWzZzE9h3+JOI2bGs3hrKQNaq2Yex3jijE1YhwqzBzXKq8o/25Xd6yrI+Ey0GxX3FG5YfCcR2sWqT+XTTg5IoCLo+57P26yyhBOWOk9+4WZGLkv9yZcAa07FVLZifR2LbtD/08Oqn6tPPs2ESdvLQNcCN/hw82CAPGOPBVTQ==
Received: from MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::10)
 by CY8PR12MB8363.namprd12.prod.outlook.com (2603:10b6:930:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 16:05:24 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::fc) by MW4P220CA0005.outlook.office365.com
 (2603:10b6:303:115::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 16:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.6 via Frontend Transport; Tue, 20 Dec 2022 16:05:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 08:05:17 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 20 Dec 2022 08:05:17 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 20 Dec 2022 08:05:13 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v1 09/10] memory: tegra: get number of enabled mc channels
Date:   Tue, 20 Dec 2022 21:32:39 +0530
Message-ID: <20221220160240.27494-10-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221220160240.27494-1-sumitg@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|CY8PR12MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: ce454167-ef3c-4bd4-1ecb-08dae2a400d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNVS4NY7b4MuR5YDbm2Xb1dAc6uDkmh7QQBpRhGI5wfgCN5mn+11oS0buPU5I/1O9EjlIkfc5s8kGPVeHB6RE7sTjsBxW9yGJhT1NMKcmTN3kg+Mvs8ucU1rObFJ+dCvVQ7u42rYosKl0ZgdLaxSXB6b2VJy+sh8gOOXC0KSrFPqbk2GmpteOvaYGLJxIXPvNrpAG23FMnI4gzCwzWeAsIpHGmY6VI5WExvdVNbcsPn/bZrm7zPKuASDc8gFZOiBQ2f1kz4AkzBO6txsu0ltjNnQSnyl7wW+zKGS/nz6GZEamd/PoTNDHVcWIb7aHO+pTpjBRpTSPVNIOgAFS5eHlOiSDnW9JovMBNOPIaPGfANI1wBqYN+aO1pk1FJCpUr7NO803X7UHqnhGeHWIRVFeqm0Ma1TxzTrIkM/8DkqKPBCTCb3oXDUtdRKi0+WTJsOCwA0vKWhF6Eg3kh7IkJBzRMPxWqWiV1RQ93vGQUnOpcnZbqGZKQwowUAYjqX7HxNimhuXOTV4jadVKohZSE4GLFkSNmN2xlZUrQomtxYtEQSLQfWmFOWISasf5KKY7XXmAFS27oS/3s5HkNKi7jzhLYNCmNkt636B+A5plxF/KJhK0ZJSvmaIbu3+JdtyoLGVSDGpoVDHpDwcnjvqRCL0SkqVKVFAXdlDefNJtqgFcCtVWthmDPK1w9WYLyp1XJKmVH61y7dGbOwb0rC+Y7SAlQChos2iPdTk9aRu2C/Mtu6YAZGRpgibhspb3RtZ4RR
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(2906002)(356005)(426003)(336012)(36756003)(47076005)(40480700001)(110136005)(82740400003)(921005)(186003)(41300700001)(40460700003)(86362001)(26005)(82310400005)(7636003)(8936002)(70206006)(5660300002)(316002)(4326008)(2616005)(70586007)(1076003)(8676002)(478600001)(107886003)(6666004)(54906003)(7696005)(358055004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 16:05:24.2086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce454167-ef3c-4bd4-1ecb-08dae2a400d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8363
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get number of MC channels which are actually enabled
in current boot configuration.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/memory/tegra/mc.c | 19 +++++++++++++++++++
 drivers/memory/tegra/mc.h |  1 +
 include/soc/tegra/mc.h    |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 4ddf9808fe6b..3d52eb3e24e4 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -881,6 +881,23 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
 	return err;
 }
 
+static void tegra_mc_num_channel_enabled(struct tegra_mc *mc)
+{
+	unsigned int i;
+	u32 value = 0;
+
+	value = mc_ch_readl(mc, 0, MC_EMEM_ADR_CFG_CHANNEL_ENABLE);
+	if (value <= 0) {
+		mc->num_channels = mc->soc->num_channels;
+		return;
+	}
+
+	for (i = 0; i < 32; i++) {
+		if (value & BIT(i))
+			mc->num_channels++;
+	}
+}
+
 static int tegra_mc_probe(struct platform_device *pdev)
 {
 	struct tegra_mc *mc;
@@ -919,6 +936,8 @@ static int tegra_mc_probe(struct platform_device *pdev)
 			return err;
 	}
 
+	tegra_mc_num_channel_enabled(mc);
+
 	if (mc->soc->ops && mc->soc->ops->handle_irq) {
 		mc->irq = platform_get_irq(pdev, 0);
 		if (mc->irq < 0)
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index bc01586b6560..c3f6655bec60 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -53,6 +53,7 @@
 #define MC_ERR_ROUTE_SANITY_ADR				0x9c4
 #define MC_ERR_GENERALIZED_CARVEOUT_STATUS		0xc00
 #define MC_ERR_GENERALIZED_CARVEOUT_ADR			0xc04
+#define MC_EMEM_ADR_CFG_CHANNEL_ENABLE			0xdf8
 #define MC_GLOBAL_INTSTATUS				0xf24
 #define MC_ERR_ADR_HI					0x11fc
 
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 6a94e88b6100..815c7d5f6292 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -236,6 +236,7 @@ struct tegra_mc {
 
 	struct tegra_mc_timing *timings;
 	unsigned int num_timings;
+	unsigned int num_channels;
 
 	struct reset_controller_dev reset;
 
-- 
2.17.1

