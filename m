Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0600D7238C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbjFFHSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbjFFHSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:18:06 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F929E7C;
        Tue,  6 Jun 2023 00:17:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnN4NWRLa61xhCjpmU1NKYD/i1mPfXC6c2NK4uP85IhdZU+MFO5NaZahzbBT9srbOv126W4uqWJIJf1ZgkKWat2Ci+kDJQ8wJcb5bbQLZo7PlYsYtuNWXnVTEn+cEgmqDJLDQGVrPPZpOAKBbzFkDthmqR3YhHp+6IOqq258RXZbOGtoGBU9wK7ulu4Cx3/87HvkWHT1uII/6z0ubXeueQvvHXDmNdQnDFLuOhKjgg0l0+Fsda0wsWDWedboKmCXxO+o9nsrc9aO+BgapYYQiEUAJ2yjESC4nNSh0WxlKzmNwvv1MbffjEIBigKNUV9e/6eJFjhliGCiG3Hf2KsVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5trypg3Bl1eCB1K4LKqR9nKEOn51CwCSFnFfOf/kUI=;
 b=j0knZiNRsJQz4/EqV8Pmjlj/CVE9iGue3Cj7JJW/PmF5/7DJHedb2ViGgmBM42AzMZJ/tIzPBJKb5ahXM7xP5hxbaBMeZEWzOpNKlKM03T3SJSw1f/4nKFsC0E+6JX9hZtU67xhOiCFYZdPkuUKVZKDER9S+nCXCtUgigwScPf/vc0ntp2xfTvU2VJ4qDhX3sJi7QlV9wzR3egdByZopA+6wYLMzRcoptgIrmiRLUPe56sydsbZ3k1W/jqzXBf2KNFWkIh4TRuRDtvUU7yrbq3qXLUmcQCyJj3vsOZqyFUjxeXLe9KP0OEt7/MWlPgq6WI9xrzErEhRcd7Z+oAEZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5trypg3Bl1eCB1K4LKqR9nKEOn51CwCSFnFfOf/kUI=;
 b=bUSOa3WUsSEqcnn8X6LURyRJIUK7NanCWf8gF/8Ud4PfXMDxb/U0NItKy2FJ+hXG/9wq05/sm2PtZb5qn/KVBHDz1mDvv4c18dTfNkVdHcJNyjDN05G4LzJBmcefH8WWhQWgePo3P1YnrDdRKQuCacBPw72FRLeA3nrZhtekgzyqsLeRUIRwvJqMSVfYNP5VyCvcLJ/SiEbX63C/pijBsUlhd38509SXzj4nVq9FtO8N0d3W+3VvB9ZLNSU2eWWtG/ywEZfc32rldXTDMGAoO9d2Ye48QwOoGYLgs8wY7XHYlmUBMGB9gYVK7f9Wu7V2IVG+U85XF5IPOtmootCYcw==
Received: from DS7PR03CA0150.namprd03.prod.outlook.com (2603:10b6:5:3b4::35)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 07:17:38 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::4f) by DS7PR03CA0150.outlook.office365.com
 (2603:10b6:5:3b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 07:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Tue, 6 Jun 2023 07:17:37 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 6 Jun 2023
 00:17:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 6 Jun 2023 00:17:27 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 6 Jun 2023 00:17:24 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: [PATCH] gpio: tegra186: Check PMC driver status before any request
Date:   Tue, 6 Jun 2023 12:47:17 +0530
Message-ID: <20230606071717.8088-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ce5e62-005f-4c33-80a7-08db665e1bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5T4KY6d/hr/fAHBPOeKTSaxDvmN9I7gA534+0Qi+LaNoM81ZtZGARRh/6JgYQjQtl3EYFE/sTeX9kkk/PQd0uC9PYLbl1KmGu8ZENGAyd+w4HnVAfTAQZ6aRo2YGAK9pbflqTRs3jPrZgSMZyZENU7YLQg5IBtavEdjMgsD0WTRvjUxa6guQoA5STv4G0tHsd/GtUaLQU2v4km26Qtg8ngb4xLNEBs9u6Lp8raM7+jbNzReop9xKUnRMjy4UAinqBrMS/ryrCh2T7ABK8Nok923TDl1wLtxLFbpQpgB1lAqFdqaorMMAP2naC35/5mDhYG1jq/WgLEoY2c35kKjFN7zmo0EAo8PRLTgmrsJOqLu+ESMG1HK3A7k+wC7ByxfJvHkca13Ei/pkT4rL2ifBKpKprwvYXasLZB1f0ozE++5l9hgg4xng6QY1rF77pTNiPJ9llR+L3XBaa6tBzUWDREDYjj2dR6GcMAot03nCcAa4cwh8qUqGe8bLcqEFYBJ4h9sP+FLeE9OEyfAizc1SICMjdDyuthhmx0+O41jCT6Ke90Dzm0bJdDc2tEu4YdoQNGEgWSbzJVxnJn4l2lx4/yPekPfNovZLGK5PS7l9lewVpjjjVybp0Z/yo3NOagkJ7q1vHVhVvNtQs+C9Ij4A1EthVcUz0zo5TK+j2R6Kes78nhYJD9CwheRps9jxHZ9L19Srd6R256kY7GfG3txcZZzBEsW62mOgvyh9zL2ElVk=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(8936002)(8676002)(107886003)(7696005)(478600001)(110136005)(54906003)(41300700001)(5660300002)(6666004)(316002)(1076003)(26005)(70586007)(70206006)(4326008)(2616005)(186003)(83380400001)(40460700003)(2906002)(47076005)(426003)(336012)(7636003)(82740400003)(40480700001)(356005)(36860700001)(86362001)(82310400005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:17:37.8733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ce5e62-005f-4c33-80a7-08db665e1bb3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the issue where even if PMC driver status is
disabled still we are trying to look up for the IRQ domain
that PMC driver would've registered if it had been enabled.

Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 464b0ea3b6f1..80d08ddde40e 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -964,11 +964,15 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 
 	np = of_find_matching_node(NULL, tegra186_pmc_of_match);
 	if (np) {
-		irq->parent_domain = irq_find_host(np);
-		of_node_put(np);
-
-		if (!irq->parent_domain)
-			return -EPROBE_DEFER;
+		if (of_device_is_available(np)) {
+			irq->parent_domain = irq_find_host(np);
+			of_node_put(np);
+
+			if (!irq->parent_domain)
+				return -EPROBE_DEFER;
+		} else {
+			of_node_put(np);
+		}
 	}
 
 	irq->map = devm_kcalloc(&pdev->dev, gpio->gpio.ngpio,
-- 
2.17.1

