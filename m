Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38B5675CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjATS14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjATS1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:27:54 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914AC7EF1;
        Fri, 20 Jan 2023 10:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674239273; x=1705775273;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nsTsJXssT9U+3aFmRBu7JqZ2vs6RASx+rJvilax8o5Q=;
  b=NqXoO1ZLz6src91ljPZvBGpJN5DYWuRH3tvbpQYkaebAEBIZSC51mYt/
   c9l2YXorbD7R9BQaPs1WeFgKjMx8gX3PDPbaxnXMm2rxV+PnY9HwTHVgW
   QJLcJPf86jUNapIVkd7ApxmUKsb2RiV5/G87shmUk8N697ALauS84coFM
   y8AvwDTaPMds/vZcStv31hgSyQ4GFObppeVqGFYD2ATCJdrl52R5LOYoZ
   2ZGrTCz8NQB/PbutTO48AhtZreD6lwmHYu3+y9oWjGmJJMiw072Ufab1C
   XxvB4LE1uv88+chH2MPJfLhc5Vz7IeSTYgNUdDDzeyhVocq+GXT9sG3TG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="313538683"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="313538683"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 10:24:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="729195614"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="729195614"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jan 2023 10:24:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D2EE6368; Fri, 20 Jan 2023 20:24:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?J=C3=B3=20=C3=81gila=20Bitsch?= <jgilab@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] usb: gadget: Move kstrtox() out of lock
Date:   Fri, 20 Jan 2023 20:24:34 +0200
Message-Id: <20230120182434.24245-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

The kstrtox() calls operate on local (to the function) variables and do
not need to be serialized. We may call them out of the lock.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/configfs.c | 72 +++++++++++++++++------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 78e7353e397b..63dc15b4f6d8 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -808,15 +808,15 @@ static ssize_t webusb_use_store(struct config_item *item, const char *page,
 	int ret;
 	bool use;
 
-	mutex_lock(&gi->lock);
 	ret = kstrtobool(page, &use);
-	if (!ret) {
-		gi->use_webusb = use;
-		ret = len;
-	}
+	if (ret)
+		return ret;
+
+	mutex_lock(&gi->lock);
+	gi->use_webusb = use;
 	mutex_unlock(&gi->lock);
 
-	return ret;
+	return len;
 }
 
 static ssize_t webusb_bcdVersion_show(struct config_item *item, char *page)
@@ -832,10 +832,12 @@ static ssize_t webusb_bcdVersion_store(struct config_item *item,
 	u16 bcdVersion;
 	int ret;
 
-	mutex_lock(&gi->lock);
 	ret = kstrtou16(page, 0, &bcdVersion);
 	if (ret)
-		goto out;
+		return ret;
+
+	mutex_lock(&gi->lock);
+
 	ret = is_valid_bcd(bcdVersion);
 	if (ret)
 		goto out;
@@ -862,15 +864,15 @@ static ssize_t webusb_bVendorCode_store(struct config_item *item,
 	int ret;
 	u8 b_vendor_code;
 
-	mutex_lock(&gi->lock);
 	ret = kstrtou8(page, 0, &b_vendor_code);
-	if (!ret) {
-		gi->b_webusb_vendor_code = b_vendor_code;
-		ret = len;
-	}
+	if (ret)
+		return ret;
+
+	mutex_lock(&gi->lock);
+	gi->b_webusb_vendor_code = b_vendor_code;
 	mutex_unlock(&gi->lock);
 
-	return ret;
+	return len;
 }
 
 static ssize_t webusb_landingPage_show(struct config_item *item, char *page)
@@ -956,15 +958,15 @@ static ssize_t os_desc_use_store(struct config_item *item, const char *page,
 	int ret;
 	bool use;
 
-	mutex_lock(&gi->lock);
 	ret = kstrtobool(page, &use);
-	if (!ret) {
-		gi->use_os_desc = use;
-		ret = len;
-	}
+	if (ret)
+		return ret;
+
+	mutex_lock(&gi->lock);
+	gi->use_os_desc = use;
 	mutex_unlock(&gi->lock);
 
-	return ret;
+	return len;
 }
 
 static ssize_t os_desc_b_vendor_code_show(struct config_item *item, char *page)
@@ -980,15 +982,15 @@ static ssize_t os_desc_b_vendor_code_store(struct config_item *item,
 	int ret;
 	u8 b_vendor_code;
 
-	mutex_lock(&gi->lock);
 	ret = kstrtou8(page, 0, &b_vendor_code);
-	if (!ret) {
-		gi->b_vendor_code = b_vendor_code;
-		ret = len;
-	}
+	if (ret)
+		return ret;
+
+	mutex_lock(&gi->lock);
+	gi->b_vendor_code = b_vendor_code;
 	mutex_unlock(&gi->lock);
 
-	return ret;
+	return len;
 }
 
 static ssize_t os_desc_qw_sign_show(struct config_item *item, char *page)
@@ -1113,15 +1115,15 @@ static ssize_t ext_prop_type_store(struct config_item *item,
 	u8 type;
 	int ret;
 
-	if (desc->opts_mutex)
-		mutex_lock(desc->opts_mutex);
 	ret = kstrtou8(page, 0, &type);
 	if (ret)
-		goto end;
-	if (type < USB_EXT_PROP_UNICODE || type > USB_EXT_PROP_UNICODE_MULTI) {
-		ret = -EINVAL;
-		goto end;
-	}
+		return ret;
+
+	if (type < USB_EXT_PROP_UNICODE || type > USB_EXT_PROP_UNICODE_MULTI)
+		return -EINVAL;
+
+	if (desc->opts_mutex)
+		mutex_lock(desc->opts_mutex);
 
 	if ((ext_prop->type == USB_EXT_PROP_BINARY ||
 	    ext_prop->type == USB_EXT_PROP_LE32 ||
@@ -1138,12 +1140,10 @@ static ssize_t ext_prop_type_store(struct config_item *item,
 		   type == USB_EXT_PROP_BE32))
 		ext_prop->data_len >>= 1;
 	ext_prop->type = type;
-	ret = len;
 
-end:
 	if (desc->opts_mutex)
 		mutex_unlock(desc->opts_mutex);
-	return ret;
+	return len;
 }
 
 static ssize_t ext_prop_data_show(struct config_item *item, char *page)
-- 
2.39.0

