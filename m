Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B269073855E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjFUNgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjFUNgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:36:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92971981;
        Wed, 21 Jun 2023 06:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1h/bQdu0GGzyb0KUcrVMaz/6SRaYABwiTAYN6tZ9uJkwweaj0ISsR8BbMhp8OBxUrorIZzTuaDXHVU3w7AFGMnwYT3TmuzZY2Hgv3HIyBhZpqh9ISjJ/2mTn/c+fNIcEUT2K7LKwXbpXG0qCODWr0LXDZ17Brf4P1YT9n06yevai4rE20rhJDPo0OW4pxSs8sKyu/QjKj7RfgE265BFsi1wok5GhKWFgQ+7hZc1fGr89GFclxfMwwjd+9X9E7fbunGsYngpBhbGqATYHyj/7Ez5KK5xSOzxZ9S2pIGY54t7MKqAlpkyNyuU3L4SmvzX5NJYGfxzQRJRqbTZdjHeSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPU6pwjZ5JP+wKRLO/yH1vCWuLkB0iwb9pKdtpFyve4=;
 b=Ck68V/JJS3iRg8RDlJeuZd349gJHDJzOOWNr+mWRHWaG0X+njRTYwB4M264xFHXHC27ZQGVDeS5cN20EOvi0ltSIPf/IT6nhYCCJne3nO5WWtSCIkfHg/bgJI6YHB/76L3MbocSeOb5ae47mXI6AzBSHOWcmwBwXhVZZOSNAxVkXLkdAWXxt5SaOCsw2WCcaPGFGBGd5rYPIqYanK0Dv1PtlLDPhzduVUWFoFfJQtNn9Ij3LPD0teQFalFrRWJnBoasSJnrEg6FTTZHBH3ubumR1/MGahoq9Fgo/LGdGOAE38CRyNXOuUcip/xDZXt5+zDYVNN6HfrW2calR3DFUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPU6pwjZ5JP+wKRLO/yH1vCWuLkB0iwb9pKdtpFyve4=;
 b=l0qbfckIJgmeC+vSsEoOEOAGLi2/QIx4OrY1iLp7M3sh8DWpiLpgKvns2NgvcIh0ZKAfOMPxZ2PW2nlupRdcLrCa0U4UpEV1UHtxeVP53wWNTnhtZ8TkdLXTmJlFdK0B3gFYxu6sLsjVHVRIqQRi+mJrPw3GM3flH2bJELdXoFLjvE7dDw8ejPdXWRbQmkYKiSC87zfRMW2cEakLk/bAfVlybeC7NTUvMhPJLWo3da1i8zwzk8QzyK9vEPB5ixaVpNIuY7AOBcW3rgxThZ2J32Odl+5lk2Kd5XCoUpVKXX2OJLclr9TiMbO3N3SkpeUHOu1c745bhmO3yXA8U/CTVg==
Received: from SA1P222CA0043.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::17)
 by SA3PR12MB8000.namprd12.prod.outlook.com (2603:10b6:806:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 13:36:00 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::b1) by SA1P222CA0043.outlook.office365.com
 (2603:10b6:806:2d0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 13:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 13:36:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 06:35:44 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 06:35:44 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 21 Jun 2023 06:35:42 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <talho@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch 4/4] memory: tegra: make icc_set_bw return zero if BWMGR not supported
Date:   Wed, 21 Jun 2023 19:05:26 +0530
Message-ID: <20230621133526.22492-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230621133526.22492-1-sumitg@nvidia.com>
References: <20230621133526.22492-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|SA3PR12MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 10543ffb-133f-42e8-2ba4-08db725c73bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ut/4qrVYgaY7LhRVS+1LzxGesWPKlagiOn9LYBL950qxcyops3LhLvkP2RsnmSdoQOQd+5ofsChokfNcCy33byqOl9b1Jm3x27fjyvFYbAWwXOrbjMuC1mUeBS6ZbBX0VDQqt2xuc0GNEmiZplyGOY0uq3zKLjBP419jMwcXNsWd7WnIoUPQxxVfYqjV/OM5GI0fqNArl0grCN0ZIwhgz01NlM310P0C7iig3RC3UYjY2l/BKRVMzgy9cUJmh8vhG/3IQtTsQAmR32r/A2U5RFIXjldqQOjnD9OwDdsVzOEZMr6BqF9Qi0UMdQUew/qy2lS+gp9LQ6+ZqXA+ljVZARNLrAGUWBN1FWKuGhblupsgcdW5oxnE0mBRTe3/12RTHz5uCqCsn9R92wF3zHLAGSKrkbinlNazJFTnz7sfNBcZRj/vufYeOFOsuwFdLZgy6i7WjKBJXreRnI/+G4XcMz7Sv5QPM2Bybnia8b0XIXFd8/FoRKU+bBXRhh3dZroXzylnYMahweRT46r5fxaojoLBWrkh810tmCEntIkRObMd/+Nv/q8gD8V8RHTmRmW2BJUUdDddde0wqOrNfRj/3SXpncL44UeaQjmhWGYp1Vu2sWudk2ryyxY+0gi8dmmiwZGTwBlMnRL+Rs+1GxFm/V+Y/YDZnfL73r4WjQG3ETAXBxLz+4phdFP5WN87u2dfS0Yfe0A/ixHa8hD2xvALaopRJI5rcubpgOjlvhe1pvnlMk8u5VkzPpDzY8HUYItd
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(82310400005)(47076005)(478600001)(426003)(2616005)(107886003)(6666004)(54906003)(110136005)(336012)(83380400001)(7696005)(26005)(1076003)(2906002)(5660300002)(36756003)(40460700003)(70206006)(356005)(316002)(40480700001)(86362001)(70586007)(4326008)(82740400003)(8676002)(41300700001)(7636003)(8936002)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:36:00.5854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10543ffb-133f-42e8-2ba4-08db725c73bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8000
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

Return zero from icc_set_bw() to MC client driver if MRQ_BWMGR_INT
is not supported by the BPMP-FW. Currently, 'EINVAL' is returned
which causes error message in client drivers even when the platform
doesn't support scaling.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/memory/tegra/tegra234.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index bc73be7fe143..07aba301a173 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -951,7 +951,7 @@ static int tegra234_mc_icc_set(struct icc_node *src, struct icc_node *dst)
 		return 0;
 
 	if (!mc->bwmgr_mrq_supported)
-		return -EINVAL;
+		return 0;
 
 	if (!mc->bpmp) {
 		dev_err(mc->dev, "BPMP reference NULL\n");
@@ -998,7 +998,7 @@ static int tegra234_mc_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 	struct tegra_mc *mc = icc_provider_to_tegra_mc(p);
 
 	if (!mc->bwmgr_mrq_supported)
-		return -EINVAL;
+		return 0;
 
 	if (node->id == TEGRA_ICC_MC_CPU_CLUSTER0 ||
 	    node->id == TEGRA_ICC_MC_CPU_CLUSTER1 ||
-- 
2.17.1

