Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13815F3F75
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJDJXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJDJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:22:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9D5192B0;
        Tue,  4 Oct 2022 02:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664875280; x=1696411280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lu5K2V7nFBFYObZ1dwJ6OVK1LUkbq3YmYSLm5miq5Ug=;
  b=I2rlIn0hAEGBwlw1DhKf+eoMfKG7jHCTCC5vil7z3bYRc2s2/LW3GwQ0
   wlr8K3C1KtkE+RpzU23EWJ7eSAkSDtjLYnYXhq68MmvzrIgQxL+/CxkY/
   yoB95ZtIv0JKKsilylnxj4J+gSqqPnHiai4SzdJzbNscxIu308MBgXLAJ
   TeNIJ7UKrfYEkfc0uxla+3gyrZENDprWNpiNdZpFOzLeljh3eUNx0R1Ex
   1T39EIJ5r0SCuom+O82XvGrqMIQdz+Aowqb6/1h7GFCfuO0fk7Wn8syja
   5hXAtODsiBvFTERiucXX9dW5KQQPRl43oTS8nmP6hj3hdr5Bqhgno6RsQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="303824988"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="303824988"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 02:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="623865973"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="623865973"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 04 Oct 2022 02:21:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8338F45; Tue,  4 Oct 2022 12:21:31 +0300 (EEST)
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
Subject: [PATCH v3 1/5] device property: Allow const parameter to dev_fwnode()
Date:   Tue,  4 Oct 2022 12:21:25 +0300
Message-Id: <20221004092129.19412-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221004092129.19412-1-andriy.shevchenko@linux.intel.com>
References: <20221004092129.19412-1-andriy.shevchenko@linux.intel.com>
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

It's not fully correct to take a const parameter pointer to a struct
and return a non-const pointer to a member of that struct.

Instead, introduce a const version of the dev_fwnode() API which takes
and returns const pointers and use it where it's applicable.

With this, convert dev_fwnode() to be a macro wrapper on top of const
and non-const APIs that chooses one based on the type.

Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Fixes: aade55c86033 ("device property: Add const qualifier to device_get_match_data() parameter")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c  | 11 +++++++++--
 include/linux/property.h |  7 ++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 4d6278a84868..d77302d28566 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -17,12 +17,19 @@
 #include <linux/property.h>
 #include <linux/phy.h>
 
-struct fwnode_handle *dev_fwnode(const struct device *dev)
+struct fwnode_handle *__dev_fwnode(struct device *dev)
 {
 	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
 		of_fwnode_handle(dev->of_node) : dev->fwnode;
 }
-EXPORT_SYMBOL_GPL(dev_fwnode);
+EXPORT_SYMBOL_GPL(__dev_fwnode);
+
+const struct fwnode_handle *__dev_fwnode_const(const struct device *dev)
+{
+	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
+		of_fwnode_handle(dev->of_node) : dev->fwnode;
+}
+EXPORT_SYMBOL_GPL(__dev_fwnode_const);
 
 /**
  * device_property_present - check if a property of a device is present
diff --git a/include/linux/property.h b/include/linux/property.h
index 117cc200c656..587b5b666b5b 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -32,7 +32,12 @@ enum dev_dma_attr {
 	DEV_DMA_COHERENT,
 };
 
-struct fwnode_handle *dev_fwnode(const struct device *dev);
+const struct fwnode_handle *__dev_fwnode_const(const struct device *dev);
+struct fwnode_handle *__dev_fwnode(struct device *dev);
+#define dev_fwnode(dev)							\
+	_Generic((dev),							\
+		 const struct device *: __dev_fwnode_const,	\
+		 struct device *: __dev_fwnode)(dev)
 
 bool device_property_present(struct device *dev, const char *propname);
 int device_property_read_u8_array(struct device *dev, const char *propname,
-- 
2.35.1

