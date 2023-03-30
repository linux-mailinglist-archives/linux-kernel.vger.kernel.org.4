Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C4D6CFC25
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjC3HDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjC3HDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:03:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251FA5FEB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680159780; x=1711695780;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ha6H+SZyBXx//gj4nDJJ9ogNSgJ8Pc3xlcWt+hyabCM=;
  b=FGpGTZ7oxReaO7cqFn2JuSr/sO5ddrNhB+Vrai4VXkaP41JcmF1Tp09+
   SvnTTNXzEyp2m7epS+0oilyJMW3skf0/XjVcMFlidgL5+bpInQzbVvg6O
   Wiwpc4GfI32neYRfE4obHfYyQCQMkPsj9hTTY9Dlw28jxjZL3tj7I68xS
   JowRaMSzHkv7ZjL9nmCQmUDWZlZ83cd/wFuq69HMmm+hxWw3bchwjIJY+
   vJG7d3tE96SBGMRUhCyy+TXfWAEhFWqh9jGljy6V5NyAObg7QlryYrvv6
   vIXV+oPQlTDlhIR9rr1MXWe0xSnuZEz2psTxmtikbB+02utBObYGwd1vk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="329580916"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="329580916"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 00:02:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="795557966"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="795557966"
Received: from pglmail07.png.intel.com ([10.221.193.207])
  by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2023 00:02:57 -0700
Received: from localhost (ppgyli0109.png.intel.com [10.126.160.114])
        by pglmail07.png.intel.com (Postfix) with ESMTP id 55B104837;
        Thu, 30 Mar 2023 15:02:57 +0800 (+08)
Received: by localhost (Postfix, from userid 11742525)
        id 54B103040; Thu, 30 Mar 2023 15:02:57 +0800 (+08)
From:   Boon Khai Ng <boon.khai.ng@intel.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Tien Sung Ang <tien.sung.ang@intel.com>,
        Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [PATCH v1 1/8] drivers: net: stmmac_main: Add support for HW-accelerated VLAN Stripping
Date:   Thu, 30 Mar 2023 15:02:52 +0800
Message-Id: <20230330070252.12705-1-boon.khai.ng@intel.com>
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

Currently, VLAN tag stripping is done by driver in stmmac_rx_vlan().
Add support for VLAN tag stripping by the MAC hardware for MAC drivers
that support it. This is done by adding rx_hw_vlan() and
set_hw_vlan_mode() callbacks at stmmac_ops struct which are called if
registered by the MAC driver.

