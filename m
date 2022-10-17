Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2136011EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiJQO43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiJQOyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44762691A5;
        Mon, 17 Oct 2022 07:54:05 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DuN0mXwWkXkPpbB55PqFQ+7RoejEE6nRQT+hjzfltP4=;
        b=zkZwcE9gGOX7PbT3GwSVVM4TN2w/tFLQDSrelW/eujv4kbNICfCOcVG8D/5Om1Q71YoYbJ
        aSPJt71sbft9YQ+niFXaMloW9rmWRuzqSruJlZ/akjV4rDquj4ZOZHK3URPlGA+EKn75vF
        XDaX6cieJqvgzsD778nXzZWs9x0+k+rP9QWz49iLTa86HXefZ/CNF0zoGGMGWseAyocpLb
        NoiM4VnCRb5MxbxFPE/NNfJm8tKem4cKSVW25hjFPbPurJrRb2GnIwwnYeOc4+HyiVmPUR
        UnHaufphB+vA0DvkjMOwmydYZ3SBqC9uATy3M/jHkKI08sql8j9D7OyEa0RsGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DuN0mXwWkXkPpbB55PqFQ+7RoejEE6nRQT+hjzfltP4=;
        b=kQ5jW4dgw3aVNMAbukPFjwwLHGGY3znm4eokzM34s/wKjUfnhI3dAcARgkR1/Izhyfcu4o
        DbUOZK3dQx1fNEBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Allow !PC relative relocations
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111145.806607235@infradead.org>
References: <20220915111145.806607235@infradead.org>
MIME-Version: 1.0
Message-ID: <166601844226.401.9535379202269375669.tip-bot2@tip-bot2>
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

Commit-ID:     61c6065ef7ec0447a280179d04b2d81c80c2f479
Gitweb:        https://git.kernel.org/tip/61c6065ef7ec0447a280179d04b2d81c80c2f479
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:07 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:06 +02:00

objtool: Allow !PC relative relocations

Objtool doesn't currently much like per-cpu usage in alternatives:

arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0xf: unsupported relocation in alternatives section
  f:   65 c7 04 25 00 00 00 00 00 00 00 80     movl   $0x80000000,%gs:0x0      13: R_X86_64_32S        __x86_call_depth

Since the R_X86_64_32S relocation is location invariant (it's
computation doesn't include P - the address of the location itself),
it can be trivially allowed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111145.806607235@infradead.org
---
 tools/objtool/arch/x86/decode.c      | 24 ++++++++++++++++++++++++
 tools/objtool/check.c                |  2 +-
 tools/objtool/include/objtool/arch.h |  2 ++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 1c253b4..f094383 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -73,6 +73,30 @@ unsigned long arch_jump_destination(struct instruction *insn)
 	return insn->offset + insn->len + insn->immediate;
 }
 
+bool arch_pc_relative_reloc(struct reloc *reloc)
+{
+	/*
+	 * All relocation types where P (the address of the target)
+	 * is included in the computation.
+	 */
+	switch (reloc->type) {
+	case R_X86_64_PC8:
+	case R_X86_64_PC16:
+	case R_X86_64_PC32:
+	case R_X86_64_PC64:
+
+	case R_X86_64_PLT32:
+	case R_X86_64_GOTPC32:
+	case R_X86_64_GOTPCREL:
+		return true;
+
+	default:
+		break;
+	}
+
+	return false;
+}
+
 #define ADD_OP(op) \
 	if (!(op = calloc(1, sizeof(*op)))) \
 		return -1; \
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 43ec14c..7174bba 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1645,7 +1645,7 @@ static int handle_group_alt(struct objtool_file *file,
 		 * accordingly.
 		 */
 		alt_reloc = insn_reloc(file, insn);
-		if (alt_reloc &&
+		if (alt_reloc && arch_pc_relative_reloc(alt_reloc) &&
 		    !arch_support_alt_relocation(special_alt, insn, alt_reloc)) {
 
 			WARN_FUNC("unsupported relocation in alternatives section",
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index beb2f3a..fe2ea4b 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -93,4 +93,6 @@ bool arch_is_rethunk(struct symbol *sym);
 
 int arch_rewrite_retpolines(struct objtool_file *file);
 
+bool arch_pc_relative_reloc(struct reloc *reloc);
+
 #endif /* _ARCH_H */
