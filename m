Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77E16CFC2D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjC3HE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjC3HEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:04:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4CD6EB3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680159849; x=1711695849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ndv8crStbW5ZRgEStB8bHeQMoCmlow7fCoN/DcJCsds=;
  b=Jl1qwhtLT4ziSbTUbvgFEEARUdGyeeedNnZVfe3j2gCxpZB7WyHhzVQw
   V9GFeh6ekjNS3nv8W3IwQg/QBOjqbQCYB5rpxcnV5iVRcBd4YZDEE7Gp7
   5F+y+NCdjvwoADeCtabkAyQArbIGzHTHSfIN9V1w/9u1IhM1nxXqH2lgu
   U+Q1cQmpETeU+cd27nL6LYuiF2IZIKTBAD7oP3B/XTvKKxCcxWzeCKVk8
   9Z94IaJnzknOgpztW/0e4ioKt8mJBcLS8UBW/swWrORcAgpUc6YJ8CzVX
   4rZjORNDTox4eAHzL9l8p7iokI1AEDT7aQAPevufL8G8yETao+KyPHNio
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="329581089"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="329581089"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 00:04:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="795558317"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="795558317"
Received: from pglmail07.png.intel.com ([10.221.193.207])
  by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2023 00:04:07 -0700
Received: from localhost (ppgyli0109.png.intel.com [10.126.160.114])
        by pglmail07.png.intel.com (Postfix) with ESMTP id EE6074837;
        Thu, 30 Mar 2023 15:04:06 +0800 (+08)
Received: by localhost (Postfix, from userid 11742525)
        id BC23B3040; Thu, 30 Mar 2023 15:04:06 +0800 (+08)
From:   Boon Khai Ng <boon.khai.ng@intel.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Tien Sung Ang <tien.sung.ang@intel.com>,
        Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [PATCH v1 7/8] net: stmmac: Add Double VLAN handling for VLAN Rx filtering
Date:   Thu, 30 Mar 2023 15:04:05 +0800
Message-Id: <20230330070405.6901-1-boon.khai.ng@intel.com>
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

Add double VLAN handling for VLAN Rx Filtering.

Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h   |  1 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h |  3 +++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c    | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index ec9c130276d8..ca2d4515dd0f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -535,6 +535,7 @@ struct mac_device_info {
 	unsigned int promisc;
 	bool vlan_fail_q_en;
 	u8 vlan_fail_q;
+	unsigned int double_vlan;
 };
 
 struct stmmac_rx_routing {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 3f11b2c52324..428f82905273 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -499,6 +499,9 @@
 #define XGMAC_VLAN_TAG_STRIP_ALL	(0x3 << XGMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
 
 #define XGMAC_VLAN_TAG_DATA		0x00000054
+#define XGMAC_VLAN_TAG_DATA_ERIVLT	BIT(20)
+#define XGMAC_VLAN_TAG_DATA_ERSVLM	BIT(19)
+#define XGMAC_VLAN_TAG_DATA_DOVLTC	BIT(18)
 #define XGMAC_VLAN_TAG_DATA_ETV		BIT(17)
 #define XGMAC_VLAN_TAG_DATA_VEN		BIT(16)
 #define XGMAC_VLAN_TAG_DATA_VID		GENMASK(15, 0)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 78bad5242562..4dff53dc771f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -438,6 +438,15 @@ static int dwxgmac2_write_vlan_filter(struct net_device *dev,
 	if (index >= hw->num_vlan)
 		return -EINVAL;
 
+	if (hw->double_vlan) {
+		data |= XGMAC_VLAN_TAG_DATA_DOVLTC;
+		data |= XGMAC_VLAN_TAG_DATA_ERIVLT;
+		data &= ~XGMAC_VLAN_TAG_DATA_ERSVLM;
+	} else {
+		data &= ~XGMAC_VLAN_TAG_DATA_DOVLTC;
+		data &= ~XGMAC_VLAN_TAG_DATA_ERIVLT;
+	}
+
 	writel(data, ioaddr + XGMAC_VLAN_TAG_DATA);
 
 	val = readl(ioaddr + XGMAC_VLAN_TAG);
@@ -1855,6 +1864,14 @@ static u32 dwxgmac2_get_num_vlan(void __iomem *ioaddr)
 	return num_vlan;
 }
 
+static u32 dwxgmac2_is_double_vlan(void __iomem *ioaddr)
+{
+	u32 val;
+
+	val = readl(ioaddr + XGMAC_HW_FEATURE3);
+	return (val & XGMAC_HWFEAT_DVLAN);
+}
+
 int dwxgmac2_setup(struct stmmac_priv *priv)
 {
 	struct mac_device_info *mac = priv->hw;
@@ -1889,6 +1906,7 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
 	mac->mii.clk_csr_shift = 19;
 	mac->mii.clk_csr_mask = GENMASK(21, 19);
 	mac->num_vlan = dwxgmac2_get_num_vlan(priv->ioaddr);
+	mac->double_vlan = dwxgmac2_is_double_vlan(priv->ioaddr);
 	return 0;
 }
 
-- 
2.25.1

