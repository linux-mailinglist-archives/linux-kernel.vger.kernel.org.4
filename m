Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383176CFC27
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjC3HDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjC3HDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:03:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532CF6195
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680159813; x=1711695813;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=soLnH5oYStpH9kmsXzBts0HwbsxJYFH+woSRYd8u9x8=;
  b=TswtLBa/TCc7PcwZXvj3sZfmbJV5Q6SBgv2HqUq1Pg9k4kKQ7hNwyHTe
   5QZFoeDqu33Qg808RymglLvbnNPN+j/K6MQtbUe48ighimqGbmHCSw1lX
   Zlq8Shn98+tl/b8YIZPF79FKQMq59Hu86G6iSCMPDGHPHIfp7M1G/gLVe
   PMNuvzzBJFwub28Sle9QtCi/e+Guyk6BNAhP5GBPPty76OTCy/97uX/JE
   GlUzdUBMvuekwUBBO2zyulMbM/b8gEPgtcTQxXd20jj+ghYSGaUuFhMnR
   B8bsgsR+E+RLeBHYM8xEQrcK3JLVLSFQO6E3Cv6puxibW4eN3OkBmPsFi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="339810382"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="339810382"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 00:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="773882736"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="773882736"
Received: from pglmail07.png.intel.com ([10.221.193.207])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2023 00:03:31 -0700
Received: from localhost (ppgyli0109.png.intel.com [10.126.160.114])
        by pglmail07.png.intel.com (Postfix) with ESMTP id EC0884837;
        Thu, 30 Mar 2023 15:03:30 +0800 (+08)
Received: by localhost (Postfix, from userid 11742525)
        id EB0C03040; Thu, 30 Mar 2023 15:03:30 +0800 (+08)
From:   Boon Khai Ng <boon.khai.ng@intel.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Tien Sung Ang <tien.sung.ang@intel.com>,
        Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [PATCH v1 3/8] drivers: net: stmmac: Add support for HW-accelerated VLAN Stripping
Date:   Thu, 30 Mar 2023 15:03:29 +0800
Message-Id: <20230330070329.4828-1-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=AC_FROM_MANY_DOTS,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to add HW-accelerated VLAN Stripping for XGMAC

Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    | 28 ++++++++++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 38 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  | 15 ++++++++
 3 files changed, 81 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 1913385df685..b7beaa197343 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -431,6 +431,7 @@
 #define XGMAC_TDES2_VTIR		GENMASK(15, 14)
 #define XGMAC_TDES2_VTIR_SHIFT		14
 #define XGMAC_TDES2_B1L			GENMASK(13, 0)
+#define XGMAC_TDES2_VLAN_TAG_MASK	GENMASK(15, 14)
 #define XGMAC_TDES3_OWN			BIT(31)
 #define XGMAC_TDES3_CTXT		BIT(30)
 #define XGMAC_TDES3_FD			BIT(29)
@@ -462,6 +463,8 @@
 #define XGMAC_RDES3_RSV			BIT(26)
 #define XGMAC_RDES3_L34T		GENMASK(23, 20)
 #define XGMAC_RDES3_L34T_SHIFT		20
+#define XGMAC_RDES3_ET_LT		GENMASK(19, 16)
+#define XGMAC_RDES3_ET_LT_SHIFT		16
 #define XGMAC_L34T_IP4TCP		0x1
 #define XGMAC_L34T_IP4UDP		0x2
 #define XGMAC_L34T_IP6TCP		0x9
@@ -471,4 +474,29 @@
 #define XGMAC_RDES3_TSD			BIT(6)
 #define XGMAC_RDES3_TSA			BIT(4)
 
+/* RDES0 (write back format) */
+#define XGMAC_RDES0_VLAN_TAG_MASK	GENMASK(15, 0)
+
+/* MAC VLAN Tag Control */
+#define XGMAC_VLAN_TAG_CTRL_OB		BIT(0)
+#define XGMAC_VLAN_TAG_CTRL_CT		BIT(1)
+#define XGMAC_VLAN_TAG_CTRL_OFS_MASK	GENMASK(6, 2)
+#define XGMAC_VLAN_TAG_CTRL_OFS_SHIFT	2
+#define XGMAC_VLAN_TAG_CTRL_EVLS_MASK	GENMASK(22, 21)
+#define XGMAC_VLAN_TAG_CTRL_EVLS_SHIFT	21
+#define XGMAC_VLAN_TAG_CTRL_EVLRXS	BIT(24)
+
+#define XGMAC_VLAN_TAG_STRIP_NONE	(0x0 << XGMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
+#define XGMAC_VLAN_TAG_STRIP_PASS	(0x1 << XGMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
+#define XGMAC_VLAN_TAG_STRIP_FAIL	(0x2 << XGMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
+#define XGMAC_VLAN_TAG_STRIP_ALL	(0x3 << XGMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
+
+/* Error Type or L2 Type(ET/LT) Field Number */
+#define XGMAC_ET_LT_VLAN_STAG		8
+#define XGMAC_ET_LT_VLAN_CTAG		9
+#define XGMAC_ET_LT_DVLAN_CTAG_CTAG	10
+#define XGMAC_ET_LT_DVLAN_STAG_STAG	11
+#define XGMAC_ET_LT_DVLAN_CTAG_STAG	12
+#define XGMAC_ET_LT_DVLAN_STAG_CTAG	13
+
 #endif /* __STMMAC_DWXGMAC2_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index c6c4d7948fe5..8bd77e30cc24 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -7,6 +7,7 @@
 #include <linux/bitrev.h>
 #include <linux/crc32.h>
 #include <linux/iopoll.h>
