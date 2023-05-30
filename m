Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255527162EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjE3ODG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjE3ODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:03:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338AD107
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685455381; x=1716991381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3hi+6DjKBRb58wjc2nrmmX0ORLHVc/CjtHtIE1vhyfU=;
  b=idJ7Fbhyytj1ANyhp8O6dEXUMO5WydyWeHGmw670f9j28W+35Rd9naqM
   PukfBXqk7c1n2O5Cl+dEwnmKWVlH4Yy1Yc8pJXsiSpy3b+2bUvLN4LDrh
   d1as1HjOYPGCgy1I5J6ryXpEQjzRusiJJSnnmFt8ImBFLV9KfVjyNtatA
   CtiLcoRxbNvG43vQpKTdDcYiR1oI1eqaxOI2nmjs1lW95lmU+uO+885UF
   k59ud6gkeoM5lvFoVL5rheOhbOXCuGTGUIoYUUPT1yrr2NJC4K3hhG1wL
   SrsYqiAPAhkEevecRzS6wX2Pdz04+J4E7v1pkLZZ+S5COGeMYBEKztGzg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="383179448"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="383179448"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 07:03:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="953142980"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="953142980"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.105.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 07:02:58 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     arnd@arndb.de
Cc:     hch@lst.de, andriy.shevchenko@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] misc: enclosure: use DEVICE_ATTR_RW* macros
Date:   Tue, 30 May 2023 16:02:23 +0200
Message-Id: <20230530140223.13994-3-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230530140223.13994-1-mariusz.tkaczyk@linux.intel.com>
References: <20230530140223.13994-1-mariusz.tkaczyk@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR RW and RO macros. Update function names accordingly.
No functional changes intended.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

