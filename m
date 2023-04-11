Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1976DD36E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjDKGv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjDKGvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:51:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6D53AA2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195826; x=1712731826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fGa6nb2+nmNFRDt+vgd1O06FQw1KI1Dbhhp5ECOkeNE=;
  b=kIW+aCys4lD6hXZtiL/eY38VZpRNUEXGUnU2IGka7+I/EDddG/NC3A0X
   YtHTHVADt8IckfaouP2LRtuU/Pf1hNaD2ccmxnoeQFh3oJKSY2HB/twSg
   gxafYtrvy58YlJNt6dTGwN7wy9MVTRsYXR7AcNFnLuYkL3+TxxsykPCCk
   FyWLj59aFdt4P+4k684doDKHjsL2BWexkn3UHYryPOvx4xaUX2pfeMhqc
   o8BN9+OODFEDg/UokQtJtjI2m8ESJ6joPWAdEWaFgyxOlyXOE2OKrSwuU
   v65vgfcp11AlHaihglSXcl3NhmUVwkH4I9MO7QoN8sILh3uKxtble8LST
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028642"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028642"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256664"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256664"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:46 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] iommu/vt-d: Remove BUG_ON in dmar_insert_dev_scope()
Date:   Tue, 11 Apr 2023 14:48:15 +0800
Message-Id: <20230411064815.31456-18-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tina Zhang <tina.zhang@intel.com>

The dmar_insert_dev_scope() could fail if any unexpected condition is
encountered. However, in this situation, the kernel should attempt
recovery and proceed with execution. Remove BUG_ON with WARN_ON, so that
kernel can avoid being crashed when an unexpected condition occurs.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406065944.2773296-8-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 9346c6e7ebae..e35be3786bde 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -262,7 +262,8 @@ int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
 						   get_device(dev));
 				return 1;
 			}
-		BUG_ON(i >= devices_cnt);
+		if (WARN_ON(i >= devices_cnt))
+			return -EINVAL;
 	}
 
 	return 0;
-- 
2.34.1

