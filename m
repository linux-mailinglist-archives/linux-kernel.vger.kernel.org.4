Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422D06C4AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCVMeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCVMeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:34:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE8252F5D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679488441; x=1711024441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RR2lUtE6MIt2kHIsf8+e8beC+uOvUnJFzEHkAFWyuG0=;
  b=hZKjfg5FMrQunQWxHooFfL0Xmth9W2jm9vzFkAH2U6ggF8TOSvOuLwKy
   zbL72YkbsMx63e3s4rCa9R1x7WbXwEmQU07kRecIj+3w8W23Q2eyKfCss
   cPpue4zZ6DbtDjCb5of2X/wZItsF4YZvOoTU1ffBQZsnoHs7MmlWPBBwS
   yQb2Yzl+/nu3ky6neRbqsTkkgIe0JxHvl1yTkV4bj24YIYqO6ual8lsAO
   RlFerl7pCyhwdcFQQ0ax3kiwq7fIYfKu04/+c2aYQnGWJ8+3Zc/ErtuRJ
   4EOpl1x/DiB71qzKI2sMHH2zNeShme0VTVnuRvbLgQz26WKSx2K9oIM1+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="366935906"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="366935906"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 05:34:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="771022466"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="771022466"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Mar 2023 05:33:58 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu: Use sysfs_emit() for sysfs show
Date:   Wed, 22 Mar 2023 20:34:21 +0800
Message-Id: <20230322123421.278852-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sysfs_emit() instead of the sprintf() for sysfs entries. sysfs_emit()
knows the maximum of the temporary buffer used for outputting sysfs
content and avoids overrunning the buffer length.

Prefer 'long long' over 'long long int' as suggested by checkpatch.pl.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/amd/init.c    |  4 ++--
 drivers/iommu/intel/iommu.c | 17 +++++++++--------
 drivers/iommu/iommu.c       | 31 +++++++++++++++----------------
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 19a46b9f7357..a98202018140 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1941,7 +1941,7 @@ static ssize_t amd_iommu_show_cap(struct device *dev,
 				  char *buf)
 {
 	struct amd_iommu *iommu = dev_to_amd_iommu(dev);
-	return sprintf(buf, "%x\n", iommu->cap);
+	return sysfs_emit(buf, "%x\n", iommu->cap);
 }
 static DEVICE_ATTR(cap, S_IRUGO, amd_iommu_show_cap, NULL);
 
@@ -1950,7 +1950,7 @@ static ssize_t amd_iommu_show_features(struct device *dev,
 				       char *buf)
 {
 	struct amd_iommu *iommu = dev_to_amd_iommu(dev);
-	return sprintf(buf, "%llx:%llx\n", iommu->features2, iommu->features);
+	return sysfs_emit(buf, "%llx:%llx\n", iommu->features2, iommu->features);
 }
 static DEVICE_ATTR(features, S_IRUGO, amd_iommu_show_features, NULL);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7c2f4bd33582..a366790fb781 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3760,8 +3760,8 @@ static ssize_t version_show(struct device *dev,
 {
 	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	u32 ver = readl(iommu->reg + DMAR_VER_REG);
-	return sprintf(buf, "%d:%d\n",
-		       DMAR_VER_MAJOR(ver), DMAR_VER_MINOR(ver));
+	return sysfs_emit(buf, "%d:%d\n",
+			  DMAR_VER_MAJOR(ver), DMAR_VER_MINOR(ver));
 }
 static DEVICE_ATTR_RO(version);
 
@@ -3769,7 +3769,7 @@ static ssize_t address_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
-	return sprintf(buf, "%llx\n", iommu->reg_phys);
+	return sysfs_emit(buf, "%llx\n", iommu->reg_phys);
 }
 static DEVICE_ATTR_RO(address);
 
@@ -3777,7 +3777,7 @@ static ssize_t cap_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
-	return sprintf(buf, "%llx\n", iommu->cap);
+	return sysfs_emit(buf, "%llx\n", iommu->cap);
 }
 static DEVICE_ATTR_RO(cap);
 
