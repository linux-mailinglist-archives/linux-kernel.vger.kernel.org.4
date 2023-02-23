Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA666A0B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjBWOOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjBWOO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:14:27 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E953E26CD0;
        Thu, 23 Feb 2023 06:14:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gi1DD7NGWf2ivqVbJ3Fw0Gxf4OaXYRCco3nmF5UIGOth6abPayJM6XlVIOiK7WtPanb857fh8DvyRK/aSGA/o/DmboZgRbiu5qeo7ZbFi2UsFc+rYLJMBOKzUkKILEbYtUxHVGZTjWY70dp+w+rUdeTIHa4ScvkBBj2JvQyh3kr/27ejk7qAWLpyduMmZjzwILACgU6dYIJEiNcRnld1oPS9+xGtjyMS7o+sRyjbA89MipkGa3uJyfdCw7N12hfcGrq5sHGLfS91io8tJsGAfNxkoBai7McuknQOvxUZlVl0jecPzIX4OS8eUvv84Heq+CvirdyxQ37aLlE3jwG+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0c7g5hltWK5WiLGYgI8RABl9ZTU365m03obYU21rfAw=;
 b=jQE3OBtfT3nNzYukCWPFkLuIJ7rV5q3ekEEkLcoogH+E93N+TXtCRtV0B8nNB1QMiDJsbr5TR6Auq9DCV//3PQXr/w9Tt2f5cPAS3ZRnRavsjDaVLL/mf3ONAewSo9aWn4PFAQCkxYBILF0HqKLTJIooG0o1dmZpGsllefFCu8vfUNP7A+pdOlX/1VXijDum7g/e/9EHqheZhtDH83HFLFoNI/RaCyDzjXJlESXIRneAIlhDzmYXk1UTD+C5N+LxSc1Re6avUtHunazUXPuytAO0c9uVqpdZ1zLIppx90c6NBEH37437OMQyWEJW7laiGgXYXX0nLjv9J/+qMDFfbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c7g5hltWK5WiLGYgI8RABl9ZTU365m03obYU21rfAw=;
 b=fwc1Kmn/w2lI7a11qVTi9bEHnkM4jcpCh8tBRWl9Os4NWCdUrkZ7YFe4PTYn0o+KGsoI6AtXNsbYztdGwVrmSQp7YQCTv9y9uWAZjBT9PRPYoW2mPkiqwsJ7rpTIFUR2ABtAOcxSJM6ajmzpQSMqaCTLOnyT/x3Ckh9W94POWh4=
Received: from MN2PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:c0::37)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Thu, 23 Feb
 2023 14:14:18 +0000
Received: from BL02EPF000108EA.namprd05.prod.outlook.com
 (2603:10b6:208:c0:cafe::79) by MN2PR05CA0024.outlook.office365.com
 (2603:10b6:208:c0::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7 via Frontend
 Transport; Thu, 23 Feb 2023 14:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF000108EA.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.14 via Frontend Transport; Thu, 23 Feb 2023 14:14:17 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Feb
 2023 08:14:17 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Feb
 2023 06:14:16 -0800
Received: from xhdswatia40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34 via Frontend
 Transport; Thu, 23 Feb 2023 08:14:14 -0600
From:   Swati Agarwal <swati.agarwal@amd.com>
To:     <adrian.hunter@intel.com>, <michal.simek@xilinx.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Add support to request the "gate" clock
Date:   Thu, 23 Feb 2023 19:44:02 +0530
Message-ID: <20230223141402.23979-1-swati.agarwal@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EA:EE_|PH7PR12MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ea5912-915d-44c0-fb70-08db15a84005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRaKgH28ig3raBsCUGp/AaeE6KBkfWdV0yYUmFvNV5iEdvdWFFs0EI/lJh+LWoyV6AASHBoImd/ityP4pZyAVa0X4b1nwSNddyybac2itqqTf6HDYoDaaEq3oioOyyja64HGbXjWKE90Y91AEC3pCQ4HC9DZdb8hhmD6ZHS2CyUgJmi0MVKmdDXw0nA+Y9aEYvUIUKGWMweAF5/OyAXIESIsKqYDoO+zCp7efeuggW14LzZ//bgyi6iirBQFEiF4UEh/9+P2Kga4VuGy4ABtqiCNAOGvZXgQR51hGZ1w8vWtwCzvbSSii8n+w85Vy+I/kNypMz852HB/8fG0aUGYjWjK44HH7fN86c8rV+D/28KhOJLfVjB10DszQQ5UhlMcgRoVLnMnBjYReI9RuYLkf2YlAnygM+CbXXMvEJNCGnGUMF9LL+L+ZRJaV3Lr9I86tklbwGk3AIjkEUwl9+JTgPGqj2IRGFISJV/CGzJ9TYPIZ66M1ODtHXhQwDM0RQOh+sy5V3IaUY0/n7RD8RYJ2eAwNTjUYGIBORa56S1Y0aiiLBaGV+rLIJB988Rvwj8AYQ0rtuq5003htD369ny3CmnWHHTXB+WrICTtQe55ti39WnpX2Pq4kmvl4thbp19K8F94g1wzBNnZTTDEMq3Zi1B8EA1Qa7hZNLBLWEcMzpiQg1XOn4JF5IJ0HCjHyuQEuGgtDSZbngXGGpNROR9vRjduzNR7bskKSPPDEbkG0rw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(110136005)(54906003)(336012)(2616005)(6666004)(36756003)(186003)(316002)(40460700003)(26005)(478600001)(40480700001)(86362001)(1076003)(8676002)(4326008)(70206006)(82310400005)(8936002)(83380400001)(5660300002)(44832011)(36860700001)(356005)(82740400003)(47076005)(2906002)(426003)(70586007)(81166007)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 14:14:17.5567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ea5912-915d-44c0-fb70-08db15a84005
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to read the optional "gate" clock property and request the
clock which will be used to ungate the DLL clock.

For Xilinx platforms which has DLL module, dll clock must be
ungated/enabled when SD controller operates at higher frequencies like 50
MHz, 100 MHz and 200 MHz. This will be done by explicitly requesting gate
clock from the driver.

Signed-off-by: Swati Agarwal <swati.agarwal@amd.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 4eebbf801b41..1fd7528c14fc 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1870,6 +1870,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	int ret;
 	struct device_node *node;
 	struct clk *clk_xin;
+	struct clk *clk_dll;
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct device *dev = &pdev->dev;
@@ -1943,6 +1944,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto clk_dis_ahb;
 	}
 
+	clk_dll = devm_clk_get_optional_enabled(dev, "gate");
+	if (IS_ERR(clk_dll)) {
+		ret = dev_err_probe(dev, PTR_ERR(clk_dll), "failed to get dll clk\n");
+		goto clk_disable_all;
+	}
+
 	if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
 		sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
 
-- 
2.17.1

