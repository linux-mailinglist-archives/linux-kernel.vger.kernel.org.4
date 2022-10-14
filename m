Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985765FE982
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJNHZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJNHZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:25:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B009193766;
        Fri, 14 Oct 2022 00:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jsa+MRLDGwdVmbgNghg2Iu0RApT2cKis8ylDB9qJYzK7GKr05LZVkD14hi1ry+A5OS11OYT9ctA/lQO2sRL4YBEkAaJzbCtEHLVWUqWpu7LGW4lWQ+UI54ld3MB/vhCCb2vmc3cNiNjO4tN/pNqPqbo7mJUycVISlVqzTd51WFI0+kFO36Wa3LBf+b9mgcW+wDj6Sz3SwmWoLn1BM94LI9LdmGeTE8vK1NLEyjERpzbkPT1NWC/KSOpXCHr6H9i+pf8s7Yii+NjDk6OffSzu/cXdqZa30xwriZtQHn2bG0ofO/YvwQzjvPagSYgsjNwQQgpYGbFHg1Mk0+ruwo0mDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/OIYLQil+6XQAlj+Yk0AsFxkvX4fwH51SnUCVgyCgI=;
 b=khLUhfkTOaa9+v6LiuPartU7VJFRHw6LvtMtOR/C3CLFlvdOuPqSFrqZWeI/NpkiUC54qUaTZMxAVn2/hmKg86snwWsVqBuFx+GY/IJPG46CTSbHx9gpvZJkCbf/0IIHaMNO+N5H9dtlDSYjZt2wpyEMdQagJu0q2Bslr3oWoQR7RE7ZuHbOrcWrRuAEPMnREks/amPCblGOWSLaWeQNulEK8iWCWJ4s3kU7Wqqaq+GKxQ31f0PEm+32ulHfUgSTqIQpeULx7oe0YD55j09iXFUgW0vMgwbJfa3Bxu7gbO3zLu5OGoZBPb81HPGRphSM7JUNwL80ruLp9F1WCrhxEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/OIYLQil+6XQAlj+Yk0AsFxkvX4fwH51SnUCVgyCgI=;
 b=RPDZzc2gNcI50rYY8KkJ2zl2VdQNgipp92HpiR7dz1kxKNXvKeydcJOZhjligM2jrZgXLf5YWhe+tqYlKmqaS5Npnt04zJNWWa/0NTZXsjPRiI3crl+259MbMHn1MH85hwA3RggFhCD/uacnLVNolStj+ySLoGiOTiGMIqYQZOXXxKth7CYMbCzC0soUgxQ2uYHiieURyZvzXoNyoTDAN+8XdqNpHdW37p/djtfUwDWskLwLp4H/A3m+Et1efjwwVvaQ+DpgrolW/3u9tVq15X2Y59uuv6neCmf8DZAnnZUqmjrG1CPHqGm6nLj3Ao/dTTt8k0Nw7vkqdE+5U0F2+Q==
Received: from BN1PR10CA0016.namprd10.prod.outlook.com (2603:10b6:408:e0::21)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 07:25:38 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::63) by BN1PR10CA0016.outlook.office365.com
 (2603:10b6:408:e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29 via Frontend
 Transport; Fri, 14 Oct 2022 07:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 07:25:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 14 Oct
 2022 00:25:12 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 14 Oct
 2022 00:25:12 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 14 Oct 2022 00:25:08 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v8 3/3] mmc: sdhci-tegra: Issue CMD and DAT resets together
Date:   Fri, 14 Oct 2022 12:54:56 +0530
Message-ID: <20221014072456.28953-3-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221014072456.28953-1-pshete@nvidia.com>
References: <CAPDyKFq5hNTdwT7CMvsxG=_5u+xvG2k3-PfbGhAbHfHbGqK81w@mail.gmail.com>
 <20221014072456.28953-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT092:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0c530e-b42d-4d3a-1928-08daadb549e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qsom0MQ2G2XETLoEqrGTCM0zamrDNUYJgKzpnAJlmo/ojs02b8ULdQixyyR7Ta7eBU/Rcb5VhW7PTO/18/qZSjqSS2I8y9cv1/xT8L+eweJ/tN7xvas/mrIo5BWowXwgsqHUa9ltSjVw35HdS+Ijh2Lj+Ff0LIted3JwBRN9EYYrPKUq7YChbhv1Zs8pOlpCXOWwwJWswKOemEePZYp870raS5tJOYlN+k933vORtXfQPxkmeF6YX4OUiEPO6Z70h/QhghG5K1MUuxC79R/tprKdr9fFNO1eSm3CAeNhl6coDCKsG84nqt23m6ZhZJkW10i3eM2/ETQnodef6UTj39zRTtsCo3irprAaYXX1O5DsNh+LQkVjui2ePyak5dobMtX8a4NBhj7sx4CVC8xKkUV/VPBwezt8h4ZQMmGrtCPZ3ORGqyP1393HdTPJyrwsPedwi2poNVthwFrVkm1LLUUwIsDam41XzuMyPIYcnCJD83tP1RLbxGvDUakaKBEFBZgTDmDL3T/HQPNqMNDE+cmrLyeTB6R7K3OLi8yFNRv8d4YBSA8L396840hreTziKQ6Yc32ZZF6G6FpUiSh8/sLTjsVNzr3W/KUKsGaL/zjRoXNJwajAvoT9JxsVJ497OoWX9Eef1MBukMvQL6pxT3o+RW90id91b5IRkED1V07yiXTSJDMRIQ/NX6hvtFD5i1JbewPEawr5BWQNv91BwMNq6lVqWzWxHFxe35SE8QdfVk/+2Ooj+BuCEDta+pvQhcwiAwZxfZWQDMIXhCfxDw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(40460700003)(7636003)(356005)(70586007)(478600001)(1076003)(47076005)(8936002)(6666004)(70206006)(426003)(5660300002)(86362001)(186003)(107886003)(82310400005)(4326008)(2616005)(54906003)(316002)(36756003)(8676002)(82740400003)(336012)(26005)(41300700001)(83380400001)(110136005)(36860700001)(2906002)(7696005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 07:25:36.4792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0c530e-b42d-4d3a-1928-08daadb549e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 3 ++-
 drivers/mmc/host/sdhci.c       | 5 +++++
 drivers/mmc/host/sdhci.h       | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 0cd7c3f7e6f4..9fbea5bbfa4a 100644
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