@@ -3785,7 +3785,7 @@ static ssize_t ecap_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
 	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
-	return sprintf(buf, "%llx\n", iommu->ecap);
+	return sysfs_emit(buf, "%llx\n", iommu->ecap);
 }
 static DEVICE_ATTR_RO(ecap);
 
@@ -3793,7 +3793,7 @@ static ssize_t domains_supported_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
 	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
-	return sprintf(buf, "%ld\n", cap_ndoms(iommu->cap));
+	return sysfs_emit(buf, "%ld\n", cap_ndoms(iommu->cap));
 }
 static DEVICE_ATTR_RO(domains_supported);
 
@@ -3801,8 +3801,9 @@ static ssize_t domains_used_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
-	return sprintf(buf, "%d\n", bitmap_weight(iommu->domain_ids,
-						  cap_ndoms(iommu->cap)));
+	return sysfs_emit(buf, "%d\n",
+			  bitmap_weight(iommu->domain_ids,
+					cap_ndoms(iommu->cap)));
 }
 static DEVICE_ATTR_RO(domains_used);
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 10db680acaed..d1ba4397fded 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -550,7 +550,7 @@ static void iommu_group_remove_file(struct iommu_group *group,
 
 static ssize_t iommu_group_show_name(struct iommu_group *group, char *buf)
 {
-	return sprintf(buf, "%s\n", group->name);
+	return sysfs_emit(buf, "%s\n", group->name);
 }
 
 /**
@@ -663,52 +663,51 @@ static ssize_t iommu_group_show_resv_regions(struct iommu_group *group,
 {
 	struct iommu_resv_region *region, *next;
 	struct list_head group_resv_regions;
-	char *str = buf;
+	int offset = 0;
 
 	INIT_LIST_HEAD(&group_resv_regions);
 	iommu_get_group_resv_regions(group, &group_resv_regions);
 
 	list_for_each_entry_safe(region, next, &group_resv_regions, list) {
-		str += sprintf(str, "0x%016llx 0x%016llx %s\n",
-			       (long long int)region->start,
-			       (long long int)(region->start +
-						region->length - 1),
-			       iommu_group_resv_type_string[region->type]);
+		offset += sysfs_emit_at(buf, offset, "0x%016llx 0x%016llx %s\n",
+					(long long)region->start,
+					(long long)(region->start +
+						    region->length - 1),
+					iommu_group_resv_type_string[region->type]);
 		kfree(region);
 	}
 
-	return (str - buf);
+	return offset;
 }
 
 static ssize_t iommu_group_show_type(struct iommu_group *group,
 				     char *buf)
 {
-	char *type = "unknown\n";
+	char *type = "unknown";
 
 	mutex_lock(&group->mutex);
 	if (group->default_domain) {
 		switch (group->default_domain->type) {
 		case IOMMU_DOMAIN_BLOCKED:
-			type = "blocked\n";
+			type = "blocked";
 			break;
 		case IOMMU_DOMAIN_IDENTITY:
-			type = "identity\n";
+			type = "identity";
 			break;
 		case IOMMU_DOMAIN_UNMANAGED:
-			type = "unmanaged\n";
+			type = "unmanaged";
 			break;
 		case IOMMU_DOMAIN_DMA:
-			type = "DMA\n";
+			type = "DMA";
 			break;
 		case IOMMU_DOMAIN_DMA_FQ:
-			type = "DMA-FQ\n";
+			type = "DMA-FQ";
 			break;
 		}
 	}
 	mutex_unlock(&group->mutex);
-	strcpy(buf, type);
 
-	return strlen(type);
+	return sysfs_emit(buf, "%s\n", type);
 }
 
 static IOMMU_GROUP_ATTR(name, S_IRUGO, iommu_group_show_name, NULL);
-- 
2.34.1

