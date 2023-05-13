Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7899B7019C1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjEMUpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjEMUpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:45:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1B82D62;
        Sat, 13 May 2023 13:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E01D61551;
        Sat, 13 May 2023 20:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76635C433EF;
        Sat, 13 May 2023 20:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684010721;
        bh=MgXAugWg05JpajxGCkES+KuPc7L8WPiutMpYWSE6mLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLhst0Y2B37X+lrJqVRa7gbKGDQsjxNIe9qorfyrEORHGGNC7Q6qsSYBYKS4WcrLA
         cryLxmB4cu8wCd44b+CBNADT6Bv+Ufs6pnS6QIsn2pKUaCAfSL79IZl5N+Fp65yC4s
         DnvMVWz4sYmzB0pa1kENJA+/iDn8vx30WsCaZ28qUqMpG5F8vfmcQZWlS7xjKQSfES
         4Qhiqb9IHX3tilmnPC3CSSNQ/2T4oDSIbs5O4Pp15h57RfbOdl/AFiPyN8QH12tPNK
         FgX6kt08yUwT5C54Tcpzl8jWXDoW8UwgFbPhO0XSaH94WwSpaKZ3TF/BdRJLOVI4zM
         NFVroPkB5GVvQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 04/21] modpost: squash report_extable_warnings() into extable_mismatch_handler()
Date:   Sun, 14 May 2023 05:44:45 +0900
Message-Id: <20230513204502.1593923-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230513204502.1593923-1-masahiroy@kernel.org>
References: <20230513204502.1593923-1-masahiroy@kernel.org>
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

Collect relevant code into one place to clarify all the cases are
covered by 'if () ... else if ... else ...'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 371891d67175..7a9a3ef8ca0d 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1275,40 +1275,19 @@ static int is_executable_section(struct elf_info* elf, unsigned int section_inde
 	return ((elf->sechdrs[section_index].sh_flags & SHF_EXECINSTR) == SHF_EXECINSTR);
 }
 
-static void report_extable_warnings(const char* modname, struct elf_info* elf,
-				    const struct sectioncheck* const mismatch,
-				    Elf_Rela* r, Elf_Sym* sym,
-				    const char* fromsec, const char* tosec)
-{
-	Elf_Sym* tosym = find_elf_symbol(elf, r->r_addend, sym);
-	const char* tosym_name = sym_name(elf, tosym);
-
-	warn("%s(%s+0x%lx): Section mismatch in reference to the %s:%s\n",
-	     modname, fromsec, (long)r->r_offset, tosec, tosym_name);
-
-	if (!match(tosec, mismatch->bad_tosec) &&
-	    is_executable_section(elf, get_secindex(elf, sym)))
-		fprintf(stderr,
-			"The relocation at %s+0x%lx references\n"
-			"section \"%s\" which is not in the list of\n"
-			"authorized sections.  If you're adding a new section\n"
-			"and/or if this reference is valid, add \"%s\" to the\n"
-			"list of authorized sections to jump to on fault.\n"
-			"This can be achieved by adding \"%s\" to \n"
-			"OTHER_TEXT_SECTIONS in scripts/mod/modpost.c.\n",
-			fromsec, (long)r->r_offset, tosec, tosec, tosec);
-}
-
 static void extable_mismatch_handler(const char* modname, struct elf_info *elf,
 				     const struct sectioncheck* const mismatch,
 				     Elf_Rela* r, Elf_Sym* sym,
 				     const char *fromsec)
 {
 	const char* tosec = sec_name(elf, get_secindex(elf, sym));
+	Elf_Sym *tosym = find_elf_symbol(elf, r->r_addend, sym);
+	const char *tosym_name = sym_name(elf, tosym);
 
 	sec_mismatch_count++;
 
-	report_extable_warnings(modname, elf, mismatch, r, sym, fromsec, tosec);
+	warn("%s(%s+0x%lx): Section mismatch in reference to the %s:%s\n",
+	     modname, fromsec, (long)r->r_offset, tosec, tosym_name);
 
 	if (match(tosec, mismatch->bad_tosec))
 		fatal("The relocation at %s+0x%lx references\n"
@@ -1317,7 +1296,16 @@ static void extable_mismatch_handler(const char* modname, struct elf_info *elf,
 		      "You might get more information about where this is\n"
 		      "coming from by using scripts/check_extable.sh %s\n",
 		      fromsec, (long)r->r_offset, tosec, modname);
-	else if (!is_executable_section(elf, get_secindex(elf, sym)))
+	else if (is_executable_section(elf, get_secindex(elf, sym)))
+		warn("The relocation at %s+0x%lx references\n"
+		     "section \"%s\" which is not in the list of\n"
+		     "authorized sections.  If you're adding a new section\n"
+		     "and/or if this reference is valid, add \"%s\" to the\n"
+		     "list of authorized sections to jump to on fault.\n"
+		     "This can be achieved by adding \"%s\" to\n"
+		     "OTHER_TEXT_SECTIONS in scripts/mod/modpost.c.\n",
+		     fromsec, (long)r->r_offset, tosec, tosec, tosec);
+	else
 		error("%s+0x%lx references non-executable section '%s'\n",
 		      fromsec, (long)r->r_offset, tosec);
 }
-- 
2.39.2

