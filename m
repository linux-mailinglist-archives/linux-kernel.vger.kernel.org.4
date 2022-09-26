Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A745E9E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbiIZJt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbiIZJtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:49:46 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7FFE093;
        Mon, 26 Sep 2022 02:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbDssWk6FO0jynDVoa+qvFRut3neN/cYxsF8f6EEG3i0o18VVy0x7wzUh0Y0ggDTkPgl3v0OR+yipOUYCpdm6Z1VBF6UScXIn8SxNRV0smZ9ktw3uI+oX8a0vM3rFvBcykSQo5uzrAB5zwQMjuEbCfytHbS32zqwMgFeYyPjiSUvGKFyqsFFGsmC8M/G9EaM4m+V3qIHM5lL56eVkdnxPWpumHRqKGoHdvwTN9q7p5M08vpUtR6EuVrndHn/dY85wDIYOeV9gYEPTjmwXkm+cfC9tmhdBzmMaq0VZe+ip2zW7lCPOFqUzynzPLF9sBmPMIYrCAXezbxDmh/p3RZPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8g/lfiqFZnVMQ/AB7Rl4IBT5t+98wmWvA4+//Udwng=;
 b=FHKPrg8jd5FJUfNNU88k7gQD+AfKOa44OmKSHjHVwWNapqPbYh8hWn2x1N2M214WoAAJBJQlJ4Bapt9H2RKIDWQ1aEe9xFz9N0PUFDHBllG5to9kP1/Vn3d9gWyQvG4XInEsfrD7x6/sWF/S8eoA2TUeIBGTrPOPhJ3v+jrzW71Wq7Qh3i8WfW4b8eYCfZuCVAQdXKwuFrpnv5/qBKx/Hd4NgA5xXKr1+IkpNoYpzv298rphnPATjas9FeZ8CFcZx7vK62sTiJQ9z365LotuMupOBM/Yx/jbZF2lyKhpImhI1cnh+LzofuYyiDB0WHA53JiZZQuoO1xQIMenbjdOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8g/lfiqFZnVMQ/AB7Rl4IBT5t+98wmWvA4+//Udwng=;
 b=N+35LvWgcGBMG0DSB2TqW6pZVb/sbeWHDuQQR2ex8W0IzbzcWObkslbaJRrXP61GK1klzTCwew1A5Yh6c4u1LurOEdoKhcZpZIaAf9Y4Mal+wH7e3Rr7azCzM5jxAbfLxGkx5jkgoSSD3ltS/CcwVAjzvNNIFw/nJv6lxRSmId9vssija7y9/q2LMhs8J7KyvoBuQCZLyZN2EDQeZSW/u0nKQrE+u+knnmJGbgNmMz/kl6VYQnYTvz1/rLJs9rZlQE0lOyslrRlvIgLOkpJTLeoueKXDmp8UOXfc+uYlSaCAdfxuZmsywHIBMF2JgGtK0Pmhn5BySpXrraegag6YAg==
Received: from MW4PR03CA0338.namprd03.prod.outlook.com (2603:10b6:303:dc::13)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 09:49:43 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::c4) by MW4PR03CA0338.outlook.office365.com
 (2603:10b6:303:dc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 09:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 09:49:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 02:49:30 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 02:49:30 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 02:49:27 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v3 3/4] mmc: sdhci-tegra: Issue CMD and DAT resets together
Date:   Mon, 26 Sep 2022 15:19:05 +0530
Message-ID: <20220926094906.14537-3-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926094906.14537-1-pshete@nvidia.com>
References: <20220926094906.14537-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|CH0PR12MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 24345cda-cf8a-4762-f757-08da9fa4700a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDkRalQCwI9j+7Uoggvb9a85e7HtYnE3eL2J5uMhMTn8MurwVm22SLEFk9AYkgStR0RLX1i2jomLAt3bUf9BXAhlXmoCLliG/TDjIl6ZNq/Y4VpQGpAEeQNjsEywsnm17g6Enff22OB9J/0hbqdDQSVFxxm1G3+qbzELKS2Xpm4DUfujyZ49ac00VA3q/HXyXHSeRrJzUmYpJ9v6BbLHSg96Z1CymiybDbvV5++ARg8SPQaU/hVRzb/1m+Yle9pJr1RRA9gCh4NNbSHm6L3Nj6PRJ1Y+UgocZnjhFbLHleiKuDOpz3BDu9XNuHBao3KV9g2Tvt2Xu9+L5iKPykmEQAYn2YN0nSMhdWDNKA3BDyW0cWOy1CLasuCzjGEpbRX0ttbzldEtuzUPjVawO6+99tvcOXS4AZkqWhqRj5UqN/UU3gRkuBKMqxOcrSSqVQazrXnfHD3SSJ/Nte/T0bxwWs+q05Hiv5oGKIujlsp1vCjWSFzdV6Do6/W3EGQOA8C/EhvMaMo8K0JElwXcpK0WsHxCEkI7iYqBHdk0wt/0oQUdBuNdC5RkXOqAEUwPTFnJUTuIGjO42V/HdGD4zNd4iRm4mWXp+9XGMVSW+fXjoKqv3FUdavTL6PeN+qRLr7Z5WrMCiUW5g3unfTVvadmJHgNAjUGguVMwLpNgjtWYdoFUgQHUmiFyKnhILGjz4YsKhl5iesrnPIFGuwiBmQtK6mshgGRiFO7Rg5uvN0YjrgUj76ekS9wTszQ113fhDP5emN25B9fyZqgF3BNys54Www==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(47076005)(426003)(41300700001)(8676002)(4326008)(70586007)(70206006)(356005)(26005)(40480700001)(2906002)(86362001)(1076003)(186003)(36756003)(2616005)(336012)(7636003)(8936002)(5660300002)(478600001)(6666004)(107886003)(36860700001)(82310400005)(83380400001)(316002)(82740400003)(40460700003)(7696005)(54906003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 09:49:42.8003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24345cda-cf8a-4762-f757-08da9fa4700a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
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
 drivers/mmc/host/sdhci-tegra.c |  3 ++-
 drivers/mmc/host/sdhci.c       | 20 +++++++++++++++-----
 drivers/mmc/host/sdhci.h       |  2 ++
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 4d32b5bfc424..58449e010a9b 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1532,7 +1532,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
 	.ops  = &tegra186_sdhci_ops,
 };
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7689ffec5ad1..2f4a0e84fee8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3060,12 +3060,22 @@ static bool sdhci_request_done(struct sdhci_host *host)
 			host->ops->set_clock(host, host->clock);
 
 		/*
-		 * Spec says we should do both at the same time, but Ricoh
-		 * controllers do not like that.
+		 * While the specification says we should do both at the
+		 * same time, Ricoh controllers (and potentially others) do not
+		 * like that. On the other hand, some controllers (such as those
+		 * found on Tegra186 and later) rely on both being reset at the
+		 * same time. Use a quirk for the latter category since most
+		 * controllers seem to work fine with DAT and CMD getting reset
+		 * at the same time.
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

