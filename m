Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16B062E9CC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbiKQXoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiKQXnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:43:37 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110AFA467
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:43:31 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q1so3505256pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4mv3CX5gtAvBGKnmAgdVfBbS+bjuaYuEHlpManO9ok=;
        b=JAmzMP7DHtpsgJrcaJHLEpivCHt+540eE4yAZ5LJaET3wNe6tiPOo14LNAJvUu9+h1
         4sJl5Cz3EV9NV5pLmLvQohZFFQYsEhRan8JkLl0nGrn4Yf2qYJ14ub07jRf8YNLbIaih
         M9OmVcAFgGjNshLsfMmIG4sJXYf+xPVCMLuv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4mv3CX5gtAvBGKnmAgdVfBbS+bjuaYuEHlpManO9ok=;
        b=kReK/CorHn2076KkULg8SSy50sqsLQIHZELL4UAe+Ax4osLbYUSZpqZuKUJJjXcHdf
         kWVYyrDMFkRrsZBtu6QjXn5VVPkWYL2rVmzWX0LxDtOoDmCTwxMK7+zEaYx2IyhLKWTq
         w8wu5beg/SbIAfhTNobJFmq3yLE0XJ95Oh9EXU+0iohHd00AYUFCJ8/sOcOSkGVJMsoC
         npQuTdGJcrxnc5fA3HZLjqlrvIUmCWreZ3YiEemqygPzry+1oXZsJ3jZlmNNps77ecXJ
         4pkLBFshhmQaAaAAqAC/5g5Vz0OAjwf2AWdQErpW6lpMBKgCsRdRRBJOr/gbZpI3lQlT
         v1Qg==
X-Gm-Message-State: ANoB5pn1U9gB6g9cJqzn3mxdPbOergCKMZUEGWdAVnwwSnHKmxdoOtGs
        ZJRjNRGVMb6CUUSF8mk6yjFrNA==
X-Google-Smtp-Source: AA0mqf5bontKGmSxfV5EPBb3DrrHk3pjZ7eyKPmqkUgTkAPEdzH7BqIzgkV0Ij3CWdMsMUqet+72Vg==
X-Received: by 2002:a63:165d:0:b0:473:f7cd:6603 with SMTP id 29-20020a63165d000000b00473f7cd6603mr4329920pgw.336.1668728610990;
        Thu, 17 Nov 2022 15:43:30 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ij27-20020a170902ab5b00b00188ea79fae0sm2006916plb.48.2022.11.17.15.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:43:29 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Gow <davidgow@google.com>,
        tangmeng <tangmeng@uniontech.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 4/6] panic: Consolidate open-coded panic_on_warn checks
Date:   Thu, 17 Nov 2022 15:43:24 -0800
Message-Id: <20221117234328.594699-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117233838.give.484-kees@kernel.org>
References: <20221117233838.give.484-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5647; h=from:subject; bh=sxOIx5raY6nqpOG6YuXQYmflOUxoB4Lnr7UKuKqtC5Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjdscd2xOTxn5Fhuk9GHBu0+Cr2QXYwrSk2jHMMYhU hJUbffSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3bHHQAKCRCJcvTf3G3AJt2tEA CMAqhij2qsXL2q83Hi+yD1DUdHylf9XtJBUQ9nTL4LZpDtQlwpcXUruFfqc7cO9Qvcgf7Vcd3F9mq8 YnbF7Lw8McfpAWbrUALH/5lHVT6JR3HJ3wqRpcBjjC8j2fVbw+iFzXhufGOSOnI1FVtv3fSOS9wPws xiMYgUYWAvh1hpNRmS1mcy0EPLe4qocZLXb7qAnudPi8jy6RICKkPOoDN3zBnbY3D/4qq6bnoCm8tq MNu8W+hcuSpVh9UuUHw5yY898bSzCo3xS9SyHat8AagX5VORkdI7aB7n2Exm/p7ssIqoMhO4AfEKk1 z4hwroXVI9oMflHVHic//69Bu7Zvy29pGbqdYdssmz6H29qJhoRbU8xDIwVZ2xXJyj3qTtn6fjFKpd SW2d42wsi09rP/x1qiRySqimGVyM0tpM+iFhPXhaHfy+DWxNpdZY8M2qkPLX8D7byj+be1neeh4BPf CvWku0SS6YQDRkhMpQ9r1HlkkluJmJ9PhfLejqKgI+zdl8ihrsRJXRC255MhtnRYVCL+XtYYp4Tx0G qGmtZr8uDxv0TcU0eTgVsEw9ZIjcOAjRrkBaxVkFeqn1Uvfvyr+5jHAsqoaK+R2nov5FpdgxYxiYsZ nhr7fXddGhkxOEhViYRsnjF0kpB02cvImdzarQaeUlm8tOiOdy4EN7l3vHWA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several run-time checkers (KASAN, UBSAN, KFENCE, KCSAN, sched) roll
their own warnings, and each check "panic_on_warn". Consolidate this
into a single function so that future instrumentation can be added in
a single location.

Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Gow <davidgow@google.com>
Cc: tangmeng <tangmeng@uniontech.com>
Cc: Jann Horn <jannh@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/panic.h | 1 +
 kernel/kcsan/report.c | 3 +--
 kernel/panic.c        | 9 +++++++--
 kernel/sched/core.c   | 3 +--
 lib/ubsan.c           | 3 +--
 mm/kasan/report.c     | 4 ++--
 mm/kfence/report.c    | 3 +--
 7 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index c7759b3f2045..979b776e3bcb 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -11,6 +11,7 @@ extern long (*panic_blink)(int state);
 __printf(1, 2)
 void panic(const char *fmt, ...) __noreturn __cold;
 void nmi_panic(struct pt_regs *regs, const char *msg);
