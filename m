Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE186011B7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiJQOy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiJQOxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:53:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1159691A9;
        Mon, 17 Oct 2022 07:53:45 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018415;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xQECrAMC1mfEGRDJTJK97EsmoNkBaVxGk/vgONIWcqE=;
        b=tdO0OdMCDXm6jLkvyuDjv2CvTnze2zfI1PJljEGYbJPZSqD2ZgXXKIrRQgzbwnpi6TJN/r
        n5gak0YbLK3MOT1drvS2M0sTTrRM4De8BKU8cX+lw5QQF4ESHNhRcEkojZb23gLp0vc6Jx
        oX7qAQA2FXUeFAMQVWzQ3Z+UXVEfvijC8FU10Dtg698qV+PutfFP35l2FVPXkXxQ4hJsft
        +U0bvL1rrYuqYOW22dBd5M5w7/lqJXugu5FhLMqcJbPnR+UfjzSaL5OeluHgCQeedFCQ6W
        +jyIASHxgbFJFEpw8lYd5TduCEblu3DXyJxPH9VyV9vELnEvWTGn7Vm6kL1R0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018415;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xQECrAMC1mfEGRDJTJK97EsmoNkBaVxGk/vgONIWcqE=;
        b=1C2WmxlHCifztflfdYpDfxmNCwidwt3TK3q4gjI69gCqXsh2dNYxoGTo5yooVbXZvdeR9U
        xwyDy72xocfn3oCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/orc: Make it callthunk aware
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111148.511637628@infradead.org>
References: <20220915111148.511637628@infradead.org>
MIME-Version: 1.0
Message-ID: <166601841409.401.11334103297583920367.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     396e0b8e09e86440c2119d12c2101110d3cd5bf9
Gitweb:        https://git.kernel.org/tip/396e0b8e09e86440c2119d12c2101110d3cd5bf9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:33 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:17 +02:00

x86/orc: Make it callthunk aware

Callthunks addresses on the stack would confuse the ORC unwinder. Handle
them correctly and tell ORC to proceed further down the stack.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111148.511637628@infradead.org
---
 arch/x86/include/asm/alternative.h |  5 +++++
 arch/x86/kernel/callthunks.c       | 13 +++++++++++++
 arch/x86/kernel/unwind_orc.c       | 21 ++++++++++++++++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 07ac257..4b8cd25 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -92,6 +92,7 @@ extern void callthunks_patch_builtin_calls(void);
 extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
 					  struct module *mod);
 extern void *callthunks_translate_call_dest(void *dest);
+extern bool is_callthunk(void *addr);
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
 static __always_inline void
@@ -101,6 +102,10 @@ static __always_inline void *callthunks_translate_call_dest(void *dest)
 {
 	return dest;
 }
+static __always_inline bool is_callthunk(void *addr)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 0710036..7f97881 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -293,6 +293,19 @@ void *callthunks_translate_call_dest(void *dest)
 	return target ? : dest;
 }
 
+bool is_callthunk(void *addr)
+{
+	unsigned int tmpl_size = SKL_TMPL_SIZE;
+	void *tmpl = skl_call_thunk_template;
+	unsigned long dest;
+
+	dest = roundup((unsigned long)addr, CONFIG_FUNCTION_ALIGNMENT);
+	if (!thunks_initialized || skip_addr((void *)dest))
+		return false;
+
+	return !bcmp((void *)(dest - tmpl_size), tmpl, tmpl_size);
+}
+
 #ifdef CONFIG_MODULES
 void noinline callthunks_patch_module_calls(struct callthunk_sites *cs,
 					    struct module *mod)
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 0ea57da..cfac2b5 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -136,6 +136,21 @@ static struct orc_entry null_orc_entry = {
 	.type = UNWIND_HINT_TYPE_CALL
 };
 
+#ifdef CONFIG_CALL_THUNKS
+static struct orc_entry *orc_callthunk_find(unsigned long ip)
+{
+	if (!is_callthunk((void *)ip))
+		return NULL;
+
+	return &null_orc_entry;
+}
+#else
+static struct orc_entry *orc_callthunk_find(unsigned long ip)
+{
+	return NULL;
+}
+#endif
+
 /* Fake frame pointer entry -- used as a fallback for generated code */
 static struct orc_entry orc_fp_entry = {
 	.type		= UNWIND_HINT_TYPE_CALL,
@@ -189,7 +204,11 @@ static struct orc_entry *orc_find(unsigned long ip)
 	if (orc)
 		return orc;
 
-	return orc_ftrace_find(ip);
+	orc =  orc_ftrace_find(ip);
+	if (orc)
+		return orc;
+
+	return orc_callthunk_find(ip);
 }
 
 #ifdef CONFIG_MODULES
