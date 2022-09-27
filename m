Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64E05EC608
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiI0O23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiI0O2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:28:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DA7186990;
        Tue, 27 Sep 2022 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664288892; x=1695824892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cc1aFjYUO4SDChMPwPNv5Bv/vhNv4tExWF8sOyp8IOc=;
  b=AvtXbPzYTPnufJQiza+ZRHIPXhXeWSgPSD+kvl3K+YPqvweu7aF+Wco8
   3KX5tQpUPfbkZhew7Kl9nEAyrnUM1DDiH/llettZtkTYHkGA9OXcyXiBn
   gthYOECzUS0yiIQmeC4/7JYL8oJdvTTwXzYchh+hwj0D/5dhpwRKre9zk
   SxXypEAqgQRY7o7CS9+gcKKgfDJsjoL3jfWFxi3uzFwOs9m7G0SWfMBCc
   xaOIZcZeIYjpkXjpvZ7RI+TgGtAf3D3tdsG4ECcG3RfrpUY4MeMCa8+YD
   2phU6KEOr90Mt6GZMyX+Xcj56td6+9LlW+9bJaMYGfDj3vkNV72TXvQ6j
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="302808026"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="302808026"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 07:28:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="684008506"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="684008506"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 27 Sep 2022 07:28:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 08235265; Tue, 27 Sep 2022 17:28:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 4/5] device property: Constify device child node APIs
Date:   Tue, 27 Sep 2022 17:28:20 +0300
Message-Id: <20220927142822.4095-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927142822.4095-1-andriy.shevchenko@linux.intel.com>
References: <20220927142822.4095-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device parameter is not altered in the device child node APIs,
constify them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 10 +++++-----
 include/linux/property.h | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 1a1616c9b599..04eb5e0ab407 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -763,10 +763,10 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
  * @dev: Device to find the next child node for.
  * @child: Handle to one of the device's child nodes or a null handle.
  */
-struct fwnode_handle *device_get_next_child_node(struct device *dev,
+struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 						 struct fwnode_handle *child)
 {
-	const struct fwnode_handle *fwnode = dev_fwnode(dev);
+	const struct fwnode_handle *fwnode = dev_fwnode_const(dev);
 	struct fwnode_handle *next;
 
 	if (IS_ERR_OR_NULL(fwnode))
@@ -800,10 +800,10 @@ EXPORT_SYMBOL_GPL(fwnode_get_named_child_node);
  * @dev: Device to find the named child node for.
  * @childname: String to match child node name against.
  */
-struct fwnode_handle *device_get_named_child_node(struct device *dev,
+struct fwnode_handle *device_get_named_child_node(const struct device *dev,
 						  const char *childname)
 {
-	return fwnode_get_named_child_node(dev_fwnode(dev), childname);
+	return fwnode_get_named_child_node(dev_fwnode_const(dev), childname);
 }
 EXPORT_SYMBOL_GPL(device_get_named_child_node);
 
@@ -859,7 +859,7 @@ EXPORT_SYMBOL_GPL(fwnode_device_is_available);
  * device_get_child_node_count - return the number of child nodes for device
  * @dev: Device to cound the child nodes for
  */
-unsigned int device_get_child_node_count(struct device *dev)
+unsigned int device_get_child_node_count(const struct device *dev)
 {
 	struct fwnode_handle *child;
 	unsigned int count = 0;
diff --git a/include/linux/property.h b/include/linux/property.h
index fe440211e529..31dd6cbea9b0 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -110,16 +110,16 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
 	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
 	     child = fwnode_get_next_available_child_node(fwnode, child))
 
-struct fwnode_handle *device_get_next_child_node(
-	struct device *dev, struct fwnode_handle *child);
+struct fwnode_handle *device_get_next_child_node(const struct device *dev,
+						 struct fwnode_handle *child);
 
 #define device_for_each_child_node(dev, child)				\
 	for (child = device_get_next_child_node(dev, NULL); child;	\
 	     child = device_get_next_child_node(dev, child))
 
-struct fwnode_handle *fwnode_get_named_child_node(
-	const struct fwnode_handle *fwnode, const char *childname);
-struct fwnode_handle *device_get_named_child_node(struct device *dev,
+struct fwnode_handle *fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
+						  const char *childname);
+struct fwnode_handle *device_get_named_child_node(const struct device *dev,
 						  const char *childname);
 
 struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
@@ -128,7 +128,7 @@ void fwnode_handle_put(struct fwnode_handle *fwnode);
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
 
-unsigned int device_get_child_node_count(struct device *dev);
+unsigned int device_get_child_node_count(const struct device *dev);
 
 static inline bool device_property_read_bool(struct device *dev,
 					     const char *propname)
-- 
2.35.1

