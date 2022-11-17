Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C597862E9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiKQXoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbiKQXnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:43:35 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11463AE4B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:43:31 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id k15so3314148pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEctX2gK/ElW3R9ceKOIZ71qq6p0GHil0cFCvNxx9OU=;
        b=g/cPhiEF39Jvwi7g1+Xq/pr38nMj44Nu7s3aqvgVZ1DuDpYFoo3QSUKLFZp+RMwqwL
         g5oKfoC/3yNkyhPPEKYdkg/utc2TP4MAjs/KblO7vXyah7+sZr2ylyYvIb8fIxIUDBNi
         KVyAxBdO6D26J0+lG5kgCcL5Y7eu/9gjkucTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEctX2gK/ElW3R9ceKOIZ71qq6p0GHil0cFCvNxx9OU=;
        b=nrYHFqdcb/qx/OcnJPS7Ns3Ixx8HHRKEKYeryPPtQC8D6bQMo/M1n6faXS6O382701
         DDwRvHRxcHLBesYvdl/AKvPa1i8ESbvPbEQVL+ARvOERKPQL5tQXySJ9pf5UvLHP3dzS
         pXs4eX7DEWAbWbcyY7F10EaCE40KzLDjZd24AbNfVDUnEa0KiPQmgpRPC8zFkr+hEHzK
         NUDnspFXQC5HeF6Psa3AIHHp2vDFy+TcYuaUsDMDu5F0jGD3g0987I/T818M+We8sm4k
         TS7sx/lDMwJMG9yDGiuxo1ZoEmwhrzU7rgG9NdaP8wySQKv5vj+kpxAqcCeDgPthAPW+
         /G6A==
X-Gm-Message-State: ANoB5pnVFowRb5CcArHBCsRTgdbo7szJPtZlwa5NXPIAKLgzyHk2KIyv
        7E3iqhMSKK2bYnrFLlga0KAevg==
X-Google-Smtp-Source: AA0mqf4M/o7GhXpsftplQmBpm+8mjuCK9Jc0JOK5XP71hY2vvCFVWcsgoDClF4tpNfGyM5thbqjLnQ==
X-Received: by 2002:aa7:92d3:0:b0:571:fa1d:85b7 with SMTP id k19-20020aa792d3000000b00571fa1d85b7mr5205770pfa.39.1668728611497;
        Thu, 17 Nov 2022 15:43:31 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a27-20020aa794bb000000b0056e8eb09d57sm1740441pfl.63.2022.11.17.15.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:43:29 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: [PATCH v3 3/6] exit: Expose "oops_count" to sysfs
Date:   Thu, 17 Nov 2022 15:43:23 -0800
Message-Id: <20221117234328.594699-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117233838.give.484-kees@kernel.org>
References: <20221117233838.give.484-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2942; h=from:subject; bh=6N9/v4YXpaCj0jy2bGs74rqpXsiLoI6QvjFrvLVEdiU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjdscdh2yxsYpUSBCFMx+XWPrp5jq3lGnveBJJoWti eB8Nl9WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3bHHQAKCRCJcvTf3G3AJjt4EA CjpotPoy23FlY4Qe6SzOgM/fewK8Qusqvop3tumZYb1OmUZ3CgaaTE15vdIUaf/nsyYtA1FhiPGV/U YQy1UTWXdQA2wt++NQZfMTdEMdmBItLvn+FAGrDmZpojr50i2xvPqQ4ZlTzhRzMA4NgWg+La/tm6rj rrsKc6k4YwSUes7KJWCF2R81GXMgfp2I13qsOUoqTmeeoWTkj9NQDzd+tbrjQ3C4gdqQUywUnDjZth U2HhrYciP9QXml569OiVFVdJqdk5r06EornXt5+0ffDu464SSxJdveFq11X9OGsM93M1T0Ct0tTfTD jCaFKZm4SdH8BPjWDdZd8WV1oscg2YS+C0ZlJ1IIHmRbDOeyPpsZyHgSzry1ErZrI++9xrESX6Rnk9 WFfS6UoZwKN6RXQFCh8dszPl/D23nHXp0TcN9D352o4kt4QnP8NrMRHB2c4akAbPZVmrBJrWhTFS7A IFJforSkglRfDq1Q4pY+zYhYCHA0IcvyOXU8zHLrw3SiT79IM/ELZb5Vif026dvQAFGc2H2zhqtJsA IPMHAhfLn32+WmGmgb3y8FYwiPnuNtRPq3hPthUqpNGpteOifZBwly3+o0FnPEoLYzAIRHq5tDL10c Sq+p7wxTwnoc9TVGptRmQKHqr92CO9QKe0gKg2UpDHcOAlTJ5znFcTS2wcxQ==
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

Since Oops count is now tracked and is a fairly interesting signal, add
the entry /sys/kernel/oops_count to expose it to userspace.

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jann Horn <jannh@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../ABI/testing/sysfs-kernel-oops_count       |  6 +++++
 MAINTAINERS                                   |  1 +
 kernel/exit.c                                 | 22 +++++++++++++++++--
 3 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-oops_count

diff --git a/Documentation/ABI/testing/sysfs-kernel-oops_count b/Documentation/ABI/testing/sysfs-kernel-oops_count
new file mode 100644
index 000000000000..156cca9dbc96
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-oops_count
@@ -0,0 +1,6 @@
+What:		/sys/kernel/oops_count
+Date:		November 2022
+KernelVersion:	6.2.0
+Contact:	Linux Kernel Hardening List <linux-hardening@vger.kernel.org>
+Description:
+		Shows how many times the system has Oopsed since last boot.
diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd80c113721..0a1e95a58e54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11106,6 +11106,7 @@ M:	Kees Cook <keescook@chromium.org>
 L:	linux-hardening@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
+F:	Documentation/ABI/testing/sysfs-kernel-oops_count
 F:	include/linux/overflow.h
 F:	include/linux/randomize_kstack.h
 F:	mm/usercopy.c
diff --git a/kernel/exit.c b/kernel/exit.c
index 799c5edd6be6..bc62bfe75bc7 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -67,6 +67,7 @@
 #include <linux/io_uring.h>
 #include <linux/kprobes.h>
 #include <linux/rethook.h>
+#include <linux/sysfs.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -99,6 +100,25 @@ static __init int kernel_exit_sysctls_init(void)
 late_initcall(kernel_exit_sysctls_init);
 #endif
 
+static atomic_t oops_count = ATOMIC_INIT(0);
+
+#ifdef CONFIG_SYSFS
+static ssize_t oops_count_show(struct kobject *kobj, struct kobj_attribute *attr,
+			       char *page)
+{
+	return sysfs_emit(page, "%d\n", atomic_read(&oops_count));
+}
+
+static struct kobj_attribute oops_count_attr = __ATTR_RO(oops_count);
+
+static __init int kernel_exit_sysfs_init(void)
+{
+	sysfs_add_file_to_group(kernel_kobj, &oops_count_attr.attr, NULL);
+	return 0;
+}
+late_initcall(kernel_exit_sysfs_init);
+#endif
+
 static void __unhash_process(struct task_struct *p, bool group_dead)
 {
 	nr_threads--;
@@ -901,8 +921,6 @@ void __noreturn do_exit(long code)
 
 void __noreturn make_task_dead(int signr)
 {
-	static atomic_t oops_count = ATOMIC_INIT(0);
-
 	/*
 	 * Take the task off the cpu after something catastrophic has
 	 * happened.
-- 
2.34.1

