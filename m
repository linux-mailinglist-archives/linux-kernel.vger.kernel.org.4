Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDA95F6748
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiJFNHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiJFNGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:06:55 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B572A5734;
        Thu,  6 Oct 2022 06:06:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDw4Dcg5n6DRQIXott2G/RIPbn3Eq3klEqkxmmy3MlWmjbJebQj9Z7KCWgVO3Jty7Le8UsIRcmo3Plt2tCxgXrzQVDrvUjg6niHfMvzm1EFHj0YkMaaKaYAR2U3zRh2lAnlXTHoFGar8lej52wbsHCevPvuhXbw+vYotaU5efIUlGYobap9Jaff3Gfgl5GQXRV/YyGejeiVWizdmmGmQnmtszAFrogAkapRPGB0/wz0lxgoRPSBZoAuW/+hCutNxEWNzsPkz8d+L33Ouhh8dhH662/vmymNpz5tOzgbNUh0J8AuSg1uStJGpgkxlOQ1xtl6uxQUEcRhvwIxvmQMtdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySAXZuQxT+OaejFFBcyvnzs7QYtblFhBELXJC0YqmDY=;
 b=lBZLT4W3LOlmDoksTok5J9ZB/rTBxxjSEZ7z3jLTatl/knKsRo92yUlpzHhSJBPUJPrXFox0WQav2s+icWp8f5GJH8zXRcOiNl7YXi8jwfzcvKMipCRgAR7ukXQLZSS1m+BLsm06CJaDS27kzr3QQS9bF73sukE+wCiHb3c/7CxelMmHRoD1UNR5+yFyFOifG4+/n/Ke3C6dmOSV40zw+BjKsE0hh799ZII9jAzrWr6Zdv9UAyRP5hPc/mEvrRCzGV7usnaEubqImNoyLK+l8CHlBOdOlySxbRlgGSbfk1jNz856Bomq0iOl0DUvTo+BJ1qkUOm/ta4232bKVoub7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySAXZuQxT+OaejFFBcyvnzs7QYtblFhBELXJC0YqmDY=;
 b=Sr+UCXaOIAwB7GO2RyvReK268Mgn1V/8NB5X9/Goxpq8pqPqcWFNIOfZP4A7VWV4lCpMtpWwa0OlMloMyzUOVJ3cbiAjmnKVq85AHgK2lcWU727b6MK7WOF0MwVHFBDC1zywz1Sc9p8ig+yo+cqlq/ANuulG8JO+WSbr7GNoxulZdA2qZkf21rwboTQr6RcEzY1pm/CpFu9wOgTgpDmu5mQZMP6elmHXAGHKmn66p+BtGb7eK+CDqyqQ+eC36PabuLcWkMH8W1mBirSSB6K99e/+4RViu38Yt1QDFbrj/ZRU3F67EaQDzChjsrDEVvhpqdJiuigX9dQsRqD7MeDptA==
Received: from MW3PR05CA0011.namprd05.prod.outlook.com (2603:10b6:303:2b::16)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 13:06:51 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::9d) by MW3PR05CA0011.outlook.office365.com
 (2603:10b6:303:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.7 via Frontend
 Transport; Thu, 6 Oct 2022 13:06:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 13:06:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 6 Oct 2022
 06:06:28 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 6 Oct 2022
 06:06:27 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 6 Oct 2022 06:06:24 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v7 1/4] mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
Date:   Thu, 6 Oct 2022 18:36:19 +0530
Message-ID: <20221006130622.22900-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <Yz6zfrVq9cP/wrJb@orome>
References: <Yz6zfrVq9cP/wrJb@orome>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: ace4b991-020e-4661-868f-08daa79ba225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dlIx2B8+ypxAjI8FrWfp6eLGltb4WwMIzbUJV/rH79Cz6QlxHdfi8cQHMxrAZQw+eeSDzBMsDiyMB8ZUc59QjEjzep6PakQGkyLW0LEDpboqyzjUF8vnZSdRvUZGL+P3PInGfImQiO5GM3oaJp+z9AvE6PVI1eFFNjwTRDYHQ3ReOyN1nZ+G/trpe2JXNsSg9brgQzo8atImM5YuvJC30ozKhn3xcBigKpYbHyP7ifo7BVQIana9nzW2flCTcmV165Fjo4J1ttrrAdafcTxqvpt7gTEcduMkS6OhhSMIFuDfJ6czUx9P89xkdYXAx0GYbeoVSRjTDfFpM2XecgsytkQRtVPYvcKC+9nLO5So96VMJVbgLIiviqrD0ngOj3QF4r4OAAa1h59DHOyRQJBMV6CGISMM2i63CR4foHJJntrRC6QRQyTpHNA/sY8xwx+BqEb0f4WLwgIGypgf6nUSPKf+7z70+XD0fq2Txex7UvX+MHGzHkhU1iMex2JQ1lqBEN8aH4qJbqmeWB/+kkf+aJqaK783zgakqEZgMCcCictwYUajS8Rz6/Zm2PTu0A19be5iVJIetNSBsVwTOXNusGR/HIWESP5p2gCuwlutIkOMLg+frOBpqqP/ThUKP5T/hf35UvB7mbalblVRSrm0vetHCzaLsPDJFKe8sQRGaAOv6hSTsuipNF5R4qG53qBphT2hiw8TOjfgMHbHJ3LFxxVUnrTPLeRRNHZmXGALDJOmV5462zDs/xfuC2UL40iTsuoi3zPDYIZkUhFW14WQeQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(5660300002)(186003)(110136005)(426003)(356005)(54906003)(1076003)(86362001)(336012)(26005)(316002)(2906002)(40480700001)(4326008)(83380400001)(70206006)(8936002)(70586007)(7636003)(40460700003)(47076005)(36756003)(2616005)(82740400003)(8676002)(82310400005)(41300700001)(36860700001)(7696005)(107886003)(6666004)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 13:06:50.6609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ace4b991-020e-4661-868f-08daa79ba225
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
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
Acked-by: Thierry Reding <treding@nvidia.com>
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

