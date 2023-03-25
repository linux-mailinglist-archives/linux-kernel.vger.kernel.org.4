Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6612F6C8994
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 01:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjCYAZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 20:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjCYAZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 20:25:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB7015170;
        Fri, 24 Mar 2023 17:25:19 -0700 (PDT)
Date:   Sat, 25 Mar 2023 00:25:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679703918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JFrJa74silC7lUlmjXh77y0DtlJwtKvDnMDKcpCuiU=;
        b=mVn9HrmrYde0t/6tlhB221aVvdXq6clXrAU3h58faluucvn1ZzYIySTLun/Reh7YKoX9wF
        MaVNCAmvQBFn3/mEXP4/SC/MLajTcn8ycxlqBHS7uDqCVDic7xRT4Eugge7EQi7USTDTNJ
        83ALjMI55ducAnCzsdb/ljf3oJRG5qw0z5TjmsDqs9kxdzeQeEjdPzPPscjoZkta7g90Hs
        hiBxdDX2SOgxTbRN2OQ3l+zeEJF9Nl42lFFcunw7rTVN0jLXD8NVmI9pNcOZUkQ/fpXQbm
        lHkBi4oNIrKPShC8ZgreRdripjHgXildo1C9G8hjZij4K3RDpuJ16/gkHf+fdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679703918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JFrJa74silC7lUlmjXh77y0DtlJwtKvDnMDKcpCuiU=;
        b=vGpNxwNqzbJh28EbMsujF9sdjJJ9deSbChzVk6/p1hBjrcuJ/f5nd44jatkubcFWbp7qMw
        smJhuVQaOQLxQZCA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Use relative pointers for annotations
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <bed05c64e28200220c9b1754a2f3ce71f73076ea.1677683419.git.jpoimboe@kernel.org>
References: <bed05c64e28200220c9b1754a2f3ce71f73076ea.1677683419.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167970391794.5837.9706730555691010902.tip-bot2@tip-bot2>
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

Commit-ID:     1c0c1faf5692c18c127d044ecc0cc92c7bab3477
Gitweb:        https://git.kernel.org/tip/1c0c1faf5692c18c127d044ecc0cc92c7bab3477
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 01 Mar 2023 07:13:08 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 23 Mar 2023 23:18:56 +01:00

objtool: Use relative pointers for annotations

They produce the needed relocations while using half the space.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/bed05c64e28200220c9b1754a2f3ce71f73076ea.1677683419.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/nospec-branch.h |  6 +++---
 include/linux/objtool.h              | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 3ef70e5..78ed154 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -194,9 +194,9 @@
  * builds.
  */
 .macro ANNOTATE_RETPOLINE_SAFE
-	.Lannotate_\@:
+.Lhere_\@:
 	.pushsection .discard.retpoline_safe
-	_ASM_PTR .Lannotate_\@
+	.long .Lhere_\@ - .
 	.popsection
 .endm
 
@@ -318,7 +318,7 @@
 #define ANNOTATE_RETPOLINE_SAFE					\
 	"999:\n\t"						\
 	".pushsection .discard.retpoline_safe\n\t"		\
-	_ASM_PTR " 999b\n\t"					\
+	".long 999b - .\n\t"					\
 	".popsection\n\t"
 
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 8375792..2b0258d 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -49,7 +49,7 @@
 #define ANNOTATE_NOENDBR					\
 	"986: \n\t"						\
 	".pushsection .discard.noendbr\n\t"			\
-	_ASM_PTR " 986b\n\t"					\
+	".long 986b - .\n\t"					\
 	".popsection\n\t"
 
 #define ASM_REACHABLE							\
@@ -67,7 +67,7 @@
 #define ANNOTATE_INTRA_FUNCTION_CALL				\
 	999:							\
 	.pushsection .discard.intra_function_calls;		\
-	.long 999b;						\
+	.long 999b - .;						\
 	.popsection;
 
 /*
@@ -92,10 +92,10 @@
  * inconsistencies.
  */
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 signal=0 end=0
-.Lunwind_hint_ip_\@:
+.Lhere_\@:
 	.pushsection .discard.unwind_hints
 		/* struct unwind_hint */
-		.long .Lunwind_hint_ip_\@ - .
+		.long .Lhere_\@ - .
 		.short \sp_offset
 		.byte \sp_reg
 		.byte \type
@@ -107,7 +107,7 @@
 
 .macro STACK_FRAME_NON_STANDARD func:req
 	.pushsection .discard.func_stack_frame_non_standard, "aw"
-	_ASM_PTR \func
+	.long \func - .
 	.popsection
 .endm
 
@@ -120,7 +120,7 @@
 .macro ANNOTATE_NOENDBR
 .Lhere_\@:
 	.pushsection .discard.noendbr
-	.quad	.Lhere_\@
+	.long	.Lhere_\@ - .
 	.popsection
 .endm
 
