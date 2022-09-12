Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705605B5B24
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiILN1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiILN1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:27:39 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF622F64B;
        Mon, 12 Sep 2022 06:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzNMwFmgFFOOdmHCJq63od8zJJLtOjNEROOY8tlXtOoLPL/PI6UhDQo4XBlv3t0pW69DeXbUi9pHogf497a/F01YQbcg4OOpCvJmi0zT6NzfzytPHIc6LubKXyGNOYCsTWgygbDni6IbcnURAmem9frM3nyboUnBfxQNE9f6k2Q0OeW29fuvH/P6gF8fcRlGU4YDp1CkhYh5dviZBzSgCgtM3rk69bMyY7OBJO+peKnuSXf9TqWFARJlPEEaMelhQDP6ioMCfrCj1IgEQJ1FuImgEHhDVewXOmu6nb8UV7gHUVyNI2Ez3BQlD84R3HzNUO6Ba7v3+9QUCBRt+sSJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbMGqWh09ct78D/RST7bfnJEnWI81g3rfFJFbEAPsXM=;
 b=ZDYV2PS/Ws/gLECmniQX1eo92sOZ3CDHuG12TponwwdsqaFHsosSqTn3adfRR8OFEhGTW9nrq0xTz5p1nLqjC//jgDSZtvg+VVYunozuPyrOoDRueC1mnudgGUl2c2NylsipeIByZOkm52RD9KXL5bl1r4IVKYLwqxoYl3zycZ6sTvC2eLC7PzAcj+pNS5VUGJHgxHy7zJPwqELMKvbcPy5zWVqO2kiXDha0y+7Qcn0rXjLKxiLHjK2v8XUF63e1UuQ96BCEqbrHHwmUoyw2jPooKP+liczuNPqK0aN3h7Qeqtpge6OxXqva7y9ZkkvKEVUjFBEwtIyE3YDEqk9o8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbMGqWh09ct78D/RST7bfnJEnWI81g3rfFJFbEAPsXM=;
 b=W2umnoqfpc+oUV48JSMeG2ZG2GIqf++Tt+byGGLpvvMFeebNA1nKLDB1Yd4ZtzAC6KczmeH93QxFdaShL7p0NQPpKZKYugud8JD0rZCg8YFxEvj5OnrpyJMPxZYQSf3lWZBrdmrz7eFTZcpTwfe53G3HRxE/MUPw4oDI8f6qVQgRKpvQYVFqoYHMo8rRlLUkGgGtO8w/4IX7oJURErrdvLl4xMq+gJsC18BS2GOPgyyE7JOgs2O5DYpXatiStE57/LfJQYY+IXM6QlBA81F6Vdvxk3n5q/Td93MTC+OsXk9e1BvjE6J/9P2Ax7695F4ace2Jl1JBN9YWk1QoJIKhLA==
Received: from DM6PR05CA0065.namprd05.prod.outlook.com (2603:10b6:5:335::34)
 by SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Mon, 12 Sep
 2022 13:27:37 +0000
Received: from DS1PEPF0000B073.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::c8) by DM6PR05CA0065.outlook.office365.com
 (2603:10b6:5:335::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.6 via Frontend
 Transport; Mon, 12 Sep 2022 13:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DS1PEPF0000B073.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.12 via Frontend Transport; Mon, 12 Sep 2022 13:27:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Mon, 12 Sep 2022 13:27:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 06:27:32 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 12 Sep 2022 06:27:30 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>
Subject: [PATCH] mmc: sdhci-tegra: Issue CMD and DAT resets together
Date:   Mon, 12 Sep 2022 18:57:28 +0530
Message-ID: <20220912132728.18383-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B073:EE_|SA0PR12MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: 565d49e0-3b77-4300-15d1-08da94c28e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S18yQ81DI03D+HCCwWwHc7THL5lg1nw3v91Q7qPqrrfldMk6rXfqVpoSJucerOP2OPyPwtz5yuw8NkY8lPJna6S/4+psCXeKend6WcTUTWxlRQQLo42Kpj+Kn8/dElOQuwA+kmF/sUNaMqtiwCyyKB2M8s4gnohhGcmRMWMvxIWl+vtOMD5LmeezKIlRIeHJhW8t0Pve0+5V9CVPTVHqUeDSkr9NQMLPlAMd9x+rRLat2rQZ1JWzcX689x4RBrzj6GJp0tMKQ8C7YN2SSzQEyed2wM8Gp7pzBSw2KHnPJM/bg/dI5XPxGbHuuDLMtow21LrR2SQYbUHkuaQQ7nVQlrnLjn7sJ+IdR33XfEzbfIC2bAkU3qXt9gVbrokJwZf7Kyny0lcA+uNKWz2jZD/klY7jUBhogLQzGrWWEhKbNAZ0e/Kt0pqd1d51mthtNNE+TGf6OtvW1HTlNqnM2htYSsxsWPkbMSitYkfxEElxsweU5XBEZelhU93ZL9q1LSsK7faOxy2G0s9voVKLUyI9GXOUxPhecp5jnX6O6CIciHq1Vyo6PO/+CfQDI/gAcoSk3QB4pL6tUrF1j4zshZCzzGGT5OBf4Ab7wfwq9LnQxwOEcNwD9rwihHfUvOKCLPnqbh3IqP6eqwi/R4soTpLnbN5xwuGp1Q4r2pfgcZhJ0nIHKSRRSMQIG+Na9HroUyFoY82J2xOELF6/l8ajq6eCm5xfWYFnisjF0RV7gnGd5GKOcQdZKgNJKo/0jGU3yPq0NBNuBu95Cx3goTZYWtkDcalGGJiDXd+XUstkB6pjc8+MrDdycQTUSDUYQQXNZV9a
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(36840700001)(46966006)(40470700004)(7696005)(81166007)(26005)(356005)(186003)(47076005)(2616005)(478600001)(426003)(83380400001)(336012)(1076003)(41300700001)(107886003)(54906003)(316002)(40480700001)(86362001)(82310400005)(40460700003)(70206006)(4326008)(8936002)(36756003)(8676002)(110136005)(82740400003)(36860700001)(70586007)(2906002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 13:27:35.4271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 565d49e0-3b77-4300-15d1-08da94c28e3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B073.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477
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

This is applicable to Tegar186 and later chips.

Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c |  3 ++-
 drivers/mmc/host/sdhci.c       | 10 ++++++++--
 drivers/mmc/host/sdhci.h       |  2 ++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 2d2d8260c681..0a82cbedabe4 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1525,7 +1525,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
 	.ops  = &tegra186_sdhci_ops,
 };
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7689ffec5ad1..89ede0cf674a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3063,8 +3063,14 @@ static bool sdhci_request_done(struct sdhci_host *host)
 		 * Spec says we should do both at the same time, but Ricoh
 		 * controllers do not like that.
 		 */
-		sdhci_do_reset(host, SDHCI_RESET_CMD);
-		sdhci_do_reset(host, SDHCI_RESET_DATA);
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
index 95a08f09df30..111e9bf98dde 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -480,6 +480,8 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/* Issue CMD and DATA reset together */
+#define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER	(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.17.1

