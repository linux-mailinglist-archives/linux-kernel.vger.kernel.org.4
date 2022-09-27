Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9345EC0B7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiI0LNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiI0LNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:13:43 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B2328E07;
        Tue, 27 Sep 2022 04:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dr5MgHxUuBLZ3MPgMZ7knYdNPl/jd3zLzJV7vL+iGK/dyZ2VC63vAjcvhKh8OKLyCN+M36vCXf3eftRzy7DOzkEdecnLEC0f8sbUIDvd8M00zpjA1vJfvXg3BiV2fiomPdaSXf/LUfb0dZ5esripne5f5WzBhTWMhvkDJdEHV6WL7sIf+ADjvYgOko35tcfqc8oy+tNNapFIvQJKpS3qu7ZC54fVC/ZUJMPyqjSF30fRVIrRTUNY9YAQBW2YdsgY6DAEq52AF20muvj5RW4chyjdz5YH/Lf2hqbX1yNHZLulmiAKm6uaxCp1JXYkoRC4kMou7DjbQAGtsZs/ScxBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RkAacYyGEm6912nGI+71qd87CiKcmh+M1C1UXg0j4M=;
 b=Ofp9N9hUpSbIlklbjdZXTTJ2ob4L8mmiWvR5HHTmGGIO+nDrDZ872f6O2/uJioEOyKLlp9/Dta1SPR/IYhjmARhF7mJcIwzZn8lZSeeW0dF/kAORJHOhDHiRGZ2V/4pHGosfhkzhDE/sNzUsuKMUwtwLPWkKBoKZH7EliDM1siCBCy8p14wbedp2HH98ocCe5n4G4G4CAqJGuhmCdKZdKj6loTxS3qo7Bf+b1KLdRRQ34I7/Gmk1ksvdWFpyFmsANeSVkjnvudS2NbsPT6zdfsI8obB8OzhO7lPlP53j7av7xWuZcLU3quRiyw4znvVaRiefo2nUGB9TTCxET/Dscg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RkAacYyGEm6912nGI+71qd87CiKcmh+M1C1UXg0j4M=;
 b=rY6ivEYzvv2h4G8cQxzWbqKncIVY0CY9JTbreLHynv381Pa3Ay1BNFuFXDwNyrIvMLnOzZbKkezpOnguHiG+xLnQoXVVGzeJBC17nNLSLJbNhnqoSHomvtt5vN9gErdwY3ZmcXu4UPtTickQxy2WQbsbk5zSh8MfmJdzDSE+gokRguvtmmo2mI6MdX5M1cVsD/T3k8f83Ef+bpBmxHkvrP5g7ERsoazE8tF1s+V3O4daARvIvcahxe7gXLf093iVMHeHxemt6uMkLJqHcJLT3FdKb4Ru4SeUXDeyzMqtqDCewYN/9BYltWerJ6D3C3/LAqJ4TXYy4as8y1ciuZWUig==
Received: from DS7PR03CA0121.namprd03.prod.outlook.com (2603:10b6:5:3b4::6) by
 SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 27 Sep
 2022 11:13:40 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::47) by DS7PR03CA0121.outlook.office365.com
 (2603:10b6:5:3b4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 11:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 11:13:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 27 Sep
 2022 04:13:28 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 04:13:28 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 27 Sep 2022 04:13:25 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v5 3/3] mmc: sdhci-tegra: Issue CMD and DAT resets together
Date:   Tue, 27 Sep 2022 16:43:13 +0530
Message-ID: <20220927111314.32229-3-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220927111314.32229-1-pshete@nvidia.com>
References: <df68846a-2a09-ef98-6823-d536d99ccb61@intel.com>
 <20220927111314.32229-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: edb406ad-445e-4c52-a986-08daa07954f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ffNabXWH3U617+DdVrdqlSN4gYmukNPyw299+9WDV8omjjF7vH7QQNFjsPLlKz27D1wOyC2NIz5cM+5glfVOzzd+7DrN3DR2pcrYYuldSxESWf8W/wRkRShMvIhv5eJ7fiT/0H/UFKzaVSH9WjdtkMhpJ1eOXZRofWay7Nfj+OmP7V34ynS5BDd0pnL1tCB9gkabOq9uRQc0Rqn2qoX2kUIK1sNXKQcCjQ7+q+NT/jdXbaaf03qj5o33Uv1Zu8nLp2Wo/u3BOqOcR8TkcXM3hSF1ZeJGKievbuTHcelrVRBv2mEX8lSv8gX3IZvXQOWXF1RLVEtUMN8BGsJ/7u05Y27x1m9azZjoN0yy0tjQjfxRFUGtmtHwwBEnpSwqG4pAWE1IsNn65+G7BR6HztCWISu3QD9FfsZro7W5Bl2pUHjSsbt426rs9SMz5Wi+aHtZECDeNMRlE1M5fNUMczR8afubaAsX95Aaz4B9qdiekNolTmCPvSfYGqLMX2a9T/uR0VvjuGRveHynnlg+5GGsjUor/IJuG9It3hyGwhTLip1CfyC433HDHNHGpdR308f5RYffak+RlyjGvlbn5akBmSx81WBVE0zWywSPhS7m7vt3Z3BAiqrQR0cmBcVSOsPutHEm/m7Kv3SPGNpyZ7PTrK4MrgR6UMv8A4gJMYmF4rvYzSdjYHhrsoWQyxxoerjKjFUNzGIUGXUS5YHp+wnjBKN9/mPdcgHnItV9ODQXmOrlfrh/uEvToMZ+ztz2tohXVjB67NDuzgM0m5TgwpAPcA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(316002)(110136005)(36860700001)(1076003)(186003)(26005)(8936002)(336012)(54906003)(8676002)(2616005)(4326008)(70206006)(86362001)(2906002)(70586007)(6666004)(5660300002)(83380400001)(41300700001)(7696005)(426003)(36756003)(47076005)(40460700003)(107886003)(40480700001)(7636003)(82310400005)(82740400003)(478600001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 11:13:40.1747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb406ad-445e-4c52-a986-08daa07954f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226
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
---
 drivers/mmc/host/sdhci-tegra.c | 3 ++-
 drivers/mmc/host/sdhci.c       | 5 +++++
 drivers/mmc/host/sdhci.h       | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 46f37cc26dbb..61dc5ee0726d 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1536,7 +1536,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
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

