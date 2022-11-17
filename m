Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE3062E9C8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbiKQXnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiKQXnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:43:33 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C42BA446
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:43:31 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so3481964pjl.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmIZZc21Vqw+ah0v9NZF0i5NZ6eVMCNaXJnOrpu6AVc=;
        b=Yrj5IFrDvbUZ3Yvcoww5ZxD9/vtv8JQAnR+pht+KQwLqqHXthMcS0yvQmCr+eNVO9f
         o6LbrbHFtt/SytHCo4KpaWV397L63RMWGED1Hs8t8YbB/ZISoD9PQxa5W7Z+rJ/EJ1vv
         DLJA5t4SrLk0wKYJE+jlGYm37CcLrDtO27/Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmIZZc21Vqw+ah0v9NZF0i5NZ6eVMCNaXJnOrpu6AVc=;
        b=g3bsrgq4RyIQs7O85rF0HUu6/TvoXqUr+88LyDwBP4hpZ5fxd8CmfAWYmNbbHHtFli
         aO2LGAT48du4/mkIuUVqekZJ4cxldrDOMnNgIUKGW1Ll2buhrw4YXUcop2steQ574ma4
         9e8VeDdswdKqq//6Ggvj+BRd7+2/9Y1ceu77sDs1j8aPKRO+xpb6VTElOMPwlq7gUBGL
         oRhmIwkTqOduARXI5n42nvwgOw4wwWz4ADPJPFmouAln+EBRu2dp4tw73KOJf3eoZJZA
         woOuWrydlA7gK78coXxc0h7Xopa5qrcXOD2fu3IYLRJeErEen3gSdYKZA/UgbQgC/bOD
         eZHA==
X-Gm-Message-State: ANoB5pkwpBGFVYbkCiUAbNI66Qi5Gj3VX8uyWNDw9VVDLuaHA16I2Zma
        LRVAvM05wjxeTunyC9n98JKprA==
X-Google-Smtp-Source: AA0mqf7s/asEdnHkCrNi5YFesuLIeRxumx7zAhOgO328FmhLx3/DrF0ZZE+OszS5js75jDXYCsHOtQ==
X-Received: by 2002:a17:90a:710b:b0:218:725:c820 with SMTP id h11-20020a17090a710b00b002180725c820mr5027614pjk.170.1668728610498;
        Thu, 17 Nov 2022 15:43:30 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r16-20020aa79890000000b005627d995a36sm1726716pfl.44.2022.11.17.15.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:43:29 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        David Gow <davidgow@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 2/6] exit: Put an upper limit on how often we can oops
Date:   Thu, 17 Nov 2022 15:43:22 -0800
Message-Id: <20221117234328.594699-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117233838.give.484-kees@kernel.org>
References: <20221117233838.give.484-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5376; i=keescook@chromium.org; h=from:subject; bh=bLKz0AsFfkmjD/QLdbw/QzipPdep0rPypPtLzjq9ZTA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjdsccBvLQ6nT8J4vcb5go4xzTn7/5z8tY/5Q7hcSb zMPNB62JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3bHHAAKCRCJcvTf3G3AJpL1D/ oDk0k/qwVU9AOH7rJGYOAx8NIIF3c/+tKzCgbmUMHK8vTPitK9TmPTBdDT8RMWympaOJTlnGEyWEVZ qi89p2iZ/Ly7IkmOAm+XKeqt8Id7PBkvGfQ0S6hOJBU3vL9QiovG/ZBvBdaEjtezeuVa0K/njRUL8P IBXJMNwV1PaowE45g/K64RUmABpgQ6n/KmAcw61aJpDNRZS4WGzG7aXI3ZPYe9Jcrz8omNZM72o0sX lEvUNN1yHpHmGp9fsPIFzkQoW4QVRqRrxy8CUljllnNQzVo/03L4fA+cR1+RaTlnxwHiQ87T/32JP4 EmX6r4WjI21FvqTknthuTLg9BmgmB+TWSDDW/LnEIMcOY1vr4QymYzhycPxn1PK6WGkO8REkW+K1+O 4GwWjG895xklsuozUg/QU/iwbkRsvGxC4vSkT8qQBHVw7MAkISN+OkpAvxQg6gLZvyZlZC2zO2xMF5 VwiQFlFr6vuL9CMz+kBo68TOCs9iXuaYHRt0TnWcIel+zE9fZA0Mq72SGUglEf2cY6nqIlFNuBN8qe Vu1/C460YPWW9/d9EunqPkl3UUbL5qeCuR0jBraE02NNA1ta4jWs9BV7HenTQCni0j+clechmslpPH O1ShX8omxLAY2xC0IUAtMKY7RMIISZYapZnKNO18Lbo0S9i1uvATRGJhFHSw==
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

From: Jann Horn <jannh@google.com>