This patch is applying at the higher level of the driver at stmmac_main
this will be upstreammed by IoTG team and thus it is decoupled from
the next patch.

Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h    | 16 ++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 22 ++++++++++++++++++-
 include/linux/stmmac.h                        |  1 +
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 16a7421715cb..3a317ae87880 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -55,6 +55,10 @@ struct stmmac_desc_ops {
 	void (*set_tx_ic)(struct dma_desc *p);
 	/* Last tx segment reports the transmit status */
 	int (*get_tx_ls)(struct dma_desc *p);
+	/* RX VLAN TCI */
+	int (*get_rx_vlan_tci)(struct dma_desc *p);
+	/* RX VLAN valid */
+	bool (*get_rx_vlan_valid)(struct dma_desc *p);
 	/* Return the transmit status looking at the TDES1 */
 	int (*tx_status)(void *data, struct stmmac_extra_stats *x,
 			struct dma_desc *p, void __iomem *ioaddr);
@@ -116,6 +120,10 @@ struct stmmac_desc_ops {
 	stmmac_do_void_callback(__priv, desc, set_tx_ic, __args)
 #define stmmac_get_tx_ls(__priv, __args...) \
 	stmmac_do_callback(__priv, desc, get_tx_ls, __args)
+#define stmmac_get_rx_vlan_tci(__priv, __args...) \
+	stmmac_do_callback(__priv, desc, get_rx_vlan_tci, __args)
+#define stmmac_get_rx_vlan_valid(__priv, __args...) \
+	stmmac_do_callback(__priv, desc, get_tx_vlan_valid, __args)
 #define stmmac_tx_status(__priv, __args...) \
 	stmmac_do_callback(__priv, desc, tx_status, __args)
 #define stmmac_get_tx_len(__priv, __args...) \
@@ -368,6 +376,10 @@ struct stmmac_ops {
 	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash,
 				 __le16 perfect_match, bool is_double);
 	void (*enable_vlan)(struct mac_device_info *hw, u32 type);
+	void (*rx_hw_vlan)(struct net_device *dev, struct mac_device_info *hw,
+			   struct dma_desc *rx_desc, struct sk_buff *skb);
+	void (*set_hw_vlan_mode)(void __iomem *ioaddr,
+				 netdev_features_t features);
 	int (*add_hw_vlan_rx_fltr)(struct net_device *dev,
 				   struct mac_device_info *hw,
 				   __be16 proto, u16 vid);
@@ -475,6 +487,10 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, update_vlan_hash, __args)
 #define stmmac_enable_vlan(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, enable_vlan, __args)
+#define stmmac_rx_hw_vlan(__priv, __args...) \
+	stmmac_do_void_callback(__priv, mac, rx_hw_vlan, __args)
+#define stmmac_set_hw_vlan_mode(__priv, __args...) \
+	stmmac_do_void_callback(__priv, mac, set_hw_vlan_mode, __args)
 #define stmmac_add_hw_vlan_rx_fltr(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, add_hw_vlan_rx_fltr, __args)
 #define stmmac_del_hw_vlan_rx_fltr(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 17310ade88dd..8ee595d46481 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3421,6 +3421,10 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 			stmmac_fpe_handshake(priv, true);
 	}
 
+	/* Set HW VLAN Stripping mode */
+	if (priv->plat->use_hw_vlan)
+		stmmac_set_hw_vlan_mode(priv, priv->ioaddr, dev->features);
+
 	return 0;
 }
 
@@ -5399,7 +5403,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		/* Got entire packet into SKB. Finish it. */
 
 		stmmac_get_rx_hwtstamp(priv, p, np, skb);
-		stmmac_rx_vlan(priv->dev, skb);
+
+		/* Switch between rx_hw_vlan or rx_vlan */
+		if (priv->plat->use_hw_vlan)
+			stmmac_rx_hw_vlan(priv, priv->dev,
+					  priv->hw, p, skb);
+		else
+			stmmac_rx_vlan(priv->dev, skb);
+
 		skb->protocol = eth_type_trans(skb, priv->dev);
 
 		if (unlikely(!coe))
@@ -5650,6 +5661,10 @@ static int stmmac_set_features(struct net_device *netdev,
 {
 	struct stmmac_priv *priv = netdev_priv(netdev);
 
+	netdev_features_t changed;
+
+	changed = netdev->features ^ features;
+
 	/* Keep the COE Type in case of csum is supporting */
 	if (features & NETIF_F_RXCSUM)
 		priv->hw->rx_csum = priv->plat->rx_coe;
@@ -5668,6 +5683,9 @@ static int stmmac_set_features(struct net_device *netdev,
 			stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
 	}
 
+	if (changed & NETIF_F_HW_VLAN_CTAG_RX)
+		stmmac_set_hw_vlan_mode(priv, priv->ioaddr, features);
+
 	return 0;
 }
 
@@ -7217,6 +7235,8 @@ int stmmac_dvr_probe(struct device *device,
 #ifdef STMMAC_VLAN_TAG_USED
 	/* Both mac100 and gmac support receive VLAN tag detection */
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
+	ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
+
 	if (priv->dma_cap.vlhash) {
 		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 		ndev->features |= NETIF_F_HW_VLAN_STAG_FILTER;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index a2414c187483..0f2800eada9d 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -273,5 +273,6 @@ struct plat_stmmacenet_data {
 	bool use_phy_wol;
 	bool sph_disable;
 	bool serdes_up_after_phy_linkup;
+	bool use_hw_vlan;
 };
 #endif
-- 
2.25.1

