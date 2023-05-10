Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7C96FDCD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjEJLhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbjEJLhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:37:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244C576A1;
        Wed, 10 May 2023 04:37:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQCdbEH+w2fhChNGTJ9IzeOj0w+hweTw3PG3Bz0WgSPicMTSgPJ2tQcfPuY7GxTI+0J+tJtmt9rgoFQ+x2B10/iYXjKNk2DppCv4mr8DmRcsHLVX8W9wMS4ilFZCLEN/WSDP4G39684b8+k2l2yrIAjYgLwIDiU2XdQs8DK73afwdauyVSvMH+Qg8Jhu8iKsqz2aFWlQdR3wu5WqNzUfRsWDYpPO8HmomKPlLUALMzyTI5GreIjK81Q656b7H6BFVjpaVwG35bnpXvgkEhOogVVIiO46dKUF2imqtraOQmjM5ZBEvWyzBD8z5vSysWfF3ogTO/M+UqaLI3bqkvu7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rxdj6f8c95lYWwdmu4mId02ODxGpHnyGoMss7/dYDI=;
 b=R5cIAdEyy887VHrb04Yags9cLfsJ/inb38iBj4kg8shSG659e9ov0q/+OV0L9WbLY+wC5utVHbK4J9Px49VEHEg52ou4BfHK4XCZbWp5WXpBlXumy5EU+D8yYMfdPe+wl9HhGimjw+y3/FoNHEJgfEMIDmR1VEr2pqGm1wSoVcfaSm+nXaybO0Nnl+CS6vs6/ONozPH7bw9p6lg6h8gqD92964j7YXN4IrVPTgE/89rDS5ESZq9g9lnrMwmwnmk+85ekHLi8HCte4FMuhGZd4w6U4i587nb7hNGDRDSskkKJOLd8D92c2D13eKl+E1Eaz3TzFUyqJMjmlV8E9fzdbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rxdj6f8c95lYWwdmu4mId02ODxGpHnyGoMss7/dYDI=;
 b=QXp3iWLMzYPtpdEUc1n6bmhJ2IIuICmVlqdLxuo0698+eUR9yn4bvtjH9vAk9CELj9bgk1k2tewzW3HTZpgG3kLVNjU5q7TIbpoyuqFpkAkiR5BRfN5GEEJsUQatyNX11377bDePponGTjosVZTX/ySNlaoiBK66HamxDIzJ/cWSAcJth/jIPOsBwyluTs5Ucy5Bz3IZkdZje5BiTGKD75zx4vxgtOvjAjFwbk9z9D5VtOa9Z+xRGzMtYG7fgdCLLJlrgnvU4JZJC6nnTdT942n89OqJDi7voUC6n3hvVp1TYAMc1CuGjnpidEKmHZWrkJviDaMe7M5RPzP3G/ifOQ==
Received: from BN0PR04CA0063.namprd04.prod.outlook.com (2603:10b6:408:ea::8)
 by PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 11:37:01 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::ae) by BN0PR04CA0063.outlook.office365.com
 (2603:10b6:408:ea::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 11:37:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18 via Frontend Transport; Wed, 10 May 2023 11:37:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 04:36:50 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 10 May 2023 04:36:49 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 04:36:47 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     Stefan Kristiansson <stefank@nvidia.com>, <arnd@arndb.de>,
        <kkartik@nvidia.com>, <sumitg@nvidia.com>, <windhl@126.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/6] soc: tegra: fuse: add support for Tegra264
Date:   Wed, 10 May 2023 14:31:30 +0300
Message-ID: <20230510113129.4167493-4-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
References: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1b9e2e-f029-449c-bddc-08db514adec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtZFpSxW4xXr5txoCsfbHAmkCyHhhOzdiz3nY0LVlVCTdCtwC1bHC4phDO9OmBkwgVeZYs6NafM2QrPk7jV28fdxiO8f3Mafv8q15uwVtxBc2vm/j9aM0JoZDhAI7QfeagoericHt4PTe+YN0tl+x6AhxOEgaUOdOgoehI5zFchaPsCiTR1k7tDh/P9pHfr80TYOzua0LNj1WKAFVYhudTnyBkjD99cVRXqTxY3Dn8rhzPsKP2UxbwnlxK0jQmrm0Nz3Xnxu+kctJte9VpvwmaNe1NeIJ9Rv9pziw14De6xhXAgTszq+7CBfaZUnRXyTFrOPz4sE5h2nxE5fQ1jKSuUy+Xx04spDEHV5PZ6dHJ7DSjgLFeM9wgCZtm79K8pXw2ThlDxRh4iNfviS2TjY/P48Q3k01KFilwbw09OXx6mt4iAYlcz6DMhd0Ywp6ah3w6GyrYeLftroEpKJDGneURcczgGoyuQWkk4k7vP5OvjA0g6h3b9Bm+3hygcD2J2fGJbZNT8z+2NCTjWA81zm5aXN4OtjD1VjPcLJF91I9JIwg0/qal402/55n5eNUqy/LzulieKUpfTA7B87IpHu+9y4t2D8kBREzz1UzpuQQM0t/vMEZlW+c0sgDifdVyJ0W2RugjQ9l3ch8/sVecZvAsjJ0hgznd09AeT6q7Bf+4oAxcTly5Im70t9vFIv2upQGzHKGmWv5umiHwhdYCcBYaY6szeJ5oznBn0TvmAnxNopWW1W1jh4MnBb0bKscHj1
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(6666004)(2616005)(2906002)(478600001)(186003)(40460700003)(36756003)(7696005)(356005)(40480700001)(1076003)(41300700001)(26005)(316002)(82740400003)(7636003)(83380400001)(47076005)(110136005)(54906003)(4326008)(6636002)(70586007)(70206006)(86362001)(8676002)(336012)(426003)(36860700001)(82310400005)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 11:37:00.8113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1b9e2e-f029-449c-bddc-08db514adec5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256
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

