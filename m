Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD7770D29A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjEWD4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjEWD4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:56:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D15120;
        Mon, 22 May 2023 20:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684814183; x=1716350183;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kv+U3eR2t5jXrzu7bhE+tT5rUsZNuQI3uVH6Dk7rusQ=;
  b=GO05ctuDT4THeaWR4P76lv2IV/SZoF76y7xB2Jly9HMlpTXuGZTFlck8
   rtPDaZCCN4Eo7oL9FiYUucqUBMCFm30oMSAd0e/B0L4zvvjLrR2DL1Th8
   T+AJpMbYfEVCrcKz10zEyM6GpeAWXznbAXt/75Ub8pjV1tNrSS7k8IFPb
   rVGU13lFpavVZi3DcXMzLB87ULmsDGnie4TfGL7yVZrwFFKqHwT99N+Ju
   vMwSbG7OOGR9AN0C3U+Na1GyiYs+bRz6SygABKbGSmRYr9p7VlAMegcjD
   gM5po7dlI2WicW2UPJJdQRW+SFvaotJv/VtMo4D2PKJpSmm7l6mqy83vj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="342577144"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="342577144"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 20:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="681240866"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="681240866"
Received: from ganyifangubuntu20-ilbpg12.png.intel.com ([10.88.229.31])
  by orsmga006.jf.intel.com with ESMTP; 22 May 2023 20:56:19 -0700
From:   Gan Yi Fang <yi.fang.gan@intel.com>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Looi Hong Aun <hong.aun.looi@intel.com>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Gan Yi Fang <yi.fang.gan@intel.com>
Subject: [PATCH net 1/1] net: stmmac: Remove redundant checking for rx_coalesce_usecs
Date:   Mon, 22 May 2023 23:55:48 -0400
Message-Id: <20230523035548.188651-1-yi.fang.gan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

