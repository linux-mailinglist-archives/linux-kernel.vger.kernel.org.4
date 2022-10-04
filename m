Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790415F3F76
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiJDJXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiJDJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:22:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8B12ED5F;
        Tue,  4 Oct 2022 02:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664875284; x=1696411284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZeP0lPjV7NZNcBm7cfO7nOE3g40M6mF5EMSj7k4YNWE=;
  b=MQ2V3FPM7FT3v9izM+jVEEh15MhMk+KrjFPxx7GriOERZVfuEHYsnjbK
   kYSdhBNAdXPSoBc9Pzm+XoBCyxQbzg9F83/OD5boPWpxStgvCqN48cFjF
   83oq2WSEfWrD9u7UKNyp9aoureHU5wGXpToKxrzjy72pkAC4BBVJEkNsY
   nnV8tUPDE8o5vSw9zqzwi4iv+Pn4VWFcefL2joRP8JMbGhDh/XIGCldNB
   7EMtpLjlb/oCf9MoyWlJ6/a+U6KnlTnuVRfD3Seda9qRZ4nkSwCgFGq4R
   o4FzqyHDxhy2mrmAjKnin9Pwr96/4blTWFkTZsQarJsZxZeSTMUhTakQH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="303824994"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="303824994"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 02:21:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="623865980"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="623865980"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 04 Oct 2022 02:21:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B5AF0101; Tue,  4 Oct 2022 12:21:31 +0300 (EEST)
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
Subject: [PATCH v3 5/5] device property: Constify parameter in device_dma_supported() and device_get_dma_attr()
Date:   Tue,  4 Oct 2022 12:21:29 +0300
Message-Id: <20221004092129.19412-6-andriy.shevchenko@linux.intel.com>
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

Constify parameter in device_dma_supported() and device_get_dma_attr()
since they don't alter anything related to it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c  | 4 ++--
 include/linux/property.h | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index d3ea5f82978f..68f61d3e3857 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -871,13 +871,13 @@ unsigned int device_get_child_node_count(const struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_get_child_node_count);
 
-bool device_dma_supported(struct device *dev)
+bool device_dma_supported(const struct device *dev)
 {
 	return fwnode_call_bool_op(dev_fwnode(dev), device_dma_supported);
 }
 EXPORT_SYMBOL_GPL(device_dma_supported);
 
-enum dev_dma_attr device_get_dma_attr(struct device *dev)
+enum dev_dma_attr device_get_dma_attr(const struct device *dev)
 {
 	if (!fwnode_has_op(dev_fwnode(dev), device_get_dma_attr))
 		return DEV_DMA_NOT_SUPPORTED;
diff --git a/include/linux/property.h b/include/linux/property.h
index 472689e53ade..83674f968a8f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -388,9 +388,8 @@ property_entries_dup(const struct property_entry *properties);
 
 void property_entries_free(const struct property_entry *properties);
 
-bool device_dma_supported(struct device *dev);
-
-enum dev_dma_attr device_get_dma_attr(struct device *dev);
+bool device_dma_supported(const struct device *dev);
+enum dev_dma_attr device_get_dma_attr(const struct device *dev);
 
 const void *device_get_match_data(const struct device *dev);
 
-- 
2.35.1

