Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA596C438C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCVGuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCVGtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:49:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E9156516
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679467787; x=1711003787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xP7VJduO7JMRCBdiR2gq1cP4nZMZAj/onHcGkgWCalY=;
  b=ayBn1ds8RFyAxQp+wWXjXPkcmCzhkNqA8UNBFBTb4MRkegi8wIXvSFUt
   83hL8CV+d7Yd4JSPmF6p0r+Ldof+DrcbUhfAoKNOmKiAntVLiDxLJY4Wa
   8ewzdzM3FzZsZzHTt0sgsWyfGqIN170kOuelPZs9+8IOTpP752VuUPPY6
   aWtepSWmSzfxjdAd+nDRXB+g4SR3V0hCsarI6E9t4wC5o9FE0qqhc1QRT
   NIwgCHdWG/FUJ1J0xkV0tlD8PGKuycMy1AqmViGNfIHYP47bAVbAguxpY
   zSCyk/rBKFi3SAp9FayG4VAsbQibVc3HfWrhDvBaJPp8OrHYHH1yCiHmu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="337866763"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="337866763"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 23:49:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="659080433"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="659080433"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2023 23:49:44 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 4/6] iommu: Move lock from iommu_change_dev_def_domain() to its caller
Date:   Wed, 22 Mar 2023 14:49:54 +0800
Message-Id: <20230322064956.263419-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322064956.263419-1-baolu.lu@linux.intel.com>
References: <20230322064956.263419-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intention is to make it possible to put group ownership check and
default domain change in a same critical region protected by the group's
mutex lock. No intentional functional change.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6d27fd585e75..54a5bd79d21b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2889,7 +2889,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	int ret, dev_def_dom;
 	struct device *dev;
 
-	mutex_lock(&group->mutex);
+	lockdep_assert_held(&group->mutex);
 
 	if (group->default_domain != group->domain) {
 		dev_err_ratelimited(prev_dev, "Group not assigned to default domain\n");
@@ -2978,28 +2978,15 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 		goto free_new_domain;
 
 	group->domain = group->default_domain;
-
-	/*
-	 * Release the mutex here because ops->probe_finalize() call-back of
-	 * some vendor IOMMU drivers calls arm_iommu_attach_device() which
-	 * in-turn might call back into IOMMU core code, where it tries to take
-	 * group->mutex, resulting in a deadlock.
-	 */
-	mutex_unlock(&group->mutex);
-
-	/* Make sure dma_ops is appropriatley set */
-	iommu_group_do_probe_finalize(dev, group->default_domain);
 	iommu_domain_free(prev_dom);
+
 	return 0;
 
 free_new_domain:
 	iommu_domain_free(group->default_domain);
 	group->default_domain = prev_dom;
 	group->domain = prev_dom;
-
 out:
-	mutex_unlock(&group->mutex);
-
 	return ret;
 }
 
@@ -3089,7 +3076,19 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 		goto out;
 	}
 
+	mutex_lock(&group->mutex);
 	ret = iommu_change_dev_def_domain(group, dev, req_type);
+	/*
+	 * Release the mutex here because ops->probe_finalize() call-back of
+	 * some vendor IOMMU drivers calls arm_iommu_attach_device() which
+	 * in-turn might call back into IOMMU core code, where it tries to take
+	 * group->mutex, resulting in a deadlock.
+	 */
+	mutex_unlock(&group->mutex);
+
+	/* Make sure dma_ops is appropriatley set */
+	if (!ret)
+		iommu_group_do_probe_finalize(dev, group->default_domain);
 	ret = ret ?: count;
 
 out:
-- 
2.34.1

