Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BAD5F510C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJEIlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJEIk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:40:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB856EF27;
        Wed,  5 Oct 2022 01:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOZbbzghi2CmzTeSevJRsEOo7qqi45KqGGTOW3Thg39HigQxpEFx0BH/URKEFkqLvQ8nqMwPx3xu3RO2UTZENXGT69KU3DjKxNUaBkVV0kaiYUel7TN4IbenKY39KAf5DtzC+SO7dOTE0wztiZLCo3fCT97Gl21Sng7ChxHhzalDy6XSBh4nCqCzMcL+hD97CTllOlcZRcNuM5IwjB3ieJWUkJH8Z330tExw5VnRLvL+WdvMlDcqrCAvZlmdROVc95z8FqHiOmivY4hl2JHU3lWI1pDpi+goJydMbiBtrEYDvk9ohUmhoHsXk8h30IlK4DZFdOCaSp4Kfpc9DXTepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3CMRs9/hiKMEvcG5/1EV+Q5x0RPGtG2ZyPTXp3sGlw=;
 b=L0AGPzbJ7LOuLJ59IK9UpzAaeL7R5VKWts/RRHZTGC8tBp9jThqPuCSloqt2oSQP/fYrPua5IA5Eo4/sz3CtmCF7VAJbvTjIwuUIuNKpzRsT3ARYjoB7LFEZ0J5KIj1dZT5WpwTah9OE2VdCLeRESvIu0tcKZnMavUY2WiMMrwqTQNp2ePjMrP+YRkbWIEmxCGns8TBUNr+fRKwSxfnzSxVaenvdYkp1Q7oMYZnXo3lyDrt/ptr/7OQg53Pt7WCFG0xWbXQRv/PobsoTDNEv4W+fZoHJSxelS6mC/d4BG5j4DRKwcroYxlvSYmZ6fAZxhPAtVFrhd67rVLp7smTptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3CMRs9/hiKMEvcG5/1EV+Q5x0RPGtG2ZyPTXp3sGlw=;
 b=kb72UCzvkSaPDkMi4v2G69gCXaDzVOi24Q1g2o7d6ttOIvtXNeYMMhW/URpHfGhaAEpMLTbfNH3INcWoZKXAWAnWUHmrVcO6UMbMwdybD1f141k0PeonCtscA+NFBdMzx1omPyyXnrD6gSWhqIQfiDRG/e0+YBJahfKPU5G3kJ7J5mgnL7msBbtFcnfqKVgWNtvgwjXBza/AvGcuXELGfd+xPo8kB88m7DCBEYFjwzzCQRqCxVUEyoY0Y/XD7aDcegpO+QZEY4TSPIpusf1mEbaOxQwEM/D8XE1+IGBWxAsUTF4IKSyjeXLPyTMbhxBnlzdRdklSgLft58p5e84Y1g==
