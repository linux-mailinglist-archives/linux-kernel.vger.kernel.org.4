Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D7C743477
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjF3FlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjF3FlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:41:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A21F3585;
        Thu, 29 Jun 2023 22:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HE1cVuRceHNPshML9yr3i+OWdUJG/75UtTj+SikkceE5LM4mYupYu0Mgetz4ovwXLiog4Tqw+NXcIqSJ2TZQKKQMfc11Hr6K+T+R8IUPcjo0M+9zucGJi21OhUQkhHdXzgYLtHdRhack22I42nfe1HUcP9rhP5JzXbfuk30vXt1txPkOP+02NT8bY/so3B9mMYrV69lzjk99IdNvhN4jFoVp5SG2c6wjEme2CgPFMeEh6oFjL6naxuEWJqadhgCAFWFVC+RdH643Q3EA+tvZsJ7fERBJ3pfAOlvkauhZW0zQ7IWqgBBLApsJ/ViXQTXZp0S1LZOE7lgUsRrENxJjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEQyTmedwlnI9ovLDEPzhOm7VLG6nvnM9uwObZMyPEU=;
 b=gtiyID88iDoYO6hxwk/fk/PFCMP3TMX8tSqFhJcxn3SPghyYakqh3j+iQYWbSIgaVHfjcJspJNfTwKPAWjngOMII3m5hsEpuZ3HQgJnYJrU32cNeXJm1bFfUwdTkl3nUPTkGob2COaTaXbgQa8t5QVZWlYRbDWIN+77SsAts2nuMyak0ppMNaKApR/tPdDXRVMvUqUngDcjVmZrAJtekx+lXqzvm5ndjAtcTrZICAWYxtGC/T3vyKreEn3pdZrEj26PaCKcvuPkE7p/jIejLVVyPl+JM5mzM+j44HEVXW2vtjY3Sl/R2YabP94Y46XBn33WLKqcJkRDiGirfYJw50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEQyTmedwlnI9ovLDEPzhOm7VLG6nvnM9uwObZMyPEU=;
 b=ZT3uDaNp/dBuZ9OuVaeGy5MDiRcTLGRLQ8n6v5W37oQsQLVTug3OWGAO326InkejKWJgzHpKp6V+kk2yNpnH+eNPcV0JqDLYkBL27k0sSbc660evXrNJKnpR7U0ygpsxR6+bbtduq+YJFSITZTn2tKef8Ld8//8DFd8izaEHTO4=
