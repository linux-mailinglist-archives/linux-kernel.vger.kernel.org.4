Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C2D68CC70
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjBGCJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBGCJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:09:55 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A5B2BF3A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 18:09:53 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id r18so9489607pgr.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 18:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpoaSRADxtOzIb7bPjBbBJEJdeXVedb+PzOMYN8weXw=;
        b=FQEbiqUxyI8fQeaMTCTDwQf3T1Nu/FuItXg+Yk022rm0CsG/08xoalp/qHQToTgD5R
         3BHlt5ItYP9ZtzHnUl2pkYJxBwK1B8RM476l/30Zas2wNH2cKcukRx3umW+or7m27DPy
         4Y1QDEQpI/9vVr0zWrPiDZ0tXIYl4cHmYwP1AifY+ibaT6CbPEBV1NZOSKiNjFbk5HLx
         9GJTemx4OMOl27aNyN6LKIfLIsPQfQBqVbc1lYtt4rRyTae2k7Eo/5APO55Cc1Etvnzx
         21I7IAYHp9tojzBZTfd6Dn1RvuVSqnB6/ypbrIl4Nizq2PE6v9ZalHcpTE4M4e3/kers
         2RhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpoaSRADxtOzIb7bPjBbBJEJdeXVedb+PzOMYN8weXw=;
        b=Id23jTog2suzINQbnQ0SxYE6Bu1fdBYgyPkZZ3Ibnirp1/pXb63NGSv2njVPJIYwbE
         zxt+iOSTFsURCo0ikHsv/A7QpJUK5W8waBs1csuxFEeJQvdgtEo9ZPH152bB7YYxXk+7
         w15bFqUefc6h0sP2kjZ0dwpfqgDGe2U6urT1xDW8IztZk0vf+evVZzcR4grpvrDDo2+8
         zU6eqdusjSsB1DTT0+i1gWDMRmCQaSLz6O+b0Ct7W0vwYThIORgrI3WOSlUkZvstJMsY
         h0Tk2Rs0yB2yJ2YaSzPTA4YlZEWLQPd3f4bdIceiRivEfPZtU0QeYUh6rEqYApfDPxzQ
         1GgA==
X-Gm-Message-State: AO0yUKVW1n10x3m/Un0AiZjWOciwV7xN3CgRovi+BMDjjZbBxJdprj3N
        edf6+dUkxFsnfZwZ0r9U5uY=
X-Google-Smtp-Source: AK7set/G5YL/cRNecJlI0OL5X9JU2dAif/RQpv7rVn7Jf1IZdM9rGPGLcauFF8rjhePoJiJZymLKRQ==
X-Received: by 2002:aa7:9a0d:0:b0:593:b880:211f with SMTP id w13-20020aa79a0d000000b00593b880211fmr1547075pfj.26.1675735793385;
        Mon, 06 Feb 2023 18:09:53 -0800 (PST)
Received: from localhost.localdomain ([112.20.108.204])
        by smtp.gmail.com with ESMTPSA id d198-20020a621dcf000000b00593225b379dsm7843765pfd.106.2023.02.06.18.09.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Feb 2023 18:09:52 -0800 (PST)
From:   chris.chenfeiyang@gmail.com
X-Google-Original-From: chenfeiyang@loongson.cn
To:     w@1wt.eu, paulmck@kernel.org
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, chenhuacai@kernel.org,
        jiaxun.yang@flygoat.com, arnd@arndb.de,
        chris.chenfeiyang@gmail.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] nolibc: Add statx() support to implement sys_stat()
Date:   Tue,  7 Feb 2023 10:09:40 +0800
Message-Id: <1af05c1441e9f96870be1cc20b1162e3f5043b2e.1675734681.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675734681.git.chenfeiyang@loongson.cn>
References: <cover.1675734681.git.chenfeiyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feiyang Chen <chenfeiyang@loongson.cn>

Neither __NR_newfstatat nor __NR_stat is defined on new architecture
like LoongArch, but we can use statx() to implement sys_stat().

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 tools/include/nolibc/sys.h   | 36 +++++++++++++++++++++++++---
 tools/include/nolibc/types.h | 46 ++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index b5f8cd35c03b..7ff9b401008a 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1054,6 +1054,7 @@ pid_t setsid(void)
  * Warning: the struct stat's layout is arch-dependent.
  */
 
