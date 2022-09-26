Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4CE5E9E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiIZJuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiIZJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:49:53 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38078A199;
        Mon, 26 Sep 2022 02:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlNivb4H0huDNEL9k887ukI8+nXdBOOFKi7DbT+Jh9ruiPK1u4M4t+htMkLtAJ4A6FVUaa7vxBF6rdFvTV3GHII5Mw0HEZ2l2S12z/45/8c/BOCJuR3h6tVw2OVYc1nrD3tURRoC8atjExDfnPHYB3E5T0XPlZaYy4BaM7QpyHtqC7kpE972jTXA4BFcpmgRNtIA2+tE+kVRBCizbufOYOZPh2T0ae1o5YN+KC2bPx/RLvOkZsi/ozSzUE+ATQDF+SuNSCMo4ilRuIAuyvwyIPQgvjWutrs877cwCMQUDLJWhvr4AIi1UCXlskg4HokOGhpugKe+KlvsMDkg+B0PNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrcKnIJPvv0HyKJzj4fq1Gvd+67OqFC7mDjvryyWuhY=;
 b=PYROytd7mZgC1a9gH2vaBrxtLW4oI5v40y7iBKERpDvtvUIAdeKEQnwTt9bQjYU4EpUSK4vv+FvdfY3QLmwGHpvCPklim395y0WgT9oPQMqMOAz4+7A/ctjkQt0P6J8EFhOS5rjje5tWDkJ4x08LsVL8R5OWjqP6CTpdsHwEXXFM1Ggk9Ge6cbUoV2ALSe+L08jqztRAdOaLytJb94Fl5ZPb5omZZnnGq/RN2kZ+jLIBU6T5HdCLRsaoqMVVmxFsDR3IQrun6nHnPqcV6yWL5/hpt9MqeKL1uUVGhS/jO+UpsEzaYw9P4i7lAVKTTu62xyxGWAIwy7MChdsQrkxx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrcKnIJPvv0HyKJzj4fq1Gvd+67OqFC7mDjvryyWuhY=;
 b=k3p3HZnYkkRaytdc3yoY2MbU+/iM9x7rPLspIr6mr6C3GYqCg3ZiPBmjMnROYlZZh2mbVkuuwdRWUfLzoItbFBs1WSiefywOAF2WXABjkGCBuDzGj4DyeAW8WmgIukMusbTZPjnD/VM/DoxW2rb+RDOxujJbvRlP79Jf4r6hED9kB+OZwTD2OOohp40KOJ0HdTyfNRr0T/IbJi4AsEuIUfZ2yENEPTxgPLb0GMtlgvk9aQ5DQhvP5dSsy7PKhIg+c5Bubdy7pU9PTRum5aaeNNBKBIrGrWIpXA009bmNeSUcvW26W9QauIyarCt6rN8np5NpoDhr6+dRc4xyDy95IA==
Received: from BN9P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::17)
 by CH0PR12MB5282.namprd12.prod.outlook.com (2603:10b6:610:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 09:49:50 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::b3) by BN9P222CA0012.outlook.office365.com
 (2603:10b6:408:10c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Mon, 26 Sep 2022 09:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 09:49:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 02:49:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 02:49:34 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 02:49:31 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v3 4/4] mmc: sdhci-tegra: Use actual clock rate for SW tuning correction
Date:   Mon, 26 Sep 2022 15:19:06 +0530
Message-ID: <20220926094906.14537-4-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926094906.14537-1-pshete@nvidia.com>
References: <20220926094906.14537-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|CH0PR12MB5282:EE_
X-MS-Office365-Filtering-Correlation-Id: 18acefec-5c8e-4605-8092-08da9fa4745d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNvIOhB0Ko150R7wtczjqpS+3eTvrz1zvViMlbydY0H1rRZOwgZVf8YTcIY4qdfwJGfyud2hmNtEbx7wM060buFTpXMuLCNyjG2J57ByE3zj1saSniNQM7uXz+1bGrYRbz3eQZUuRWAiIExCVNb/b8Gq7iwvPvTaTmhQUzOnX/z85RHSlJa8wbM/z6656WQTExWsm8/wENUmR/E1+bS12gxV86zkf8hIIK7qyhY6qRd6Y/BRtUfxZXEg83/vMH8IN86u5e2Ver9NFLnSs1iGpCSiUry/avr/VRZFxiqcjrzhnI0UrnSLK2y6M3MHTBr+FgxvYYOxcsYnBSfYUXvbHfq2o5mR1GtMzOPZQs80CWkR1w5rWUNEp6EUy9xGH8JloSIbCzoOkWkHL8svthatq6ZyG+CEXEldtZUSLUkQBkmn8oo+k5OM5+elhS+dki9mD5sUjz1J44Ke9xmiaPjbHaqDE2+Bkq95iSsrgWKXRTe0++bOWFQZoQ6xm4WOaWV+1dHw6+lMiBL8dYq9NEfL0mJcno1NpyVLFCkFiMMlaaJ9Lv2ZP7Zwy6maQymhFXyf9CuXhBvui3bpGthDTERC44CIyi44LkEpD+juXzf+QeyqYpF92+JT+6LHY/BTNkCg5LXq8gJJ1U4pwUUSkgsGKwwDCoqOYEw2qaTWLjEceDXWkWb/PeGwox5rrXHSOw8yfmw3MJgVJfalaWXODTkKNAncHIe2mppkqVrkEBjPy+xzJs9tP1bN3xISggkp9zAy6JxrB5dhv0wVy2oe9mnltw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(82740400003)(86362001)(7636003)(36756003)(356005)(36860700001)(2906002)(336012)(1076003)(186003)(2616005)(40460700003)(82310400005)(5660300002)(40480700001)(107886003)(6666004)(41300700001)(478600001)(7696005)(47076005)(26005)(426003)(83380400001)(316002)(110136005)(54906003)(8676002)(4326008)(70586007)(70206006)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 09:49:50.0053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18acefec-5c8e-4605-8092-08da9fa4745d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5282
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

