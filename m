Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B5C6AAA6A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 15:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCDO3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 09:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCDO3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 09:29:05 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6BFC4ED6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 06:29:03 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 324ESurj006572;
        Sat, 4 Mar 2023 15:28:56 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     paulmck@kernel.org
Cc:     chenhuacai@loongson.cn, chenfeiyang@loongson.cn,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3/5] tools/nolibc: check for S_I* macros before defining them
Date:   Sat,  4 Mar 2023 15:28:42 +0100
Message-Id: <20230304142844.6522-4-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230304142844.6522-1-w@1wt.eu>
References: <20230304142844.6522-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defining S_I* flags in types.h can cause some build failures if
linux/stat.h is included prior to it. But if not defined, some toolchains
that include some glibc parts will in turn fail because linux/stat.h
already takes care of avoiding these definitions when glibc is present.

Let's preserve the macros here but first include linux/stat.h and check
for their definition before doing so. We also define the previously
missing permission macros so that we don't get a different behavior
depending on the first include found.

Cc: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/types.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index fbbc0e68c001..47a0997d2d74 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -9,6 +9,7 @@
 
 #include "std.h"
 #include <linux/time.h>
+#include <linux/stat.h>
 
 
 /* Only the generic macros and types may be defined here. The arch-specific
@@ -16,7 +17,11 @@
  * the layout of sys_stat_struct must not be defined here.
  */
 
-/* stat flags (WARNING, octal here) */
+/* stat flags (WARNING, octal here). We need to check for an existing
+ * definition because linux/stat.h may omit to define those if it finds
+ * that any glibc header was already included.
+ */
+#if !defined(S_IFMT)
 #define S_IFDIR        0040000
 #define S_IFCHR        0020000
 #define S_IFBLK        0060000
@@ -34,6 +39,22 @@
 #define S_ISLNK(mode)  (((mode) & S_IFMT) == S_IFLNK)
 #define S_ISSOCK(mode) (((mode) & S_IFMT) == S_IFSOCK)
 
+#define S_IRWXU 00700
+#define S_IRUSR 00400
+#define S_IWUSR 00200
+#define S_IXUSR 00100
+
+#define S_IRWXG 00070
+#define S_IRGRP 00040
+#define S_IWGRP 00020
+#define S_IXGRP 00010
+
+#define S_IRWXO 00007
+#define S_IROTH 00004
+#define S_IWOTH 00002
+#define S_IXOTH 00001
+#endif
+
 /* dirent types */
 #define DT_UNKNOWN     0x0
 #define DT_FIFO        0x1
-- 
2.17.5

