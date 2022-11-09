Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3530562341D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiKIUBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiKIUAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:00:55 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A9913D6F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:00:52 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso2861638pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 12:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQKFx/3OVEr8FOcVZmOutyPL+4wZ1FyB719efe5yfh8=;
        b=Eaj/SO41QTj6LK1PYYV3lOKLMoZSqh+R0yOIIew/1/tAcK612AxIrryq13QPOM+mG3
         cIGmAGV1hA0JT7z/XcIG7pfVNECt7JsEuq8IzQEpG+xbwBgzHHge111qfOUOpF/DODDh
         gd9NKs/G/CVQXIRMjB5VA6NVlRIODdQVSaQVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQKFx/3OVEr8FOcVZmOutyPL+4wZ1FyB719efe5yfh8=;
        b=8Lmsj8eCguhaA+PlDi/IYidNkxYxKMlQ3WLyDTIuzPmCpI9RPuVt4l02+Fs0t/8Tm+
         JxmzDldVOsRjuj+BtYOhoqazJJt0C+QlEB4pO1jxoqeb9ImlZqRoWY9+H0SMksPy4e9D
         GbMo88zADtHvAQFVPyE8DdlJO/u+UrpHmdRQdkmajdwb70MUj6sonFeBUkouRS0TaHO1
         Bq2hukPZQ43H2vMUJ/13PdG+bRwGPyuZSGwoPZTg5sMMNpkdX1QdzjsFawD82Oy58Ou/
         3LBRJh+a2+K/nlTBdr68l0aBpup4dWl6z80xqVcRJfbtAFiya2Tr0Z0rv7p/ufO68WAf
         Swjg==
X-Gm-Message-State: ACrzQf1oexDGD5Z9B8b5GJqqilDOb/EcfL2vRQi9FG+wYyJNzBoaAp8j
        cyvaXAfoI9TW54BZRQyPrB+LZg==
X-Google-Smtp-Source: AMsMyM6mufCgxjvUeKez7jB4G5EOHeMUc1Hxuif7xwxUrr+40nx9N84+xIx/MS0AbRJyF1rMX+hmwA==
X-Received: by 2002:a17:902:7283:b0:188:612b:1d31 with SMTP id d3-20020a170902728300b00188612b1d31mr31950444pll.81.1668024052270;
        Wed, 09 Nov 2022 12:00:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bd5-20020a17090b0b8500b0020d9306e735sm1629847pjb.20.2022.11.09.12.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:00:51 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
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
        Luis Chamberlain <mcgrof@kernel.org>,
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
Subject: [PATCH v2 2/6] exit: Put an upper limit on how often we can oops
Date:   Wed,  9 Nov 2022 12:00:45 -0800
Message-Id: <20221109200050.3400857-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109194404.gonna.558-kees@kernel.org>
References: <20221109194404.gonna.558-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5361; i=keescook@chromium.org; h=from:subject; bh=+f/+Dg4RjhhWvYSeTOZHt0meJbZX9qmj9YfRzK8RgiI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjbAbvj62Q9JcvPPd6ZZiW3RZKbMkJ9KitwgH9cwUs jkYefu2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2wG7wAKCRCJcvTf3G3AJtTYEA Coz/20jIancS/LGuMA+yU7vBUbp90sWb4OB9OEWj+5Z8KSUdedxGwouUYlMeNAAlL/7NDkKSvNpUDC JmGbJON8OKVCS8idIB9lACwcVavVx18L/YCJvzSwTvQTdXDOhMSjrS4Ouyyt2MSQiCpru6xUvwlGCm DOXU4YlA5cqVJ9CA/Uwq1U23IVAQOTldToR9GH19lq+0Kmr19P0jQha/rl5uarCKr5BU0XTqW6QKT2 k4cPF3Fjb65aiz0I3G2gW8SrPW4AANI3jJyhQT1+m32izI7gqs4Dz/h4jq9RSfF9rXjBXmBceJfnnb UmjaXMhmVJvPnAB7UXA5/tUz5h4PnWMb4WIyWqS8K3Rjppw81sgG0S3FEKk317d7y/ucXUDBwAIdbZ QqQI+ijh8zAw6m4pa1PHMgJxjN1nvqzNRip6eiShoPrpJrNKHlVZMseoUe+ytcD0IXZlr5VZgMlSnR MvmYVYavcUj4497v/0Zh4lg22PSKybYSsACuCv/g6jWagGfwMiDf+qOK4fNpn6eI5Jk9v4/vqg9zTj iEwg/2zCSXBGZsM3rMMyuud3hH9sMkmyKANOQvl4zbB3ghuT0gVX9Vt4Sb+innAy0kHTbvs2+F4XSh VvkhTOPJ5bFVFdiIqQFVx3jLysoYcUAkK3oXCThGbXsbm9fTKpWY3lnzNiVA==
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

[Moved sysctl into kernel/exit.c -kees]

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20221107201317.324457-1-jannh@google.com
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
index 35e0a31a0315..892f38aeb0a4 100644
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
+		panic("Oopsed too often (oops_limit is %d)", oops_limit);
+
 	/*
 	 * We're taking recursive faults here in make_task_dead. Safest is to just
 	 * leave this task alone and wait for reboot.
-- 
2.34.1

