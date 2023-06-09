Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F987291BC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbjFIHtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbjFIHrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8821FEC;
        Fri,  9 Jun 2023 00:47:43 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQyAldtrmSj2NV7EKTjOZmLpODWIu6tI0pJDC0ncpEw=;
        b=ZFHZiuTsNf9JnzIFfL6gUuBG0KTdk98iONBOYJ+1CDLNbVAFqPQWccwGcNy2Xeu8GVNQI6
        9ag7OhrMmte2L9CrsN4o5Gwo2vvu98WF9tKbdOoPsY7j2PIJHTwV/c0Og7ZjjAj2a7NZxr
        RMZS4l0s5ORxotF7B+Q/eEb42mtQpLmdiHJ6v+kNBlf02SMAwgiL61xrmxR6qYeQA+jzse
        LTL+FZ1AIRm4rzHmIbKkWxxRMxewdQ1F5dqGgxAi+/RrK/HXi6f4yR4fhHcc+QGCgLZnbW
        fw0Tvqb2ob19QJtiN/wnDz3eBU1IH0pogOXrAl3Znno+lc2qGwSgVaA43N5ArA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQyAldtrmSj2NV7EKTjOZmLpODWIu6tI0pJDC0ncpEw=;
        b=GZeNQKylPeJTyt+3sFE681xMtYi/uTcuFPekEzqNfgfTahx1fABaHSpX9mmX9y31tiOkSQ
        zpXclkEPKgKbX/DA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove flags argument from elf_create_section()
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <515235d9cf62637a14bee37bfa9169ef20065471.1685464332.git.jpoimboe@kernel.org>
References: <515235d9cf62637a14bee37bfa9169ef20065471.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629685863.404.11673063766415934535.tip-bot2@tip-bot2>
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

Commit-ID:     2707579dfa615a5dda4aabb92e433f03a87b5ec5
Gitweb:        https://git.kernel.org/tip/2707579dfa615a5dda4aabb92e433f03a87b5ec5
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:20:54 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:13 -07:00

objtool: Remove flags argument from elf_create_section()

Simplify the elf_create_section() interface a bit by removing the flags
argument.  Most callers don't care about changing the section header
flags.  If needed, they can be modified afterwards, just like any other
section header field.

Link: https://lore.kernel.org/r/515235d9cf62637a14bee37bfa9169ef20065471.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 17 ++++++++++-------
 tools/objtool/elf.c                 | 10 +++++-----
 tools/objtool/include/objtool/elf.h |  2 +-
 tools/objtool/orc_gen.c             |  4 ++--
 4 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b11c25a..eaf6815 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -677,11 +677,14 @@ static int create_static_call_sections(struct objtool_file *file)
 	list_for_each_entry(insn, &file->static_call_list, call_node)
 		idx++;
 
