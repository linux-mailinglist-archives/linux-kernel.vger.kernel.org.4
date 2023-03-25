Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAD56C8995
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 01:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjCYAZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 20:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjCYAZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 20:25:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9421556E;
        Fri, 24 Mar 2023 17:25:19 -0700 (PDT)
Date:   Sat, 25 Mar 2023 00:25:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679703917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wCirbR7sB1pp/RjM9j3c9w3fwXW5dZpYmwDM/S2ffcc=;
        b=3ytJuqSTorvomifxdYqwJoVhVM89AopLzVl48ziflXJLfkiQNGRLqaD4F38tufcTlk91g/
        1uiDn8pmz5pWmiGvTS6QaaQdhyPVxbRJy5JGvV7KuS8t2jYmVv7bAGKj4V4SIsqyaTKSUb
        69fYtMl5t32JZxMTH43hVOVS7pCi/UYDp4gWY5Fm1FMk/klYXJs/okN6UUddtF1hBW2SMN
        eCrfi/LNa7gGmMCrUZzItTDJdx2tCtpMUK1rmbnrEs6CCaAAXy1C1QGdz47tmEbZt57KEn
        cc+Y883XDmd8UD2mTkT/b2YIxHlMlWiKf9ofU687KeEH/ZLXj3d65hCEjxKMeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679703917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wCirbR7sB1pp/RjM9j3c9w3fwXW5dZpYmwDM/S2ffcc=;
        b=r6wJhQ6NriVGycVrm3+sB6z928PZ4AF5RBJ80dd+ws6OE6KomONax1BR7rgw6o8OxSwe3D
        kbUZ+d89kZQeTSBQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86,objtool: Introduce ORC_TYPE_*
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <cc879d38fff8a43f8f7beb2fd56e35a5a384d7cd.1677683419.git.jpoimboe@kernel.org>
References: <cc879d38fff8a43f8f7beb2fd56e35a5a384d7cd.1677683419.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167970391736.5837.1869200891597004450.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     f902cfdd46aedd2afb3e8033223312dbf5fbb675
Gitweb:        https://git.kernel.org/tip/f902cfdd46aedd2afb3e8033223312dbf5fbb675
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 01 Mar 2023 07:13:10 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 23 Mar 2023 23:18:57 +01:00

x86,objtool: Introduce ORC_TYPE_*

Unwind hints and ORC entry types are two distinct things.  Separate them
out more explicitly.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/cc879d38fff8a43f8f7beb2fd56e35a5a384d7cd.1677683419.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/orc_types.h       |  4 ++++
 arch/x86/kernel/unwind_orc.c           | 12 ++++++------
 include/linux/objtool_types.h          |  1 +
 tools/arch/x86/include/asm/orc_types.h |  4 ++++
 tools/include/linux/objtool_types.h    |  1 +
 tools/objtool/orc_dump.c               |  7 +++----
 tools/objtool/orc_gen.c                | 19 +++++++++++++++++--
 7 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index 1343a62..b4d4ec7 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -39,6 +39,10 @@
 #define ORC_REG_SP_INDIRECT		9
 #define ORC_REG_MAX			15
 
+#define ORC_TYPE_CALL			0
+#define ORC_TYPE_REGS			1
+#define ORC_TYPE_REGS_PARTIAL		2
+
 #ifndef __ASSEMBLY__
 #include <asm/byteorder.h>
 
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 37307b4..8348ac5 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -133,7 +133,7 @@ static struct orc_entry null_orc_entry = {
 	.sp_offset = sizeof(long),
 	.sp_reg = ORC_REG_SP,
 	.bp_reg = ORC_REG_UNDEFINED,
-	.type = UNWIND_HINT_TYPE_CALL
+	.type = ORC_TYPE_CALL
 };
 
 #ifdef CONFIG_CALL_THUNKS
