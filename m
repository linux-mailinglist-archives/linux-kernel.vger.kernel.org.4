Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF1D5EBF4E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiI0KKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiI0KKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:10:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3C99DB7C;
        Tue, 27 Sep 2022 03:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3AoHzNIkZaKpJhBU2juDZVO8dRkA5bLucW+l5c3c9gLgo6xoOec2nTVW0oSTLJUH4Q0WgRZyBjIOEXuqFCkdfjRjR8mv8UDLBbYXqaXSLSap6othtOSeHkIc9DRHjv3wxTA3nLarJMIAeW6CqBhGeNsC9oX8Gw1FFD4JeTWr29ZihjZuI3vLWeD/XpOUgzrzr9UGpXPVbqFOXyNWrON03EmJc7LF9l37OO5+6ggjyykQthzC9p1Z608EeX8IDmVqAvUA8mdASH0yZiENO3TmN5grKGQ+y8CkqhdeONntpWwpb/m/7HA+B8YLn9qqTx0NtoZpDkb3rzhNDIlU3CtGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFxlsqCoC1Ddv3TcW2TK8Oqeuln5kCCqvgn76alBgsg=;
 b=aXsn7ucUq/aCL13K5XGkQIekjwVw0g9Ly9O0/Q7qxffIbNNt9jTCpermlx+BGeDvngleCqcwjWSJeRf3Cul6WjCrLMBx0+f7/gKua8ievnJ6IQM4U6mWkXzt6W95CmeRy+Fe48WfFThfyzgwS8vvTplXujDdHkQSb2UIydd4jIxN9N51vjhfrkOd425LD1cuIwT2+Bq3iwxncXCsisH3oiV58vS153Z+0twsZST2VGWToktCqeUIxfK+xaiRFe0V0739I+iCh3KGY3FFE384zNJ4qkBDNnQ27qm8ackifcGmewPrLir+DFcRX6RZWPlXeX5VwyOxtHg+zkHTGflA1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFxlsqCoC1Ddv3TcW2TK8Oqeuln5kCCqvgn76alBgsg=;
 b=cbWnNMU1q7dT/qJ+J3hZeGkkSvsjRAQQDfcJZXzBT6tmMuqJgPajDBsOjb8mnYlYra27E6B71+ttt3z1xFFtCo8v0FkJMKd77yosEzmsIKLss5XFN677jGQgf+M6hm0jYh7cenckMb+22WYiMyn0kDBs+gWsWhC5elb0t/5EGkmUA/iT0CHJtYBos86t8Iyn8L6Wt+eXukjLmaDCUCyJE7eDnJ6ZMyv6y+4VIy8a9/pbEN5Zcoa4cHJ8WtrKg+YAUPf7NeSV+YXRKCelfzpH7YU9fuBJarGUmZ5glZ/7EIPw+UXmLQ7YYkaItltTWremB9Vs9xHiZhukzuKRAZStKw==
Received: from DS7PR05CA0077.namprd05.prod.outlook.com (2603:10b6:8:57::17) by
 MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 10:10:19 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::6a) by DS7PR05CA0077.outlook.office365.com
 (2603:10b6:8:57::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9 via Frontend
 Transport; Tue, 27 Sep 2022 10:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 10:10:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 27 Sep
 2022 03:10:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 03:10:00 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 27 Sep 2022 03:09:56 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v4 3/4] mmc: sdhci-tegra: Issue CMD and DAT resets together
Date:   Tue, 27 Sep 2022 15:39:45 +0530
Message-ID: <20220927100946.19482-3-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220927100946.19482-1-pshete@nvidia.com>
References: <91f09a39-57fa-06a9-6e9e-b3e768d9e26a@intel.com>
 <20220927100946.19482-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: eed79c29-1d93-4f07-5954-08daa0707b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cheMLSOQIz6FvdCE5izuYHZw8tCpNG/HSGFs0L0xOkYeAabmFuT6f4CR4HqgbfVZwkQyasHcV216cBlfJwA8cHYQQnd0LODx9KeJNafM6ZN51AFouc0XRtLux7zmQa7vRLvYTdvr6xjOP+WsafWFAtfCNOpbUXuLEAOn9uEVzQ8oxF1HoXVWjUPEoYtNaN178NJPR0iU+ikZAZy+5nUxCVBVp4nnouZWxN5lVtkMrssU6WjZ/8VwAFr0haf+tXqQPBStzQzTLaguOEDkBKdhZR5KuVomKBBQqK06oPeyH185DT2IP/wy0deH8QPR1CajByL4RdUsHQ+LOlFJ/PZ41jnoVUO+G7P2AOortMtGiBhe/s8GJqWoa1v16aSkpxsO/hAaaoW/sQadOtzb+sZWA8BAZvTI9pRre3w3FOskuf+6v1A77phjdSLTOD1bLJsRVCRD1Uy+aYNaKj83ERe4KBaVkgnK3rrgZjsPWzVh63gUnf2QIwGEWGQlyiGQ8+0LNBEmS0lwPkut6NuB94XaBODBPJPnf/88J3TzCt/FXyewMaIx7MTOjHHhisS4LrQGReN27KIcXi2VgBjCw4wePZUEHJIWsuwEXXTcfNYjUU++8R6iBvqm3mBq0sIlc7xRmNz8C1rA5cgSAaukdNIT75f0AIFj3hiuySNnx2+Z8jbI6gcKnGYcTrwmp6vpo2VL7hYlshzgk0CYP8KZk6q5tCVSCwFLU0kjvWeBocX8IX9p3dNXE0MMF8x8RXEdIzpxpZ22xB1xwcHhAciLcZNbwQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(356005)(7636003)(83380400001)(336012)(186003)(36860700001)(426003)(2616005)(82740400003)(1076003)(26005)(7696005)(478600001)(41300700001)(107886003)(8936002)(6666004)(47076005)(70206006)(4326008)(70586007)(8676002)(5660300002)(2906002)(82310400005)(40460700003)(110136005)(40480700001)(316002)(54906003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 10:10:18.8528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eed79c29-1d93-4f07-5954-08daa0707b33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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
 drivers/mmc/host/sdhci.c       | 8 +++++++-
 drivers/mmc/host/sdhci.h       | 2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

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
index 2b5dda521b0e..5123ec3fc74a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -266,12 +266,14 @@ enum sdhci_reset_reason {
 	SDHCI_RESET_FOR_TUNING_ABORT,
 	SDHCI_RESET_FOR_CARD_REMOVED,
 	SDHCI_RESET_FOR_CQE_RECOVERY,
+	SDHCI_RESET_FOR_CMD_DAT_TOGETHER,
 };
 
 static void sdhci_reset_for_reason(struct sdhci_host *host, enum sdhci_reset_reason reason)
 {
 	switch (reason) {
 	case SDHCI_RESET_FOR_INIT:
+	case SDHCI_RESET_FOR_CMD_DAT_TOGETHER:
 		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 		break;
 	case SDHCI_RESET_FOR_REQUEST_ERROR:
@@ -3084,7 +3086,11 @@ static bool sdhci_request_done(struct sdhci_host *host)
 			/* This is to force an update */
 			host->ops->set_clock(host, host->clock);
 
-		sdhci_reset_for(host, REQUEST_ERROR);
+		if (host->quirks2 &
+			SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER)
+			sdhci_reset_for(host, CMD_DAT_TOGETHER);
+		else
+			sdhci_reset_for(host, REQUEST_ERROR);
 
 		host->pending_reset = false;
 	}
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

