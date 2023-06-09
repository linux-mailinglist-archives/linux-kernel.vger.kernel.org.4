Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E83F729F1E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbjFIPtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241912AbjFIPtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:49:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E61B359D;
        Fri,  9 Jun 2023 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686325745; x=1717861745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MMOQJvuhySW3Bx7Au361jmZr/o23ev6AN5VhmCppLTM=;
  b=Ie2msF5MXRteANZb70tjW4p6r6eyuRT5e9m6Lf9DQoGlYkjExid3er1A
   c41k4uo8VH+o9BdnJBZYKINtPCZbgD6X+RoUMEvtVTz6yCsrjcon3KG/a
   KloaGbrrI+JSGOPP0v3AocQTUSgiVYQj2m332J1Fy0TQph4FhVkZFYwQQ
   BTyd5VLBuIt1o4SF2V2V+Tpz2KOtfPOzKwaTB5ZGZ8jKQwEYy5aA1r58L
   jCV9AmfxBYN1l/3dpCMfWiG4vMXMO1QUqQO8MPbMsS/FYZx0yd93qU9mo
   JrOo3XAUcv6WoWRXXMNngB26geF8zmvcqxhvJzSPBx/BEAgZ8Fg8Rhvmh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="423504375"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="423504375"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 08:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="854785638"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="854785638"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2023 08:48:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7310765E; Fri,  9 Jun 2023 18:49:02 +0300 (EEST)
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
Subject: [PATCH v2 3/3] ata: ahci_platform: Make code agnostic to OF/ACPI
Date:   Fri,  9 Jun 2023 18:49:00 +0300
Message-Id: <20230609154900.43024-4-andriy.shevchenko@linux.intel.com>
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

With the help of a new device_is_compatible() make
the driver code agnostic to the OF/ACPI. This makes
it neater. As a side effect the header inclusions is
corrected (seems mod_devicetable.h was implicitly
included).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/ahci_platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index ab30c7138d73..81fc63f6b008 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -9,14 +9,14 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/device.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/libata.h>
 #include <linux/ahci_platform.h>
-#include <linux/acpi.h>
 #include <linux/pci_ids.h>
 #include "ahci.h"
 
@@ -56,10 +56,10 @@ static int ahci_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
+	if (device_is_compatible(dev, "hisilicon,hisi-ahci"))
 		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
 
-	port = acpi_device_get_match_data(dev);
+	port = device_get_match_data(dev);
 	if (!port)
 		port = &ahci_port_info;
 
-- 
2.40.0.1.gaa8946217a0b

