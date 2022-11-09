Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F226623424
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiKIUB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiKIUBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:01:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899692F01B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:00:56 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so2891512pji.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 12:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ro0afIwumapgwWvmG1YsaLR3d/PQtiJimII64ZaFtl0=;
        b=Bj6yZrGQoXcj6tNclOshbH3J9egAhjRfmkDStPVklR9XEa2v3+3RdklXH8z9cfK7y6
         PPcmlkc0mboBMbnoQZtz+vYF6J+Wi51E/b/I8emu9c/PT+P5E72HPuJEYseo44GJfTjC
         LNoK4lTry2eXlMd8D+D4AHavtEoQuosMVMq10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ro0afIwumapgwWvmG1YsaLR3d/PQtiJimII64ZaFtl0=;
        b=mtQhQWjNq5v4vS4IC45Ey5kTu+wZHnrCBI5Je9ZiH1JsLh+Zy0A1zZ27pNegeP3GM1
         E8LErcl5C/8BNsMWDWkAADtBUxlN/R86p/Go7NZ9IQ2B+YgWLQbx7735OZ8CkQfHxht7
         kz+0eOr6sqBNKBEBWaBWygGB96+j1m4DjKn3NOb3r2koRtfVsJQy7/0usrBsb/A7iIu3
         oKIFPKHIb8aHe8CqhEdaGORZLQB2rt67vxvuHhj6XMVosImyOr7KtDIBfbozawUm/iKj
         py22a/E7zOusAYmAo7l+YjRLi9IHURGOM9KgLIYfSlyerVnqn34I3Ql9gmNKuTpsZyeT
         6zRg==
X-Gm-Message-State: ACrzQf0wnNjELonlTppnZmch/B4t8WbHftMlK4elLBMK4sbEn19xyWYf
        Zze72vAetE+dqLOpmSLO4ssXdg==
X-Google-Smtp-Source: AMsMyM6s+8KZY3HwZ2NBLRKmVoBPCut+WPXxEXFmTLrSqQTqHLCi1hv7jT0ImlockAyWwGGLZF71bw==
X-Received: by 2002:a17:902:edd5:b0:187:1e83:8b96 with SMTP id q21-20020a170902edd500b001871e838b96mr54187822plk.1.1668024055895;
        Wed, 09 Nov 2022 12:00:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bf20-20020a17090b0b1400b0020ad53b5883sm1639166pjb.14.2022.11.09.12.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:00:54 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: [PATCH v2 6/6] panic: Expose "warn_count" to sysfs
Date:   Wed,  9 Nov 2022 12:00:49 -0800
Message-Id: <20221109200050.3400857-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109194404.gonna.558-kees@kernel.org>
References: <20221109194404.gonna.558-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3046; h=from:subject; bh=crjf/DqHlmowr17FD7/hL69h8FPT+JeC7P8wT4Sy3y8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjbAbwTj82NH1mVc/BdwILXJUeaZUer5Kuv1KXHcsT gLf80RyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2wG8AAKCRCJcvTf3G3AJqs9D/ 44ACl1LNxgKhWqINCpUTjTgHQ0kvWjIPxs52zdEdrIVDv2BZZ/DhUpxrcC730QQtcJ6F7xe3UlmePB 3hKgSYaj13nxQyS3P9cvMUtbFrQj7cCWQ8v2Q4xYikQw5hnl76PZNNLk9JRzNurPZykchYWXpIrXDt yPp0o/bmBoaDGuwOBGLA3ZcGPZgVtS3734GCjfABnwjPchjreV8dXC7sLPVxx1MAcgHOKuqoYRTcfZ sqZKqkLm9KLO/nZ5dm5UtR/R6AljYC5Y1uxCfYNkicYlrzReWZefDGPaBPR/ZQ68eDwIUiGSi8G9cz 6S9Jy7hFaGQGgsxyLMJQwKOVFoLDLpm6q2HbyNVp2Cenh5utpS6/TVtvR9OqFo+7w1UPBi0z1Hczye 6qKolXHZNNv70gNEN8fXOJGu0vqBZAEaSYp5YvkGnnymFY5tMIOG2FM+dJ1Rh3eFx1KoKh5/8uWgLP zR9Vl5PP3Wi27coL560UkZve06uP7FO8GZnRBiPLpOxZw7AGp1jlCAXOn28uBrDybJAvFxZt1W5emj 6AfqaB0D26hF55T8TAlhjp8jtR0Nk247ofFgCq/h7fshmRCFK94izJo05cL5SWAJFlphsHH6pYPpk/ 9L8qhMC3W+qJVj26D2+kYfHGTR7ruMYJ2UqU1p94HQJ4R8tORQAiouOk+uWA==
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

Since Warn count is now tracked and is a fairly interesting signal, add
the entry /sys/kernel/warn_count to expose it to userspace.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: tangmeng <tangmeng@uniontech.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../ABI/testing/sysfs-kernel-warn_count       |  6 +++++
 MAINTAINERS                                   |  1 +
 kernel/panic.c                                | 22 +++++++++++++++++--
 3 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-warn_count

diff --git a/Documentation/ABI/testing/sysfs-kernel-warn_count b/Documentation/ABI/testing/sysfs-kernel-warn_count
new file mode 100644
index 000000000000..08f083d2fd51
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-warn_count
@@ -0,0 +1,6 @@
+What:		/sys/kernel/oops_count
+Date:		November 2022
+KernelVersion:	6.2.0
+Contact:	Linux Kernel Hardening List <linux-hardening@vger.kernel.org>
+Description:
+		Shows how many times the system has Warned since last boot.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1e95a58e54..282cd8a513fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11107,6 +11107,7 @@ L:	linux-hardening@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	Documentation/ABI/testing/sysfs-kernel-oops_count
+F:	Documentation/ABI/testing/sysfs-kernel-warn_count
 F:	include/linux/overflow.h
 F:	include/linux/randomize_kstack.h
 F:	mm/usercopy.c
diff --git a/kernel/panic.c b/kernel/panic.c
index b235fa4a6fc8..ddf0f8956d6e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -32,6 +32,7 @@
 #include <linux/bug.h>
 #include <linux/ratelimit.h>
 #include <linux/debugfs.h>
+#include <linux/sysfs.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
 
@@ -107,6 +108,25 @@ static __init int kernel_panic_sysctls_init(void)
 late_initcall(kernel_panic_sysctls_init);
 #endif
 
+static atomic_t warn_count = ATOMIC_INIT(0);
+
+#ifdef CONFIG_SYSFS
+static ssize_t warn_count_show(struct kobject *kobj, struct kobj_attribute *attr,
+			       char *page)
+{
+	return sysfs_emit(page, "%d\n", atomic_read(&warn_count));
+}
+
+static struct kobj_attribute warn_count_attr = __ATTR_RO(warn_count);
+
+static __init int kernel_panic_sysfs_init(void)
+{
+	sysfs_add_file_to_group(kernel_kobj, &warn_count_attr.attr, NULL);
+	return 0;
+}
+late_initcall(kernel_panic_sysfs_init);
+#endif
+
 static long no_blink(int state)
 {
 	return 0;
@@ -211,8 +231,6 @@ static void panic_print_sys_info(bool console_flush)
 
 void check_panic_on_warn(const char *reason)
 {
-	static atomic_t warn_count = ATOMIC_INIT(0);
-
 	if (panic_on_warn)
 		panic("%s: panic_on_warn set ...\n", reason);
 
-- 
2.34.1