Many Linux systems are configured to not panic on oops; but allowing an
attacker to oops the system **really** often can make even bugs that look
completely unexploitable exploitable (like NULL dereferences and such) if
each crash elevates a refcount by one or a lock is taken in read mode, and
this causes a counter to eventually overflow.

The most interesting counters for this are 32 bits wide (like open-coded
refcounts that don't use refcount_t). (The ldsem reader count on 32-bit
platforms is just 16 bits, but probably nobody cares about 32-bit platforms
that much nowadays.)

So let's panic the system if the kernel is constantly oopsing.

The speed of oopsing 2^32 times probably depends on several factors, like
how long the stack trace is and which unwinder you're using; an empirically
important one is whether your console is showing a graphical environment or
a text console that oopses will be printed to.
In a quick single-threaded benchmark, it looks like oopsing in a vfork()
child with a very short stack trace only takes ~510 microseconds per run
when a graphical console is active; but switching to a text console that
oopses are printed to slows it down around 87x, to ~45 milliseconds per
run.
(Adding more threads makes this faster, but the actual oops printing
happens under &die_lock on x86, so you can maybe speed this up by a factor
of around 2 and then any further improvement gets eaten up by lock
contention.)

It looks like it would take around 8-12 days to overflow a 32-bit counter
with repeated oopsing on a multi-core X86 system running a graphical
environment; both me (in an X86 VM) and Seth (with a distro kernel on
normal hardware in a standard configuration) got numbers in that ballpark.

12 days aren't *that* short on a desktop system, and you'd likely need much
longer on a typical server system (assuming that people don't run graphical
desktop environments on their servers), and this is a *very* noisy and
violent approach to exploiting the kernel; and it also seems to take orders
of magnitude longer on some machines, probably because stuff like EFI
pstore will slow it down a ton if that's active.

Signed-off-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/r/20221107201317.324457-1-jannh@google.com
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/sysctl/kernel.rst |  8 ++++
 kernel/exit.c                               | 42 +++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 98d1b198b2b4..09f3fb2f8585 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -667,6 +667,14 @@ This is the default behavior.
 an oops event is detected.
 
 
+oops_limit
+==========
+
+Number of kernel oopses after which the kernel should panic when
+``panic_on_oops`` is not set. Setting this to 0 or 1 has the same effect
+as setting ``panic_on_oops=1``.
+
+
 osrelease, ostype & version
 ===========================
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 35e0a31a0315..799c5edd6be6 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -72,6 +72,33 @@
 #include <asm/unistd.h>
 #include <asm/mmu_context.h>
 
+/*
+ * The default value should be high enough to not crash a system that randomly
+ * crashes its kernel from time to time, but low enough to at least not permit
+ * overflowing 32-bit refcounts or the ldsem writer count.
+ */
+static unsigned int oops_limit = 10000;
+
+#if CONFIG_SYSCTL
+static struct ctl_table kern_exit_table[] = {
+	{
+		.procname       = "oops_limit",
+		.data           = &oops_limit,
+		.maxlen         = sizeof(oops_limit),
+		.mode           = 0644,
+		.proc_handler   = proc_douintvec,
+	},
+	{ }
+};
+
+static __init int kernel_exit_sysctls_init(void)
+{
+	register_sysctl_init("kernel", kern_exit_table);
+	return 0;
+}
+late_initcall(kernel_exit_sysctls_init);
+#endif
+
 static void __unhash_process(struct task_struct *p, bool group_dead)
 {
 	nr_threads--;
@@ -874,6 +901,8 @@ void __noreturn do_exit(long code)
 
 void __noreturn make_task_dead(int signr)
 {
+	static atomic_t oops_count = ATOMIC_INIT(0);
+
 	/*
 	 * Take the task off the cpu after something catastrophic has
 	 * happened.
@@ -897,6 +926,19 @@ void __noreturn make_task_dead(int signr)
 		preempt_count_set(PREEMPT_ENABLED);
 	}
 
+	/*
+	 * Every time the system oopses, if the oops happens while a reference
+	 * to an object was held, the reference leaks.
+	 * If the oops doesn't also leak memory, repeated oopsing can cause
+	 * reference counters to wrap around (if they're not using refcount_t).
+	 * This means that repeated oopsing can make unexploitable-looking bugs
+	 * exploitable through repeated oopsing.
+	 * To make sure this can't happen, place an upper bound on how often the
+	 * kernel may oops without panic().
+	 */
+	if (atomic_inc_return(&oops_count) >= READ_ONCE(oops_limit))
+		panic("Oopsed too often (kernel.oops_limit is %d)", oops_limit);
+
 	/*
 	 * We're taking recursive faults here in make_task_dead. Safest is to just
 	 * leave this task alone and wait for reboot.
-- 
2.34.1

