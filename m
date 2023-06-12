Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39F972CB28
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjFLQNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjFLQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:12:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A5DF9;
        Mon, 12 Jun 2023 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686586378; x=1718122378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZVijZK/WZlyfY9LyKUl0qbhbQCVTQtvnKOYuW8Ncf/M=;
  b=nqpy6rdC0eIi7vJ1ryhlNpdtvlc//sSr5lyMLp3tfDTH+E1wLIhh1az6
   m2fZ+f+QKiFBzfc+dtUVG94Rc24K8HeTvmwCPtHoJo6fSRp0mf51RUPkl
   /ZzcRMEirxTAmMSm+jxP9Oz+To1c3mKiFMeypvDwwqF0EFk/RFYbpixEj
   kRyA5B/sOwkUuD5CNZCYxLGwUuaViUh2ytiIiu686uH44muq3nOurHbae
   /WkIygervy21YZ5oR2fwBB6lKaHsKKaCXCN99Ax+WTaiEQpTK6Sa/KSJN
   BrW+WZ9Gk3GJFliZuEAuCedoDCsdCxGBSY1xfuNndfXpo9MDdnhD6O706
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="360572690"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="360572690"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 09:10:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="824031047"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="824031047"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jun 2023 09:10:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D20983B6; Mon, 12 Jun 2023 19:10:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 2/3] device property: Implement device_is_compatible()
Date:   Mon, 12 Jun 2023 19:10:10 +0300
Message-Id: <20230612161011.86871-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230612161011.86871-1-andriy.shevchenko@linux.intel.com>
References: <20230612161011.86871-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users want to use the struct device pointer to see if the
device is compatible in terms of Open Firmware specifications,
i.e. if it has a 'compatible' property and it matches to the
given value. Provide inline helper for the users.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/property.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 3df7e10156d8..0251138c7c88 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -90,6 +90,18 @@ bool fwnode_device_is_compatible(const struct fwnode_handle *fwnode, const char
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

