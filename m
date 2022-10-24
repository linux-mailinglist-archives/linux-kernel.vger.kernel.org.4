Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0170460AEE8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJXPVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJXPVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:21:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C820676776
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666620308; x=1698156308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OcmON4vRcRHtsz7DNouDpqshe8zRX7Zuf0O6FuXtvIQ=;
  b=duhzLA+x/McyKrT0h5qMXjMLQx3N/DS0x2IwBAl+GEd+WyzVVfaYLRGw
   4nvDe9LHlJcx0cVGDdnBW1wK0FTAumgtYMen7dwP80jOjIk/ncsJT6uCm
   z0WAZ/BrYFuXEgXD/jD+tjBxDzw4NWDYPnB0zfSQ78xXm8HH1FQKF1u3I
   ewu99hqrf5XqJ8D4uOt891Ws7n23JlSYf5BaBDaSgQhIws0U5HFOiUfdq
   jbLjLNe9HayvEGq7ZFyvnvCYfjjC3syzvVqzOMD1qs9W3ZaxLHzivzUsN
   veMoy/M+9Y6gzaRttNAe7728lzF3mPMwiuQYL7QnaSfQOLYyUo5roE30i
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="309101789"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="309101789"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 06:24:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="806302274"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="806302274"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 24 Oct 2022 06:24:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 31D55107; Mon, 24 Oct 2022 16:24:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [rft, PATCH v1 2/4] kernel.h: Split the hexadecimal related helpers to hex.h
Date:   Mon, 24 Oct 2022 16:24:32 +0300
Message-Id: <20221024132434.47057-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221024132434.47057-1-andriy.shevchenko@linux.intel.com>
References: <20221024132434.47057-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index bc3e0364970a..7a495e94b087 100644
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
@@ -259,34 +260,6 @@ extern enum system_states {
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
2.35.1

