Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCE967995E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjAXNiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjAXNiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:38:20 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AEF2A9A3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674567496; x=1706103496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8SbPXPfTRkZy0rqLvi5qcFrMTKDYIGc/6ThVu8fqKqk=;
  b=E0F7ZyDziC0LEk44JRrEdUmcwDf1Hh0Ieonrcj7es9fJdvt06idxF/Gc
   nebfLo5/TmqdX24CPQaclEctcIZy/Yu4Q3z1LylQvdd3I3eFsOrZZn/+6
   WYbdKAIxVrBYxpdO2SJjj9MVM4A1DPZE13t4eLFBu2TckLvT5O3vyZVdi
   +S2uqR1wcHHR6XnH94Tg9GUeCiH17SpkgHuzXErKmrdsOaVfB/QBT/Eq2
   aCssydOvrMroClQJTa772+o2C4kERtgqYkyJMxZxQhvwlcuRteWyLJ+CB
   zRD5MQbNgrSux+uJyaAEyYnr/4cHQ+JABsZWILxW2QtIZrcUmtoB79Pgy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="309867877"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="309867877"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 05:38:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="730686604"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="730686604"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jan 2023 05:38:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EC1E5154; Tue, 24 Jan 2023 15:38:49 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/1] uuid: Decouple guid_t and uuid_le types and respective macros
Date:   Tue, 24 Jan 2023 15:38:38 +0200
Message-Id: <20230124133838.22645-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The guid_t type and respective macros are being used internally only.
The uuid_le has its user outside the kernel. Decouple these types and
macros, and make guid_t completely internal type to the kernel.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: based on next/master to prevent compilation errors (LKP)
 
Supposed to go via Greg's driver/misc tree as necessary patches         
are there.

 MAINTAINERS               |  2 +-
 include/linux/uuid.h      | 20 ++++++++++++++++----
 include/uapi/linux/uuid.h | 12 ++++--------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e18388b4579..b43991269fae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10429,6 +10429,7 @@ F:	drivers/watchdog/mei_wdt.c
 F:	include/linux/mei_aux.h
 F:	include/linux/mei_cl_bus.h
 F:	include/uapi/linux/mei.h
+F:	include/uapi/linux/uuid.h
 F:	samples/mei/*
 
 INTEL MAX 10 BMC MFD DRIVER
@@ -21731,7 +21732,6 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.infradead.org/users/hch/uuid.git
 F:	include/linux/uuid.h
-F:	include/uapi/linux/uuid.h
 F:	lib/test_uuid.c
 F:	lib/uuid.c
 
diff --git a/include/linux/uuid.h b/include/linux/uuid.h
index 8cdc0d3567cd..5be158a49e11 100644
--- a/include/linux/uuid.h
+++ b/include/linux/uuid.h
@@ -8,15 +8,25 @@
 #ifndef _LINUX_UUID_H_
 #define _LINUX_UUID_H_
 
-#include <uapi/linux/uuid.h>
 #include <linux/string.h>
 
 #define UUID_SIZE 16
 
+typedef struct {
+	__u8 b[UUID_SIZE];
+} guid_t;
+
 typedef struct {
 	__u8 b[UUID_SIZE];
 } uuid_t;
 
+#define GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)			\
+((guid_t)								\
+{{ (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
+   (b) & 0xff, ((b) >> 8) & 0xff,					\
+   (c) & 0xff, ((c) >> 8) & 0xff,					\
+   (d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) }})
+
 #define UUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)			\
 ((uuid_t)								\
 {{ ((a) >> 24) & 0xff, ((a) >> 16) & 0xff, ((a) >> 8) & 0xff, (a) & 0xff, \
@@ -97,10 +107,12 @@ extern const u8 uuid_index[16];
 int guid_parse(const char *uuid, guid_t *u);
 int uuid_parse(const char *uuid, uuid_t *u);
 
-/* backwards compatibility, don't use in new code */
-static inline int uuid_le_cmp(const guid_t u1, const guid_t u2)
+/* MEI UUID type, don't use anywhere else */
+#include <uapi/linux/uuid.h>
+
+static inline int uuid_le_cmp(const uuid_le u1, const uuid_le u2)
 {
-	return memcmp(&u1, &u2, sizeof(guid_t));
+	return memcmp(&u1, &u2, sizeof(uuid_le));
 }
 
 #endif
diff --git a/include/uapi/linux/uuid.h b/include/uapi/linux/uuid.h
index c0f4bd9b040e..96ac684a4b2f 100644
--- a/include/uapi/linux/uuid.h
+++ b/include/uapi/linux/uuid.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /* DO NOT USE in new code! This is solely for MEI due to legacy reasons */
 /*
- * UUID/GUID definition
+ * MEI UUID definition
  *
  * Copyright (C) 2010, Intel Corp.
  *	Huang Ying <ying.huang@intel.com>
@@ -14,19 +14,15 @@
 
 typedef struct {
 	__u8 b[16];
-} guid_t;
+} uuid_le;
 
-#define GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)			\
-((guid_t)								\
+#define UUID_LE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)		\
+((uuid_le)								\
 {{ (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
    (b) & 0xff, ((b) >> 8) & 0xff,					\
    (c) & 0xff, ((c) >> 8) & 0xff,					\
    (d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) }})
 
-/* backwards compatibility, don't use in new code */
-typedef guid_t uuid_le;
-#define UUID_LE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)		\
-	GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
 #define NULL_UUID_LE							\
 	UUID_LE(0x00000000, 0x0000, 0x0000, 0x00, 0x00, 0x00, 0x00,	\
 	     0x00, 0x00, 0x00, 0x00)

base-commit: a54df7622717a40ddec95fd98086aff8ba7839a6
-- 
2.39.0

