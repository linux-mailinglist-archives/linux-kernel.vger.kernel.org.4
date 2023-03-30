Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4962D6CFC2C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjC3HEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjC3HEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:04:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9214C5240
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680159839; x=1711695839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xtyv66YpPvzhMRJSor++ce65xw1dFlbuga91j3DjbWA=;
  b=HXMn0GWHu3N5M2thXhEDR04lEZPuaFwUk1YyHDkRU2O7XwQek+x/j1H0
   kZKrboxzFtGxM3SQP8t3QmTzvwF6UQjZJvRlUuLAhwVtlbgrzM3oen6l6
   AZnw0v6IJY7LwPvXv1qnA3SVFBFqf1gj5181yzKkk7Nx8AhBq2xiOtEXi
   knmdavUjJlq2FSWuGSvARXva3ARShEte3TBsgH/UFwepMo6hTuBDtluPK
   mQOqwU+BTYa2SOtl7Js0ck8/p0r83Bl4E+c9S0VmPc0ksN2BgO27PaG7m
   SDyKryVHJb1tDDvk55x4/GxASCCRbasfKG+MoZmin85sGMpGx1Em49exP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="342699100"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="342699100"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 00:03:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="930614020"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="930614020"
Received: from pglmail07.png.intel.com ([10.221.193.207])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2023 00:03:47 -0700
Received: from localhost (ppgyli0109.png.intel.com [10.126.160.114])
        by pglmail07.png.intel.com (Postfix) with ESMTP id 01FC54837;
        Thu, 30 Mar 2023 15:03:47 +0800 (+08)
Received: by localhost (Postfix, from userid 11742525)
        id 00A423040; Thu, 30 Mar 2023 15:03:46 +0800 (+08)
From:   Boon Khai Ng <boon.khai.ng@intel.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Tien Sung Ang <tien.sung.ang@intel.com>,
        Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [PATCH v1 5/8] net: stmmac: Add support for VLAN Rx filtering
Date:   Thu, 30 Mar 2023 15:03:45 +0800
Message-Id: <20230330070345.18199-1-boon.khai.ng@intel.com>
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

Add support for VLAN ID-based filtering by the MAC controller for MAC
drivers that support it. Only the 12-bit VID field is used.

Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  21 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 191 +++++++++++++++++-
 2 files changed, 210 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index b7beaa197343..4c92828f21d6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -64,6 +64,10 @@
 #define XGMAC_VLAN_ESVL			BIT(18)
 #define XGMAC_VLAN_ETV			BIT(16)
 #define XGMAC_VLAN_VID			GENMASK(15, 0)
+#define XGMAC_VLAN_OFS			GENMASK(6, 2)
+#define XGMAC_VLAN_OFS_SHIFT		2
+#define XGMAC_VLAN_CT			BIT(1)
+#define XGMAC_VLAN_OB			BIT(0)
 #define XGMAC_VLAN_HASH_TABLE		0x00000058
 #define XGMAC_VLAN_INCL			0x00000060
 #define XGMAC_VLAN_VLTI			BIT(20)
@@ -149,6 +153,7 @@
 #define XGMAC_HWFEAT_FRPES		GENMASK(12, 11)
 #define XGMAC_HWFEAT_FRPPB		GENMASK(10, 9)
 #define XGMAC_HWFEAT_FRPSEL		BIT(3)
+#define XGMAC_HWFEAT_NRVF		GENMASK(2, 0)
 #define XGMAC_MAC_DPP_FSM_INT_STATUS	0x00000150
 #define XGMAC_MAC_FSM_CONTROL		0x00000158
 #define XGMAC_PRTYEN			BIT(1)
@@ -477,7 +482,8 @@
 /* RDES0 (write back format) */
 #define XGMAC_RDES0_VLAN_TAG_MASK	GENMASK(15, 0)
 
-/* MAC VLAN Tag Control */
+/* MAC VLAN Tag Control and VLAN Tag Data */
+#define XGMAC_VLAN_TAG_CTRL		0x00000050
 #define XGMAC_VLAN_TAG_CTRL_OB		BIT(0)
 #define XGMAC_VLAN_TAG_CTRL_CT		BIT(1)
 #define XGMAC_VLAN_TAG_CTRL_OFS_MASK	GENMASK(6, 2)
@@ -491,6 +497,11 @@
 #define XGMAC_VLAN_TAG_STRIP_FAIL	(0x2 << XGMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
 #define XGMAC_VLAN_TAG_STRIP_ALL	(0x3 << XGMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
 
