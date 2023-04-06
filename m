Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928BF6D9E9A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbjDFRUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240044AbjDFRTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:19:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C177A8B;
        Thu,  6 Apr 2023 10:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwfSOvWBCj2w4FMFdSOEo70iPXKxZC3exAfnH8eBFKVV+5qd/84EOaydA+gzlKI7pLQY7AioCPa2z9wf6sR+rUH1ZJaYSAADSpuGajZTtfQSEK2YQ798fwYV1973zu1+ZuX1qLY0xk1aWfnuojhZXoTgUU48awZtBA97fAKrAEkj3ik/2sHzy0YGS9o1SuHkWRICfzga2B2RVRQ/q6wD3WJMV8iKFxvi4YaQGDl/OL93F+kjqPK35Wq9c6tcwstQKygmGZ5DGG9bwCPzdcQSCqJuAZGGrubJtARgoRxkBXKwbQydno4WkkgqQt+/l56tpvjdu5UbrqYKr60M5mXybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0B4e4waDo/8ygYRfAUPi4j/yHBgi9ZU9AnjB6UuD5k=;
 b=PLhyFs/WSC5EBMCCB0NgLRqwBOh2kicTtHF8JNPvATir5ZoERfwUCqc+K9vuVHxqqkbQr9xPLlx81Qe3ywz7lFKZR+VZiZ/jEM0881QzfJWp0/+1C4NVIvqVFA6nO01/CZ/x/UU9xVz8YQcQeebOcVNb3gC7oC8zqtnUN+T5ATJtjkzb82ryZ+HLSTDzS6HCBAcPvelE26FVn/PB0Qa4d+l5nGWvJLURmMB+/M43SpXHliKpjfzqs28Mw4y3sy6LzmyGU1TzAggeCYXYcz9odFuD6xXt5h6kN8uF4kWY3TlUMkNaYd+Mz8PkcEp8Ub6+0R4jWyFggCsh+hFCYQ+dRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0B4e4waDo/8ygYRfAUPi4j/yHBgi9ZU9AnjB6UuD5k=;
 b=LzzzeNkhlQFVL3io7dM8hdrhrWVErpxYuoMddhTS+ajzHETfZhMzBXxfqAMIQzcGrT7qC2DgVpJe2vpmOuzXmYhVVc6pLbo6btrTUMiZlsbr0x8AJGtQd3wr6k55x9WUgblCu0Zl4HH0TWp229NnDUaY5m9TBWH9ABZ42dIsXlygpQpsRGcVfmQLTDdJj3XNwJrti5F2qZ1BL2VocnKgv8m5Mb8wqO1VUXOL88nY+R8tFsAJGLG5KqBr4jFuJRrxzhObyZTj1v/utWgl4IJS5R4EgxyNdHp6bX8IQ/6pe/T0mxtJfMuxAjMt/QXSefkArh5y1oLoToTzNmeuLFJEIw==
Received: from BL1PR13CA0347.namprd13.prod.outlook.com (2603:10b6:208:2c6::22)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 17:19:12 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::a3) by BL1PR13CA0347.outlook.office365.com
 (2603:10b6:208:2c6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.16 via Frontend
 Transport; Thu, 6 Apr 2023 17:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35 via Frontend Transport; Thu, 6 Apr 2023 17:19:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 6 Apr 2023
 10:18:43 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 6 Apr 2023
 10:18:43 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 6 Apr 2023 10:18:43 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V5 10/10] gpio: tegra186: Add Tegra234 hte support
Date:   Thu, 6 Apr 2023 10:18:37 -0700
Message-ID: <20230406171837.11206-11-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406171837.11206-1-dipenp@nvidia.com>
References: <20230406171837.11206-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c7c271-a2b8-45d4-8a23-08db36c30a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hEEo/R3j5PMuAn36gcbyeVrDUJ3ZJnuOvn9sdRsF9UNlHvESYyJg6qrwVTvpXxjSM6uEeC4Y3UQtpkFPHZhzRcxP+Nxxb73F+U3bnGhPjnr+gMxyx78UEqXOBA8Dq/4FEsJ4P0vSD/dn+bu7jsCzYvWRAG7qeMGaXELt1isCA8PJRHIenaP/yDkrdw0yK4CdsGAvC1XxOon9niCcJCLe2aNzzMpn+j2ef9fx57WsyNACh0T+4V71539fEgrX2Hr81TKDlY2ltN7gdswnxNEXtAkvt+8OXFlwl6p668gtDTAkkS1ZTL6UF9reSTTXFDdbbYVCZvCYFPQbIPmYQxCFk1TVUzbLqhbT9uxroVK09Pmz35wwOsrbt66gAGuYAU67KRXV3KQeISglv89tswyD2UDbcdjYDby2NMMaEppD6wSWME1weKQ7JiG4nKDHyD0z8KqjkUI32/pX89hv2rTkFkIHHMHsRjyUwz73EZ4lR9keqmeHMdRJv1Qvq04bEmhIAnkITuW1wn5tS5phjyi3v9aGKOuLvYo8sV+KaOe2nyVAM2dfOGhKs3OsydAN0Byvi7+OH/6KxU95AroYvqtfT+jBLXIDlLoohaZzT09Y3nxHA3ffGL0DNxMkMswCHRJsjHogd/jdHjBxg3R7Ol417HP5XLfvk/CBnD8AiX375EdAb0fpaigWT2D2BpgNFX0We2NpYd+6IKpIf10DDsZA1QfLMyOil2FtGOA2LyoulaH+WdigGtXXrAa8+U6sG66aFhadgaKv9aha57oI0zHHmUDS6svQMyqJMqDtSpR3fqNPGWWGcadPuESW/Sf+T3K
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(316002)(7416002)(5660300002)(478600001)(83380400001)(7696005)(8936002)(41300700001)(110136005)(4744005)(70206006)(4326008)(8676002)(70586007)(6666004)(107886003)(26005)(1076003)(2906002)(186003)(40460700003)(336012)(426003)(7636003)(921005)(356005)(82740400003)(47076005)(2616005)(40480700001)(82310400005)(86362001)(36756003)(36860700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 17:19:12.3391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c7c271-a2b8-45d4-8a23-08db36c30a7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-tegra186.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 14c872b6ad05..b904de0b1784 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -1134,6 +1134,7 @@ static const struct tegra_gpio_soc tegra234_aon_soc = {
 	.name = "tegra234-gpio-aon",
 	.instance = 1,
 	.num_irqs_per_bank = 8,
+	.has_gte = true,
 };
 
 #define TEGRA241_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
-- 
2.17.1

