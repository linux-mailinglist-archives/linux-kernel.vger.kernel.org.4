Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADBC69A8AA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjBQJ4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjBQJ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:56:13 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371425F82B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676627773; x=1708163773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=soshgH1no5hycuBrP/dpzD8rbmx7eoXwNiXBGFJYNPk=;
  b=GsHYdIRbjYiVUumDzC3kI9t05iLXB+kWd30OPADqvqsc8LtppruAKYMW
   EvRVICFvW9mBmks6tKTCOSM25oqoVQHqor4JJL084gH4POm0wBRT4zknD
   FFuT0lJGttVKu4Md3WDbvs8OppX/77gz5PU5ANBh558yAfcuzXnyzA6ip
   mWqMatvOdxBKKyLWVMyZf/b2Nzg3JHlSexNSCWH/v1ClaqKKhT+bmRt9V
   Q35OI30KLBhNSecpZFmTGa9q4v6BYx2u1/WC94djAtLnBwXeeDDXSCHJ/
   5oeWHMI+Lo9MI3sjVt65xw+tmngOGND6CjUa267hOiuexPqe7z1jthGAi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331955179"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="331955179"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 01:56:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="999391208"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="999391208"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 17 Feb 2023 01:56:08 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/6] ARM/dma-mapping: Remove iommu_detach_device()
Date:   Fri, 17 Feb 2023 17:47:31 +0800
Message-Id: <20230217094736.159005-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230217094736.159005-1-baolu.lu@linux.intel.com>
References: <20230217094736.159005-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu_detach_device() attaches the default domain to the device, or if
default domain is not supported by the IOMMU driver, it calls its
set_platform_dma_ops callback. If the default domain is supported or
the IOMMU driver is not iommu-dma aware, iommu_detach_device() is
actually a noop.

The 64-bit ARM drivers always support default domain and iommu-dma is
even not enabled for 32-bit ARM. This turns out that iommu_detach_device()
is always a noop in arm_iommu_detach_device(). Remove it to avoid dead
code.

The bonus is that it also removes a obstacle of arm_iommu_detach_device()
re-entering the iommu core during release_device. With this removed, the
iommu core code could be simplified a lot.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/arm/mm/dma-mapping.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8bc01071474a..dcbc2f4586d4 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1699,7 +1699,6 @@ void arm_iommu_detach_device(struct device *dev)
 		return;
 	}
 
-	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
 	to_dma_iommu_mapping(dev) = NULL;
 	set_dma_ops(dev, NULL);
-- 
2.34.1

