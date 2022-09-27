Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0285EC0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiI0LNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiI0LNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:13:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A73F24951;
        Tue, 27 Sep 2022 04:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmUP4sIGMFjZac8kJFGXRfTd6v1Vqa7qK/OL6aYoiAyGtO4QmbYWSJ6sYVlhVhBl8FqRDpZVCQ0DBAnbl8NLSO3BWxRlqn89znGtiboK/69DaI1PkijsCfPnRn2BfYe43n62LRVYQjXDu5IfZjiYLO1vvyaqNwC/Xdw96Tw1ZfyI+ty0mfp5z9O2XSUeEV39KputdddCie3ZEsQQwd1DDqWIzvvE/Wj4lhqD1/DOuP7LtIMSo4QNwXWdzMHoy8YNbLdNJ3S1XLqvNg3VNKQGqWo3JW1HXts8vlK77cvMJSURtRWTDi3XA1e85Ei67KcooQ4WCCsOlFf2hi7M57moJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt2SFqLcav+hZ/lBpn/7PhfyM9sb1S7Ki7Fjfdb/ozI=;
 b=F8u6VKT1k8x4+UUH2lIb81qTpkXljRTZ1nB4H8jTJU44il1+DdQaZDqInzG5bYJit7vfCE3r6/dwrbUL3p63HwDY6DaMotCx0pI+XWg6YIZjF5CAdhIGshJxElCFA2Yi/WYY19VtCsNPdxlgbyN0hJ1ztab3xN0aNAguy+ISwjjenWY64pAN7u2SACiMEoF7OMTXyBlggta7hVnkQBTMyhWCG+GBaVuhp6+gDn4VzPiguyKOxI6T++rhDeRQ4dK6IQ3sEgnS+TUJhS1QtArttgZXnap2eENlnPUc1jq3CELfplGLEUNTJE2Os67OFRIpnc82ufpWI23qfnrd5Rj0MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt2SFqLcav+hZ/lBpn/7PhfyM9sb1S7Ki7Fjfdb/ozI=;
 b=PWyLpHEsQHJ061/PR/HXkciAJeOCVYNF3mypDgNdZ2RllzroEwh/0r8GJw37FWRbRqHpKJ+/X9sRyWFE62FBky2nrUErCE+4m7L8GM76RsJrUX2fryk6x3cV1OL+D6UaAFK70kB3MUDJjrAEzFSNTIL/a6vm8SXNKAFdNVw0R6Iy3Yh0i00JfGMUT0XKadh/rnPWRiaS+jlMWArT1xKnvTGTgLSZfbmDbppQeUIbk0aYGm0U6tojH63U/fNzbgrFBUxEXMJg+ocpbDBAkRu33nrZraaKcTqpTqtr9kt1Kf2s4fsGB+XX9JEyA6NNm5jvG1f+HgzgrV0XENcq8BYBEQ==
Received: from MW4PR04CA0179.namprd04.prod.outlook.com (2603:10b6:303:85::34)
 by DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Tue, 27 Sep
 2022 11:13:27 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::de) by MW4PR04CA0179.outlook.office365.com
 (2603:10b6:303:85::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 11:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 11:13:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 27 Sep
 2022 04:13:19 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 04:13:19 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 27 Sep 2022 04:13:16 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v5 1/3] mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
Date:   Tue, 27 Sep 2022 16:43:11 +0530
Message-ID: <20220927111314.32229-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <df68846a-2a09-ef98-6823-d536d99ccb61@intel.com>
References: <df68846a-2a09-ef98-6823-d536d99ccb61@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|DM4PR12MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bdbfdec-a796-4349-40c9-08daa0794d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHawTeGMLXtwCp1aEE3DafoiERzzjErpckGQXAVGEJqFRi42Qev/CUyPNTewEXJrS+T6aU2dMHpWQEF+MeKyQx97RjxOVyXa2xBhD0iyZExHRqDDsdJwify+BC1ShwS9pzTiPFiL3bk0impjF/+kEpwQuCQpaB/Pl367hEzZoG5Gj6rZ02ec0VR0iYI+sclEcR1udztpxGzjycudT2ygx2XNt22VrfPUFH0trkquS2BSxkjp2p73HZxsDFYwxi5PO8Z1VKPCQ6lG+RN0NzCeWNPA9IddoLCFFLxWyiT670ew5poOB20W/Rl08W/JUBrMqVJxdtE2zw9yv3BLm11kiXjOtheALhra7poJoJLn1AQsVVXQUFEkTiWB05Clj8kXrRQmZSP9LZvGW4/AKt4HiCeRNl9hWhWaW/zssI4wqU78BUx9CNgHHWzOtZtWEY6X0Y+ywxySwGXAYnvxDbryXfKLbuyN12681jQKjc+axSx2BJa0s6g1rf2JEACmubKuZbKbnl7k4Qm4qIX/xAymowpLNkKxN1AOOlUL94G/rAZdU+5vZ8TlRJoRvoYTM01dHoy+e1T6wpCxabHEF4cFo94fHTyyGiq0yO+qA6t9FAx3lcjjZKXu7eMcQ6532kW3OruelEa1nDq5wFx25HwiotnbAZwd1i37IKKDGONeXZe5ACkpTMiJUfDhR+99onlcvazmMSplgxSSk0FrgXZCjelRTkd1BRgn/g+fWpdHST9nrJZ85nuFmntbFOd78MAqzixWgSd+VeeFiTOSv4J9xA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(7696005)(316002)(336012)(82740400003)(54906003)(110136005)(1076003)(186003)(26005)(8936002)(2616005)(36860700001)(86362001)(2906002)(40480700001)(41300700001)(83380400001)(426003)(47076005)(8676002)(4326008)(70206006)(70586007)(82310400005)(478600001)(40460700003)(7636003)(5660300002)(356005)(107886003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 11:13:27.3345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdbfdec-a796-4349-40c9-08daa0794d46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

