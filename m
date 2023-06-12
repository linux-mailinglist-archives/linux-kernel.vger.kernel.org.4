Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A81A72D0FF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbjFLUsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbjFLUrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:47:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FE42943
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76B8E62EFB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9696CC433AF;
        Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602716;
        bh=oC2jzfNDP3qXofDBVXlAqaNEq75nX/bGi7jR4v97zaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rp57k+kruEmbcOONSC0w6AF6KVWffRId/t95pE3udygnwZ5N50WYldwWdIBSJkpWD
         lTwzdRlcY02MhuwOah7Da+oDyOVilf+uasSrQMjnF/3FCmqAWFm0AJ+OeO8xFwymG6
         AcZXbmflqTQl5W9sGG7um/Lgq2UdQlKIG8Ktbw5OtNUNfWNVsCCP0PXNBtmYHXbUr6
         hwuiqPFxXiDuKZbqhn94XvSt241uYv6dSoPpb4IcIg5G68Ig/kh1aJePhdJbvotND/
         pMZaeNpnSxbOSO1si3aZL3Opx3I1pHpfZYSvfZ4A3QDKt7z/d0Ts+r1BPl9OAxSk9X
         9H0CsrT9ix0Pw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C637DCE3A53; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Sven Schnelle <svens@linux.ibm.com>, Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 13/53] tools/nolibc: s390: provide custom implementation for sys_fork
Date:   Mon, 12 Jun 2023 13:44:34 -0700
Message-Id: <20230612204514.292087-13-paulmck@kernel.org>
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

On s390 the first two arguments to the clone() syscall are swapped,
as documented in clone(2).

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Cc: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/arch-s390.h | 9 +++++++++
 tools/include/nolibc/sys.h       | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index c62ee2472407..a738e7f3f8e8 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -5,6 +5,7 @@
 
 #ifndef _NOLIBC_ARCH_S390_H
 #define _NOLIBC_ARCH_S390_H
+#include <asm/signal.h>
 #include <asm/unistd.h>
 
 /* The struct returned by the stat() syscall, equivalent to stat64(). The
@@ -223,4 +224,12 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 	return (void *)my_syscall1(__NR_mmap, &args);
 }
 #define sys_mmap sys_mmap
+
+static __attribute__((unused))
+pid_t sys_fork(void)
+{
+	return my_syscall5(__NR_clone, 0, SIGCHLD, 0, 0, 0);
+}
+#define sys_fork sys_fork
+
 #endif /* _NOLIBC_ARCH_S390_H */
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 1b9b91cd8b57..60dffb1cbf96 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -336,6 +336,7 @@ void exit(int status)
  * pid_t fork(void);
  */
 
+#ifndef sys_fork
 static __attribute__((unused))
 pid_t sys_fork(void)
 {
@@ -351,6 +352,7 @@ pid_t sys_fork(void)
 #error Neither __NR_clone nor __NR_fork defined, cannot implement sys_fork()
 #endif
 }
+#endif
 
 static __attribute__((unused))
 pid_t fork(void)
-- 
2.40.1

