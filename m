Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DAD5BE605
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiITMin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiITMii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:38:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF8E74B95;
        Tue, 20 Sep 2022 05:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QE2NFDXlbBTCjpQhmLh1Wv+6H2HNnig78Ov+qJMQecuwL8k/qWXo7pQ+0Nb+qZgIcIfYBgrwBXSuumcEBHHFCjUq+h/yTPIJqLq1h40OxAE+Eq98eNOWaCNwrap+ekgEczyNqpjOVh+Fc543xv6+IP3NhDFFn6hA+yHG6LU7Qwg+sn3NjnC4dbkJdm1fkh4ibqW503658AE2zMK5RABDVqNrLYJnV5LZ0v//3gfJDTypodcqgQ/XxYDlsewNwYl94k9kmZanqQ9FHksNOKjAliZDfSc8BZEiGH+PPpwnO/G5sW5a3Z9rEg4xmehwtiXyrl74hfVFt2rqjeZVnInNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NDhLgRThTISRiD64iK2tPQ147B0bUybYswO+kM4n1o=;
 b=eUZwskaXnNtt4WWyFUggTeUtwOFqXcJwbESU3Pqi+GmJ0lIVDyY3X2zjFlXuYt4XHw0B0cyeIF0BbzXNLbGx9LWY4+7uobZmBRTP3u0wB41YKGFNhn6ereROHFnFa70uFAl1HCs4QYqtrwuYHXJTtiZ4KXlK+T2QX55eE+Gjy7oEYjchBYyh799S0OZWUWF+OpSJZhfkQy/DlgYJZfLiKcrE4l7YX+pPxcS+ujPZHBHol/lEXUUhCiB9bEa3G/3qERj+Uj0/N8/Oa0oKpFWVR+R0BhNKDl77errJoHYc0ulHWofOS7lIFjKIEmEK7nr1nrmRB//AtYFOxkTXy3tpyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NDhLgRThTISRiD64iK2tPQ147B0bUybYswO+kM4n1o=;
 b=oKoHV8Np4eGyY8gpIVZCr6ZeXf9QKKJ1dRZFDoybqltr7VN4auaM1c7u3hF9eIj0cPVaUXsYWXQmT0KgoVDStw0MgJAxAT/dBEEq7RPXxdEwImuQatz4ycTqQRHPJBR2kZx8Be7fFygxlUUMgTX6yQ2FreHML25ej4qUNgY3ihqJL6cviX1cUbsp9pfZSJ1NWwdtpSGy2WsX8weE8gry9oRvb1Me1vWkF/A4Eq7R3ff5VQxKX3AkEBj6vfWqhu6r2RKPyzJTOtd1K0US65PerV8A9CS/a9PtHRPJxxsQ9W5/DEcHqs/iGdA+xX/BJLSb4cTZ30y5wLGmkQNGkZM3Dw==
Received: from MW4PR04CA0214.namprd04.prod.outlook.com (2603:10b6:303:87::9)
 by CH2PR12MB4956.namprd12.prod.outlook.com (2603:10b6:610:69::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 12:38:32 +0000
Received: from CO1PEPF00001A5F.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::31) by MW4PR04CA0214.outlook.office365.com
 (2603:10b6:303:87::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 12:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00001A5F.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.12 via Frontend Transport; Tue, 20 Sep 2022 12:38:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 20 Sep
 2022 05:37:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 20 Sep
 2022 05:37:57 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 20 Sep 2022 05:37:54 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v3 1/4] mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
Date:   Tue, 20 Sep 2022 18:07:49 +0530
Message-ID: <20220920123752.21027-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5F:EE_|CH2PR12MB4956:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1dc41a-add8-4df8-404e-08da9b050655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+rwQ+/BO6ak8lThhamFDFAOqJxaTMcqRaFjV4RC1W5B4UWU4w8fqUG+N/b7qIthdDm7ri6HttxoCZtPL0TOC1uTE9qG/hXS9gZBPObXOS1HIM2ZsAn7kIxCYckS1oo3UnLAnU3nMghJkBFZ9A8JBlClgogoUG6uk1HAm+YUtKh93BlLmn6H49Sk3Ugj3B1qsWrfP8c705PSfpJG/kqTx1PsV54Xxv45W/SCSwcJNGaa2Tv4QeCz319iGhR3ZhBP6ZQGQw38TChq214Y6elAwdeRaB9IgO+IuBfvEnl3uQ+pfCXW4tRp5WN5GR1gkJOWk2Xz4c5jIodZ0Ed0hCCkf0xrfFjBA4s6h0DLb8+xisIoQjsWHiV4UrQ2RAeZ63S0lSY1xU2aA65bVLMjgPprHWIMJLtqERqlBs6rG3XXWMYlkwHoGvCws3iTmu+dwREdF7Njro802jjh5DFp7mEqDG02boSJyqTDx4VDJ2Rl32a9qUdkurBkat9Y94HqE6kov+WjFszZxXxY+ANdBsqJbaXfsVl1BlfCHImjqhrfmVjSiIlHgiF5YIZyOYV3UU4u5c9OkM5nznmlTb1zrpPeF5NGrUxWuuOyQcGfkiBiAyzBtk1QEq2crCbzLPsWaj/LunbrDIdAo9B5G8E9fFsu32UG+ZWwiPIRSr2qY9q/w4y3Lnf4rVvUGT3RZ41HMqGpWAeOMriQnxyAB+hdBxg9L4bUMY0GIrZcZuVTQ0Dx868dmm8pwEPQ2AmoDS0zkg0TnILRJF1UM3cvnlIC0LtUCg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(40480700001)(2906002)(36756003)(54906003)(316002)(426003)(36860700001)(8676002)(47076005)(82740400003)(4326008)(5660300002)(82310400005)(70206006)(70586007)(8936002)(86362001)(110136005)(336012)(1076003)(186003)(478600001)(7636003)(2616005)(26005)(356005)(41300700001)(6666004)(83380400001)(40460700003)(7696005)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 12:38:30.8801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1dc41a-add8-4df8-404e-08da9b050655
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4956
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create new SoC data structure for Tegra234 platforms.
Additional features, tap value configurations are added/
updated for Tegra234 platform hence separate Tegra194 and
Tegra234 SoC data.

Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 2d2d8260c681..a6c5bbae77b4 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1556,7 +1556,21 @@ static const struct sdhci_tegra_soc_data soc_data_tegra194 = {
 	.max_tap_delay = 139,
 };
 
+static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
+	.pdata = &sdhci_tegra186_pdata,
+	.dma_mask = DMA_BIT_MASK(39),
+	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
+		    NVQUIRK_HAS_PADCALIB |
+		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
+		    NVQUIRK_ENABLE_SDR50 |
+		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_HAS_TMCLK,
+	.min_tap_delay = 95,
+	.max_tap_delay = 111,
+};
+
 static const struct of_device_id sdhci_tegra_dt_match[] = {
+	{ .compatible = "nvidia,tegra234-sdhci", .data = &soc_data_tegra234 },
 	{ .compatible = "nvidia,tegra194-sdhci", .data = &soc_data_tegra194 },
 	{ .compatible = "nvidia,tegra186-sdhci", .data = &soc_data_tegra186 },
 	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
-- 
2.17.1

