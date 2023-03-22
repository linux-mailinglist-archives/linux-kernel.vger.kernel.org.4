Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FF46C4164
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCVEBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjCVEAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:00:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B0A497DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 21:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C78CDCE1752
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7733C4339C;
        Wed, 22 Mar 2023 04:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679457626;
        bh=WByO8acwZQuT4iXFRv6NfiOBwBiqMnpdQ0Zz8Qhutj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ah7xBhMrbtmXdB28Fa+2TLa96rzWrLYBLYcsC9dBc3JLBzM0FbJm7hijJDaqJMVSC
         88lVtqzAXHMEpbujV3WzUWMpU9L1calLNDNOLa0eRkHsjEjguwO9JORkxvVB/8dud6
         MY9SNoagfO6WnErCEqzDr85E/67Nw6Nz6btL08sZHWaSR3CcKJjQtPBAtXKIaWnNXz
         2+atd43Ey2zXbo7/NvLp9ael+CrqXqBSqUVlsSGjZe9muZr8eXkVABpLrIH4DK9lC7
         egknG2DsSGrZI5SebY99U4kS6HsITkEpILBpse6YTc1fjUlC5pcB4yNIhdsWjWOGOf
         MBZeTDyyUkVag==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 06/11] static_call: "EXPORT_STATIC_CALL_TRAMP" -> "EXPORT_STATIC_CALL_RO"
Date:   Tue, 21 Mar 2023 21:00:12 -0700
Message-Id: <00373cd98e299d6ab3c6c7417514acf0f0ead157.1679456900.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679456900.git.jpoimboe@kernel.org>
References: <cover.1679456900.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EXPORT_STATIC_CALL_TRAMP() basically creates a read-only export of the
static call.  Make that clearer by renaming it to
EXPORT_STATIC_CALL_RO().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/events/amd/brs.c               |  2 +-
 arch/x86/include/asm/perf_event.h       |  2 +-
 arch/x86/include/asm/preempt.h          |  4 ++--
 include/linux/kernel.h                  |  2 +-
 include/linux/sched.h                   |  2 +-
 include/linux/static_call.h             | 28 +++++++++++++++----------
 include/linux/static_call_types.h       |  8 +++----
 kernel/sched/core.c                     |  8 +++----
 tools/include/linux/static_call_types.h |  8 +++----
 9 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index ed308719236c..961be770aa24 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -423,7 +423,7 @@ void noinstr perf_amd_brs_lopwr_cb(bool lopwr_in)
 }
 
 DEFINE_STATIC_CALL_NULL(perf_lopwr_cb, perf_amd_brs_lopwr_cb);
