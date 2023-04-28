Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A04B6F14BE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346016AbjD1J4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345778AbjD1J4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:56:12 -0400
Received: from out0-210.mail.aliyun.com (out0-210.mail.aliyun.com [140.205.0.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9B25599;
        Fri, 28 Apr 2023 02:55:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047213;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---.STFoGdv_1682675616;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STFoGdv_1682675616)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:53:37 +0800
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
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Sathvika Vasireddy" <sv@linux.ibm.com>,
        "=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <linux@weissschuh.net>,
        <linux-kbuild@vger.kernel.org>
Subject: [PATCH RFC 33/43] objtool: Add validation for x86 PIE support
Date:   Fri, 28 Apr 2023 17:51:13 +0800
Message-Id: <226af8c63c5bfa361763dd041a997ee84fe926cf.1682673543.git.houwenlong.hwl@antgroup.com>
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

For x86 PIE binary, only RIP-relative addressing is allowed, however,
there are still a little absolute references of R_X86_64_64 relocation
type for data section and a little absolute references of R_X86_64_32S
relocation type in pvh_start_xen() function.

Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig                        |  1 +
 scripts/Makefile.lib                    |  1 +
 tools/objtool/builtin-check.c           |  4 +-
 tools/objtool/check.c                   | 82 +++++++++++++++++++++++++
 tools/objtool/include/objtool/builtin.h |  1 +
 5 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 715f0734d065..b753a54e5ea7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2224,6 +2224,7 @@ config RELOCATABLE
 config X86_PIE
 	def_bool n
 	depends on X86_64
+	select OBJTOOL if HAVE_OBJTOOL
 
 config RANDOMIZE_BASE
 	bool "Randomize the address of the kernel image (KASLR)"
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 100a386fcd71..e3c804fbc421 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -270,6 +270,7 @@ objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
 objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess
 objtool-args-$(CONFIG_GCOV_KERNEL)			+= --no-unreachable
 objtool-args-$(CONFIG_PREFIX_SYMBOLS)			+= --prefix=$(CONFIG_FUNCTION_PADDING_BYTES)
+objtool-args-$(CONFIG_X86_PIE)			        += --pie
 
 objtool-args = $(objtool-args-y)					\
 	$(if $(delay-objtool), --link)					\
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 7c175198d09f..1cf1d00464e0 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -81,6 +81,7 @@ static const struct option check_options[] = {
 	OPT_BOOLEAN('t', "static-call", &opts.static_call, "annotate static calls"),
 	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP"),
 	OPT_BOOLEAN(0  , "cfi", &opts.cfi, "annotate kernel control flow integrity (kCFI) function preambles"),
+	OPT_BOOLEAN(0, "pie", &opts.pie, "validate addressing rules for PIE"),
 	OPT_CALLBACK_OPTARG(0, "dump", NULL, NULL, "orc", "dump metadata", parse_dump),
 
 	OPT_GROUP("Options:"),
@@ -137,7 +138,8 @@ static bool opts_valid(void)
 	    opts.sls			||
 	    opts.stackval		||
 	    opts.static_call		||
-	    opts.uaccess) {
+	    opts.uaccess		||
+	    opts.pie) {
 		if (opts.dump_orc) {
 			ERROR("--dump can't be combined with other options");
 			return false;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5b600bbf2389..d67b80251eec 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -131,6 +131,27 @@ static struct instruction *prev_insn_same_sym(struct objtool_file *file,
 	for (insn = next_insn_same_sec(file, insn); insn;		\
 	     insn = next_insn_same_sec(file, insn))
 
+static struct instruction *find_insn_containing(struct objtool_file *file,
+						struct section *sec,
+						unsigned long offset)
+{
+	struct instruction *insn;
+
+	insn = find_insn(file, sec, 0);
+	if (!insn)
+		return NULL;
+
+	sec_for_each_insn_from(file, insn) {
+		if (insn->offset > offset)
+			return NULL;
+		if (insn->offset <= offset && (insn->offset + insn->len) > offset)
+			return insn;
+	}
+
+	return NULL;
+}
+
+
 static inline struct symbol *insn_call_dest(struct instruction *insn)
 {
 	if (insn->type == INSN_JUMP_DYNAMIC ||
@@ -4529,6 +4550,61 @@ static int validate_reachable_instructions(struct objtool_file *file)
 	return 0;
 }
 
+static int is_in_pvh_code(struct instruction *insn)
+{
+	struct symbol *sym = insn->sym;
+
+	return sym && !strcmp(sym->name, "pvh_start_xen");
+}
+
+static int validate_pie(struct objtool_file *file)
+{
+	struct section *sec;
+	struct reloc *reloc;
+	struct instruction *insn;
+	int warnings = 0;
+
+	for_each_sec(file, sec) {
+		if (!sec->reloc)
+			continue;
+		if (!(sec->sh.sh_flags & SHF_ALLOC))
+			continue;
+
+		list_for_each_entry(reloc, &sec->reloc->reloc_list, list) {
+			switch (reloc->type) {
+			case R_X86_64_NONE:
+			case R_X86_64_PC32:
+			case R_X86_64_PLT32:
+			case R_X86_64_64:
+			case R_X86_64_PC64:
+			case R_X86_64_GOTPCREL:
+				break;
+			case R_X86_64_32:
+			case R_X86_64_32S:
+				insn = find_insn_containing(file, sec, reloc->offset);
+				if (!insn) {
+					WARN("can't find relocate insn near %s+0x%lx",
+					     sec->name, reloc->offset);
+				} else {
+					if (is_in_pvh_code(insn))
+						break;
+					WARN("insn at %s+0x%lx is not compatible with PIE",
+					     sec->name, insn->offset);
+				}
+				warnings++;
+				break;
+			default:
+				WARN("unexpected relocation type %d at %s+0x%lx",
+				     reloc->type, sec->name, reloc->offset);
+				warnings++;
+				break;
+			}
+		}
+	}
+
+	return warnings;
+}
+
 int check(struct objtool_file *file)
 {
 	int ret, warnings = 0;
@@ -4673,6 +4749,12 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
+	if (opts.pie) {
+		ret = validate_pie(file);
+		if (ret < 0)
+			return ret;
+		warnings += ret;
+	}
 
 	if (opts.stats) {
 		printf("nr_insns_visited: %ld\n", nr_insns_visited);
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 2a108e648b7a..1151211a5cea 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -26,6 +26,7 @@ struct opts {
 	bool uaccess;
 	int prefix;
 	bool cfi;
+	bool pie;
 
 	/* options: */
 	bool backtrace;
-- 
2.31.1