Received: from DM6PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:333::18)
 by CH2PR12MB4889.namprd12.prod.outlook.com (2603:10b6:610:68::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 05:39:04 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::97) by DM6PR03CA0085.outlook.office365.com
 (2603:10b6:5:333::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 05:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 05:39:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 00:39:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 00:38:59 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 30 Jun 2023 00:38:55 -0500
From:   Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <sbhatta@marvell.com>, <linux@armlinux.org.uk>,
        <michal.simek@amd.com>, <radhey.shyam.pandey@amd.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>, <sarath.babu.naidu.gaddam@amd.com>,
        <git@amd.com>
Subject: [PATCH net-next V4 2/3] net: axienet: Preparatory changes for dmaengine support
Date:   Fri, 30 Jun 2023 11:08:43 +0530
Message-ID: <20230630053844.1366171-3-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630053844.1366171-1-sarath.babu.naidu.gaddam@amd.com>
References: <20230630053844.1366171-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT068:EE_|CH2PR12MB4889:EE_
X-MS-Office365-Filtering-Correlation-Id: 0315422e-222a-4627-0306-08db792c5070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5wHvL8AUN71N1EQriy0cTpD+cju1xfuFpmOkjAuyv1e85/k9h5MdNqwxvKEHVMXajHJSxAPUsKGBwyynamsrtf4T9L95T+93qzVfqNB6NzIPqrPkxMeGb+TFDUE5E3w8g/Ji0tTQ3/2gn1GAP8Ky1I/gqPt0tUP0yMlIv5JPb+KKpkZAjGoZNZLWGGL/b6yB1VkaMEVUtuU7JNCgkPVe80K9nwv5cK4FhUdkn4IucHrtc7A/8fyUkKCUAUXE8U6BwI9Plf7XD16Xv1vWae3xtV9lGytsEiA3HGfoV8plQVyuR09O6R3b60Hg+WFw5uM+k8BNUxb6rVh888/WqphOllfH6fJsfrwnMBeqAivm4qxUyh74aSW6kAcvw9I3kJ6vdYYYsfbejGGF4eUrDi8yDfEwcgnCSH7j5LShYwSI2CnHbn/D6Oj6z60OjRbXk4tdtObuZPJeBjPiLNY+ULE9MVyxyPID8Ewz3dyBkieyjP7Q/PJR1KSsyIwfHgIjaayQ/Br8PEEeqQPhYIzX19UndQiVY1RZsxY/yIf88wYfVM4giNmfUmwL1F+z44tGFxlt3ZfepDg6SwGzWu5IXx3D8zxvGjENdUS3MsJrCc/olzydTRaUUrHC7vT/2qlQ9po2gzZgqpfgEY2AN0srZWCJ3u8rqW8D/fe63q4RFffEK0RBlJKwcBDd21JREujJRr70ZbaQ8VSvhsObK3qJSh/iMR7fAD7umBItH6njpxbC3G+yXG5IhV1U0cSVEARzb+VruPS3Rj7ubn+4qmkziYN1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(336012)(426003)(47076005)(40460700003)(83380400001)(30864003)(2616005)(2906002)(81166007)(356005)(82740400003)(36860700001)(40480700001)(36756003)(8936002)(8676002)(82310400005)(110136005)(5660300002)(86362001)(54906003)(41300700001)(4326008)(70206006)(70586007)(6666004)(316002)(478600001)(103116003)(186003)(1076003)(7416002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 05:39:03.7315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0315422e-222a-4627-0306-08db792c5070
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4889
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The axiethernet driver has in-built dma programming. The aim is to remove
axiethernet axidma programming  after some time and instead use the
dmaengine framework to communicate with existing xilinx DMAengine
controller(xilinx_dma) driver.

Keep the axidma programming code under use_dmaengine check so that
dmaengine changes can be added later.

Perform minor code reordering to minimize conditional
use_dmaengine checks and there is no functional change.

It uses "dmas" property to identify whether it should use a dmaengine
framework or axiethernet axidma programming.

Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>

---
Changes in V4:
1) Renamed has_dmas to use_dmaegine.
2) Removed the AXIENET_USE_DMA.
1) Changed the start_xmit_** functions description.