-EXPORT_STATIC_CALL_TRAMP_GPL(perf_lopwr_cb);
+EXPORT_STATIC_CALL_RO_GPL(perf_lopwr_cb);
 
 void __init amd_brs_lopwr_init(void)
 {
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8fc15ed5e60b..43eb95db4cc9 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -588,7 +588,7 @@ DECLARE_STATIC_CALL(perf_lopwr_cb, perf_amd_brs_lopwr_cb);
 
 static __always_inline void perf_lopwr_cb(bool lopwr_in)
 {
-	static_call_mod(perf_lopwr_cb)(lopwr_in);
+	static_call_ro(perf_lopwr_cb)(lopwr_in);
 }
 
 #endif /* PERF_NEEDS_LOPWR_CB */
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 2d13f25b1bd8..65028c346709 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -124,7 +124,7 @@ DECLARE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
 
 #define __preempt_schedule() \
 do { \
-	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule); \
+	__STATIC_CALL_RO_ADDRESSABLE(preempt_schedule); \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
@@ -132,7 +132,7 @@ DECLARE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_dynamic_e
 
 #define __preempt_schedule_notrace() \
 do { \
-	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule_notrace); \
+	__STATIC_CALL_RO_ADDRESSABLE(preempt_schedule_notrace); \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 40bce7495af8..5c857c3acbc0 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -107,7 +107,7 @@ DECLARE_STATIC_CALL(might_resched, __cond_resched);
 
 static __always_inline void might_resched(void)
 {
-	static_call_mod(might_resched)();
+	static_call_ro(might_resched)();
 }
 
 #elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 63d242164b1a..13b17ff4ad22 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2074,7 +2074,7 @@ DECLARE_STATIC_CALL(cond_resched, __cond_resched);
 
 static __always_inline int _cond_resched(void)
 {
-	return static_call_mod(cond_resched)();
+	return static_call_ro(cond_resched)();
 }
 
 #elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 013022a8611d..74f089a5955b 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -23,6 +23,7 @@
  *
  *   static_call(name)(args...);
  *   static_call_cond(name)(args...);
+ *   static_call_ro(name)(args...);
  *   static_call_update(name, func);
  *   static_call_query(name);
  *
@@ -123,12 +124,11 @@
  *   Notably argument setup is unconditional.
  *
  *
- * EXPORT_STATIC_CALL() vs EXPORT_STATIC_CALL_TRAMP():
- *
- *   The difference is that the _TRAMP variant tries to only export the
- *   trampoline with the result that a module can use static_call{,_cond}() but
- *   not static_call_update().
+ * EXPORT_STATIC_CALL() vs EXPORT_STATIC_CALL_RO():
  *
+ *   The difference is the read-only variant exports the trampoline but not the
+ *   key, so a module can call it via static_call_ro() but can't update the
+ *   target via static_call_update().
  */
 
 #include <linux/types.h>
@@ -210,11 +210,14 @@ extern long __static_call_return0(void);
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
-/* Leave the key unexported, so modules can't change static call targets: */
-#define EXPORT_STATIC_CALL_TRAMP(name)					\
+/*
+ * Read-only exports: export the trampoline but not the key, so modules can't
+ * change call targets.
+ */
+#define EXPORT_STATIC_CALL_RO(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name));				\
 	__STATIC_CALL_ADD_TRAMP_KEY(name)
-#define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
+#define EXPORT_STATIC_CALL_RO_GPL(name)				\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name));			\
 	__STATIC_CALL_ADD_TRAMP_KEY(name)
 
@@ -268,10 +271,13 @@ extern long __static_call_return0(void);
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
-/* Leave the key unexported, so modules can't change static call targets: */
-#define EXPORT_STATIC_CALL_TRAMP(name)					\
+/*
+ * Read-only exports: export the trampoline but not the key, so modules can't
+ * change call targets.
+ */
+#define EXPORT_STATIC_CALL_RO(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
-#define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
+#define EXPORT_STATIC_CALL_RO_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
 #else /* Generic implementation */
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index c4c4efb6f6fa..06293067424f 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -80,11 +80,11 @@ struct static_call_key {
 #endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
 
 #ifdef MODULE
-#define __STATIC_CALL_MOD_ADDRESSABLE(name)
-#define static_call_mod(name)	__raw_static_call(name)
+#define __STATIC_CALL_RO_ADDRESSABLE(name)
+#define static_call_ro(name)	__raw_static_call(name)
 #else
-#define __STATIC_CALL_MOD_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
-#define static_call_mod(name)	__static_call(name)
+#define __STATIC_CALL_RO_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
+#define static_call_ro(name)	__static_call(name)
 #endif
 
 #define static_call(name)	__static_call(name)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index af017e038b48..a89de2a2d8f8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6824,7 +6824,7 @@ EXPORT_SYMBOL(preempt_schedule);
 #define preempt_schedule_dynamic_disabled	NULL
 #endif
 DEFINE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
-EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
+EXPORT_STATIC_CALL_RO(preempt_schedule);
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule);
 void __sched notrace dynamic_preempt_schedule(void)
@@ -6897,7 +6897,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 #define preempt_schedule_notrace_dynamic_disabled	NULL
 #endif
 DEFINE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_dynamic_enabled);
-EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
+EXPORT_STATIC_CALL_RO(preempt_schedule_notrace);
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule_notrace);
 void __sched notrace dynamic_preempt_schedule_notrace(void)
@@ -8493,12 +8493,12 @@ EXPORT_SYMBOL(__cond_resched);
 #define cond_resched_dynamic_enabled	__cond_resched
 #define cond_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
-EXPORT_STATIC_CALL_TRAMP(cond_resched);
+EXPORT_STATIC_CALL_RO(cond_resched);
 
 #define might_resched_dynamic_enabled	__cond_resched
 #define might_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
-EXPORT_STATIC_CALL_TRAMP(might_resched);
+EXPORT_STATIC_CALL_RO(might_resched);
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 static DEFINE_STATIC_KEY_FALSE(sk_dynamic_cond_resched);
 int __sched dynamic_cond_resched(void)
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index c4c4efb6f6fa..06293067424f 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -80,11 +80,11 @@ struct static_call_key {
 #endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
 
 #ifdef MODULE
-#define __STATIC_CALL_MOD_ADDRESSABLE(name)
-#define static_call_mod(name)	__raw_static_call(name)
+#define __STATIC_CALL_RO_ADDRESSABLE(name)
+#define static_call_ro(name)	__raw_static_call(name)
 #else
-#define __STATIC_CALL_MOD_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
-#define static_call_mod(name)	__static_call(name)
+#define __STATIC_CALL_RO_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
+#define static_call_ro(name)	__static_call(name)
 #endif
 
 #define static_call(name)	__static_call(name)
-- 
2.39.2

