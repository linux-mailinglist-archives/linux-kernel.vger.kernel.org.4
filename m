Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81266CFC26
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjC3HDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjC3HDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:03:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F4D2139
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680159789; x=1711695789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tj2Ro4tnyQIITSi0I4npXtq+zou6vejuqOZsKucl3Ns=;
  b=UVTRoFwxZ/VnEOXevOAbSHCkiy5gg64/S5cLimbF5cPS3zoDTcQu5adu
   6G2Xxn81sXhb1fun4vBDFWWfJYTAFqSG62jOXD7bIr0p/jUMULKGqVz2t
   RJ/6BBU4MFaguDeCbB69sCfDwyef7hh1qDfa47mznf/agr2oQHI+zM/L9
   Sth4A/KCL/Bhr36yd41C/I62S70ONeae1OIZluaAFsEQnCf9o+Dt9GzyF
   UioL/bIk0xezD0P4eu+MMtC5PC/xK80QaIDqdPDM2QNOuHrSKrMwLT4Az
   p6c2lP9Nxn3YKdl7vNHsrt4nnO8gnCgb/fxEDEPARLd6mYhlE+JaSYC4R
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="339810343"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="339810343"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 00:03:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="773882569"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="773882569"
Received: from pglmail07.png.intel.com ([10.221.193.207])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2023 00:03:08 -0700
Received: from localhost (ppgyli0109.png.intel.com [10.126.160.114])
        by pglmail07.png.intel.com (Postfix) with ESMTP id 78F0D4837;
        Thu, 30 Mar 2023 15:03:07 +0800 (+08)
Received: by localhost (Postfix, from userid 11742525)
        id 77CAD3040; Thu, 30 Mar 2023 15:03:07 +0800 (+08)
From:   Boon Khai Ng <boon.khai.ng@intel.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Tien Sung Ang <tien.sung.ang@intel.com>,
        Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [PATCH v1 2/8] drivers: net: stmmac_main: fix vlan toggle option.
Date:   Thu, 30 Mar 2023 15:03:05 +0800
Message-Id: <20230330070305.18808-1-boon.khai.ng@intel.com>
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

This patch is to fix toggling rx vlan offload from the ethool.

Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8ee595d46481..664c32d61622 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4565,10 +4565,8 @@ static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
 	veth = (struct vlan_ethhdr *)skb->data;
 	vlan_proto = veth->h_vlan_proto;
 
-	if ((vlan_proto == htons(ETH_P_8021Q) &&
-	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
-	    (vlan_proto == htons(ETH_P_8021AD) &&
-	     dev->features & NETIF_F_HW_VLAN_STAG_RX)) {
+	if (vlan_proto == htons(ETH_P_8021Q) ||
+	    vlan_proto == htons(ETH_P_8021AD)) {
 		/* pop the vlan tag */
 		vlanid = ntohs(veth->h_vlan_TCI);
 		memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
@@ -5685,6 +5683,8 @@ static int stmmac_set_features(struct net_device *netdev,
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_RX)
 		stmmac_set_hw_vlan_mode(priv, priv->ioaddr, features);
+		priv->plat->use_hw_vlan = features & NETIF_F_HW_VLAN_CTAG_RX;
+	}
 
 	return 0;
 }
-- 
2.25.1

