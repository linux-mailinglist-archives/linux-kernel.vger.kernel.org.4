Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527D672D11A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbjFLUtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbjFLUrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:47:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E0E2960
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACDD662F12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C26C43327;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=3kluAJ78NXxdpTo6ccwYTg3Vy1h0KV1jojs/dLdw/p4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ray7trlhxNf6u6xWdY2QyahrNaycAxH2B3GGOIJ9T/7ng6GBQXBqg+XlfB6IubxPY
         zoFomVawpHhbXE0PbDJXzSdBX5ZGBq1WLAigivSc7ckUSr4f41omcDrX3uXiBB2GV6
         S3cDwlALZ88dbGzeTstLX2KSetup29fS867VpfcD9pUhK5oXEfWikaCQ9fx2irB8sl
         Y3t703NcJ6Nz5X4Kda+lEmlDviz7VoPnhtjX02nXL47fU3nFa0Xj3jysXO1jy7fuTJ
         18t3MBsb+lony/zEmPGBEwVp+UbcPalcc4CgLaZCQjfSSMtU+M7gH4ibCmtkNkuhI4
         +05wDlBsYi/Xg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 06B33CE3A7F; Mon, 12 Jun 2023 13:45:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Zhangjin Wu <falcon@tinylab.org>, Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 36/53] tools/nolibc: support nanoseconds in stat()
Date:   Mon, 12 Jun 2023 13:44:57 -0700
Message-Id: <20230612204514.292087-36-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

Keep backwards compatibility through unions.

The compatibility macros like

 #define st_atime st_atim.tv_sec

as documented in stat(3type) don't work for nolibc because it would
break with other stat-like structures that contain the field st_atime.

The stx_atime, stx_mtime, stx_ctime are in type of 'struct
statx_timestamp', which is incompatible with 'struct timespec', should
be converted explicitly.

    /* include/uapi/linux/stat.h */

    struct statx_timestamp {
    	__s64	tv_sec;
    	__u32	tv_nsec;
    	__s32	__reserved;
    };

    /* include/uapi/linux/time.h */
    struct timespec {
    	__kernel_old_time_t	tv_sec;		/* seconds */
    	long			tv_nsec;	/* nanoseconds */
    };

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/linux-riscv/3a3edd48-1ace-4c89-89e8-9c594dd1b3c9@t-8ch.de/
Co-authored-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
[wt: squashed Zhangjin & Thomas' patches into one to preserve "bisectability"]
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/sys.h                   | 66 +++++++++++---------
 tools/include/nolibc/types.h                 |  6 +-
 tools/testing/selftests/nolibc/nolibc-test.c | 23 +++++++
 3 files changed, 62 insertions(+), 33 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index c688b410f9e4..7836d7e7760d 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1161,23 +1161,26 @@ int sys_stat(const char *path, struct stat *buf)
 	long ret;
 
 	ret = sys_statx(AT_FDCWD, path, AT_NO_AUTOMOUNT, STATX_BASIC_STATS, &statx);
-	buf->st_dev     = ((statx.stx_dev_minor & 0xff)
-			  | (statx.stx_dev_major << 8)
-			  | ((statx.stx_dev_minor & ~0xff) << 12));
-	buf->st_ino     = statx.stx_ino;
-	buf->st_mode    = statx.stx_mode;
-	buf->st_nlink   = statx.stx_nlink;
-	buf->st_uid     = statx.stx_uid;
-	buf->st_gid     = statx.stx_gid;
-	buf->st_rdev    = ((statx.stx_rdev_minor & 0xff)
-			  | (statx.stx_rdev_major << 8)
-			  | ((statx.stx_rdev_minor & ~0xff) << 12));
-	buf->st_size    = statx.stx_size;
-	buf->st_blksize = statx.stx_blksize;
-	buf->st_blocks  = statx.stx_blocks;
-	buf->st_atime   = statx.stx_atime.tv_sec;
-	buf->st_mtime   = statx.stx_mtime.tv_sec;
-	buf->st_ctime   = statx.stx_ctime.tv_sec;
+	buf->st_dev          = ((statx.stx_dev_minor & 0xff)
+			       | (statx.stx_dev_major << 8)
+			       | ((statx.stx_dev_minor & ~0xff) << 12));
+	buf->st_ino          = statx.stx_ino;
+	buf->st_mode         = statx.stx_mode;
+	buf->st_nlink        = statx.stx_nlink;
+	buf->st_uid          = statx.stx_uid;
+	buf->st_gid          = statx.stx_gid;
+	buf->st_rdev         = ((statx.stx_rdev_minor & 0xff)
+			       | (statx.stx_rdev_major << 8)
+			       | ((statx.stx_rdev_minor & ~0xff) << 12));
+	buf->st_size         = statx.stx_size;
+	buf->st_blksize      = statx.stx_blksize;
+	buf->st_blocks       = statx.stx_blocks;
+	buf->st_atim.tv_sec  = statx.stx_atime.tv_sec;
+	buf->st_atim.tv_nsec = statx.stx_atime.tv_nsec;
+	buf->st_mtim.tv_sec  = statx.stx_mtime.tv_sec;
+	buf->st_mtim.tv_nsec = statx.stx_mtime.tv_nsec;
+	buf->st_ctim.tv_sec  = statx.stx_ctime.tv_sec;
+	buf->st_ctim.tv_nsec = statx.stx_ctime.tv_nsec;
 	return ret;
 }
 #else
