Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDED15EDD4C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiI1M5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiI1M5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:57:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3D17A772;
        Wed, 28 Sep 2022 05:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYL3GgTAOvuxFG9H2Qm0BXSxOfCucfgLRsLDnithHcrA/iphJ2dAklleELep96OIsOsRl1gtX5j9MgZVt8/+encG3uJGZN0RS9Fk3PLo1Uo6wrG1faY7aAHR8NMu7tgu4WJpdN8dFWIqT7YsNo3W/IYa0/VMIsvHOioJhV2yRk4S8Bg9i6C3JH9HXw1axu99FRAjcqNHDcIPZDWU8qXjwOhyQUdCet1T6TaDysN9pPEDYG9J9YIGpQhLrgc3Q1L7gDlSNhvkOL6AHeOm5I9JQEMN4nP3nLtaZ/+2jym967aCe3UYSUo+oj7mPw51pSZ/IVQ1fA65wdTEYDccjnQ7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKCgfFq9PE7e6kkKpq+JUrFlDC2u6h7iljFt2N9KQGE=;
 b=C3djpj1y5JuxStV/9Ayxk23z8D27+hwS+dqzbbPM0S2WgNWU6K/55VROwHMHmHZWIZVqCj3A5ixPO6SCvxs3YEkYXuPVznzLGtl2w1/ysZirOj2q3tsdNv5mHamXqGb0A8YvzqIvdq+ym3U86170pMKrYiQdKKI+Lkrnzfd3DO62VcOJZcBcaVLluv1llkZhHSViihI9hPw6dGxapZHtZGJGWGnr2F3H2pZDS7SfxLFOqCRREzQ/SUH7GZBUPHSTvBrSywhCu12vRj/qEauZKOXgL+sHRxOVWy8uXvSFDG+TLiBjdMIbhhQdNz9se5ZGzeVnCjqvA4Hu3ieUhMXLJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKCgfFq9PE7e6kkKpq+JUrFlDC2u6h7iljFt2N9KQGE=;
 b=ByaTUePZzt3u/bFHI3xKW+F0X+julheuU3urjbxXhDGV6vPQCbiRx8Zo4o+WKslf3XbtjKCgy7FF04P8D/NqoEmXmv9R/Bm6S2ej/UO0eHVbt4GBg5oGnfcbswFF8JWUzWSgG77ZAC/ndO0bj28dQuK43ENvj8xFBUiud7ccEtjTF/hs7QrAhqV2MKrMFSlvaYJXBe1SphfXU/k7Gl13PQvpTNqT0sxJtQ/7KdKMNCAOq3c6gJAJJJunLteF8TjI+x6TZYNMT7B9bCoZm1/PMtUZA+0o+ra2UxXjqr4bZU7DxGGgYV2AkVdP2/p2u2VlTOIrqvrBLqQVQgjxPiXBcA==
Received: from MW2PR16CA0053.namprd16.prod.outlook.com (2603:10b6:907:1::30)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 12:57:17 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::3) by MW2PR16CA0053.outlook.office365.com
 (2603:10b6:907:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Wed, 28 Sep 2022 12:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 12:57:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 28 Sep
 2022 05:57:04 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 05:57:04 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 28 Sep 2022 05:57:00 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v6 4/4] mmc: sdhci-tegra: Use actual clock rate for SW tuning correction
Date:   Wed, 28 Sep 2022 18:26:48 +0530
Message-ID: <20220928125648.19636-4-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220928125648.19636-1-pshete@nvidia.com>
References: <a5c231e8-f28a-e692-5961-58e6838711ed@intel.com>
 <20220928125648.19636-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT011:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 49027dd5-3e75-4a17-1898-08daa150f8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6Icy72QRsza3TA0Fb4igcL+42ovkFaALXcJEvwHFRiQpwGBCaMEYj2R/SACGcBZ+N0eCuCAtWg4JQ1xkWKMAEVF9GDcY9tCnSwGNgomgxZrV0UcjOu1+658R0FosDUEIgh+X8+j1lsIG3K5HltDUF7sGyjuHBDVP3znx0+2g/3RBjhkkAa/7okTfGKJ5bqDeGwwIC+JeifY4u2VaQB4aLs90qNELQt4UJVRtoVbjdDgq3vZML12rjnNM9PY5j/z9kK0z5xYtLpK9UueLtHDnnY6R5D63ietYQ4fDtXqQwv0uISyYNHaj1lTUp1UyRUqlcl3DhgI0ss/LDeBZftqClODrj/anAaQbH8BaB4mu7oBxuxNVyXh/GWcDYk+Mrrc+8tlnXej4v9qXKU4FQ3kvfAypCCX4vBj9OBmuGeFnmMIhXzMSPyCGRRAxf9Hr6l3SB5/RLDQ/y8lts/prof4aaiVhsULVC9t3u1vH3qSZwsLVb0tbxuoW8RrI1gQJdAqU67HvJOIvFfqIRns5Oizwju/XbQRaSKUEhfc9SdYGDbUL6YWGC3YiKNeC12TRmpCD8YHy91SBh4LHKu00bRJaaNjQHVRa2QR1YTyNMDZcw9GZD0s6z/rJNOmqmtcRqb5t3Da8eOnTtHC6ULptw56zvVx99ofErIGuV9AZjF9sZhJjeliwEbJcDUHz/kQuHD7qIKC/K4fYHl9f5Er2wKVE/I1bRjS9zxbojIpDZjCpS2+BH/j0ZPr0aN1tNJYpuaU0eOWr/6Xpwfs/wAO/dIjNA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(7696005)(5660300002)(426003)(478600001)(83380400001)(107886003)(6666004)(41300700001)(47076005)(1076003)(186003)(2906002)(26005)(82310400005)(40460700003)(40480700001)(336012)(54906003)(70586007)(2616005)(70206006)(8676002)(8936002)(110136005)(316002)(4326008)(7636003)(86362001)(356005)(36860700001)(82740400003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 12:57:16.7613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49027dd5-3e75-4a17-1898-08daa150f8b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
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
index 283f702b4993..8739cd6a702c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -783,7 +783,7 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 		dev_err(dev, "failed to set clk rate to %luHz: %d\n",
 			host_clk, err);
 
-	tegra_host->curr_clk_rate = host_clk;
+	tegra_host->curr_clk_rate = clk_get_rate(pltfm_host->clk);
 	if (tegra_host->ddr_signaling)
 		host->max_clk = host_clk;
 	else
-- 
2.17.1

