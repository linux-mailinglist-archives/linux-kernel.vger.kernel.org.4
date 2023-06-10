Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E93072ACCA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjFJQHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 12:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjFJQHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 12:07:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939A89E;
        Sat, 10 Jun 2023 09:07:21 -0700 (PDT)
Date:   Sat, 10 Jun 2023 16:07:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686413232;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AvwYa+1b+gn3pQXI5Z99TCOGlSyQIK1HBe30/jd1Z+Q=;
        b=pvjFyJivhN4uAWfYQmukt0u+GS2fjgzS8u/TrHL4PovjpM8aAftOaQwXPrl+ozxQJeJCi2
        LXg+KWxtLi/2wc7stxMmnVPYhz9dj/HITi3U0ZUKcoxIiE1QqSJfdHonuA+5k8M1YxxEbQ
        FHDQQUZA6pXDo+6GmKS87IQcYJc7wyNdEslwpttxowWW0KbMPt6gdn+8gAD8rv4mm9l6f0
        05dwH8HlpvUGIyh7DnKPXHxtyT43bsR7L2vJ/gmBhUAuYfEt5NrLaAzyZKuQu5ldf6HRI3
        frCRSU1H1a3JunFJxazT+KdTUwa5SVnoFc+2mHBrM02tx3jmLu3RDtl/R8qyYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686413232;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AvwYa+1b+gn3pQXI5Z99TCOGlSyQIK1HBe30/jd1Z+Q=;
        b=fFl99LW+eDGiuTmU5lP39T73ZicCuZ2wPPS41L9mtsWerBfARzRjY4rj+t6IEtvbliJO+/
        nHDHdMENDtiixQAQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Add sys_ni_posix_timers() prototype
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230607142925.3126422-1-arnd@kernel.org>
References: <20230607142925.3126422-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <168641323120.404.166067010257758345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ad0334ffa4f9ae3dacfd89dae578df97f18a5203
Gitweb:        https://git.kernel.org/tip/ad0334ffa4f9ae3dacfd89dae578df97f18a5203
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 07 Jun 2023 16:28:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 10 Jun 2023 17:57:30 +02:00

posix-timers: Add sys_ni_posix_timers() prototype

The sys_ni_posix_timers() definition causes a warning when the declaration
is missing, so this needs to be added along with the normal syscalls,
outside of the #ifdef.

kernel/time/posix-stubs.c:26:17: error: no previous prototype for 'sys_ni_posix_timers' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230607142925.3126422-1-arnd@kernel.org

---
 arch/alpha/kernel/osf_sys.c | 2 --
 include/linux/syscalls.h    | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 2a9a877..d98701e 100644
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
index 33a0ee3..24871f8 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1280,6 +1280,7 @@ asmlinkage long sys_ni_syscall(void);
 
 #endif /* CONFIG_ARCH_HAS_SYSCALL_WRAPPER */
 
+asmlinkage long sys_ni_posix_timers(void);
 
 /*
  * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.
