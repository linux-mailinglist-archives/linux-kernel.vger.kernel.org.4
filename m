Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982D4622DBC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiKIOWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiKIOWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:22:06 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6455327924;
        Wed,  9 Nov 2022 06:20:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4/FAnTsby+TKsm8zHfEbMNWSL612LBjafoC2+prys8Llcs73p3f+pcEoyjqW38WA5h/kuvUmiW2BYrCPhCGaP7UqxNM49i+sr5fq4rKAEYTL/7Lj6lVPxKksoY/p1HTONM+R+DAB98cWZ3/30s+tORXzVQs/9TcQ6/x/9tGeICsjPfN4cA/Wvj7HeZMtVQ+zYRD5KGKT7OJ2+KSrCXTBZrN1c0M3ljA/3skyvU0J101JD5D3PZlv88j1XDLQq/hfCHXSSLtCfYZtuzCtRcfFx0pccEK3mPXOwXf6dwwMSR2S6jqBv8MbIhRzkJ7QUr8dxlnkxf4Sw4M6xD267KchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/pwRwqFbdREWXUfvV27otWLxg1bps1dWM8OQ6j519M=;
 b=QKSc1EBCoiwNRwpk5EBG/N2b1pQjrdmw8pgk+cC4TLXQrg2IXIupqcXkdf85G0Oolh+i0bgxtKEgkr0rITLFE3zlKB5L4VgDCFa3KYuVUaORNRnepOiShwsgdOacMM1RcoQn7R2Lu6OQs2/jNCQjFdpID9urjufsIgcuFm3wM37ZFy2VcCypSirA3nZX+is1+BxOLCNMYpQ9UX0XL+dFBrQRpxaKUZsFGHAv/v8r7wBCPj6etlJCHFf11PEkSOP7NWxPXymZ/1Y3WfiAWLzSY79s8J05omA7QuBVD6EcijSnA6o30IEMVA3OeRFnov1cvSXSloP4Uiwe+FtCd5xAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/pwRwqFbdREWXUfvV27otWLxg1bps1dWM8OQ6j519M=;
 b=nNBOaH07mAxqYSPWhh6NWokfzqTiq5yiotaSzuwUtY1MuBRwKJSJNF4f0zIlqPEC9bCsD9rvW/IHWjyZyYAp7f7Jn6xXpi71T04HOCAmNvFCOHOr25kNUZsoV9Fpi8TCl5HKBWVFEVxjdnpclhVyqSVnoPQ2GxwGcjQYLSy1zE9lB/havs8/rdS0ih1GqlmWCVjf5LJV5Wv3ToR5EaQB82kTLm5GGL0ejMLHcW/BkYVFP2MlorAgH5d1ZwDefi0lSsqGeVxoPaoqQj0q7cQ3sMMfWY4Q9mZyuY4TD+jKIrtljmly25WQFZOsBUGL3+mOtne3t8Jm4OEWae8bPE8LMQ==
Received: from DM5PR07CA0066.namprd07.prod.outlook.com (2603:10b6:4:ad::31) by
 DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.25; Wed, 9 Nov 2022 14:20:39 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::f) by DM5PR07CA0066.outlook.office365.com
 (2603:10b6:4:ad::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Wed, 9 Nov 2022 14:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 14:20:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 9 Nov 2022
 06:20:27 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 9 Nov 2022
 06:20:27 -0800
Received: from kkartik-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 9 Nov 2022 06:20:23 -0800
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kkartik@nvidia.com>, <digetx@gmail.com>,
        <ndesaulniers@google.com>, <ulf.hansson@linaro.org>,
        <arnd@arndb.de>, <skamble@nvidia.com>, <windhl@126.com>,
        <sumitg@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] soc/tegra: fuse: use platform info with soc revision
Date:   Wed, 9 Nov 2022 19:50:22 +0530
Message-ID: <1668003622-13706-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: c4af4b1f-92c6-4d27-9427-08dac25d93a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJ9mjtfsi159f72SI5sWVgBgmL2SDaWx9qYBIvf3iVFrCak0lnXMpK2DsMLtotOdpWIXasLjL4yOeqRcYf5r0d715YyWUJM8WhOlAaAlfaE1MT2dUOwVICnZwPTqCEXT5kf8xG0nzM/iAovsdYU4GWORYChkfDryfkYR5gQjPeja8H3/VY3oop8+Jhfx5qh8KhwgO0c7QJIl9Uurhc9e/fvK6MvCq757wAdM5xAgEPTKEA5QbTfgSJRH8z3jJeTv00c+gHZ1Cbo7a61bwGrHLQ3f2Kgm/oPM4pKsMDBdZSX690oiMhgVls1P5xZH7k3tYY7PduYE54kKU/GW7kH76UP00+629594sc03Ll7T83tlkm7qAPLZkjkPe0zKWKi5GKLQd3zcVFLJ+RomMJCEC+eJ+HVy+3fUQVLIiJ1XEVTObZmYYPgywUd8WMOwvd06j5Z2Yvu3o310BZgh65Ik8nwjDVETFTvW3l+sWbs5vOqROkjX84MlOJWpcgWc7Vn0D2zf++ohVBOP2nmfpyY2F7eHikLoF4OfTnZp+0PYQCIkxEUC26KEmGugKr7VeUgyjDRI1zhZz1yaPzx94rBzE865cyiGQPCehldTivgY1VcNbkimdxhQpimT6D6WumksGXtIlj+7dk/H50hc8pC3dMU7Lu7WPBlRP/rpE+CkNAlFu/ozG+bHsnScjiKDuqo/Rlyp4vr89Vyok6VIF4KwAEG252ryU5rsaPDdSpOhLMaorsm0nu6Drv6PQZp84Vi14tjUy01j00NbnzDLFg4us4dxJ10idgNGPHZwUk5sGEo=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(82740400003)(36860700001)(86362001)(82310400005)(921005)(478600001)(8936002)(26005)(40460700003)(70206006)(110136005)(2906002)(316002)(83380400001)(5660300002)(186003)(336012)(70586007)(41300700001)(2616005)(8676002)(356005)(47076005)(7636003)(426003)(7696005)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 14:20:38.9658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4af4b1f-92c6-4d27-9427-08dac25d93a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra pre-silicon platforms do not have chip revisions. This makes the
revision soc attribute meaningless on these platforms.

