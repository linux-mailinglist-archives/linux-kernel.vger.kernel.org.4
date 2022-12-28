Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4C265773A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 14:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiL1NgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 08:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiL1NgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 08:36:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F66C1A5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 05:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672234561; x=1703770561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zW6Em7VKW6QJK6Y9hrXmcyrM2HrENfs3xicGHX5cUI0=;
  b=cyD5iVHrj9nOdycl8Syv9eZK4necPariJ5ZNjB/3NXcMrv50QhI6FRtB
   9BRU0GvK6pzWrllpSy9eP4Ua8DuIsSgSMpb28RV6NJHxbEl1qcZCUofcs
   f7VkeSwK04VMLZlSEI7IsP1zAbfREL2ksxLjnsb2wj/MBj9fj/O4rN8GB
   RrQZ06fdJKLZQXzuk4Y7EB7cCUuQpSqvenIztwl+5Vflaj3oCxCWG6dRo
   oiI6InWlADClhl26ehnHuZyoUHcf3qKwHgtyuI1uekJ4e0WbH8ixgI2Zw
   mCtshbXyom3i7arNAv8D2A2w1hgaYALIvkOpIIcq/LJ+cl7M+n81MAA7M
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="304367432"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="304367432"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 05:35:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="982095935"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="982095935"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 28 Dec 2022 05:35:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1CDF4159; Wed, 28 Dec 2022 15:36:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] uuid: Decouple guid_t and uuid_le types and respective macros
Date:   Wed, 28 Dec 2022 15:36:16 +0200
Message-Id: <20221228133616.69278-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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
 include/linux/uuid.h      | 20 ++++++++++++++++----
 include/uapi/linux/uuid.h | 12 ++++--------
 2 files changed, 20 insertions(+), 12 deletions(-)

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
-- 
2.35.1