@@ -153,7 +153,7 @@ static struct orc_entry *orc_callthunk_find(unsigned long ip)
 
 /* Fake frame pointer entry -- used as a fallback for generated code */
 static struct orc_entry orc_fp_entry = {
-	.type		= UNWIND_HINT_TYPE_CALL,
+	.type		= ORC_TYPE_CALL,
 	.sp_reg		= ORC_REG_BP,
 	.sp_offset	= 16,
 	.bp_reg		= ORC_REG_PREV_SP,
@@ -554,7 +554,7 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	/* Find IP, SP and possibly regs: */
 	switch (orc->type) {
-	case UNWIND_HINT_TYPE_CALL:
+	case ORC_TYPE_CALL:
 		ip_p = sp - sizeof(long);
 
 		if (!deref_stack_reg(state, ip_p, &state->ip))
@@ -567,7 +567,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		state->prev_regs = NULL;
 		break;
 
-	case UNWIND_HINT_TYPE_REGS:
+	case ORC_TYPE_REGS:
 		if (!deref_stack_regs(state, sp, &state->ip, &state->sp)) {
 			orc_warn_current("can't access registers at %pB\n",
 					 (void *)orig_ip);
@@ -590,13 +590,13 @@ bool unwind_next_frame(struct unwind_state *state)
 		state->full_regs = true;
 		break;
 
-	case UNWIND_HINT_TYPE_REGS_PARTIAL:
+	case ORC_TYPE_REGS_PARTIAL:
 		if (!deref_stack_iret_regs(state, sp, &state->ip, &state->sp)) {
 			orc_warn_current("can't access iret registers at %pB\n",
 					 (void *)orig_ip);
 			goto err;
 		}
-		/* See UNWIND_HINT_TYPE_REGS case comment. */
+		/* See ORC_TYPE_REGS case comment. */
 		state->ip = unwind_recover_rethook(state, state->ip,
 				(unsigned long *)(state->sp - sizeof(long)));
 
diff --git a/include/linux/objtool_types.h b/include/linux/objtool_types.h
index 8513537..9a83468 100644
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -40,6 +40,7 @@ struct unwind_hint {
 #define UNWIND_HINT_TYPE_CALL		0
 #define UNWIND_HINT_TYPE_REGS		1
 #define UNWIND_HINT_TYPE_REGS_PARTIAL	2
+/* The below hint types don't have corresponding ORC types */
 #define UNWIND_HINT_TYPE_FUNC		3
 #define UNWIND_HINT_TYPE_ENTRY		4
 #define UNWIND_HINT_TYPE_SAVE		5
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index 1343a62..b4d4ec7 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -39,6 +39,10 @@
 #define ORC_REG_SP_INDIRECT		9
 #define ORC_REG_MAX			15
 
+#define ORC_TYPE_CALL			0
+#define ORC_TYPE_REGS			1
+#define ORC_TYPE_REGS_PARTIAL		2
+
 #ifndef __ASSEMBLY__
 #include <asm/byteorder.h>
 
diff --git a/tools/include/linux/objtool_types.h b/tools/include/linux/objtool_types.h
index 8513537..9a83468 100644
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -40,6 +40,7 @@ struct unwind_hint {
 #define UNWIND_HINT_TYPE_CALL		0
 #define UNWIND_HINT_TYPE_REGS		1
 #define UNWIND_HINT_TYPE_REGS_PARTIAL	2
+/* The below hint types don't have corresponding ORC types */
 #define UNWIND_HINT_TYPE_FUNC		3
 #define UNWIND_HINT_TYPE_ENTRY		4
 #define UNWIND_HINT_TYPE_SAVE		5
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index 9f6c528..97ecbb8 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -4,7 +4,6 @@
  */
 
 #include <unistd.h>
-#include <linux/objtool_types.h>
 #include <asm/orc_types.h>
 #include <objtool/objtool.h>
 #include <objtool/warn.h>
@@ -39,11 +38,11 @@ static const char *reg_name(unsigned int reg)
 static const char *orc_type_name(unsigned int type)
 {
 	switch (type) {
-	case UNWIND_HINT_TYPE_CALL:
+	case ORC_TYPE_CALL:
 		return "call";
-	case UNWIND_HINT_TYPE_REGS:
+	case ORC_TYPE_REGS:
 		return "regs";
-	case UNWIND_HINT_TYPE_REGS_PARTIAL:
+	case ORC_TYPE_REGS_PARTIAL:
 		return "regs (partial)";
 	default:
 		return "?";
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index f49630a..e85bbb9 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -26,6 +26,22 @@ static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi,
 		return 0;
 	}
 
+	switch (cfi->type) {
+	case UNWIND_HINT_TYPE_CALL:
+		orc->type = ORC_TYPE_CALL;
+		break;
+	case UNWIND_HINT_TYPE_REGS:
+		orc->type = ORC_TYPE_REGS;
+		break;
+	case UNWIND_HINT_TYPE_REGS_PARTIAL:
+		orc->type = ORC_TYPE_REGS_PARTIAL;
+		break;
+	default:
+		WARN_FUNC("unknown unwind hint type %d",
+			  insn->sec, insn->offset, cfi->type);
+		return -1;
+	}
+
 	orc->end = cfi->end;
 	orc->signal = cfi->signal;
 
@@ -83,7 +99,6 @@ static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi,
 
 	orc->sp_offset = cfi->cfa.offset;
 	orc->bp_offset = bp->offset;
-	orc->type = cfi->type;
 
 	return 0;
 }
@@ -151,7 +166,7 @@ int orc_create(struct objtool_file *file)
 	struct orc_entry null = {
 		.sp_reg  = ORC_REG_UNDEFINED,
 		.bp_reg  = ORC_REG_UNDEFINED,
-		.type    = UNWIND_HINT_TYPE_CALL,
+		.type    = ORC_TYPE_CALL,
 	};
 
 	/* Build a deduplicated list of ORC entries: */
