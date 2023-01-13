Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C78D66972E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbjAMMdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbjAMMcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216324FCD5;
        Fri, 13 Jan 2023 04:31:10 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wDbKxqGYeN5BCJlyVJxQ3gTA0fCKqletaO/hYXAUUnc=;
        b=vlO/ICev8KZN9TQl3yzW+cLGUJp6hWkhzFsvaQKQ67Ul6emOvti3t5IRszCEc23vlNWV1t
        kuUDyzaPQfCDf7ydIY7Q1kCcALg4MUTHHK8GeUwK7rysULSrVUMXAklzt0JAvF8weh/YG4
        Rk2wrsZAHDOPIBxn8MtzJpq7N/YAk5Q3h0HqCPJrf/CFvAkvnOo/lvtd1k4XVBqdVyXfb4
        5nLMJ8ZRTC5wN3v2gEk1gNyZqUr092bB9jlU/yQ16h+hCUh5fpckB412XmJOinfZO6LkOv
        cNSAqJbk2c66aaghjAbAD3qNEPXk/I9iY68bnIp1+grl0TOAELxMGQy63EiIeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wDbKxqGYeN5BCJlyVJxQ3gTA0fCKqletaO/hYXAUUnc=;
        b=vs9samWpAq+oNZD3JEF5YPfkZiLzQC92ChC09IxWdgbv3sJU6tNvWZBJ5sgfRlZbHHTQKU
        hZFlhv22R2fnG4BQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] entry, kasan, x86: Disallow overriding mem*() functions
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195542.028523143@infradead.org>
References: <20230112195542.028523143@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306621.4906.6454025554442390032.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     69d4c0d3218692ffa56b0e1b9c76c50c699d7044
Gitweb:        https://git.kernel.org/tip/69d4c0d3218692ffa56b0e1b9c76c50c699d7044
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:17 +01:00

entry, kasan, x86: Disallow overriding mem*() functions

KASAN cannot just hijack the mem*() functions, it needs to emit
__asan_mem*() variants if it wants instrumentation (other sanitizers
already do this).

  vmlinux.o: warning: objtool: sync_regs+0x24: call to memcpy() leaves .noinstr.text section
  vmlinux.o: warning: objtool: vc_switch_off_ist+0xbe: call to memcpy() leaves .noinstr.text section
  vmlinux.o: warning: objtool: fixup_bad_iret+0x36: call to memset() leaves .noinstr.text section
  vmlinux.o: warning: objtool: __sev_get_ghcb+0xa0: call to memcpy() leaves .noinstr.text section
  vmlinux.o: warning: objtool: __sev_put_ghcb+0x35: call to memcpy() leaves .noinstr.text section

Remove the weak aliases to ensure nobody hijacks these functions and
add them to the noinstr section.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195542.028523143@infradead.org
---
 arch/x86/lib/memcpy_64.S  |  5 ++---
 arch/x86/lib/memmove_64.S |  4 +++-
 arch/x86/lib/memset_64.S  |  4 +++-
 mm/kasan/kasan.h          |  4 ++++-
 mm/kasan/shadow.c         | 38 ++++++++++++++++++++++++++++++++++++++-
 tools/objtool/check.c     |  3 +++-
 6 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index dd8cd88..a640176 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -8,7 +8,7 @@
 #include <asm/alternative.h>
 #include <asm/export.h>
 
