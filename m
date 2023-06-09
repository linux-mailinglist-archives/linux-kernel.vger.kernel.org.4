Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D71729F18
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241921AbjFIPtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241902AbjFIPtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:49:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6270C358C;
        Fri,  9 Jun 2023 08:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686325742; x=1717861742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y+zkYbO5YK9WS+hVnRuiIYSGEwkKq9bB3JyPjPdLmHk=;
  b=SLyf/6tP4qRceqWuqNm70aTe0Pj2DCHDbVpxvpYL94IzfUzgoYkhORav
   cyD4SMTCpfhRYM0k/y4/vbdw7HLu6ZImwikcKDFGuEfJDAYAX4I3i4/eG
   AZMYlVnnYq91XXg/8CYWcuHmqi84zuY7CxqwTfERje3i1Ci3HkwARqbHd
   OcX5K59R6lWstq388Xey6h+eyT+jVy55g83Skb+/xc/AlOMPLYhrtjL28
   7wOkpNYcD71zvODFTCWkgenWPqlg/pLcN8wtMV/lpKFGrxv0gIiBfxOdM
   adLzXQU05+yh6Tqr+Q9YHlEZagDQQZKdYayvU77GfZqi5lfcKs/hnchl7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="423504368"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="423504368"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 08:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="854785637"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="854785637"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2023 08:48:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5E97534F; Fri,  9 Jun 2023 18:49:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 2/3] device property: Implement device_is_compatible()
Date:   Fri,  9 Jun 2023 18:48:59 +0300
Message-Id: <20230609154900.43024-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
References: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users want to use the struct device pointer to see if the
device is compatible in terms of Open Firmware specifications,
i.e. if it has a 'compatible' property and it matches to the
given value. Provide inline helper for the users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/property.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 695053c60306..0222b77dd75c 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -85,6 +85,18 @@ bool fwnode_device_is_compatible(const struct fwnode_handle *fwnode, const char
 	return fwnode_property_match_string(fwnode, "compatible", compat) >= 0;
 }
 
+/**
+ * device_is_compatible - match 'compatible' property of the device with a given string
+ * @dev: Pointer to the struct device
+ * @compat: The string to match 'compatible' property with
+ *
+ * Returns: true if matches, otherwise false.
+ */
+static inline bool device_is_compatible(const struct device *dev, const char *compat)
+{
+	return fwnode_device_is_compatible(dev_fwnode(dev), compat);
+}
+
 int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       const char *prop, const char *nargs_prop,
 				       unsigned int nargs, unsigned int index,
-- 
2.40.0.1.gaa8946217a0b

