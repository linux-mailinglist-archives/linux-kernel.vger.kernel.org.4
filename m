Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179C774F119
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjGKOEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjGKOEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:04:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::60e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43BB10E7;
        Tue, 11 Jul 2023 07:04:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgJVgeFo/Y7cBu/PCNWApOsjCn6xn0MgtHwNWfU54BXbvLtd6UYtTbV/NbGFV+MyN7YdcRXhHR5iilBKAvuNeqqPcZvoE0sbJh7V5yAQcbjht/thHZ3koc3VxT+RANUHAhEyG5OJuDYU2rML6X79qMUfKABbDZaS5pGhwlgFpOSRGZqPfZgy5gG4EYmOivDuC/R1CikGQORUCiVBD0PtSRs/IahkjfS7l3FEaXKZ21r1K6lE5K+tAQzKlFonZWMdKt9gEZQIzEmcK0EwOeFgH1gvv6ey06wxLixUkPHq40hMiTUkEujoFXAb22XgaEk76b3V47EtcQWVThP8Ibpbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctBmjKcRtWEhRonab0OMW7QyHLXL+P3tL+nGsl6+ME8=;
 b=SMfm+9MiaAFwpQZxK0s6ooe+lNqY5hlgkl5dK+YJHmQxyJxELo8nkLtpa7FKa4+UoNmAZDEl6tZ+75STcbjKodmD/xVxpeqGQRFi59OW6np/8rUohPNDx64JO77tZwhRX35guUhDREZGFdJiR+gRly8Wy3UdmNOr/uoiqxxiKgsD1aF/7uQ+FI/BDGY+vPtr2uGN+iPeFH3JReAvdIQoOKRN5bzPabJjTeXKhR+QKGVFWgnu9ZhndAIbh0F4ovVv/WtKZhvsGJbc0DJz4P8maopON5frsSE/oL/8UIhDcasay9TsEYkHPrwA6jfVfWbXWWolkqXLR2dECMEkQFIVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctBmjKcRtWEhRonab0OMW7QyHLXL+P3tL+nGsl6+ME8=;
 b=KdcpbOPIuyqLhJMtPX9IoW07U8L8Fh7Tq4Bm/m5Z8Xg8V9+5/3SqXYgR5sRe8YRIrRaHuyHPmwka3w5I89R/LUfR0hYC15GGWAg+C4q5o+3w05mk3zH/GlSCE1AEd31nbIyseRjcz+ESgfQnkM78kqxGd90k9TAR0MVF3YB/xzQ=
Received: from BN9PR03CA0168.namprd03.prod.outlook.com (2603:10b6:408:f4::23)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 14:04:39 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::32) by BN9PR03CA0168.outlook.office365.com
 (2603:10b6:408:f4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Tue, 11 Jul 2023 14:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 14:04:39 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 09:04:37 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Srinivas Neeli <srinivas.neeli@amd.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH 2/2] can: xilinx_can: Add support for controller reset
