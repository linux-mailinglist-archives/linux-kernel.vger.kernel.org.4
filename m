Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE36B627440
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiKNBsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbiKNBsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:48:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA94EDFD5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 17:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668390479; x=1699926479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j140O/WHBMrsJSHsHEaF6cUi5s3fzlbz0+OwH/+tCb0=;
  b=nFxYEGGBHsthMlH49Eg2yJ9H9XBTMAd5rQXZBxJO2ZlQrc6gsz7dVA1H
   sRqv5o8VBNtwNnTw3rbXSUB+buA4Zmj9MaDq/6LjoR3v7AckVFUZ3GI31
   MvKKVzdYZJwTnIEaKuIkExZ08qt1uoNcUWWTdy6A+WNCtvj+LOjY6J+j1
   NMUOCJ/tWDtyqhbPJgryofQB58IcrYkct0G223Cm1XwGbNuBpX4i6navY
   V8ZX1I/GLjROhEFNjSjrnn3C0u21n+UlGv4tUpcJYyguWzQPNlGlXnz7u
   SnDYcnxV81QoX6jlHijDpU5ncwbD2EJhrxtCHrKA6L+ee2WTNG+ZlAbhF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="313006695"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="313006695"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 17:47:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="707124231"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="707124231"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2022 17:47:57 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 5/7] iommu/vt-d: Rename domain_add_dev_info()
Date:   Mon, 14 Nov 2022 09:40:47 +0800
Message-Id: <20221114014049.3959-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114014049.3959-1-baolu.lu@linux.intel.com>
References: <20221114014049.3959-1-baolu.lu@linux.intel.com>
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

dmar_domain_attach_device() is more meaningful according to what this
helper does.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f165e0d37bab..6a2a77fce0f8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2455,7 +2455,8 @@ static int __init si_domain_init(int hw)
 	return 0;
 }
 
-static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
+static int dmar_domain_attach_device(struct dmar_domain *domain,
+				     struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
@@ -4264,7 +4265,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
-	return domain_add_dev_info(to_dmar_domain(domain), dev);
+	return dmar_domain_attach_device(to_dmar_domain(domain), dev);
 }
 
 static int intel_iommu_map(struct iommu_domain *domain,
-- 
2.34.1

