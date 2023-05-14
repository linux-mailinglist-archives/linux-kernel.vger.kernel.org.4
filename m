Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F309701E08
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbjENP2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 11:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbjENP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 11:28:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4790A3C1B;
        Sun, 14 May 2023 08:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 923D4617A6;
        Sun, 14 May 2023 15:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307E7C4339B;
        Sun, 14 May 2023 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684078082;
        bh=Sr1ACpmB4VMo9mQd8LPvpsqLdM7Qav5Pbz5xK//K3hU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4RzBkqjU/bCoauKDTC/QoXDI9/U+s36nixkP2tU6dAs643Z82QUxTNxFlyrYjYKc
         REvT/e/B8hIcJUuL6Cg8Q+ccot/E3ev0aaEraMSFL0hBXwELtNjDVtTnWgGxcmuG1P
         +G0//6Ug/hKbo4dQ1HEJdUe2EhZ40YHIIxX3eS5eUPQ5Fzq0hgxLS8KntV1NdYs3gJ
         zvyM0VHb6nLr2Wg++rnKdJcLMDsg91emd1MuQZlRiiTSt9jbb6snuPYtvR/C/88gKj
         VDH1nkSQ4QdIzJkqjvMxqWbLyw5AaKO7NhyMx0vKJ74i7pCfbD6+IfynuMxrUw04Yn
         YubER217qb1rw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v5 07/21] modpost: squash extable_mismatch_handler() into default_mismatch_handler()
Date:   Mon, 15 May 2023 00:27:25 +0900
Message-Id: <20230514152739.962109-8-masahiroy@kernel.org>
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

Merging these two reduces several lines of code. The extable section
mismatch is already distinguished by EXTABLE_TO_NON_TEXT.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 84 ++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 58 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0bda2f22c985..49357a716519 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -881,27 +881,14 @@ enum mismatch {
  * targeting sections in this array (white-list).  Can be empty.
  *
  * @mismatch: Type of mismatch.
- *
- * @handler: Specific handler to call when a match is found.  If NULL,
- * default_mismatch_handler() will be called.
- *
  */
 struct sectioncheck {
 	const char *fromsec[20];
 	const char *bad_tosec[20];
 	const char *good_tosec[20];
 	enum mismatch mismatch;
-	void (*handler)(const char *modname, struct elf_info *elf,
-			const struct sectioncheck* const mismatch,
-			Elf_Rela *r, Elf_Sym *sym, const char *fromsec);
-
 };
 
-static void extable_mismatch_handler(const char *modname, struct elf_info *elf,
-				     const struct sectioncheck* const mismatch,
-				     Elf_Rela *r, Elf_Sym *sym,
-				     const char *fromsec);
-
 static const struct sectioncheck sectioncheck[] = {
 /* Do not reference init/exit code/data from
  * normal code and data
@@ -974,7 +961,6 @@ static const struct sectioncheck sectioncheck[] = {
 	.bad_tosec = { ".altinstr_replacement", NULL },
 	.good_tosec = {ALL_TEXT_SECTIONS , NULL},
 	.mismatch = EXTABLE_TO_NON_TEXT,
-	.handler = extable_mismatch_handler,
 }
 };
 
@@ -1255,60 +1241,42 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 		     modname, tosym, tosec);
 		break;
 	case EXTABLE_TO_NON_TEXT:
-		fatal("There's a special handler for this mismatch type, we should never get here.\n");
+		warn("%s(%s+0x%lx): Section mismatch in reference to the %s:%s\n",
+		     modname, fromsec, (long)r->r_offset, tosec, tosym);
+
+		if (match(tosec, mismatch->bad_tosec))
+			fatal("The relocation at %s+0x%lx references\n"
+			      "section \"%s\" which is black-listed.\n"
+			      "Something is seriously wrong and should be fixed.\n"
+			      "You might get more information about where this is\n"
+			      "coming from by using scripts/check_extable.sh %s\n",
+			      fromsec, (long)r->r_offset, tosec, modname);
+		else if (is_executable_section(elf, get_secindex(elf, sym)))
+			warn("The relocation at %s+0x%lx references\n"
+			     "section \"%s\" which is not in the list of\n"
+			     "authorized sections.  If you're adding a new section\n"
+			     "and/or if this reference is valid, add \"%s\" to the\n"
+			     "list of authorized sections to jump to on fault.\n"
+			     "This can be achieved by adding \"%s\" to\n"
+			     "OTHER_TEXT_SECTIONS in scripts/mod/modpost.c.\n",
+			     fromsec, (long)r->r_offset, tosec, tosec, tosec);
+		else
+			error("%s+0x%lx references non-executable section '%s'\n",
+			      fromsec, (long)r->r_offset, tosec);
 		break;
 	}
 }
 
-static void extable_mismatch_handler(const char* modname, struct elf_info *elf,
-				     const struct sectioncheck* const mismatch,
-				     Elf_Rela* r, Elf_Sym* sym,
-				     const char *fromsec)
-{
-	const char* tosec = sec_name(elf, get_secindex(elf, sym));
-	Elf_Sym *tosym = find_elf_symbol(elf, r->r_addend, sym);
-	const char *tosym_name = sym_name(elf, tosym);
-
-	sec_mismatch_count++;
-
-	warn("%s(%s+0x%lx): Section mismatch in reference to the %s:%s\n",
-	     modname, fromsec, (long)r->r_offset, tosec, tosym_name);
-
-	if (match(tosec, mismatch->bad_tosec))
-		fatal("The relocation at %s+0x%lx references\n"
-		      "section \"%s\" which is black-listed.\n"
-		      "Something is seriously wrong and should be fixed.\n"
-		      "You might get more information about where this is\n"
-		      "coming from by using scripts/check_extable.sh %s\n",
-		      fromsec, (long)r->r_offset, tosec, modname);
-	else if (is_executable_section(elf, get_secindex(elf, sym)))
-		warn("The relocation at %s+0x%lx references\n"
-		     "section \"%s\" which is not in the list of\n"
-		     "authorized sections.  If you're adding a new section\n"
-		     "and/or if this reference is valid, add \"%s\" to the\n"
-		     "list of authorized sections to jump to on fault.\n"
-		     "This can be achieved by adding \"%s\" to\n"
-		     "OTHER_TEXT_SECTIONS in scripts/mod/modpost.c.\n",
-		     fromsec, (long)r->r_offset, tosec, tosec, tosec);
-	else
-		error("%s+0x%lx references non-executable section '%s'\n",
-		      fromsec, (long)r->r_offset, tosec);
-}
-
 static void check_section_mismatch(const char *modname, struct elf_info *elf,
 				   Elf_Rela *r, Elf_Sym *sym, const char *fromsec)
 {
 	const char *tosec = sec_name(elf, get_secindex(elf, sym));
 	const struct sectioncheck *mismatch = section_mismatch(fromsec, tosec);
 
-	if (mismatch) {
-		if (mismatch->handler)
-			mismatch->handler(modname, elf,  mismatch,
-					  r, sym, fromsec);
-		else
-			default_mismatch_handler(modname, elf, mismatch,
-						 r, sym, fromsec);
-	}
+	if (!mismatch)
+		return;
+
+	default_mismatch_handler(modname, elf, mismatch, r, sym, fromsec);
 }
 
 static unsigned int *reloc_location(struct elf_info *elf,
-- 
2.39.2

