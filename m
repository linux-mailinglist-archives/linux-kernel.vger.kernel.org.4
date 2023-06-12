Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172E272CB20
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjFLQM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjFLQM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:12:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C599C5;
        Mon, 12 Jun 2023 09:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686586375; x=1718122375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ekjCA2CGwiZrAX/o+zl26feODwMRZ9OhX+gAL/VO0z8=;
  b=Nmw7Ixa/Wr1RI2UbrHa9u87RH4HNNdy/2HnMpNBxBVbHxr62fKjOuRNn
   ceap7mDXxn+zU0xsqAGZumDjBu0gl1ssIJZBJ5jqzrxRrSmetdFQMTPx0
   h3B0JX7bEzJQiccVFP89SqeM+pZHHPuIQYUTY7UOWQlmQ9qXp/zluXeZE
   TTFozMNNexUZ58TE8s+QdsqTeFWvySujfMOt5y+P82K6wY6QaNSN+ehKo
   Usf4vqbrdfkpH04kFFklg1reB4WUSH1L8zAsqNeAZtaogJpQaIfQtHV+p
   H1by1CqNmksx5f/xtLLeKmrSGDjqNueDi07MqrXLASREFU/8l6/SMyWE6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="360572639"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="360572639"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 09:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="824031046"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="824031046"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jun 2023 09:10:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DC44C3BC; Mon, 12 Jun 2023 19:10:13 +0300 (EEST)
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
Subject: [PATCH v3 3/3] ata: ahci_platform: Make code agnostic to OF/ACPI
Date:   Mon, 12 Jun 2023 19:10:11 +0300
Message-Id: <20230612161011.86871-4-andriy.shevchenko@linux.intel.com>
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

With the help of a new device_is_compatible() make the driver code
agnostic to the OF/ACPI. This makes it neater. As a side effect
the header inclusions is corrected (seems mod_devicetable.h was
implicitly included).

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
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

