Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502C86AAA6D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 15:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjCDO3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 09:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjCDO3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 09:29:16 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCE151EFFA
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 06:29:11 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 324ESu48006574;
        Sat, 4 Mar 2023 15:28:56 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     paulmck@kernel.org
Cc:     chenhuacai@loongson.cn, chenfeiyang@loongson.cn,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 5/5] tools/nolibc: Add statx() and make stat() rely on statx() if necessary
Date:   Sat,  4 Mar 2023 15:28:44 +0100
Message-Id: <20230304142844.6522-6-w@1wt.eu>
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

LoongArch and RISC-V 32-bit only have statx(). ARC, Hexagon, Nios2 and
OpenRISC have statx() and stat64() but not stat() or newstat(). Add
statx() and make stat() rely on statx() if necessary to make them happy.
We may just use statx() for all architectures in the future.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys.h | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 41cad6d6137e..5d624dc63a42 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -20,6 +20,7 @@
 #include <linux/time.h>
 #include <linux/auxvec.h>
 #include <linux/fcntl.h> // for O_* and AT_*
+#include <linux/stat.h>  // for statx()
 
 #include "arch.h"
 #include "errno.h"
@@ -1090,12 +1091,66 @@ pid_t setsid(void)
 	return ret;
 }
 
+#if defined(__NR_statx)
+/*
+ * int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf);
+ */
+
+static __attribute__((unused))
+int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
+{
+	return my_syscall5(__NR_statx, fd, path, flags, mask, buf);
+}
+
+static __attribute__((unused))
+int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
+{
+	int ret = sys_statx(fd, path, flags, mask, buf);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+#endif
 
 /*
  * int stat(const char *path, struct stat *buf);
  * Warning: the struct stat's layout is arch-dependent.
  */
 
+#if defined(__NR_statx) && !defined(__NR_newfstatat) && !defined(__NR_stat)
+/*
+ * Maybe we can just use statx() when available for all architectures?
+ */
+static __attribute__((unused))
+int sys_stat(const char *path, struct stat *buf)
+{
+	struct statx statx;
+	long ret;
+
+	ret = sys_statx(AT_FDCWD, path, AT_NO_AUTOMOUNT, STATX_BASIC_STATS, &statx);
+	buf->st_dev     = ((statx.stx_dev_minor & 0xff)
+			  | (statx.stx_dev_major << 8)
+			  | ((statx.stx_dev_minor & ~0xff) << 12));
+	buf->st_ino     = statx.stx_ino;
+	buf->st_mode    = statx.stx_mode;
+	buf->st_nlink   = statx.stx_nlink;
+	buf->st_uid     = statx.stx_uid;
+	buf->st_gid     = statx.stx_gid;
+	buf->st_rdev    = ((statx.stx_rdev_minor & 0xff)
+			  | (statx.stx_rdev_major << 8)
+			  | ((statx.stx_rdev_minor & ~0xff) << 12));
+	buf->st_size    = statx.stx_size;
+	buf->st_blksize = statx.stx_blksize;
+	buf->st_blocks  = statx.stx_blocks;
+	buf->st_atime   = statx.stx_atime.tv_sec;
+	buf->st_mtime   = statx.stx_mtime.tv_sec;
+	buf->st_ctime   = statx.stx_ctime.tv_sec;
+	return ret;
+}
+#else
 static __attribute__((unused))
 int sys_stat(const char *path, struct stat *buf)
 {
@@ -1125,6 +1180,7 @@ int sys_stat(const char *path, struct stat *buf)
 	buf->st_ctime   = stat.st_ctime;
 	return ret;
 }
+#endif
 
 static __attribute__((unused))
 int stat(const char *path, struct stat *buf)
-- 
2.17.5