+#include <linux/if_vlan.h>
 #include "stmmac.h"
 #include "stmmac_ptp.h"
 #include "dwxlgmac2.h"
@@ -1174,6 +1175,39 @@ static void dwxgmac2_sarc_configure(void __iomem *ioaddr, int val)
 	writel(value, ioaddr + XGMAC_TX_CONFIG);
 }
 
+static void dwxgmac2_rx_hw_vlan(struct net_device *dev,
+				struct mac_device_info *hw,
+				struct dma_desc *rx_desc, struct sk_buff *skb)
+{
+	if ((dev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
+	    hw->desc->get_rx_vlan_valid(rx_desc)) {
+		u16 vid = (u16)hw->desc->get_rx_vlan_tci(rx_desc);
+
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
+	}
+}
+
+static void dwxgmac2_set_hw_vlan_mode(void __iomem *ioaddr,
+				      netdev_features_t features)
+{
+	u32 val;
+
+	val = readl(ioaddr + XGMAC_VLAN_TAG);
+	val &= ~XGMAC_VLAN_TAG_CTRL_EVLS_MASK;
+
+	if (features & NETIF_F_HW_VLAN_CTAG_RX)
+		/* Always strip VLAN on Receive */
+		val |= XGMAC_VLAN_TAG_STRIP_ALL;
+	else
+		/* Do not strip VLAN on Receive */
+		val |= XGMAC_VLAN_TAG_STRIP_NONE;
+
+	/* Enable outer VLAN Tag in Rx DMA descriptro */
+	val |= XGMAC_VLAN_TAG_CTRL_EVLRXS;
+
+	writel(val, ioaddr + XGMAC_VLAN_TAG);
+}
+
 static void dwxgmac2_enable_vlan(struct mac_device_info *hw, u32 type)
 {
 	void __iomem *ioaddr = hw->pcsr;
@@ -1498,6 +1532,8 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.set_arp_offload = dwxgmac2_set_arp_offload,
 	.est_configure = dwxgmac3_est_configure,
 	.fpe_configure = dwxgmac3_fpe_configure,
+	.rx_hw_vlan = dwxgmac2_rx_hw_vlan,
+	.set_hw_vlan_mode = dwxgmac2_set_hw_vlan_mode,
 };
 
 static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
@@ -1559,6 +1595,8 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.set_arp_offload = dwxgmac2_set_arp_offload,
 	.est_configure = dwxgmac3_est_configure,
 	.fpe_configure = dwxgmac3_fpe_configure,
+	.rx_hw_vlan = dwxgmac2_rx_hw_vlan,
+	.set_hw_vlan_mode = dwxgmac2_set_hw_vlan_mode,
 };
 
 int dwxgmac2_setup(struct stmmac_priv *priv)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index b1f0c3984a09..2bdd5ef6d048 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -67,6 +67,19 @@ static int dwxgmac2_get_tx_ls(struct dma_desc *p)
 	return (le32_to_cpu(p->des3) & XGMAC_RDES3_LD) > 0;
 }
 
+static inline int dwxgmac2_wrback_get_rx_vlan_tci(struct dma_desc *p)
+{
+	return (le32_to_cpu(p->des0) & XGMAC_RDES0_VLAN_TAG_MASK);
+}
+
+static inline bool dwxgmac2_wrback_get_rx_vlan_valid(struct dma_desc *p)
+{
+	return((((le32_to_cpu(p->des3) & XGMAC_RDES3_ET_LT) >>
+		XGMAC_RDES3_ET_LT_SHIFT) >= XGMAC_ET_LT_VLAN_STAG) &&
+		(((le32_to_cpu(p->des3) & XGMAC_RDES3_ET_LT) >>
+		XGMAC_RDES3_ET_LT_SHIFT) <= XGMAC_ET_LT_DVLAN_STAG_CTAG));
+}
+
 static int dwxgmac2_get_rx_frame_len(struct dma_desc *p, int rx_coe)
 {
 	return (le32_to_cpu(p->des3) & XGMAC_RDES3_PL);
@@ -349,6 +362,8 @@ const struct stmmac_desc_ops dwxgmac210_desc_ops = {
 	.set_tx_owner = dwxgmac2_set_tx_owner,
 	.set_rx_owner = dwxgmac2_set_rx_owner,
 	.get_tx_ls = dwxgmac2_get_tx_ls,
+	.get_rx_vlan_tci = dwxgmac2_wrback_get_rx_vlan_tci,
+	.get_rx_vlan_valid = dwxgmac2_wrback_get_rx_vlan_valid,
 	.get_rx_frame_len = dwxgmac2_get_rx_frame_len,
 	.enable_tx_timestamp = dwxgmac2_enable_tx_timestamp,
 	.get_tx_timestamp_status = dwxgmac2_get_tx_timestamp_status,
-- 
2.25.1

