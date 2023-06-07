Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11343725D26
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbjFGLb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjFGLbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:31:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6B5198B;
        Wed,  7 Jun 2023 04:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZxT4dUQnvjz5GwaqA6W5tfdhNeDAeNZY0d1W3qTP9jmTaSZhSz5rUhQzHLORtiEu8/2Gu95xUn2c+PGrb+i2rxXVT9NGcC/eLbJhqlrz0kyCWQMZoTNGR+Xh+u1QM3s11md5PcAuCESx2i/WG555wPBKRFGuuqKmSxYEzP2FgD4GAe8DfjI96uWTO8J0VO92PIr0JxgNCJbIKv8/yopXmZ/ACFTrrlEQEBOZlgkWE+FQkAJDFuyl9dmPWuW43nsgOtqfuWpDY8RVlA3L3G8Sq39WQCcdkfugKZ943heOa5/hro6pxAHCTokVWY4GZKqKafdvhdsU+VAm/2+TYdE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvMIMul0HsrsZ0b+8E/XrqW70XklPovbUMCBCC05cGU=;
 b=N6lAguNerz+3mwuZqo1Z6Vssa0vJTOQQcmSjrNNXpbc8stxobrHBpt25DY+N3v1Jq/DXImvK8wHTcB1IjY+BJ8vtugSsa7SqjqdZ1obuloZqKrVZPuJqUVfZS6lje8Iazz1tjZAS6GtdwCodvRSZON2caSljDlFzV0E5tnHNSn41PDo5Nt3uAJ3qk4JyewBqvMFOY/e77UQg+lFvQglrE+ezbQS55xPi9f+jyL3d9a66fe3eEupK2MN5+ErY73bpM13SDbUY55DJP5gxkVohoI+Xuuj/+D5wt77BBQJxu3otZAQC+MbvEcLS7TMdQTVJXxuOioavyRyNsaxQBuJE/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvMIMul0HsrsZ0b+8E/XrqW70XklPovbUMCBCC05cGU=;
 b=BWCq5jSMLt6nN5D+mGg60vY2oZEi4NtRlPcNMZzDollOUlyIDtoei20W52hVdmztIGHJA8GAeJ6jKwnQv0HuC6uqSGLSkxKpllxXBOGHAbuUeVtUsZ8XXoo0bDi9ioJekUa8dexo/b5qHZK9R++IiQ00aA2mqb2UCyZwFDZERBAz5wlX7omwCw8yF/4axW0yO0tS5uAh7R5gIkaShwck5nXg+JGKJXm0blEduZKcWw470l21beigyqCZnUGDlKHMPUDDHfb5+82xjr8PUhOOBcOjfaba3Zinxbk5zAkMmu0e4NpPgz5+R3zcyrIutnDhJ3mXlT7ZnwXxiVevROU6bg==
Received: from BN9PR03CA0066.namprd03.prod.outlook.com (2603:10b6:408:fc::11)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 11:31:21 +0000
Received: from BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::81) by BN9PR03CA0066.outlook.office365.com
 (2603:10b6:408:fc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 11:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT076.mail.protection.outlook.com (10.13.176.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.24 via Frontend Transport; Wed, 7 Jun 2023 11:31:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 7 Jun 2023
 04:31:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 7 Jun 2023 04:31:08 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 7 Jun 2023 04:31:06 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: [PATCH v2] gpio: tegra186: Check PMC driver status before any request
Date:   Wed, 7 Jun 2023 17:01:04 +0530
Message-ID: <20230607113104.11761-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <496889ff-dd61-51af-c716-b9b9e2300be7@nvidia.com>
References: <496889ff-dd61-51af-c716-b9b9e2300be7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT076:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 1234b539-34e3-4b11-ae3d-08db674ab7bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EqIhoryHZGaf5XPFaIGOKL8lGYtx5XZKHIeenp+J/hqlPmVqLP7j0sGrfIpQcOMBvux7Nqz2xTkYwQOLN+KHbHHVR2WIirbHK8gUPsHrC9hRm93RO/7xIq9JRr9Iy1PPgFZel4hRtes1iEex++MZjfXWLrz91Yif2G+H/visauKfo0rNYgbEWcSAsKkzMoByTZKx4mYK0NfzfDSSMKPDcWW9gsjR7pSJEOhVccGx0cuHB6cXX8JLIYDKlvYC4Jacwc+dk1zrfczwcaqEsdLFk1eokNAabkyPRMZjJQhd66UoUPnO4v8RS2cLDsRfhWWd44OwiAhLoLoE6xgd2D1rkfevz/4qUj3KkMMw90W0/93ecE9kDhi2p1bSJUpuAtsA3Ze6aTkoeZmfMR0g38WHPkPmAz8Rn8MAgXsTchnK0Vd1QytwrE+UUOgFGkyMxUNrs51n2XR7GQlKVBLeHliCUQVdERKqr0SIfqY0wbwpWXumAEtCvj6rMNPy8G7wbIiJevoOfWq+sNarQWAO139tAzXWm12AxcEMofRfSv2mJ5YuFDyWFeR0yrfcN2scY+I/h+t5dywm7DAClNTpPILnqBkYEhJnJ/Wetr0ldR0YNwTBK96MYLti7LDQOl5dITCOwoZlCBxfoDArRze/cTuJBt+5oOZW7PGyXavo64ZRUM0ZDVDuQs4N/66SbzqzSDAGL3u0S0/6f90kSvqsXyLr7oC0FSGRLrdsq6fRqx8KXybaIF23SI58sX22Io9IXx7H
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(54906003)(110136005)(40460700003)(478600001)(40480700001)(5660300002)(8936002)(8676002)(36756003)(86362001)(2906002)(70206006)(82740400003)(70586007)(316002)(82310400005)(356005)(7636003)(4326008)(7696005)(41300700001)(2616005)(107886003)(1076003)(36860700001)(47076005)(26005)(83380400001)(186003)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 11:31:20.8953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1234b539-34e3-4b11-ae3d-08db674ab7bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803
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

When the PMC device is disabled, probing of the Tegra186 GPIO driver
fails because the IRQ domain that is registered by the PMC driver is
not found. The PMC IRQ domain is only used for wake-up and does not
impact GPIO functionality in general. Therefore, if the PMC device is
disabled, skip looking up the PMC IRQ domain to allow the GPIO driver
to be probed.

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

