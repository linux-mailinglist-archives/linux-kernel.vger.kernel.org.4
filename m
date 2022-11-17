Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFB362E9CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbiKQXoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240200AbiKQXnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:43:37 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B97B4BE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:43:33 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w23so3057561ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPxyAZmVFIQ+hzeHNDklOMYnt0nT5zaSRXR3AKVl0no=;
        b=CAnKSUlMijYM3oVNjTZMp+QYoCaxz54Tvn3HQZid0a5tCbxs2wTS7qkaFFagJiUS4o
         vZ80dfmkV08AIKBz7/JDfnIUWIOQTe8o9D+UJybk1RQ1IAtZ15Nt/LroPCWZXlTywlCK
         pEuPftQpieWwcSn3Zz3nK5otvgpihOgdX6Qyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPxyAZmVFIQ+hzeHNDklOMYnt0nT5zaSRXR3AKVl0no=;
        b=yesZXZzEZ1R3/tR3A8x2giGUSwaRS+1wUjlyo7dynE5FbjGPo62vB7EJ5dWwPJTdyA
         tAKIYT7TFTgYlgkHeZ/vPcqN1678mGtHLaU8mPPO4bzgnR9h4F1pgP+nZxIfk9fPwsGu
         +AqOTcHSyHNzoajdFZqU4Br6j8x1xXo2wriCHSo2O5ZGGjmY65GH0Yk1KjyTKKA7UtJX
         +fV1lZNcDqped1FSJ6XdxOvOdDf8kwN0F+J1kSgpB3W3osnwYpEJbN0V3ZsFQ/jxZE8Z
         T9SYMDx0ptdUHJnjxAuUUE3YjmLsblmtcd+bRr11JPE77fmq7EBfS5Sv8cdCKDbHuTUr
         +xWg==
X-Gm-Message-State: ANoB5pkZbqw7S9zquTnviIAxRz4cncqwleVn8UC2h71D1ET97u3LWhao
        xJXTUsuv7zgAK02Udr1o+uXhGw==
X-Google-Smtp-Source: AA0mqf5/HPUPf8kTcojd23Y21MDR9j+2oe33EmCLeeB5s1/w+jLFfaLm0IoriYNIk05T+q106xmteQ==
X-Received: by 2002:a17:90a:dd83:b0:218:61bd:d00d with SMTP id l3-20020a17090add8300b0021861bdd00dmr8381157pjv.236.1668728612350;
        Thu, 17 Nov 2022 15:43:32 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w184-20020a627bc1000000b0056bb99db338sm1763850pfc.175.2022.11.17.15.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:43:31 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: [PATCH v3 6/6] panic: Expose "warn_count" to sysfs
Date:   Thu, 17 Nov 2022 15:43:26 -0800
Message-Id: <20221117234328.594699-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117233838.give.484-kees@kernel.org>
References: <20221117233838.give.484-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3097; h=from:subject; bh=D2z//ezLIcXAbCg09JRiGI8OFvfo+V6hl+TtnONC3LA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjdsceSurFVH4Xz0byr7qjcNZv7p7TUAKJ01o1LaCS il+61kOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3bHHgAKCRCJcvTf3G3AJrZqD/ 0XXgpqckv3Sl3gOzRU8XGOhhTKNCgley3+PyzCJRtiQH47toEntYyvD9vFmODaSLhG1FiyD30a+PUs G7BgQa2k5SXXu1y/m/LEYrgI+Ka82BZRjN3oncSn6Gj1sGbXDiyXNgFu2e7l3f5j0GuuPciyXT5UaC Whh7g6SSpQlWFg6h1VXkWltmzGxJmgVINVIrm35KuAdSyHO3fh2FDZDFbYgC7Zw5VEZQWZGwFRZKlq fZ2NQCYYViH28pOLbjsQelxISmwyjMc+u8Si72QGiSXyQDGontB6hLEn6ri71jOmtQC2fi1PaCVFse OlWZA3mp10sfh98TdxKylYukslvpvusA+K5MQpXzq1tksDtB8jEjaCMbaiVfi0VDO+HWdplKdRZ2+e n0Us8b6qHL08DRQD/d5Iyo3nKHoDU7W22eM6TKwdRh1VOt5OxabohHDHQQAQSKLRmVdRuK4voUVG2z WTiHCwgHCUaqjBbTFhP0qQEkOrInX+5FbG+pTGdqZYZkv2f092vx6VJEu8Z8BO3LF5bC2BFaiheOTK xh8e8bMHCJ2MM9mzid34rIfE7sSTbJVFhVblpoFmXm9S5J9GpgTITDTaHoCWUeeMuoxo3kOaCKuojk rVwdTZGGHPl+RyJg5fYfmDe+KCV0g0DLqAai97luhkgJ180YHwMEsAH3AtwQ==
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

Since Warn count is now tracked and is a fairly interesting signal, add
the entry /sys/kernel/warn_count to expose it to userspace.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: tangmeng <tangmeng@uniontech.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
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
index e5aab27496d7..d718531d8bf4 100644
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
 
 void check_panic_on_warn(const char *origin)
 {
-	static atomic_t warn_count = ATOMIC_INIT(0);
-
 	if (panic_on_warn)
 		panic("%s: panic_on_warn set ...\n", origin);
 
-- 
2.34.1

