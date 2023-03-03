Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DE36A9F4D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjCCSkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjCCSkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:40:19 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80D962332
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:39:23 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id v10so1351850iox.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 10:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677868752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lj/t6Fz/u75jqRo8OM20KwqRZGxc+UX5ZSqckuG+0gc=;
        b=aYvV43QPE3cPf6fntBuyX9cMHioXxxVTAMrSpgyW/aUaKAKKUVJ4JyrjKtrBn0yafI
         vm0DeyPOkvctS8L1wE0Eg57BVSlGQn3jhpwOPPMbsOICpG/VV5reP05gispHhJkPvJk1
         JfJAeIqtWYeTbIocnz5oRQIQATb3iawG5t9arkCQFahGf94YgUUUfZgD/Xjea4vuVtQO
         7rt1gPV9GpO0wJrK31+Cm96hm7O52eelQSQ4E9S8j7cF9aQXXGChf7lJIq5CZLZU8IAK
         55673Uj6te34ngXvKHDlsuMYNCxwHDSj2BwWTQLTJ5ykiAaq3CFq4C4A3qZTQk20vFG/
         0ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677868752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lj/t6Fz/u75jqRo8OM20KwqRZGxc+UX5ZSqckuG+0gc=;
        b=26FTa3Qmh3FXq2+nMA0CrArwjzOW1BecuRy+yjXX3hJ8IZdbJiaoOriuwmyPPDDKcH
         lVGukSo1kG9iG8qj5BRxoye3ExK/hE/g7PkV1neECuonoWHNr0IF0kZK9ByPQNBfkqUu
         YQBT51mDPfPz4nuvL2D54wt7Nv5iqzUUXh/y+qgphNBZdG1fjWHda073E0rYpWIPATFD
         BWpqkaBRs1UFnU1Zz+rBrBQQs0CXV6C+LYjibaj4o+3rE6nIuZsnwSuIk9plxu/5ou0p
         wpcTstru2iELMmY2QnqesY57FBdQVX4sQm5AASBIdWtyF+r677GjYbwzjgtWSnYnQCgW
         w+KA==
X-Gm-Message-State: AO0yUKUBQPJS0eY0quBOnFGD650vEZNiUk4tanSCprdsUD5oYwBFVtwb
        cHo/iJts0gJdTX7PPKA/GAg=
X-Google-Smtp-Source: AK7set+4yucOkRW1/d5e/kPN1MXE3eipNN0yVQZrke+VeTgk533pCsdP1C5ltGsIopAYsVSlqy80OQ==
X-Received: by 2002:a5d:8150:0:b0:74d:1ccb:e5a5 with SMTP id f16-20020a5d8150000000b0074d1ccbe5a5mr1503812ioo.6.1677868752557;
        Fri, 03 Mar 2023 10:39:12 -0800 (PST)
Received: from ArchLinux.lan ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id e12-20020a5ede0c000000b0074c9a4bb374sm875009iok.11.2023.03.03.10.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 10:39:12 -0800 (PST)
From:   Schspa Shi <schspa@gmail.com>
To:     tglx@linutronix.de, longman@redhat.com, swboyd@chromium.org,
        linux@roeck-us.net, wuchi.zero@gmail.com
Cc:     linux-kernel@vger.kernel.org, Schspa Shi <schspa@gmail.com>
Subject: [PATCH v2 2/2] debugobject: add unit test for static debug object
Date:   Sat,  4 Mar 2023 02:31:48 +0800
Message-Id: <20230303183147.934793-2-schspa@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303183147.934793-1-schspa@gmail.com>
References: <20230303183147.934793-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test case to enusre that static debug object correctness.

Tested on little-endian arm64 qemu, result:

[    2.385735] KTAP version 1
[    2.385860] 1..1
[    2.386406]     KTAP version 1
[    2.386658]     # Subtest: static debugobject init
[    2.386726]     1..1
[    2.401777]     ok 1 static_debugobject_test
[    2.402455] ok 1 static debugobject init

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 MAINTAINERS                    |   5 ++
 lib/Kconfig.debug              |  14 ++++
 lib/Makefile                   |   2 +
 lib/test_static_debug_object.c | 125 +++++++++++++++++++++++++++++++++
 4 files changed, 146 insertions(+)
 create mode 100644 lib/test_static_debug_object.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b0db911207ba4..38187e2921691 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23202,6 +23202,11 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/zswap.c
 
+STATIC DEBUGOBJECT TEST
+M:	Schspa Shi <schspa@gmail.com>
+S:	Maintained
+F:	lib/test_static_debug_object.c
+
 THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c8b379e2e9adc..9d5ee631d4380 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2801,6 +2801,20 @@ config TEST_CLOCKSOURCE_WATCHDOG
 
 	  If unsure, say N.
 
