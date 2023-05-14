Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2791A701DFD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 17:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbjENP1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 11:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbjENP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 11:27:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61802699;
        Sun, 14 May 2023 08:27:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F30160B77;
        Sun, 14 May 2023 15:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A59C4339E;
        Sun, 14 May 2023 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684078068;
        bh=ZFbJylkRfRWvmh1oXo92Q82xN7MYbuSvRg13umh8NkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jgrgoSeeVhHO6VrpBX1dznbLspwKtiJHkbZMCrr/65EIHki23hZWKTbZ9L4Gq1ZwL
         JBE5N/PdLlcpIrp7vPXB9Kn7dob4TBLl+mW+RI+n44/6Vxo2vHF1n6plCAHVHjDlsQ
         sV4DrcCSo0e6JUKBKetVIIDM1/a8e4+POkOiNvN+zYmT6TATG16LRMOiWGedOe5rdo
         evNQGM6/ubqPw/UPlXHJuQdnaWjjZ5RcOpeiVoqXFER0z7I5V9CgD2szipdRzoFsaa
         XTUrkqrszQ4Xe+I2T7FJt9EP1dNu7SRwIRhX2Lze86iT7o7VF69SvKWPEnfPtIOlR2
         q5oY4vambhWhg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v5 01/21] modpost: remove broken calculation of exception_table_entry size
Date:   Mon, 15 May 2023 00:27:19 +0900
Message-Id: <20230514152739.962109-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230514152739.962109-1-masahiroy@kernel.org>
References: <20230514152739.962109-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_extable_entry_size() is completely broken. It has awesome comments
about how to calculate sizeof(struct exception_table_entry).

It was based on these assumptions:

  - struct exception_table_entry has two fields
  - both of the fields have the same size

Then, we came up with this equation:

  (offset of the second field) * 2 == (size of struct)

It was true for all architectures when commit 52dc0595d540 ("modpost:
handle relocations mismatch in __ex_table.") was applied.

Our mathematics broke when commit 548acf19234d ("x86/mm: Expand the
exception table logic to allow new handling options") introduced the
third field.

Now, the definition of exception_table_entry is highly arch-dependent.

For x86, sizeof(struct exception_table_entry) is apparently 12, but
find_extable_entry_size() sets extable_entry_size to 8.

I could fix it, but I do not see much value in this code.

extable_entry_size is used just for selecting a slightly different
error message.

If the first field ("insn") references to a non-executable section,

    The relocation at %s+0x%lx references
    section "%s" which is not executable, IOW
    it is not possible for the kernel to fault
    at that address.  Something is seriously wrong
    and should be fixed.

If the second field ("fixup") references to a non-executable section,

    The relocation at %s+0x%lx references
    section "%s" which is not executable, IOW
    the kernel will fault if it ever tries to
    jump to it.  Something is seriously wrong
    and should be fixed.

Merge the two error messages rather than adding even more complexity.

Change fatal() to error() to make it continue running and catch more
possible errors.

Fixes: 548acf19234d ("x86/mm: Expand the exception table logic to allow new handling options")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 60 +++----------------------------------------
 1 file changed, 3 insertions(+), 57 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c1c523adb139..ba4577aa4f1d 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1292,43 +1292,6 @@ static int is_executable_section(struct elf_info* elf, unsigned int section_inde
 	return ((elf->sechdrs[section_index].sh_flags & SHF_EXECINSTR) == SHF_EXECINSTR);
 }
 
-/*
- * We rely on a gross hack in section_rel[a]() calling find_extable_entry_size()
- * to know the sizeof(struct exception_table_entry) for the target architecture.
- */
-static unsigned int extable_entry_size = 0;
-static void find_extable_entry_size(const char* const sec, const Elf_Rela* r)
-{
-	/*
-	 * If we're currently checking the second relocation within __ex_table,
-	 * that relocation offset tells us the offsetof(struct
-	 * exception_table_entry, fixup) which is equal to sizeof(struct
-	 * exception_table_entry) divided by two.  We use that to our advantage
-	 * since there's no portable way to get that size as every architecture
-	 * seems to go with different sized types.  Not pretty but better than
-	 * hard-coding the size for every architecture..
-	 */
-	if (!extable_entry_size)
-		extable_entry_size = r->r_offset * 2;
-}
-
-static inline bool is_extable_fault_address(Elf_Rela *r)
-{
-	/*
-	 * extable_entry_size is only discovered after we've handled the
-	 * _second_ relocation in __ex_table, so only abort when we're not
-	 * handling the first reloc and extable_entry_size is zero.
-	 */
-	if (r->r_offset && extable_entry_size == 0)
-		fatal("extable_entry size hasn't been discovered!\n");
-
-	return ((r->r_offset == 0) ||
-		(r->r_offset % extable_entry_size == 0));
-}
-
-#define is_second_extable_reloc(Start, Cur, Sec)			\
-	(((Cur) == (Start) + 1) && (strcmp("__ex_table", (Sec)) == 0))
-
 static void report_extable_warnings(const char* modname, struct elf_info* elf,
 				    const struct sectioncheck* const mismatch,
 				    Elf_Rela* r, Elf_Sym* sym,
@@ -1384,22 +1347,9 @@ static void extable_mismatch_handler(const char* modname, struct elf_info *elf,
 		      "You might get more information about where this is\n"
 		      "coming from by using scripts/check_extable.sh %s\n",
 		      fromsec, (long)r->r_offset, tosec, modname);
-	else if (!is_executable_section(elf, get_secindex(elf, sym))) {
-		if (is_extable_fault_address(r))
-			fatal("The relocation at %s+0x%lx references\n"
-			      "section \"%s\" which is not executable, IOW\n"
-			      "it is not possible for the kernel to fault\n"
-			      "at that address.  Something is seriously wrong\n"
-			      "and should be fixed.\n",
-			      fromsec, (long)r->r_offset, tosec);
-		else
-			fatal("The relocation at %s+0x%lx references\n"
-			      "section \"%s\" which is not executable, IOW\n"
-			      "the kernel will fault if it ever tries to\n"
-			      "jump to it.  Something is seriously wrong\n"
-			      "and should be fixed.\n",
-			      fromsec, (long)r->r_offset, tosec);
-	}
+	else if (!is_executable_section(elf, get_secindex(elf, sym)))
+		error("%s+0x%lx references non-executable section '%s'\n",
+		      fromsec, (long)r->r_offset, tosec);
 }
 
 static void check_section_mismatch(const char *modname, struct elf_info *elf,
@@ -1574,8 +1524,6 @@ static void section_rela(const char *modname, struct elf_info *elf,
 		/* Skip special sections */
 		if (is_shndx_special(sym->st_shndx))
 			continue;
-		if (is_second_extable_reloc(start, rela, fromsec))
-			find_extable_entry_size(fromsec, &r);
 		check_section_mismatch(modname, elf, &r, sym, fromsec);
 	}
 }
@@ -1635,8 +1583,6 @@ static void section_rel(const char *modname, struct elf_info *elf,
 		/* Skip special sections */
 		if (is_shndx_special(sym->st_shndx))
 			continue;
-		if (is_second_extable_reloc(start, rel, fromsec))
-			find_extable_entry_size(fromsec, &r);
 		check_section_mismatch(modname, elf, &r, sym, fromsec);
 	}
 }
-- 
2.39.2