+#define XGMAC_VLAN_TAG_DATA		0x00000054
+#define XGMAC_VLAN_TAG_DATA_ETV		BIT(17)
+#define XGMAC_VLAN_TAG_DATA_VEN		BIT(16)
+#define XGMAC_VLAN_TAG_DATA_VID		GENMASK(15, 0)
+
 /* Error Type or L2 Type(ET/LT) Field Number */
 #define XGMAC_ET_LT_VLAN_STAG		8
 #define XGMAC_ET_LT_VLAN_CTAG		9
@@ -499,4 +510,12 @@
 #define XGMAC_ET_LT_DVLAN_CTAG_STAG	12
 #define XGMAC_ET_LT_DVLAN_STAG_CTAG	13
 
+/* EXT VLAN Filtering HW FEAT */
+#define XGMAC_HWFEAT_NO_EXT		0
+#define XGMAC_HWFEAT_EXT_VLAN_4		1
+#define XGMAC_HWFEAT_EXT_VLAN_8		2
+#define XGMAC_HWFEAT_EXT_VLAN_16	3
+#define XGMAC_HWFEAT_EXT_VLAN_24	4
+#define XGMAC_HWFEAT_EXT_VLAN_32	5
+
 #endif /* __STMMAC_DWXGMAC2_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 8bd77e30cc24..feb9189ec20e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -415,6 +415,157 @@ static void dwxgmac2_set_eee_timer(struct mac_device_info *hw, int ls, int tw)
 	writel(value, ioaddr + XGMAC_LPI_TIMER_CTRL);
 }
 
+static void dwxgmac2_write_single_vlan(struct net_device *dev, u16 vid)
+{
+	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
+	u32 val;
+
+	val = readl(ioaddr + XGMAC_VLAN_TAG);
+	val &= ~XGMAC_VLAN_VID;
+	val |= XGMAC_VLAN_ETV | vid;
+
+	writel(val, ioaddr + XGMAC_VLAN_TAG);
+}
+
+static int dwxgmac2_write_vlan_filter(struct net_device *dev,
+				      struct mac_device_info *hw,
+				      u8 index, u32 data)
+{
+	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
+	int i, timeout = 10;
+	u32 val;
+
+	if (index >= hw->num_vlan)
+		return -EINVAL;
+
+	writel(data, ioaddr + XGMAC_VLAN_TAG_DATA);
+
+	val = readl(ioaddr + XGMAC_VLAN_TAG);
+	val &= ~(XGMAC_VLAN_TAG_CTRL_OFS_MASK |
+		XGMAC_VLAN_CT |
+		XGMAC_VLAN_OB);
+
+	val |= (index << XGMAC_VLAN_OFS_SHIFT | XGMAC_VLAN_OB);
+
+	writel(val, ioaddr + XGMAC_VLAN_TAG);
+
+	for (i = 0; i < timeout; i++) {
+		val = readl(ioaddr + XGMAC_VLAN_TAG);
+		if (!(val & XGMAC_VLAN_OB))
+			return 0;
+		udelay(1);
+	}
+
+	netdev_err(dev, "Timeout accessing MAC_VLAN_TAG_FILTER\n");
+
+	return -EBUSY;
+}
+
+static int dwxgmac2_add_hw_vlan_rx_fltr(struct net_device *dev,
+					struct mac_device_info *hw,
+					__be16 proto, u16 vid)
+{
+	int index = -1;
+	u32 val = 0;
+	int i, ret;
+
+	if (vid > 4095)
+		return -EINVAL;
+
+	/* Single Rx VLAN Filter */
+	if (hw->num_vlan == 1) {
+		/* For single VLAN filter, VID 0 means VLAN promiscuous */
+		if (vid == 0) {
+			netdev_warn(dev, "Adding VLAN ID 0 is not supported\n");
+			return -EPERM;
+		}
+
+		if (hw->vlan_filter[0] & XGMAC_VLAN_VID) {
+			netdev_err(dev, "Only single VLAN ID supported\n");
+			return -EPERM;
+		}
+
+		hw->vlan_filter[0] = vid;
+		dwxgmac2_write_single_vlan(dev, vid);
+
+		return 0;
+	}
+
+	/* Extended Rx VLAN Filter Enable */
+	val |= XGMAC_VLAN_TAG_DATA_ETV | XGMAC_VLAN_TAG_DATA_VEN | vid;
+
+	for (i = 0; i < hw->num_vlan; i++) {
+		if (hw->vlan_filter[i] == val)
+			return 0;
+
+		else if (!(hw->vlan_filter[i] & XGMAC_VLAN_TAG_DATA_VEN))
+			index = i;
+	}
+
+	if (index == -1) {
+		netdev_err(dev, "MAC_VLAN_TAG_FILTER full (size: %0u)\n",
+			   hw->num_vlan);
+		return -EPERM;
+	}
+
+	ret = dwxgmac2_write_vlan_filter(dev, hw, index, val);
+
+	if (!ret)
+		hw->vlan_filter[index] = val;
+
+	return ret;
+}
+
+static int dwxgmac2_del_hw_vlan_rx_fltr(struct net_device *dev,
+					struct mac_device_info *hw,
+					__be16 proto, u16 vid)
+{
+	int i, ret = 0;
+
+	/* Single Rx VLAN Filter */
+	if (hw->num_vlan == 1) {
+		if ((hw->vlan_filter[0] & XGMAC_VLAN_VID) == vid) {
+			hw->vlan_filter[0] = 0;
+			dwxgmac2_write_single_vlan(dev, 0);
+		}
+		return 0;
+	}
+
+	/* Extended Rx VLAN Filter Enable */
+	for (i = 0; i < hw->num_vlan; i++) {
+		if ((hw->vlan_filter[i] & XGMAC_VLAN_TAG_DATA_VID) == vid) {
+			ret = dwxgmac2_write_vlan_filter(dev, hw, i, 0);
+
+			if (!ret)
+				hw->vlan_filter[i] = 0;
+			else
+				return ret;
+		}
+	}
+	return ret;
+}
+
+static void dwxgmac2_restore_hw_vlan_rx_fltr(struct net_device *dev,
+					     struct mac_device_info *hw)
+{
+	u32 val;
+	int i;
+
+	/* Single Rx VLAN Filter */
+	if (hw->num_vlan == 1) {
+		dwxgmac2_write_single_vlan(dev, hw->vlan_filter[0]);
+		return;
+	}
+
+	/* Extended Rx VLAN Filter Enable */
+	for (i = 0; i < hw->num_vlan; i++) {
+		if (hw->vlan_filter[i] & XGMAC_VLAN_TAG_DATA_VEN) {
+			val = hw->vlan_filter[i];
+			dwxgmac2_write_vlan_filter(dev, hw, i, val);
+		}
+	}
+}
+
 static void dwxgmac2_set_mchash(void __iomem *ioaddr, u32 *mcfilterbits,
 				int mcbitslog2)
 {
@@ -493,6 +644,10 @@ static void dwxgmac2_set_filter(struct mac_device_info *hw,
 		}
 	}
 
