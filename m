Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC5D6C5C19
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCWBa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCWB37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:29:59 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5661F303FA;
        Wed, 22 Mar 2023 18:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWsksnNvR08xbKpHL1Xr5bY7WVjUcobndGOk+nPc/Nk36bKRN2OC/GaTcPHryoKL8kmvqbiRcI7D0e7JihbSI2/9ZG2wiMmRcl2C5ewC5Lb9T7rF6e3ieU8MLcgJ9S0WZqlV8ocby5zLdHn0D4J8DIETeKDmstrO/aQjz8oWK8TVUGrCYjKYOAlxycdJq2piMtGSmF1/QG2DJGYLv3uoSLzobc3DkhzsASd51GH1BhuP/gH8fpuBISaOLcqrkjHw0a/WzIpGBJWTWmzL32/ihVgXr9dWHLyeaWyJef/rAMc7ZhwrkwIy53ExwjXRQc/+H+lDzNRh3FqcUmhr31Fyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84187s+87Zv9eZPlcalYEMwzk96EgU1bcgE72lqR3go=;
 b=V0bjR/iK3aB2iDNdpvUNUGLEWRBfwbUaEZv5547hRoXnH2s5qcD3oSoHFEOIVs1g0QjlrcVSwdQNVn5kwk9DJLI3ezFMnn9LEcsyhS1y+v2Ev5KCziO8168ANcxMphySNDgc1hbXWcLUBZJsbCZmAmFjzxMEY0M5kxFHXrq3nbVMk9rvd72zoZvmMMVjIlDdXk+rVNFBYuout+t/KrYHP5H/j5XYx2+U3Y+yfz5rinjZ/r5g+CWNdMwhLUxI/b8C1HzaVlICeA4Vo2TGgAveChdw2uXbCte+VyZVpNY+XNVMqwE96CFrc7a/OG+YFJvuL3iqsUQFyuCmFY3+4YTiAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84187s+87Zv9eZPlcalYEMwzk96EgU1bcgE72lqR3go=;
 b=aOjAv1XLSzI2ybeF1TjNVpJ821qkulOdD5IuSsOtDJfWtv78gXSdjChEvzagqIf5xI/zFdIiWb0VVe4nPagmY+zcvvqiiQX6vbZ7YTjqdbbSstIxOGw00KfqXhIC58btgxpLHy9ua5Olh1Am7fflbd8uJrGMtRrD01d431MYLZMfuks3jEgfTvDYI5ffBIBARwXNmHpPMoP+OoJSIoGajUxqajRMM/ffa79f/VUYkOHdYYx00ej0UIEGpi9IsYkOPDQwzLuZ9a8i0tAwlYaGTQ990mISR+8v35LU41AhMBvQCPL9i/hnMjO5WkYZx5YzS/9ET62TNeonfqYvDe0xsQ==
Received: from BN0PR04CA0022.namprd04.prod.outlook.com (2603:10b6:408:ee::27)
 by BY5PR12MB4917.namprd12.prod.outlook.com (2603:10b6:a03:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 01:29:47 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::8f) by BN0PR04CA0022.outlook.office365.com
 (2603:10b6:408:ee::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 01:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 01:29:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 18:29:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 18:29:35 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 22 Mar 2023 18:29:35 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V4 09/10] hte: handle nvidia,gpio-controller property