+void check_panic_on_warn(const char *origin);
 extern void oops_enter(void);
 extern void oops_exit(void);
 extern bool oops_may_print(void);
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 67794404042a..e95ce7d7a76e 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -492,8 +492,7 @@ static void print_report(enum kcsan_value_change value_change,
 	dump_stack_print_info(KERN_DEFAULT);
 	pr_err("==================================================================\n");
 
-	if (panic_on_warn)
-		panic("panic_on_warn set ...\n");
+	check_panic_on_warn("KCSAN");
 }
 
 static void release_report(unsigned long *flags, struct other_info *other_info)
diff --git a/kernel/panic.c b/kernel/panic.c
index d843d036651e..cfa354322d5f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -201,6 +201,12 @@ static void panic_print_sys_info(bool console_flush)
 		ftrace_dump(DUMP_ALL);
 }
 
+void check_panic_on_warn(const char *origin)
+{
+	if (panic_on_warn)
+		panic("%s: panic_on_warn set ...\n", origin);
+}
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -619,8 +625,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 	if (regs)
 		show_regs(regs);
 
-	if (panic_on_warn)
-		panic("panic_on_warn set ...\n");
+	check_panic_on_warn("kernel");
 
 	if (!regs)
 		dump_stack();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5800b0623ff3..285ef8821b4f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5729,8 +5729,7 @@ static noinline void __schedule_bug(struct task_struct *prev)
 		pr_err("Preemption disabled at:");
 		print_ip_sym(KERN_ERR, preempt_disable_ip);
 	}
-	if (panic_on_warn)
-		panic("scheduling while atomic\n");
+	check_panic_on_warn("scheduling while atomic");
 
 	dump_stack();
 	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
diff --git a/lib/ubsan.c b/lib/ubsan.c
index 36bd75e33426..60c7099857a0 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -154,8 +154,7 @@ static void ubsan_epilogue(void)
 
 	current->in_ubsan--;
 
-	if (panic_on_warn)
-		panic("panic_on_warn set ...\n");
+	check_panic_on_warn("UBSAN");
 }
 
 void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs)
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index df3602062bfd..cc98dfdd3ed2 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -164,8 +164,8 @@ static void end_report(unsigned long *flags, void *addr)
 				       (unsigned long)addr);
 	pr_err("==================================================================\n");
 	spin_unlock_irqrestore(&report_lock, *flags);
-	if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
-		panic("panic_on_warn set ...\n");
+	if (!test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
+		check_panic_on_warn("KASAN");
 	if (kasan_arg_fault == KASAN_ARG_FAULT_PANIC)
 		panic("kasan.fault=panic set ...\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 7e496856c2eb..110c27ca597d 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -268,8 +268,7 @@ void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *r
 
 	lockdep_on();
 
-	if (panic_on_warn)
-		panic("panic_on_warn set ...\n");
+	check_panic_on_warn("KFENCE");
 
 	/* We encountered a memory safety error, taint the kernel! */
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_STILL_OK);
-- 
2.34.1

