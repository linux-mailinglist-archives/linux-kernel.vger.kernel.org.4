Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CE869A8AD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjBQJ4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjBQJ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:56:28 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360A963BC5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676627781; x=1708163781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I7zwcHhE0QciS3+BHxkcRCwFeb6U9lVqL1VaFiFdxu8=;
  b=lODVbbV86Eq4xmxpCfRYhX8gfMppxZYG+8M2uXP4sOyaaOZvn8rFXELX
   kNwKFfSwVYQGldFw3sBQbUMjAv+Xv6lCSSKoElinWHIN774f0ed7IlVKL
   Z+w1bqAhGlPcsV/00GRftlii3BYgbp6cveWFcMm5bbHuOVFyNf2IQdjBg
   U0pux6QPhg44ybPNdB0TCHikeNCuR0Sntxl5RckCehwosVhpyqY83r3DE
   MeyQYhw9bRZoX0sKJgOakvz8q0fdYzyWHZExREHRyELIHGSZykV4jNcR2
   k98F+6SpY5j64gjOlRLH1qZbPR9bfkR8V0RFg6xmx+johxEO7Md5xJriS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331955258"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="331955258"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 01:56:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="999391230"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="999391230"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 17 Feb 2023 01:56:15 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 4/6] iommu: Move lock from iommu_change_dev_def_domain() to its caller
Date:   Fri, 17 Feb 2023 17:47:34 +0800
Message-Id: <20230217094736.159005-5-baolu.lu@linux.intel.com>
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

The intention is to make it possible to put group ownership check and
default domain change in a same critical region protected by the group's
mutex lock. No intentional functional change.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 093692308b80..e1ae1eb4faf0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2892,7 +2892,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	int ret, dev_def_dom;
 	struct device *dev;
 
-	mutex_lock(&group->mutex);
+	lockdep_assert_held(&group->mutex);
 
 	if (group->default_domain != group->domain) {
 		dev_err_ratelimited(prev_dev, "Group not assigned to default domain\n");
@@ -2980,28 +2980,15 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
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

