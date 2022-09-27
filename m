Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C6A5EC0B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiI0LOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiI0LNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:13:49 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2087.outbound.protection.outlook.com [40.107.212.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB3F1A81E;
        Tue, 27 Sep 2022 04:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jt5gvz2u2gM5/vfzDOhIqcaYeiN1u9e3mTI9dZl9MKvuQjb88cmQQOL5KjDNX2eWVQeeLu+yevFvJsN53sUVuRvpUHM6tg1iC6s/wQ+eHp2pjHNpFi6VfJki3QbR2ozR4dYMxHl+V2mOLtVOK5drITxjVOibiNFpOxWGiFruQItVuK31LNPTeSB5ZJe04lqdJSKSLlVTWjQvA8kH+VYF7SbmNG+hxqDl0z++mweQ/VSd/6XTqKt8kchjhNdv/I445zfFxDHenO/QIhgrkf7MQ5Caqul0z/x4D6r532ddi3JWqEqHNsVHPIJYrvBrLKQHIm/KyOWwADAZkBcwAUOweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrH7mXv8Qhft7UcA4wqYTG7iWuUTiv6yT0sZS4USblM=;
 b=RJlpLBgxsyLr4/ze0TX3pCcRHSOJEabsw05S6e/6J4kRcxhZTNZbkhXPMNnahfoyX3b40Q8m1u0B+LHt6f30ib6fe8VXefsL55QuL8lgTSUoaPYHB5r+dfQRPOQdXY9Nlo4pwerZ0Uet3DZNDPCTMqfcqilMrQlELmcT9IogFgqKRh5QVfiHJcNVzJOZ9psvWM/JCfiFK2M5kQyFTMfxPxHxbGh4Ep5NtsDlmbWlkTpunTB6vb0VLB8ckr6IIF2DwrhFm15eu4cTYszjAIzDGERMpxW0GFrk6VfDH2Oj9b6P8zqGKLxp0XUPxNVTmh66dN+lqCQDBT0JPokhFIJInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrH7mXv8Qhft7UcA4wqYTG7iWuUTiv6yT0sZS4USblM=;
 b=of66Vn75nQqbr9c5G184Og6Mo5gzH6sK8q/U7+ufz3JTLaewIYNvd0fhxRS2XRLKq2IJm8XEUVli/mjRBUzSn2Dn4LB4ju/hDvbCZmur0TsvEaL7qfMAT4/MA0wu6JxJcmEms+NK1Ufg1KF8Cv6y3mQS5hojj14uKcZN0w5k5FgoXGnR8IV23USAqsKPXs6cm6o7en44afdAP8N42wTGinBXHlWQ0omno2yBckocsXvseyi6kNYrPTA3u9TmaNeHpf5X4rYzIoG/2FD29LMZ6j2b4RSCAYOGkwX56btYGRsNpJE7t/4ZggPVhyivq/V2YIUMGJwLU/iBJ5sISWuehA==
Received: from MW4PR03CA0117.namprd03.prod.outlook.com (2603:10b6:303:b7::32)
 by BY5PR12MB4934.namprd12.prod.outlook.com (2603:10b6:a03:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 11:13:47 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::a0) by MW4PR03CA0117.outlook.office365.com
 (2603:10b6:303:b7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 27 Sep 2022 11:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 11:13:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 27 Sep
 2022 04:13:32 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 04:13:32 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 27 Sep 2022 04:13:29 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v5 4/4] mmc: sdhci-tegra: Use actual clock rate for SW tuning correction
Date:   Tue, 27 Sep 2022 16:43:14 +0530
Message-ID: <20220927111314.32229-4-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220927111314.32229-1-pshete@nvidia.com>
References: <df68846a-2a09-ef98-6823-d536d99ccb61@intel.com>
 <20220927111314.32229-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|BY5PR12MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 501c43ff-3f26-4f1b-3e5b-08daa07958e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5bLpRWPyqq9dDj/l0fHpXSZAtVtLrMD4QGBz36c0jWYmHZ7pHVrzeP4KJ7nbGXQthKXIQUihEf8DBS9I+HjD7aBJ7r3iKUGySC0mEy39yMyobjDrfbjT/lie3wCldsAlBhdnK7Fb3wNQz5aWfEgrRtxLCSj8FmUsSdJRHpF5hG+gW6cNgt5NW17nMh7ccDLtohvGBZW1WKrsqynMCGIbZR3zmd9YxbjHbHPqeFxKZYjMoDqEGDfmcNaz8CBIzjSa+d5Ke4zKIe8qHpiAnKzDanQfOREMqghfoV7gYceFWXx22+8kI4tx1i4I96FZKcJiSDEpV0tVMntl2UEZ+bul9kPdhbnc/Ukhd1oTuMiIiOGJj5uXEk1EcEZCrnv+cqz1SW+1QZhvOi36QLgGKDDLaRB2MzVVITOfKL1/8l8S12eOwtxyYkAdDwtmc7lEomfZK/a2vK2+dd/aBO2st4m5GIJVLkglKxG2K0zaBIKey+EnXmT+bSbb2gfsFFMeMK544B39wUYM7BSKdn3N8i5K8PRP6QJHAOz05r3vfHT/fox+fNR9C+uOctz7xBUEASlW5qeTR7Io00X5IB1Uhdl9/VDAz53PV6FOGFOxvr+Q03984i9NmPnCOvM40PtJRg6MAmzYe4EHHyrFNL9rUbbMKNHGvg4Z0b334CIEbslx1pRD0eUHoLCyAFtPlpnU3a686nU8quNinaf5Vhh/fgfcO3nSMcoihQ5GhZdTGByNMmevxpRJP9nqruNmdI4CLXPmHtoUQOyaXByeHEnw8wD6A==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(86362001)(7636003)(40460700003)(70586007)(356005)(82740400003)(70206006)(4326008)(8676002)(41300700001)(54906003)(110136005)(316002)(82310400005)(2906002)(5660300002)(40480700001)(8936002)(336012)(47076005)(186003)(2616005)(1076003)(426003)(83380400001)(478600001)(107886003)(26005)(7696005)(6666004)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 11:13:46.8027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 501c43ff-3f26-4f1b-3e5b-08daa07958e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4934
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure tegra_host member "curr_clk_rate" holds the actual clock rate
instead of requested clock rate for proper use during tuning correction
algorithm. Actual clk rate may not be the same as the requested clk
frequency depending on the parent clock source set. Tuning correction
algorithm depends on certain parameters which are sensitive to current
clk rate. If the host clk is selected instead of the actual clock rate,
tuning correction algorithm may end up applying invalid correction,
which could result in errors

Fixes: ea8fc5953e8b ("mmc: tegra: update hw tuning process")

Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 61dc5ee0726d..8285b979391d 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -784,7 +784,7 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 		dev_err(dev, "failed to set clk rate to %luHz: %d\n",
 			host_clk, err);
 
-	tegra_host->curr_clk_rate = host_clk;
+	tegra_host->curr_clk_rate = clk_get_rate(pltfm_host->clk);
 	if (tegra_host->ddr_signaling)
 		host->max_clk = host_clk;
 	else
-- 
2.17.1

