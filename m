Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3A26AAA6B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 15:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCDO3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 09:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCDO3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 09:29:05 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5101293E7
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 06:29:04 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 324ESuTI006573;
        Sat, 4 Mar 2023 15:28:56 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     paulmck@kernel.org
Cc:     chenhuacai@loongson.cn, chenfeiyang@loongson.cn,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 4/5] tools/nolibc: Include linux/fcntl.h and remove duplicate code
Date:   Sat,  4 Mar 2023 15:28:43 +0100
Message-Id: <20230304142844.6522-5-w@1wt.eu>
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

From: Feiyang Chen <chenfeiyang@loongson.cn>

Include linux/fcntl.h for O_* and AT_*. asm/fcntl.h is included
by linux/fcntl.h, so it can be safely removed.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys.h   | 2 +-
 tools/include/nolibc/types.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 115579e7f1db..41cad6d6137e 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -11,7 +11,6 @@
 #include "std.h"
 
 /* system includes */
-#include <asm/fcntl.h>   // for O_*
 #include <asm/unistd.h>
 #include <asm/signal.h>  // for SIGCHLD
 #include <asm/ioctls.h>
@@ -20,6 +19,7 @@
 #include <linux/loop.h>
 #include <linux/time.h>
 #include <linux/auxvec.h>
+#include <linux/fcntl.h> // for O_* and AT_*
 
 #include "arch.h"
 #include "errno.h"
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 47a0997d2d74..10823e5ac44b 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -81,11 +81,6 @@
 #define MAXPATHLEN     (PATH_MAX)
 #endif
 
-/* Special FD used by all the *at functions */
-#ifndef AT_FDCWD
-#define AT_FDCWD       (-100)
-#endif
-
 /* whence values for lseek() */
 #define SEEK_SET       0
 #define SEEK_CUR       1
-- 
2.17.5

