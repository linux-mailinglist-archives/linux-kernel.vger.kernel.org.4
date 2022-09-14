Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE895B85B5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiINJ5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiINJ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:57:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C608011440;
        Wed, 14 Sep 2022 02:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBgFeCVBK0d6zchnZ6CXEURZTs2IKFcYgF/HUHl9nSiip9tssVRAxmxWnzdtGzAm+XNNw9sSCH7h6NSRxZIAaApXGpW0bfhiNswvDL8DRtSTpr2Zg4L3XEEKAnfWdKxuqjlvhsn0vzUUx+GKlxT1S6g8rYcYELp/U3d1e4imlUfrSC6ktBa4Kabax5YZLif0yDYlHOwU55ur4fpYIbO9b2BGsGweva1AbHrZsOwXVwAm8mI6shglxKzvtCJnPgaoZI4gWvFnSt7RhIddRQxR1BI3Xu/SErej1AgQPM8PvA5higvuZ7mWcuDIenWEs5nU3aNPrPnJTkskJu6vnz6yqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pdOpeerL70Zsqq9YY6yNbm/dwrmy6+lHcTI3QrR0cI=;
 b=I4PBL4oxcy0LP3srqGpsRU5QltSP6K92Qu3ga0FO0v/B0GQA/Z4Ta3o2nTcYfN3wTt0a2Ub4uBBDCPiFT7HlcCiRANCKnghJvAm8H3qZTas8QJadUIePpU+u+4wuIyF1qnSI84/MNbolrODI3xzMBWvEeeZTZXho24P0aJpPTtooryIQZktvmsW7wDjQhxUNl93iKlWWyBMXTaB0NPHWoP5Iq/rXdNey65JMSWGTzSp9s2CW90KtdmfVK/ifAqtO4F7jz0BqyajPA/2QqYFUpHD2YgbFXKP3e2T7gyUq7zFShhkksCu01WSouoWGdLNg5vZlFqmUQZQuxlLOaXaRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pdOpeerL70Zsqq9YY6yNbm/dwrmy6+lHcTI3QrR0cI=;
 b=i3WpkMazuFP3pVrkq0eUmwXJUlKj2hjOHDU0rFkl+9finMFPjVkLCWJPL+hpMnUfEnFcU3uYSmhvetejE5vmYGYSFmL99zN0fMTenWcOUEjp2R8NbneFYVF64vRAu6eYyLs4KvZP5RoRmsYLq+B8UFJNq5hzMC+rYHwnJmBpV0tosyPOX/cICbnlAL+7Kw7tHcLX9bDP9Fdx+yZZc0precPudWI6UmelvHjWUfaoDkARBJvg9uqHtBQlOc9/km5a+fHRnLUvlyoZPerwDhOWnWLpKxFWdllrtTSnkOHtANs7EOCOqzoochmyv6nZnmMdIS9w8bO9WA7ZzSORQglrPw==
Received: from BN9PR03CA0321.namprd03.prod.outlook.com (2603:10b6:408:112::26)
 by CH2PR12MB4937.namprd12.prod.outlook.com (2603:10b6:610:64::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 09:57:01 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::79) by BN9PR03CA0321.outlook.office365.com
 (2603:10b6:408:112::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Wed, 14 Sep 2022 09:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 09:57:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 14 Sep
 2022 02:56:45 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 02:56:45 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 14 Sep 2022 02:56:42 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v2 3/4] mmc: sdhci-tegra: Issue CMD and DAT resets together
Date:   Wed, 14 Sep 2022 15:26:27 +0530
Message-ID: <20220914095628.26093-3-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220914095628.26093-1-pshete@nvidia.com>
References: <20220914095628.26093-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT079:EE_|CH2PR12MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: a46eb5cb-645f-4b6d-d561-08da963777fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cRnPtB9OWpW3OAUwWG3tUOPMcLgVNwhaNSn9s99MydwfhcDLJVx1+44kTJf7EQW3MMHZAwJuN8I1YGzNtYWCCTsOm3Vldy45AzVHLHQJobRtEEgV8fLK5rgqISxKq2nS2xFeVH/VjeLz0yUMqriwnh1G8XSVqG/nmLLoHyhI7k5xFMWIA0EYh5o+U8CuWnlk0TXGLwKik9v3FLvmksDEdg32ZyP5LGaOqPLghkS4TdbiTsxgzCWaIJRNSCEqw1g8i+rUxDCZwOH9w7w/fVbropp8aoMqi9AHs95VHbEFEOeJaeIXLmLhT3xrF5INrkSSC/ChjhqfiW1Z9ph0vq+jqsfkQ3dX2RwtUjfDmFGRkwYV/3sSq1mkfnZbEsdlLFVsqFbfy0RO/U3jOdrUdMAetTeREWQYLSJRZbSikByl1ZqNqhcmIB4ZpIo4D7AeiVpoZzl+8ZGXCzE5oW5tRncNVx5tHw1HocfrP1SzGhBtC5LiQ9AT5ItykurSqIwjhjVg+1Np+D5wzYrbJPdw9AWwiRmRBhkIadIF+o6wJANxtViYP8Lwyn3K2041XZuktb/axLnMEkLnmS82NrNC63PWPOeIxUpIh2Jr3tFo87v4AgTkVSowzT4wyhFvMvXTi+/ul7zL3Jjx2jzBMp90BqWD+iwZGB5XaGgLbyhhmwhmnKaTV9dNLzDwX/gQhLrM9BS38LhqDRy/z7MppgeyATdsV/VCGDYy5tj7jLQWtpQ9twqDHcoTDMim/3W6VvWYoCcr8Wvx10JZAM8jTPOf7sJtIA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(8936002)(36860700001)(2616005)(70206006)(82740400003)(26005)(336012)(426003)(6666004)(110136005)(4326008)(54906003)(1076003)(70586007)(40460700003)(7636003)(8676002)(83380400001)(82310400005)(36756003)(40480700001)(316002)(186003)(5660300002)(7696005)(478600001)(107886003)(47076005)(86362001)(41300700001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 09:57:00.4610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a46eb5cb-645f-4b6d-d561-08da963777fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4937
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error condition to avoid system crash
Tegra SDMMC controller requires CMD and DAT resets
issued together.

This is applicable to Tegra186 and later chips.

Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c |  3 ++-
 drivers/mmc/host/sdhci.c       | 11 ++++++++---
 drivers/mmc/host/sdhci.h       |  2 ++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index b66b0cc51497..7d16dc41fe91 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1530,7 +1530,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
 	.ops  = &tegra186_sdhci_ops,
 };
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7689ffec5ad1..289fa8ae4866 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3063,9 +3063,14 @@ static bool sdhci_request_done(struct sdhci_host *host)
 		 * Spec says we should do both at the same time, but Ricoh
 		 * controllers do not like that.
 		 */
-		sdhci_do_reset(host, SDHCI_RESET_CMD);
-		sdhci_do_reset(host, SDHCI_RESET_DATA);
-
+		if (host->quirks2 &
+			SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER) {
+			sdhci_do_reset(host, SDHCI_RESET_CMD |
+					SDHCI_RESET_DATA);
+		} else {
+			sdhci_do_reset(host, SDHCI_RESET_CMD);
+			sdhci_do_reset(host, SDHCI_RESET_DATA);
+		}
 		host->pending_reset = false;
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 95a08f09df30..8045308f7859 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -480,6 +480,8 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/* Issue CMD and DATA reset together */
+#define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER      (1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.17.1

