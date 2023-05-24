Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA4070F4DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjEXLNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjEXLN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:13:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9133139
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684926806; x=1716462806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3AV3Yx4AGK3x6utTSXAG8DPnytjUXdcCkaS3PI2AvfY=;
  b=UMZNN7jDLxEtJlN5PEXXaHO4+Z7rYbIBgDs+a5dN0RQsIIgBMMksXtl2
   nEbo4YOTSErsdWFrl8AKG+lhavLWbUXgpL8nY3xIfFmW2ABaoDT56c9sm
   Brq4FZJ0HcxTjLS/q4y8yPNQLdWvw8+TQp8zl57vV5IPlhVJoV6cY2OQG
   aMY3Zgx+mwlC/R8HwiNXDRQnkaq0JBoEVRCg13+lzVnVT6TxaUTIF3OFM
   aAe+Bj04gRLHSmpKHwehILblvDUlt84AVyjOUCd9Jd1tGQeflW+ussK3t
   E6/MlVhLxP8F1sCBVhjtk9ViOH8177iQqvopXStuHnnjZyIHC4BlxNaho
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="333156326"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="333156326"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 04:13:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="878621310"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="878621310"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.105.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 04:13:02 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     arnd@arndb.de
Cc:     andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com
Subject: [PATCH v2 2/2] misc: enclosure: update sysfs api
Date:   Wed, 24 May 2023 13:12:31 +0200
Message-Id: <20230524111231.14506-3-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230524111231.14506-1-mariusz.tkaczyk@linux.intel.com>
References: <20230524111231.14506-1-mariusz.tkaczyk@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR RW and RO macros. Update function names accordingly.
No functional changes intended.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 drivers/misc/enclosure.c | 80 +++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 42 deletions(-)

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index 59704fdb962a..95d70840a88a 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -473,8 +473,8 @@ static const char *const enclosure_type[] = {
 	[ENCLOSURE_COMPONENT_ARRAY_DEVICE] = "array device",
 };
 
-static ssize_t get_component_fault(struct device *cdev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t fault_show(struct device *cdev, struct device_attribute *attr,
+			  char *buf)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -484,9 +484,8 @@ static ssize_t get_component_fault(struct device *cdev,
 	return sysfs_emit(buf, "%d\n", ecomp->fault);
 }
 
-static ssize_t set_component_fault(struct device *cdev,
-				   struct device_attribute *attr,
-				   const char *buf, size_t count)
+static ssize_t fault_store(struct device *cdev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -497,8 +496,10 @@ static ssize_t set_component_fault(struct device *cdev,
 	return count;
 }
 
-static ssize_t get_component_status(struct device *cdev,
-				    struct device_attribute *attr,char *buf)
+static DEVICE_ATTR_RW(fault);
+
+static ssize_t status_show(struct device *cdev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -508,9 +509,8 @@ static ssize_t get_component_status(struct device *cdev,
 	return sysfs_emit(buf, "%s\n", enclosure_status[ecomp->status]);
 }
 
-static ssize_t set_component_status(struct device *cdev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
+static ssize_t status_store(struct device *cdev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -531,8 +531,10 @@ static ssize_t set_component_status(struct device *cdev,
 		return -EINVAL;
 }
 
-static ssize_t get_component_active(struct device *cdev,
-				    struct device_attribute *attr, char *buf)
+static DEVICE_ATTR_RW(status);
+
+static ssize_t active_show(struct device *cdev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
 
@@ -540,9 +542,8 @@ static ssize_t get_component_active(struct device *cdev,
 	return sysfs_emit(buf, "%d\n", ecomp->active);
 }
 
-static ssize_t set_component_active(struct device *cdev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
+static ssize_t active_store(struct device *cdev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -553,8 +554,10 @@ static ssize_t set_component_active(struct device *cdev,
 	return count;
 }
 
-static ssize_t get_component_locate(struct device *cdev,
-				    struct device_attribute *attr, char *buf)
+static DEVICE_ATTR_RW(active);
+
+static ssize_t locate_show(struct device *cdev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -564,9 +567,8 @@ static ssize_t get_component_locate(struct device *cdev,
 	return sysfs_emit(buf, "%d\n", ecomp->locate);
 }
 
-static ssize_t set_component_locate(struct device *cdev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
+static ssize_t locate_store(struct device *cdev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -577,9 +579,10 @@ static ssize_t set_component_locate(struct device *cdev,
 	return count;
 }
 
-static ssize_t get_component_power_status(struct device *cdev,
-					  struct device_attribute *attr,
-					  char *buf)
+static DEVICE_ATTR_RW(locate);
+
+static ssize_t power_status_show(struct device *cdev,
+				 struct device_attribute *attr, char *buf)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -594,9 +597,9 @@ static ssize_t get_component_power_status(struct device *cdev,
 	return sysfs_emit(buf, "%s\n", ecomp->power_status ? "on" : "off");
 }
 
-static ssize_t set_component_power_status(struct device *cdev,
-					  struct device_attribute *attr,
-					  const char *buf, size_t count)
+static ssize_t power_status_store(struct device *cdev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
 {
 	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
@@ -616,16 +619,20 @@ static ssize_t set_component_power_status(struct device *cdev,
 	return count;
 }
 
-static ssize_t get_component_type(struct device *cdev,
-				  struct device_attribute *attr, char *buf)
+static DEVICE_ATTR_RW(power_status);
+
+static ssize_t type_show(struct device *cdev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
 
 	return sysfs_emit(buf, "%s\n", enclosure_type[ecomp->type]);
 }
 
-static ssize_t get_component_slot(struct device *cdev,
-				  struct device_attribute *attr, char *buf)
+static DEVICE_ATTR_RO(type);
+
+static ssize_t slot_show(struct device *cdev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
 	int slot;
@@ -639,18 +646,7 @@ static ssize_t get_component_slot(struct device *cdev,
 	return sysfs_emit(buf, "%d\n", slot);
 }
 
-static DEVICE_ATTR(fault, S_IRUGO | S_IWUSR, get_component_fault,
-		    set_component_fault);
-static DEVICE_ATTR(status, S_IRUGO | S_IWUSR, get_component_status,
-		   set_component_status);
-static DEVICE_ATTR(active, S_IRUGO | S_IWUSR, get_component_active,
-		   set_component_active);
-static DEVICE_ATTR(locate, S_IRUGO | S_IWUSR, get_component_locate,
-		   set_component_locate);
-static DEVICE_ATTR(power_status, S_IRUGO | S_IWUSR, get_component_power_status,
-		   set_component_power_status);
-static DEVICE_ATTR(type, S_IRUGO, get_component_type, NULL);
-static DEVICE_ATTR(slot, S_IRUGO, get_component_slot, NULL);
+static DEVICE_ATTR_RO(slot);
 
 static struct attribute *enclosure_component_attrs[] = {
 	&dev_attr_fault.attr,
-- 
2.26.2

