Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AF66CFC2B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjC3HEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjC3HEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:04:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BE55FEC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680159837; x=1711695837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vTwh61qjsVEdLTsPz/f55VFpFiD95Ge+Rto9FZrYjVU=;
  b=niG1JNwsXJV6lCfn+6Z8fz9oBOwGTm4VJTBuknn66KvypTwIk2Pz8X9m
   tgf2mIHxqsBbK5FJsCd3br77Pn7a7b4L7q4Tx8dAEGdQfbLf+5BTGIDbx
   zNdkryyYHpT44x/pkAGXck0UcJtLYhMmJvkcPLpg9bcSQHhtnvUaZj+xu
   pDKO8fgn9rxo4/eWltyeEjxGNi54N88+tibKiNmYv1wI/MNJ66SDaBtRI
   pYrGXI/edxOHa3gobkiRJC21KGdlVqaAtaWExt8LqDKz8bVAkBVnOtNsY
   9/VoAnqgYXwfCtKYW0su6TJdZPSzTFw4vXXlg9FEAdG/hlL95Oobn/JzS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="342699066"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="342699066"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 00:03:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="930614012"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="930614012"
Received: from pglmail07.png.intel.com ([10.221.193.207])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2023 00:03:40 -0700
Received: from localhost (ppgyli0109.png.intel.com [10.126.160.114])
        by pglmail07.png.intel.com (Postfix) with ESMTP id 836932B76;
        Thu, 30 Mar 2023 15:03:38 +0800 (+08)
Received: by localhost (Postfix, from userid 11742525)
        id 820AA3040; Thu, 30 Mar 2023 15:03:38 +0800 (+08)
From:   Boon Khai Ng <boon.khai.ng@intel.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Tien Sung Ang <tien.sung.ang@intel.com>,
        Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [PATCH v1 4/8] drivers: net: dwmac: Add use_hw_vlan setting
Date:   Thu, 30 Mar 2023 15:03:36 +0800
Message-Id: <20230330070336.10781-1-boon.khai.ng@intel.com>
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

This is to handle the use_hw_vlan setting at dwmac-socfpga
level.

Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 067a40fe0a23..26da3a9da345 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -537,6 +537,12 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		plat->has_xgmac = 1;
 		plat->pmt = 1;
 		plat->tso_en = of_property_read_bool(np, "snps,tso");
+
+		/* Rx VLAN HW Stripping */
+		if (of_property_read_bool(np, "snps,rx-vlan-offload")) {
+			dev_info(&pdev->dev, "RX VLAN HW Stripping\n");
+			plat->use_hw_vlan = true;
+		}
 	}
 
 	dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*dma_cfg),
-- 
2.25.1

