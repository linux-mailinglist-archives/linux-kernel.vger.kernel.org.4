Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1975F69C1FD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 19:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjBSSv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 13:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjBSSvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 13:51:51 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C9D21449C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 10:51:49 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 31JIpiRe014622;
        Sun, 19 Feb 2023 19:51:44 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Vincent Dagonneau <v@vda.io>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/4] tools/nolibc: add stdint.h
Date:   Sun, 19 Feb 2023 19:51:30 +0100
Message-Id: <20230219185133.14576-2-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230219185133.14576-1-w@1wt.eu>
References: <20230219185133.14576-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Dagonneau <v@vda.io>

Nolibc works fine for small and limited program however most program
expect integer types to be defined in stdint.h rather than std.h.

This is a quick fix that moves the existing integer definitions in std.h
to stdint.h.

Signed-off-by: Vincent Dagonneau <v@vda.io>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/Makefile |  4 ++--
 tools/include/nolibc/std.h    | 15 +--------------
 tools/include/nolibc/stdint.h | 24 ++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 16 deletions(-)
 create mode 100644 tools/include/nolibc/stdint.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index cfd06764b5ae..ec57d3932506 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -25,8 +25,8 @@ endif
 
 nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
 arch_file := arch-$(nolibc_arch).h
-all_files := ctype.h errno.h nolibc.h signal.h std.h stdio.h stdlib.h string.h \
-             sys.h time.h types.h unistd.h
+all_files := ctype.h errno.h nolibc.h signal.h std.h stdint.h stdio.h stdlib.h \
+             string.h sys.h time.h types.h unistd.h
 
 # install all headers needed to support a bare-metal compiler
 all: headers
diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index 1747ae125392..933bc0be7e1c 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -18,20 +18,7 @@
 #define NULL ((void *)0)
 #endif
 
-/* stdint types */
-typedef unsigned char       uint8_t;
-typedef   signed char        int8_t;
-typedef unsigned short     uint16_t;
-typedef   signed short      int16_t;
-typedef unsigned int       uint32_t;
-typedef   signed int        int32_t;
-typedef unsigned long long uint64_t;
-typedef   signed long long  int64_t;
-typedef unsigned long        size_t;
-typedef   signed long       ssize_t;
-typedef unsigned long     uintptr_t;
-typedef   signed long      intptr_t;
-typedef   signed long     ptrdiff_t;
+#include "stdint.h"
 
 /* those are commonly provided by sys/types.h */
 typedef unsigned int          dev_t;
diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
new file mode 100644
index 000000000000..4ba264031df9
--- /dev/null
+++ b/tools/include/nolibc/stdint.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Standard definitions and types for NOLIBC
+ * Copyright (C) 2023 Vincent Dagonneau <v@vda.io>
+ */
+
+#ifndef _NOLIBC_STDINT_H
+#define _NOLIBC_STDINT_H
+
+typedef unsigned char       uint8_t;
+typedef   signed char        int8_t;
+typedef unsigned short     uint16_t;
+typedef   signed short      int16_t;
+typedef unsigned int       uint32_t;
+typedef   signed int        int32_t;
+typedef unsigned long long uint64_t;
+typedef   signed long long  int64_t;
+typedef unsigned long        size_t;
+typedef   signed long       ssize_t;
+typedef unsigned long     uintptr_t;
+typedef   signed long      intptr_t;
+typedef   signed long     ptrdiff_t;
+
+#endif /* _NOLIBC_STDINT_H */
-- 
2.35.3

