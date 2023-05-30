Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C511715A23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjE3J27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjE3J23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:28:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E23E47
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685438870; x=1716974870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bb/2NSh0FsupKWJ63NAi7JNkLNuSTtTj++ZJQlgFfKg=;
  b=U+sUkeVR+24sL4egl41ZbcONBQu0u+siT6qx1MBBfsU0C3Y07AvKvxoE
   mCNiQHz7FKxteHHonUFn5+M+th+UpBVGtMXY0grE/24lg2KN0ld/vnTFY
   QUGGcuVCYOPOm0SdvW+RgOqm6Qvrj2fwHq8MHbflCEZSCWCAILkgtJKbS
   OHR27AtdmkZUR4AWD+5Dh202q2caD8IZSzaOodPHkTKMCZa5kL/E2yipZ
   ug/4+jowYivPnLrjhxSb9yxKJ0GzBEfmbwySpvSQEWhlFLomM2ujuwczG
   n3tCHgdSmAGQ7XVl93+/jGuzAfJk5mmxZHGy/Zv/sUrfvr388j7zAE5LA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="344365177"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="344365177"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 02:27:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="818720180"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="818720180"
Received: from tower.bj.intel.com ([10.238.157.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 02:27:47 -0700
From:   Yanfei Xu <yanfei.xu@intel.com>
To:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        yanfei.xu@intel.com
Subject: [PATCH 2/2] iommu/vt-d: Use BUG_ON to check NULL value of 'table'
Date:   Tue, 30 May 2023 17:25:03 +0800
Message-Id: <20230530092503.152926-3-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530092503.152926-1-yanfei.xu@intel.com>
References: <20230530092503.152926-1-yanfei.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking NULL value of 'table' variable deserves a BUG_ON as the
following code will trigger a crash by dereferencing the NULL
'table' pointer. Crash in advance with BUG_ON to avoid WARN_ON
plus NULL pointer dereferencing can simplify the crash log.

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e98f1b122b49..8aa3bfdb7f95 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1944,7 +1944,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	if (sm_supported(iommu)) {
 		unsigned long pds;
 
-		WARN_ON(!table);
+		BUG_ON(!table);
 
 		/* Setup the PASID DIR pointer: */
 		pds = context_get_sm_pds(table);
-- 
2.34.1

