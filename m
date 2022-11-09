Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D19C623420
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiKIUBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiKIUA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:00:56 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311DE13E16
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:00:53 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u6so18075474plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 12:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoO8Qi1M2kCdIN6zHAfogLzoF2oQxJ0yZB573MhBfxM=;
        b=EhVqRQKR/J/E9Hb9pWPoBTGiGmmVJ15if/s/UHujP+rFedb22K9Y6uH+iHmOitVeRO
         IbY5kw5eRYyZCDWPS2Qe8qKzNu9QoCSNA3K73CvdAay+ive3yjMrD+Qw1dmLfEgCRCAV
         XdTFZWcHpuhwwmYoDWP8Y4MASNfDL/NPQYVYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoO8Qi1M2kCdIN6zHAfogLzoF2oQxJ0yZB573MhBfxM=;
        b=kn8saz+ryfcOMaoPeZ8WOCAvfRjpq00IJLzjYVtu7/t9sAiKun4dNFJE5de9Vpogka
         1hl5V0aefgmNU1IvyCIDxopWgfxhjtp7SBhRhMOY2xZi5L20ikKz5PsOgTVZ3M/haXEf
         hcC2EuHrzstgQwFADFiHVnOb9Auqfyb4xiwC77Ku7/ptnFyDVTfQFEw+cmY7252aVU8S
         4j314W1P4fCl8EEnKcZIX1XZ/N1gYzzrRT+ymFa59/Kq+0K4pNrU3qR8aUKDI8YpLH7l
         mMKYNucicZ08YQiNtGWX5KaRyIr+Rz9eX4r12ai8QwQc5G/LydAdOqGeYZn2scZGFuj+
         Rggg==
X-Gm-Message-State: ACrzQf2Gta4RpIFPqmMwoyCeD4t+EAXIpDT5kwdUkJPWeDMRYdw3MCGM
        tVbaYL/0X654YV239YG4huiyvw==
X-Google-Smtp-Source: AMsMyM7SeWAc8gpa4nrlnL+apd00+XFV1GPMSvpuDJMO2XLoGLkvHPOQwxYY2e+UQHUXm2NDDJDGjw==
X-Received: by 2002:a17:902:ebc4:b0:186:b32c:4ce5 with SMTP id p4-20020a170902ebc400b00186b32c4ce5mr61507291plg.74.1668024052529;
        Wed, 09 Nov 2022 12:00:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902b20300b00186a8beec78sm9499392plr.52.2022.11.09.12.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:00:51 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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
        Luis Chamberlain <mcgrof@kernel.org>,
        David Gow <davidgow@google.com>,
        tangmeng <tangmeng@uniontech.com>,
        Petr Mladek <pmladek@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
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
Subject: [PATCH v2 4/6] panic: Consolidate open-coded panic_on_warn checks
Date:   Wed,  9 Nov 2022 12:00:47 -0800
Message-Id: <20221109200050.3400857-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109194404.gonna.558-kees@kernel.org>
References: <20221109194404.gonna.558-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5558; h=from:subject; bh=VhZyajDguwXIOeRKKSSBP5ZVJr/iLJGDdjMef3dLzMw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjbAbwCC8IljHAxeFaKkt0TLagUmeHw0bhuvd7ksR8 fg83TzSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2wG8AAKCRCJcvTf3G3AJifHEA CxHC8oBdRT9jmscKAq1CLjsng9Xu0W2++MH6aYtXPPh25LnNhXYdV9KUvaJjzFjqRkkI7X5f9hEATv 9nuFwmdAocHRelXYsa4bEIsLo/KYPVXuoagngmb7VfQcwJ84BzZAwvxcPH5Lkn1BJa6niOTpms388R 9rtIAL21U66N//NJHwbMuybr3RL+OGqIYN3Dl1jaggZMneQyFFBzuBDa5QZ0WG20DEvRLXEfPNUXZE byJiHgygyJNN5ng21MQ5yPhekwsLUFIR+9BXrupZBP9NH7lCWAW5a9fKMnIKKwOcG8hhfjcdMaBjb3 il3beRvwO4Fzrrw/8NDh12B5l5nd/fxNQK6bko4ILshXi/05VG308GEXdKecc9Y2EUAJB5aHVrKY0H NOK7XHUBeVeT70pDl7A76wtfe/2/ti5ukPfkzBOlblWr0swqFt210ZL05WDfZuNfRAzyxOtfU3lxnZ am+wMKJDx7OdRfhVEYGLVSaOinlE629WiO8FjhY7Ev3SHPoUOiRB+uJXcApTQYPFBS869SOiPmpt1w gaMKFf8mCAF4tclFqFV9nf9f0ORxE4YzFGmUuzSZFAVALBhH+1o+kbr3IlDU2hn0VyuYC2CDdAcNon 9Nwk+/4iG4f3rNqthjUpAvew2tvHiooY4Lp+2aA8LsYzaf05DNZtDkIKbTng==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: David Gow <davidgow@google.com>
Cc: tangmeng <tangmeng@uniontech.com>
Cc: Jann Horn <jannh@google.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org
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
index c7759b3f2045..1702aeb74927 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -11,6 +11,7 @@ extern long (*panic_blink)(int state);
 __printf(1, 2)
 void panic(const char *fmt, ...) __noreturn __cold;
 void nmi_panic(struct pt_regs *regs, const char *msg);
+void check_panic_on_warn(const char *reason);
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
index 129936511380..3afd234767bc 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -201,6 +201,12 @@ static void panic_print_sys_info(bool console_flush)
 		ftrace_dump(DUMP_ALL);
 }
 
+void check_panic_on_warn(const char *reason)
+{
+	if (panic_on_warn)
+		panic("%s: panic_on_warn set ...\n", reason);
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