Instead, populate the revision soc attribute with
"platform name + chip revision" for Silicon. For pre-silicon platforms
populate it with "platform name" instead.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
v2->v3
 * Cosmetic Changes.
v1->v2
 * Updated commit message.

 drivers/soc/tegra/fuse/fuse-tegra.c    | 22 ++++++++++++++++++++--
 drivers/soc/tegra/fuse/tegra-apbmisc.c |  1 +
 include/soc/tegra/fuse.h               | 15 +++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index ea25a1dcafc2..f02953f793e9 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -35,6 +35,19 @@ static const char *tegra_revision_name[TEGRA_REVISION_MAX] = {
 	[TEGRA_REVISION_A04]     = "A04",
 };
 
+static const char *tegra_platform_name[TEGRA_PLATFORM_MAX] = {
+	[TEGRA_PLATFORM_SILICON]			= "Silicon",
+	[TEGRA_PLATFORM_QT]				= "QT",
+	[TEGRA_PLATFORM_SYSTEM_FPGA]			= "System FPGA",
+	[TEGRA_PLATFORM_UNIT_FPGA]			= "Unit FPGA",
+	[TEGRA_PLATFORM_ASIM_QT]			= "Asim QT",
+	[TEGRA_PLATFORM_ASIM_LINSIM]			= "Asim Linsim",
+	[TEGRA_PLATFORM_DSIM_ASIM_LINSIM]		= "Dsim Asim Linsim",
+	[TEGRA_PLATFORM_VERIFICATION_SIMULATION]	= "Verification Simulation",
+	[TEGRA_PLATFORM_VDK]				= "VDK",
+	[TEGRA_PLATFORM_VSP]				= "VSP",
+};
+
 static const struct of_device_id car_match[] __initconst = {
 	{ .compatible = "nvidia,tegra20-car", },
 	{ .compatible = "nvidia,tegra30-car", },
@@ -370,8 +383,13 @@ struct device * __init tegra_soc_device_register(void)
 		return NULL;
 
 	attr->family = kasprintf(GFP_KERNEL, "Tegra");
-	attr->revision = kasprintf(GFP_KERNEL, "%s",
-		tegra_revision_name[tegra_sku_info.revision]);
+	if (tegra_is_silicon())
+		attr->revision = kasprintf(GFP_KERNEL, "%s %s",
+					   tegra_platform_name[tegra_sku_info.platform],
+					   tegra_revision_name[tegra_sku_info.revision]);
+	else
+		attr->revision = kasprintf(GFP_KERNEL, "%s",
+					   tegra_platform_name[tegra_sku_info.platform]);
 	attr->soc_id = kasprintf(GFP_KERNEL, "%u", tegra_get_chip_id());
 	attr->custom_attr_group = fuse->soc->soc_attr_group;
 
diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index 3351bd872ab2..4591c5bcb690 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -156,6 +156,7 @@ void __init tegra_init_revision(void)
 	}
 
 	tegra_sku_info.sku_id = tegra_fuse_read_early(FUSE_SKU_INFO);
+	tegra_sku_info.platform = tegra_get_platform();
 }
 
 void __init tegra_init_apbmisc(void)
diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index 977c334136e9..a63de5da8124 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -34,6 +34,20 @@ enum tegra_revision {
 	TEGRA_REVISION_MAX,
 };
 
+enum tegra_platform {
+	TEGRA_PLATFORM_SILICON = 0,
+	TEGRA_PLATFORM_QT,
+	TEGRA_PLATFORM_SYSTEM_FPGA,
+	TEGRA_PLATFORM_UNIT_FPGA,
+	TEGRA_PLATFORM_ASIM_QT,
+	TEGRA_PLATFORM_ASIM_LINSIM,
+	TEGRA_PLATFORM_DSIM_ASIM_LINSIM,
+	TEGRA_PLATFORM_VERIFICATION_SIMULATION,
+	TEGRA_PLATFORM_VDK,
+	TEGRA_PLATFORM_VSP,
+	TEGRA_PLATFORM_MAX,
+};
+
 struct tegra_sku_info {
 	int sku_id;
 	int cpu_process_id;
@@ -47,6 +61,7 @@ struct tegra_sku_info {
 	int gpu_speedo_id;
 	int gpu_speedo_value;
 	enum tegra_revision revision;
+	enum tegra_platform platform;
 };
 
 #ifdef CONFIG_ARCH_TEGRA
-- 
2.17.1

