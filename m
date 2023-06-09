Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2C4729E57
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241730AbjFIPZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241534AbjFIPZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:25:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E3335B6;
        Fri,  9 Jun 2023 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686324312; x=1717860312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ddxTpj08Ejw4GJ1aZ/q3t7SQimsuCWBX6xQNszlNeHQ=;
  b=T7elnzfw5GNCpdj814oiTP4sXUn15CIhuOZrvPuXj2CXEQilvra4glah
   0aIm6LjToxvgY2hYOHBpeo7+L/c9v7IWZEkm1sTZEWg3Qy4GubakXi0Mv
   ooibK2NV3Tbr9ZcF1//M5l69iYP2Dx5J4Qdx6l3sBRrrDiMZoAyfXGo+B
   OkxBnPlgA5ZVtK3ucVCms5YrPhkJD4wLmbQwLwpW5bolPxGIyPaTEvPSx
   E9RD8nl0t5sYTNq9RkhvhTV93TeG9Bj1uLpZaDIzJAgqaUxv7/ZsJOpbD
   d57nNgA6tgGxq/cyV/B/2geZsL10h9U7SJQhOW4ShluqsLEgARW8QROdZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="357623180"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="357623180"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 08:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="775532601"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="775532601"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jun 2023 08:25:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 681CD16A; Fri,  9 Jun 2023 18:25:14 +0300 (EEST)
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
Subject: [PATCH v1 1/3] ACPI: Move ACPI_DEVICE_CLASS() to mod_devicetable.h
Date:   Fri,  9 Jun 2023 18:25:05 +0300
Message-Id: <20230609152507.77649-2-andriy.shevchenko@linux.intel.com>
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

The data type of struct acpi_device_id is defined in the
mod_devicetable.h. It's suboptimal to require user with
the almost agnostic code to include acpi.h solely for the
macro that affects the data type defined elsewhere.

Taking into account the above and for the sake of consistency
move ACPI_DEVICE_CLASS() to mod_devicetable.h.

Note, that with CONFIG_ACPI=n the ID table will be filed with data
but it does not really matter because either it won't be used, or
won't be compiled in some cases (when guarded by respective ifdeffery).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/acpi.h            | 14 --------------
 include/linux/mod_devicetable.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d41a05d68166..640f1c07c894 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -70,19 +70,6 @@ static inline void acpi_free_fwnode_static(struct fwnode_handle *fwnode)
 	kfree(fwnode);
 }
 
-/**
- * ACPI_DEVICE_CLASS - macro used to describe an ACPI device with
- * the PCI-defined class-code information
- *
- * @_cls : the class, subclass, prog-if triple for this device
- * @_msk : the class mask for this device
- *
- * This macro is used to create a struct acpi_device_id that matches a
- * specific PCI class. The .id and .driver_data fields will be left
- * initialized with the default value.
- */
-#define ACPI_DEVICE_CLASS(_cls, _msk)	.cls = (_cls), .cls_msk = (_msk),
-
 static inline bool has_acpi_companion(struct device *dev)
 {
 	return is_acpi_device_node(dev->fwnode);
@@ -782,7 +769,6 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 #define ACPI_COMPANION_SET(dev, adev)	do { } while (0)
 #define ACPI_HANDLE(dev)		(NULL)
 #define ACPI_HANDLE_FWNODE(fwnode)	(NULL)
-#define ACPI_DEVICE_CLASS(_cls, _msk)	.cls = (0), .cls_msk = (0),
 
 #include <acpi/acpi_numa.h>
 
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index ccaaeda792c0..486747518aae 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -221,6 +221,19 @@ struct acpi_device_id {
 	__u32 cls_msk;
 };
 
+/**
+ * ACPI_DEVICE_CLASS - macro used to describe an ACPI device with
+ * the PCI-defined class-code information
+ *
+ * @_cls : the class, subclass, prog-if triple for this device
+ * @_msk : the class mask for this device
+ *
+ * This macro is used to create a struct acpi_device_id that matches a
+ * specific PCI class. The .id and .driver_data fields will be left
+ * initialized with the default value.
+ */
+#define ACPI_DEVICE_CLASS(_cls, _msk)	.cls = (_cls), .cls_msk = (_msk),
+
 #define PNP_ID_LEN	8
 #define PNP_MAX_DEVICES	8
 
-- 
2.40.0.1.gaa8946217a0b

