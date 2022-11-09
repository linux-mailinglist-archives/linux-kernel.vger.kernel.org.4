Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0222B6223F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 07:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKIG06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 01:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiKIG0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 01:26:53 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9701D312;
        Tue,  8 Nov 2022 22:26:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/UEASmRlNMJAChaC5JBRuAtO/mYgFg+ZvjCdJ9vmMvIYXfykQahxjsktDwKk7QtdfXBHuxrqnLso3bGnWXiInWXMmYVungKzvYASIQKkFohBqaSigLwnsye5p6M6HF3hSC1fWV8qDdD9I4CiomTYOhNXyAoke2bn7QrGYBfCg01TcvsResIvOuJ7Oc5n6TBZYdh4IAvfWxlXP6JgLKVs/94KTlRElY7vDcxDvWL+GvvukyUSVDB4AbYyenPciKICgqG2gOIT1FfjF7DVEZ1zNmFFTL1Z+nzcUEWqmmgtOkCgxEX7b7RYV8vdW7q39jPT0iq73vP7WH663wzOXeSqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vrEhv1zGM42Ruxyfv4OtAna5fT54ysKvsEIDLietOg=;
 b=Yyg6dzveGyxu1DBpa9hiYx8pWCQld+WflOxe8WPOQTBCZQa6QKrgAAba/FKcnT8vLxiUge8RHw0ZDo5ZIe88PcrsS9jXwOQFm5eywC4AVXRC0XaIcRq42ao1c0syycbYmNnsJWq43Zum6ZlohYwum12gA1u8GgaKmB0df+Kq5IntDhcYyXd0TZCC9nRWijvvPl1NivIbrySo3AfG/n0xe4Jo3qoBk8Wmtl3sc20w6JdAVq0N1C/j/yVc2oPbb5N27sk0RDa30hOx9GDXBRrBe3Nu3e+cdda76l06Dzl7yDnQMaZ6XK6cp+eSWDifagfcHFOcRdR/nbd2wbUL5nRwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vrEhv1zGM42Ruxyfv4OtAna5fT54ysKvsEIDLietOg=;
 b=WDjGjSQvwi/I8IdsB6sEjgSFSMLuqcK7vN035WXE+3TB32B0cGnWHN7oBFGj5yKTYenrE22NhgL6xlVyP+lifAf+ztE/M3kPmA2m/7N+2QQMNzAVF35ahOC9AZKKfIIlShRRh41RRsguIBoU32W2TVuVLpwnwgAyHYCiLd7GqoOvmbjoXjJYKAiGvomfpfjWlnrSSy4ztBW2vYyNrwlLpYWSx29cDr3+GfzFwUzD9wkXx5vQTQLAOTjxFe2Oj6W10rnOyKWVtLuNvtp7eNwjC6louo+cxLdSZfr8Gn7SDwTObzBctIyS0KrXFFL+MIJhTXMygrVChcboUn1vymVz5g==
Received: from BN9PR03CA0329.namprd03.prod.outlook.com (2603:10b6:408:112::34)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:26:50 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::78) by BN9PR03CA0329.outlook.office365.com
 (2603:10b6:408:112::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:26:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.11 via Frontend Transport; Wed, 9 Nov 2022 06:26:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 8 Nov 2022
 22:26:24 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 8 Nov 2022 22:26:23 -0800
Received: from kkartik-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 8 Nov 2022 22:26:20 -0800
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kkartik@nvidia.com>, <digetx@gmail.com>,
        <ndesaulniers@google.com>, <ulf.hansson@linaro.org>,
        <arnd@arndb.de>, <skamble@nvidia.com>, <windhl@126.com>,
        <sumitg@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] soc/tegra: fuse: use platform info with soc revision
Date:   Wed, 9 Nov 2022 11:56:19 +0530
Message-ID: <1667975179-11136-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C409:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: ca2df8b3-6658-4615-df88-08dac21b62d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jKC/WSQ6n8vB9kbUOWhh6MybAeVHaixgBl8xkQQhuZ1E43yCkeoIC5oikCZUfiHyINYx2JMIuNF8JdGbNMECzF9nSAJ22+xdQHcQYtYvnXoGiqbjIiW4+yoiJDX27FGOgEh4DJ72ITP8v7VhJdytvFChWucJToGcj09LQn0D8qsrD8Cpg1eIRp0Tkwe81L0CL6i5JmPcUYMrZ4UhWfO2Fn0KmoP5FkhUZRfv1OMM58wwFjbbdUrS/ekPQgoc8fWRWYHoh8knA/IM+6QdzjG9R2I2QPSxtMy5rweGBdPtF4dwY/biG7fwiLsIr8CxD3oQ13lRmIVXZ56wQBuhqV0eyqRTKavGKee2sdM40irEtDyv7hnyfqpdL/56n3WZr3ElIKN++8rUAXQNOQsp7LdjpouTduXB2iASkqEQlDs+wxo5/wCayzymZWxCbGSjBneQGnSc/DJ2+pT34PVAyRqoB3fEI96kn6S/yN1CApS+oyohIO6EB6Sl2QtEvmR9VBHxUOEBfaxJr/qAf4UTQOBfiOQxIp4P/WQj6mg7yIkD0hqRC0q0l0Jcp5+K9zY/pGzcotv+UDpwOIvqsxR1UMx82xb9WYnXyJcU2RPE5Hjt7yoSp9Wri4XAOXrROTZMiz31xuhOU38bzPTOJxOWmeVW3Po1iXE6SWb8Ikpl/7MrDEGuiCQUnkZTCJHpU72akgVbMT1Ckfif4VGUbIWKJ1aQi7bZBr7dsR63L+8YZIwLsvugziaracnnfEm2OMtMP1j+OoFSlZqmfeukh83lb6uvuBaHfOmEK6ZVjYssBLD7vME=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(8676002)(82740400003)(70586007)(70206006)(316002)(7696005)(40480700001)(336012)(47076005)(426003)(36860700001)(40460700003)(83380400001)(2906002)(41300700001)(86362001)(26005)(5660300002)(186003)(2616005)(36756003)(8936002)(82310400005)(478600001)(7636003)(110136005)(356005)(921005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:26:50.2076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2df8b3-6658-4615-df88-08dac21b62d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
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
v1->v2:
 * Updated commit message.

 drivers/soc/tegra/fuse/fuse-tegra.c    | 23 +++++++++++++++++++++--
 drivers/soc/tegra/fuse/tegra-apbmisc.c |  1 +
 include/soc/tegra/fuse.h               | 15 +++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index ea25a1dcafc2..a20c9e0105dc 100644
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
@@ -370,8 +383,14 @@ struct device * __init tegra_soc_device_register(void)
 		return NULL;
 
 	attr->family = kasprintf(GFP_KERNEL, "Tegra");
-	attr->revision = kasprintf(GFP_KERNEL, "%s",
-		tegra_revision_name[tegra_sku_info.revision]);
+	if (tegra_is_silicon()) {
+		attr->revision = kasprintf(GFP_KERNEL, "%s %s",
+					   tegra_platform_name[tegra_sku_info.platform],
+					   tegra_revision_name[tegra_sku_info.revision]);
+	} else {
+		attr->revision = kasprintf(GFP_KERNEL, "%s",
+					   tegra_platform_name[tegra_sku_info.platform]);
+	}
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

