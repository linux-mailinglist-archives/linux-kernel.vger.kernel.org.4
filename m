Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4689670AEC8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjEUQFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjEUQFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:05:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4557CE4;
        Sun, 21 May 2023 09:05:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8101960EBB;
        Sun, 21 May 2023 16:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5823EC433EF;
        Sun, 21 May 2023 16:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684685126;
        bh=DllT3ZPOBUigMQGFIvZ6Cw5LDSBjW9pG7B4U9kbXEAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzdAmYmcSc6P4QtLbs6CZOmM4Ynr9rvb8H9OAAENgMqVmNjP4ZbwDFw9N+tZKFkx3
         SNd4r/qGJ/nJJ5VgblK16Q+Ie4vevA7SKvgCX+wXtdfpuR8AfBsZGXILB5NprMxTKq
         WyN6xInHOqLDUc9uvpjyO4RncUy+ORFNitoH6Il+sJRr0UbwH9vwFR/eCT97cQqgMl
         m0rWlqApLCsf6K2kbovLLLkfGWidhoa7GIWtI3epVjqQmDp8h7qci6rd6ruXxZik0J
         EhqUYGOmYr6K/IhcgMrXdRJOqOKaRo6zv6zM6gr7YWeLUgRazDwzCkEj3uZg3QOenR
         2lYYx6MMVfrfg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 07/20] modpost: replace r->r_offset, r->r_addend with faddr, taddr
Date:   Mon, 22 May 2023 01:04:12 +0900
Message-Id: <20230521160426.1881124-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230521160426.1881124-1-masahiroy@kernel.org>
References: <20230521160426.1881124-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

r_offset/r_addend holds the offset address from/to which a symbol is
referenced. It is unclear unless you are familiar with ELF.

Rename them to faddr, taddr, respectively. The prefix 'f' means 'from',
't' means 'to'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7848bacd4b42..f364738a236e 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1166,18 +1166,18 @@ static bool is_executable_section(struct elf_info *elf, unsigned int secndx)
 
 static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 				     const struct sectioncheck* const mismatch,
-				     Elf_Rela *r, Elf_Sym *tsym,
-				     unsigned int fsecndx, const char *fromsec,
-				     const char *tosec)
+				     Elf_Sym *tsym,
+				     unsigned int fsecndx, const char *fromsec, Elf_Addr faddr,
+				     const char *tosec, Elf_Addr taddr)
 {
 	Elf_Sym *from;
 	const char *tosym;
 	const char *fromsym;
 
-	from = find_fromsym(elf, r->r_offset, fsecndx);
+	from = find_fromsym(elf, faddr, fsecndx);
 	fromsym = sym_name(elf, from);
 
-	tsym = find_tosym(elf, r->r_addend, tsym);
+	tsym = find_tosym(elf, taddr, tsym);
 	tosym = sym_name(elf, tsym);
 
 	/* check whitelist - we may ignore it */
@@ -1204,7 +1204,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 		break;
 	case EXTABLE_TO_NON_TEXT:
 		warn("%s(%s+0x%lx): Section mismatch in reference to the %s:%s\n",
-		     modname, fromsec, (long)r->r_offset, tosec, tosym);
+		     modname, fromsec, (long)faddr, tosec, tosym);
 
 		if (match(tosec, mismatch->bad_tosec))
 			fatal("The relocation at %s+0x%lx references\n"
@@ -1212,7 +1212,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 			      "Something is seriously wrong and should be fixed.\n"
 			      "You might get more information about where this is\n"
 			      "coming from by using scripts/check_extable.sh %s\n",
-			      fromsec, (long)r->r_offset, tosec, modname);
+			      fromsec, (long)faddr, tosec, modname);
 		else if (is_executable_section(elf, get_secindex(elf, tsym)))
 			warn("The relocation at %s+0x%lx references\n"
 			     "section \"%s\" which is not in the list of\n"
@@ -1221,17 +1221,18 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 			     "list of authorized sections to jump to on fault.\n"
 			     "This can be achieved by adding \"%s\" to\n"
 			     "OTHER_TEXT_SECTIONS in scripts/mod/modpost.c.\n",
-			     fromsec, (long)r->r_offset, tosec, tosec, tosec);
+			     fromsec, (long)faddr, tosec, tosec, tosec);
 		else
 			error("%s+0x%lx references non-executable section '%s'\n",
-			      fromsec, (long)r->r_offset, tosec);
+			      fromsec, (long)faddr, tosec);
 		break;
 	}
 }
 
 static void check_section_mismatch(const char *modname, struct elf_info *elf,
-				   Elf_Rela *r, Elf_Sym *sym,
-				   unsigned int fsecndx, const char *fromsec)
+				   Elf_Sym *sym,
+				   unsigned int fsecndx, const char *fromsec,
+				   Elf_Addr faddr, Elf_Addr taddr)
 {
 	const char *tosec = sec_name(elf, get_secindex(elf, sym));
 	const struct sectioncheck *mismatch = section_mismatch(fromsec, tosec);
@@ -1239,8 +1240,9 @@ static void check_section_mismatch(const char *modname, struct elf_info *elf,
 	if (!mismatch)
 		return;
 
-	default_mismatch_handler(modname, elf, mismatch, r, sym, fsecndx, fromsec,
-				 tosec);
+	default_mismatch_handler(modname, elf, mismatch, sym,
+				 fsecndx, fromsec, faddr,
+				 tosec, taddr);
 }
 
 static unsigned int *reloc_location(struct elf_info *elf,
@@ -1406,7 +1408,8 @@ static void section_rela(const char *modname, struct elf_info *elf,
 		/* Skip special sections */
 		if (is_shndx_special(sym->st_shndx))
 			continue;
-		check_section_mismatch(modname, elf, &r, sym, fsecndx, fromsec);
+		check_section_mismatch(modname, elf, sym,
+				       fsecndx, fromsec, r.r_offset, r.r_addend);
 	}
 }
 
@@ -1464,7 +1467,8 @@ static void section_rel(const char *modname, struct elf_info *elf,
 		/* Skip special sections */
 		if (is_shndx_special(sym->st_shndx))
 			continue;
-		check_section_mismatch(modname, elf, &r, sym, fsecndx, fromsec);
+		check_section_mismatch(modname, elf, sym,
+				       fsecndx, fromsec, r.r_offset, r.r_addend);
 	}
 }
 
-- 
2.39.2

