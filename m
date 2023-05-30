Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EDE716AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjE3RVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjE3RVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF45DC5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 371FC63119
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E048C433A1;
        Tue, 30 May 2023 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467292;
        bh=ezwwKI2GDxpeRWO6jitsfuA2ZdZYwPWarLEJ85t+eoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YKeCJ/vRmwMEfsTROMVCnxQEDwItNceboZrlvf8/twBja4RR58SkJ69m8DZDl7l18
         Gxi9RGsi8QVkc/1vkcP81dnFL2DU5KAh17YLkpe+Z0FLgBDpHxUfZgsIPoqwXUZkeL
         ewhvS26MUcpCs/o3uM3nF/3aASMKl3qsbZTBgncSOdIBmkgKpWaS5HWRlsS9yRQc6j
         fxLan87+aEv4AkIrzPPGHfR6D6x+2hgIx9ua6Z5KwXgWSUF4sVkH4jlMNBpeT1CpQH
         H8NlL5PXhThgyvd0yJgdtzFzz6koPEtYMcvKN0oZiaVrobZO6I7AdTYDhObmrqhAvE
         aG+5gcH4Y5toA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 02/22] objtool: Remove flags argument from elf_create_section()
Date:   Tue, 30 May 2023 10:20:54 -0700
Message-Id: <515235d9cf62637a14bee37bfa9169ef20065471.1685464332.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685464332.git.jpoimboe@kernel.org>
References: <cover.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the elf_create_section() interface a bit by removing the flags
argument.  Most callers don't care about changing the section header
flags.  If needed, they can be modified afterwards, just like any other
section header field.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 17 ++++++++++-------
 tools/objtool/elf.c                 | 10 +++++-----
 tools/objtool/include/objtool/elf.h |  2 +-
 tools/objtool/orc_gen.c             |  4 ++--
 4 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a13c257f80dd..bc6771550423 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -676,11 +676,14 @@ static int create_static_call_sections(struct objtool_file *file)
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
 
@@ -762,7 +765,7 @@ static int create_retpoline_sites_sections(struct objtool_file *file)
 	if (!idx)
 		return 0;
 
-	sec = elf_create_section(file->elf, ".retpoline_sites", 0,
+	sec = elf_create_section(file->elf, ".retpoline_sites",
 				 sizeof(int), idx);
 	if (!sec) {
 		WARN("elf_create_section: .retpoline_sites");
@@ -808,7 +811,7 @@ static int create_return_sites_sections(struct objtool_file *file)
 	if (!idx)
 		return 0;
 
-	sec = elf_create_section(file->elf, ".return_sites", 0,
+	sec = elf_create_section(file->elf, ".return_sites",
 				 sizeof(int), idx);
 	if (!sec) {
 		WARN("elf_create_section: .return_sites");
@@ -860,7 +863,7 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
 	if (!idx)
 		return 0;
 
-	sec = elf_create_section(file->elf, ".ibt_endbr_seal", 0,
+	sec = elf_create_section(file->elf, ".ibt_endbr_seal",
 				 sizeof(int), idx);
 	if (!sec) {
 		WARN("elf_create_section: .ibt_endbr_seal");
@@ -919,7 +922,7 @@ static int create_cfi_sections(struct objtool_file *file)
 		idx++;
 	}
 
-	sec = elf_create_section(file->elf, ".cfi_sites", 0, sizeof(unsigned int), idx);
+	sec = elf_create_section(file->elf, ".cfi_sites", sizeof(unsigned int), idx);
 	if (!sec)
 		return -1;
 
@@ -967,7 +970,7 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 	list_for_each_entry(insn, &file->mcount_loc_list, call_node)
 		idx++;
 
-	sec = elf_create_section(file->elf, "__mcount_loc", 0, addrsize, idx);
+	sec = elf_create_section(file->elf, "__mcount_loc", addrsize, idx);
 	if (!sec)
 		return -1;
 
@@ -1012,7 +1015,7 @@ static int create_direct_call_sections(struct objtool_file *file)
 	list_for_each_entry(insn, &file->call_list, call_node)
 		idx++;
 
-	sec = elf_create_section(file->elf, ".call_sites", 0, sizeof(unsigned int), idx);
+	sec = elf_create_section(file->elf, ".call_sites", sizeof(unsigned int), idx);
 	if (!sec)
 		return -1;
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 500e92979a31..7598c0a2633d 100644
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
index b24f83e7ca34..2c28aeeb3cb2 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -109,7 +109,7 @@ struct elf {
 };
 
 struct elf *elf_open_read(const char *name, int flags);
-struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
+struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
 
 struct symbol *elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size);
 
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 48efd1e2f00d..d5f750be7d7d 100644
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
 
-- 
2.40.1