-.pushsection .noinstr.text, "ax"
+.section .noinstr.text, "ax"
 
 /*
  * We build a jump to memcpy_orig by default which gets NOPped out on
@@ -43,7 +43,7 @@ SYM_TYPED_FUNC_START(__memcpy)
 SYM_FUNC_END(__memcpy)
 EXPORT_SYMBOL(__memcpy)
 
-SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
+SYM_FUNC_ALIAS(memcpy, __memcpy)
 EXPORT_SYMBOL(memcpy)
 
 /*
@@ -184,4 +184,3 @@ SYM_FUNC_START_LOCAL(memcpy_orig)
 	RET
 SYM_FUNC_END(memcpy_orig)
 
-.popsection
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 724bbf8..0266186 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -13,6 +13,8 @@
 
 #undef memmove
 
+.section .noinstr.text, "ax"
+
 /*
  * Implement memmove(). This can handle overlap between src and dst.
  *
@@ -213,5 +215,5 @@ SYM_FUNC_START(__memmove)
 SYM_FUNC_END(__memmove)
 EXPORT_SYMBOL(__memmove)
 
-SYM_FUNC_ALIAS_WEAK(memmove, __memmove)
+SYM_FUNC_ALIAS(memmove, __memmove)
 EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index fc9ffd3..6143b1a 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -6,6 +6,8 @@
 #include <asm/alternative.h>
 #include <asm/export.h>
 
+.section .noinstr.text, "ax"
+
 /*
  * ISO C memset - set a memory block to a byte value. This function uses fast
  * string to get better performance than the original function. The code is
@@ -43,7 +45,7 @@ SYM_FUNC_START(__memset)
 SYM_FUNC_END(__memset)
 EXPORT_SYMBOL(__memset)
 
-SYM_FUNC_ALIAS_WEAK(memset, __memset)
+SYM_FUNC_ALIAS(memset, __memset)
 EXPORT_SYMBOL(memset)
 
 /*
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index ea8cf13..71c1543 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -618,6 +618,10 @@ void __asan_set_shadow_f3(const void *addr, size_t size);
 void __asan_set_shadow_f5(const void *addr, size_t size);
 void __asan_set_shadow_f8(const void *addr, size_t size);
 
+void *__asan_memset(void *addr, int c, size_t len);
+void *__asan_memmove(void *dest, const void *src, size_t len);
+void *__asan_memcpy(void *dest, const void *src, size_t len);
+
 void __hwasan_load1_noabort(unsigned long addr);
 void __hwasan_store1_noabort(unsigned long addr);
 void __hwasan_load2_noabort(unsigned long addr);
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 2fba1f5..9826993 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -38,6 +38,12 @@ bool __kasan_check_write(const volatile void *p, unsigned int size)
 }
 EXPORT_SYMBOL(__kasan_check_write);
 
+#ifndef CONFIG_GENERIC_ENTRY
+/*
+ * CONFIG_GENERIC_ENTRY relies on compiler emitted mem*() calls to not be
+ * instrumented. KASAN enabled toolchains should emit __asan_mem*() functions
+ * for the sites they want to instrument.
+ */
 #undef memset
 void *memset(void *addr, int c, size_t len)
 {
@@ -68,6 +74,38 @@ void *memcpy(void *dest, const void *src, size_t len)
 
 	return __memcpy(dest, src, len);
 }
+#endif
+
+void *__asan_memset(void *addr, int c, size_t len)
+{
+	if (!kasan_check_range((unsigned long)addr, len, true, _RET_IP_))
+		return NULL;
+
+	return __memset(addr, c, len);
+}
+EXPORT_SYMBOL(__asan_memset);
+
+#ifdef __HAVE_ARCH_MEMMOVE
+void *__asan_memmove(void *dest, const void *src, size_t len)
+{
+	if (!kasan_check_range((unsigned long)src, len, false, _RET_IP_) ||
+	    !kasan_check_range((unsigned long)dest, len, true, _RET_IP_))
+		return NULL;
+
+	return __memmove(dest, src, len);
+}
+EXPORT_SYMBOL(__asan_memmove);
+#endif
+
+void *__asan_memcpy(void *dest, const void *src, size_t len)
+{
+	if (!kasan_check_range((unsigned long)src, len, false, _RET_IP_) ||
+	    !kasan_check_range((unsigned long)dest, len, true, _RET_IP_))
+		return NULL;
+
+	return __memcpy(dest, src, len);
+}
+EXPORT_SYMBOL(__asan_memcpy);
 
 void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9767bab..92554c5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1074,6 +1074,9 @@ static const char *uaccess_safe_builtin[] = {
 	"__asan_store16_noabort",
 	"__kasan_check_read",
 	"__kasan_check_write",
+	"__asan_memset",
+	"__asan_memmove",
+	"__asan_memcpy",
 	/* KASAN in-line */
 	"__asan_report_load_n_noabort",
 	"__asan_report_load1_noabort",
