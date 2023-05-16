Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86B57052AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjEPPr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjEPPrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:47:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0004F7EC4;
        Tue, 16 May 2023 08:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF61163BA3;
        Tue, 16 May 2023 15:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F63C4331D;
        Tue, 16 May 2023 15:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684251991;
        bh=6a4E3hOiBRNKm/YMm19jLYIBcL0Rao1gaj6adOyNw3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sxSO5s1RLwegkfthAeCa+WE9I4fFrht8PmKA36QXkndW/TCG288ZCdOB08/bAT4vG
         GmclOMl9Z2rdOGDS2k7j/tSZ93+cbrmb6yvIcTFP1Bum86FrHxdQEZgpODOflL2Q46
         tyfSk0Oc65tXezH+YTfDQY6nXIURh8n7qCHYaq65FtXKX43DlE9b2yOpIkStHO/eoD
         fB7dnQjIsF/Y01PffnYMc4OChQWX17gfK4kOR2kWc5Zj8xwsPS0rNzl3/idXx/CLYs
         GAMMBMMCMkBObjh5gv8Wjh3YDKb5pBPmW613+YuEo9Ci7L+xaeNzU67YbxH86PszAM
         F2jOvpboazMhg==
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
Subject: [PATCH 04/16] ARM: vdso: add missing prototypes
Date:   Tue, 16 May 2023 17:45:53 +0200
Message-Id: <20230516154605.517690-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516154605.517690-1-arnd@kernel.org>
References: <20230516154605.517690-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The __vdso_clock_* functions have no prototype, and the
__eabi_unwind_cpp_pr* functions have a prototype in a header that is
not included before the definition:

arch/arm/vdso/vgettimeofday.c:10:5: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]
arch/arm/vdso/vgettimeofday.c:16:5: error: no previous prototype for '__vdso_clock_gettime64' [-Werror=missing-prototypes]
arch/arm/vdso/vgettimeofday.c:22:5: error: no previous prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]
arch/arm/vdso/vgettimeofday.c:28:5: error: no previous prototype for '__vdso_clock_getres' [-Werror=missing-prototypes]
arch/arm/vdso/vgettimeofday.c:36:6: error: no previous prototype for '__aeabi_unwind_cpp_pr0' [-Werror=missing-prototypes]
arch/arm/vdso/vgettimeofday.c:40:6: error: no previous prototype for '__aeabi_unwind_cpp_pr1' [-Werror=missing-prototypes]
arch/arm/vdso/vgettimeofday.c:44:6: error: no previous prototype for '__aeabi_unwind_cpp_pr2' [-Werror=missing-prototypes]

Add the prototypes in an appropriate header and ensure that
both are included here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/vdso.h   | 5 +++++
 arch/arm/vdso/vgettimeofday.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/include/asm/vdso.h b/arch/arm/include/asm/vdso.h
index 5b85889f82ee..422c3afa806a 100644
--- a/arch/arm/include/asm/vdso.h
+++ b/arch/arm/include/asm/vdso.h
@@ -24,6 +24,11 @@ static inline void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
 
 #endif /* CONFIG_VDSO */
 
+int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts);
+int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts);
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
+int __vdso_clock_getres(clockid_t clock_id, struct old_timespec32 *res);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 1976c6f325a4..a003beacac76 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -6,6 +6,8 @@
  */
 #include <linux/time.h>
 #include <linux/types.h>
+#include <asm/vdso.h>
+#include <asm/unwind.h>
 
 int __vdso_clock_gettime(clockid_t clock,
 			 struct old_timespec32 *ts)
-- 
2.39.2

