Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08376CFC33
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjC3HFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjC3HFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:05:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE485B8A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680159880; x=1711695880;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zvQjehCoLV/UZ6Hoz5pnB98GnX/LzKxAcj5uY17PNik=;
  b=MF3D78b2yafLEmIeb+P28KK/v4gRMcF8X7kWG50Lrtf8JJ1XF1CQPO6O
   XY4joDbDIdsYSJGPf1I45tWJ/LxRVHXkgpoSR+3mE2uC0H3mjw0Qe6E7h
   XK90qx4C9DUmrG4O61IhGuNePMP2cmNzqRlysXgBXDec0UOYf0i/iYsm7
   IR598pxeUw5mGJ5+8Gq6pPKIGLkxovlsLjR05jlBlIRfn0aGNHHeEKSDU
   V4OQDAq2MsRT3WMcWvlaPQHaLlucXJJJveAaDikY+DauzsGpxtkL8Lu5q
   WyXvh7F36TykdQxbUDytuwRtL+/vuLRYflWyPeaLCEWUd2mOS05/juCqZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="342699140"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="342699140"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 00:03:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="930614033"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="930614033"
Received: from pglmail07.png.intel.com ([10.221.193.207])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2023 00:03:57 -0700
Received: from localhost (ppgyli0109.png.intel.com [10.126.160.114])
        by pglmail07.png.intel.com (Postfix) with ESMTP id 806754837;
        Thu, 30 Mar 2023 15:03:56 +0800 (+08)
Received: by localhost (Postfix, from userid 11742525)
        id 7F5E53040; Thu, 30 Mar 2023 15:03:56 +0800 (+08)
From:   Boon Khai Ng <boon.khai.ng@intel.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Tien Sung Ang <tien.sung.ang@intel.com>,
        Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [PATCH v1 6/8] net: stmmac: Add support for VLAN promiscuous mode
Date:   Thu, 30 Mar 2023 15:03:54 +0800
Message-Id: <20230330070354.27490-1-boon.khai.ng@intel.com>
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

For dwxgmac2, enable VLAN promiscuity when MAC Controller is requested to
enter promiscuous mode.

Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  1 +
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 67 +++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 4c92828f21d6..3f11b2c52324 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -69,6 +69,7 @@
 #define XGMAC_VLAN_CT			BIT(1)
 #define XGMAC_VLAN_OB			BIT(0)
 #define XGMAC_VLAN_HASH_TABLE		0x00000058
+#define XGMAC_VLAN_VLHT			GENMASK(15, 0)
 #define XGMAC_VLAN_INCL			0x00000060
 #define XGMAC_VLAN_VLTI			BIT(20)
 #define XGMAC_VLAN_CSVL			BIT(19)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index feb9189ec20e..78bad5242562 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -472,6 +472,12 @@ static int dwxgmac2_add_hw_vlan_rx_fltr(struct net_device *dev,
 	if (vid > 4095)
 		return -EINVAL;
 
+	if (hw->promisc) {
+		netdev_err(dev,
+			   "Adding VLAN in promisc mode not supported\n");
+		return -EPERM;
+	}
+
 	/* Single Rx VLAN Filter */
 	if (hw->num_vlan == 1) {
 		/* For single VLAN filter, VID 0 means VLAN promiscuous */
@@ -522,6 +528,12 @@ static int dwxgmac2_del_hw_vlan_rx_fltr(struct net_device *dev,
 {
 	int i, ret = 0;
 
+	if (hw->promisc) {
+		netdev_err(dev,
+			   "Deleting VLAN in promisc mode not supported\n");
+		return -EPERM;
+	}
+
 	/* Single Rx VLAN Filter */
 	if (hw->num_vlan == 1) {
 		if ((hw->vlan_filter[0] & XGMAC_VLAN_VID) == vid) {
@@ -545,9 +557,45 @@ static int dwxgmac2_del_hw_vlan_rx_fltr(struct net_device *dev,
 	return ret;
 }
 
+static void dwxgmac2_vlan_promisc_enable(struct net_device *dev,
+					 struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value;
+	u32 hash;
+	u32 val;
+	int i;
+
+	/* Single Rx VLAN Filter */
+	if (hw->num_vlan == 1) {
+		dwxgmac2_write_single_vlan(dev, 0);
+		return;
+	}
+
+	/* Extended Rx VLAN Filter Enable */
+	for (i = 0; i < hw->num_vlan; i++) {
+		if (hw->vlan_filter[i] & XGMAC_VLAN_TAG_DATA_VEN) {
+			val = hw->vlan_filter[i] & ~XGMAC_VLAN_TAG_DATA_VEN;
+			dwxgmac2_write_vlan_filter(dev, hw, i, val);
+		}
+	}
+
+	hash = readl(ioaddr + XGMAC_VLAN_HASH_TABLE);
+	if (hash & XGMAC_VLAN_VLHT) {
+		value = readl(ioaddr + XGMAC_VLAN_TAG);
+		if (value & XGMAC_VLAN_VTHM) {
+			value &= ~XGMAC_VLAN_VTHM;
+			writel(value, ioaddr + XGMAC_VLAN_TAG);
+		}
+	}
+}
+
 static void dwxgmac2_restore_hw_vlan_rx_fltr(struct net_device *dev,
 					     struct mac_device_info *hw)
 {
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value;
+	u32 hash;
 	u32 val;
 	int i;
 
@@ -564,6 +612,13 @@ static void dwxgmac2_restore_hw_vlan_rx_fltr(struct net_device *dev,
 			dwxgmac2_write_vlan_filter(dev, hw, i, val);
 		}
 	}
+
+	hash = readl(ioaddr + XGMAC_VLAN_HASH_TABLE);
+	if (hash & XGMAC_VLAN_VLHT) {
+		value = readl(ioaddr + XGMAC_VLAN_TAG);
+		value |= XGMAC_VLAN_VTHM;
+		writel(value, ioaddr + XGMAC_VLAN_TAG);
+	}
 }
 
 static void dwxgmac2_set_mchash(void __iomem *ioaddr, u32 *mcfilterbits,
@@ -649,6 +704,18 @@ static void dwxgmac2_set_filter(struct mac_device_info *hw,
 		value |= XGMAC_FILTER_VTFE;
 
 	writel(value, ioaddr + XGMAC_PACKET_FILTER);
+
+	if (dev->flags & IFF_PROMISC) {
+		if (!hw->promisc) {
+			hw->promisc = 1;
+			dwxgmac2_vlan_promisc_enable(dev, hw);
+		}
+	} else {
+		if (hw->promisc) {
+			hw->promisc = 0;
+			dwxgmac2_restore_hw_vlan_rx_fltr(dev, hw);
+		}
+	}
 }
 
 static void dwxgmac2_set_mac_loopback(void __iomem *ioaddr, bool enable)
-- 
2.25.1

