Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDBE6011D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJQOzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiJQOyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F308367CA3;
        Mon, 17 Oct 2022 07:53:56 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nr1cugH5Yu0i8Cjc289xP+gGWqESMqaJMC8BByvp6Lk=;
        b=XBrPOlAg3nP7whdSBBxSlML+Do67zZsbFVkwniwgMHLhlErZ87Lgcg2Tvs7ORZ5/4XukBf
        +CgsvVdoqY4CE23sUsQ7Gu2+3omxGMbNLrXz/DCJ9jOTlz9XUoHL1aNdBFr+Hm277CswIm
        fNDDIgXC2y14Z1/UamM7/twqLaLWCmD25OF5W3/3hODz0mkciRNrWVZ4ZBchGAUG/XRABO
        NnDt6m8gG6BPTZ6E8LyPbsl1sWBEgDdjd8OxjMBZdm9HQVa8gXpYOvP5ErSjluiL+xSF6W
        58q6tqTGdR1yR5giBJLKmuP4R6baAeYrrGkIRdPjeHbLRUhEcQBFw97q8vvt/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nr1cugH5Yu0i8Cjc289xP+gGWqESMqaJMC8BByvp6Lk=;
        b=8aMEMoaUB6zVV31xtD0dRbAgAmMo5yyKTB7epiuGcdnMr6PdZazvqQkTaVRlTcfY47CxbG
        2dsSh9jo2KG1ioAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/modules: Add call patching
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111147.575673066@infradead.org>
References: <20220915111147.575673066@infradead.org>
MIME-Version: 1.0
Message-ID: <166601842378.401.4292798870470772226.tip-bot2@tip-bot2>
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

Commit-ID:     eaf44c816ed8d1ef94c354e3ed47d53cd5a5cb13
Gitweb:        https://git.kernel.org/tip/eaf44c816ed8d1ef94c354e3ed47d53cd5a5cb13
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:24 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:13 +02:00

x86/modules: Add call patching

As for the builtins create call thunks and patch the call sites to call the
thunk on Intel SKL CPUs for retbleed mitigation.

Note, that module init functions are ignored for sake of simplicity because
loading modules is not something which is done in high frequent loops and
the attacker has not really a handle on when this happens in order to
launch a matching attack. The depth tracking will still work for calls into
the builtins and because the call is not accounted it will underflow faster
and overstuff, but that's mitigated by the saturating counter and the side
effect is only temporary.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111147.575673066@infradead.org
---
 arch/x86/include/asm/alternative.h |  5 +++++
 arch/x86/kernel/callthunks.c       | 19 +++++++++++++++++++
 arch/x86/kernel/module.c           | 20 +++++++++++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 6b7bbd0..ef007fa 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -89,8 +89,13 @@ struct callthunk_sites {
 
 #ifdef CONFIG_CALL_THUNKS
 extern void callthunks_patch_builtin_calls(void);
+extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
+					  struct module *mod);
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
+static __always_inline void
+callthunks_patch_module_calls(struct callthunk_sites *sites,
+			      struct module *mod) {}
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index e5275d6..7b9d998 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -249,3 +249,22 @@ void __init callthunks_patch_builtin_calls(void)
 	thunks_initialized = true;
 	mutex_unlock(&text_mutex);
 }
+
+#ifdef CONFIG_MODULES
+void noinline callthunks_patch_module_calls(struct callthunk_sites *cs,
+					    struct module *mod)
+{
+	struct core_text ct = {
+		.base = (unsigned long)mod->core_layout.base,
+		.end  = (unsigned long)mod->core_layout.base + mod->core_layout.size,
+		.name = mod->name,
+	};
+
+	if (!thunks_initialized)
+		return;
+
+	mutex_lock(&text_mutex);
+	callthunks_setup(cs, &ct);
+	mutex_unlock(&text_mutex);
+}
+#endif /* CONFIG_MODULES */
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 43f0112..2fb9de2 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -254,7 +254,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 {
 	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
 		*para = NULL, *orc = NULL, *orc_ip = NULL,
-		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL;
+		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL,
+		*calls = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
@@ -274,6 +275,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 			retpolines = s;
 		if (!strcmp(".return_sites", secstrings + s->sh_name))
 			returns = s;
+		if (!strcmp(".call_sites", secstrings + s->sh_name))
+			calls = s;
 		if (!strcmp(".ibt_endbr_seal", secstrings + s->sh_name))
 			ibt_endbr = s;
 	}
@@ -299,6 +302,21 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *aseg = (void *)alt->sh_addr;
 		apply_alternatives(aseg, aseg + alt->sh_size);
 	}
+	if (calls || para) {
+		struct callthunk_sites cs = {};
+
+		if (calls) {
+			cs.call_start = (void *)calls->sh_addr;
+			cs.call_end = (void *)calls->sh_addr + calls->sh_size;
+		}
+
+		if (para) {
+			cs.pv_start = (void *)para->sh_addr;
+			cs.pv_end = (void *)para->sh_addr + para->sh_size;
+		}
+
+		callthunks_patch_module_calls(&cs, me);
+	}
 	if (ibt_endbr) {
 		void *iseg = (void *)ibt_endbr->sh_addr;
 		apply_ibt_endbr(iseg, iseg + ibt_endbr->sh_size);
