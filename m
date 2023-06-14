Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F6072F9CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243253AbjFNJwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242991AbjFNJwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:52:21 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DAA183
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:52:18 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-977cc772639so51616766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686736337; x=1689328337;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FmWeC77NBNaRdAHWwSRuR6SPcKNZqe53/vQrn9mW/UE=;
        b=geOqKiSnU2NC0ybUfNA7m6HcaY8z+CzuIrG8t9/O+xFTu0P49YRHGL54o4tXVSYalr
         TZfBm1rW0NBOQa2YZ/w35f3gF3DqEFEbEqo/jRINhTMeg/1sHJQpcEmQ2PAOzPdRuja0
         voBDCMwcjB96U11GODbwmFzdMyoY5LN0xzs4Cwmpj5fCkpByAcSu/Ptid/c3MbfVNqMu
         +QdZFKQjk7KLRPaTA56ypDcJa/7o2Yf33qkEG2Wa3lG+SRqiA/wBOfG0+QzJ+gn56AC4
         L1n8wv7S62yi38Fggzgz5FXfdBsJyhJRe4DioZFaB/hJl1dBp8XTP9SF4Y22iceud3c1
         gzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686736337; x=1689328337;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmWeC77NBNaRdAHWwSRuR6SPcKNZqe53/vQrn9mW/UE=;
        b=A5Z55RCcbitdqr2lUUPZqhTf75Bp8j+YeNNgxyLfNO2hfg1j4rQdF3b9YPDluc9hYd
         CYVFmuYkCkRYCb+dpUzm3tCzfaYaGBNlknP0Y6fsJRqSqawIozQcrh7AFl8eA6zOqFsl
         Y359/OM5g4+rOxqR0mY4zEokJPHOPtSRzu0md6CTRcaq7NNoyD1VCQOYSzLq0M/0W42W
         FO7XE+iWHOnyEXmxo3ZXi+bL7tSbZSBPoFJckHbaEx5wr8JzymUG2eZ/grLm6UNjzCB1
         CgW0eYHACEFMeVQUqUr7U2veKqGGY+k4PVGimNXE60XIOnJuCc3dXFMt0mD40KRSPgMC
         L82g==
X-Gm-Message-State: AC+VfDycRtQepPFYp1FxIo2H4DOdeVC2ENDBmGBT6xZUwnBA2BCxwe/t
        rc41t2tVhbd0XVZPmU1XPzcdxh7qSA==
X-Google-Smtp-Source: ACHHUZ63fN5ppS9ZmKhf6hNJ+08lZlGdBHOVI1GV/1i4KQ/LJIOWWBYBQGkc0H3hTE4SWMuUlGOqe11YMQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:980:a2e1:a81a:5ba8])
 (user=elver job=sendgmr) by 2002:a17:907:2e01:b0:974:5eb6:74f2 with SMTP id
 ig1-20020a1709072e0100b009745eb674f2mr4428432ejc.14.1686736337234; Wed, 14
 Jun 2023 02:52:17 -0700 (PDT)
Date:   Wed, 14 Jun 2023 11:51:16 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614095158.1133673-1-elver@google.com>
Subject: [PATCH] kasan: add support for kasan.fault=panic_on_write
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN's boot time kernel parameter 'kasan.fault=' currently supports
'report' and 'panic', which results in either only reporting bugs or
also panicking on reports.

However, some users may wish to have more control over when KASAN
reports result in a kernel panic: in particular, KASAN reported invalid
_writes_ are of special interest, because they have greater potential to
corrupt random kernel memory or be more easily exploited.

To panic on invalid writes only, introduce 'kasan.fault=panic_on_write',
which allows users to choose to continue running on invalid reads, but
panic only on invalid writes.

Signed-off-by: Marco Elver <elver@google.com>
---
 Documentation/dev-tools/kasan.rst |  7 ++++---
 mm/kasan/report.c                 | 31 ++++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index e66916a483cd..7f37a46af574 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -107,9 +107,10 @@ effectively disables ``panic_on_warn`` for KASAN reports.
 Alternatively, independent of ``panic_on_warn``, the ``kasan.fault=`` boot
 parameter can be used to control panic and reporting behaviour:
 
-- ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
-  report or also panic the kernel (default: ``report``). The panic happens even
-  if ``kasan_multi_shot`` is enabled.
+- ``kasan.fault=report``, ``=panic``, or ``=panic_on_write`` controls whether
+  to only print a KASAN report, panic the kernel, or panic the kernel on
+  invalid writes only (default: ``report``). The panic happens even if
+  ``kasan_multi_shot`` is enabled.
 
 Software and Hardware Tag-Based KASAN modes (see the section about various
 modes below) support altering stack trace collection behavior:
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 892a9dc9d4d3..f8ac4d0c9848 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -43,6 +43,7 @@ enum kasan_arg_fault {
 	KASAN_ARG_FAULT_DEFAULT,
 	KASAN_ARG_FAULT_REPORT,
 	KASAN_ARG_FAULT_PANIC,
+	KASAN_ARG_FAULT_PANIC_ON_WRITE,
 };
 
 static enum kasan_arg_fault kasan_arg_fault __ro_after_init = KASAN_ARG_FAULT_DEFAULT;
@@ -57,6 +58,8 @@ static int __init early_kasan_fault(char *arg)
 		kasan_arg_fault = KASAN_ARG_FAULT_REPORT;
 	else if (!strcmp(arg, "panic"))
 		kasan_arg_fault = KASAN_ARG_FAULT_PANIC;
+	else if (!strcmp(arg, "panic_on_write"))
+		kasan_arg_fault = KASAN_ARG_FAULT_PANIC_ON_WRITE;
 	else
 		return -EINVAL;
 
@@ -211,7 +214,7 @@ static void start_report(unsigned long *flags, bool sync)
 	pr_err("==================================================================\n");
 }
 
-static void end_report(unsigned long *flags, void *addr)
+static void end_report(unsigned long *flags, void *addr, bool is_write)
 {
 	if (addr)
 		trace_error_report_end(ERROR_DETECTOR_KASAN,
@@ -220,8 +223,18 @@ static void end_report(unsigned long *flags, void *addr)
 	spin_unlock_irqrestore(&report_lock, *flags);
 	if (!test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
 		check_panic_on_warn("KASAN");
-	if (kasan_arg_fault == KASAN_ARG_FAULT_PANIC)
+	switch (kasan_arg_fault) {
+	case KASAN_ARG_FAULT_DEFAULT:
+	case KASAN_ARG_FAULT_REPORT:
+		break;
+	case KASAN_ARG_FAULT_PANIC:
 		panic("kasan.fault=panic set ...\n");
+		break;
+	case KASAN_ARG_FAULT_PANIC_ON_WRITE:
+		if (is_write)
+			panic("kasan.fault=panic_on_write set ...\n");
+		break;
+	}
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 	lockdep_on();
 	report_suppress_stop();
@@ -536,7 +549,11 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_ty
 
 	print_report(&info);
 
-	end_report(&flags, ptr);
+	/*
+	 * Invalid free is considered a "write" since the allocator's metadata
+	 * updates involves writes.
+	 */
+	end_report(&flags, ptr, true);
 }
 
 /*
@@ -571,7 +588,7 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 
 	print_report(&info);
 
-	end_report(&irq_flags, ptr);
+	end_report(&irq_flags, ptr, is_write);
 
 out:
 	user_access_restore(ua_flags);
@@ -597,7 +614,11 @@ void kasan_report_async(void)
 	pr_err("Asynchronous fault: no details available\n");
 	pr_err("\n");
 	dump_stack_lvl(KERN_ERR);
-	end_report(&flags, NULL);
+	/*
+	 * Conservatively set is_write=true, because no details are available.
+	 * In this mode, kasan.fault=panic_on_write is like kasan.fault=panic.
+	 */
+	end_report(&flags, NULL, true);
 }
 #endif /* CONFIG_KASAN_HW_TAGS */
 
-- 
2.41.0.162.gfafddb0af9-goog

