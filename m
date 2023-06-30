Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DF174347C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjF3Flc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjF3FlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:41:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20616.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB383AAE;
        Thu, 29 Jun 2023 22:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3ZKpPPIpCsLjGE2bgwIS6GD31Y8HqfNH73aXr2rU27PqlL2cCsXAfHMcb+67tabtImcuXIJsOjt1goYFKTN4MrDtKsXKQwDNVqkC4kp6jy8JubeE/YNAKdqzV7pG/D2BMQjjChJK+RAZzEiV57RO3+ZFZL9T1P+s4+6C36crKfXbInuAgwB7vOnBT3h6S0bp74jGTaL+TBoOmpRdxB39acPKrGdhovDWsbUusX5J6xN75HO6WSN9mBM4rb+gDPK5bgTc/1A8QFk0X+ijjm5g6PcouEK58QaaCaSTcQabRDXiKwmxgddaj6mLK/snmKTzYPluFusjbWDvtBNxtQ+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/V0kR+Bf9c/SbqV2nADViWn/nWikp09f5GLzT2IdPw=;
 b=i0za2vMv2Lv9uHWl5X5jflQbnlRB7+FFJjD684R0LseoXxObvUiRiTlFfpc9Tf8+d4YA1RH/0oTw+ZvefS3zO2KHC0rJDVnIgK7l5n/gABtESV47IfUXsL4NSYDI64cwiaHwptsIIPSRYG5mIlhIFTeytnCBr0AVKyn59UjFGxc8SIbcdjEHmWJ/r6wOX16bzTdhjwKAfs/t6eSpO/6Y5g4KGZrRHn5oPKNWYjFFW2SWJzKIudfb215ZGEnOuDIEzEh1Gt6v+QYLmE2084dqwJErltApwlRJmFXnAY3qqbiNZSTbgJveCj64gmt2tMCtSaBSdpumvlGe5VpVnAmSlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/V0kR+Bf9c/SbqV2nADViWn/nWikp09f5GLzT2IdPw=;
 b=XnNNmmtrRYlBUBEbITQv7e59IYyvpyd5iZEICdCkcNhauQdMZIMdKCqbUuRQ7bgPjrrTG84W6fcLQ1N7cSgih/2RfNoZ961FSZFbi/gyNZ/UBgOvjFlQjnEYXVhw8DlPKC3q22o4gpL5HUAaRtjajHfrKdi7mlxrHMISaws3XZ0=