Date:   Wed, 22 Mar 2023 18:29:28 -0700
Message-ID: <20230323012929.10815-10-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323012929.10815-1-dipenp@nvidia.com>
References: <20230323012929.10815-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT037:EE_|BY5PR12MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: e5eb480c-76b6-4f62-dc03-08db2b3e16c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wzd7BbtZKIYfGkWWYtJ0tcCAQC0/Hk4RSKNLUZGQ6YkGNhSxwj0Yk7QaPvhWKXtI/e2xbdOUHbNCrWvUEOW9/hKUMUShceS7z2QHDcUtz9RFFxnyjFHQKV3deiWBScKQQHT6s+P+DIrcUIzwhvc+S97+jiwjmZKfIXTxKRpezCYBnDW8+pU8YaZ0fFzc9WRLcmj3Td6DMGgTjAeSXSmg4A8CYpaJdYk7aVK6x+xYFZCjs6vgoB8yIIBw4KR6NM/vXNfXAq6yUtcAl7NFfa5UjZ5cTIAJwrezovqT6Fe8hXg7hgOBEK4gjGfDL6XOnYaCL2Nd03HomRYSsABWXP5EY2Uz33RWTGXYQooG5oYt6yTMSD/UZsh/wklcX/lkYDVVBd2M9XfEaTqSW7ufuLR+7c6IifXWLVSYzAkcqKuX4PvHDBwN0CrUpDV/V6rbWGNN4ETjc3TzaX7KjQvUy7ZLaIFzr7sVbePZXMcXf+PeGgEzOquhq+8e+uZX542LxXr0Xj61T8tm3NpTqq2K/NS8pu2B/+5g0Eeiujn6hmJ2xKfNSWfpmoVZWodXWmiUnyEpoF4yXg4F5KMAHFv3w1qQPhsX1ggWvCU57Ix0y0vd3Y2zf+rn+6a/r8khCpp50MGrF42qqYyCFiMd5upWcAlkpaSBCa3VWaR57CFtjLQlYHdN9QCsLDUTlIhaqJZEDpP22cfK+dMGc5nMK7cv1O6Y7FCfstxACk/Cg/INm3AQ/YsiGT5KAiEX/N6O2/0MDdgWC5NKYgYPOPXP7p13U0mog==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199018)(46966006)(36840700001)(8676002)(70586007)(70206006)(4326008)(36860700001)(8936002)(82740400003)(2616005)(2906002)(110136005)(7636003)(41300700001)(356005)(921005)(86362001)(478600001)(7696005)(5660300002)(7416002)(83380400001)(82310400005)(6666004)(107886003)(336012)(47076005)(426003)(36756003)(26005)(1076003)(40480700001)(316002)(186003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:29:47.1164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5eb480c-76b6-4f62-dc03-08db2b3e16c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4917
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dt binding adds nvidia,gpio-controller property from Tegra234 SoC
onwards to simplify code handling gpio chip search. The gpio chip search
is needed for the AON GPIO GTE instances to map the hardware timestamp
GPIO request (coming from the GPIO framework) to the tegra HTE
providers. The patch also adds new gpio chip match function to match
from the fwnode instead of the gpio controller label. The addition
of the property does not break ABI for the existing Tegra194 code.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 drivers/hte/hte-tegra194.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
index 945c68c5e476..2c485ff5be22 100644
--- a/drivers/hte/hte-tegra194.c
+++ b/drivers/hte/hte-tegra194.c
@@ -679,6 +679,11 @@ static int tegra_get_gpiochip_from_name(struct gpio_chip *chip, void *data)
 	return !strcmp(chip->label, data);
 }
 
+static int tegra_gpiochip_match(struct gpio_chip *chip, void *data)
+{
+	return chip->fwnode == of_node_to_fwnode(data);
+}
+
 static int tegra_hte_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -687,6 +692,7 @@ static int tegra_hte_probe(struct platform_device *pdev)
 	struct device *dev;
 	struct tegra_hte_soc *hte_dev;
 	struct hte_chip *gc;
+	struct device_node *gpio_ctrl;
 
 	dev = &pdev->dev;
 
@@ -754,15 +760,23 @@ static int tegra_hte_probe(struct platform_device *pdev)
 		gc->match_from_linedata = tegra_hte_match_from_linedata;
 
 		if (of_device_is_compatible(dev->of_node,
-					    "nvidia,tegra194-gte-aon"))
+					    "nvidia,tegra194-gte-aon")) {
 			hte_dev->c = gpiochip_find("tegra194-gpio-aon",
 						tegra_get_gpiochip_from_name);
-		else if (of_device_is_compatible(dev->of_node,
-						 "nvidia,tegra234-gte-aon"))
-			hte_dev->c = gpiochip_find("tegra234-gpio-aon",
-						tegra_get_gpiochip_from_name);
-		else
-			return -ENODEV;
+		} else {
+			gpio_ctrl = of_parse_phandle(dev->of_node,
+						     "nvidia,gpio-controller",
+						     0);
+			if (!gpio_ctrl) {
+				dev_err(dev,
+					"gpio controller node not found\n");
+				return -ENODEV;
+			}
+
+			hte_dev->c = gpiochip_find(gpio_ctrl,
+						   tegra_gpiochip_match);
+			of_node_put(gpio_ctrl);
+		}
 
 		if (!hte_dev->c)
 			return dev_err_probe(dev, -EPROBE_DEFER,
-- 
2.17.1

