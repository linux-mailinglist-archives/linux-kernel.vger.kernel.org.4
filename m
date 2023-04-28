Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC72B6F14E8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjD1KCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjD1KBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:01:51 -0400
Received: from out0-214.mail.aliyun.com (out0-214.mail.aliyun.com [140.205.0.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B1061BE;
        Fri, 28 Apr 2023 03:01:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047187;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---.STCEPeI_1682675581;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STCEPeI_1682675581)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:53:01 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Qing Zhang" <zhangqing@loongson.cn>,
        <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH RFC 22/43] x86/ftrace: Adapt ftrace nop patching for PIE support
Date:   Fri, 28 Apr 2023 17:51:02 +0800
Message-Id: <38a5029cd2590e04209117740f8912db36eff58f.1682673543.git.houwenlong.hwl@antgroup.com>
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

From: Thomas Garnier <thgarnie@chromium.org>

From: Thomas Garnier <thgarnie@chromium.org>

When using PIE with function tracing, the compiler generates a
call through the GOT (call *__fentry__@GOTPCREL). This instruction
takes 6-bytes instead of 5-bytes with a relative call. And -mnop-mcount
option is not implemented for -fPIE now.

If PIE is enabled, replace the 6th byte of the GOT call by a 1-byte nop
so ftrace can handle the previous 5-bytes as before.

[Hou Wenlong: Adapt code change and fix wrong offset calculation in
make_nop_x86()]

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Co-developed-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/ftrace.c | 46 ++++++++++++++++++++++-
 scripts/recordmcount.c   | 81 ++++++++++++++++++++++++++--------------
 2 files changed, 98 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 5e7ead52cfdb..b795f9dde561 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -124,6 +124,50 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
 	return 0;
 }
 
+/* Bytes before call GOT offset */
+static const unsigned char got_call_preinsn[] = { 0xff, 0x15 };
+
+static int __ref
+ftrace_modify_initial_code(unsigned long ip, unsigned const char *old_code,
+			   unsigned const char *new_code)
+{
+	unsigned char replaced[MCOUNT_INSN_SIZE + 1];
+
+	/*
+	 * If PIE is not enabled default to the original approach to code
+	 * modification.
+	 */
+	if (!IS_ENABLED(CONFIG_X86_PIE))
+		return ftrace_modify_code_direct(ip, old_code, new_code);
+
+	ftrace_expected = old_code;
+
+	/* Ensure the instructions point to a call to the GOT */
+	if (copy_from_kernel_nofault(replaced, (void *)ip, sizeof(replaced))) {
+		WARN_ONCE(1, "invalid function");
+		return -EFAULT;
+	}
+
+	if (memcmp(replaced, got_call_preinsn, sizeof(got_call_preinsn))) {
+		WARN_ONCE(1, "invalid function call");
+		return -EINVAL;
+	}
+
+	/*
+	 * Build a nop slide with a 5-byte nop and 1-byte nop to keep the ftrace
+	 * hooking algorithm working with the expected 5 bytes instruction.
+	 */
+	memset(replaced, x86_nops[1][0], sizeof(replaced));
+	memcpy(replaced, new_code, MCOUNT_INSN_SIZE);
+
+	/* replace the text with the new text */
+	if (ftrace_poke_late)
+		text_poke_queue((void *)ip, replaced, MCOUNT_INSN_SIZE + 1, NULL);
+	else
+		text_poke_early((void *)ip, replaced, MCOUNT_INSN_SIZE + 1);
+	return 0;
+}
+
 int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long ip = rec->ip;
@@ -141,7 +185,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long ad
 	 * just modify the code directly.
 	 */
 	if (addr == MCOUNT_ADDR)