+	/* VLAN Filtering */
+	if (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
+		value |= XGMAC_FILTER_VTFE;
+
 	writel(value, ioaddr + XGMAC_PACKET_FILTER);
 }
 
@@ -1529,6 +1684,9 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.enable_vlan = dwxgmac2_enable_vlan,
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
+	.add_hw_vlan_rx_fltr = dwxgmac2_add_hw_vlan_rx_fltr,
+	.del_hw_vlan_rx_fltr = dwxgmac2_del_hw_vlan_rx_fltr,
+	.restore_hw_vlan_rx_fltr = dwxgmac2_restore_hw_vlan_rx_fltr,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
 	.est_configure = dwxgmac3_est_configure,
 	.fpe_configure = dwxgmac3_fpe_configure,
@@ -1599,6 +1757,37 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.set_hw_vlan_mode = dwxgmac2_set_hw_vlan_mode,
 };
 
+static u32 dwxgmac2_get_num_vlan(void __iomem *ioaddr)
+{
+	u32 val, num_vlan;
+
+	val = readl(ioaddr + XGMAC_HW_FEATURE3);
+	switch (val & XGMAC_HWFEAT_NRVF) {
+	case 0:
+		num_vlan = 1;
+		break;
+	case 1:
+		num_vlan = 4;
+		break;
+	case 2:
+		num_vlan = 8;
+		break;
+	case 3:
+		num_vlan = 16;
+		break;
+	case 4:
+		num_vlan = 24;
+		break;
+	case 5:
+		num_vlan = 32;
+		break;
+	default:
+		num_vlan = 1;
+	}
+
+	return num_vlan;
+}
+
 int dwxgmac2_setup(struct stmmac_priv *priv)
 {
 	struct mac_device_info *mac = priv->hw;
@@ -1632,7 +1821,7 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
 	mac->mii.reg_mask = GENMASK(15, 0);
 	mac->mii.clk_csr_shift = 19;
 	mac->mii.clk_csr_mask = GENMASK(21, 19);
-
+	mac->num_vlan = dwxgmac2_get_num_vlan(priv->ioaddr);
 	return 0;
 }
 
-- 
2.25.1