Date:   Tue, 11 Jul 2023 16:03:55 +0200
Message-ID: <a913de6c4099a1d3408a3973f637446b50c5dee4.1689084227.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1689084227.git.michal.simek@amd.com>
References: <cover.1689084227.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3563; i=michal.simek@amd.com; h=from:subject:message-id; bh=R4fFiiO7EGcwITvbons/T/EYfPUVyUM9NNMIqVyAJaw=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpS1iR7xd4OzHn3KzJ16+nrLM42kxIJjXpWHljHP9q0Km bxFglG+I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzk9gGGOdx5255Gi9+KnLD4 bt0j5R3yxsrX/jPMdzKe9HnRe9e6X1s9PPzSMg6vObdKDQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: d1204e89-d003-490f-102a-08db8217c436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tcy4Aa0xbx23IXz8ZST1lDc3HiE6y91J5k+erlnr8PsFFXp5kkMECw1i0s8hvFE/rmd7Dw4EVpwAksbc6BtQEAsfZKKVam4UgU1byKIvngWZvFttpujVHFglreYKTRhx9yBPymeK2GPOci6LAigOYdCmlLi0qan7CxSZZLlEGVhabCtRUzg43NFCSQacXEcEP4vk707Tzhvct0fX9NKQtfEJZjk3y3SdovVNJCHCo/cg26ScaxLqxkw3pdL8eaLHKXqmWvjR6GRsLMVYVrF5qoKnzs8FReDxbtsIZlvxeyQ7nfznDyPnt1YOBOMo1Ya5Bb0sqC/6bBGd+miuo33p94JNFDIkcFZtmmZ45R/qmuGmuiUoS2o3VY90fKLyAInt1k+aEc1/ANgCjIFwlJM3BOVUNGCTQIx2dEYwZ0+/lCl7Z4js+ikkHwQ2EwU6Lxe8OVYKy8xedotozxDaazh6f9PKnUt+wQp+JZE+ZefyqiPj5Yf20motTf4FMlgXO23UgqDD1SGibK5nkQc+LvQY+Qx+5FdxilQUjeknfhwIpTED8x80QlH83TTrUe7uoCzv9ODaKxWW8PIT9N0Tw2Q3kR+ELnjoscbpfLZepOsT4b3V42WPSHMjJaPO2iD5nDs1+x7RwQ0FE5PfZyNatpaTAQyj95f5IgYUuDiLVY/P4Bz8BT+4r4Wqn7negCFpi4D3L4Yey60bs9KrqMUSLzGfxBIQkOqlAtwonrpRTWJKZEbAqtkY+Oq0QJusxMcayGdc+UrMsiKIZHnCmFWxeDx+DLc5lNbbDt9pTtFc3xr3F9g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(44832011)(82310400005)(186003)(86362001)(26005)(5660300002)(8676002)(40480700001)(8936002)(7416002)(40460700003)(41300700001)(81166007)(82740400003)(356005)(70586007)(4326008)(6666004)(70206006)(36860700001)(2906002)(83380400001)(426003)(336012)(36756003)(47076005)(2616005)(110136005)(54906003)(16526019)(316002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 14:04:39.0324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1204e89-d003-490f-102a-08db8217c436
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Neeli <srinivas.neeli@amd.com>

Add support for an optional reset for the CAN controller using the reset
driver. If the CAN node contains the "resets" property, then this logic
will perform CAN controller reset.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/net/can/xilinx_can.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 4d3283db3a13..929e00061898 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -30,6 +30,7 @@
 #include <linux/can/error.h>
 #include <linux/phy/phy.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 
 #define DRIVER_NAME	"xilinx_can"
 
@@ -200,6 +201,7 @@ struct xcan_devtype_data {
  * @can_clk:			Pointer to struct clk
  * @devtype:			Device type specific constants
  * @transceiver:		Optional pointer to associated CAN transceiver
+ * @rstc:			Pointer to reset control
  */
 struct xcan_priv {
 	struct can_priv can;
@@ -218,6 +220,7 @@ struct xcan_priv {
 	struct clk *can_clk;
 	struct xcan_devtype_data devtype;
 	struct phy *transceiver;
+	struct reset_control *rstc;
 };
 
 /* CAN Bittiming constants as per Xilinx CAN specs */
@@ -1799,6 +1802,16 @@ static int xcan_probe(struct platform_device *pdev)
 	priv->can.do_get_berr_counter = xcan_get_berr_counter;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 					CAN_CTRLMODE_BERR_REPORTING;
+	priv->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(priv->rstc)) {
+		dev_err(&pdev->dev, "Cannot get CAN reset.\n");
+		ret = PTR_ERR(priv->rstc);
+		goto err_free;
+	}
+
+	ret = reset_control_reset(priv->rstc);
+	if (ret)
+		goto err_free;
 
 	if (devtype->cantype == XAXI_CANFD) {
 		priv->can.data_bittiming_const =
@@ -1827,7 +1840,7 @@ static int xcan_probe(struct platform_device *pdev)
 	/* Get IRQ for the device */
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto err_free;
+		goto err_reset;
 
 	ndev->irq = ret;
 
@@ -1843,21 +1856,21 @@ static int xcan_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->can_clk)) {
 		ret = dev_err_probe(&pdev->dev, PTR_ERR(priv->can_clk),
 				    "device clock not found\n");
-		goto err_free;
+		goto err_reset;
 	}
 
 	priv->bus_clk = devm_clk_get(&pdev->dev, devtype->bus_clk_name);
 	if (IS_ERR(priv->bus_clk)) {
 		ret = dev_err_probe(&pdev->dev, PTR_ERR(priv->bus_clk),
 				    "bus clock not found\n");
-		goto err_free;
+		goto err_reset;
 	}
 
 	transceiver = devm_phy_optional_get(&pdev->dev, NULL);
 	if (IS_ERR(transceiver)) {
 		ret = PTR_ERR(transceiver);
 		dev_err_probe(&pdev->dev, ret, "failed to get phy\n");
-		goto err_free;
+		goto err_reset;
 	}
 	priv->transceiver = transceiver;
 
@@ -1904,6 +1917,8 @@ static int xcan_probe(struct platform_device *pdev)
 err_disableclks:
 	pm_runtime_put(priv->dev);
 	pm_runtime_disable(&pdev->dev);
+err_reset:
+	reset_control_assert(priv->rstc);
 err_free:
 	free_candev(ndev);
 err:
@@ -1920,10 +1935,12 @@ static int xcan_probe(struct platform_device *pdev)
 static void xcan_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct xcan_priv *priv = netdev_priv(ndev);
 
 	unregister_candev(ndev);
 	pm_runtime_disable(&pdev->dev);
 	free_candev(ndev);
+	reset_control_assert(priv->rstc);
 }
 
 static struct platform_driver xcan_driver = {
-- 
2.36.1

