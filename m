Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3776962D2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjBNL4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjBNL4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:56:13 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAC4241CE;
        Tue, 14 Feb 2023 03:56:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrThIxK1t4uq1gvqgF1sjOFUjwBov+gJBLmrQs0Hz0iB5WvSEyflX6v78GADPgVQufcCe405x7sWatSznIj3jF28Be8rDlhroDqX8V8lsNeWrgNx9ECCiw/FTNoCZ8Bt5Cv/N96c2PvLRCH/Wuc90hVOzXnPYc++CBRfckvBJhG6QZgC9sBBRvZx2Hpq1Hiv7p5grKxFzGqGiAeHiDjgjgYwQUpxWNBh/zwfhhjAy4WF0Bmf85oZUvRtFfTikRMKmZ8OezSEqBEaO0xqFiEhtUSosM5hqECVJmA/eEoSxCtkgDPM2C+EObwAT24wenCLurBzR2IhM0G2C+AUy3kSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3j0tCXldGlgbZICuqquGBDxzqwiM6DBLu57Xe5rKo8=;
 b=S7fVK8DcLYuDw+QNuQCYvNNdvhnrum91HWPrbQVGFn8BBbGmteiWL2hoZy4goUPAhNAwxDGK45/FgTNC6X2Zsua07qqu3uwIFDRHAWZrxHcfUPfqGNm8zz1uv8kRS4+pfKVeV+I01oq67tCvCguZcoAy4dM0ANRF4/UoE+t5Xkk6ChPkh1cJxbge3SXnuJ93fKpTNsjuHY75ZsmQFSPceMlG3ebLHET5HCqlo1VMIXlo/pAGb1g2wAwLcmRzja0MoVNRQoE6nn7QyYrg2PFpaoC8vTP2S94ugeIOiukptaOLfMi/gMehom033KXSvDVkhMGQ3FjexYfO1Jda8/3XiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3j0tCXldGlgbZICuqquGBDxzqwiM6DBLu57Xe5rKo8=;
 b=rGaG/uPuuAhlSnd2tLDXt7KxuPT8JTQDpyWC7TKK+PetIU5e4oOK/G91jJcd9xiqbwseRbrHcJkwNdhnClxwgKijrtc41hMnprDS74vnFnmJXUnG3Ir7D3zRVm4CFCdc5IpVKkYD2G/Scuj+7qrEEorKIUkyjWULJa2iqzgyFA5rSXMPZF26WGhwbgvZYNwVIJiZRoiSElPYiBg9CNvvyc9kdxXMxwHBbSXjK/gq7oSHh7JhoFNB7Cwe8fXytS8SnpohmWRmtMCV1ioIFXvMLaC2XU+zTAj574FqatysvfgbV5amVaSfyJUOLjyOg7GFM+xCwuLa2WWpAri+bU6ovw==
Received: from DM6PR04CA0010.namprd04.prod.outlook.com (2603:10b6:5:334::15)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 11:56:10 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::e2) by DM6PR04CA0010.outlook.office365.com
 (2603:10b6:5:334::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Tue, 14 Feb 2023 11:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26 via Frontend Transport; Tue, 14 Feb 2023 11:56:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 03:56:01 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 03:56:01 -0800
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 03:56:00 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V2 3/6] gpio: tegra186: Add Tegra234 hte support
Date:   Tue, 14 Feb 2023 03:55:50 -0800
Message-ID: <20230214115553.10416-4-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214115553.10416-1-dipenp@nvidia.com>
References: <20230214115553.10416-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf88f89-4cac-4d94-c66a-08db0e827699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yShKT+axflnAwJPVpybzSsKiTFB0rTmZRo5aXdlL2eW0xBEDa1MklGJY8qCV0JtDdfsgB8UfbVL0wDECHh0qU3xgA7w3rE9jcFmgnyswOXLzFgwuKRzJTVprwVZ9IS5udO48keGWpj4ueMbC2mjUcTIGWKrcpQktS2pe23K/GQ2mi2q0C4zv1GTVEyFg5wD9+zHfJHMVm9sxmz6+axGrDB86ZjjrmXiyCv483GEEtOEruQqDRKksZrGRE2VBraR395cWw8ndThOr0y7vmqcBuU6mMvBi8gIpFeXadocxqVGUoPm6Gp83cLkJW/2NT/sTJOQYJvd/J36HfvsP5999gsR8KI3VuB3ZflqQL4vuF8ZzL1UlxqNbTPryoM1JOh4TwuRq7QbXOQaGYqhq7uK4+zWmz6F2QQtDCG1XZAzzqJyLN45Q6kIDDVxwx3fem5scpjySnyFcU7Tid/plwaeECB8yN144ptY6ZPu0/kg1DebZLmb8KBWE0RU9hT+dsPSX1FO7D03ImndJC2xmyg7EJju1NRJFHUFZoqrMTSx6H5y9i9k7SyDj6fWM7pWi7AHqLjBY+lV9YXQT5n+7Zg03kF5Zjg/nOlZO1N7XbvI1FaTebk9yhoDFogWF9BZvQ4CT5ayEHQ4f3nrBbJNaBeXdvPtDuOKeoqC19tqRa9nSeA/2/9+tuU8EbKeTN7eTYxlkh3UKqEqAuIh2Q0w5a39H8ofvOudtU0kBa7jyRAwE6je/npuey3ucCG+VOhIT4fKdY08KECf9ZLXh/JjFTjieLQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199018)(36840700001)(46966006)(40470700004)(40460700003)(921005)(356005)(86362001)(36756003)(70206006)(8676002)(70586007)(478600001)(4326008)(7696005)(6666004)(82310400005)(110136005)(41300700001)(8936002)(2906002)(40480700001)(36860700001)(4744005)(83380400001)(7636003)(5660300002)(186003)(26005)(316002)(47076005)(1076003)(426003)(82740400003)(2616005)(107886003)(336012)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 11:56:10.0133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf88f89-4cac-4d94-c66a-08db0e827699
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable timestamp support for the Tegra234, has_gte variable needs
to be set true.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index fdc5bdcd5638..58346c3ff18d 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -1137,6 +1137,7 @@ static const struct tegra_gpio_soc tegra234_aon_soc = {
 	.name = "tegra234-gpio-aon",
 	.instance = 1,
 	.num_irqs_per_bank = 8,
+	.has_gte = true,
 };
 
 #define TEGRA241_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
-- 
2.17.1

