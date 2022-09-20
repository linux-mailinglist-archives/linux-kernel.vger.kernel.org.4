Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DFC5BE60B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiITMix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiITMik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:38:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C0975391;
        Tue, 20 Sep 2022 05:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSeHCJH+zYpS/KS8tFq+ESSXoN89uI7iv6uRGuyrHS8OsINxmrE/SRdgTvy9or60gerd7EENIYIvj3WTe5M+swyx2g+sGg0roKSjuGoJEQQKg4z5AFQ/lOmPiO0vXk4ArIubBxMRY3UTcPIt5y+gjy/XoWMJ2I/y58zQ2cz1rMHDwsxD1LbbinX2K1BJIG9NrZpz1Um63k07sSU19oRKlsy7LYBvuOztZok8aMrwsL9DHGHknpW23dByVa8uE8HNFh0nCejEgyFEwK0AVZovr9NE4Vo4FWcbuJqK/QEBPtdqOlgjm8ljJ2XwivOubIPXN2/2YAlYwknv7dvXsth1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbHzK1weJseQqzFVF23W4aXub+Q3tmeUopiOz2KuIGQ=;
 b=fWCktuiLcDDUkmmZpV9wFwfDfJnLXnycFN0Bjs6c5TjXM/CqjL3IARC2MJalboVYpgVnHqh26P05wO0xPy4t8noZTCGAcEJtZP1VXKAFyJxoflNGHnT83/GSuYrlNWrHiBxbb6G8DljLfpDZb+1808TfpAqaEfoFy+S9x1XRdqGgNmH+wxP2/OmwPlcq/SMaiY16NrMhAq5xR0qL0eI45Ob1OG1M76dRikB1gntfSYqqNCwxU6mjFxMLyKaUGs2Na+y4j6gNpE/lWTj1rnoxyn13WhcDQGVUFNqvXVVwLTsh7cJZNb2rrqYFRbgB3hPFVYM4rctY0IsEMTsaB3XuAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbHzK1weJseQqzFVF23W4aXub+Q3tmeUopiOz2KuIGQ=;
 b=m0tkOzjC11UIwsX8qnK0twLDvjWkznZ790fDCk+OMRA8/5SkIPDPFPd/6kau/YhzNljeYjWJZBEK0OqtXfJWqYhfYgITmM7XPkVA1mO7WboJ4BUgN6kWUHjQNoTxxyioynTQrXj6VUIiH+xyL/fOsG3MrGOJisRp+p7LIz8J3U+1UlZ1iXBi1wPyBbnRP3PZrBDTIXUt4dHbcOPXpNzBvdE/Cbw+z6xf8LUiH2OO3009CGfAu6keg6NUZi0C8OfCRIuqSjlaCm2X3jvGW1qOqCnLHKn2A2+XSG8AW0epjJgubjrDBPD/+IHw3ydXNJcd+9ck/Tt7ZJPqOhyOE9bnhg==
Received: from DM6PR06CA0073.namprd06.prod.outlook.com (2603:10b6:5:336::6) by
 SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14; Tue, 20 Sep 2022 12:38:36 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::f9) by DM6PR06CA0073.outlook.office365.com
 (2603:10b6:5:336::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 12:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 12:38:36 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 20 Sep
 2022 05:38:09 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 20 Sep
 2022 05:38:09 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 20 Sep 2022 05:38:06 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v3 4/4] mmc: sdhci-tegra: Use actual clock rate for SW tuning correction
Date:   Tue, 20 Sep 2022 18:07:52 +0530
Message-ID: <20220920123752.21027-4-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920123752.21027-1-pshete@nvidia.com>
References: <20220920123752.21027-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: f898e7cd-5295-43f6-d406-08da9b050986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Cv7KUDiLCeDKc4zz/EWSmZ5WYZaFFUtLQvMssoo4SC/t97kr2WIPlwbbx1cOn9BXVnCQC59JqzcIA0Tp9ZZxreObfZwu2FRIL3oVghuKhibRhwi3CItvIRtM1o4Gi+XU1uTqiUNu2jhBeIdn1z0gv+YtO6qRwLo34kHDN8AfU/3t6dHyOfoFojtKfbRtLQeCiZoja39KAls6eExDgwXN4oZnQZpxDPs+r3BI+raHa6e7Fm9t8lJ9AJMT0GVUbUH2LIhyshhD5hTr+OUpRK3EA0LeC3PwsHaDcZGvFC/GwuxoERk9yHau1zDgC7aTM3jv2BvTmt8DR7aP51gLgd85tFKhGxZeE63quO8UggdZoAbFa2xquzRwukcXDUFUsdJHodDljivkui1k0sn2ankozJ/7VLjrepwIhKgZAFuGMY+KGLXDgeqx10k9MLa/wpkNI7N2CtC7lxFrsTZ8PQWE/2/o+BN0Le73C0eRidz8Pw67It2G2umBNRnLr+3P2Fi3wp3Yc5Qdv9QWDjtlghqyrsK42N4X/pk2sxsOYe0Oi4YyPHYMTZzQr4wgeQx2po3BDZsftCy4s98XktZUP66PAufS1zA1dVpKXwTwfVHo+22z6fznajMXywZ01TxlVbyjIDsd5qVCBbQqhO3OQ4TtVW/9CeDHnQAq8pSPVzhObLdTQlCnmtcUq/R1sUgEoHPGMW0tt3PqxPPfGuqQmEo4QkkUC/8A84aay8hztFhzSWFjS6nvcnykBKowJKsOcvSrzxW0aINZpLifxoRP1dz1Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(7696005)(86362001)(41300700001)(4326008)(8676002)(107886003)(6666004)(8936002)(356005)(82310400005)(7636003)(26005)(478600001)(40460700003)(36756003)(70206006)(70586007)(54906003)(110136005)(316002)(186003)(1076003)(2616005)(2906002)(47076005)(426003)(83380400001)(336012)(40480700001)(5660300002)(82740400003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 12:38:36.1913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f898e7cd-5295-43f6-d406-08da9b050986
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 58449e010a9b..10f6df070456 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -780,7 +780,7 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 		dev_err(dev, "failed to set clk rate to %luHz: %d\n",
 			host_clk, err);
 
-	tegra_host->curr_clk_rate = host_clk;
+	tegra_host->curr_clk_rate = clk_get_rate(pltfm_host->clk);
 	if (tegra_host->ddr_signaling)
 		host->max_clk = host_clk;
 	else
-- 
2.17.1

