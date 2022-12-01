Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE98763F55B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiLAQhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiLAQhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:37:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E54ABA0A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:37:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4D9CB81F8F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCB8C433C1;
        Thu,  1 Dec 2022 16:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669912638;
        bh=e4FpSbE4DElqkkwlRAW7vqGn1U2Oxmc9jQs2WyNHufo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NM4auNJplcKF5KcWXi8vNloDVPPpveaTbp23KYumYc+AnblLUdtiRdm83jnqp7S9+
         ZNKx1YNPdLRSKBzXP8ibiKfsG+JfoEfdauRZNn6mgkNOt05ZqA57x3Wm3Cf4CS5y7c
         gn37vMVttZd4SEot9HNI2iA9sVRAmLe0M4V9vWeyUxiYobKxZYvUotNlhpNbgfq/XI
         XoC33a85TbgbfyY4+uPSFI30R17kQlR7Ll/z4EHzCFQZnpwKUolqcXaafwfiFkFsxG
         CoBT45OxAEIowMm+XUoJH1nudUJ3iWthMynUIOhlYpvEoFy+L4Opd8xIMJhRk+Dl52
         LrNVEMovbfmzg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Subject: [RFC PATCH] panic: Add new taint flag for fault injection
Date:   Fri,  2 Dec 2022 01:37:13 +0900
Message-Id: <166991263326.311919.16890937584677289681.stgit@devnote3>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221201234121.8925fdf83115747ac4ac116a@kernel.org>
References: <20221201234121.8925fdf83115747ac4ac116a@kernel.org>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since the function error injection framework in the fault injection
subsystem can change the function code flow forcibly, it may cause
unexpected behavior (but that is the purpose of this feature).
To identify this in the kernel oops message, add a new taint flag
for this, and set it if it is (and similar things in BPF) used.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/panic.h    |    3 ++-
 kernel/fail_function.c   |    2 ++
 kernel/panic.c           |    1 +
 kernel/trace/bpf_trace.c |    2 ++
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index c7759b3f2045..2b03a02d86be 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -69,7 +69,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
 #define TAINT_TEST			18
-#define TAINT_FLAGS_COUNT		19
+#define TAINT_FAULT_INJECTED		19
+#define TAINT_FLAGS_COUNT		20
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index a7ccd2930c5f..80a743f14a2c 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -9,6 +9,7 @@
 #include <linux/kprobes.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/panic.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
@@ -298,6 +299,7 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
 		fei_attr_free(attr);
 		goto out;
 	}
+	add_taint(TAINT_FAULT_INJECTED, LOCKDEP_NOW_UNRELIABLE);
 	fei_debugfs_add_attr(attr);
 	list_add_tail(&attr->list, &fei_attr_list);
 	ret = count;
diff --git a/kernel/panic.c b/kernel/panic.c
index da323209f583..e396a5fd9bb6 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -426,6 +426,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
 	[ TAINT_TEST ]			= { 'N', ' ', true },
+	[ TAINT_FAULT_INJECTED ]	= { 'J', ' ', false },
 };
 
 /**
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1ed08967fb97..de0614d9796c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2137,6 +2137,8 @@ int perf_event_attach_bpf_prog(struct perf_event *event,
 		goto unlock;
 
 	/* set the new array to event->tp_event and set event->prog */
+	if (prog->kprobe_override)
+		add_taint(TAINT_FAULT_INJECTED, LOCKDEP_NOW_UNRELIABLE);
 	event->prog = prog;
 	event->bpf_cookie = bpf_cookie;
 	rcu_assign_pointer(event->tp_event->prog_array, new_array);

