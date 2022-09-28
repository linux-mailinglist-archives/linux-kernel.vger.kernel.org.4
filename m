Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E635EDAC8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiI1K7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbiI1K6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:58:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879164B4B0;
        Wed, 28 Sep 2022 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664362657; x=1695898657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=skX/WDwNM/DXd0kPEwSKK6N878en+b7YxS0IVV3SxMc=;
  b=SO6Bae/lsRYYg9lADEgzU0rlFRIXHKWt/n+rzI3+UW4tnnszvhtzwoxO
   bZveginox5mhaX6TRpbUTVkwkSnAJ1fE5Da4kNSjE1N+r2xKLqtLlMBo9
   l1XYx/ki32Mx3ZNCbxIskxU39XkiNLfyRUFMBRQnksIeuwnX0/EgOG2OI
   JtczwInSzp/819vxwELXMCRsHuvN1DjhHErti82Y8VWCQpM8BF+kcZBxh
   CV4Y5569QNhr8dN9HHeooUBYkGl5Lk1wjYF/gneC2Fa+dIXYy5SkDk0xq
   lPln7M/SSP2ssvyQFRRA+r+vleR5L2Z5PsqIJCP3F6Ab5AvfGoe0GhAiz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="281288064"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="281288064"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 03:57:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="621881391"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="621881391"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 28 Sep 2022 03:57:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2573E57F; Wed, 28 Sep 2022 13:57:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 5/5] device property: Constify parameter in device_dma_supported() and device_get_dma_attr()
Date:   Wed, 28 Sep 2022 13:57:46 +0300
Message-Id: <20220928105746.51208-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220928105746.51208-1-andriy.shevchenko@linux.intel.com>
References: <20220928105746.51208-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify parameter in device_dma_supported() and device_get_dma_attr()
since they don't alter anything related to it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
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

