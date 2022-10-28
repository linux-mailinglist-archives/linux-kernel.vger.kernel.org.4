Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2647B611232
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiJ1NDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiJ1NDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:03:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F361D1CC77D;
        Fri, 28 Oct 2022 06:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fhms5AgFOkWQTsjWWiiCA8moQ02wNae2mbR7hQZPQNCuNMW1JvsrxpkR7Ux1Dbz5FVngS43uO8+oVjOwUh4qHPzwe4It1ql488UTKIbikZW7DQcO5lDWJC8FTSmPlvHR09QosvYflF6uqYaADlUbSMYPyvcwWKqGdRxQILY14yI7jIL2QGgukhnMdDHGLptlsw6ATsZu/9ks+a8axBxcCnmIdJdD+m5HJGtG4qJ+oXeuL9IWOfo91wPm+J6Vtg3JDEYEHxCDWDf8AqCNN35w89/hgUAxEJHnYmEFginROjbpIqm+ulkI96fa3HpDEilzBimLtKoIOY03kHUF+6VL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4RZIQ1Di7dneZqytQHdUTk6Ta6ap9bGCfe5EgqxPxI=;
 b=FzbJDFBhlfarPyfjhaISBCcDAuw0j9sVjsoouZut73Ilh52DEcLsP1HjO22hg4X7SA4Pj4A0juQEWZ8A/+qwn4U7dIpQIxndFzYRP5FCCLHnzpXXmR1Dxl7NSNQV1pwM8lATClcu5ylo1TNXeiPIg+mtnbpkMtoqCiuLfflS1isdrP7YDPxm+mc+qjJr1mwgl6kGCNXNL/LS4uMemAsvbUp7ug9c7ed4tc+I/dmkf7pIgAn+2qDlMYCHdkUmcRZEPIo0cUZqVoG+Pa+5+UNzVVFRtO/Wq0FZ3geyCXdC+YUbgEAP5SkTPyfh27Q9hvOk4U7RKckQNI5A4qbq3Qixlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4RZIQ1Di7dneZqytQHdUTk6Ta6ap9bGCfe5EgqxPxI=;
 b=osQPjwfFKFoZolKFtuIVCktYUIjJVpgd+iSEt+pLnZ4ywMXHuswBsztPYKTjqTIQoWKWKAiptnWseBvF6lwWE4KeGajLghcJgBoDu5oMlTtXtIZsFMyBTS4aptINZPNWE99WL929suNj99f8MBGyBIcLKyS3PSNkeUEBPJxgM+5ELS7KHDZ4RIyp6gzF1AdqEHVTzICbuM7Cg5XJXgbpz9wMTxAFs9AesIwSAKMT93MEhxeVMuC9UBtZDqFEAMY/s0Ho3IhdY8wnzXQbcREZsuMpz6z3czDVvgVtipN90B4Nc9lKD7DX/8r+wDV6C7iZ8z3CBFLeaD5+Wzi8s6dIhA==
Received: from DM6PR02CA0077.namprd02.prod.outlook.com (2603:10b6:5:1f4::18)
 by DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 13:03:14 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::af) by DM6PR02CA0077.outlook.office365.com
 (2603:10b6:5:1f4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Fri, 28 Oct 2022 13:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 13:03:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 28 Oct
 2022 06:03:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 28 Oct 2022 06:03:06 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 28 Oct 2022 06:03:01 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <joro@8bytes.org>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <will@kernel.org>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
        <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v9 4/4] mmc: sdhci-tegra: Issue CMD and DAT resets together
Date:   Fri, 28 Oct 2022 18:32:42 +0530
Message-ID: <20221028130242.20900-4-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028130242.20900-1-pshete@nvidia.com>
References: <CAPDyKFpG9ZjVTiK3HEqioDN8ksGpRYiXL_SLSmOfm9fjJfcrsw@mail.gmail.com>
 <20221028130242.20900-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|DM6PR12MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: 964bf9d0-5233-47a3-3d4e-08dab8e4c632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7YycH6GmwjPCQGKsc0vBJktHOSHvEqJprHh+Y5DJR4l4xe34R1exz2rbXNmrgRzXUFL9JVLNbpM0xFWurNqWXcId7sVUHOlSehjLGwuXR7DJsqoWEqykGfvarQvBDVoekXkCdXlOm1+XtFVWe1HmvhQ6YaTeWfWW720dT4rRpfSqdbxVcJ4huEa9/KeY/l5iRoAUoqGvkjmrNM16e3CPTiH5oXV9bxKWxiSwWrWDLEyP4Lt1AMjazLdOmKOM/gc7zbZ3hKn61RrWYUWp0tMBXN/h6m1kJc3ZU32xSXu210SOizaG2syXO08aXbjoaqAzWcKlyZZG8YHi38SaKjjK8lBg/lp4cLwI5tZVplOuPkQP56sYmUvY7xJ4sllD73Ir3gd9vkTj7JSsC9xFpyEX+JWUNX8sa4KHEObvtUlOUdKhqUnYfTldurmDZ1+jhFKlcTqN3gGIkuXP4VMrxwsJlMj22bt3CmQFG7LqWy0JGqJl0glEK4PJ3kIA4wUSEZm3cJXkmgAolTZYv9zFirqpSMNpYVPaqoppN4XCW6epEZACJnIK5Ohg5R1lrQO1a9x6g/lheaLFy/I6+WcVbKMMpcwQw4Ow2oH3+ds/YTkiKhr4XA/2VAOD3zHKKqOg3Zsp8iEI0jC0ZHnNKwjLD7diirZ8NssnNTMP6EUYlZxvhQZ3bzitBZzee96UAOqc4AoihThqK0WRjETatRN5TMpfXHqTPigNIXzRGRkiSjHkz4A1CH2TnR/oAMD0ziqB22lY3sliOFe9R0LqnzDBEUDQQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(107886003)(6666004)(316002)(110136005)(36860700001)(336012)(47076005)(40480700001)(426003)(54906003)(86362001)(2906002)(40460700003)(7416002)(186003)(4326008)(8936002)(36756003)(70206006)(5660300002)(2616005)(70586007)(83380400001)(7696005)(8676002)(26005)(1076003)(41300700001)(478600001)(82740400003)(7636003)(356005)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 13:03:14.2019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 964bf9d0-5233-47a3-3d4e-08dab8e4c632
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index e44060cceb68..7cb3bf34a176 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1531,7 +1531,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
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