Received: from MW4PR03CA0080.namprd03.prod.outlook.com (2603:10b6:303:b6::25)
 by CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 08:40:52 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::27) by MW4PR03CA0080.outlook.office365.com
 (2603:10b6:303:b6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Wed, 5 Oct 2022 08:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 08:40:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 5 Oct 2022
 01:40:44 -0700
Received: from 74ef364-lcelt.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 5 Oct 2022 01:40:42 -0700
From:   Haotien Hsu <haotienh@nvidia.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>
CC:     JC Kuo <jckuo@nvidia.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Haotien Hsu <haotienh@nvidia.com>,
        "Wayne Chang" <waynec@nvidia.com>
Subject: [PATCH] phy: tegra: xusb: Remove usb3 supply
Date:   Wed, 5 Oct 2022 16:40:31 +0800
Message-ID: <20221005084031.2154251-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|CH0PR12MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d2a4d0-08eb-40a3-c36e-08daa6ad4fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eF23okbThuX3WSsCt7kWm+DGVy98Cuhk7KcFkVizm8qXNApQZOtlm0+IBVPkLKoCuPoMR2ULOt2ZUiJ9emvdPCOKawgpw4lI/p0qnZgVJ99M+sjfXqBHDIJVDfeQeVsYDyBPnUzdY0D2js7QWO2wtDkI5r0yaNVejnowPIInCe/ZHHoULIWTqQIz3+a8mHCMQktMwegDpkOp0UdGuVy+Z81nzG+MnEZ3xfRR7OHck2QklUUCmoB32oFIKY0klZKGLrnkTd4+ZLBIlYhazvqpj3KAcJlStq8MDyxEe3o8ZmqhIrjq5e2ec+AJwH1c31Eeu35lvyrDf1s3yl09O5kvzDGb/ioZL4MX7M1yuev0aGvlRTcEcd106gI85LRv6rbpEXE2xlHzLQKV+QnA0MPzM1B9QL63g95NifC2qqkjKUgAlQXmpCMsZG8P7kPnMQggphsrPVE4d/FSqDOjTpVQz/F+Mx6cD03+CKTjkQC18Yo2Ekf2KNwrfeaA/maxMj8LPq/JEIZ0n52qIpCb2yD0ZpNLirDUMX4j9Ci7Yno93529qZVcFcvHSQBwqd93A8GoABYYCbK3L7gh6Vx3Y6uRVQynFOCJsgffb/yR1u9H7KKZMwGaYqJ8F9xrM1n7iiXhQR/o9gcfDg08MHCjSZfpyYm+rakGSozWoI/ptV8KZEalzWuBTxDt3hefoCKf3laTd/0tmLSMT840EWRxRZsO6uUulL1LWvEzKoLNTyUsCxp5FjZInWTl6RCotDs8koYfsTqn6pkTgw2ixJ4m+SNgDw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(82740400003)(82310400005)(336012)(16526019)(36860700001)(47076005)(426003)(356005)(86362001)(186003)(5660300002)(8936002)(316002)(41300700001)(40480700001)(70586007)(110136005)(8676002)(54906003)(4326008)(70206006)(2616005)(6666004)(7696005)(107886003)(7636003)(26005)(40460700003)(1076003)(478600001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 08:40:52.3459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d2a4d0-08eb-40a3-c36e-08daa6ad4fd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5138
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wayne Chang <waynec@nvidia.com>

Remove redundant codes for getting the vbus supply of usb3 ports because
we get and control the vbus supply by the companion usb2 ports

Signed-off-by: Wayne Chang <waynec@nvidia.com>
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra124.c |  1 -
 drivers/phy/tegra/xusb-tegra186.c |  1 -
 drivers/phy/tegra/xusb-tegra210.c |  1 -
 drivers/phy/tegra/xusb.c          | 10 +---------
 drivers/phy/tegra/xusb.h          |  2 --
 5 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra124.c b/drivers/phy/tegra/xusb-tegra124.c
index db56c7fbe60b..f4f75ea033b8 100644
--- a/drivers/phy/tegra/xusb-tegra124.c
+++ b/drivers/phy/tegra/xusb-tegra124.c
@@ -1652,7 +1652,6 @@ tegra124_usb3_port_map(struct tegra_xusb_port *port)
 
 static const struct tegra_xusb_port_ops tegra124_usb3_port_ops = {
 	.release = tegra_xusb_usb3_port_release,
-	.remove = tegra_xusb_usb3_port_remove,
 	.enable = tegra124_usb3_port_enable,
 	.disable = tegra124_usb3_port_disable,
 	.map = tegra124_usb3_port_map,
diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index f6099609f154..25db49789f41 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -1213,7 +1213,6 @@ tegra186_usb3_port_map(struct tegra_xusb_port *port)
 
 static const struct tegra_xusb_port_ops tegra186_usb3_port_ops = {
 	.release = tegra_xusb_usb3_port_release,
-	.remove = tegra_xusb_usb3_port_remove,
 	.enable = tegra186_usb3_port_enable,
 	.disable = tegra186_usb3_port_disable,
 	.map = tegra186_usb3_port_map,
diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index eedfc7c2cc05..ebc8a7e21a31 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -3078,7 +3078,6 @@ tegra210_usb3_port_map(struct tegra_xusb_port *port)
 
 static const struct tegra_xusb_port_ops tegra210_usb3_port_ops = {
 	.release = tegra_xusb_usb3_port_release,
-	.remove = tegra_xusb_usb3_port_remove,
 	.enable = tegra210_usb3_port_enable,
 	.disable = tegra210_usb3_port_disable,
 	.map = tegra210_usb3_port_map,
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 46661a8d5bbc..0eaab6d846bf 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -960,8 +960,7 @@ static int tegra_xusb_usb3_port_parse_dt(struct tegra_xusb_usb3_port *usb3)
 			return -EINVAL;
 	}
 
-	usb3->supply = regulator_get(&port->dev, "vbus");
-	return PTR_ERR_OR_ZERO(usb3->supply);
+	return 0;
 }
 
 static int tegra_xusb_add_usb3_port(struct tegra_xusb_padctl *padctl,
@@ -1018,13 +1017,6 @@ void tegra_xusb_usb3_port_release(struct tegra_xusb_port *port)
 	kfree(usb3);
 }
 
-void tegra_xusb_usb3_port_remove(struct tegra_xusb_port *port)
-{
-	struct tegra_xusb_usb3_port *usb3 = to_usb3_port(port);
-
-	regulator_put(usb3->supply);
-}
-
 static void __tegra_xusb_remove_ports(struct tegra_xusb_padctl *padctl)
 {
 	struct tegra_xusb_port *port, *tmp;
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index d66b22bfeaa7..1b6b780efeec 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -360,7 +360,6 @@ void tegra_xusb_hsic_port_release(struct tegra_xusb_port *port);
 
 struct tegra_xusb_usb3_port {
 	struct tegra_xusb_port base;
-	struct regulator *supply;
 	bool context_saved;
 	unsigned int port;
 	bool internal;
@@ -382,7 +381,6 @@ struct tegra_xusb_usb3_port *
 tegra_xusb_find_usb3_port(struct tegra_xusb_padctl *padctl,
 			  unsigned int index);
 void tegra_xusb_usb3_port_release(struct tegra_xusb_port *port);
-void tegra_xusb_usb3_port_remove(struct tegra_xusb_port *port);
 
 struct tegra_xusb_port_ops {
 	void (*release)(struct tegra_xusb_port *port);
-- 
2.25.1

