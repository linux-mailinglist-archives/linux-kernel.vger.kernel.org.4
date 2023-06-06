Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48DB724679
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbjFFOkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238072AbjFFOjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:39:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FF91733
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:38:22 -0700 (PDT)
Message-ID: <20230606142032.937376270@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=X5/mGdJCXgY2x3hbkFl+DcjtQwggjg9WtZyekAGVZm8=;
        b=ccXf2YoXP6bmaxL+24Dyu26Jc5EOOnCAU1rwP+7LXMT7NQbtNp7ZqfMgccuylPEE0zuJQA
        TNAeh3IEOxnWArQhCcIkCwzOqXAupwepk/pBSqxzynyZnwyXdq8wUOI8dGHcBkmw/WGtaX
        31Zjsh/Ky9/zJpIxwq/2+9AxNR0ZhRMgUwrRGNxBzv+3OtPc6q/vooEleyMWh2QzGNhHWo
        1ABi8DAkkAwxPqSo8kS8mUWPcoM1BGVzcn2SFn2eyV2YdqZsYdPjjptknUHkSKEXQAsAAc
        FbO9C2bl+unpCOF5qvDuxGbl3TG0/3Fdd3eqrwkK8/FkbQqJsswN1HyfD8VWFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=X5/mGdJCXgY2x3hbkFl+DcjtQwggjg9WtZyekAGVZm8=;
        b=X788qT6ZGfh/f6eNpLqqkZA8SRx6637+/DkoOQMnZ6oUQzeYu5Y1kc3+Q2QeVwqyIknaG3
        mBo/xp4ickMo10AA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [patch 34/45] signal: Add sys_private_ptr to siginfo::_sifields::_timer
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:38:12 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On signal delivery collect_signal() copies the queued siginfo into a caller
provided siginfo struct. The posix timer signal delivery code then uses
siginfo::si_tid to lookup the timer in the hash table.

That's required today as the timer and the sigqueue are separate entities
and have different life time rules.

The sigqueue will be embedded into struct k_itimer to address a few issues
in the posix timer signal handling, which means the life time rules are
not longer separate, which can spare the lookup.

Due to locking rules posixtimer_deliver_signal() cannot be invoked from
collect_signal(). The timer pointer could be handed down from
collect_signal() to dequeue_signal(), but that's just overhead for the
non-posixtimer case.

There is room in the _sifields union for an extra pointer which will be
used later for storing the timer pointer. This field is copied with siginfo
and cleared before the info is delivered to userspace like the existing
si_sys_private field.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/signal_32.c        |    2 +-
 arch/x86/kernel/signal_64.c        |    2 +-
 include/uapi/asm-generic/siginfo.h |    2 ++
 kernel/time/posix-timers.c         |    4 +++-
 4 files changed, 7 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -456,7 +456,7 @@ CHECK_SI_OFFSET(_timer);
 /* compat_siginfo_t doesn't have si_sys_private */
 CHECK_SI_SIZE  (_timer, 3*sizeof(int));
 #else
-CHECK_SI_SIZE  (_timer, 4*sizeof(int));
+CHECK_SI_SIZE  (_timer, 5*sizeof(int));
 #endif
 static_assert(offsetof(siginfo32_t, si_tid)     == 0x0C);
 static_assert(offsetof(siginfo32_t, si_overrun) == 0x10);
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -450,7 +450,7 @@ static_assert(offsetof(siginfo_t, si_pid
 static_assert(offsetof(siginfo_t, si_uid) == 0x14);
 
 CHECK_SI_OFFSET(_timer);
-CHECK_SI_SIZE  (_timer, 6*sizeof(int));
+CHECK_SI_SIZE  (_timer, 8*sizeof(int));
 static_assert(offsetof(siginfo_t, si_tid)     == 0x10);
 static_assert(offsetof(siginfo_t, si_overrun) == 0x14);
 static_assert(offsetof(siginfo_t, si_value)   == 0x18);
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -47,6 +47,7 @@ union __sifields {
 		int _overrun;		/* overrun count */
 		sigval_t _sigval;	/* same as below */
 		int _sys_private;       /* not to be passed to user */
+		void *_sys_privptr;	/* not to be passed to user */
 	} _timer;
 
 	/* POSIX.1b signals */
@@ -151,6 +152,7 @@ typedef struct siginfo {
 #define si_tid		_sifields._timer._tid
 #define si_overrun	_sifields._timer._overrun
 #define si_sys_private  _sifields._timer._sys_private
+#define si_sys_privptr  _sifields._timer._sys_privptr
 #define si_status	_sifields._sigchld._status
 #define si_utime	_sifields._sigchld._utime
 #define si_stime	_sifields._sigchld._stime
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -289,8 +289,9 @@ bool posixtimer_deliver_signal(struct ke
 out:
 	spin_lock(&current->sighand->siglock);
 
-	/* Don't expose the si_sys_private value to userspace */
+	/* Don't expose the si_sys_priv* values to userspace */
 	info->si_sys_private = 0;
+	info->si_sys_privptr = NULL;
 	return ret;
 }
 
@@ -505,6 +506,7 @@ static int do_timer_create(clockid_t whi
 
 	new_timer->sigq->info.si_tid   = new_timer->it_id;
 	new_timer->sigq->info.si_code  = SI_TIMER;
+	new_timer->sigq->info.si_sys_privptr  = new_timer;
 
 	if (copy_to_user(created_timer_id, &new_timer_id, sizeof (new_timer_id))) {
 		error = -EFAULT;