Changes in V3:
1) New patch
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |   2 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 317 +++++++++++-------
 2 files changed, 191 insertions(+), 128 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 575ff9de8985..3ead0bac597b 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -435,6 +435,7 @@ struct axidma_bd {
  * @coalesce_usec_rx:	IRQ coalesce delay for RX
  * @coalesce_count_tx:	Store the irq coalesce on TX side.
  * @coalesce_usec_tx:	IRQ coalesce delay for TX
+ * @use_dmaengine: flag to check dmaengine framework usage.
  */
 struct axienet_local {
 	struct net_device *ndev;
@@ -499,6 +500,7 @@ struct axienet_local {
 	u32 coalesce_usec_rx;
 	u32 coalesce_count_tx;
 	u32 coalesce_usec_tx;
+	u8  use_dmaengine;
 };
 
 /**
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 3e310b55bce2..1fa67bb09625 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -588,10 +588,6 @@ static int axienet_device_reset(struct net_device *ndev)
 	struct axienet_local *lp = netdev_priv(ndev);
 	int ret;
 
-	ret = __axienet_device_reset(lp);
-	if (ret)
-		return ret;
-
 	lp->max_frm_size = XAE_MAX_VLAN_FRAME_SIZE;
 	lp->options |= XAE_OPTION_VLAN;
 	lp->options &= (~XAE_OPTION_JUMBO);
@@ -605,11 +601,17 @@ static int axienet_device_reset(struct net_device *ndev)
 			lp->options |= XAE_OPTION_JUMBO;
 	}
 
-	ret = axienet_dma_bd_init(ndev);
-	if (ret) {
-		netdev_err(ndev, "%s: descriptor allocation failed\n",
-			   __func__);
-		return ret;
+	if (!lp->use_dmaengine) {
+		ret = __axienet_device_reset(lp);
+		if (ret)
+			return ret;
+
+		ret = axienet_dma_bd_init(ndev);
+		if (ret) {
+			netdev_err(ndev, "%s: descriptor allocation failed\n",
+				   __func__);
+			return ret;
+		}
 	}
 
 	axienet_status = axienet_ior(lp, XAE_RCW1_OFFSET);
@@ -775,20 +777,20 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
 }
 
 /**
- * axienet_start_xmit - Starts the transmission.
+ * axienet_start_xmit_legacy - Starts the transmission.
  * @skb:	sk_buff pointer that contains data to be Txed.
  * @ndev:	Pointer to net_device structure.
  *
  * Return: NETDEV_TX_OK, on success
  *	    NETDEV_TX_BUSY, if any of the descriptors are not free
  *
- * This function is invoked from upper layers to initiate transmission. The
+ * This function is invoked from axienet_start_xmit to initiate transmission. The
  * function uses the next available free BDs and populates their fields to
  * start the transmission. Additionally if checksum offloading is supported,
  * it populates AXI Stream Control fields with appropriate values.
  */
 static netdev_tx_t
-axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+axienet_start_xmit_legacy(struct sk_buff *skb, struct net_device *ndev)
 {
 	u32 ii;
 	u32 num_frag;
@@ -890,6 +892,27 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_OK;
 }
 
+/**
+ * axienet_start_xmit - Invoke the transmission function
+ * @skb:        sk_buff pointer that contains data to be Txed.
+ * @ndev:       Pointer to net_device structure.
+ *
+ * Return: NETDEV_TX_OK, on success
+ *          NETDEV_TX_BUSY, if any of the descriptors are not free
+ *
+ * This function is invoked from upper layers to initiate transmission
+ */
+static netdev_tx_t
+axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct axienet_local *lp = netdev_priv(ndev);
+
+	if (!lp->use_dmaengine)
+		return axienet_start_xmit_legacy(skb, ndev);
+	else
+		return NETDEV_TX_BUSY;
+}
+
 /**
  * axienet_rx_poll - Triggered by RX ISR to complete the BD processing.
  * @napi:	Pointer to NAPI structure.
@@ -1124,41 +1147,22 @@ static irqreturn_t axienet_eth_irq(int irq, void *_ndev)
 static void axienet_dma_err_handler(struct work_struct *work);
 
 /**
- * axienet_open - Driver open routine.
- * @ndev:	Pointer to net_device structure
+ * axienet_init_legacy_dma - init the dma legacy code.
+ * @ndev:       Pointer to net_device structure
  *
  * Return: 0, on success.
- *	    non-zero error value on failure
+ *          non-zero error value on failure
+ *
+ * This is the dma  initialization code. It also allocates interrupt
+ * service routines, enables the interrupt lines and ISR handling.
  *
- * This is the driver open routine. It calls phylink_start to start the
- * PHY device.
- * It also allocates interrupt service routines, enables the interrupt lines
- * and ISR handling. Axi Ethernet core is reset through Axi DMA core. Buffer
- * descriptors are initialized.
  */
-static int axienet_open(struct net_device *ndev)
+
+static inline int axienet_init_legacy_dma(struct net_device *ndev)
 {
 	int ret;
 	struct axienet_local *lp = netdev_priv(ndev);
 
-	dev_dbg(&ndev->dev, "axienet_open()\n");
-
-	/* When we do an Axi Ethernet reset, it resets the complete core
-	 * including the MDIO. MDIO must be disabled before resetting.
-	 * Hold MDIO bus lock to avoid MDIO accesses during the reset.
-	 */
-	axienet_lock_mii(lp);
-	ret = axienet_device_reset(ndev);
-	axienet_unlock_mii(lp);
-
-	ret = phylink_of_phy_connect(lp->phylink, lp->dev->of_node, 0);
-	if (ret) {
-		dev_err(lp->dev, "phylink_of_phy_connect() failed: %d\n", ret);
-		return ret;
-	}
-
-	phylink_start(lp->phylink);
-
 	/* Enable worker thread for Axi DMA error handling */
 	INIT_WORK(&lp->dma_err_task, axienet_dma_err_handler);
 
@@ -1192,13 +1196,62 @@ static int axienet_open(struct net_device *ndev)
 err_tx_irq:
 	napi_disable(&lp->napi_tx);
 	napi_disable(&lp->napi_rx);
-	phylink_stop(lp->phylink);
-	phylink_disconnect_phy(lp->phylink);
 	cancel_work_sync(&lp->dma_err_task);
 	dev_err(lp->dev, "request_irq() failed\n");
 	return ret;
 }
 
+/**
+ * axienet_open - Driver open routine.
+ * @ndev:	Pointer to net_device structure
+ *
+ * Return: 0, on success.
+ *	    non-zero error value on failure
+ *
+ * This is the driver open routine. It calls phylink_start to start the
+ * PHY device.
+ * It also allocates interrupt service routines, enables the interrupt lines
+ * and ISR handling. Axi Ethernet core is reset through Axi DMA core. Buffer
+ * descriptors are initialized.
+ */
+static int axienet_open(struct net_device *ndev)
+{
+	int ret;
+	struct axienet_local *lp = netdev_priv(ndev);
+
+	dev_dbg(&ndev->dev, "%s\n", __func__);
+
+	/* When we do an Axi Ethernet reset, it resets the complete core
+	 * including the MDIO. MDIO must be disabled before resetting.
+	 * Hold MDIO bus lock to avoid MDIO accesses during the reset.
+	 */
+	axienet_lock_mii(lp);
+	ret = axienet_device_reset(ndev);
+	axienet_unlock_mii(lp);
+
+	ret = phylink_of_phy_connect(lp->phylink, lp->dev->of_node, 0);
+	if (ret) {
+		dev_err(lp->dev, "phylink_of_phy_connect() failed: %d\n", ret);
+		return ret;
+	}
+
+	phylink_start(lp->phylink);
+
+	if (!lp->use_dmaengine) {
+		ret = axienet_init_legacy_dma(ndev);
+		if (ret)
+			goto error_code;
+	}
+
+	return 0;
+
+error_code:
+	phylink_stop(lp->phylink);
+	phylink_disconnect_phy(lp->phylink);
+
+	return ret;
+}
+
 /**
  * axienet_stop - Driver stop routine.
  * @ndev:	Pointer to net_device structure
@@ -1215,8 +1268,10 @@ static int axienet_stop(struct net_device *ndev)
 
 	dev_dbg(&ndev->dev, "axienet_close()\n");
 
-	napi_disable(&lp->napi_tx);
-	napi_disable(&lp->napi_rx);
+	if (!lp->use_dmaengine) {
+		napi_disable(&lp->napi_tx);
+		napi_disable(&lp->napi_rx);
+	}
 
 	phylink_stop(lp->phylink);
 	phylink_disconnect_phy(lp->phylink);
@@ -1224,18 +1279,18 @@ static int axienet_stop(struct net_device *ndev)
 	axienet_setoptions(ndev, lp->options &
 			   ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
 
-	axienet_dma_stop(lp);
+	if (!lp->use_dmaengine) {
+		axienet_dma_stop(lp);
+		cancel_work_sync(&lp->dma_err_task);
+		free_irq(lp->tx_irq, ndev);
+		free_irq(lp->rx_irq, ndev);
+		axienet_dma_bd_release(ndev);
+	}
 
 	axienet_iow(lp, XAE_IE_OFFSET, 0);
 
-	cancel_work_sync(&lp->dma_err_task);
-
 	if (lp->eth_irq > 0)
 		free_irq(lp->eth_irq, ndev);
-	free_irq(lp->tx_irq, ndev);
-	free_irq(lp->rx_irq, ndev);
-
-	axienet_dma_bd_release(ndev);
 	return 0;
 }
 
@@ -1411,14 +1466,16 @@ static void axienet_ethtools_get_regs(struct net_device *ndev,
 	data[29] = axienet_ior(lp, XAE_FMI_OFFSET);
 	data[30] = axienet_ior(lp, XAE_AF0_OFFSET);
 	data[31] = axienet_ior(lp, XAE_AF1_OFFSET);
-	data[32] = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
-	data[33] = axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
-	data[34] = axienet_dma_in32(lp, XAXIDMA_TX_CDESC_OFFSET);
-	data[35] = axienet_dma_in32(lp, XAXIDMA_TX_TDESC_OFFSET);
-	data[36] = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
-	data[37] = axienet_dma_in32(lp, XAXIDMA_RX_SR_OFFSET);
-	data[38] = axienet_dma_in32(lp, XAXIDMA_RX_CDESC_OFFSET);
-	data[39] = axienet_dma_in32(lp, XAXIDMA_RX_TDESC_OFFSET);
+	if (!lp->use_dmaengine) {
+		data[32] = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
+		data[33] = axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
+		data[34] = axienet_dma_in32(lp, XAXIDMA_TX_CDESC_OFFSET);
+		data[35] = axienet_dma_in32(lp, XAXIDMA_TX_TDESC_OFFSET);
+		data[36] = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
+		data[37] = axienet_dma_in32(lp, XAXIDMA_RX_SR_OFFSET);
+		data[38] = axienet_dma_in32(lp, XAXIDMA_RX_CDESC_OFFSET);
+		data[39] = axienet_dma_in32(lp, XAXIDMA_RX_TDESC_OFFSET);
+	}
 }
 
 static void
@@ -1878,9 +1935,6 @@ static int axienet_probe(struct platform_device *pdev)
 	u64_stats_init(&lp->rx_stat_sync);
 	u64_stats_init(&lp->tx_stat_sync);
 
-	netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
-	netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll);
-
 	lp->axi_clk = devm_clk_get_optional(&pdev->dev, "s_axi_lite_clk");
 	if (!lp->axi_clk) {
 		/* For backward compatibility, if named AXI clock is not present,
@@ -2006,75 +2060,80 @@ static int axienet_probe(struct platform_device *pdev)
 		goto cleanup_clk;
 	}
 
-	/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
-	np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
-	if (np) {
-		struct resource dmares;
+	if (!of_find_property(pdev->dev.of_node, "dmas", NULL)) {
+		/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
+		np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
 
-		ret = of_address_to_resource(np, 0, &dmares);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"unable to get DMA resource\n");
+		if (np) {
+			struct resource dmares;
+
+			ret = of_address_to_resource(np, 0, &dmares);
+			if (ret) {
+				dev_err(&pdev->dev,
+					"unable to get DMA resource\n");
+				of_node_put(np);
+				goto cleanup_clk;
+			}
+			lp->dma_regs = devm_ioremap_resource(&pdev->dev,
+							     &dmares);
+			lp->rx_irq = irq_of_parse_and_map(np, 1);
+			lp->tx_irq = irq_of_parse_and_map(np, 0);
 			of_node_put(np);
+			lp->eth_irq = platform_get_irq_optional(pdev, 0);
+		} else {
+			/* Check for these resources directly on the Ethernet node. */
+			lp->dma_regs = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
+			lp->rx_irq = platform_get_irq(pdev, 1);
+			lp->tx_irq = platform_get_irq(pdev, 0);
+			lp->eth_irq = platform_get_irq_optional(pdev, 2);
+		}
+		if (IS_ERR(lp->dma_regs)) {
+			dev_err(&pdev->dev, "could not map DMA regs\n");
+			ret = PTR_ERR(lp->dma_regs);
+			goto cleanup_clk;
+		}
+		if (lp->rx_irq <= 0 || lp->tx_irq <= 0) {
+			dev_err(&pdev->dev, "could not determine irqs\n");
+			ret = -ENOMEM;
 			goto cleanup_clk;
 		}
