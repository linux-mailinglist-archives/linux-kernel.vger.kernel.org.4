Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07845B5B16
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiILNX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiILNXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:23:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D769722B39;
        Mon, 12 Sep 2022 06:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZEyuhdV7ju6IM5ejUtp3N71X4giEjrIPcyxmXfPycQA/jYh3q3KLS9tO/vYJTJ/l5dHi/MeAZp1vFiq3EhjObiBLUwPecxI1wUFa3gNNh6iw8QeMgzXv5WG1xn7XCCo6fGbPtPScabvCgaU7v0C1u6jwDSyhfv1rCKE/+NJSxXtWURMFBJLRE/oLudLGe4DW+ZcC5W7ULDmmT4DCxuQkAU+knLmjIdlZ7Q7ugwbVu8G9yNJ+7sLp/JCR86LFKiSCoL/hXomKZKWwTFXKki51OU3+iDRQDcx71IQ0EpPbVXgrbkN+q7KLjmlvD0tRsTTWF7y3NaAidBIeei7hPNTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbTPIkkGBib9fwcRuryTqZdvBldoyiDRdZ4oq3PN++M=;
 b=gQKykAjmfRw1B3DGF8klHXMgLkKr8RiFTfQJXnB2CQPb14eF4K4M847dBVAouIN6mx1ZA8seZT+tsWcULh5+PgifLmy/vAB0evbCqtzsBUJWJfxXo9kX2obcUunV4aFllmxMxMnvZocZcR0yQnhzXUgOYZyVvfKyMnQ3Gxm68tFyNOa8UwaElkQrMaSMDBtJxJMUePUt3HHCAuifLh3Xe6KthZkYUBJxrY3Rid7CQ+vM1Im+V6uC/YulnxiUAMlzS/GW779Q2c16a1mk72bq4WEhigZZfgUHJy1pk+NB2wQyJQIHwftqaB4LHEmK+7zQqx83rj+PCw8+qnuZEFXO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbTPIkkGBib9fwcRuryTqZdvBldoyiDRdZ4oq3PN++M=;
 b=NCtelx14EjZBRqyg2yRBcgp17RtiOmcvfXKaylz3wBr4XdAbUGt7ttcl6dw/IeqTFGX19RKIaKmZvZ6zZvOWKFIcLCeE/ecHvY4/mX1fZy3qcBfSK7msLnZwD9+t6I0sfpvKen13JpJZSsuVRHOOPmQUK9V6kw59XtTQIX1Wfn/FLORw+RVRCyr8kD4ZpEt68Sv1u9jay3cyt2Hdn3XvgC39IXRHxcUvE5ZE77uXFIeubz0a+m1rzHvP66NWCm0aYFd/geWRS8HRJ8ws80i/G1FKURr4YqHSD81RS1aJSnT37srdxjJqsrykNKhWj2D7ajOyGsZrIjQMpAqqAXeGwA==
Received: from DM6PR02CA0093.namprd02.prod.outlook.com (2603:10b6:5:1f4::34)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 13:23:51 +0000
Received: from DS1PEPF0000B076.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::f) by DM6PR02CA0093.outlook.office365.com
 (2603:10b6:5:1f4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Mon, 12 Sep 2022 13:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DS1PEPF0000B076.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.10 via Frontend Transport; Mon, 12 Sep 2022 13:23:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Mon, 12 Sep
 2022 13:23:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 06:23:47 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 12 Sep 2022 06:23:44 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>
Subject: [PATCH 2/2] mmc: sdhci-tegra: Use actual clock rate for SW tuning correction
Date:   Mon, 12 Sep 2022 18:53:37 +0530
Message-ID: <20220912132337.18159-2-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220912132337.18159-1-pshete@nvidia.com>
References: <20220912132337.18159-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B076:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: f96e23d6-4073-49cc-62f8-08da94c207e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfuhIW1dVTOzNEvoLzpvCFQdYSwA22ga+4lHda59A5JVMqZ1rmS9Pn1CajJ7Zac0FRqf4saDhpt7yh9CjFfdwiTdxvbsK9z413JE5tk78kE1cGjpPfPdYGifKG9w4vGKduzUbHs/8F/a4JjEUcIXYkGTj0SII+LViBkxMNVNmB/Zuy0pO671cjbX3VeIvpcW1FB8jLsXZUCTLfhoKT3U7S3zS9+0OAn1dBYnT1nLbTDIW8ktLW9f5YCtd4GFX/GOUX6jjJPRuLUl73dBBuDL9qQ4tfsRzsR9E4f2pJgiSqLmJrWgXuXM9TBvKXrA6U8nCOjJ9joSPxy4Xb2KePVN/Mg1oUMv8qhHRHO2YKq2JnL1xQo4BmYcSL7S8PMBrfn+P1GvG6FiTWJZHFWId6KU4C1wDzzxxIGmcH+sBwlZmAo36APBHn/2NvW0ezcy/LB+Jdbo3fObecc+e7Ei9pD2xro52r2kV+CTkNKEJdgFvA8SC5jOeblKzoMYXLy5ynsn8AxNXxobrCERmivg1FPDR3+cZE9I0fbMCT3HUmfEzfMG01FXeGhny48tX7Uuf54nO3QGCEQxfJncBlYYC+vucpeBdKkNv9/8cQkawcct+GRQhRP9DHKpf71FtRwAR/+3otna45xgKMeyXrh4bPZdpXeEYj840NkqDkPh8fRuOfqtKFZWw+/+AQYVLK22fEE2fbgvv/buBkfyXWrHD+1kEmYGbh7wu7f6hW5M/FVRnKiCnz5EDFiVPlGIMXPx9kQJ2/E4JPNUVXkLNAu1X9LL79lVtbL3ZRSLMUhR1ZMDclTfWCZvNsfENl0JFz3peaT1
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(40470700004)(36840700001)(36860700001)(40480700001)(81166007)(356005)(40460700003)(82310400005)(82740400003)(86362001)(7696005)(4744005)(36756003)(478600001)(26005)(2906002)(4326008)(41300700001)(8676002)(8936002)(5660300002)(6666004)(107886003)(70586007)(70206006)(47076005)(426003)(316002)(83380400001)(1076003)(110136005)(54906003)(336012)(2616005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 13:23:49.3371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f96e23d6-4073-49cc-62f8-08da94c207e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B076.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure tegra_host member "curr_clk_rate" holds the actual clock rate
instead of requested clock rate for proper use during tuning correction
algorithm.

Fixes: ea8fc5953e8b ("mmc: tegra: update hw tuning process")

Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 136c045d8f01..3a3d188e8c65 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -773,7 +773,7 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 		dev_err(dev, "failed to set clk rate to %luHz: %d\n",
 			host_clk, err);
 
-	tegra_host->curr_clk_rate = host_clk;
+	tegra_host->curr_clk_rate = clk_get_rate(pltfm_host->clk);
 	if (tegra_host->ddr_signaling)
 		host->max_clk = host_clk;
 	else
-- 
2.17.1

