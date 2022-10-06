Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B445F674B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiJFNHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiJFNHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:07:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B346AA2AAB;
        Thu,  6 Oct 2022 06:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfF36C8XScvFjX04hNTXAsCMe7INiLowI/tI4t6wint9rbTRj6UYLGCsJuqZeD089by2UMA3dRCs66SKFr3jkAoo8eEmMg27wtQI6N0ziDdQ3V5JhYtBlGyqKlOqKbSGAv6GPnkyD/MRlLA0JgPTKvdqq5MogBRLMDOT/WcD9K03PKKOkxkuns/odP7cn5o94r6tdjB7uZO7w/LAlrm+dsd6bmo5QY7wvRo6UKdX/dcRh81krqYteWqYi9nisZt4QUfJxJ7ERH0/F0eKmnkdCpJaB51IGWxYfRScTGaWIFyj+dVdKbsRLbD2YUVoNC1wHvZArX3w316Tz/Ho8pD3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIeZ1LT7TqnvY3Uvh7MH08omej2EHzrFcpvfiDM38/A=;
 b=YEDgShDyOMtNynPdKI/NW/KsHJMRPLhMjl3SP1yTcPo+u+1KQyv82C323euFsUuooQyOrP0ZkK8gBdaE2k+x1nmUqfv1t5oxGJJGCXawAxpCMYKIny0ip/mov8IFCA4OXEHEsrS4bBX687lEc22/9rkQ7CGdJY8tDDVAQbCDtW/1h8nX27vmcp9Xl26ZR+hvH1PiDiaxp9P5BJ3Q0pwioAfKhdcvikBE2aET/Z06l6SEnVq3SoCpPQGIBvo/vDEy3vgZnl3m19wLoLxqAD/e6J3oa1xEIU/1x7CK/I0+xHGr1shS7By+HVdyGASJYd1juZJzWMzBGLClvq9/OeoqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIeZ1LT7TqnvY3Uvh7MH08omej2EHzrFcpvfiDM38/A=;
 b=jkc9Y5efn4tr25JohGCG+dq28JkQ6rr14Y3AnW6uPzgg1waixZ4zvS0krtQoU5xqdXQexFYy+MI6rceMkAw9bTBA0N5oTp7n3Ut7yIYGCBoFmqnQmqtHbHA5pcCPEvBltuOnzI18Aiqs71VAGL5OgxXqIt3kVql6/zxq3CfchBAW/b2TT9Rw5FbN0mlYypOh7saCEWh5SPkztU6rUCFxxiMPMqIOj6p+Yyk6CJZF5wBF7J92dm5+xhd+mK0ZIooM9p73WWMlYi+glQ8xmLlGRHelPuYQjExxEZ7OmgbqFtRCREOTUhd+jgBSaQkYJh+LqYhdp3pNUKehQ+rsLU52CQ==
Received: from MW4PR03CA0125.namprd03.prod.outlook.com (2603:10b6:303:8c::10)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 13:06:55 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::c2) by MW4PR03CA0125.outlook.office365.com
 (2603:10b6:303:8c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 13:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 13:06:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 6 Oct 2022
 06:06:38 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 6 Oct 2022
 06:06:37 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 6 Oct 2022 06:06:34 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v7 3/4] mmc: sdhci-tegra: Issue CMD and DAT resets together
Date:   Thu, 6 Oct 2022 18:36:21 +0530
Message-ID: <20221006130622.22900-3-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221006130622.22900-1-pshete@nvidia.com>
References: <Yz6zfrVq9cP/wrJb@orome>
 <20221006130622.22900-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a9f06c-300f-4325-0c15-08daa79ba4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBEy/Qo87bnsjULZ0H6E5FD228qJ+UO+LqnuQf57D/2tZoCwCGuHPYS4LxAEWmJlvmatSZPpummgrBemVQyUXwSBUG6Wgc4uxtaaxBqQ5eLh2GCrGw7YwQh7JxCL9VtSvuJ4+22/pyWIZ8C+XshXcB/qgg+PY86PWr6BNXZx3mLOVHXTs2F48KcrOVBTIpmWCi6H3j+nBLOK5EeTSlWuxPU6pOCAldSus0b/1ZjNlFTLAHEr1E4ceR8OSA/dCCO+zf4Do3z6cj7h0kKaG2dRIlEIUzTc5jqMgZkCLsdVJqHwmDFDagCceJzWo/KjBJN0v2WEBF5x4bUzLRyP/IGccw90K6uqWSlMy7OiXLXlbRHsskMteTrbe/CgLMmi6PerKFxknB2D2nFv8rvW3GN0GZ9XKLruvrsdbLqMqS7OF3zEKxBUcGLWI5tVoxGLI6twzpv70H+AD+4PTszSHi/oOYkuDwKNRY9hXJfG02ORiNU4t5AoYP8AgHYleflHkUZJOOQRYiaK5k5Hxp/TUz55wCasI4woJnJO1Swy1iL98eh5YjwYH8leHrI/XVFny3fhpsZLk3zlaMTH3FdRx9UP648SqRKflSVQjnzVtfcEM6DiRB5ZdWtdwlC3QK7buDTp13xhirnSFWKvnLW3v4S4BzgCiMvXyON4j7SLrLIyrY2z5HsL28CbI6A0E/iR6dFglI1+nHQV4//r1Fw9svODZeRyRv83WsGk/0DekU0BRTvs0Cml9XAqDQ/OlFf3dMnP8rLis+XZnDzpdyjno/u9yA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(70586007)(83380400001)(4326008)(70206006)(8676002)(6666004)(26005)(86362001)(40460700003)(107886003)(5660300002)(7696005)(41300700001)(2906002)(2616005)(47076005)(426003)(186003)(1076003)(40480700001)(8936002)(336012)(36756003)(478600001)(82310400005)(316002)(36860700001)(356005)(54906003)(110136005)(82740400003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 13:06:55.4313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a9f06c-300f-4325-0c15-08daa79ba4fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
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
index e88294a6912d..3663c5d0efe0 100644
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