Received: from DS7PR03CA0202.namprd03.prod.outlook.com (2603:10b6:5:3b6::27)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 05:39:15 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::ee) by DS7PR03CA0202.outlook.office365.com
 (2603:10b6:5:3b6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 05:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.50 via Frontend Transport; Fri, 30 Jun 2023 05:39:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 00:39:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 00:39:05 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 30 Jun 2023 00:39:00 -0500
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
Subject: [PATCH net-next V4 3/3] net: axienet: Introduce dmaengine support
Date:   Fri, 30 Jun 2023 11:08:44 +0530
Message-ID: <20230630053844.1366171-4-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630053844.1366171-1-sarath.babu.naidu.gaddam@amd.com>
References: <20230630053844.1366171-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3adf12-9f3a-40c5-fb50-08db792c575e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxriUZKX0Q5wda1mfUXe2jUYLifgv3fbW2X7NpwYmwTw53XZ+f2YHysJwYbltyKpKdNCR1fGZ4YlY6nRXWi5z3hkZ9dEHIoNPB4U4fV2OFJNi3/7c6QFad+exhzjRR9jTS9wVmZlmecaOEL/TW9zWl9+4YOPbB7BpTE9GMKLXKir/Y5qSdl7K1tuyXr7vOVCj7xXrJ2CXkPPd/+QW+D/s87zyKY+tQ7vh4buwcLxQwmmx9nVnXeANwBk507n/F0zEPXAtckSHahSJ+qbBwx+Xst+N+nqjxZ5ceIFu0FoiAp9CAZrgZns9Wq+4NBISh7luhv7VKSAirxqtejQ6n+0/B5U2f9IOz5DDznK5g8zCOYqO/Cq1adnZ5AvOvoIOZGgjGn3e+pavYtSQYR/vUVoat0zIu9gsSLPlwzaB03KqU+HUqs4cI7Nghtt/PKglFCsDQwh+vs8JpB3jsef++rPJ4vyDlWm8IUQYlPHfAa/c9Td83eX4Bi+FipE1RpnVUvrAA3sfnKVz645eAhNtKHPs1hQFfSeSCbvK8Z1hjw5y1U82ldyfLmqPCqTL8bI+6ENfRTFvNWwSssCWV/AS0dyfeRMlpAz8s9bxcxA1gy+WwXlqGlhfqIpkjGOVvqYWrxJG6CGmElo447Q6/V9JkSWkLek8Tip5Vdxyg3aLRbWE8VQ1ibSCSRSpjZMY/+4guyWSzkPvSbKoMQcZNWALUl30olVpJWpHNa/4J6TaUnybaVVmVU3HHbbm5JCt7ipZoCQ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(26005)(4326008)(82310400005)(8936002)(36860700001)(966005)(110136005)(2616005)(478600001)(1076003)(336012)(54906003)(426003)(2906002)(6666004)(83380400001)(186003)(356005)(103116003)(30864003)(70206006)(7416002)(47076005)(36756003)(82740400003)(81166007)(40480700001)(70586007)(5660300002)(86362001)(40460700003)(8676002)(41300700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 05:39:15.3484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3adf12-9f3a-40c5-fb50-08db792c575e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dmaengine framework to communicate with the xilinx DMAengine
driver(AXIDMA).

Axi ethernet driver uses separate channels for transmit and receive.
Add support for these channels to handle TX and RX with skb and
appropriate callbacks. Also add axi ethernet core interrupt for
dmaengine framework support.

The dmaengine framework was extended for metadata API support during the
axidma RFC[1] discussion. However it still needs further enhancements to
make it well suited for ethernet usecases. The ethernet features i.e
ethtool set/get of DMA IP properties, ndo_poll_controller,(mentioned
in TODO) and it requires follow-up discussion and dma framework
enhancement.

Introducing dmaengine support has a dependency on xilinx_dma. It uses
one of xilinx_dma API to reset the DMA. DMA needs to be reset prior
to accessing MDIO.

[1]: https://lore.kernel.org/lkml/1522665546-10035-1-git-send-email-
radheys@xilinx.com

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
---
Changes in V4:
1) Remove the AXIENET_USE_DMA.
2) Add dev_err_probe for dma_request_chan error handling.
3) Add kmem_cache_destroy for create in axienet_setup_dma_chan.
4) Add XILINX_DMA dependency in ethernet drier Kconfig file.
5) move setup_dma_channel to init_dmaengine func
6) Remove unlikely
	if (unlikely(ret < 0))
7) if (ret == 0) to if (!ret)
8) Rename DMA_MEM_TO_DEV to DMA_TO_DEVICE
9) Remove else check for lp->use_dmaengine = 1; in the probe.

Changes in V3:
1) New patch for dmaengine framework support.
---
 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |   6 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 309 +++++++++++++++++-
 3 files changed, 314 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 0014729b8865..35d96c633a33 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -26,6 +26,7 @@ config XILINX_EMACLITE
 config XILINX_AXI_EMAC
 	tristate "Xilinx 10/100/1000 AXI Ethernet support"
 	depends on HAS_IOMEM