-		return ftrace_modify_code_direct(ip, old, new);
+		return ftrace_modify_initial_code(ip, old, new);
 
 	/*
 	 * x86 overrides ftrace_replace_code -- this function will never be used
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index e30216525325..02783a29d428 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -218,36 +218,10 @@ static void *mmap_file(char const *fname)
 	return file_map;
 }
 
-
-static unsigned char ideal_nop5_x86_64[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
-static unsigned char ideal_nop5_x86_32[5] = { 0x3e, 0x8d, 0x74, 0x26, 0x00 };
-static unsigned char *ideal_nop;
-
 static char rel_type_nop;
-
 static int (*make_nop)(void *map, size_t const offset);
 
-static int make_nop_x86(void *map, size_t const offset)
-{
-	uint32_t *ptr;
-	unsigned char *op;
-
-	/* Confirm we have 0xe8 0x0 0x0 0x0 0x0 */
-	ptr = map + offset;
-	if (*ptr != 0)
-		return -1;
-
-	op = map + offset - 1;
-	if (*op != 0xe8)
-		return -1;
-
-	/* convert to nop */
-	if (ulseek(offset - 1, SEEK_SET) < 0)
-		return -1;
-	if (uwrite(ideal_nop, 5) < 0)
-		return -1;
-	return 0;
-}
+static unsigned char *ideal_nop;
 
 static unsigned char ideal_nop4_arm_le[4] = { 0x00, 0x00, 0xa0, 0xe1 }; /* mov r0, r0 */
 static unsigned char ideal_nop4_arm_be[4] = { 0xe1, 0xa0, 0x00, 0x00 }; /* mov r0, r0 */
@@ -504,6 +478,50 @@ static void MIPS64_r_info(Elf64_Rel *const rp, unsigned sym, unsigned type)
 	}).r_info;
 }
 
+static unsigned char ideal_nop5_x86_64[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+static unsigned char ideal_nop6_x86_64[6] = { 0x66, 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+static unsigned char ideal_nop5_x86_32[5] = { 0x3e, 0x8d, 0x74, 0x26, 0x00 };
+static size_t ideal_nop_x86_size;
+
+static unsigned char stub_default_x86[2] = { 0xe8, 0x00 };   /* call relative */
+static unsigned char stub_got_x86[3] = { 0xff, 0x15, 0x00 }; /* call .got */
+static unsigned char *stub_x86;
+static size_t stub_x86_size;
+
+static int make_nop_x86(void *map, size_t const offset)
+{
+	uint32_t *ptr;
+	size_t stub_offset = offset + 1 - stub_x86_size;
+
+	/* Confirm we have the expected stub */
+	ptr = map + stub_offset;
+	if (memcmp(ptr, stub_x86, stub_x86_size))
+		return -1;
+
+	/* convert to nop */
+	if (ulseek(stub_offset, SEEK_SET) < 0)
+		return -1;
+	if (uwrite(ideal_nop, ideal_nop_x86_size) < 0)
+		return -1;
+	return 0;
+}
+
+/* Swap the stub and nop for a got call if the binary is built with PIE */
+static int is_fake_mcount_x86_x64(Elf64_Rel const *rp)
+{
+	if (ELF64_R_TYPE(rp->r_info) == R_X86_64_GOTPCREL) {
+		ideal_nop = ideal_nop6_x86_64;
+		ideal_nop_x86_size = sizeof(ideal_nop6_x86_64);
+		stub_x86 = stub_got_x86;
+		stub_x86_size = sizeof(stub_got_x86);
+		mcount_adjust_64 = 1 - stub_x86_size;
+	}
+
+	/* Once the relocation was checked, rollback to default */
+	is_fake_mcount64 = fn_is_fake_mcount64;
+	return is_fake_mcount64(rp);
+}
+
 static int do_file(char const *const fname)
 {
 	unsigned int reltype = 0;
@@ -568,6 +586,9 @@ static int do_file(char const *const fname)
 		rel_type_nop = R_386_NONE;
 		make_nop = make_nop_x86;
 		ideal_nop = ideal_nop5_x86_32;
+		ideal_nop_x86_size = sizeof(ideal_nop5_x86_32);
+		stub_x86 = stub_default_x86;
+		stub_x86_size = sizeof(stub_default_x86);
 		mcount_adjust_32 = -1;
 		gpfx = 0;
 		break;
@@ -597,9 +618,13 @@ static int do_file(char const *const fname)
 	case EM_X86_64:
 		make_nop = make_nop_x86;
 		ideal_nop = ideal_nop5_x86_64;
+		ideal_nop_x86_size = sizeof(ideal_nop5_x86_64);
+		stub_x86 = stub_default_x86;
+		stub_x86_size = sizeof(stub_default_x86);
 		reltype = R_X86_64_64;
 		rel_type_nop = R_X86_64_NONE;
-		mcount_adjust_64 = -1;
+		is_fake_mcount64 = is_fake_mcount_x86_x64;
+		mcount_adjust_64 = 1 - stub_x86_size;
 		gpfx = 0;
 		break;
 	}  /* end switch */
-- 
2.31.1