-	sec = elf_create_section(file->elf, ".static_call_sites", SHF_WRITE,
+	sec = elf_create_section(file->elf, ".static_call_sites",
 				 sizeof(struct static_call_site), idx);
 	if (!sec)
 		return -1;
 
+	/* Allow modules to set the low bits of static_call_site::key */
+	sec->sh.sh_flags |= SHF_WRITE;
+
 	idx = 0;
 	list_for_each_entry(insn, &file->static_call_list, call_node) {
 
@@ -763,7 +766,7 @@ static int create_retpoline_sites_sections(struct objtool_file *file)
 	if (!idx)
 		return 0;
 
-	sec = elf_create_section(file->elf, ".retpoline_sites", 0,
+	sec = elf_create_section(file->elf, ".retpoline_sites",
 				 sizeof(int), idx);
 	if (!sec) {
 		WARN("elf_create_section: .retpoline_sites");
@@ -809,7 +812,7 @@ static int create_return_sites_sections(struct objtool_file *file)
 	if (!idx)
 		return 0;
 
-	sec = elf_create_section(file->elf, ".return_sites", 0,
+	sec = elf_create_section(file->elf, ".return_sites",
 				 sizeof(int), idx);
 	if (!sec) {
 		WARN("elf_create_section: .return_sites");
@@ -861,7 +864,7 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
 	if (!idx)
 		return 0;
 
-	sec = elf_create_section(file->elf, ".ibt_endbr_seal", 0,
+	sec = elf_create_section(file->elf, ".ibt_endbr_seal",
 				 sizeof(int), idx);
 	if (!sec) {
 		WARN("elf_create_section: .ibt_endbr_seal");
@@ -920,7 +923,7 @@ static int create_cfi_sections(struct objtool_file *file)
 		idx++;
 	}
 
-	sec = elf_create_section(file->elf, ".cfi_sites", 0, sizeof(unsigned int), idx);
+	sec = elf_create_section(file->elf, ".cfi_sites", sizeof(unsigned int), idx);
 	if (!sec)
 		return -1;
 
@@ -968,7 +971,7 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 	list_for_each_entry(insn, &file->mcount_loc_list, call_node)
 		idx++;
 
-	sec = elf_create_section(file->elf, "__mcount_loc", 0, addrsize, idx);
+	sec = elf_create_section(file->elf, "__mcount_loc", addrsize, idx);
 	if (!sec)
 		return -1;
 
@@ -1013,7 +1016,7 @@ static int create_direct_call_sections(struct objtool_file *file)
 	list_for_each_entry(insn, &file->call_list, call_node)
 		idx++;
 
-	sec = elf_create_section(file->elf, ".call_sites", 0, sizeof(unsigned int), idx);
+	sec = elf_create_section(file->elf, ".call_sites", sizeof(unsigned int), idx);
 	if (!sec)
 		return -1;
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 500e929..7598c0a 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1059,7 +1059,7 @@ static int elf_add_string(struct elf *elf, struct section *strtab, char *str)
 }
 
 struct section *elf_create_section(struct elf *elf, const char *name,
-				   unsigned int sh_flags, size_t entsize, int nr)
+				   size_t entsize, int nr)
 {
 	struct section *sec, *shstrtab;
 	size_t size = entsize * nr;
@@ -1117,7 +1117,7 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	sec->sh.sh_entsize = entsize;
 	sec->sh.sh_type = SHT_PROGBITS;
 	sec->sh.sh_addralign = 1;
-	sec->sh.sh_flags = SHF_ALLOC | sh_flags;
+	sec->sh.sh_flags = SHF_ALLOC;
 
 	/* Add section name to .shstrtab (or .strtab for Clang) */
 	shstrtab = find_section_by_name(elf, ".shstrtab");
@@ -1153,7 +1153,7 @@ static struct section *elf_create_rel_reloc_section(struct elf *elf, struct sect
 	strcpy(relocname, ".rel");
 	strcat(relocname, base->name);
 
-	sec = elf_create_section(elf, relocname, 0, sizeof(GElf_Rel), 0);
+	sec = elf_create_section(elf, relocname, sizeof(GElf_Rel), 0);
 	free(relocname);
 	if (!sec)
 		return NULL;
@@ -1185,9 +1185,9 @@ static struct section *elf_create_rela_reloc_section(struct elf *elf, struct sec
 	strcat(relocname, base->name);
 
 	if (addrsize == sizeof(u32))
-		sec = elf_create_section(elf, relocname, 0, sizeof(Elf32_Rela), 0);
+		sec = elf_create_section(elf, relocname, sizeof(Elf32_Rela), 0);
 	else
-		sec = elf_create_section(elf, relocname, 0, sizeof(GElf_Rela), 0);
+		sec = elf_create_section(elf, relocname, sizeof(GElf_Rela), 0);
 	free(relocname);
 	if (!sec)
 		return NULL;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index b24f83e..2c28aee 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -109,7 +109,7 @@ struct elf {
 };
 
 struct elf *elf_open_read(const char *name, int flags);
-struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
+struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
 
 struct symbol *elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size);
 
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 48efd1e..d5f750b 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -237,12 +237,12 @@ int orc_create(struct objtool_file *file)
 		WARN("file already has .orc_unwind section, skipping");
 		return -1;
 	}
-	orc_sec = elf_create_section(file->elf, ".orc_unwind", 0,
+	orc_sec = elf_create_section(file->elf, ".orc_unwind",
 				     sizeof(struct orc_entry), nr);
 	if (!orc_sec)
 		return -1;
 
-	sec = elf_create_section(file->elf, ".orc_unwind_ip", 0, sizeof(int), nr);
+	sec = elf_create_section(file->elf, ".orc_unwind_ip", sizeof(int), nr);
 	if (!sec)
 		return -1;
 
