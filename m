Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA487291B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbjFIHtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239120AbjFIHrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27B4210C;
        Fri,  9 Jun 2023 00:47:43 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vlHTX3+aA/2+zboelFSuY6ojH1eXBOnVryBW0r+TA6c=;
        b=KZfjmxMj+Bu5VvTgaiuO45PgX/o77sVetHbu/o/1Wyi5pYgKHXA7pOKr8beiIKgwbvb3vF
        RM1Uq6oWNvajhT4Wwe73+SsC5YxCZwsFtiWug2iFXdIcnoSJ/pQvB/4NsPZ73GVrK04zfs
        Q+84uYKlf1J6zFsN//WHErt8tNeplPXvXfVRPgejkmcyNtOHtD/4H+DvPAOk1cuglNj1nk
        xewD1rooI8hOXt/3OzFtdW00AOj8islzqGk9k21s+BwykK9DlLXnDeELACRPZAaQNhxAh6
        eV89FEpKMT6YXqpdS9Ao+UshrkyixH8v349xzBbJ9JFvPjit2cWGpsyU4DTPzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vlHTX3+aA/2+zboelFSuY6ojH1eXBOnVryBW0r+TA6c=;
        b=twi8vI3HA/cHgiW+9/AXXPwcY2ciX/PorlU2qCUULLyoOqpKMuokQgDiTbFmYJxTJnwZVd
        kv673jHbwsPc7iDA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Allow stack operations in
 UNWIND_HINT_UNDEFINED regions
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <820c5b433f17c84e8761fb7465a8d319d706b1cf.1685981486.git.jpoimboe@kernel.org>
References: <820c5b433f17c84e8761fb7465a8d319d706b1cf.1685981486.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629686051.404.16012940122573453456.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     1e4b619185e83e54aca617cf5070c64a88fe936b
Gitweb:        https://git.kernel.org/tip/1e4b619185e83e54aca617cf5070c64a88fe936b
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 05 Jun 2023 09:12:21 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:11 -07:00

objtool: Allow stack operations in UNWIND_HINT_UNDEFINED regions

If the code specified UNWIND_HINT_UNDEFINED, skip the "undefined stack
state" warning due to a stack operation.  Just ignore the stack op and
continue to propagate the undefined state.

Link: https://lore.kernel.org/r/820c5b433f17c84e8761fb7465a8d319d706b1cf.1685981486.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 12 ++++++++++++
 tools/objtool/include/objtool/cfi.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4b869de..b11c25a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -33,6 +33,7 @@ static unsigned long nr_cfi, nr_cfi_reused, nr_cfi_cache;
 static struct cfi_init_state initial_func_cfi;
 static struct cfi_state init_cfi;
 static struct cfi_state func_cfi;
+static struct cfi_state force_undefined_cfi;
 
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset)
@@ -2240,6 +2241,11 @@ static int read_unwind_hints(struct objtool_file *file)
 
 		insn->hint = true;
 
+		if (hint->type == UNWIND_HINT_TYPE_UNDEFINED) {
+			insn->cfi = &force_undefined_cfi;
+			continue;
+		}
+
 		if (hint->type == UNWIND_HINT_TYPE_SAVE) {
 			insn->hint = false;
 			insn->save = true;
@@ -2793,6 +2799,10 @@ static int update_cfi_state(struct instruction *insn,
 	struct cfi_reg *cfa = &cfi->cfa;
 	struct cfi_reg *regs = cfi->regs;
 
+	/* ignore UNWIND_HINT_UNDEFINED regions */
+	if (cfi->force_undefined)
+		return 0;
+
 	/* stack operations don't make sense with an undefined CFA */
 	if (cfa->base == CFI_UNDEFINED) {
 		if (insn_func(insn)) {
@@ -4607,6 +4617,8 @@ int check(struct objtool_file *file)
 	init_cfi_state(&init_cfi);
 	init_cfi_state(&func_cfi);
 	set_func_state(&func_cfi);
+	init_cfi_state(&force_undefined_cfi);
+	force_undefined_cfi.force_undefined = true;
 
 	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3)))
 		goto out;
diff --git a/tools/objtool/include/objtool/cfi.h b/tools/objtool/include/objtool/cfi.h
index b1258e7..c8a6bec 100644
--- a/tools/objtool/include/objtool/cfi.h
+++ b/tools/objtool/include/objtool/cfi.h
@@ -36,6 +36,7 @@ struct cfi_state {
 	bool drap;
 	bool signal;
 	bool end;
+	bool force_undefined;
 };
 
 #endif /* _OBJTOOL_CFI_H */
