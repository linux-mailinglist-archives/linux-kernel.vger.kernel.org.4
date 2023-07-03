Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7C27462DB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGCSww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjGCSwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:52:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57407E7B;
        Mon,  3 Jul 2023 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688410353; x=1719946353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lYPz1zqR2x3WBQCDulQo4Jbi7YfCgb1sAO+AUE8NaYA=;
  b=C48jagK3r8s+dfHvMr47nC+VdKWjvtdvWECCkl7yh4E/XJYG+31WGmq2
   OWCpgcNwoK119LRc8oYQ40IRKCd9PK0VeszTN6f5Fs9YeUk/ALwirSI2Q
   o4I6ZQHDPi1Y4dqoN6pZhJkaLlWn7Nh3JrBMwGQRMvnNIyP2izpelCc8v
   R51KKRGqVhrnRek4vn6L9g52Wr2kv4ckZ4fP4OYkc0+uVIHwtR68yPAum
   MOoeNllmcqiPKBSbrF8Csnv+5+lTDsnQdjtplxaGsUlgebXosJrLK1cW2
   c6IgrgZrbHw5larhIR8WOGjFdI7nyIDJDY8uq1zdzRaGe+gk1ZNsYNKPr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="449322743"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="449322743"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="831912489"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="831912489"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2023 11:52:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A2FA869A; Mon,  3 Jul 2023 21:52:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 11/12] HID: cp2112: Convert to DEVICE_ATTR_RW()
Date:   Mon,  3 Jul 2023 21:52:21 +0300
Message-Id: <20230703185222.50554-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of custom wrapper, use DEVICE_tATTR_RW() directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-cp2112.c | 42 ++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 1e45f5407d09..3c6a3be8fc02 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -944,18 +944,10 @@ CP2112_CONFIG_ATTR(release_version, ({
 
 #undef CP2112_CONFIG_ATTR
 
-struct cp2112_pstring_attribute {
-	struct device_attribute attr;
-	unsigned char report;
-};
-
-static ssize_t pstr_store(struct device *kdev,
-			  struct device_attribute *kattr, const char *buf,
-			  size_t count)
+static ssize_t pstr_store(struct device *kdev, struct device_attribute *kattr,
+			  const char *buf, size_t count, int number)
 {
 	struct hid_device *hdev = to_hid_device(kdev);
-	struct cp2112_pstring_attribute *attr =
-		container_of(kattr, struct cp2112_pstring_attribute, attr);
 	struct cp2112_string_report report;
 	int ret;
 
@@ -963,7 +955,7 @@ static ssize_t pstr_store(struct device *kdev,
 
 	ret = utf8s_to_utf16s(buf, count, UTF16_LITTLE_ENDIAN,
 			      report.string, ARRAY_SIZE(report.string));
-	report.report = attr->report;
+	report.report = number;
 	report.length = ret * sizeof(report.string[0]) + 2;
 	report.type = USB_DT_STRING;
 
@@ -981,17 +973,15 @@ static ssize_t pstr_store(struct device *kdev,
 	return count;
 }
 
-static ssize_t pstr_show(struct device *kdev,
-			 struct device_attribute *kattr, char *buf)
+static ssize_t pstr_show(struct device *kdev, struct device_attribute *kattr,
+			 char *buf, int number)
 {
 	struct hid_device *hdev = to_hid_device(kdev);
-	struct cp2112_pstring_attribute *attr =
-		container_of(kattr, struct cp2112_pstring_attribute, attr);
 	struct cp2112_string_report report;
 	u8 length;
 	int ret;
 
-	ret = cp2112_hid_get(hdev, attr->report, (u8 *)&report.contents,
+	ret = cp2112_hid_get(hdev, number, (u8 *)&report.contents,
 			     sizeof(report.contents), HID_FEATURE_REPORT);
 	if (ret < 3) {
 		hid_err(hdev, "error reading %s string: %d\n", kattr->attr.name,
@@ -1016,10 +1006,16 @@ static ssize_t pstr_show(struct device *kdev,
 }
 
 #define CP2112_PSTR_ATTR(name, _report) \
-static struct cp2112_pstring_attribute dev_attr_##name = { \
-	.attr = __ATTR(name, (S_IWUSR | S_IRUGO), pstr_show, pstr_store), \
-	.report = _report, \
-};
+static ssize_t name##_store(struct device *kdev, struct device_attribute *kattr, \
+			    const char *buf, size_t count) \
+{ \
+	return pstr_store(kdev, kattr, buf, count, _report); \
+} \
+static ssize_t name##_show(struct device *kdev, struct device_attribute *kattr, char *buf) \
+{ \
+	return pstr_show(kdev, kattr, buf, _report); \
+} \
+static DEVICE_ATTR_RW(name);
 
 CP2112_PSTR_ATTR(manufacturer,	CP2112_MANUFACTURER_STRING);
 CP2112_PSTR_ATTR(product,	CP2112_PRODUCT_STRING);
@@ -1034,9 +1030,9 @@ static const struct attribute_group cp2112_attr_group = {
 		&dev_attr_max_power.attr,
 		&dev_attr_power_mode.attr,
 		&dev_attr_release_version.attr,
-		&dev_attr_manufacturer.attr.attr,
-		&dev_attr_product.attr.attr,
-		&dev_attr_serial.attr.attr,
+		&dev_attr_manufacturer.attr,
+		&dev_attr_product.attr,
+		&dev_attr_serial.attr,
 		NULL
 	}
 };
-- 
2.40.0.1.gaa8946217a0b

