Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C450A62C8B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiKPTFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiKPTF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:05:28 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139DB58BCC;
        Wed, 16 Nov 2022 11:05:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZVf28xhgxE3QJes6fC/xPGJKnhe/Ero0KmMprlLwMLYEbKyjh0A0e3rdqniyu37CtO93s2/bELe78SpahzNS0pwxre2p1uuOFIBydNA6Acg75IPx3vwRjzmgJg5Ct8p11QdXotcnB6dJKRpDwtsNXKE452UqwHJfnZTRDXgJ+p5qPaA3xAz5OIcjmycyeM6miawN5kJk99t1dUxQArq8RDV1+0rx58qNIGakM1NRc7kKe4ygjQ8vunJfMxeEooh+ATN7Hq1o3VYdM9nllXN9RnEOF+Re8/F9I0zSyLdletimAuneSxvKrjIQ9/dAsWVfshAgQlSH0hWlni4VSPIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+SV89ez17ISJdVQU7OeoYBfsdskAaJl2aofCLJnnjg=;
 b=ZQjQdm5CYoUXKzQsjhf+UcuzS8ipMjsojd949bEYCzXc9FD+nf1fwpOtyUn3fssxoCjMoz2qiC9nlf47JZrTPzRzfw4GeS44Ziau2MCSNveSB5/9Gdgbw2HxMj7qRxWlT502Vdj805GgaHUcwA1r5SyNi8B8nOn22d/lypBFsVR3F2IFIno2oyFmD7F4R87Ho6LFYyybZI7AsFPWHhzWuSB5O7PeMQyMkK+UXPvHTFY9MEMkQI7Y/PCV0Hsg9NnFxAyBdrG88cnUA+CjX8uhU2HyVZZTnej1PNFAPf5tA3vVy5ExN7jVxYClG/RmwKuLfLuLjCUhJnEVCf557PPoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+SV89ez17ISJdVQU7OeoYBfsdskAaJl2aofCLJnnjg=;
 b=nGLr3ORXwk0Rg08NS9eF2CmFf1HXg7Fqbq62pJXcorkvg3wsD2bh4ja1PRFF0yHaAkSzNlcDOee1zzLX3u6HYHn/SCv+8Al1ZaJTR5F8AzxMDbwXJUeH9GkUFF4aubT5Xydw0M1+kazt1T+3O/Gkp854p6rB5YG8m7rz+1em/aYgfrgOWIsoFbAxOpLMu1zg1TXqLKOt1sCVmOQqs3ENaH711e1bRRRnmrRV1E/OxWrNWoM9LJdZA8ELJeKnK1b/p6iXHrwxIy9akQVf5y+RDph7eAkoNYJLQssaoaRwsdBu5SAvMrkRliKhRkx6UuieP8yvyDpWPUvRUMxjsWqqsg==
Received: from BN9PR03CA0676.namprd03.prod.outlook.com (2603:10b6:408:10e::21)
 by PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 19:05:25 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::c9) by BN9PR03CA0676.outlook.office365.com
 (2603:10b6:408:10e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Wed, 16 Nov 2022 19:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Wed, 16 Nov 2022 19:05:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 16 Nov
 2022 11:05:11 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 16 Nov
 2022 11:05:11 -0800
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 16 Nov 2022 11:05:10 -0800
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <suzuki.poulose@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <sfr@canb.auug.org.au>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ywan@nvidia.com>,
        "Besar Wicaksono" <bwicaksono@nvidia.com>
Subject: [PATCH] perf: arm_cspmu: Fix build failure on x86_64
Date:   Wed, 16 Nov 2022 13:04:55 -0600
Message-ID: <20221116190455.55651-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT062:EE_|PH0PR12MB5451:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e34e7fb-ff6b-4065-36ff-08dac80584d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ck91oTqE/EViz5W5MpD94lgGi8Iu5pdMTRnK+MtLG9U8ijn1m7YAWrTXdSrP2TWQNp1x/Dr8HcrLevtx7eMkHGMXwJmuNNgnr7hh/kT5v1xqVFHqTqtgVJ8RknIEqp/cDi+tOVo+pPjQPk5iAWg2gTuFu77b6q9k/5LEblweQi6y+6wrR/4BCBaZpIi5LPGTiPOo9cp1P9gImfW+uIBteo/8AMcWZflVYTgvW2CGAmTsJavW2mK5gC28L4ZLX1GPQN61prHYhIRQcX9WmYDk4vOu6N+HMlbZiToOJr0kqVUHMK6380rTpj/rhweIgc7Yt0KsdbFPyi5AtFqVianLo2nvaTPbuY2m6J6CX/YXA0OWovbRSproLJzfyxCsKotPnM7BP6JyC1Q0QStQdV3SgBaRMrzO6aiRG2Ft0VSEbCMs8Nz2V5tx4lWhpFeG8Cko+929pWCnZIWxQTdULR1mqfTrpQafiKIphM8hgBo128DnqDplAIU3+H2UO8lGiXTw1ICo3Vabtbl/WQpZ3qkDm9dsyB7EzEMF8fGVaQHnXRnQTn4ESs8MzK/rFWSNbYM3TFBKhnlf9ekT4QZ2Zokra6xeNEUsXCXGS4BFXQqr4xtAS7QrpMvdRrzSN3lAkJwXKG2DdKuMh2KOB4EXDFBwDGos5D6DyVlCRiipbaMH6npwWnXhyy3eZRT4ItDv1BS0uyq1DemdPL38T0+QvvdwZPhH9yStbkECyrmBGIpCddUZrClHH5qRmPod4yw7MJDTJa1hegSJCv0CLMgO2+fLSw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(356005)(5660300002)(7636003)(2906002)(40480700001)(8936002)(4744005)(8676002)(70586007)(41300700001)(426003)(83380400001)(47076005)(107886003)(36756003)(6666004)(70206006)(7696005)(336012)(26005)(186003)(1076003)(36860700001)(82310400005)(86362001)(2616005)(478600001)(316002)(110136005)(40460700003)(82740400003)(54906003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:05:25.3338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e34e7fb-ff6b-4065-36ff-08dac80584d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5451
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building on x86_64 allmodconfig failed:
  | drivers/perf/arm_cspmu/arm_cspmu.c:1114:29: error: implicit
  |    declaration of function 'get_acpi_id_for_cpu'

get_acpi_id_for_cpu is a helper function from ARM64.
Fix by adding ARM64 dependency.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 drivers/perf/arm_cspmu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
index 058223bef661..0b316fe69a45 100644
--- a/drivers/perf/arm_cspmu/Kconfig
+++ b/drivers/perf/arm_cspmu/Kconfig
@@ -4,7 +4,7 @@
 
 config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
 	tristate "ARM Coresight Architecture PMU"
-	depends on ACPI
+	depends on ARM64 && ACPI
 	depends on ACPI_APMT || COMPILE_TEST
 	help
 	  Provides support for performance monitoring unit (PMU) devices

base-commit: 9500fc6e9e6077616c0dea0f7eb33138be94ed0c
-- 
2.17.1

