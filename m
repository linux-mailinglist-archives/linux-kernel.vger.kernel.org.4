Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08454729E56
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbjFIPZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbjFIPZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:25:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CBE3A94;
        Fri,  9 Jun 2023 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686324313; x=1717860313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JiZcSEh6wtKIXhWUTQdPeLqGPLC1Yi/N2wixH2YZSZk=;
  b=EJa5g5PiePvyG4IjnlFH/h6ujKDStd8TMIcJR4jrVlONViWLjRAavmSu
   0HQr7P4KV3vEsJIOKC0dfh8eWea2H4DXym4+NS8f3yJ15kssP7F3AHugi
   uR1gYcPFns+X6af04g89PpjhIZPCFZeRerTo6Q26gKyBQgH1lRhjyWFI4
   ug8XT6IMjbfZ85Sq+CIE0DFEo0ROTfGVxZYlGzspc5Hl/RREamd7tLYZ6
   gSrR5H3Aqn2lIWZp/9r25QOz8gEeo+rSrdBv1nAPJoA9EaAniEkLMi+LP
   7wTq2bjWiKy+E66GKFbF7YVSYbuOAgC7FOfjTv+EiTOlAaIG9vKc9R4Bt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="357623189"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="357623189"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 08:25:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="775532603"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="775532603"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jun 2023 08:25:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7D70D34F; Fri,  9 Jun 2023 18:25:14 +0300 (EEST)
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
Subject: [PATCH v1 3/3] ata: ahci_platform: Make code agnostic to OF/ACPI
Date:   Fri,  9 Jun 2023 18:25:07 +0300
Message-Id: <20230609152507.77649-4-andriy.shevchenko@linux.intel.com>
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

With the help of a new device_is_compatible() make
the driver code agnostic to the OF/ACPI. This makes
it neater. As a side effect the header inclusions is
corrected (seems mod_devicetable.h was implicitly
included).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/ahci_platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index ab30c7138d73..71a18344a0c8 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -12,11 +12,11 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/device.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/platform_device.h>
 #include <linux/libata.h>
 #include <linux/ahci_platform.h>
-#include <linux/acpi.h>
 #include <linux/pci_ids.h>
 #include "ahci.h"
 
@@ -56,7 +56,7 @@ static int ahci_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
+	if (device_is_compatible(dev, "hisilicon,hisi-ahci"))
 		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
 
 	port = acpi_device_get_match_data(dev);
-- 
2.40.0.1.gaa8946217a0b

