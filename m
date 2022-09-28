Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A235EDD48
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiI1M53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiI1M5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:57:20 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2074.outbound.protection.outlook.com [40.107.212.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7111672B54;
        Wed, 28 Sep 2022 05:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qvr9RSvKqWnbWXnlV+kLJdJrCTV1dsw5a1wn+wmmzHGMv8JvJhXTvPwMENjtZTvqrQHYsT5l+0/nAd7OH47b1M/G8DO2pI9uzWTwJH3hEu4jdwA5NXSkaQU1k2ZvueJ3+zEsohUX7+ppK8VH8Ekg/0A1+oT4SVFz1bIAoygtAbmKoNLRa47Zp0YQ78r6U6DhMCLv7UpJEakdOIbD60tubKX6vdPla2E871PJ+pOPDU27tAE5qQlS9VmCYtCnyfe5Ye3sQPCuKBamaIutpwGeaRDLz43XN/R4nQwmrLpZDN5s4CCEKk6Lj7uGagbl4ilXUGWA/yYD9ElzKz1rxq5Wvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/CYBEKeSG01oSWwsEsY5kuVdggUtkrlR5+T+LSuC7s=;
 b=BXM6LEIXujrCSOVC0q4cb4R7YoUeTGbOGsHhk5ajMosWY/bYvQoRZtw6spZB8fCmJ7puHlKuGIE1RULK1YYitM5mpd0kLe2NVxLeT7BfbpAQjNylGymQCSwi520cccit+OGat0wgDwo+713Abthar6kOY0PVTdBakbPuPJmlT5FkvSA2ei6poCQ2zQw4owSEzJ3YUyd1fl3WAFI0H7BFj1O4pujfahl/XAtw2VLVb/KU1Fj3j2K8CIdsRRiwL8TSizLfpr7Kbhs1L4ECGTvMlBYZr5f7dTwsaLpYP+c5lpVWNEi7dsJyo7B835oISJAlRMaxFq19T4MHibySos3Lmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/CYBEKeSG01oSWwsEsY5kuVdggUtkrlR5+T+LSuC7s=;
 b=E4uststrPTEIp1CDkuBlAq6tP5cSIPCQcaYsgb+UVLFD69IfOczkskB1MorWmxUzoSh7oVH5D1OKiKpuVmbLvm0nl8XlbA8KXOE9Sx3s3V43oh7hEmz0svQ52pjFi0kYtcDX0W1pgd5GmHFJvXTGxB9o/iBZueqnzaFLt3tya20EPlHzu3emlvn9itZzBSi4YdYQ8JKm9RWi8MNZHvan5+t/4yLa/KjkEFwGFUWtaHWxQudk9KMuaHGPLp527+0BYP3thuKpo+eTTJtPtqzaNAGVWdsEUJm6FxkBA85crYJUhB11CLqfvBq0TNlXfWVK4Hcsb+fyKCSaCLDaw6GMkA==
Received: from BN9PR03CA0275.namprd03.prod.outlook.com (2603:10b6:408:f5::10)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Wed, 28 Sep
 2022 12:57:12 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::2f) by BN9PR03CA0275.outlook.office365.com
 (2603:10b6:408:f5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 12:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 12:57:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 28 Sep
 2022 05:57:00 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 05:57:00 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 28 Sep 2022 05:56:57 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v6 3/4] mmc: sdhci-tegra: Issue CMD and DAT resets together
Date:   Wed, 28 Sep 2022 18:26:47 +0530
Message-ID: <20220928125648.19636-3-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220928125648.19636-1-pshete@nvidia.com>
References: <a5c231e8-f28a-e692-5961-58e6838711ed@intel.com>
 <20220928125648.19636-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT047:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b04e38-fe1a-4517-4133-08daa150f634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZSq9ooNrVUUtEaJx4ROhbl+ZcG3qnj4+wtQxcMKlGmlt50IhvgQDrOk5Iv0M9KEV+9CBtJAN/UlwV19R1XWoN+TIct13YQjTUTjAacobIE16XQP61WYtaR0rb2l3NSFi0j8EHqqrSNVqLGm2OxwtswZDc3RwamhiKU7ag9n8YhvQwqjmmYEqxLSObld8KmMqMaF1wr23j9CG77hy6C1KEyDtl2w+ms8rrFt+IoWLsJjZL0LOa8qxCsEk2W9WcuTg0QgNFPQwX6qAecn/2hH+U3Tz9C5Dn/24+zIKqLTnO6VjwZfJT5UHubDpYJXT4VGJrDw7Lt8Y77MVIj0UJCMK+4+XHVaIqBhJk9S/MDC+nTrvlCWMMdddk40pbIMRCwE0LVke9zM0yNkPJmqmrHslxmyzWo8U1qBqcH8PIn8Dx/nmt4j8YFhIWBRke3VX7G7eI/8jWMeCpCKJrxjOpzNFtj0gHZwThFNGT4Eydw8iiRgFQrndFxbx3VYCe+hDZg2z5Y2cSvedd54SGKq8f/9wAmL0Y7ukGfhaKaGpikiIQ1+ZjjfeIei+4IK53ZgICW5btMxubwBfoOJ8ypwA/EGh6P/ABm3MJxgU3mkaypuWpx0zfX37h45sAVtQnkjeNfa6HD88lJPwfKyWQ/ANaP2K4ffR0DeXMIKC1Oj7de4uc9huKNl5Im3Q7kEMkQXzMa/dLpgnTK9StzS8U416gmW9w027X/Wql6k9M1NcwVXeAfDHnJjDbo+cjo/BlytLXpXQG9y6WiRUp3r6mhOBPJWIQg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(6666004)(82310400005)(2616005)(336012)(186003)(47076005)(5660300002)(26005)(107886003)(82740400003)(83380400001)(426003)(1076003)(7696005)(2906002)(36860700001)(40480700001)(41300700001)(110136005)(54906003)(40460700003)(478600001)(8936002)(8676002)(70586007)(316002)(70206006)(36756003)(4326008)(356005)(7636003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 12:57:12.4234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b04e38-fe1a-4517-4133-08daa150f634
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error condition to avoid system crash
Tegra SDMMC controller requires CMD and DAT resets
issued together. SDHCI controller FSM goes into
bad state due to rapid SD card hot-plug event.
Issuing reset on the CMD FSM before DATA FSM results
in kernel panic, hence add support to issue CMD and
DAT resets together.
This is applicable to Tegra186 and later chips.

Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-tegra.c | 3 ++-
 drivers/mmc/host/sdhci.c       | 5 +++++
 drivers/mmc/host/sdhci.h       | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 60ce3e80f248..283f702b4993 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1535,7 +1535,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
 	.ops  = &tegra186_sdhci_ops,
 };
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2b5dda521b0e..8512a69f1aae 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -270,6 +270,11 @@ enum sdhci_reset_reason {
 
 static void sdhci_reset_for_reason(struct sdhci_host *host, enum sdhci_reset_reason reason)
 {
+	if (host->quirks2 &
+		SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER) {
+		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+		return;
+	}
 	switch (reason) {
 	case SDHCI_RESET_FOR_INIT:
 		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d750c464bd1e..6a5766774b05 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -478,6 +478,8 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/* Issue CMD and DATA reset together */
+#define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER	(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.17.1