-		lp->dma_regs = devm_ioremap_resource(&pdev->dev,
-						     &dmares);
-		lp->rx_irq = irq_of_parse_and_map(np, 1);
-		lp->tx_irq = irq_of_parse_and_map(np, 0);
-		of_node_put(np);
-		lp->eth_irq = platform_get_irq_optional(pdev, 0);
-	} else {
-		/* Check for these resources directly on the Ethernet node. */
-		lp->dma_regs = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
-		lp->rx_irq = platform_get_irq(pdev, 1);
-		lp->tx_irq = platform_get_irq(pdev, 0);
-		lp->eth_irq = platform_get_irq_optional(pdev, 2);
-	}
-	if (IS_ERR(lp->dma_regs)) {
-		dev_err(&pdev->dev, "could not map DMA regs\n");
-		ret = PTR_ERR(lp->dma_regs);
-		goto cleanup_clk;
-	}
-	if ((lp->rx_irq <= 0) || (lp->tx_irq <= 0)) {
-		dev_err(&pdev->dev, "could not determine irqs\n");
-		ret = -ENOMEM;
-		goto cleanup_clk;
-	}
 
-	/* Autodetect the need for 64-bit DMA pointers.
-	 * When the IP is configured for a bus width bigger than 32 bits,
-	 * writing the MSB registers is mandatory, even if they are all 0.
-	 * We can detect this case by writing all 1's to one such register
-	 * and see if that sticks: when the IP is configured for 32 bits
-	 * only, those registers are RES0.
-	 * Those MSB registers were introduced in IP v7.1, which we check first.
-	 */
-	if ((axienet_ior(lp, XAE_ID_OFFSET) >> 24) >= 0x9) {
-		void __iomem *desc = lp->dma_regs + XAXIDMA_TX_CDESC_OFFSET + 4;
-
-		iowrite32(0x0, desc);
-		if (ioread32(desc) == 0) {	/* sanity check */
-			iowrite32(0xffffffff, desc);
-			if (ioread32(desc) > 0) {
-				lp->features |= XAE_FEATURE_DMA_64BIT;
-				addr_width = 64;
-				dev_info(&pdev->dev,
-					 "autodetected 64-bit DMA range\n");
-			}
+		/* Autodetect the need for 64-bit DMA pointers.
+		 * When the IP is configured for a bus width bigger than 32 bits,
+		 * writing the MSB registers is mandatory, even if they are all 0.
+		 * We can detect this case by writing all 1's to one such register
+		 * and see if that sticks: when the IP is configured for 32 bits
+		 * only, those registers are RES0.
+		 * Those MSB registers were introduced in IP v7.1, which we check first.
+		 */
+		if ((axienet_ior(lp, XAE_ID_OFFSET) >> 24) >= 0x9) {
+			void __iomem *desc = lp->dma_regs + XAXIDMA_TX_CDESC_OFFSET + 4;
+
 			iowrite32(0x0, desc);
+			if (ioread32(desc) == 0) {	/* sanity check */
+				iowrite32(0xffffffff, desc);
+				if (ioread32(desc) > 0) {
+					lp->features |= XAE_FEATURE_DMA_64BIT;
+					addr_width = 64;
+					dev_info(&pdev->dev,
+						 "autodetected 64-bit DMA range\n");
+				}
+				iowrite32(0x0, desc);
+			}
+		}
+		if (!IS_ENABLED(CONFIG_64BIT) && lp->features & XAE_FEATURE_DMA_64BIT) {
+			dev_err(&pdev->dev, "64-bit addressable DMA is not compatible with 32-bit archecture\n");
+			ret = -EINVAL;
+			goto cleanup_clk;
 		}
-	}
-	if (!IS_ENABLED(CONFIG_64BIT) && lp->features & XAE_FEATURE_DMA_64BIT) {
-		dev_err(&pdev->dev, "64-bit addressable DMA is not compatible with 32-bit archecture\n");
-		ret = -EINVAL;
-		goto cleanup_clk;
-	}
 
-	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(addr_width));
-	if (ret) {
-		dev_err(&pdev->dev, "No suitable DMA available\n");
-		goto cleanup_clk;
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(addr_width));
+		if (ret) {
+			dev_err(&pdev->dev, "No suitable DMA available\n");
+			goto cleanup_clk;
+		}
+		netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
+		netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll);
 	}
 
 	/* Check for Ethernet core IRQ (optional) */
@@ -2092,14 +2151,16 @@ static int axienet_probe(struct platform_device *pdev)
 	}
 
 	lp->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
-	lp->coalesce_usec_rx = XAXIDMA_DFT_RX_USEC;
 	lp->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
-	lp->coalesce_usec_tx = XAXIDMA_DFT_TX_USEC;
 
-	/* Reset core now that clocks are enabled, prior to accessing MDIO */
-	ret = __axienet_device_reset(lp);
-	if (ret)
-		goto cleanup_clk;
+	if (!lp->use_dmaengine) {
+		lp->coalesce_usec_rx = XAXIDMA_DFT_RX_USEC;
+		lp->coalesce_usec_tx = XAXIDMA_DFT_TX_USEC;
+		/* Reset core now that clocks are enabled, prior to accessing MDIO */
+		ret = __axienet_device_reset(lp);
+		if (ret)
+			goto cleanup_clk;
+	}
 
 	ret = axienet_mdio_setup(lp);
 	if (ret)
-- 
2.25.1

