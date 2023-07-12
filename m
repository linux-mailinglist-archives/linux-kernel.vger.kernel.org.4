Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5BB750810
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjGLMV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjGLMVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:21:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849E99B;
        Wed, 12 Jul 2023 05:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2RvdASv7me2uF4K2GYEcW2fTmZqhaNVWMYj1OwjJDYRS/Eh/f/NKV5b9T6NoEoH62R2ep7JfWkCNjXbZhV86GPHCHIu6+fVJ776YRN1ihy/stQ6KY0otmPqF/0qWxWF+p8blR4WW1BLsSU3xOImuabldgxQRlpqY5eZwNXqOANLo8yVWoM7yzV3OEREH3mik4BfwuHPXsHdK8Weh5hK23ROKkW/cFtUWBJfuQHU0Vc5M+M+pNK+Ku64NJewpGrgt3tOuWyJVx5mGkbX+yUHNdpjeprVWtAJSujEEP5Hm1hAXZqDqJyI+rf8jGB8OrP88CxWRqlUbl5nsl92rLab2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSRPxJPPzUh8j2dtkBxrWA1T6LN0Fqp3ZmASMfuZjUY=;
 b=J2W/2gLpzxDWUV2tn/ePAU0DeNWl81Hre1eEMSD7bytyRpNwmWAlfYYPzEpYRtVF1XN0GZ0NW8oDsG72N+DhLx+QCX5Ti0Pd/olsJW7ipLvueUJhMdDrhoZ6TeInrV5tOrhlIxTv2C2ejL8m827EQAuSkWIr9o6CKmFK4M7Xb84WbvVQ9mEEF7N4t8h40L0FNuNr2Qphd1RHLilxnBzYVwibXhTtEzPKwso4UTamleNKtXj2PzlUJuFkpMc+w/s0Yvps2cS/EUrWgCnrPmoRcAUIuc2Snkqz5TTYxqxmMtKMlSdPpUSxvtX1tSyLY26D8LJDNJhA3G630DN3G+YmQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSRPxJPPzUh8j2dtkBxrWA1T6LN0Fqp3ZmASMfuZjUY=;
 b=Cal/C92YPqqdke5ZFH2Q3pBNgLaWHJuj2bdvBTHpjTzoj0nueaOlE1FqdnIzJi0RLzrBtSL4NTZzqF+W8BTmNGD7bDP5ge15zX1P2sSU6osdIkpERCvB/mDUG7eNd3X0DtrRzh9kayf0zzx0NdoUokoYbDuF3UgQyjLWouWiGfc=
Received: from BN9PR03CA0504.namprd03.prod.outlook.com (2603:10b6:408:130::29)
 by CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 12:21:16 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::61) by BN9PR03CA0504.outlook.office365.com
 (2603:10b6:408:130::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 12:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 12:21:15 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 07:20:56 -0500
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
Subject: [PATCH v2 2/2] can: xilinx_can: Add support for controller reset
Date:   Wed, 12 Jul 2023 14:20:46 +0200
Message-ID: <ab7e6503aa3343e39ead03c1797e765be6c50de2.1689164442.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1689164442.git.michal.simek@amd.com>
References: <cover.1689164442.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3587; i=michal.simek@amd.com; h=from:subject:message-id; bh=zjASbYlHTwyXN6GaTTSSuNwXIgN88Y29PGWBuEMwemk=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpR1s+Z8Pb2wK39he5xC5ZTCPfwKkSdZdm0+sKAs9tfcZ 1dz9WoOd8SyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJ8M1jmF9QzOZl3RtrPTvS fSHPnSLOQHXzrwzzHQ6y3mC7HC4sr/33w/lo385Io6abAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|CH0PR12MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9d4992-12b3-43e2-3c7f-08db82d27d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZ/K3zwwJe3USGdCSGRF94WTx/Sgui/l76wnlnMxEB2TxGk4xXz+chWfgbmX5A/3X77+m4ZDian+eEOGf35DmEdGHGoI9OoTJmY6n3iYmMwCjvIdkbLOyWYTwQz2y3Ly2/zaZQIqnrMV23QdvWpL1I1o5HL0feBYZU4orCH2S8sOe3iWBaYt52fleTKFxQh2ejjREBz0Z/YC5hucOHJzr9mhdywLTz2uvpx/ip9vV+cBCttc5+q2AfOfWsDxwcAGAPSd/V+MEDmGMbfY1Jq/Mo0YTLM76CwNoEi0hmlYU3TsKnHpVCYOu150sRA7wd+Nd4fpQQNH+mBoOUlLBBPiWoWHXsItzfTCg325oe7B+hALjDeWkhTyo+3DNiJ44K3R4CDjLoxnj1qbmG+4ptekpQHCa0Q1vqWF/+FR3htBWBhF3SEsOda1eSNBK5PcIrudV4giblLZpWu7cXSifhQefma7QjlHWJ8Z7dk162EHRec4i/4Syf4ibCfY9r1zafqa8WyC11XuuV4xr8wDFjxfTVllVn23YNLHinzDH/jB2MEwXIJlxPZ7soJYE+/gkIemfOuZWfHrxHDw87d7uiJfVLcbFpJ0ZW0Rjyflk4oIxPn9/+/bUfZD2F03K72f2f9kd9BbT9RqX9cjPbbJWVMfNRoorOz0AOH5RcXMNEV8R5PoAB3xm0IS8HbHJ09gdZ1ELot1VyQxyzTlznZZOTEaxQ8JQk/A9SWUQdI1xv+dmuFKFetZBFlDfEwoS6g8h0OuFDCpY0D1b4gGCzBn0yPsHftQUdS3dzlCpZxPkdjqcpw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(8936002)(36756003)(82310400005)(8676002)(5660300002)(36860700001)(26005)(7416002)(44832011)(316002)(70586007)(70206006)(47076005)(4326008)(2906002)(83380400001)(81166007)(54906003)(16526019)(82740400003)(356005)(426003)(336012)(186003)(2616005)(110136005)(478600001)(86362001)(6666004)(40460700003)(40480700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:21:15.6703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9d4992-12b3-43e2-3c7f-08db82d27d62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5156
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

Changes in v2:
- Fix use-after-free in xcan_remove reported by Marc.

 drivers/net/can/xilinx_can.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 4d3283db3a13..abe58f103043 100644
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
@@ -1920,9 +1935,11 @@ static int xcan_probe(struct platform_device *pdev)
 static void xcan_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct xcan_priv *priv = netdev_priv(ndev);
 
 	unregister_candev(ndev);
 	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(priv->rstc);
 	free_candev(ndev);
 }
 
-- 
2.36.1

