Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C3B611231
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiJ1NDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiJ1NDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:03:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274191CD6BA;
        Fri, 28 Oct 2022 06:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuWvNak7KHI5a819+uAdreNt5nNEOuFK/H8s7xfmmSkCW+8j6YxUIbyviTOrD+/x68fuBnimHqoCQnUcGpxhzy36ZNfPpoxDdR3oqmdnQbIzrcCYud8k5bYuYGKoho8vRrIVhR49VaF+9xgfbSSScx2RC7L2MkMqFA/bJBMKDmmCFqoLl7cyxLhfh29WYtSxsvaabTTg3nPC4Epal+mFMCG4CZYOZE51s1M/H/TllC9Wa4sMLyZavHT8bXE7Z6QtMiQV8+NUEvaEL6POpQHr2I9p9MWBtX1I0807J20/PuTXhN190MdNvXFQ3R2lvAlWp8MAcTjIBrzj+LZiR8UzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySAXZuQxT+OaejFFBcyvnzs7QYtblFhBELXJC0YqmDY=;
 b=NSbrVZSqA3ByIYOT+z31BHHuRSrt1FX3fTbwfe9GR5u6Ks6XiMvKmyB8hpe+OMNEOzDH59xFMsYuXdsouAOVHvfUCGKpxbnmCFN08BzAAOUU/h62LIkkHWDIhuMXnEEVqZexmpmeZ6RUCEfEMWscAZpvLjG/Aej4TycsmAWUzWABjABenX6kGIFcLeCcud7NqBmsVf7QbJLWG631aqfd3gj9jTrN+vDIlq8QGdWRFNEAdhbgQgHamJSz/2OJXiRjAzq0dtcSCktT6xmHMNZMKRi4vU+KlhN3C2BmAwVFABsLv6BDnh4mSAcRGmSF/y10GHlR0SP48+PAdkPJBWhzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySAXZuQxT+OaejFFBcyvnzs7QYtblFhBELXJC0YqmDY=;
 b=XU/+6A13UlYl7XVLtqNQ5B4J2MKbz/jRPGrs7k8b/6JHwpbUQy+tVY2Hgto65EENL6pouHjuM8R5vGrGQ7ZnHylDJL9kE9Dl4QgpET1ixdGXdz++3t1uIuCxSgjC6rzWyzD1J2rEFL3DVN0BaxgBBt1xzP5FMzKvOkPI90wPVvaMHLDT0QM+wOV4OjW/Mb1nir60SRmXEGqp5nt7s/SUyBkTZ98CizzjLVAvq/w3/BnFgEfHuzcjS+T4iciTZGTGPVFbbuq5r9TMe8rnPnIM1SE5IeIvIBZY2w1qGFpiruYR61qDXiTIc1ocwfGJZRNQMmFOd2bjhK8HqFla1epWqQ==
Received: from DM6PR02CA0087.namprd02.prod.outlook.com (2603:10b6:5:1f4::28)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 28 Oct
 2022 13:03:04 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::96) by DM6PR02CA0087.outlook.office365.com
 (2603:10b6:5:1f4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14 via Frontend
 Transport; Fri, 28 Oct 2022 13:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 13:03:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 28 Oct
 2022 06:02:55 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 28 Oct 2022 06:02:54 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 28 Oct 2022 06:02:50 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <joro@8bytes.org>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <will@kernel.org>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
        <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v9 2/4] mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
Date:   Fri, 28 Oct 2022 18:32:40 +0530
Message-ID: <20221028130242.20900-2-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028130242.20900-1-pshete@nvidia.com>
References: <CAPDyKFpG9ZjVTiK3HEqioDN8ksGpRYiXL_SLSmOfm9fjJfcrsw@mail.gmail.com>
 <20221028130242.20900-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: ee66c6cd-d88e-4f60-3b64-08dab8e4c07f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSg27F8FQmUT9tQK8pdqoMZ40bWbMALMBAURW03opyjYOobt5Ww02unMIQSTlLiYYSz95qq8JeMM1orqTCwc/6pjfhx159Zt5tKkNbBhTCTs2yaEHtf9YDfIf+gA+UQd6e4eXqLGLcUJ3Y9qMhp01oT2YfPE1tptexxomrN+OFuBgD6dFDwxZjNnWNF9TczpgjE0+J+m/hjHhsA/CWumX+GqUO8Hiah0kkxfJ0P5RrK3/QnBtwDdNzOduNhcxjviTvmm6Nk8W5ElVmMrqy1snHv8m/guiZpnbOVtrnPjwMwaMgc06Zt8vcRNsytX5EDfixa6Q01j6oBRSYzBKZm2cOTVS9RRCPoYUMjdXtghuJz7GLM0eEzADXKa6tWZ8H6mUiQ6Ztg2Z5a2QCKIwOjc+LCJxgOxd8FmZaxb1qhRjL6sxKRBmO93YrzP3FN7kFD9T77yQmEgz2qGWFoSL3+i7bF9C5MWFS0cS9LZqUt42vuPF5cgfgJx8TEN20797wH1c1KW31+v4A/5CCdZl/6w0jkk0OWOG8iCToOOwBODZH0bu3kzxMVGCFvOqhApf3A3IpRevvAFywYGWyK5+xjMedwvd6fmnxRVufWgmrop6PTzuNfknbnfN4jq138ANkuiMp2lzfrI1BB0Xw6b5JrMdrPQnGpOlXZrEicAlpG03ZPGWRISAnQlZecf1mpwSJqdCr6mCPd3Ow3YMG0eaj6PxnLAN6WOK1hHoRpvlVr/IPtk+Qekp222QQCMxUX2fxyuB/2KXCjQeSlI96cDGECG9g==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(7416002)(40460700003)(70206006)(86362001)(5660300002)(70586007)(4326008)(8676002)(7696005)(107886003)(26005)(6666004)(2906002)(36756003)(8936002)(41300700001)(426003)(36860700001)(110136005)(356005)(7636003)(316002)(54906003)(47076005)(82310400005)(82740400003)(336012)(83380400001)(2616005)(186003)(1076003)(40480700001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 13:03:04.6402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee66c6cd-d88e-4f60-3b64-08dab8e4c07f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

