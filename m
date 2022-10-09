Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C860F5F8C47
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 18:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiJIQWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 12:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJIQWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 12:22:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4561275E8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 09:22:41 -0700 (PDT)
X-QQ-mid: bizesmtp63t1665332550tg3l1ber
Received: from localhost.localdomain ( [58.247.70.42])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Oct 2022 00:22:29 +0800 (CST)
X-QQ-SSF: 01100000002000G0Z000B00A0000000
X-QQ-FEAT: D6RqbDSxuq5upTGykcxJAyaU0dOQRvgi1FDhmiv9RN+CCAo9tdPA2XbwycMqh
        7vJ/26RKv+2ZX6fmHP9bPJpbDa4P8nuqdhXofUHZBx8Xxc2R+ql9kDEEdM/MUsJPnNNz3S+
        ev8ruIsNSlwzwZtuR8QfNMA2bMqKea5yLw6+0aCJSf8PEVJNwyaFi5JEEsYVD8uzUqq8UnT
        GImgSaEtOF8oh552BYSMJ7z8FNFjy5bD7MCzkvsyqq0OmdKGyVbIQoEctsbKtgm+7ySsUak
        zrU+IybcMOEirI0TOhOsn1cfDRWiTx480PXRzD3XtaHhkX5XIj2w8dGWby8Mmg59yLQV6Ur
        sHX0No2j0dQJbVR+ih/0jw+luXXruH8szzw9XbyQ/Y7xYvjzs8=
X-QQ-GoodBg: 0
From:   Soha Jin <soha@lohu.info>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, Soha Jin <soha@lohu.info>
Subject: [PATCH 2/3] device property: add {device,fwnode}_property_match_string_nocase()
Date:   Mon, 10 Oct 2022 00:21:54 +0800
Message-Id: <20221009162155.1318-3-soha@lohu.info>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221009162155.1318-1-soha@lohu.info>
References: <20221009162155.1318-1-soha@lohu.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lohu.info:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_property_match_string_nocase and fwnode_property_match_string_nocase
are used to do case-insensitive match with match_string_nocase.

Signed-off-by: Soha Jin <soha@lohu.info>
---
 drivers/base/property.c  | 92 ++++++++++++++++++++++++++++++++--------
 include/linux/property.h |  6 +++
 2 files changed, 80 insertions(+), 18 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 4d6278a84868..5e579b915e77 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -242,6 +242,30 @@ int device_property_match_string(struct device *dev, const char *propname,
 }
 EXPORT_SYMBOL_GPL(device_property_match_string);
 
+/**
+ * device_property_match_string_nocase - find a string in an array and return
+ * index with case-insensitive comparison
+ * @dev: Device to get the property of
+ * @propname: Name of the property holding the array
+ * @string: String to look for
+ *
+ * Find a given string in a string array and if it is found return the
+ * index back.
+ *
+ * Return: %0 if the property was found (success),
+ *	   %-EINVAL if given arguments are not valid,
+ *	   %-ENODATA if the property does not have a value,
+ *	   %-EPROTO if the property is not an array of strings,
+ *	   %-ENXIO if no suitable firmware interface is present.
+ */
+int device_property_match_string_nocase(struct device *dev,
+	const char *propname, const char *string)
+{
+	return fwnode_property_match_string_nocase(dev_fwnode(dev), propname,
+						   string);
+}
+EXPORT_SYMBOL_GPL(device_property_match_string_nocase);
+
 static int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
 					  const char *propname,
 					  unsigned int elem_size, void *val,
@@ -441,23 +465,9 @@ int fwnode_property_read_string(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string);
 
