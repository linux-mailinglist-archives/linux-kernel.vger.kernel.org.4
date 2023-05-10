Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CC96FE003
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbjEJOXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbjEJOXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:23:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F233AA9;
        Wed, 10 May 2023 07:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DluImhtw8b6GiyLb1EQJRsGGMjxcTfIQ+4pJopojxUt4Vki4lPmH8n3ckYL9ihFibOmj4HVcjpYex3Y+d89pr7KPVlMLgl6X0n+vwk5xVmG44BIA/7C/HvIk04N25nK8T99hl9MOiukhaokaEAAOMpZKbNFghWSQq3ZzZLADkHDzs2+oXlp7462soZNCtqkfr+z5vs9oQAYtycDD8I7T16TfxtIM70AvLKmFLwxsZPlXEaTX21uWWcamuKhmETP7Vvu58o9eUk9lY6lq6K1BSZ18cMAMVABs2vKwvnBbTP5NrlIaCc+cMRjLr4SQT+hOBvj0GH9CR0qFV6p+lgQdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rxdj6f8c95lYWwdmu4mId02ODxGpHnyGoMss7/dYDI=;
 b=nrXeKgDTBjgOWbzym2KC9RAaLmCFjP0AP+nuOfi44YLKERgo+SBGq0btpUsyiJp2qoT0p3EGIqADpbO2PRZFiWD1LQALM1r+nC1HG4VnOtTSdV4tApoHbY+5XxOzVAYLL09zV28uIY5/KnpQKkEPORHCxO00DTMFi5Z5+vC4K+x7BQSw5Iw0JF6hcmw9W9D+8CuAF7QsLwsNp5VcuNqXiqHo9MW7XdjwRD5WCApCc/KhL7Sn+UGZKAqLeUEKlCnyMlXt5UPZzr1Af2Y6PXwVGJuA82Ruw3NUd2pfDbb1dz24MGd92VSPyfg4+N5OMObw8SaICGkRFHjPBeB1zPlLlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rxdj6f8c95lYWwdmu4mId02ODxGpHnyGoMss7/dYDI=;
 b=TREmgam9Oo6Ykku5G4R+kZxRLgyYu8x5/TfGZwCsKOU6X0CBCgpcC0PxxUnLNnHrUAxycZgNsrfxSrWG4dnVbZVzPtpFWAzNTTtZ6r7qGH0wh81VA57UV2m05hDGQEtzgkshVze+BDU1wjdY1rJEjGvRHt2zUgkQCGgBVj7O+sewpBgL0N/uVOGe0vuuzBHHI1cxsQBlVZl9iqX9L8xTcwQbTkrd01QzvkI8DSJSIlTOhEzFmCCVWD+U9P4/AL6hl0P94HAhE/1NdeCFN/Ova/GsMBuDFcgokBAelY/YjJkp+AdGOa3Esw7E77XjxKyYN3qTPYaxCnrYM05T+Ezd1Q==
Received: from MW4PR03CA0063.namprd03.prod.outlook.com (2603:10b6:303:b6::8)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 14:23:21 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::6e) by MW4PR03CA0063.outlook.office365.com
 (2603:10b6:303:b6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 14:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20 via Frontend Transport; Wed, 10 May 2023 14:23:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 07:23:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 07:23:12 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 07:23:10 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     Stefan Kristiansson <stefank@nvidia.com>, <arnd@arndb.de>,
        <kkartik@nvidia.com>, <sumitg@nvidia.com>, <windhl@126.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/6] soc: tegra: fuse: add support for Tegra264
Date:   Wed, 10 May 2023 17:22:45 +0300
Message-ID: <20230510142248.183629-4-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510142248.183629-1-pdeschrijver@nvidia.com>
References: <20230510142248.183629-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: fff87bc0-1afd-492a-5416-08db51621bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4uvNoeQJAoDl/zg40FYG6LTjjR0TNdjl/trRz/ofxv4ey76yKX2XVIAr9l0sdBqe4c8em/vMCz87iblW/QABY8d9dOSSVaiRjRFTXEyZ4GxbWNf8bNmX3KPzWY234bx/Pz0kRnmgwVHCadv+qc3XyYqxYNyK/8aOd2mJCogow8IAhEUCpr404lHbCAHOuKXsMsCH5Wg0GLzx+EjKvv1KYtTUQfNP8WWx5yG6/z3BPvJp5pqjkvgzQIJVwu4CGZgszHFa1sSeGsyDJ5X9Bv5me4g5CPoEHadp9zPMb2vcC57pF+vTNEiTifiZ5FqS5EIWfzhha00yGrGXs5ZRd7/eV4jvqySR4SzTYu+1w61wUeD9EwxelVW4/YKOmhPQndhnVTTxTIFdejmRUsiBF9mriPQnlyenedYGfppSaUE62pZkAIHTDdNVwv+vZ+/gh7p1Ee1NAOODRnToKOJWfhILk41+lltDINOM+K2v8AjyGCq5oz4xpj6WT84+gIdTSgCtNLR87+XlbTK2iXrhmHmfm3VUC1LplctrX2nb9bAHPOa8dxm73RRwI2SVcU/0cgiMXCB4Cs66kG0bKQs7O461APRzdXr0KVh2/oWD8mLZlpF+ZwHZGkkWfT+gjVTs0rMKmUzUGnQiAewwXe/vcVhu/nph7zSEhsfSusqfouQ220ByN4eNRWscz1KE1ToqWJec/RH5Jzugmt42kgbBby1x+A==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(7696005)(6666004)(5660300002)(40460700003)(8936002)(8676002)(478600001)(54906003)(82740400003)(7636003)(316002)(356005)(40480700001)(110136005)(6636002)(4326008)(36756003)(70206006)(70586007)(86362001)(2616005)(2906002)(186003)(83380400001)(47076005)(336012)(426003)(36860700001)(41300700001)(26005)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:23:21.7498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fff87bc0-1afd-492a-5416-08db51621bdb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876
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

