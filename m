Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B645FE97C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJNHZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJNHZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:25:21 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9352B638;
        Fri, 14 Oct 2022 00:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J01IFMAIjnnvJ4EdiHaLh8WnfOLKy/liAvsJXi8fk0WBnRwIAvhQdUqtBjyYZEv1AOVwAFi6SVyp1jT6bwzvFSfit5q7wdqKFpbWdH5v4cF/gM5rMNtg6BLVVPvzcBBsQxZV7b8xfbEH3wDjtwmhoIZln0rom9oGY7HOTNuz2jYEnmuWLo0ZBqG86qtPd5uMPeB3eYkdeD0Ulyqb0sbbbYUtsKlOXjid0Mhqi7R/P4x0zHEsdVp3UkzuCp5GxW/oVSga6Ft00NUdDy2UkeXm4lW1nPsjxuJ50PTdSDu3bEKQGgsA4bc6zTgUZhsuZpXo/Y0o+1HSMqQ87DAVvDvK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt2SFqLcav+hZ/lBpn/7PhfyM9sb1S7Ki7Fjfdb/ozI=;
 b=KRuw4QpZau8iTiEWFTu0PDNbGhSSzi684mXH1cIA21MSeIbrXFE5Jbl30InP7cA9nYQjfr7Ub+7QlgVXbs/SUeB68a17I43YBvAedobXaLIHtJa4BniZA0mosGFuQ0TGRF+DPHzWgUWkC94AdtIvoetyLfCAF33QIbYDtTsyxjXvMZ31lPD4GC8XbWjU33yO1aHjfsoaKoQ9PYjRzOSRnXfknWdTM2qFxzumoWS6EE42ly1UJ2ZzAaeodmZajNTXgWb3HMMY1j/TSMze0uTvU5M8/X/fwvTNiNefEN1nuGkfa0UY+x2JCxqbFCIBWlGLtRSwG1meZBWdDlgxi8v+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt2SFqLcav+hZ/lBpn/7PhfyM9sb1S7Ki7Fjfdb/ozI=;
 b=N+kS89g0hn0YQ0bh1Flv4dTkyPxn7QZ+qU+aNzqEPxUve0vsQZ+D+PnumKmniatKwa/c2A8lOPPrpduUSZdzeJ6/D65qX5ZHxioN5KMx1FtiV4DhIZkzwO5F1xwPxauNvpepB/va1a0EWvPeZChp4DH3FOau5VyITx6h5C43RHAvVG3tJ+F9EyCNk8r59lyfGpF8XmCp2H7HZSz5UfhufkB6Izg8I4zl1hSxafkrxgrwB3NUIB/3kGvje5Wrmfe2J8Z55b2d0JzbsTmeRf7yHtt5BXQf8USVz2unESS3mlztxkLIaTzREZteIKdHPto9bbH5KSMm03LAXkfXcan8Yg==
Received: from MW4PR04CA0214.namprd04.prod.outlook.com (2603:10b6:303:87::9)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Fri, 14 Oct
 2022 07:25:17 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::c1) by MW4PR04CA0214.outlook.office365.com
 (2603:10b6:303:87::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Fri, 14 Oct 2022 07:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 07:25:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 14 Oct
 2022 00:25:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 14 Oct
 2022 00:25:01 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 14 Oct 2022 00:24:58 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v8 1/3] mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
Date:   Fri, 14 Oct 2022 12:54:54 +0530
Message-ID: <20221014072456.28953-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAPDyKFq5hNTdwT7CMvsxG=_5u+xvG2k3-PfbGhAbHfHbGqK81w@mail.gmail.com>
References: <CAPDyKFq5hNTdwT7CMvsxG=_5u+xvG2k3-PfbGhAbHfHbGqK81w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|SJ0PR12MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1c7714-d7f1-40d3-5773-08daadb53dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJQLl9vAYbRpA6DNWhxqH/SNxVDUN9dHbTuTCvwSq7sMRwQo5aje8IcXWrJoK+Io4PxhC0p4hmsmTlpxpoNETD+WmlYnw0JbUFgCbZCcQC3LS8eVR2Xh+YFamQh0Mxy9DlyJj0dwf7lA1727OoC7vbzR+S1yaHJCFxiAn5OgDodrTpaeC2zkziN1378m4d9j5cSvgu60hzBQlODnA9sQFbFyl8q+WjRx52CzhbLAfXX/uwW9XM/703mm4l4UxmNTemHaqODFqIRojy6jzHPKxCtpqGS8OtrhvHV7qCbSBsq4BIP3bRuS9bOfAPuB0jnmKm54qSUWRVwH/9UsW4tw7fyJ/KqEpLkIm9hdpUT7LRccK7tqlx7SyzCacSZhA9QPeoZfjCxPyJrgoX1J7hKd/NToDqSf6IxWb2I4mUCSENPqwLfqhB0Q9iuqWb12hWHj9aHbWF9EXOMjOXEfOBBqHnm6ciJuvTln36syj/zQqmnKg1FTfIW5UbogMZPdIJmcyICGL8Ge7IMACAYdHpqH3xQEHscQDneQ0LTuPm0h6v5pXOnkw3dp915KDbz+H2tmPyNlQZjzNyQRagoikjK1PKteXCYkn+z+u/AqA3x5zJAOsGYrVITB0F3J0Xr9DIcTRVbJhEw6aCt67VWMUmLcicKOqvRQMy9t+3Dlzjl3Fte/C9Htjh9hobsG4nZn3ENLllVUVs90wUgvjOYF/quWqFnQBa9vDzzVegEmlAKIwaMVIA203jgh3RAwdmtIKZwJ0o3eqYe1cYv+CoDN4DmUJg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(54906003)(356005)(316002)(86362001)(478600001)(7636003)(110136005)(82740400003)(2616005)(40460700003)(40480700001)(36860700001)(36756003)(8936002)(7696005)(47076005)(336012)(1076003)(186003)(107886003)(5660300002)(83380400001)(6666004)(426003)(70586007)(4326008)(8676002)(26005)(82310400005)(2906002)(41300700001)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 07:25:16.5124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1c7714-d7f1-40d3-5773-08daadb53dee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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

