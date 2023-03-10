Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38876B4E03
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjCJRIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjCJRIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:08:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706C6135B17
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678468038; x=1710004038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aFUyfmv4ngWJdE/hSGaAq035+zvVdWp2sCUpjA2Sk3o=;
  b=CaSg0LGHGwxD6a80ZQ0Vg3sjpGpOwOdWlxMjQMxTEmvf2NswPx661zfY
   2OBL0eikFmNCTdBjZd/M1iHuddw+9UGj596mrNStoaeUBlSIayA4OXtIK
   MrAEONy5E20oacbEvH1SnfcBWisCIa3aqeB4ZGq8HpVPW6L13QFgM/SVr
   LfJr+KlUA8kEGfQkgKsdR26yuQ+9c8mNZvXo98WOPNTYMdhwrxC/CpR3o
   BbGhq7jSzrNXShkCsl38zNWwQaGzW3vPdCQKBGgHDrs8cBJR+Y2SwAl4B
   rA4sgRMoxCCs6fDuBu2XtLD3KaZBLh7i0uDZZqyIMDUQXORFSXnWB+Dex
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="401637462"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="401637462"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:07:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="746787063"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="746787063"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2023 09:07:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4AC9C143; Fri, 10 Mar 2023 19:07:59 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v1 1/1] mei: Move uuid.h to the MEI namespace
Date:   Fri, 10 Mar 2023 19:07:47 +0200
Message-Id: <20230310170747.22782-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only a single user of the UUID uAPI, let's make it
part of that user.

The way it's done is to prevent compilation time breakage for
the user space that does

	#include <linux/uuid.h>

