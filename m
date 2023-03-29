Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021F56CDB1C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjC2NrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjC2NrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:47:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B885BB0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680097632; x=1711633632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3gnKgqRTKyghIyM4UgGaD9bRnVtsRIMSCRTLjmJOQmI=;
  b=E6gsPkDApyZV7LgiUj0bdaEU0UNmbNNEHG1TZ+lpi/Qy81cYRunRMFfY
   EIjeGhDuGKgre2JXosVmf8q3bi4Q02j7pSeBS5/7HkiE97ctwICiHOJMt
   CnCnShIXAy0HGqQ3fVMrN0a/Qnlma3o2SdCL4UDQ6b/EiCZjGPp+70L2i
   AF5EFSObpIWPH7iZLNMQWEIzDbU+Dq/CEk1OsHkCnrlERjWMpbWUDvPuf
   Z9EneGoiYefnrBBFsRe3fweh7f9bC2fZGCgZkfA0AOeE3NO1qJ0IiJ0no
   92ahZWm/vuoaYPfWve3lDoHkaOr1IkWDwrSvJ8lNrRm4767xNKeWOXUMB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="403506240"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="403506240"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:47:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="677783384"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="677783384"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2023 06:47:07 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iommu/vt-d: Allow zero SAGAW if second-stage not supported
Date:   Wed, 29 Mar 2023 21:47:20 +0800
Message-Id: <20230329134721.469447-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329134721.469447-1-baolu.lu@linux.intel.com>
References: <20230329134721.469447-1-baolu.lu@linux.intel.com>
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

The VT-d spec states (in section 11.4.2) that hardware implementations
reporting second-stage translation support (SSTS) field as Clear also
report the SAGAW field as 0. Fix an inappropriate check in alloc_iommu().

Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by default")
Suggested-by: Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230318024824.124542-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/dmar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 6acfe879589c..23828d189c2a 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1071,7 +1071,8 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	}
 
 	err = -EINVAL;
-	if (cap_sagaw(iommu->cap) == 0) {
+	if (!cap_sagaw(iommu->cap) &&
+	    (!ecap_smts(iommu->ecap) || ecap_slts(iommu->ecap))) {
 		pr_info("%s: No supported address widths. Not attempting DMA translation.\n",
 			iommu->name);
 		drhd->ignored = 1;
-- 
2.34.1

