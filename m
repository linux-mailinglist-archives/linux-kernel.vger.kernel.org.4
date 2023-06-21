Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F31738594
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjFUNom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjFUNoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:44:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743BB1BC6;
        Wed, 21 Jun 2023 06:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBDty7MbEu+A6R+mMqU6n4U82iQY6AG8AU8yiNypF3sfOpQVshW0BW0e6TpirlsNcBGZjVEvhksf+t6gHBdqANzHRby7+mDTlKVoCqUw6VjnWjkdvfKonI8yNtJ7Gxpx28gGI/o7r877KKv7Hkku/twWt+qlh/FgaSfOgIT3yko+t5Q7Rl9m4DQHJe7C+fbeHorwjf0zHLXfXl8ByvFIGWEaZKgl3S+j7yybCuW15NmuMgODVfQLVR9TNCWGxDZ3E/j3/1jnhrNzI+4cWz9e4xtT4+bMICwqYLSFfdbLBuBhlya2yry0igk6oCqZg02GrgcnRmCa7Znt4/d7D1qxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPU6pwjZ5JP+wKRLO/yH1vCWuLkB0iwb9pKdtpFyve4=;
 b=eGuwFvQh4w5CF8aX/LuNfI6WPafyLI4dw3YBALea6qmekEyMMrQIZSTeVxW3DWNkPxK0Su5aDHWw2ySQljiuUhZ5UkWxSGiGt7OQW4Y7P6ns+Pw852MngBI6Lzr6nuYl6a3BrYd2ySzOB/1k8MEHG7RTiTIvCBqplKpMl5HC8isVsbwjIMMR32ghGKnAXk7u+PZ+CNYc/eNnvx3TNYH5RKB6TmE5YixdCV7gW3ZjuJpwyhaSyGYEkSo8wdAs/8fY6bZSb9p7Hy7A4vHJGM7HUGVC76JGMQzn5ObQCvQLlZLbk72v6fIlJ6Pat5P/NAMgRWlyxo0mG/HaKwKrUCiSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPU6pwjZ5JP+wKRLO/yH1vCWuLkB0iwb9pKdtpFyve4=;
 b=TeKWWSkahY8J4RELcSK27P61KQxfUlvK2caJkCIKZzB5z+RsbdY5HzWoVgzXP4GcV4sqvS82xPnG9yKIQkSFSIo60VKPQXoQPFy2rcXmmV8y/87cw8UrqLsyCgQ5y1Noos2SuSjSlgLdRCsSK53PdB5PuD9hh7MBN9iasgiVIGzM+ZaDhJgC2UgHJqEOLst9OaoBPqHFsWzcBCPAuOWGnVCvTmxi43w4axVi0iXZG1AWt24sZlGGX2VL6T7mfcUrS3OAJx8eLaw4Uf0pbnHFFpGwbfMngXlfLmGOTySfjYZC09xUn/kbHEyR9V1IoIUrYu53Uns1f0KJJQ3teCaP6w==
Received: from SA1P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::14)
 by MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Wed, 21 Jun
 2023 13:44:26 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::2a) by SA1P222CA0004.outlook.office365.com
 (2603:10b6:806:22c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 13:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.19 via Frontend Transport; Wed, 21 Jun 2023 13:44:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 06:44:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 21 Jun 2023 06:44:22 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 21 Jun 2023 06:44:20 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <talho@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch RESEND 4/4] memory: tegra: make icc_set_bw return zero if BWMGR not supported
Date:   Wed, 21 Jun 2023 19:14:00 +0530
Message-ID: <20230621134400.23070-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230621134400.23070-1-sumitg@nvidia.com>
References: <20230621134400.23070-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MN0PR12MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 96bcc264-de77-4a49-6955-08db725da0e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fK5SyRxRVz/imamLyoi0ypp8Qk0GnYWwsdpfQGml/pn7hWptPUTV4NuXdiID2KB4kN/Un1QCYjJmyirulIWlmEQ89Em1gmvhto9B/9CD2qrJ2/NtZyo7oeerSCJ932CiT++w2bKGURMULnCFOddy1XQLIlOmcdxfy6//93v8f8jGCITrU3yij2FVrfpkFU3ywAPXgingQORdpp6oxHcLMF87Dvg37ev8x65C15kYtJZeov5iIKIrkf9bhTYx4+PhjmsgylLSLkIjjyW64cTZ5MBHHAL/VRbGwRb3kJLVBqWkUcLp4P9K1DSHU8quBG8+a7PstqOXW925CeyIj8R+e9DMJd7LGR7uyOUOZd55E6PGd95dW7a8uG81kKjCsM2KzvDRB9kwJ+efRvYulUHdk6cZ/vByx8LnnxvJnUmNHdk5c5RiEm+NBsV9LE8Xm3EGXWQH+bEZ6I04RiSJ8Sn9i/XneuaFFRVfX/tnOvpTdCHGDazDlz+j8mr/M+9vCPy0tFqsh0Nxdmbg97y2EX9y8GO1B+D0NdcgxPm24GOPNkuIWnop9m1EjAveWrLMw2m0gx6Q0MXxpeCo0mHAaPsMbI5xtdZiwnsxsF/L1YEA8SthFTjzRmmwb4+y26lD465UFtgK7fgm5MX/PSZK/8BTemkgYb12JNkh/P3MbJ4QQVuOcKnpZp+PajjjVAxARKmAncRFPInSwcR09rTL8C24nBO+DOrjsGtsnMbJwcJi/ijn4t939OPCYwVuEy5a6wi5
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(8936002)(36756003)(82310400005)(70206006)(70586007)(8676002)(107886003)(1076003)(26005)(186003)(41300700001)(83380400001)(36860700001)(5660300002)(4326008)(82740400003)(316002)(54906003)(40460700003)(7696005)(7636003)(356005)(2616005)(6666004)(40480700001)(478600001)(2906002)(86362001)(336012)(426003)(110136005)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:44:25.8393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bcc264-de77-4a49-6955-08db725da0e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174
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

