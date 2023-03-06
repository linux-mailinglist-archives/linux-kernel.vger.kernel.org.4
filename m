Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032576AB4D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 03:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCFC7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 21:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCFC71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 21:59:27 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4548A11668
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 18:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678071565; x=1709607565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MdWuluD3W8nfCHmXoPEsni78ipVq2xDF2ne8PYskGyM=;
  b=JFVSLHH5v9MCBzXy40dN2rMYzu/Po924qnmOkJOUJmXpGxL/K/3otyVN
   EIM7f3bMDZzicpjwbAtb1VJaS8NhA+Op6ZAP5lEh5/TVQuCv/HJRFScYv
   IM6NK+SYMk9uujPtksR652+MSMZbI/AnaNHELWqAodHE5eeLhD8bD3gha
   KBqHxtgrtyXhv+OPO6OlA45aqyfE+HBL9M+2Dma9JdzUE845toBd1sp33
   23b0VGQ2U+ku+w7nEfIv3+hxWNLJw778Pm0YPHqRh92MZBw8BCI86Xvfj
   9uXixdOK3ba0pcnUBBgSu2iToKgtVpZzIOYH18w6L0FEpNKX/7hj6pDaB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="363071524"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="363071524"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 18:59:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="765072484"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="765072484"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Mar 2023 18:59:22 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 4/6] iommu: Move lock from iommu_change_dev_def_domain() to its caller
Date:   Mon,  6 Mar 2023 10:58:02 +0800
Message-Id: <20230306025804.13912-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306025804.13912-1-baolu.lu@linux.intel.com>
References: <20230306025804.13912-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 0bcd9625090d..f8f400548a10 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2945,7 +2945,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	int ret, dev_def_dom;
 	struct device *dev;
 
-	mutex_lock(&group->mutex);
+	lockdep_assert_held(&group->mutex);
 
 	if (group->default_domain != group->domain) {
 		dev_err_ratelimited(prev_dev, "Group not assigned to default domain\n");
@@ -3033,28 +3033,15 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
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
 
@@ -3142,7 +3129,19 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
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

