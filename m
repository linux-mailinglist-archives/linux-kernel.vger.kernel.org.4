Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FB76FAFEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjEHM0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbjEHM0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:26:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3613610E;
        Mon,  8 May 2023 05:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GybuBC6m3MJhLEoKaCsyfLx1wzlbQqQaGSNVDCv2Z1umh074ER1pICsfOloIw3m8ynnl0e8F7dVX1HNXvKICC+pEPIuCMqdHJ8BnIFSxtg6OkYgDQke7vX01xKJhM5cmXju7xO27nSCu6Q74GKOZgVpu4M+n+tKRNL5utVcWndB1JhStMP2sIZzDEE+vYeC1LoOsUbaKtD728QHeNJiKztRZ6PayE86J/JZHtoM9NSNilIVhPQhMIkbRRIWpmlpC0aCHNqG7MUUVBHy1YXmQ8yM2ModbS9IAiIEeZ4yosidU10qofJXlFWoEYjXK3eqmv7QIy1fnH+nw9K0XMt8viA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stRMoWcbCwqfoD8hZ3fAX8ECwzTBwJoAX8X9lB7PwZA=;
 b=JUFjIXea23Fk96hPjXPmwsZnNfgJMnhQ6y6p8LxYPYTzspwnUgacdsnlSuyLTE/WxWUaFjq/7PYjvQd8MsV8LxRTPnR91lIIZ700UTZrPKi32296NotrpJFid3eOy7j2yRhIxTxHvX6Q0lgOxJyNWp4BeiwIV8Pq9YiieUil2uiQZ4iz519FVapf6fLHALLpqFSCyvWqvYgEP/CgYj1umSkK5rF/1PFuar41i/lFgaf4Ns+iEnDjTjO24CTlDX3VVm+11TLvUFkhxkLu7EjrF/AXeAjH+/ci0SOhtIyop0GxA93sa+UPJiaJJ1SRfNntG0n+FUqJOY7P5LXp35jZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stRMoWcbCwqfoD8hZ3fAX8ECwzTBwJoAX8X9lB7PwZA=;
 b=HJNzcpJZlJJl4IOO9TVD/Qk8eUKwyAHe86CyuseM+wULndg68TbGxO9SxABMIQwKrbM+16wY5TphKoqsatCAlEh6dUdofuOJSRrF4xrKpXBz5VCjG1qoyjdnu0SLJOFT1If+20AQC4Lj4pqAM2OfLL+N7CwuWP2Io4dbrjvPK0atghh7fNP0BgBKAElaPi4nEQ/D0YDILm6G8kXX3l97/l209IWjyLu6BU5yCF/uKVug7FDN5qfm90Wp36NbA2kG9mfROVyPNJmG03HskQdN/cUwfmlIN9JQLrc18iAJ2S4kde5qrnuskTjdzbV2PTOGSBCIZcqUUOeoZkosSLGYQA==
Received: from MW4PR04CA0349.namprd04.prod.outlook.com (2603:10b6:303:8a::24)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 12:26:07 +0000
Received: from CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::b1) by MW4PR04CA0349.outlook.office365.com
 (2603:10b6:303:8a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Mon, 8 May 2023 12:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT096.mail.protection.outlook.com (10.13.175.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32 via Frontend Transport; Mon, 8 May 2023 12:26:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 05:25:54 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 8 May 2023
 05:25:53 -0700
Received: from mallet.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 8 May 2023 05:25:51 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     Stefan Kristiansson <stefank@nvidia.com>, <arnd@arndb.de>,
        <kkartik@nvidia.com>, <sumitg@nvidia.com>, <windhl@126.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] soc: tegra: fuse: add support for Tegra264
Date:   Mon, 8 May 2023 15:20:50 +0300
Message-ID: <20230508122048.99953-4-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230508122048.99953-1-pdeschrijver@nvidia.com>
References: <20230508122048.99953-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT096:EE_|BL0PR12MB4865:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba726ab-5399-4fe8-5fba-08db4fbf65b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WHPUdxALurB3gtWdE9ItCsec5eUVnwId31P2a3RC/lStk28hvNw/ei2T5qVeYNEHqoeUEqkCbfnXsu57ZB58eAY4EOYXuUmFZERqREnD91h+wcA4XOcAxGdh69tc4zODpTXHWpUAhHydF+azCPldoLyezoni4w0H9C7Uza3UIJgzDDNnHZLEScCfOkmTdMDkI1Chp3fWR5kQB+6efSQwXEt9mAva8xQr8CHyEi+fWKlmCyY90tvS5ttrgdWIubssWXxaFTPxD/7bQQZwGFu8hPy//D2vHSlRqAW6aWnI/MvDWXlSpuqClF3T5CWAvbO0qgfI66kPGO9k9RvtQbCDzERCS4/t5NhRyMgpTYBGhji0Rp/EPFNMw3bviCAkZt+4Vq+CkxHVpP2aestNmVVIb7c+M7xs3ShVQULbLBzwgKwOCJi0osIR7XmJm3QCGfLMXhYCL7VW9q6hcmPRKoZEAD7iHUsZCS+freqIgqBZ3wxBAdu4kDSNnMYFRDeuyUA9uqSxd/uJRqwzgSm0WYeVF5FDtkSlNijsCkallDzF/HTJS4Z6Mds4UVBB10pTc+zrRXA7LF95Gt1oPQzoq7KK/OeCcePylwMUmHLjdlirCgrQ1XmpaiRsKQtM1NGp3gds1DhQAXMlo4uR2mHNfmGDBZm6yU1k5QboFMo21Lo06XM=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(36840700001)(46966006)(26005)(1076003)(83380400001)(336012)(40480700001)(426003)(36860700001)(36756003)(2616005)(7636003)(86362001)(82310400005)(82740400003)(356005)(186003)(7696005)(47076005)(110136005)(54906003)(2906002)(8936002)(8676002)(316002)(41300700001)(478600001)(70586007)(6636002)(4326008)(70206006)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 12:26:06.5253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba726ab-5399-4fe8-5fba-08db4fbf65b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
2.40.0

