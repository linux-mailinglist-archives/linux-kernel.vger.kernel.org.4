Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491B66FF2BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbjEKNYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238185AbjEKNYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:24:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6B8106D2;
        Thu, 11 May 2023 06:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdLqIMouhhdqGRkagjmeoyU+qJSpeUDvrWP0DNj3M3v18G0kZ7PnpIjm8wk4YVKGzs816BnGlHfdwK2+hUOXYykemNlz+1rfSpnqfWKoxwTkKlCvwWWLOea0il89dxRLMtHX6zMtoFECSEU7S5efm3lebQACmiUopaTDfQ2NDyHw4FqwBbShsBms28u/aFI7Z9fCcYUcu8TAEhqcHBhvY5VKLueEido9i2rsWK0kP+ixPl43iktVaaicZe9oshhF6hdb0fQrgXCtJzl3gWdGY1MTuEzTCa8q++7YsupglgwutHw6knn3pZSEJIvaayGn2a9DWrZt7Q9Dy0eTele20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rxdj6f8c95lYWwdmu4mId02ODxGpHnyGoMss7/dYDI=;
 b=h6hpg4+/2qw21VejIQy2ktA+np6dFYR6dIuRw3rXDYSqUIuJRHv6n9iezBwnYoIyLbWbJTBX0xEpGGLehI7IBRCOP66DnNkhdDbvhYClbKXmgKNrsAt2+AJfIzmZ5DlDwGsag3irIzZUXxwwHpFuGfP8T2+z/xzZJze+1TwV5EFj+CDQr8yNt8MxOHfFIX2XPI6WvJoCm1HeTQ8+pK01p5WrX3j/Wcb+32ipzTVcPw3iNqW5DjOxqBo8PPibNB/346SSRL6jcLTsdxvU02pQW2SZp3aH8D+KLUer3U42reReU+VSPIY7ycchRY2lSV8v677kE86qru4Zq/n58APBEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rxdj6f8c95lYWwdmu4mId02ODxGpHnyGoMss7/dYDI=;
 b=C5xQCHKYpmwZgyZPhS2wwtnoFI+ucLNivGEYhm33liTVzfmAPcFsENVTCG284tl7DBrNzxTZalpwABLV2ZLEq3KNKsrSnYv89YzqKfFbaNf4zjPAcj3v67CIAuVGiq61XWCXDbhEx8ST5dC9Ul869qwrEnnsXw9QEA+O75Mf+EQfC+QwH5rR2edTAD5SdrT61ldfqb4xwm3tQ2b8mAFsnlCcfJ5pyFDVqZJaH7QEx0vcpX7YlGWJ2QS5pavheLLBSZ8Gu9t8+BMcepLJB/Ckz7AdU2yXyrO5cnprzeaJNstt2MX7VLQPe445lJszPZAsLFbNDpyjP2FN1K70cibPQg==
Received: from DS7PR03CA0008.namprd03.prod.outlook.com (2603:10b6:5:3b8::13)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Thu, 11 May
 2023 13:21:47 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::98) by DS7PR03CA0008.outlook.office365.com
 (2603:10b6:5:3b8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22 via Frontend
 Transport; Thu, 11 May 2023 13:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 13:21:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 06:21:34 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 11 May
 2023 06:21:34 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 06:21:32 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     Stefan Kristiansson <stefank@nvidia.com>, <arnd@arndb.de>,
        <kkartik@nvidia.com>, <sumitg@nvidia.com>, <windhl@126.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 3/6] soc/tegra: fuse: Add support for Tegra264
Date:   Thu, 11 May 2023 16:20:48 +0300
Message-ID: <20230511132048.1122075-4-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: cd00da0b-ad43-4309-8e8b-08db5222abaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akJni1JxLimMNEysEZfQXg/Y2M/Z97Zwx4VGIaVfrwsojPXTEE1r9hQ9YuN9vSzjH7IFC4RqHd2g3T/7zmFcEgh9w7+3btPBTBfCdlUy/3qFFkLb3pWwS06ayVCQeI+dN9T/eu0K+8PZjYVEpK75D9396/7M87hHSa3EmxO06O/z+Nx5KMDE4AIEUFIoDuD6TfThL+0uV7Nwk0469BN9KNvvp7vhAeIYirowSJWP5vvlFymAbT/GbREy3Lj1YyyIsppGc69BTN0FgumkAIuj0Jgsjz4pRzrcXdtTmWRrogDbG1XnIgGNbqN19upWw/4i07eYRBTxiPwq4s29Yb6KM7HSQXfaXniV8UFH5GBR4fshFLSho010/mHJFxKfu/jkFDzSs0TRv3iB/oYbbl+0VVOmr+93EKlKBuJwfotifQZ3tf4CjDgyhbe8ma4JEsHTDxjuDVW0+Yz4zh1Rom/8u44m5NITgr4JUGVGoQf8wiB4+DisZ4/LhGM0gEUS/MNMc0U0g19pl4xaJdTk9utN65WJfeA+lWClFIMP9Z19GOlPskJsxj5hFKXDKNsOhTBNv/RUYHM0O0SZ7pvAJpL6oWDRJnBDQdNM8KkS7LoiaqnfzQah7HsxTGM3Swz9/QQXZOD9MhPvLzUnbgAm26EWePFDehT1dc8q25sUiK9wehxh+YwyQhlYh/e7DLbz2M6euBM4SkrLoOCjaxqGjrI9qEBEUr5RSBQ8ECOr4YVkC3XS+1lB6COJNOzRalYU5/b7
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(186003)(1076003)(26005)(41300700001)(6666004)(7696005)(83380400001)(47076005)(2616005)(36860700001)(426003)(336012)(478600001)(40460700003)(110136005)(54906003)(4326008)(6636002)(82740400003)(40480700001)(70586007)(70206006)(316002)(82310400005)(7636003)(356005)(5660300002)(8676002)(8936002)(86362001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 13:21:46.4425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd00da0b-ad43-4309-8e8b-08db5222abaf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Kristiansson <stefank@nvidia.com>

Add support for Tegra264 to the fuse handling code.

Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 3 ++-
 include/soc/tegra/fuse.h               | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index 4591c5bcb690..eb0a1d924526 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2014-2023, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #include <linux/export.h>
@@ -62,6 +62,7 @@ bool tegra_is_silicon(void)
 	switch (tegra_get_chip_id()) {
 	case TEGRA194:
 	case TEGRA234:
+	case TEGRA264:
 		if (tegra_get_platform() == 0)
 			return true;
 
diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index a63de5da8124..3a513be50243 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2012-2023, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #ifndef __SOC_TEGRA_FUSE_H__
@@ -17,6 +17,7 @@
 #define TEGRA186	0x18
 #define TEGRA194	0x19
 #define TEGRA234	0x23
+#define TEGRA264	0x26
 
 #define TEGRA_FUSE_SKU_CALIB_0	0xf0
 #define TEGRA30_FUSE_SATA_CALIB	0x124
-- 
2.34.1

