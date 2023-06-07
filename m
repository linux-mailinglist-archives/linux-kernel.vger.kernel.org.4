Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778667262CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbjFGO3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbjFGO3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:29:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403F31AE;
        Wed,  7 Jun 2023 07:29:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C75E06100A;
        Wed,  7 Jun 2023 14:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D04C433EF;
        Wed,  7 Jun 2023 14:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686148175;
        bh=1oDAIKxqgonf8S4LzAAuCNQtNjMJBLSiZTFS9TB1jIU=;
        h=From:To:Cc:Subject:Date:From;
        b=YkDMsm6w7qGxO3FxoqRiqvl4sX8dmEbs9oajMHBUjJdvy3sNOV0h2g1z6zYtoaO6y
         F+VUHFf4V1ReVfsVnktrUVqJgszeG8b+ocxybxUNsPXGoC+Tx0uYyPaUwcuAZ7+gRZ
         69hKhJAhjFL1MNCc92xGVPP8ICfnBRUbzuQuZiqQFWelr4eV06qitlMbneZXW5uWQz
         uFs4R5l7UmAJHmF0CTYoEDhm7hSq4oIv8Wa3FvJAHqqzCH0/6uHO773Ly1bz/61YJZ
         oAczK+G2I9Psnt7Jv/HeFkaqBTL0VLmntQsqwOfzvvr/3tW3HDpwV5bcVgkMKJhvFj
         PEU5tC0IK0smQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH] syscalls: add sys_ni_posix_timers prototype
Date:   Wed,  7 Jun 2023 16:28:45 +0200
Message-Id: <20230607142925.3126422-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

The sys_ni_posix_timers() definition causes a warning when
the declaration is missing, so this needs to be added
along with the normal syscalls, outside of the #ifdef.

kernel/time/posix-stubs.c:26:17: error: no previous prototype for 'sys_ni_posix_timers' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I missed sending this out in the initial submission of my Wmissing-prototype patches
---
 arch/alpha/kernel/osf_sys.c | 2 --
 include/linux/syscalls.h    | 1 +
 kernel/time/posix-stubs.c   | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 2a9a877a05083..d98701ee36c6a 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1014,8 +1014,6 @@ SYSCALL_DEFINE2(osf_settimeofday, struct timeval32 __user *, tv,
 	return do_sys_settimeofday64(tv ? &kts : NULL, tz ? &ktz : NULL);
 }
 
-asmlinkage long sys_ni_posix_timers(void);
-
 SYSCALL_DEFINE2(osf_utimes, const char __user *, filename,
 		struct timeval32 __user *, tvs)
 {
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 4627b9cf4b4d9..712f4e1dc6a69 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1286,6 +1286,7 @@ asmlinkage long sys_ni_syscall(void);
 
 #endif /* CONFIG_ARCH_HAS_SYSCALL_WRAPPER */
 
+asmlinkage long sys_ni_posix_timers(void);
 
 /*
  * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 828aeecbd1e8a..39769b2d1005e 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -16,6 +16,7 @@
 #include <linux/posix-timers.h>
 #include <linux/time_namespace.h>
 #include <linux/compat.h>
+#include <linux/syscalls.h>
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 /* Architectures may override SYS_NI and COMPAT_SYS_NI */
-- 
2.39.2

