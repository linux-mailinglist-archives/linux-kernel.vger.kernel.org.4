Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B20B6C271C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCUBOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjCUBNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:13:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30EC93E4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 18:13:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49E5FB811C1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF05C433AA;
        Tue, 21 Mar 2023 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679361099;
        bh=I6L9I5YvKU2tMz08JBH9lvplcZ5ve+HKcUuODuR8ErU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nprVU0QzWFuNAOMQuLfo+eot0Hp8a7bk5UFqGP8XKSNY0Gvt58aeqoZPLo8mHXBZw
         SIG3O4dQUzrnd3mU+X+8k1giibuJ7+t4NfeG6oj4rBrJ8Em4bkQBh7LVdEUqC+Dmis
         uaP5itq/GaA2AU/rLXXm+O2Xy6H1S64GukDc8AGS+GpCMHT/b8QUqd3TFKf0R/0yGY
         nM7zcpTyVifs3ivbUDiE/iTKpVd9qbPNGdJWFeJemzqhaFJmMR/FNpk7f+uW7pkbSJ
         cwzWRoDP2nzqzprNGQb5J0Fqqf/lbryqogB6uWfL4ppV/G8f44c6a7VuIrdobMyVDg
         qKrwbM8ojWC3w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 02A6415403A3; Mon, 20 Mar 2023 18:11:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 11/14] tools/nolibc: Add statx() and make stat() rely on statx() if necessary
Date:   Mon, 20 Mar 2023 18:11:34 -0700
Message-Id: <20230321011137.51837-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
References: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.40.0.rc2

