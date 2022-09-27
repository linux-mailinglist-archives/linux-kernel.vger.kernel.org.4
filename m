Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A4D5EC60E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiI0O2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiI0O2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:28:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDEA1857BF;
        Tue, 27 Sep 2022 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664288893; x=1695824893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cGiBw8L0ywgUyx1iTQQodYnhEJ/yQh4jXSXjDl9NZPU=;
  b=KnnM+75F+3zK44k+OT8tZVlBxacbRF9my+XVgO/I7BNcYLgsdsRU7KUI
   dusHHpWIS0FDnBjf4vGBatCZ/VYI3gN7gchpsAQgezWwV6jU4+RRFscBr
   NR1bekf4jYeYo+dluvUK2fv918gak7Abqdldpafr1PVbp9vOvEALhpBmR
   75ddTT032xP0HgTxjSFZwhcI03BBwZnMZvbPjCNDSCDrcVB6+Kyc//h0B
   G7aMRZgV+kWT/5dxDuDiJpFDqVE1Ky4bCagRBgMfaMvoMYkAF1rvVOI6/
   Etmbv+gs1A52dimUFwsZesGTrdDaGYBi0ciA7st44MAoNZZsDEYETuOiC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="302808028"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="302808028"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 07:28:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="684008507"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="684008507"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 27 Sep 2022 07:28:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DFA38F7; Tue, 27 Sep 2022 17:28:26 +0300 (EEST)
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
Subject: [PATCH v1 1/5] device property: Keep dev_fwnode() and dev_fwnode_const() separate
Date:   Tue, 27 Sep 2022 17:28:17 +0300
Message-Id: <20220927142822.4095-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

It's not fully correct to take a const parameter pointer to a struct
and return a non-const pointer to a member of that struct.

Instead, introduce a const version of the dev_fwnode() API which takes
and returns const pointers and use it where it's applicable.

Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Fixes: aade55c86033 ("device property: Add const qualifier to device_get_match_data() parameter")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 11 +++++++++--
 include/linux/property.h |  3 ++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 4d6278a84868..699f1b115e0a 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -17,13 +17,20 @@
 #include <linux/property.h>
 #include <linux/phy.h>
 
-struct fwnode_handle *dev_fwnode(const struct device *dev)
+struct fwnode_handle *dev_fwnode(struct device *dev)
 {
 	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
 		of_fwnode_handle(dev->of_node) : dev->fwnode;
 }
 EXPORT_SYMBOL_GPL(dev_fwnode);
 
+const struct fwnode_handle *dev_fwnode_const(const struct device *dev)
+{
+	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
+		of_fwnode_handle(dev->of_node) : dev->fwnode;
+}
+EXPORT_SYMBOL_GPL(dev_fwnode_const);
+
 /**
  * device_property_present - check if a property of a device is present
  * @dev: Device whose property is being checked
@@ -1202,7 +1209,7 @@ EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
 
 const void *device_get_match_data(const struct device *dev)
 {
-	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
+	return fwnode_call_ptr_op(dev_fwnode_const(dev), device_get_match_data, dev);
 }
 EXPORT_SYMBOL_GPL(device_get_match_data);
 
diff --git a/include/linux/property.h b/include/linux/property.h
index 117cc200c656..ae5d7f8eccf4 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -32,7 +32,8 @@ enum dev_dma_attr {
 	DEV_DMA_COHERENT,
 };
 
-struct fwnode_handle *dev_fwnode(const struct device *dev);
+struct fwnode_handle *dev_fwnode(struct device *dev);
+const struct fwnode_handle *dev_fwnode_const(const struct device *dev);
 
 bool device_property_present(struct device *dev, const char *propname);
 int device_property_read_u8_array(struct device *dev, const char *propname,
-- 
2.35.1