+config TEST_STATIC_DEBUGOBJECT
+	tristate "KUnit test for static debugobject"
+	depends on KUNIT
+	select KPROBES
+	select DEBUG_OBJECTS
+	select DEBUG_OBJECTS_TIMERS
+	help
+	  This builds the static debugobject unit test, which runs on boot.
+	  Tests the static debug object correctness.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 endif # RUNTIME_TESTING_MENU
 
 config ARCH_USE_MEMTEST
diff --git a/lib/Makefile b/lib/Makefile
index baf2821f7a00f..f663686beabd9 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -427,3 +427,5 @@ $(obj)/$(TEST_FORTIFY_LOG): $(addprefix $(obj)/, $(TEST_FORTIFY_LOGS)) FORCE
 ifeq ($(CONFIG_FORTIFY_SOURCE),y)
 $(obj)/string.o: $(obj)/$(TEST_FORTIFY_LOG)
 endif
+
+obj-$(CONFIG_TEST_STATIC_DEBUGOBJECT) += test_static_debug_object.o
diff --git a/lib/test_static_debug_object.c b/lib/test_static_debug_object.c
new file mode 100644
index 0000000000000..8a0d6ab5c24b5
--- /dev/null
+++ b/lib/test_static_debug_object.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * THis module tests the static debugobject via a static timer instance. This
+ * test use kretprobe to inject some delay to make the problem easier to
+ * reproduce.
+ *
+ * Copyright (c) 2023, Schspa Shi <schspa@gmail.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/delay.h>
+#include <linux/kprobes.h>
+#include <linux/workqueue.h>
+#include <linux/cpu.h>
+#include <kunit/test.h>
+
+static void ktest_timer_func(struct timer_list *);
+
+static DEFINE_TIMER(ktest_timer, ktest_timer_func);
+static int timer_stop;
+DEFINE_SPINLOCK(tlock);
+
+static DEFINE_PER_CPU(struct work_struct, timer_debugobject_test_work);
+
+static void timer_debugobject_workfn(struct work_struct *work)
+{
+	mod_timer(&ktest_timer, jiffies + (5 * HZ));
+}
+
+/*
+ * Reaper for links from keyrings to dead keys.
+ */
+static void ktest_timer_func(struct timer_list *t)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&tlock, flags);
+	if (!timer_stop)
+		mod_timer(&ktest_timer, jiffies + (1 * HZ));
+	spin_unlock_irqrestore(&tlock, flags);
+}
+
+
+static int static_object_check_handler(
+	struct kretprobe_instance *ri, struct pt_regs *regs)
+{
+	void *address;
+
+	address = (void *)regs_get_register(regs, 0);
+
+	if (address == &ktest_timer) {
+		int this_cpu = raw_smp_processor_id();
+		/*
+		 * This hook point adds an extra delay to make the problem
+		 * easier to reproduce. We need different delay for
+		 * differenct processor.
+		 */
+		mdelay(this_cpu * 100);
+	}
+
+	return 0;
+}
+
+
+static struct kretprobe is_static_kretprobes = {
+	.entry_handler = static_object_check_handler,
+	.data_size = 0,
+	/* Probe up to 512 instances concurrently. */
+	.maxactive = 512,
+	.kp = {
+		.symbol_name = "timer_is_static_object",
+	}
+};
+
+
+static void static_debugobject_test(struct kunit *test)
+{
+	unsigned long flags;
+	int cpu;
+	int ret;
+
+	ret = register_kretprobe(&is_static_kretprobes);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/* Do test */
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		struct work_struct *work =
+			&per_cpu(timer_debugobject_test_work, cpu);
+		INIT_WORK(work, timer_debugobject_workfn);
+		schedule_work_on(cpu, work);
+	}
+
+	for_each_online_cpu(cpu) {
+		struct work_struct *work =
+			&per_cpu(timer_debugobject_test_work, cpu);
+		flush_work(work);
+	}
+	cpus_read_unlock();
+
+	spin_lock_irqsave(&tlock, flags);
+	timer_stop = 0;
+	spin_unlock_irqrestore(&tlock, flags);
+
+	del_timer_sync(&ktest_timer);
+
+	unregister_kretprobe(&is_static_kretprobes);
+}
+
+static struct kunit_case static_debugobject_init_cases[] = {
+	KUNIT_CASE(static_debugobject_test),
+	{}
+};
+
+static struct kunit_suite static_debugobject_suite = {
+	.name = "static debugobject init",
+	.test_cases = static_debugobject_init_cases,
+};
+
+kunit_test_suite(static_debugobject_suite);
+MODULE_AUTHOR("Schspa <schspa@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.39.2

