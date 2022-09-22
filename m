Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A545E644A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiIVNyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiIVNx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:53:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99766CE1B;
        Thu, 22 Sep 2022 06:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663854838; x=1695390838;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TGRlhzszJtskHi6su65+eCvkVyzU5lO4sziinuRy1JI=;
  b=V7dCkUaStBQKhycSOnd2teEgDfW498ymR6hXLVEhgUPWj3XbRPsIbC0q
   4f+Lg5o1XX7KHhbYmPLRT1/G5aRdIOD3+3ydFsCgN6GGRJmQrHHJCcv9k
   f0p8huwOmab8eJpiM+D+9LS5ijgPrgSL9VJRN7OXigXWcU4c2QqpptEag
   y0sQ20ubGlLc+l9oLbpo4X+8alMJMSignCaAw5Bim8Xyw3WlXItEiJ3fv
   kMCQMNIZ62URCQXJuPKrQflU2iK5z1MesPN4Z54ZUJgdwwwwRFZ10aB5M
   uOPUM9rpXRRAj4mh3bzxGVSjdl3GCfL6Z03/pa+ZBvm9Ph70pSVa7Gnak
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301710563"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="301710563"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 06:53:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="723669359"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Sep 2022 06:53:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5C2D3238; Thu, 22 Sep 2022 16:54:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] device property: Add const qualifier to device_get_match_data() parameter
Date:   Thu, 22 Sep 2022 16:54:10 +0300
Message-Id: <20220922135410.49694-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Add const qualifier to the device_get_match_data() parameter.
Some of the future users may utilize this function without
forcing the type.

All the same, dev_fwnode() may be used with a const qualifier.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 4 ++--
 include/linux/property.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index ed6f449f8e5c..4d6278a84868 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -17,7 +17,7 @@
 #include <linux/property.h>
 #include <linux/phy.h>
 
-struct fwnode_handle *dev_fwnode(struct device *dev)
+struct fwnode_handle *dev_fwnode(const struct device *dev)
 {
 	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
 		of_fwnode_handle(dev->of_node) : dev->fwnode;
@@ -1200,7 +1200,7 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
 
-const void *device_get_match_data(struct device *dev)
+const void *device_get_match_data(const struct device *dev)
 {
 	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index a5b429d623f6..117cc200c656 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -32,7 +32,7 @@ enum dev_dma_attr {
 	DEV_DMA_COHERENT,
 };
 
-struct fwnode_handle *dev_fwnode(struct device *dev);
+struct fwnode_handle *dev_fwnode(const struct device *dev);
 
 bool device_property_present(struct device *dev, const char *propname);
 int device_property_read_u8_array(struct device *dev, const char *propname,
@@ -387,7 +387,7 @@ bool device_dma_supported(struct device *dev);
 
 enum dev_dma_attr device_get_dma_attr(struct device *dev);
 
-const void *device_get_match_data(struct device *dev);
+const void *device_get_match_data(const struct device *dev);
 
 int device_get_phy_mode(struct device *dev);
 int fwnode_get_phy_mode(struct fwnode_handle *fwnode);
-- 
2.35.1

