Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A076CFC2E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjC3HEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjC3HEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:04:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3317B26A4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680159861; x=1711695861;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FzchC5yvv4fr+fDOQGWdB0zVaHbcHBips95LiJ5yJcw=;
  b=dgaLcHoyBLtuTiJfkPGEXzqGikBK4uF0oppY/uQ6C2jwsC2QIWz9Seu/
   1tIbrQHBDLEHt63yAG1jzYo+Jo9t7msEFYaa2SVUONxa+aiAkNGkpXtdO
   y/pIbNlazxmpyM632rZMbbSOiUIOK04iTO/9jEFJcaXS3YvSmCQQmwBmS
   oREnZRkVR00YHRhdIZ8VvTI2AjqTniw7VP5rVjQcqYxwHzshUJd6WSBbs
   /zco1NF3xhDbhyynQ7xN60zSvx6/CSExPVdrxpbmSEJltgwqBvPCVLf4W
   1zGx9cwKRdbHWu6JjOI169cTTp19cERFq7O4x/YkP2c/KmINWlwXqt9aE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="329581129"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="329581129"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 00:04:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="795558346"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="795558346"
Received: from pglmail07.png.intel.com ([10.221.193.207])
  by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2023 00:04:17 -0700
Received: from localhost (ppgyli0109.png.intel.com [10.126.160.114])
        by pglmail07.png.intel.com (Postfix) with ESMTP id 4B9A72B68;
        Thu, 30 Mar 2023 15:04:17 +0800 (+08)
Received: by localhost (Postfix, from userid 11742525)
        id 4AA463040; Thu, 30 Mar 2023 15:04:17 +0800 (+08)
From:   Boon Khai Ng <boon.khai.ng@intel.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Tien Sung Ang <tien.sung.ang@intel.com>,
        Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [PATCH v1 8/8] net: stmmac: Add option for VLAN filter fail queue enable
Date:   Thu, 30 Mar 2023 15:04:15 +0800
Message-Id: <20230330070415.13221-1-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=AC_FROM_MANY_DOTS,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option allows packet that fail VLAN filter to be routed
to specific Rx queue when receive all is also set.

When this option is enabled:
- Enable VFFQ only when entering promiscuous mode, because receive all
  will pass up all rx packets that failed address filtering (similar to
  promiscuous mode).
- VLAN-promiscuous mode is never entered to allow rx packet to fail VLAN
  filters and get routed to selected VFFQ Rx queue.

Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h   |  5 +++++
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c  | 16 +++++++++++++---
 .../ethernet/stmicro/stmmac/stmmac_platform.c    |  7 +++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 428f82905273..5043a520a00a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -85,6 +85,11 @@
 #define XGMAC_RXQ_CTRL3			0x000000ac
 #define XGMAC_PSRQ(x)			GENMASK((x) * 8 + 7, (x) * 8)
 #define XGMAC_PSRQ_SHIFT(x)		((x) * 8)
+#define XGMAC_RXQ_CTRL4			0x00000094
+/* VFFQ mask might vary and depending on how many RX Q enabled */
+#define XGMAC_RXQCTRL_VFFQ_MASK		GENMASK(19, 17)
+#define XGMAC_RXQCTRL_VFFQ_SHIFT	17
+#define XGMAC_RXQCTRL_VFFQE		BIT(16)
 #define XGMAC_INT_STATUS		0x000000b0
 #define XGMAC_LPIIS			BIT(5)
 #define XGMAC_PMTIS			BIT(4)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 4dff53dc771f..a3e95efd1e83 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -658,6 +658,7 @@ static void dwxgmac2_set_filter(struct mac_device_info *hw,
 {
 	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
 	u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
+	u32 value_ctrl = 0;
 	int mcbitslog2 = hw->mcast_bits_log2;
 	u32 mc_filter[8];
 	int i;
@@ -668,8 +669,17 @@ static void dwxgmac2_set_filter(struct mac_device_info *hw,
 	memset(mc_filter, 0, sizeof(mc_filter));
 
 	if (dev->flags & IFF_PROMISC) {
-		value |= XGMAC_FILTER_PR;
-		value |= XGMAC_FILTER_PCF;
+		if (hw->vlan_fail_q_en) {
+			value_ctrl = readl(ioaddr + XGMAC_RXQ_CTRL4);
+			value_ctrl &= ~XGMAC_RXQCTRL_VFFQ_MASK;
+			value_ctrl |= XGMAC_RXQCTRL_VFFQE |
+				(hw->vlan_fail_q << XGMAC_RXQCTRL_VFFQ_SHIFT);
+			writel(value_ctrl, ioaddr + XGMAC_RXQ_CTRL4);
+			value = XGMAC_FILTER_PR | XGMAC_FILTER_RA;
+		} else {
+			value = XGMAC_FILTER_PR | XGMAC_FILTER_PCF;
+		}
+
 	} else if ((dev->flags & IFF_ALLMULTI) ||
 		   (netdev_mc_count(dev) > hw->multicast_filter_bins)) {
 		value |= XGMAC_FILTER_PM;
@@ -714,7 +724,7 @@ static void dwxgmac2_set_filter(struct mac_device_info *hw,
 
 	writel(value, ioaddr + XGMAC_PACKET_FILTER);
 
-	if (dev->flags & IFF_PROMISC) {
+	if (dev->flags & IFF_PROMISC && !hw->vlan_fail_q_en) {
 		if (!hw->promisc) {
 			hw->promisc = 1;
 			dwxgmac2_vlan_promisc_enable(dev, hw);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 26da3a9da345..8bc69318ae0d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -543,6 +543,13 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 			dev_info(&pdev->dev, "RX VLAN HW Stripping\n");
 			plat->use_hw_vlan = true;
 		}
+
+		/*VLAN filter failed queue state */
+		if (of_property_read_bool(np, "snps,vlan-fail-q-en")) {
+			dev_info(&pdev->dev, "VLAN filter failed queue\n");
+			plat->vlan_fail_q_en = true;
+			plat->vlan_fail_q = plat->rx_queues_to_use - 1;
+		}
 	}
 
 	dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*dma_cfg),
-- 
2.25.1

