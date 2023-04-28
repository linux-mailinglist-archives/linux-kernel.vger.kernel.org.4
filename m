Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868D46F1495
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345840AbjD1Jxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345869AbjD1JxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:53:13 -0400
Received: from out0-208.mail.aliyun.com (out0-208.mail.aliyun.com [140.205.0.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028E42726
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 02:52:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047187;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---.STFQGHW_1682675543;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STFQGHW_1682675543)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:52:24 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Juergen Gross" <jgross@suse.com>,
        "=?UTF-8?B?U3JpdmF0c2EgUy4gQmhhdCAoVk13YXJlKQ==?=" 
        <srivatsa@csail.mit.edu>, "Alexey Makhalov" <amakhalov@vmware.com>,
        "VMware PV-Drivers Reviewers" <pv-drivers@vmware.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Song Liu" <song@kernel.org>, "Nadav Amit" <namit@vmware.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH RFC 13/43] x86/paravirt: Use relative reference for original instruction
Date:   Fri, 28 Apr 2023 17:50:53 +0800
Message-Id: <d0e601438f4d140c0c383c6ad09483b34c7c572e.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the alternative patching, use relative reference for original
instruction rather than absolute one, which saves 8 bytes for one entry
on x86_64.  And it could generate R_X86_64_PC32 relocation instead of
R_X86_64_64 relocation, which also reduces relocation metadata on
relocatable builds. And the alignment could be hard coded to be 4 now.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/paravirt.h       | 10 +++++-----
 arch/x86/include/asm/paravirt_types.h |  8 ++++----
 arch/x86/kernel/alternative.c         |  8 +++++---
 arch/x86/kernel/callthunks.c          |  2 +-
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index b49778664d2b..2350ceb43db0 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -742,16 +742,16 @@ extern void default_banner(void);
 
 #else  /* __ASSEMBLY__ */
 
-#define _PVSITE(ptype, ops, word, algn)		\
+#define _PVSITE(ptype, ops)			\
 771:;						\
 	ops;					\
 772:;						\
 	.pushsection .parainstructions,"a";	\
-	 .align	algn;				\
-	 word 771b;				\
+	 .align	4;				\
+	 .long 771b-.;				\
 	 .byte ptype;				\
 	 .byte 772b-771b;			\
-	 _ASM_ALIGN;				\
+	 .align 4;				\
 	.popsection
 
 
@@ -759,7 +759,7 @@ extern void default_banner(void);
 #ifdef CONFIG_PARAVIRT_XXL
 
 #define PARA_PATCH(off)		((off) / 8)
-#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
+#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops)
 #define PARA_INDIRECT(addr)	*addr(%rip)
 
 #ifdef CONFIG_DEBUG_ENTRY
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 4acbcddddc29..982a234f5a06 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -5,7 +5,7 @@
 #ifndef __ASSEMBLY__
 /* These all sit in the .parainstructions section to tell us what to patch. */
 struct paravirt_patch_site {
-	u8 *instr;		/* original instructions */
+	s32 instr_offset;	/* original instructions */
 	u8 type;		/* type of this instruction */
 	u8 len;			/* length of original instruction */
 };
@@ -270,11 +270,11 @@ extern struct paravirt_patch_template pv_ops;
 #define _paravirt_alt(insn_string, type)		\
 	"771:\n\t" insn_string "\n" "772:\n"		\
 	".pushsection .parainstructions,\"a\"\n"	\
-	_ASM_ALIGN "\n"					\
-	_ASM_PTR " 771b\n"				\
+	"  .align 4\n"					\
+	"  .long 771b-.\n"				\
 	"  .byte " type "\n"				\
 	"  .byte 772b-771b\n"				\
-	_ASM_ALIGN "\n"					\
+	"  .align 4\n"					\
 	".popsection\n"
 
 /* Generate patchable code, with the default asm parameters. */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index f615e0cb6d93..25c59da6c53b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1230,20 +1230,22 @@ void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
 {
 	struct paravirt_patch_site *p;
 	char insn_buff[MAX_PATCH_LEN];
+	u8 *instr;
 
 	for (p = start; p < end; p++) {
 		unsigned int used;
 
+		instr = (u8 *)&p->instr_offset + p->instr_offset;
 		BUG_ON(p->len > MAX_PATCH_LEN);
 		/* prep the buffer with the original instructions */
-		memcpy(insn_buff, p->instr, p->len);
-		used = paravirt_patch(p->type, insn_buff, (unsigned long)p->instr, p->len);
+		memcpy(insn_buff, instr, p->len);
+		used = paravirt_patch(p->type, insn_buff, (unsigned long)instr, p->len);
 
 		BUG_ON(used > p->len);
 
 		/* Pad the rest with nops */
 		add_nops(insn_buff + used, p->len - used);
-		text_poke_early(p->instr, insn_buff, p->len);
+		text_poke_early(instr, insn_buff, p->len);
 	}
 }
 extern struct paravirt_patch_site __start_parainstructions[],
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index ffea98f9064b..f15405acfd42 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -245,7 +245,7 @@ patch_paravirt_call_sites(struct paravirt_patch_site *start,
 	struct paravirt_patch_site *p;
 
 	for (p = start; p < end; p++)
-		patch_call(p->instr, ct);
+		patch_call((void *)&p->instr_offset + p->instr_offset, ct);
 }
 
 static __init_or_module void
-- 
2.31.1