@@ -1195,19 +1198,22 @@ int sys_stat(const char *path, struct stat *buf)
 #else
 #error Neither __NR_newfstatat nor __NR_stat defined, cannot implement sys_stat()
 #endif
-	buf->st_dev     = stat.st_dev;
-	buf->st_ino     = stat.st_ino;
-	buf->st_mode    = stat.st_mode;
-	buf->st_nlink   = stat.st_nlink;
-	buf->st_uid     = stat.st_uid;
-	buf->st_gid     = stat.st_gid;
-	buf->st_rdev    = stat.st_rdev;
-	buf->st_size    = stat.st_size;
-	buf->st_blksize = stat.st_blksize;
-	buf->st_blocks  = stat.st_blocks;
-	buf->st_atime   = stat.st_atime;
-	buf->st_mtime   = stat.st_mtime;
-	buf->st_ctime   = stat.st_ctime;
+	buf->st_dev          = stat.st_dev;
+	buf->st_ino          = stat.st_ino;
+	buf->st_mode         = stat.st_mode;
+	buf->st_nlink        = stat.st_nlink;
+	buf->st_uid          = stat.st_uid;
+	buf->st_gid          = stat.st_gid;
+	buf->st_rdev         = stat.st_rdev;
+	buf->st_size         = stat.st_size;
+	buf->st_blksize      = stat.st_blksize;
+	buf->st_blocks       = stat.st_blocks;
+	buf->st_atim.tv_sec  = stat.st_atime;
+	buf->st_atim.tv_nsec = stat.st_atime_nsec;
+	buf->st_mtim.tv_sec  = stat.st_mtime;
+	buf->st_mtim.tv_nsec = stat.st_mtime_nsec;
+	buf->st_ctim.tv_sec  = stat.st_ctime;
+	buf->st_ctim.tv_nsec = stat.st_ctime_nsec;
 	return ret;
 }
 #endif
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 15b0baffd336..f96e28bff4ba 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -198,9 +198,9 @@ struct stat {
 	off_t     st_size;    /* total size, in bytes */
 	blksize_t st_blksize; /* blocksize for file system I/O */
 	blkcnt_t  st_blocks;  /* number of 512B blocks allocated */
-	time_t    st_atime;   /* time of last access */
-	time_t    st_mtime;   /* time of last modification */
-	time_t    st_ctime;   /* time of last status change */
+	union { time_t st_atime; struct timespec st_atim; }; /* time of last access */
+	union { time_t st_mtime; struct timespec st_mtim; }; /* time of last modification */
+	union { time_t st_ctime; struct timespec st_ctim; }; /* time of last status change */
 };
 
 /* WARNING, it only deals with the 4096 first majors and 256 first minors */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 84a1b02eb6f9..0d76790ffb0d 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -501,6 +501,28 @@ static int test_fork(void)
 	}
 }
 
+static int test_stat_timestamps(void)
+{
+	struct stat st;
+
+	if (sizeof(st.st_atim.tv_sec) != sizeof(st.st_atime))
+		return 1;
+
+	if (stat("/proc/self/", &st))
+		return 1;
+
+	if (st.st_atim.tv_sec != st.st_atime || st.st_atim.tv_nsec > 1000000000)
+		return 1;
+
+	if (st.st_mtim.tv_sec != st.st_mtime || st.st_mtim.tv_nsec > 1000000000)
+		return 1;
+
+	if (st.st_ctim.tv_sec != st.st_ctime || st.st_ctim.tv_nsec > 1000000000)
+		return 1;
+
+	return 0;
+}
+
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
@@ -589,6 +611,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
 		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
 		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
+		CASE_TEST(stat_timestamps);   EXPECT_SYSZR(1, test_stat_timestamps()); break;
 		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
 		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;
 		CASE_TEST(unlink_blah);       EXPECT_SYSER(1, unlink("/proc/self/blah"), -1, ENOENT); break;
-- 
2.40.1