+#if defined(__NR_newfstatat) || defined(__NR_stat)
 static __attribute__((unused))
 int sys_stat(const char *path, struct stat *buf)
 {
@@ -1063,10 +1064,8 @@ int sys_stat(const char *path, struct stat *buf)
 #ifdef __NR_newfstatat
 	/* only solution for arm64 */
 	ret = my_syscall4(__NR_newfstatat, AT_FDCWD, path, &stat, 0);
-#elif defined(__NR_stat)
+#else /* __NR_stat */
 	ret = my_syscall2(__NR_stat, path, &stat);
-#else
-#error Neither __NR_newfstatat nor __NR_stat defined, cannot implement sys_stat()
 #endif
 	buf->st_dev     = stat.st_dev;
 	buf->st_ino     = stat.st_ino;
@@ -1083,6 +1082,37 @@ int sys_stat(const char *path, struct stat *buf)
 	buf->st_ctime   = stat.st_ctime;
 	return ret;
 }
+#elif defined(__NR_statx)
+/* only solution for loongarch */
+static __attribute__((unused))
+int sys_stat(const char *path, struct stat *buf)
+{
+	struct statx statx;
+	long ret;
+
+	ret = my_syscall5(__NR_statx, AT_FDCWD, path, 0, STATX_BASIC_STATS, &statx);
+	buf->st_dev     = ((statx.stx_dev_minor & 0xff)
+			  | (statx.stx_dev_major << 8)
+			  | ((statx.stx_dev_minor & ~0xff) << 12));
+	buf->st_ino     = statx.stx_ino;
+	buf->st_mode    = statx.stx_mode;
+	buf->st_nlink   = statx.stx_nlink;
+	buf->st_uid     = statx.stx_uid;
+	buf->st_gid     = statx.stx_gid;
+	buf->st_rdev    = ((statx.stx_rdev_minor & 0xff)
+			  | (statx.stx_rdev_major << 8) |
+			  ((statx.stx_rdev_minor & ~0xff) << 12));
+	buf->st_size    = statx.stx_size;
+	buf->st_blksize = statx.stx_blksize;
+	buf->st_blocks  = statx.stx_blocks;
+	buf->st_atime   = statx.stx_atime.tv_sec;
+	buf->st_mtime   = statx.stx_mtime.tv_sec;
+	buf->st_ctime   = statx.stx_ctime.tv_sec;
+	return ret;
+}
+#else
+#error None of __NR_newfstatat, __NR_stat, nor __NR_statx defined, cannot implement sys_stat()
+#endif
 
 static __attribute__((unused))
 int stat(const char *path, struct stat *buf)
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index fbbc0e68c001..9b244af1ec2c 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -193,6 +193,52 @@ struct stat {
 	time_t    st_ctime;   /* time of last status change */
 };
 
+/* for statx() */
+#ifndef STATX_BASIC_STATS
+#define STATX_BASIC_STATS (0x000007ffU)
+#endif
+
+struct statx_timestamp {
+	__s64	tv_sec;
+	__u32	tv_nsec;
+	__s32	__reserved;
+};
+
+struct statx {
+	/* 0x00 */
+	__u32	stx_mask;	/* What results were written [uncond] */
+	__u32	stx_blksize;	/* Preferred general I/O size [uncond] */
+	__u64	stx_attributes;	/* Flags conveying information about the file [uncond] */
+	/* 0x10 */
+	__u32	stx_nlink;	/* Number of hard links */
+	__u32	stx_uid;	/* User ID of owner */
+	__u32	stx_gid;	/* Group ID of owner */
+	__u16	stx_mode;	/* File mode */
+	__u16	__spare0[1];
+	/* 0x20 */
+	__u64	stx_ino;	/* Inode number */
+	__u64	stx_size;	/* File size */
+	__u64	stx_blocks;	/* Number of 512-byte blocks allocated */
+	__u64	stx_attributes_mask; /* Mask to show what's supported in stx_attributes */
+	/* 0x40 */
+	struct statx_timestamp	stx_atime;	/* Last access time */
+	struct statx_timestamp	stx_btime;	/* File creation time */
+	struct statx_timestamp	stx_ctime;	/* Last attribute change time */
+	struct statx_timestamp	stx_mtime;	/* Last data modification time */
+	/* 0x80 */
+	__u32	stx_rdev_major;	/* Device ID of special file [if bdev/cdev] */
+	__u32	stx_rdev_minor;
+	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
+	__u32	stx_dev_minor;
+	/* 0x90 */
+	__u64	stx_mnt_id;
+	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
+	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
+	/* 0xa0 */
+	__u64	__spare3[12];	/* Spare space for future expansion */
+	/* 0x100 */
+};
+
 /* WARNING, it only deals with the 4096 first majors and 256 first minors */
 #define makedev(major, minor) ((dev_t)((((major) & 0xfff) << 8) | ((minor) & 0xff)))
 #define major(dev) ((unsigned int)(((dev) >> 8) & 0xfff))
-- 
2.39.0

