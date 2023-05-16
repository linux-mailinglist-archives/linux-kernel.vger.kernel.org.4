Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A907052B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjEPPsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjEPPr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:47:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3972819B0;
        Tue, 16 May 2023 08:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67E8363B8E;
        Tue, 16 May 2023 15:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1167C433EF;
        Tue, 16 May 2023 15:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684252027;
        bh=uSZFgOHv66zf2ErLT4Tl0oonO69PeMRAH5tXtTaemjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rt+0T6iwCqnI2DBJU+G1SPBWeanZBPT/dGs+wqihGalu5OX13iSDeaqKgDGb5pFPa
         U7Z1uOuF4dSBL0xetsta1vCyca14RNIUruKFekUByNfK26cGrqgP0LajoCoMH8GzLO
         MEvHHuJ5ti2rfPGF5FP54BuAyUw5j6KYXo8t5CpnwV5poHm3aiqC0o3lJuLDPYnTwj
         W5/513T1c50zUPEnx8CERIcFObNqM5dIfgHUezSPmK4+Y1iaa4Pid/cwkt/OOWTwD8
         hAxlWZIx+Om6TMEjQenC4JZ7MdgY8qo9AAvYXKs+ncVkKht30TZ+Exd1jNqzTMej0R
         OOY/Y0jtpz/4g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 14/16] ARM: add missing syscall prototypes
Date:   Tue, 16 May 2023 17:46:03 +0200
Message-Id: <20230516154605.517690-15-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516154605.517690-1-arnd@kernel.org>
References: <20230516154605.517690-1-arnd@kernel.org>
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

All architecture-independent system calls have prototypes in
include/linux/syscalls.h, but there are a few that only exist
on arm or that take the pt_regs directly. These cause a W=1
warning such as:

arch/arm/kernel/signal.c:186:16: error: no previous prototype for 'sys_sigreturn' [-Werror=missing-prototypes]
arch/arm/kernel/signal.c:216:16: error: no previous prototype for 'sys_rt_sigreturn' [-Werror=missing-prototypes]
arch/arm/kernel/sys_arm.c:32:17: error: no previous prototype for 'sys_arm_fadvise64_64' [-Werror=missing-prototypes]

Add prototypes for all custom syscalls on arm and add them
to asm/syscalls.h.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/syscalls.h   | 51 +++++++++++++++++++++++++++++++
 arch/arm/kernel/signal.c          |  1 +
 arch/arm/kernel/sys_arm.c         |  1 +
 arch/arm/kernel/sys_oabi-compat.c |  2 ++
 4 files changed, 55 insertions(+)
 create mode 100644 arch/arm/include/asm/syscalls.h

diff --git a/arch/arm/include/asm/syscalls.h b/arch/arm/include/asm/syscalls.h
new file mode 100644
index 000000000000..5912e7cffa6a
--- /dev/null
+++ b/arch/arm/include/asm/syscalls.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_SYSCALLS_H
+#define __ASM_SYSCALLS_H
+
+#include <linux/linkage.h>
+#include <linux/types.h>
+
+struct pt_regs;
+asmlinkage int sys_sigreturn(struct pt_regs *regs);
+asmlinkage int sys_rt_sigreturn(struct pt_regs *regs);
+asmlinkage long sys_arm_fadvise64_64(int fd, int advice,
+				     loff_t offset, loff_t len);
+
+struct oldabi_stat64;
+asmlinkage long sys_oabi_stat64(const char __user * filename,
+				struct oldabi_stat64 __user * statbuf);
+asmlinkage long sys_oabi_lstat64(const char __user * filename,
+				 struct oldabi_stat64 __user * statbuf);
+asmlinkage long sys_oabi_fstat64(unsigned long fd,
+				 struct oldabi_stat64 __user * statbuf);
+asmlinkage long sys_oabi_fstatat64(int dfd,
+				   const char __user *filename,
+				   struct oldabi_stat64  __user *statbuf,
+				   int flag);
+asmlinkage long sys_oabi_fcntl64(unsigned int fd, unsigned int cmd,
+				 unsigned long arg);
+struct oabi_epoll_event;
+asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
+				   struct oabi_epoll_event __user *event);
+struct oabi_sembuf;
+struct old_timespec32;
+asmlinkage long sys_oabi_semtimedop(int semid,
+				    struct oabi_sembuf __user *tsops,
+				    unsigned nsops,
+				    const struct old_timespec32 __user *timeout);
+asmlinkage long sys_oabi_semop(int semid, struct oabi_sembuf __user *tsops,
+			       unsigned nsops);
+asmlinkage int sys_oabi_ipc(uint call, int first, int second, int third,
+			    void __user *ptr, long fifth);
+struct sockaddr;
+asmlinkage long sys_oabi_bind(int fd, struct sockaddr __user *addr, int addrlen);
+asmlinkage long sys_oabi_connect(int fd, struct sockaddr __user *addr, int addrlen);
+asmlinkage long sys_oabi_sendto(int fd, void __user *buff,
+				size_t len, unsigned flags,
+				struct sockaddr __user *addr,
+				int addrlen);
+struct user_msghdr;
+asmlinkage long sys_oabi_sendmsg(int fd, struct user_msghdr __user *msg, unsigned flags);
+asmlinkage long sys_oabi_socketcall(int call, unsigned long __user *args);
+
+#endif
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index e07f359254c3..8d0afa11bed5 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -18,6 +18,7 @@
 #include <asm/traps.h>
 #include <asm/unistd.h>
 #include <asm/vfp.h>
+#include <asm/syscalls.h>
 
 #include "signal.h"
 
diff --git a/arch/arm/kernel/sys_arm.c b/arch/arm/kernel/sys_arm.c
index a5f183cfecb1..0141e9bb02e8 100644
--- a/arch/arm/kernel/sys_arm.c
+++ b/arch/arm/kernel/sys_arm.c
@@ -24,6 +24,7 @@
 #include <linux/ipc.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
+#include <asm/syscalls.h>
 
 /*
  * Since loff_t is a 64 bit type we avoid a lot of ABI hassle
diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index 006163195d67..d00f4040a9f5 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -10,6 +10,8 @@
  *  Copyright:	MontaVista Software, Inc.
  */
 
+#include <asm/syscalls.h>
+
 /*
  * The legacy ABI and the new ARM EABI have different rules making some
  * syscalls incompatible especially with structure arguments.
-- 
2.39.2

