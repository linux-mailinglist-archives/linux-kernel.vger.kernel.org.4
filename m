Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B406D81D2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbjDEP2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbjDEP2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:28:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A64E62
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680708500; x=1712244500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1G96BxpRnc7nFZ7uPknxCBPGY6qbj+oRYDf0BwBN1Ek=;
  b=bZbix5R0d6bLfZE149yERlr+2vVlgZpjfevJw2yqrvoZcu9/DGWlCso+
   W4/cV3RTd8e+44fFtDHSOOLGHrEMQdzBpkF+4cz+Dho+kJ6sfaA6jSqLr
   ZUBKGdY6PYF4WCHNlZSpLU3j5kUyYJE1AOySnAdSJ0+yXxNGUFyj6UEDf
   wLqThboEaHg4rzEOMZV9PXMSFEfOujpxZ/cmsEcL99kQ4WS7HCmwMBbD6
   PQB+sYKahOhe7SH+hphCrGtiS2PKcxXY7oQwVkARP4DK25aiYeKs35lOg
   WfeN2DGgZFGT65XzgG8HuYgvruSUMMwnRlSgQZRxoP4D8RLcRC7kvHXtT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="345064764"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="345064764"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 08:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="756028428"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="756028428"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 05 Apr 2023 08:27:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A7D651D7; Wed,  5 Apr 2023 18:27:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v2 2/5] extcon: Get rid of not really used name field in struct extcon_dev
Date:   Wed,  5 Apr 2023 18:27:42 +0300
Message-Id: <20230405152745.24959-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
References: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
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

The name field is always set to the parent device name and never
altered. No need to keep it inside the struct extcon_dev as we
always may derive it from the dev_name(edev->dev.parent) call.

Moreover, the parent device pointer won't ever be NULL, otherwise
we may not allocate the extcon device at all.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon.c | 12 +++---------
 drivers/extcon/extcon.h |  3 ---
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 47819c5144d5..75a0147703c0 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -387,7 +387,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 {
 	struct extcon_dev *edev = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%s\n", edev->name);
+	return sysfs_emit(buf, "%s\n", dev_name(edev->dev.parent));
 }
 static DEVICE_ATTR_RO(name);
 
@@ -885,7 +885,7 @@ struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 
 	mutex_lock(&extcon_dev_list_lock);
 	list_for_each_entry(sd, &extcon_dev_list, entry) {
-		if (!strcmp(sd->name, extcon_name))
+		if (device_match_name(sd->dev.parent, extcon_name))
 			goto out;
 	}
 	sd = ERR_PTR(-EPROBE_DEFER);
@@ -1269,12 +1269,6 @@ int extcon_dev_register(struct extcon_dev *edev)
 	edev->dev.class = extcon_class;
 	edev->dev.release = extcon_dev_release;
 
-	edev->name = dev_name(edev->dev.parent);
-	if (IS_ERR_OR_NULL(edev->name)) {
-		dev_err(&edev->dev,
-			"extcon device name is null\n");
-		return -EINVAL;
-	}
 	dev_set_name(&edev->dev, "extcon%lu",
 			(unsigned long)atomic_inc_return(&edev_no));
 
@@ -1465,7 +1459,7 @@ EXPORT_SYMBOL_GPL(extcon_get_edev_by_phandle);
  */
 const char *extcon_get_edev_name(struct extcon_dev *edev)
 {
-	return !edev ? NULL : edev->name;
+	return edev ? dev_name(edev->dev.parent) : NULL;
 }
 EXPORT_SYMBOL_GPL(extcon_get_edev_name);
 
diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
index 49e4ed9f6450..9ce7042606d7 100644
--- a/drivers/extcon/extcon.h
+++ b/drivers/extcon/extcon.h
@@ -6,8 +6,6 @@
 
 /**
  * struct extcon_dev - An extcon device represents one external connector.
- * @name:		The name of this extcon device. Parent device name is
- *			used if NULL.
  * @supported_cable:	Array of supported cable names ending with EXTCON_NONE.
  *			If supported_cable is NULL, cable name related APIs
  *			are disabled.
@@ -40,7 +38,6 @@
  */
 struct extcon_dev {
 	/* Optional user initializing data */
-	const char *name;
 	const unsigned int *supported_cable;
 	const u32 *mutually_exclusive;
 
-- 
2.40.0.1.gaa8946217a0b