In the future MEI user space tools can switch over to use mei_uuid.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                               |  1 +
 drivers/misc/mei/bus-fixup.c              |  2 +-
 drivers/misc/mei/hdcp/mei_hdcp.c          |  2 +-
 drivers/misc/mei/hw.h                     |  2 +-
 drivers/misc/mei/main.c                   |  1 -
 drivers/misc/mei/pxp/mei_pxp.c            |  2 +-
 include/linux/mod_devicetable.h           |  1 +
 include/linux/uuid.h                      |  3 ---
 include/uapi/linux/mei.h                  |  2 +-
 include/uapi/linux/{uuid.h => mei_uuid.h} |  7 +++--
 include/uapi/linux/uuid.h                 | 31 +----------------------
 11 files changed, 11 insertions(+), 43 deletions(-)
 copy include/uapi/linux/{uuid.h => mei_uuid.h} (79%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2892858cb040..defcedce9fe9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10479,6 +10479,7 @@ F:	drivers/watchdog/mei_wdt.c
 F:	include/linux/mei_aux.h
 F:	include/linux/mei_cl_bus.h
 F:	include/uapi/linux/mei.h
+F:	include/uapi/linux/mei_uuid.h
 F:	include/uapi/linux/uuid.h
 F:	samples/mei/*
 
diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 211536109308..31e3c74ca1f1 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -9,8 +9,8 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/slab.h>
-#include <linux/uuid.h>
 
+#include <linux/mei.h>
 #include <linux/mei_cl_bus.h>
 
 #include "mei_dev.h"
diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
index e0dcd5c114db..45e3d4d27797 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.c
+++ b/drivers/misc/mei/hdcp/mei_hdcp.c
@@ -18,7 +18,7 @@
 
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/uuid.h>
+#include <linux/mei.h>
 #include <linux/mei_cl_bus.h>
 #include <linux/component.h>
 #include <drm/drm_connector.h>
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index 319418ddf4fb..e910302fcd1f 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -7,7 +7,7 @@
 #ifndef _MEI_HW_TYPES_H_
 #define _MEI_HW_TYPES_H_
 
-#include <linux/uuid.h>
+#include <linux/mei.h>
 
 /*
  * Timeouts in Seconds
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 632d4ae21e46..c64291741d73 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -18,7 +18,6 @@
 #include <linux/ioctl.h>
 #include <linux/cdev.h>
 #include <linux/sched/signal.h>
-#include <linux/uuid.h>
 #include <linux/compat.h>
 #include <linux/jiffies.h>
 #include <linux/interrupt.h>
diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
index 7ee1fa7b1cb3..3bf560bbdee0 100644
--- a/drivers/misc/mei/pxp/mei_pxp.c
+++ b/drivers/misc/mei/pxp/mei_pxp.c
@@ -13,7 +13,7 @@
 
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/uuid.h>
+#include <linux/mei.h>
 #include <linux/mei_cl_bus.h>
 #include <linux/component.h>
 #include <drm/drm_connector.h>
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 549590e9c644..35203ca3fc37 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -9,6 +9,7 @@
 #define LINUX_MOD_DEVICETABLE_H
 
 #ifdef __KERNEL__
+#include <linux/mei.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
 typedef unsigned long kernel_ulong_t;
diff --git a/include/linux/uuid.h b/include/linux/uuid.h
index 6b1a3efa1e0b..43d4a79b273d 100644
--- a/include/linux/uuid.h
+++ b/include/linux/uuid.h
@@ -107,7 +107,4 @@ extern const u8 uuid_index[16];
 int guid_parse(const char *uuid, guid_t *u);
 int uuid_parse(const char *uuid, uuid_t *u);
 
-/* MEI UUID type, don't use anywhere else */
-#include <uapi/linux/uuid.h>
-
 #endif
diff --git a/include/uapi/linux/mei.h b/include/uapi/linux/mei.h
index 4f3638489d01..6e57743628c0 100644
--- a/include/uapi/linux/mei.h
+++ b/include/uapi/linux/mei.h
@@ -7,7 +7,7 @@
 #ifndef _LINUX_MEI_H
 #define _LINUX_MEI_H
 
-#include <linux/uuid.h>
+#include <linux/mei_uuid.h>
 
 /*
  * This IOCTL is used to associate the current file descriptor with a
diff --git a/include/uapi/linux/uuid.h b/include/uapi/linux/mei_uuid.h
similarity index 79%
copy from include/uapi/linux/uuid.h
copy to include/uapi/linux/mei_uuid.h
index 96ac684a4b2f..676ebe12d623 100644
--- a/include/uapi/linux/uuid.h
+++ b/include/uapi/linux/mei_uuid.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* DO NOT USE in new code! This is solely for MEI due to legacy reasons */
 /*
  * MEI UUID definition
  *
@@ -7,8 +6,8 @@
  *	Huang Ying <ying.huang@intel.com>
  */
 
-#ifndef _UAPI_LINUX_UUID_H_
-#define _UAPI_LINUX_UUID_H_
+#ifndef _UAPI_LINUX_MEI_UUID_H_
+#define _UAPI_LINUX_MEI_UUID_H_
 
 #include <linux/types.h>
 
@@ -27,4 +26,4 @@ typedef struct {
 	UUID_LE(0x00000000, 0x0000, 0x0000, 0x00, 0x00, 0x00, 0x00,	\
 	     0x00, 0x00, 0x00, 0x00)
 
-#endif /* _UAPI_LINUX_UUID_H_ */
+#endif /* _UAPI_LINUX_MEI_UUID_H_ */
diff --git a/include/uapi/linux/uuid.h b/include/uapi/linux/uuid.h
index 96ac684a4b2f..8443738f4bb2 100644
--- a/include/uapi/linux/uuid.h
+++ b/include/uapi/linux/uuid.h
@@ -1,30 +1 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* DO NOT USE in new code! This is solely for MEI due to legacy reasons */
-/*
- * MEI UUID definition
- *
- * Copyright (C) 2010, Intel Corp.
- *	Huang Ying <ying.huang@intel.com>
- */
-
-#ifndef _UAPI_LINUX_UUID_H_
-#define _UAPI_LINUX_UUID_H_
-
-#include <linux/types.h>
-
-typedef struct {
-	__u8 b[16];
-} uuid_le;
-
-#define UUID_LE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)		\
-((uuid_le)								\
-{{ (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
-   (b) & 0xff, ((b) >> 8) & 0xff,					\
-   (c) & 0xff, ((c) >> 8) & 0xff,					\
-   (d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) }})
-
-#define NULL_UUID_LE							\
-	UUID_LE(0x00000000, 0x0000, 0x0000, 0x00, 0x00, 0x00, 0x00,	\
-	     0x00, 0x00, 0x00, 0x00)
-
-#endif /* _UAPI_LINUX_UUID_H_ */
+#include <linux/mei_uuid.h>
-- 
2.39.1

