Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDDB5BE609
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiITMis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiITMih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:38:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3576BCF1;
        Tue, 20 Sep 2022 05:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQsFW+DDrwEDyMyoGRfka27KLD1YdXjpf8ZcDpCoAhl+UgfscjmaCdX2DFuGoR2QwL7NGkicH2ULxbkQrTB4NBFV73tALGssqh1f7WwWhpBVQZS/Ow+M5FlnmmuGc46pKFZHk6adhSFqtIPshqCujUmTWb6wc4jvZqRRw4q590lMzUKePnxlavvcWt4HDe5B+l/m3LUBKg+N1J5HXvo+Vr845nOSZ92bvBT+p6PJweWSQ59XAd+N+XCUNk0ODsCn6QjaaO0ZYtBFyxkFTfPG0mZdRrGuUdPc5b87tbUk2LjBzbAtFr3WjTYi4qcBdemRdWsNozvLhThD8IZZwxyL6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8g/lfiqFZnVMQ/AB7Rl4IBT5t+98wmWvA4+//Udwng=;
 b=DGZGV89ZXliGHIS9Ad6W7aW8gpRB3lIAFtwx6Pp+DJaT0Poe5mL+qAlKxlSCNUv//ky6WzX/KmE03v23+bx05l/lD6xGBSgCFxyhGYhPcYpQjwZBtEkCGT1P31E8PPZFmIq/38Yg7303j9F/HhwkHgrBFee5bXMCq0TCxSN5DKPDEqK59HICXr1i4aRT5rKA6EWX2zUduTH5YfABSw7XaXCWK33M2q0ncs0CobIzy56x8r3hlKFjuqx0cCOLl7+KQSLZop/+pkGbyoVK//QUqQnLYzLp4JcJni/RSvAxJ/j+/nxu1hKficcV0R9romuTUERJskoKHCbOLYev1yxoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8g/lfiqFZnVMQ/AB7Rl4IBT5t+98wmWvA4+//Udwng=;
 b=uTjNv7IMS9tevj4uWkQP4WyD/QI6Wb4LF3owHDXZb3SBFxa9qukQ/7sc3m2+Yv3CwFd5wyqFrcBOpBN3Bd6c1QzxFQKmdW/mWpfCIfNek4nSX4KRbdX7EjHd05CHm9aDK7vVTqaSr0Zw17xlMhEkrXn+kEKE0ey01ZW0zY49Y3ADA+al3i2aMe9s1ECd7cS0LrvRBWE+smuB9qDDnBJYroEDJnCaHVJzK/OU9j7AxMCLg6cyfo/VhyxhS+bKBuc+smqYw6B7WwiVqQwhKnAQFQbhx7o3ZQizMOUl7EXsv6sM4WivrFDqaf8XkYXtuD+Hnh+YT+pgpXrlJFUCeYx2Nw==
Received: from DS7PR03CA0064.namprd03.prod.outlook.com (2603:10b6:5:3bb::9) by
 SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 12:38:34 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::af) by DS7PR03CA0064.outlook.office365.com
 (2603:10b6:5:3bb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 12:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 12:38:33 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 20 Sep
 2022 05:38:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 20 Sep
 2022 05:38:05 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 20 Sep 2022 05:38:02 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v3 3/4] mmc: sdhci-tegra: Issue CMD and DAT resets together
Date:   Tue, 20 Sep 2022 18:07:51 +0530
Message-ID: <20220920123752.21027-3-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920123752.21027-1-pshete@nvidia.com>
References: <20220920123752.21027-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: d180fc3c-c5f7-4c81-1cb2-08da9b05081f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XGe+gPn/LY9Ub+3uDWLScjGOmu3vI9ENsOSXcovB5S9WJQxZjJwoUbfMMFBu4/WJ/nnv0cEs9fF8cdsyOdQidwR4OsLbvnGXLjd7RrCrr+asFALSW9HNQ0klxhB6+A2I2D0vQp2RsYYt6Lqw/m5jASPEK1LJZXgcJ9hRwuIUcHLQFUboVLfJTMBBW/3EJCRLprDLuiD951fFEylFJ4ABxpPnyYQW2jx24CuBo7t6WoCT9VGp+Sn0QDGfdyAvq4jM3y91Bwj5p+69lXQEfnanfFbbj3iCO0D6XHlTnjB8ufGLZ4D3y33JNZOQ+IzdqL8Da3CTncUqMdPOk8dlc4DOKNYVk9UWZMwKU0zFvEWKMvU71w18mJJf++VRLLMDlias3b9Z+lb7qNftpNGRPDjGcrjdRxf6f9IoOjYgPp+dPdI5A1mVyadPyuJacILxODCHgHj/0NVpcV20FP0v0/KQ0Y0xwP3v6nH2PKAkK2reGJzbC9V4+Jx2lQ/d9w9abMQ5Y5ziXU8B8SWl6sLiVR7RWEobmCJSvEd9r05iMKD2FoaK9hfhAyckyrXtMb3srxESRDzkAMIWtqguPkHgzVud1rvMu1iXcSasn9aSgLsUs0bLPpienCXTXhb/mK2G9kq8rICHwlH8jJlv+IS5bpMlbAEmeyOmvxTMlIXXLq/pikUgYhJjbqR5YQqXlYL0TRkqLN4ZNRPNL13MkfsiRUaP/kwYHQFIn8Q3UtGj3t6WswSIGORkAXJWEbau/64StIYVLDTjM+59XMfoz8p2ZRlDFA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(83380400001)(2906002)(316002)(54906003)(110136005)(8676002)(5660300002)(40480700001)(70206006)(70586007)(4326008)(478600001)(6666004)(107886003)(86362001)(41300700001)(82310400005)(8936002)(7696005)(2616005)(1076003)(186003)(426003)(336012)(26005)(47076005)(7636003)(356005)(40460700003)(36860700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 12:38:33.8182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d180fc3c-c5f7-4c81-1cb2-08da9b05081f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
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

