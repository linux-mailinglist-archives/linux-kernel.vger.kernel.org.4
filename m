Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6366F14A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345902AbjD1JzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345706AbjD1JzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:55:05 -0400
Received: from out0-201.mail.aliyun.com (out0-201.mail.aliyun.com [140.205.0.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C344EE2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 02:54:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047205;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---.STFQGTg_1682675609;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STFQGTg_1682675609)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:53:30 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Petr Mladek" <pmladek@suse.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Song Liu" <song@kernel.org>,
        "Julian Pidancet" <julian.pidancet@oracle.com>,
        "Ard Biesheuvel" <ardb@kernel.org>
Subject: [PATCH RFC 31/43] x86/modules: Adapt module loading for PIE support
Date:   Fri, 28 Apr 2023 17:51:11 +0800
Message-Id: <c79285bfa4450fd5ad160ddd4919ac9ad826de04.1682673543.git.houwenlong.hwl@antgroup.com>
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

Adapt module loading to support PIE relocations. No GOT is generared for
module, all the GOT entry of got references in module should exist in
kernel GOT.  Currently, there is only one usable got reference for
__fentry__().

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/sections.h |  5 +++++
 arch/x86/kernel/module.c        | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index a6e8373a5170..dc1c2b08ec48 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -12,6 +12,11 @@ extern char __end_rodata_aligned[];
 
 #if defined(CONFIG_X86_64)
 extern char __end_rodata_hpage_align[];
+
+#ifdef CONFIG_X86_PIE
+extern char __start_got[], __end_got[];
+#endif
+
 #endif
 
 extern char __end_of_kernel_reserve[];
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 84ad0e61ba6e..051f88e6884e 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -129,6 +129,18 @@ int apply_relocate(Elf32_Shdr *sechdrs,
 	return 0;
 }
 #else /*X86_64*/
+#ifdef CONFIG_X86_PIE
+static u64 find_got_kernel_entry(Elf64_Sym *sym, const Elf64_Rela *rela)
+{
+	u64 *pos;
+
+	for (pos = (u64 *)__start_got; pos < (u64 *)__end_got; pos++)
+		if (*pos == sym->st_value)
+			return (u64)pos + rela->r_addend;
+	return 0;
+}
+#endif
+
 static int __write_relocate_add(Elf64_Shdr *sechdrs,
 		   const char *strtab,
 		   unsigned int symindex,
@@ -171,6 +183,7 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
 		case R_X86_64_64:
 			size = 8;
 			break;
+#ifndef CONFIG_X86_PIE
 		case R_X86_64_32:
 			if (val != *(u32 *)&val)
 				goto overflow;
@@ -181,6 +194,13 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
 				goto overflow;
 			size = 4;
 			break;
+#else
+		case R_X86_64_GOTPCREL:
+			val = find_got_kernel_entry(sym, rel);
+			if (!val)
+				goto unexpected_got_reference;
+			fallthrough;
+#endif
 		case R_X86_64_PC32:
 		case R_X86_64_PLT32:
 			val -= (u64)loc;
@@ -214,11 +234,18 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
 	}
 	return 0;
 
+#ifdef CONFIG_X86_PIE
+unexpected_got_reference:
+	pr_err("Target got entry doesn't exist in kernel got, loc %p\n", loc);
+	return -ENOEXEC;
+#else
 overflow:
 	pr_err("overflow in relocation type %d val %Lx\n",
 	       (int)ELF64_R_TYPE(rel[i].r_info), val);
 	pr_err("`%s' likely not compiled with -mcmodel=kernel\n",
 	       me->name);
+#endif
+
 	return -ENOEXEC;
 }
 
-- 
2.31.1

