Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9F16C6C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjCWPuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjCWPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:50:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B312724
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679586599; x=1711122599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vRbqxKRfJQyo9rp8OOe6y4TT1npJst8dzHA3s1UC37U=;
  b=APczLv3cvW6PDTsCEifKzgHoxsIl3zGmatGRRMqmL6ClZ6PO/R9I42tn
   FUXtgXA6IPSR2NFiaFKOQnMrqBcAbh/jytVXYfBQG4KBzyHtjFIY3XfHG
   iYXZzHKfbjlAKkfwAD9MCXb+H/1q3SRKVaWYdYxLCWQRHpOMTfWWGMZ/K
   gf+BDArSdgMF95KgZugKKJprUIAJwvusFHbkykqdMENDIT/De1ZRLtsMc
   qilCkXnPbz4MEKjLg/seHKN9m9CQZcsSGIjoPFE617Z4jmx/9QdYWNmEn
   1tzhNO1aTzk90IHA+5RCSZfUQmovbGm1xKNuUekHvGnUh67W+LPTvfgRy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="341081518"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="341081518"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 08:49:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="712716318"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="712716318"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 23 Mar 2023 08:49:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2B424176; Thu, 23 Mar 2023 17:50:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] kernel.h: Split the hexadecimal related helpers to hex.h
Date:   Thu, 23 Mar 2023 17:50:29 +0200
Message-Id: <20230323155029.40000-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of cleaning up the kernel.h split the hexadecimal
related helpers to own header called 'hex.h'.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/hex.h    | 35 +++++++++++++++++++++++++++++++++++
 include/linux/kernel.h | 29 +----------------------------
 2 files changed, 36 insertions(+), 28 deletions(-)
 create mode 100644 include/linux/hex.h

diff --git a/include/linux/hex.h b/include/linux/hex.h
new file mode 100644
index 000000000000..2618382e5b0c
--- /dev/null
+++ b/include/linux/hex.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_HEX_H
+#define _LINUX_HEX_H
+
+#include <linux/types.h>
+
+extern const char hex_asc[];
+#define hex_asc_lo(x)	hex_asc[((x) & 0x0f)]
+#define hex_asc_hi(x)	hex_asc[((x) & 0xf0) >> 4]
+
+static inline char *hex_byte_pack(char *buf, u8 byte)
+{
+	*buf++ = hex_asc_hi(byte);
+	*buf++ = hex_asc_lo(byte);
+	return buf;
+}
+
+extern const char hex_asc_upper[];
+#define hex_asc_upper_lo(x)	hex_asc_upper[((x) & 0x0f)]
+#define hex_asc_upper_hi(x)	hex_asc_upper[((x) & 0xf0) >> 4]
+
+static inline char *hex_byte_pack_upper(char *buf, u8 byte)
+{
+	*buf++ = hex_asc_upper_hi(byte);
+	*buf++ = hex_asc_upper_lo(byte);
+	return buf;
+}
+
+extern int hex_to_bin(unsigned char ch);
+extern int __must_check hex2bin(u8 *dst, const char *src, size_t count);
+extern char *bin2hex(char *dst, const void *src, size_t count);
+
+bool mac_pton(const char *s, u8 *mac);
+
+#endif
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 40bce7495af8..0d91e0af0125 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -20,6 +20,7 @@
 #include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/bitops.h>
+#include <linux/hex.h>
 #include <linux/kstrtox.h>
 #include <linux/log2.h>
 #include <linux/math.h>
@@ -263,34 +264,6 @@ extern enum system_states {
 	SYSTEM_SUSPEND,
 } system_state;
 
-extern const char hex_asc[];
-#define hex_asc_lo(x)	hex_asc[((x) & 0x0f)]
-#define hex_asc_hi(x)	hex_asc[((x) & 0xf0) >> 4]
-
-static inline char *hex_byte_pack(char *buf, u8 byte)
-{
-	*buf++ = hex_asc_hi(byte);
-	*buf++ = hex_asc_lo(byte);
-	return buf;
-}
-
-extern const char hex_asc_upper[];
-#define hex_asc_upper_lo(x)	hex_asc_upper[((x) & 0x0f)]
-#define hex_asc_upper_hi(x)	hex_asc_upper[((x) & 0xf0) >> 4]
-
-static inline char *hex_byte_pack_upper(char *buf, u8 byte)
-{
-	*buf++ = hex_asc_upper_hi(byte);
-	*buf++ = hex_asc_upper_lo(byte);
-	return buf;
-}
-
-extern int hex_to_bin(unsigned char ch);
-extern int __must_check hex2bin(u8 *dst, const char *src, size_t count);
-extern char *bin2hex(char *dst, const void *src, size_t count);
-
-bool mac_pton(const char *s, u8 *mac);
-
 /*
  * General tracing related utility functions - trace_printk(),
  * tracing_on/tracing_off and tracing_start()/tracing_stop
-- 
2.40.0.1.gaa8946217a0b

