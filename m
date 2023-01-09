Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BBD66207E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbjAIIqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbjAIIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:45:54 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCE50140F9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:42:50 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3098gCbA027423;
        Mon, 9 Jan 2023 09:42:12 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 04/22] tools/nolibc: remove local definitions of O_* flags for open/fcntl
Date:   Mon,  9 Jan 2023 09:41:50 +0100
Message-Id: <20230109084208.27355-5-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230109084208.27355-1-w@1wt.eu>
References: <20230109084208.27355-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The historic nolibc code did not include asm/fcntl.h and had to define
the various O_RDWR etc macros in each arch-specific file (since such
values differ between certain archs). This was found at least once to
induce bugs due to wrong definitions. Let's get rid of all of them and
include asm/nolibc.h from sys.h instead. This was verified to work
properly on all supported architectures.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-aarch64.h | 12 ------------
 tools/include/nolibc/arch-arm.h     | 12 ------------
 tools/include/nolibc/arch-i386.h    | 12 ------------
 tools/include/nolibc/arch-mips.h    | 12 ------------
 tools/include/nolibc/arch-riscv.h   | 12 ------------
 tools/include/nolibc/arch-s390.h    | 12 ------------
 tools/include/nolibc/arch-x86_64.h  | 12 ------------
 tools/include/nolibc/sys.h          |  1 +
 8 files changed, 1 insertion(+), 84 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 4d263661411f..f480993159ec 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -7,18 +7,6 @@
 #ifndef _NOLIBC_ARCH_AARCH64_H
 #define _NOLIBC_ARCH_AARCH64_H
 
-/* O_* macros for fcntl/open are architecture-specific */
-#define O_RDONLY            0
-#define O_WRONLY            1
-#define O_RDWR              2
-#define O_CREAT          0x40
-#define O_EXCL           0x80
-#define O_NOCTTY        0x100
-#define O_TRUNC         0x200
-#define O_APPEND        0x400
-#define O_NONBLOCK      0x800
-#define O_DIRECTORY    0x4000
-
 /* The struct returned by the newfstatat() syscall. Differs slightly from the
  * x86_64's stat one by field ordering, so be careful.
  */
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index ef94df2d93d5..48bd95492c87 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -7,18 +7,6 @@
 #ifndef _NOLIBC_ARCH_ARM_H
 #define _NOLIBC_ARCH_ARM_H
 
-/* O_* macros for fcntl/open are architecture-specific */
-#define O_RDONLY            0
-#define O_WRONLY            1
-#define O_RDWR              2
-#define O_CREAT          0x40
-#define O_EXCL           0x80
-#define O_NOCTTY        0x100
-#define O_TRUNC         0x200
-#define O_APPEND        0x400
-#define O_NONBLOCK      0x800
-#define O_DIRECTORY    0x4000
-
 /* The struct returned by the stat() syscall, 32-bit only, the syscall returns
  * exactly 56 bytes (stops before the unused array). In big endian, the format
  * differs as devices are returned as short only.
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index b1bed2d87f74..ef2a836ee667 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -7,18 +7,6 @@
 #ifndef _NOLIBC_ARCH_I386_H
 #define _NOLIBC_ARCH_I386_H
 
-/* O_* macros for fcntl/open are architecture-specific */
-#define O_RDONLY            0
-#define O_WRONLY            1
-#define O_RDWR              2
-#define O_CREAT          0x40
-#define O_EXCL           0x80
-#define O_NOCTTY        0x100
-#define O_TRUNC         0x200
-#define O_APPEND        0x400
-#define O_NONBLOCK      0x800
-#define O_DIRECTORY   0x10000
-
 /* The struct returned by the stat() syscall, 32-bit only, the syscall returns
  * exactly 56 bytes (stops before the unused array).
  */
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 11270ef25ea5..a3764f6d267e 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -7,18 +7,6 @@
 #ifndef _NOLIBC_ARCH_MIPS_H
 #define _NOLIBC_ARCH_MIPS_H
 
-/* O_* macros for fcntl/open are architecture-specific */
-#define O_RDONLY            0
-#define O_WRONLY            1
-#define O_RDWR              2
-#define O_APPEND       0x0008
-#define O_NONBLOCK     0x0080
-#define O_CREAT        0x0100
-#define O_TRUNC        0x0200
-#define O_EXCL         0x0400
-#define O_NOCTTY       0x0800
-#define O_DIRECTORY   0x10000
-
 /* The struct returned by the stat() syscall. 88 bytes are returned by the
  * syscall.
  */
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index bee769e6885c..c2b5db383d96 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -7,18 +7,6 @@
 #ifndef _NOLIBC_ARCH_RISCV_H
 #define _NOLIBC_ARCH_RISCV_H
 
-/* O_* macros for fcntl/open are architecture-specific */
-#define O_RDONLY            0
-#define O_WRONLY            1
-#define O_RDWR              2
-#define O_CREAT          0x40
-#define O_EXCL           0x80
-#define O_NOCTTY        0x100
-#define O_TRUNC         0x200
-#define O_APPEND        0x400
-#define O_NONBLOCK      0x800
-#define O_DIRECTORY   0x10000
-
 struct sys_stat_struct {
 	unsigned long	st_dev;		/* Device.  */
 	unsigned long	st_ino;		/* File serial number.  */
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 2c0b8847c050..b58f64d47b82 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -7,18 +7,6 @@
 #define _NOLIBC_ARCH_S390_H
 #include <asm/unistd.h>
 
-/* O_* macros for fcntl/open are architecture-specific */
-#define O_RDONLY            0
-#define O_WRONLY            1
-#define O_RDWR              2
-#define O_CREAT          0x40
-#define O_EXCL           0x80
-#define O_NOCTTY        0x100
-#define O_TRUNC         0x200
-#define O_APPEND        0x400
-#define O_NONBLOCK      0x800
-#define O_DIRECTORY   0x10000
-
 /* The struct returned by the stat() syscall, equivalent to stat64(). The
  * syscall returns 116 bytes and stops in the middle of __unused.
  */
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index c70a84612a9e..8d482505c347 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -7,18 +7,6 @@
 #ifndef _NOLIBC_ARCH_X86_64_H
 #define _NOLIBC_ARCH_X86_64_H
 
-/* O_* macros for fcntl/open are architecture-specific */
-#define O_RDONLY            0
-#define O_WRONLY            1
-#define O_RDWR              2
-#define O_CREAT          0x40
-#define O_EXCL           0x80
-#define O_NOCTTY        0x100
-#define O_TRUNC         0x200
-#define O_APPEND        0x400
-#define O_NONBLOCK      0x800
-#define O_DIRECTORY   0x10000
-
 /* The struct returned by the stat() syscall, equivalent to stat64(). The
  * syscall returns 116 bytes and stops in the middle of __unused.
  */
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index a42d7c405bdc..47bf67668860 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -11,6 +11,7 @@
 #include "std.h"
 
 /* system includes */
+#include <asm/fcntl.h>   // for O_*
 #include <asm/unistd.h>
 #include <asm/signal.h>  // for SIGCHLD
 #include <asm/ioctls.h>
-- 
2.17.5