+	depends on XILINX_DMA
 	select PHYLINK
 	help
 	  This driver supports the 10/100/1000 Ethernet from Xilinx for the
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 3ead0bac597b..726c14d1470a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -436,6 +436,9 @@ struct axidma_bd {
  * @coalesce_count_tx:	Store the irq coalesce on TX side.
  * @coalesce_usec_tx:	IRQ coalesce delay for TX
  * @use_dmaengine: flag to check dmaengine framework usage.
+ * @tx_chan:	TX DMA channel.
+ * @rx_chan:	RX DMA channel.
+ * @skb_cache:	Custom skb slab allocator
  */
 struct axienet_local {
 	struct net_device *ndev;
@@ -501,6 +504,9 @@ struct axienet_local {
 	u32 coalesce_count_tx;
 	u32 coalesce_usec_tx;
 	u8  use_dmaengine;
+	struct dma_chan *tx_chan;
+	struct dma_chan *rx_chan;
+	struct kmem_cache *skb_cache;
 };
 
 /**
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1fa67bb09625..ea7321703155 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -37,6 +37,9 @@
 #include <linux/phy.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma/xilinx_dma.h>
 
 #include "xilinx_axienet.h"
 
@@ -46,6 +49,9 @@
 #define TX_BD_NUM_MIN			(MAX_SKB_FRAGS + 1)
 #define TX_BD_NUM_MAX			4096
 #define RX_BD_NUM_MAX			4096
+#define DMA_NUM_APP_WORDS		5
+#define LEN_APP				4
+#define RX_BUF_NUM_DEFAULT		128
 
 /* Must be shorter than length of ethtool_drvinfo.driver field to fit */
 #define DRIVER_NAME		"xaxienet"
@@ -54,6 +60,16 @@
 
 #define AXIENET_REGS_N		40
 
+struct axi_skbuff {
+	struct scatterlist sgl[MAX_SKB_FRAGS + 1];
+	struct dma_async_tx_descriptor *desc;
+	dma_addr_t dma_address;
+	struct sk_buff *skb;
+	int sg_len;
+} __packed;
+
+static int axienet_rx_submit_desc(struct net_device *ndev);
+
 /* Match table for of_platform binding */
 static const struct of_device_id axienet_of_match[] = {
 	{ .compatible = "xlnx,axi-ethernet-1.00.a", },
@@ -726,6 +742,108 @@ static inline int axienet_check_tx_bd_space(struct axienet_local *lp,
 	return 0;
 }
 
+/**
+ * axienet_dma_tx_cb - DMA engine callback for TX channel.
+ * @data:       Pointer to the axi_skbuff structure
+ * @result:     error reporting through dmaengine_result.
+ * This function is called by dmaengine driver for TX channel to notify
+ * that the transmit is done.
+ */
+static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
+{
+	struct axi_skbuff *axi_skb = data;
+
+	struct net_device *netdev = axi_skb->skb->dev;
+	struct axienet_local *lp = netdev_priv(netdev);
+
+	u64_stats_update_begin(&lp->tx_stat_sync);
+	u64_stats_add(&lp->tx_bytes, axi_skb->skb->len);
+	u64_stats_add(&lp->tx_packets, 1);
+	u64_stats_update_end(&lp->tx_stat_sync);
+
+	dma_unmap_sg(lp->dev, axi_skb->sgl, axi_skb->sg_len, DMA_TO_DEVICE);
+	dev_kfree_skb_any(axi_skb->skb);
+	kmem_cache_free(lp->skb_cache, axi_skb);
+}
+
+/**
+ * axienet_start_xmit_dmaengine - Starts the transmission.
+ * @skb:        sk_buff pointer that contains data to be Txed.
+ * @ndev:       Pointer to net_device structure.
+ *
+ * Return: NETDEV_TX_OK, on success
+ *          NETDEV_TX_BUSY, if any memory failure or SG error.
+ *
+ * This function is invoked from xmit to initiate transmission. The
+ * function sets the skbs , call back API, SG etc.
+ * Additionally if checksum offloading is supported,
+ * it populates AXI Stream Control fields with appropriate values.
+ */
+static netdev_tx_t
+axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct dma_async_tx_descriptor *dma_tx_desc = NULL;
+	struct axienet_local *lp = netdev_priv(ndev);
+	u32 app[DMA_NUM_APP_WORDS] = {0};
+	struct axi_skbuff *axi_skb;
+	u32 csum_start_off;
+	u32 csum_index_off;
+	int sg_len;
+	int ret;
+
+	sg_len = skb_shinfo(skb)->nr_frags + 1;
+	axi_skb = kmem_cache_zalloc(lp->skb_cache, GFP_KERNEL);
+	if (!axi_skb)
+		return NETDEV_TX_BUSY;
+
+	sg_init_table(axi_skb->sgl, sg_len);
+	ret = skb_to_sgvec(skb, axi_skb->sgl, 0, skb->len);
+	if (ret < 0)
+		goto xmit_error_skb_sgvec;
+
+	ret = dma_map_sg(lp->dev, axi_skb->sgl, sg_len, DMA_TO_DEVICE);
+	if (!ret)
+		goto xmit_error_skb_sgvec;
+
+	/*Fill up app fields for checksum */
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
+			/* Tx Full Checksum Offload Enabled */
+			app[0] |= 2;
+		} else if (lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) {
+			csum_start_off = skb_transport_offset(skb);
+			csum_index_off = csum_start_off + skb->csum_offset;
+			/* Tx Partial Checksum Offload Enabled */
+			app[0] |= 1;
+			app[1] = (csum_start_off << 16) | csum_index_off;
+		}
+	} else if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
+		app[0] |= 2; /* Tx Full Checksum Offload Enabled */
+	}
+
+	dma_tx_desc = lp->tx_chan->device->device_prep_slave_sg(lp->tx_chan, axi_skb->sgl,
+			sg_len, DMA_MEM_TO_DEV,
+			DMA_PREP_INTERRUPT, (void *)app);
+
+	if (!dma_tx_desc)
+		goto xmit_error_prep;
+
+	axi_skb->skb = skb;
+	axi_skb->sg_len = sg_len;
+	dma_tx_desc->callback_param =  axi_skb;
+	dma_tx_desc->callback_result = axienet_dma_tx_cb;
+	dmaengine_submit(dma_tx_desc);
+	dma_async_issue_pending(lp->tx_chan);
+
+	return NETDEV_TX_OK;
+
+xmit_error_prep:
+	dma_unmap_sg(lp->dev, axi_skb->sgl, sg_len, DMA_TO_DEVICE);
+xmit_error_skb_sgvec:
+	kmem_cache_free(lp->skb_cache, axi_skb);
+	return NETDEV_TX_BUSY;
+}
+
 /**
  * axienet_tx_poll - Invoked once a transmit is completed by the
  * Axi DMA Tx channel.
@@ -910,7 +1028,42 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	if (!lp->use_dmaengine)
 		return axienet_start_xmit_legacy(skb, ndev);
 	else
-		return NETDEV_TX_BUSY;
+		return axienet_start_xmit_dmaengine(skb, ndev);
+}
+
+/**
+ * axienet_dma_rx_cb - DMA engine callback for RX channel.
+ * @data:       Pointer to the axi_skbuff structure
+ * @result:     error reporting through dmaengine_result.
+ * This function is called by dmaengine driver for RX channel to notify
+ * that the packet is received.
+ */
+static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
+{
+	struct axi_skbuff *axi_skb = data;
+	struct sk_buff *skb = axi_skb->skb;
+	struct net_device *netdev = skb->dev;
+	struct axienet_local *lp = netdev_priv(netdev);
+	size_t meta_len, meta_max_len, rx_len;
+	u32 *app;
+
+	app  = dmaengine_desc_get_metadata_ptr(axi_skb->desc, &meta_len, &meta_max_len);
+	dma_unmap_single(lp->dev, axi_skb->dma_address, lp->max_frm_size,
+			 DMA_FROM_DEVICE);
+	/* TODO: Derive app word index programmatically */
+	rx_len = (app[LEN_APP] & 0xFFFF);
+	skb_put(skb, rx_len);
+	skb->protocol = eth_type_trans(skb, netdev);
+	skb->ip_summed = CHECKSUM_NONE;
+
+	netif_rx(skb);
+	kmem_cache_free(lp->skb_cache, axi_skb);
+	u64_stats_update_begin(&lp->rx_stat_sync);
+	u64_stats_add(&lp->rx_packets, 1);
+	u64_stats_add(&lp->rx_bytes, rx_len);
+	u64_stats_update_end(&lp->rx_stat_sync);
+	axienet_rx_submit_desc(netdev);
+	dma_async_issue_pending(lp->rx_chan);
 }
 
 /**
@@ -1146,6 +1299,108 @@ static irqreturn_t axienet_eth_irq(int irq, void *_ndev)
 
 static void axienet_dma_err_handler(struct work_struct *work);
 
+/**
+ * axienet_rx_submit_desc - Submit the descriptors with required data
+ * like call backup API, skb buffer.. etc to dmaengine.
+ *
+ * @ndev:	net_device pointer
+ *
+ *Return: 0, on success.
+ *          non-zero error value on failure
+ */
+static int axienet_rx_submit_desc(struct net_device *ndev)
+{
+	struct dma_async_tx_descriptor *dma_rx_desc = NULL;
+	struct axienet_local *lp = netdev_priv(ndev);
+	struct axi_skbuff *axi_skb;
+	struct sk_buff *skb;
+	dma_addr_t addr;
+	int ret;
+
+	axi_skb = kmem_cache_alloc(lp->skb_cache, GFP_KERNEL);
+
+	if (!axi_skb)
+		return -ENOMEM;
+	skb = netdev_alloc_skb(ndev, lp->max_frm_size);
+	if (!skb) {
+		ret = -ENOMEM;
+		goto rx_bd_init_skb;
+	}
+
+	sg_init_table(axi_skb->sgl, 1);
+	addr = dma_map_single(lp->dev, skb->data, lp->max_frm_size, DMA_FROM_DEVICE);
+	sg_dma_address(axi_skb->sgl) = addr;
+	sg_dma_len(axi_skb->sgl) = lp->max_frm_size;
+	dma_rx_desc = dmaengine_prep_slave_sg(lp->rx_chan, axi_skb->sgl,
+					      1, DMA_DEV_TO_MEM,
+					      DMA_PREP_INTERRUPT);
+	if (!dma_rx_desc) {
+		ret = -EINVAL;
+		goto rx_bd_init_prep_sg;
+	}
+
+	axi_skb->skb = skb;
+	axi_skb->dma_address = sg_dma_address(axi_skb->sgl);
+	axi_skb->desc = dma_rx_desc;
+	dma_rx_desc->callback_param =  axi_skb;
+	dma_rx_desc->callback_result = axienet_dma_rx_cb;
+	dmaengine_submit(dma_rx_desc);
+
+	return 0;
+
+rx_bd_init_prep_sg:
+	dma_unmap_single(lp->dev, addr, lp->max_frm_size, DMA_FROM_DEVICE);
+	dev_kfree_skb(skb);
+rx_bd_init_skb:
+	kmem_cache_free(lp->skb_cache, axi_skb);
+	return ret;
+}
+
+/**
+ * axienet_init_dmaengine - init the dmaengine code.
+ * @ndev:       Pointer to net_device structure
+ *
+ * Return: 0, on success.
+ *          non-zero error value on failure
+ *
+ * This is the dmaengine initialization code.
+ */
+static inline int axienet_init_dmaengine(struct net_device *ndev)
+{
+	struct axienet_local *lp = netdev_priv(ndev);
+	int i, ret;
+
+	lp->tx_chan = dma_request_chan(lp->dev, "tx_chan0");
+	if (IS_ERR(lp->tx_chan)) {
+		ret = PTR_ERR(lp->tx_chan);
+		return dev_err_probe(lp->dev, ret, "No Ethernet DMA (TX) channel found\n");
+	}
+
+	lp->rx_chan = dma_request_chan(lp->dev, "rx_chan0");
+	if (IS_ERR(lp->rx_chan)) {
+		ret = PTR_ERR(lp->rx_chan);
+		dev_err_probe(lp->dev, ret, "No Ethernet DMA (RX) channel found\n");
+		goto err_dma_request_rx;
+	}
+	lp->skb_cache = kmem_cache_create("ethernet", sizeof(struct axi_skbuff),
+					  0, 0, NULL);
+	if (!lp->skb_cache) {
+		ret =  -ENOMEM;
+		goto err_kmem;
+	}
+	/* TODO: Instead of BD_NUM_DEFAULT use runtime support*/
+	for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
+		axienet_rx_submit_desc(ndev);
+	dma_async_issue_pending(lp->rx_chan);
+
+	return 0;
+err_kmem:
+	dma_release_channel(lp->rx_chan);
+err_dma_request_rx:
+	dma_release_channel(lp->tx_chan);
+	return ret;
+}
+
 /**
  * axienet_init_legacy_dma - init the dma legacy code.
  * @ndev:       Pointer to net_device structure
@@ -1237,7 +1492,24 @@ static int axienet_open(struct net_device *ndev)
 
 	phylink_start(lp->phylink);
 
-	if (!lp->use_dmaengine) {
+	if (lp->use_dmaengine) {
+		/* Enable interrupts for Axi Ethernet core (if defined) */
+		if (lp->eth_irq > 0) {
+			ret = request_irq(lp->eth_irq, axienet_eth_irq, IRQF_SHARED,
+					  ndev->name, ndev);
+			if (ret)
+				goto error_code;
+		}
+
+		ret = axienet_init_dmaengine(ndev);
+
+		if (ret < 0) {
+			if (lp->eth_irq > 0)
+				free_irq(lp->eth_irq, ndev);
+			goto error_code;
+		}
+
+	} else {
 		ret = axienet_init_legacy_dma(ndev);
 		if (ret)
 			goto error_code;
@@ -1285,6 +1557,14 @@ static int axienet_stop(struct net_device *ndev)
 		free_irq(lp->tx_irq, ndev);
 		free_irq(lp->rx_irq, ndev);
 		axienet_dma_bd_release(ndev);
+	} else {
+		dmaengine_terminate_all(lp->tx_chan);
+		dmaengine_terminate_all(lp->rx_chan);
+
+		dma_release_channel(lp->rx_chan);
+		dma_release_channel(lp->tx_chan);
+
+		kmem_cache_destroy(lp->skb_cache);
 	}
 
 	axienet_iow(lp, XAE_IE_OFFSET, 0);
@@ -2134,6 +2414,31 @@ static int axienet_probe(struct platform_device *pdev)
 		}
 		netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
 		netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll);
+	} else {
+		struct xilinx_vdma_config cfg;
+		struct dma_chan *tx_chan;
+
+		lp->eth_irq = platform_get_irq_optional(pdev, 0);
+		tx_chan = dma_request_chan(lp->dev, "tx_chan0");
+
+		if (IS_ERR(tx_chan)) {
+			ret = PTR_ERR(tx_chan);
+			dev_err_probe(lp->dev, ret, "No Ethernet DMA (TX) channel found\n");
+			goto cleanup_clk;
+		}
+
+		cfg.reset = 1;
+		/* As name says VDMA but it has support for DMA channel reset*/
+		ret = xilinx_vdma_channel_set_config(tx_chan, &cfg);
+
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Reset channel failed\n");
+			dma_release_channel(tx_chan);
+			goto cleanup_clk;
+		}
+
+		dma_release_channel(tx_chan);
+		lp->use_dmaengine = 1;
 	}
 
 	/* Check for Ethernet core IRQ (optional) */
-- 
2.25.1