-/**
- * fwnode_property_match_string - find a string in an array and return index
- * @fwnode: Firmware node to get the property of
- * @propname: Name of the property holding the array
- * @string: String to look for
- *
- * Find a given string in a string array and if it is found return the
- * index back.
- *
- * Return: %0 if the property was found (success),
- *	   %-EINVAL if given arguments are not valid,
- *	   %-ENODATA if the property does not have a value,
- *	   %-EPROTO if the property is not an array of strings,
- *	   %-ENXIO if no suitable firmware interface is present.
- */
-int fwnode_property_match_string(const struct fwnode_handle *fwnode,
-	const char *propname, const char *string)
+int fwnode_property_do_match_string(const struct fwnode_handle *fwnode,
+	const char *propname, const char *string,
+	int (*cmp)(const char *, const char *))
 {
 	const char **values;
 	int nval, ret;
@@ -477,15 +487,61 @@ int fwnode_property_match_string(const struct fwnode_handle *fwnode,
 	if (ret < 0)
 		goto out;
 
-	ret = match_string(values, nval, string);
+	ret = __match_string(values, nval, string, cmp);
 	if (ret < 0)
 		ret = -ENODATA;
 out:
 	kfree(values);
 	return ret;
 }
+
+/**
+ * fwnode_property_match_string - find a string in an array and return index
+ * @fwnode: Firmware node to get the property of
+ * @propname: Name of the property holding the array
+ * @string: String to look for
+ *
+ * Find a given string in a string array and if it is found return the
+ * index back.
+ *
+ * Return: %0 if the property was found (success),
+ *	   %-EINVAL if given arguments are not valid,
+ *	   %-ENODATA if the property does not have a value,
+ *	   %-EPROTO if the property is not an array of strings,
+ *	   %-ENXIO if no suitable firmware interface is present.
+ */
+int fwnode_property_match_string(const struct fwnode_handle *fwnode,
+	const char *propname, const char *string)
+{
+	return fwnode_property_do_match_string(fwnode, propname, string,
+					       strcmp);
+}
 EXPORT_SYMBOL_GPL(fwnode_property_match_string);
 
+/**
+ * fwnode_property_match_string_nocase - find a string in an array and return
+ * index with case-insensitive comparison
+ * @fwnode: Firmware node to get the property of
+ * @propname: Name of the property holding the array
+ * @string: String to look for
+ *
+ * Find a given string in a string array and if it is found return the
+ * index back.
+ *
+ * Return: %0 if the property was found (success),
+ *	   %-EINVAL if given arguments are not valid,
+ *	   %-ENODATA if the property does not have a value,
+ *	   %-EPROTO if the property is not an array of strings,
+ *	   %-ENXIO if no suitable firmware interface is present.
+ */
+int fwnode_property_match_string_nocase(const struct fwnode_handle *fwnode,
+	const char *propname, const char *string)
+{
+	return fwnode_property_do_match_string(fwnode, propname, string,
+					       strcasecmp);
+}
+EXPORT_SYMBOL_GPL(fwnode_property_match_string_nocase);
+
 /**
  * fwnode_property_get_reference_args() - Find a reference with arguments
  * @fwnode:	Firmware node where to look for the reference
diff --git a/include/linux/property.h b/include/linux/property.h
index 117cc200c656..dbe747f3e3be 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -49,6 +49,9 @@ int device_property_read_string(struct device *dev, const char *propname,
 				const char **val);
 int device_property_match_string(struct device *dev,
 				 const char *propname, const char *string);
+int device_property_match_string_nocase(struct device *dev,
+					const char *propname,
+					const char *string);
 
 bool fwnode_device_is_available(const struct fwnode_handle *fwnode);
 bool fwnode_property_present(const struct fwnode_handle *fwnode,
@@ -72,6 +75,9 @@ int fwnode_property_read_string(const struct fwnode_handle *fwnode,
 				const char *propname, const char **val);
 int fwnode_property_match_string(const struct fwnode_handle *fwnode,
 				 const char *propname, const char *string);
+int fwnode_property_match_string_nocase(const struct fwnode_handle *fwnode,
+					const char *propname,
+					const char *string);
 int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       const char *prop, const char *nargs_prop,
 				       unsigned int nargs, unsigned int index,
-- 
2.30.2

