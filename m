Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAB45EC605
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiI0O2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiI0O2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:28:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C121EF0AF;
        Tue, 27 Sep 2022 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664288893; x=1695824893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Ldno0VG4b7OFqx4NzeiuH/7QWhkds3QSmsBZXHBdbQ=;
  b=jq9hNAvqdGATEeVZxFo5W7XGKbbbJN6oUBFWQgCYrv5705qBl/SmSBrG
   El98UFG4lKQE7ckMgKLg3VG0XRT4CuqHfLoOVDCHowAks4118JQV4bG9v
   GJDfQw41tk/S2eyww2Se5r55w6ZbXmXxbJYL37hJv5tktpXs/jS0CEtOt
   j2euaRVYutMsWzX399qxxvbqiop+dfepWZYIkPKhZt92GqXGpQSn1sZaV
   N6pZhvdkq+b3801Z6jgOMwmGMBAoyLbvZ/2QnDikdGZujDugSWvmQI+ZX
   z3KvmtmK5ZceN8Ju3eR8Xys4mB0hHXRI+Nqqe6Ava8XlvO81FVkXcsyMI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="365370926"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="365370926"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 07:28:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="616845984"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="616845984"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 27 Sep 2022 07:28:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 149F9268; Tue, 27 Sep 2022 17:28:27 +0300 (EEST)
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
Subject: [PATCH v1 5/5] device property: Constify parameter in device_dma_supported() and device_get_dma_attr()
Date:   Tue, 27 Sep 2022 17:28:21 +0300
Message-Id: <20220927142822.4095-5-andriy.shevchenko@linux.intel.com>
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

Constify parameter in device_dma_supported() and device_get_dma_attr()
since they don't alter anything related to it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 10 +++++-----
 include/linux/property.h |  5 ++---
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 04eb5e0ab407..5b0417f7e561 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -871,18 +871,18 @@ unsigned int device_get_child_node_count(const struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_get_child_node_count);
 
-bool device_dma_supported(struct device *dev)
+bool device_dma_supported(const struct device *dev)
 {
-	return fwnode_call_bool_op(dev_fwnode(dev), device_dma_supported);
+	return fwnode_call_bool_op(dev_fwnode_const(dev), device_dma_supported);
 }
 EXPORT_SYMBOL_GPL(device_dma_supported);
 
-enum dev_dma_attr device_get_dma_attr(struct device *dev)
+enum dev_dma_attr device_get_dma_attr(const struct device *dev)
 {
-	if (!fwnode_has_op(dev_fwnode(dev), device_get_dma_attr))
+	if (!fwnode_has_op(dev_fwnode_const(dev), device_get_dma_attr))
 		return DEV_DMA_NOT_SUPPORTED;
 
-	return fwnode_call_int_op(dev_fwnode(dev), device_get_dma_attr);
+	return fwnode_call_int_op(dev_fwnode_const(dev), device_get_dma_attr);
 }
 EXPORT_SYMBOL_GPL(device_get_dma_attr);
 
diff --git a/include/linux/property.h b/include/linux/property.h
index 31dd6cbea9b0..a9498757155d 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -384,9 +384,8 @@ property_entries_dup(const struct property_entry *properties);
 
 void property_entries_free(const struct property_entry *properties);
 
-bool device_dma_supported(struct device *dev);
-
-enum dev_dma_attr device_get_dma_attr(struct device *dev);
+bool device_dma_supported(const struct device *dev);
+enum dev_dma_attr device_get_dma_attr(const struct device *dev);
 
 const void *device_get_match_data(const struct device *dev);
 
-- 
2.35.1

