Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D998603740
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJSAvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiJSAv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:51:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012A0C4C2E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666140683; x=1697676683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pB2ZZZeQe2vKmC5MueLvWUhrKOCkzfzRW7G6Fd2Jikw=;
  b=hhtnhbL97wOkEncURgkk7o+cpK1sfBMp3HSp5mukqMheMBxXXMJIpAoJ
   BZWSg695e/ozOABmCoB2MBMZ3/ldM2GfSFJ0WAYHgxfZTd4Tf+yokpQpl
   sI68W3xiaQuKJx4C8f+c6zDBE0aF5x3et5JVF2O9xbUr0ZdWNjzbgfhuQ
   I3HniEK4R3CaQSS2pI0RcAVFZRfnZcmYQgPM3CefhvuW2ALijouwZfzOz
   Brm+NLNQuyVT2Grqx3VzyJG80efoOEX3J/CYM33OwuiZ0vg+lZfdamUT1
   jGqKHISm45i4oreIBbGlp0hzF93nYZBuWAHmROIb6z+y3gGrKHilUeeJj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="289591527"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="289591527"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 17:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="606824824"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="606824824"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 18 Oct 2022 17:51:21 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Charlotte Tan <charlotte@extrahop.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iommu/vt-d: Clean up si_domain in the init_dmars() error path
Date:   Wed, 19 Oct 2022 08:44:47 +0800
Message-Id: <20221019004447.4563-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019004447.4563-1-baolu.lu@linux.intel.com>
References: <20221019004447.4563-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerry Snitselaar <jsnitsel@redhat.com>

A splat from kmem_cache_destroy() was seen with a kernel prior to
commit ee2653bbe89d ("iommu/vt-d: Remove domain and devinfo mempool")
when there was a failure in init_dmars(), because the iommu_domain
cache still had objects. While the mempool code is now gone, there
still is a leak of the si_domain memory if init_dmars() fails. So
clean up si_domain in the init_dmars() error path.

Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Fixes: 86080ccc223a ("iommu/vt-d: Allocate si_domain in init_dmars()")
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Link: https://lore.kernel.org/r/20221010144842.308890-1-jsnitsel@redhat.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b3cf0f991e29..48cdcd0a5cf3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2410,6 +2410,7 @@ static int __init si_domain_init(int hw)
 
 	if (md_domain_init(si_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
 		domain_exit(si_domain);
+		si_domain = NULL;
 		return -EFAULT;
 	}
 
@@ -3052,6 +3053,10 @@ static int __init init_dmars(void)
 		disable_dmar_iommu(iommu);
 		free_dmar_iommu(iommu);
 	}
+	if (si_domain) {
+		domain_exit(si_domain);
+		si_domain = NULL;
+	}
 
 	return ret;
 }
-- 
2.34.1

