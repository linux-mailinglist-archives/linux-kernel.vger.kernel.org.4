Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507A3728223
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbjFHOD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbjFHODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:03:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA3F273D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 07:03:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 35A731FDE3;
        Thu,  8 Jun 2023 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686233027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jebb4xNoc7cKLprfz+A97MNsOTZVgutG4iN5nPjlfkc=;
        b=GYwQs8ccCGYhJa45MEOP1m4CjFGK6TJKYhUVSC455AqDm89CJmZQ6O11bwpw5lbPTO7edo
        2D+jjCsXdLWSfG9Ik+NdWVEOZoi0Qbl9Y+NaLDDTGsS1/bzueLozTiwHOq2gZsT6FRu4Oq
        QonQ3otbGRNz+XsWVli45EIONpGjL4E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC05E138E6;
        Thu,  8 Jun 2023 14:03:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r/9SOMLfgWRVbwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 08 Jun 2023 14:03:46 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC PATCH 2/3] x86/alternative: add indirect call patching
Date:   Thu,  8 Jun 2023 16:03:32 +0200
Message-Id: <20230608140333.4083-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230608140333.4083-1-jgross@suse.com>
References: <20230608140333.4083-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare replacing of paravirt patching with alternative
patching, add the capability to replace an indirect call with a direct
one to alternative patching.

This is done via a new flag ALT_FLAG_CALL as the target of the call
instruction needs to be evaluated using the value of the location
addressed by the indirect call. For convenience add a macro for a
default call instruction. In case it is being used without the new
flag being set, it will result in a BUG() when being executed. As in
most cases the feature used will be X86_FEATURE_ALWAYS add another
macro ALT_CALL_ALWAYS usable for the flags parameter of the ALTERNATIVE
macros.

For a complete replacement handle the special cases of calling a nop
function and an indirect call of NULL the same way as paravirt does.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/alternative.h |  5 ++++
 arch/x86/kernel/alternative.c      | 37 +++++++++++++++++++++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index a5a4944ce5d1..8e0871c1631a 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -10,6 +10,9 @@
 
 #define ALT_FLAG_NOT		(1 << 0)
 #define ALT_NOT(feature)	((ALT_FLAG_NOT << ALT_FLAGS_SHIFT) | (feature))
+#define ALT_FLAG_CALL		(1 << 1)
+#define ALT_CALL(feature)	((ALT_FLAG_CALL << ALT_FLAGS_SHIFT) | (feature))
+#define ALT_CALL_ALWAYS		ALT_CALL(X86_FEATURE_ALWAYS)
 
 #ifndef __ASSEMBLY__
 
@@ -155,6 +158,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
 }
 #endif	/* CONFIG_SMP */
 
+#define ALT_CALL_INSTR		"call x86_BUG"
+
 #define b_replacement(num)	"664"#num
 #define e_replacement(num)	"665"#num
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b7c70479fe58..f0371304c1b5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -321,19 +321,50 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		insn_buff_sz = a->replacementlen;
 
 		/*
-		 * 0xe8 is a relative jump; fix the offset.
+		 * 0xe8 is a relative call; fix the offset.
 		 *
 		 * Instruction length is checked before the opcode to avoid
 		 * accessing uninitialized bytes for zero-length replacements.
 		 */
 		if (a->replacementlen == 5 && *insn_buff == 0xe8) {
-			*(s32 *)(insn_buff + 1) += replacement - instr;
+			s32 *displ = (s32 *)(insn_buff + 1);
+
+			if (a->flags & ALT_FLAG_CALL) {
+				u8 *f_ptr;
+
+				if (a->instrlen != 6 ||
+				    (instr[0] != 0xff && instr[1] != 0x15)) {
+					pr_err("Alternative: ALT_FLAG_CALL set for unrecognized indirect call\n");
+					pr_err("  Not replacing instruction at %pS (%px)\n",
+					       instr, instr);
+					continue;
+				}
+
+				f_ptr = *(u8 **)(instr + a->instrlen +
+						 *(s32 *)(instr + 2));
+
+				/* Replace calls of NULL with explicit BUG(). */
+				if (!f_ptr)
+					f_ptr = (u8 *)x86_BUG;
+
+				/* Replace a nop call with nops. */
+				if (f_ptr == (u8 *)x86_nop)
+					insn_buff_sz = 0;
+				else
+					*displ = f_ptr - (instr + insn_buff_sz);
+			} else {
+				*displ += replacement - instr;
+			}
 			DPRINTK("Fix CALL offset: 0x%x, CALL 0x%lx",
 				*(s32 *)(insn_buff + 1),
 				(unsigned long)instr + *(s32 *)(insn_buff + 1) + 5);
+		} else if (a->flags & ALT_FLAG_CALL) {
+			pr_err("Alternative: ALT_FLAG_CALL set for a non-call replacement instruction\n");
+			pr_err("  Ignoring the flag for instruction at %pS (%px)\n",
+			       instr, instr);
 		}
 
-		if (a->replacementlen && is_jmp(replacement[0]))
+		if (insn_buff_sz && is_jmp(replacement[0]))
 			recompute_jump(a, instr, replacement, insn_buff);
 
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
-- 
2.35.3

