Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF996483D5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiLIOgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIOgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:36:01 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC3913F31;
        Fri,  9 Dec 2022 06:36:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VduUwdcQD0c3Sht0awE2fQ5OFg5BL0o3CNFGdLIXYOGduaG2Wofe521K205f4wX05DPSa1mg8piNCfU5OgXgf/ZDeg0McggDnWRQ8YLag67TDVMOfgdBdah4ReLzRhDq5f96ymIPlH5YUGZm3vrbg694lrIJlFHeETwdI680woEn1KYP19WN9TvHICsJBh1KT5LZR+y2flppYRyVusAQZG3FWV8qgOwBXQXl+LnIbqyk2CCGPqEwLRx2/eGU1IiBHH8EXpUXw9GtrVCDQgfZTzFTPvUy1oWJIS2Zkxh2rh0ciYOHc2faPw2kzaG8NCIKjRfT1+jQ2rD44UxKc3PpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdlLRQWoNMbzDS+LDBqZZUuBOgcmo64YDdztOV9LKO0=;
 b=Ppt4v4/JfjU+d2Mnu1k6wo6+0a73TyvdNp2rJxKdNkjc/+Fnn800B3r93XHZHsVWFYET8US9fqS4wpzM56lVRgH3Bp6cA/1b9PjFcbgV3zBBH7UOmpLEPJCmHCWmffuoD7iCmF0b023T3B3GWK78iZUaD+ymO9aCtO2aJvsu1yzADiuZKz7G5eiTQbMrkyF6H4GDOUeJedHVZ5Opb7qjfN85Lz4jy2br8IoFSxzuHZfEMV/k8aRZLFIJlSuwsvKvk52WpUuS4a6fNXYjHhHBRoXjTlj5NXG32r+mfc4z0u6QcrK1oKLJdgpk/HlWGLgVCztqaIkhZvRu+usAiEg/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdlLRQWoNMbzDS+LDBqZZUuBOgcmo64YDdztOV9LKO0=;
 b=tWgRqyRZYx5nYnq6E3dtx8hKMViOFu2vxpfoQ6oARYIEp9y6zylhSOxdyzy8wS1QjGYkW+RR+a2DxRZHB+yYhqs7QGjSB0EI3HVsOjkfNrE009skBfmZYjEYQvZgSQS8oEXWXjQsl1RhNl2EsWGdV6ikhXKr5wTI5fmWesB3S1Y8sUzfK/7PERwWpbDF8bQn9A8k9G8Q/kUMZYs5ijUYNehp8pmrMK8thq7N1MK7EROQ1ugakNIlnVDDuQG0UQTPBNKB7VpDD1TROnhvQI2dWgvp5c6P+4vBTY+ULI3RGSXZ9mOLwNxCCNhU5++HISaR2T0dh8VwASQD4C3ZSsBt3A==
Received: from CY5PR15CA0154.namprd15.prod.outlook.com (2603:10b6:930:67::21)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 14:35:57 +0000
Received: from CY4PEPF0000C97D.namprd02.prod.outlook.com
 (2603:10b6:930:67:cafe::24) by CY5PR15CA0154.outlook.office365.com
 (2603:10b6:930:67::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Fri, 9 Dec 2022 14:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000C97D.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Fri, 9 Dec 2022 14:35:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 9 Dec 2022
 06:35:48 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 9 Dec 2022
 06:35:48 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Fri, 9 Dec
 2022 06:35:47 -0800
From:   James Hurley <jahurley@nvidia.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <hdegoede@redhat.com>,
        <markgross@kernel.org>, <vadimp@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
CC:     James Hurley <jahurley@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Shravan Kumar Ramani <shravankr@nvidia.com>
Subject: [PATCH v1 1/1] platform/mellanox: mlxbf-pmc: Fix event typo
Date:   Fri, 9 Dec 2022 09:35:19 -0500
Message-ID: <aadacdbbd3186c55e74ea9456fe011b77938eb6c.1670535330.git.jahurley@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97D:EE_|MW3PR12MB4521:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ac1609-3c54-4e42-5f16-08dad9f2af7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNwPe4is6urI7ZjHvUvw/lZsMlRtTqIUf3HFw6h5ckrYLUHCQIM4Fu45QwnmX1Efddb1klN8Akt6F5Xk1hrw0vbUAy9FIwaV6riuxgjy+I3+8f8QfUnJu2Zmra1sbh9V5vMAR+mB9ADBzBtFKvhUkHjBgS3DhRUNupS7OrfMZJV++6VlEGwXoUzhCbqFf1QLG8Q/S7GNYDFRCEWw55k6PrZkOeb1F9VcTw0SJhVtrGruWnRCEC5O0mq00DFIJPDU3wR7nSwkAjSXRlydf1namQNJLGm2IwPzkfBLlj6X2zFrxlvskBgiNATe2o/bdkn/t9aVRTdf3AbHjj/s33/l4KCDU2rWE51A+pmjdeQ6jEohHBARajMWFk3wEZctQDtab20Cl4xtWbMnksGhFilabosU/gvduMflRhFN5VmnuN99Ve3v/jNJ/HhJd4XKr/V0Fcd+onZ6lLJoDf069lz+vH4q2kaBHk6KJ6jCUVNf5baW4bjGFBZewyY01MICdf/d9ThG8Ydhg2MLqyIkUz5qqwXjLcK/9XxEAaMpW1d9rVnNJHeUSLVNhuOq085NBp+7/tmi1l3WYGM5ZqHOMqWth3Gd5T1155n5tAWHvsaKT82OhWVR5dmfcdqfmiyEN4y4Ej2GeJRZySydfnlrekkK+NoH24merBDlWa151ObEHI6Kh/qVabEO/0+kk69JGLHHXnSNMd1/R04dhYc0mr4qXKKt9XaIXddNoYIru8uPHU4=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(5660300002)(82310400005)(2906002)(107886003)(6666004)(478600001)(40460700003)(86362001)(7636003)(356005)(36860700001)(316002)(8676002)(36756003)(7696005)(40480700001)(41300700001)(4326008)(110136005)(54906003)(8936002)(70586007)(70206006)(83380400001)(82740400003)(2616005)(186003)(47076005)(426003)(336012)(26005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 14:35:57.4597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ac1609-3c54-4e42-5f16-08dad9f2af7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Had a duplicate event typo, so just fixed the 1 character typo.

Fixes: 1a218d312e65 ("platform/mellanox: mlxbf-pmc: Add Mellanox BlueField PMC driver")
Signed-off-by: James Hurley <jahurley@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 65b4a819f1bd..c2c9b0d3244c 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -358,7 +358,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_hnfnet_events[] = {
 	{ 0x32, "DDN_DIAG_W_INGRESS" },
 	{ 0x33, "DDN_DIAG_C_INGRESS" },
 	{ 0x34, "DDN_DIAG_CORE_SENT" },
-	{ 0x35, "NDN_DIAG_S_OUT_OF_CRED" },
+	{ 0x35, "NDN_DIAG_N_OUT_OF_CRED" },
 	{ 0x36, "NDN_DIAG_S_OUT_OF_CRED" },
 	{ 0x37, "NDN_DIAG_E_OUT_OF_CRED" },
 	{ 0x38, "NDN_DIAG_W_OUT_OF_CRED" },
-- 
2.30.1

