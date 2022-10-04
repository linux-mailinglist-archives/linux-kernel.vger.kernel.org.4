Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1715F3F77
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiJDJXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiJDJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:22:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56B963BF;
        Tue,  4 Oct 2022 02:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664875285; x=1696411285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G+cTEb7aOvdjj7yKk7zhbA1vqLcKqe3UPdbwPDBL00w=;
  b=c4pj46HvPtZ+l10bc8N5tX5HNAkcAiIJPynAaCgN0f7bL2wf8/zRdc20
   SvOED0e1Mk/d4f0x7b2RazGi7s1SC+CWjJn2Reqz73tecLrvWxtUxieXD
   XR/ixQMgM9Hu8rVFULWLd3DaaXtCzztv4E1AXCmJcNbeaHRyh5gdRJZNo
   y+w641OJ8mg974I4kFE5MLeujLWhI+VIpiTa6RdVKgZPz2Zrcb6gcEMUL
   LEf1enD/B88ngrhN35XxnR4d2AwV93/k1J/+Xs2f5cYXonnMo7fVJCS4m
   0kIY38y2sP5oKmgp45qwik4XgT+Qf4qcIAgRStIFYPO59XzVpjn+SBU2v
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="301585211"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="301585211"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 02:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="799050984"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="799050984"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 04 Oct 2022 02:21:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AFB7A265; Tue,  4 Oct 2022 12:21:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 4/5] device property: Constify device child node APIs
Date:   Tue,  4 Oct 2022 12:21:28 +0300
Message-Id: <20221004092129.19412-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221004092129.19412-1-andriy.shevchenko@linux.intel.com>
References: <20221004092129.19412-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c  |  6 +++---
 include/linux/property.h | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 58b8158add5c..d3ea5f82978f 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -763,7 +763,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
  * @dev: Device to find the next child node for.
  * @child: Handle to one of the device's child nodes or a null handle.
  */
-struct fwnode_handle *device_get_next_child_node(struct device *dev,
+struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 						 struct fwnode_handle *child)
 {
 	const struct fwnode_handle *fwnode = dev_fwnode(dev);
@@ -800,7 +800,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_named_child_node);
  * @dev: Device to find the named child node for.
  * @childname: String to match child node name against.
  */
-struct fwnode_handle *device_get_named_child_node(struct device *dev,
+struct fwnode_handle *device_get_named_child_node(const struct device *dev,
 						  const char *childname)
 {
 	return fwnode_get_named_child_node(dev_fwnode(dev), childname);
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
index 7abb1792044f..472689e53ade 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -114,16 +114,16 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
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
@@ -132,7 +132,7 @@ void fwnode_handle_put(struct fwnode_handle *fwnode);
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
 
-unsigned int device_get_child_node_count(struct device *dev);
+unsigned int device_get_child_node_count(const struct device *dev);
 
 static inline bool device_property_read_bool(struct device *dev,
 					     const char *propname)
-- 
2.35.1

