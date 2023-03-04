Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00276AAA66
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 15:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCDO0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 09:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCDO0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 09:26:35 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6BA11EBCC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 06:26:33 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 324EQHMu006043;
        Sat, 4 Mar 2023 15:26:17 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     paulmck@kernel.org
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Vincent Dagonneau <v@vda.io>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 2/4] tools/nolibc: add integer types and integer limit macros
Date:   Sat,  4 Mar 2023 15:26:04 +0100
Message-Id: <20230304142606.5995-3-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230304142606.5995-1-w@1wt.eu>
References: <20230304142606.5995-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Dagonneau <v@vda.io>

This commit adds some of the missing integer types to stdint.h and adds
limit macros (e.g. INTN_{MIN,MAX}).

The reference used for adding these types is
https://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdint.h.html.

We rely on the compiler-defined __LONG_MAX__ to get the right limits for
size_t, intptr_t, uintptr_t and ptrdiff_t. This compiler constant seem
to have been defined at least since GCC 4.1.2 and clang
3.0.0 on x86_64. It is also defined on ARM (32&64), mips and RISC-V.

Note that the maximum size of size_t is implementation-defined (>65535),
in this case I chose to go with unsigned long on all platforms since
unsigned long == unsigned int on all the platforms we care about. Note
that the kernel uses either unsigned int or unsigned long in
linux/include/uapi/asm-generic/posix_types.h. These should be equivalent
for the plaforms we are targeting.

Also note that the 'fast*' flavor of the types have been chosen to be
always 1 byte for '*fast8*' and always long (a.k.a. intptr_t/uintptr_t) for
the other variants. I have never seen the 'fast*' types in use in the wild
but that seems to be what glibc does.

Signed-off-by: Vincent Dagonneau <v@vda.io>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdint.h | 75 +++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
index 4ba264031df9..c1ce4f5e0603 100644
--- a/tools/include/nolibc/stdint.h
+++ b/tools/include/nolibc/stdint.h
@@ -21,4 +21,79 @@ typedef unsigned long     uintptr_t;
 typedef   signed long      intptr_t;
 typedef   signed long     ptrdiff_t;
 
+typedef   int8_t       int_least8_t;
+typedef  uint8_t      uint_least8_t;
+typedef  int16_t      int_least16_t;
+typedef uint16_t     uint_least16_t;
+typedef  int32_t      int_least32_t;
+typedef uint32_t     uint_least32_t;
+typedef  int64_t      int_least64_t;
+typedef uint64_t     uint_least64_t;
+
+typedef   int8_t        int_fast8_t;
+typedef  uint8_t       uint_fast8_t;
+typedef  ssize_t       int_fast16_t;
+typedef   size_t      uint_fast16_t;
+typedef  ssize_t       int_fast32_t;
+typedef   size_t      uint_fast32_t;
+typedef  ssize_t       int_fast64_t;
+typedef   size_t      uint_fast64_t;
+
+typedef  int64_t           intmax_t;
+typedef uint64_t          uintmax_t;
+
+/* limits of integral types */
+
+#define        INT8_MIN  (-128)
+#define       INT16_MIN  (-32767-1)
+#define       INT32_MIN  (-2147483647-1)
+#define       INT64_MIN  (-9223372036854775807LL-1)
+
+#define        INT8_MAX  (127)
+#define       INT16_MAX  (32767)
+#define       INT32_MAX  (2147483647)
+#define       INT64_MAX  (9223372036854775807LL)
+
+#define       UINT8_MAX  (255)
+#define      UINT16_MAX  (65535)
+#define      UINT32_MAX  (4294967295U)
+#define      UINT64_MAX  (18446744073709551615ULL)
+
+#define  INT_LEAST8_MIN  INT8_MIN
+#define INT_LEAST16_MIN  INT16_MIN
+#define INT_LEAST32_MIN  INT32_MIN
+#define INT_LEAST64_MIN  INT64_MIN
+
+#define  INT_LEAST8_MAX  INT8_MAX
+#define INT_LEAST16_MAX  INT16_MAX
+#define INT_LEAST32_MAX  INT32_MAX
+#define INT_LEAST64_MAX  INT64_MAX
+
+#define  UINT_LEAST8_MAX UINT8_MAX
+#define UINT_LEAST16_MAX UINT16_MAX
+#define UINT_LEAST32_MAX UINT32_MAX
+#define UINT_LEAST64_MAX UINT64_MAX
+
+#define SIZE_MAX         ((size_t)(__LONG_MAX__) * 2 + 1)
+#define INTPTR_MIN       (-__LONG_MAX__ - 1)
+#define INTPTR_MAX       __LONG_MAX__
+#define PTRDIFF_MIN      INTPTR_MIN
+#define PTRDIFF_MAX      INTPTR_MAX
+#define UINTPTR_MAX      SIZE_MAX
+
+#define  INT_FAST8_MIN   INT8_MIN
+#define INT_FAST16_MIN   INTPTR_MIN
+#define INT_FAST32_MIN   INTPTR_MIN
+#define INT_FAST64_MIN   INTPTR_MIN
+
+#define  INT_FAST8_MAX   INT8_MAX
+#define INT_FAST16_MAX   INTPTR_MAX
+#define INT_FAST32_MAX   INTPTR_MAX
+#define INT_FAST64_MAX   INTPTR_MAX
+
+#define  UINT_FAST8_MAX  UINT8_MAX
+#define UINT_FAST16_MAX  SIZE_MAX
+#define UINT_FAST32_MAX  SIZE_MAX
+#define UINT_FAST64_MAX  SIZE_MAX
+
 #endif /* _NOLIBC_STDINT_H */
-- 
2.17.5

