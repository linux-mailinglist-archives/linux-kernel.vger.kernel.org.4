Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3353A729E53
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241727AbjFIPZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241524AbjFIPZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:25:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA7235BE;
        Fri,  9 Jun 2023 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686324312; x=1717860312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zHjAgdVUBB0uVbkIgjmznv/ebWgxcQFRvgnhOx3Y82k=;
  b=I+FqyP3fmtGL4UXWxvjPPrf9JOsNIpmpUW9m1LAw6sEfXXeA8ozKYWoZ
   JdIHBK0hk/rUEpEr+ARuCSGYVrF3wkIqVio6sdTnnyzq1W9/w487hFQbq
   tdFdiV4ni06do0qWWXo1s3y+5/Qs0ag+wY/IQgdvg3S+t7hjmimLxy52j
   1i/LT1IgLiHvDDGnasWAJbg29t7pXryHqEbmdGTvLTyKCQanIl0hrdDkq
   HGGxtVO2j9q6HHwJSqvagur/UXJv1xS1tVFf2J4l3VaY8pyYVhcerU/QI
   9Bp3GnDqo9AOr2aZBxBZ22TuNZ6uWVTsCsiJ6YJqTpo/4+s8OE1GJX5ne
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="357623195"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="357623195"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 08:25:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="775532602"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="775532602"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jun 2023 08:25:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7760E56D; Fri,  9 Jun 2023 18:25:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
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
Subject: [PATCH v1 2/3] device property: Implement device_is_compatible()
Date:   Fri,  9 Jun 2023 18:25:06 +0300
Message-Id: <20230609152507.77649-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230609152507.77649-1-andriy.shevchenko@linux.intel.com>
References: <20230609152507.77649-1-andriy.shevchenko@linux.intel.com>
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

Some users want to use the struct device pointer to see if
the device is compatible. Provide inline helpers for them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/property.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 695053c60306..8de2c707818a 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -85,6 +85,11 @@ bool fwnode_device_is_compatible(const struct fwnode_handle *fwnode, const char
 	return fwnode_property_match_string(fwnode, "compatible", compat) >= 0;
 }
 
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

