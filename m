Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E0D6E05C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjDMEIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDMEHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:07:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C877D96
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358833; x=1712894833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fGa6nb2+nmNFRDt+vgd1O06FQw1KI1Dbhhp5ECOkeNE=;
  b=m/l4SloRW02cg0IHjvYjHDRsYzbCoY76LH7oiEC9oQmbAqYAszTVGjtq
   xGd4gqsJt/A38Btl0nYTW/tIMCoRj79Bc5MSD2qsvfOiakifuSdvXFZs/
   oJTcWVSWbuHx+6/5If/EuZ0Ika/AWqHFkaWPG5ECbdzJ/zGpdiWAflSS9
   vlUQPZ/8n6R8SeLhvAZneaXI29MUH4QknJA+g0X/QzUrz8E3PyszW/ESO
   Bx+ODtUgnAqeYJpREgtyqP5GM2BXcKksx9mV7olgxeqdmnwFGW5Re0hfY
   seLRFwrSdQK4fwMvUGKIjAiCxh2qjp1fVNIcFzn/t2+6ITHu8UrSohbSN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332786676"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332786676"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:07:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935361128"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935361128"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:07:11 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/17] iommu/vt-d: Remove BUG_ON in dmar_insert_dev_scope()
Date:   Thu, 13 Apr 2023 12:06:45 +0800
Message-Id: <20230413040645.46157-18-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413040645.46157-1-baolu.lu@linux.intel.com>
References: <20230413040645.46157-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

