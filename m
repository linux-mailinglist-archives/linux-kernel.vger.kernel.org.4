Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABA470D3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjEWGUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbjEWGUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:20:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A721BD;
        Mon, 22 May 2023 23:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684822812; x=1716358812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kv+U3eR2t5jXrzu7bhE+tT5rUsZNuQI3uVH6Dk7rusQ=;
  b=cqq//bPah+oPEEmq1hxULMMLI4G6PPUbCiHkVNhPS5mYyZL4iXjtQ7ZK
   5OGeEJi85vAegfpZItWyyqOxexWJZDV584CYn12RM1Dj1i3C8CRNMZHqW
   RhOKe7oNzhpOaA3TwHV3EBM44rfnCapY2dfSWU/SQp4osOSwyJfSQM5U+
   CfFYiUgwcGidEC0KrFLviFyBVBqKZ7FMBxKfE7wzibnRnlWrbZ3KVm3ee
   ESxc0eJFbWTfwD+sm/viGdkWHj0PnGw6zESeImh8mZj8dGPEdlvwim+GT
   pvlmzVxgXozOwwEEIfXbVxsvJLafeFah0Xt7rSaIjQUWKpNzIDcuT89Lg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="351994164"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="351994164"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 23:20:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="734636085"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="734636085"
Received: from ganyifangubuntu20-ilbpg12.png.intel.com ([10.88.229.31])
  by orsmga008.jf.intel.com with ESMTP; 22 May 2023 23:20:07 -0700
From:   Gan Yi Fang <yi.fang.gan@intel.com>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Looi Hong Aun <hong.aun.looi@intel.com>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Gan Yi Fang <yi.fang.gan@intel.com>
Subject: [PATCH net-next 1/1] net: stmmac: Remove redundant checking for rx_coalesce_usecs
Date:   Tue, 23 May 2023 02:19:52 -0400
Message-Id: <20230523061952.204537-1-yi.fang.gan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datatype of rx_coalesce_usecs is u32, always larger or equal to zero.
Previous checking does not include value 0, this patch removes the
checking to handle the value 0.

Signed-off-by: Gan Yi Fang <yi.fang.gan@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 35c8dd92d369..6ed0e683b5e0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -917,7 +917,7 @@ static int __stmmac_set_coalesce(struct net_device *dev,
 	else if (queue >= max_cnt)
 		return -EINVAL;
 
-	if (priv->use_riwt && (ec->rx_coalesce_usecs > 0)) {
+	if (priv->use_riwt) {
 		rx_riwt = stmmac_usec2riwt(ec->rx_coalesce_usecs, priv);
 
 		if ((rx_riwt > MAX_DMA_RIWT) || (rx_riwt < MIN_DMA_RIWT))
-- 
2.34.1

