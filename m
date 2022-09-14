Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F135B8DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiINRH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiINRH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:07:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DB858DE4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663175276; x=1694711276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j/yBmzurcWwXZutQtxptjkeOqWAuVzR7sTadNSSvhqM=;
  b=Q1RBiV8/mkCK9sPgOvZR4gcwqqPZ8un9mujKv+Oa2D2/eRQ1VanwhI4c
   lOGGPMz/mT/kW00i62JCxen+LnjfixR0jJGgTFmCVYVIIpJ+fjsvOF6nE
   vfZCWubQJaOibwoGN7qvoMVfxATl/6d4VsQymJmyqHr42wEI4KMlOl1EA
   Whg0O9ucePrsvCF8bXMU40+Lf8d0BEtyb4lhfX2AUei2Qle4hjPL6oMMs
   180Bmy5KNWl1Py/RtKLWhKlBzpMfmnue3xwc1wevKrqLc5FOtl5+s7dU0
   cu26r8U238V75SZtuvbv/wTXpaejVXwHX0H4Fd/vxh7eOEfxpMmhcccJa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="278873867"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="278873867"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 10:07:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="650146943"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 14 Sep 2022 10:07:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9DADEF7; Wed, 14 Sep 2022 20:08:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] kernel.h: Split the hexadecimal related helpers to hex.h
Date:   Wed, 14 Sep 2022 20:08:09 +0300
Message-Id: <20220914170809.34651-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of cleaning up the kernel.h split the hexadecimal
relted helpers to own header called 'hex.h'.

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

