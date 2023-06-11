Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3289772B291
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjFKPvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjFKPvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:51:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8111AB;
        Sun, 11 Jun 2023 08:51:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E809E614CC;
        Sun, 11 Jun 2023 15:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD6AC4339C;
        Sun, 11 Jun 2023 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686498671;
        bh=PeeA52mxZTye5kjIQi5qNZYwJyG767bC4CRESc+UcmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rm4t4DvHrpS9Ui0En1xL7yQNszoFQrlLtLkrX9gcs19zIwZOP9jLYWti3tYbxjZpy
         5sNNf7M4jw34AUPC7VDmD/MpCEmXB59pS/Up4w4JbAk5Xy0NgRdoADb1/bcz4vWCnK
         frWFxIkmoFeuxSbJ6l6zeyO/9ewW2z4FHyuftiqPVvHVv0Foswro226YHH5/7rP7h8
         FPCmqKhlrquuFCKvgBYMsZC8g5l63L1fQ/BG7OVtEZ2/r7CcB70BDHAdUoFXbJJ9Z2
         hpLoj5upzA9QyVncXBQ5zcxQYjQOl/gxAteHNjnf/I92pw6F+hrd6GLT82CSUrp0BY
         LDX0kBtY7BfDA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-snps-arc@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v9 02/11] modpost: pass struct module pointer to check_section_mismatch()
Date:   Mon, 12 Jun 2023 00:50:51 +0900
Message-Id: <20230611155100.2553804-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230611155100.2553804-1-masahiroy@kernel.org>
References: <20230611155100.2553804-1-masahiroy@kernel.org>
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

The next commit will use it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---


 scripts/mod/modpost.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 8decf04633bc..403ba4d923f5 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1211,7 +1211,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	}
 }
 
-static void check_section_mismatch(const char *modname, struct elf_info *elf,
+static void check_section_mismatch(struct module *mod, struct elf_info *elf,
 				   Elf_Sym *sym,
 				   unsigned int fsecndx, const char *fromsec,
 				   Elf_Addr faddr, Elf_Addr taddr)
@@ -1222,7 +1222,7 @@ static void check_section_mismatch(const char *modname, struct elf_info *elf,
 	if (!mismatch)
 		return;
 
-	default_mismatch_handler(modname, elf, mismatch, sym,
+	default_mismatch_handler(mod->name, elf, mismatch, sym,
 				 fsecndx, fromsec, faddr,
 				 tosec, taddr);
 }
@@ -1406,7 +1406,7 @@ static int addend_mips_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 #define R_LARCH_SUB32		55
 #endif
 
-static void section_rela(const char *modname, struct elf_info *elf,
+static void section_rela(struct module *mod, struct elf_info *elf,
 			 Elf_Shdr *sechdr)
 {
 	Elf_Rela *rela;
@@ -1452,12 +1452,12 @@ static void section_rela(const char *modname, struct elf_info *elf,
 			break;
 		}
 
-		check_section_mismatch(modname, elf, elf->symtab_start + r_sym,
+		check_section_mismatch(mod, elf, elf->symtab_start + r_sym,
 				       fsecndx, fromsec, r.r_offset, r.r_addend);
 	}
 }
 
-static void section_rel(const char *modname, struct elf_info *elf,
+static void section_rel(struct module *mod, struct elf_info *elf,
 			Elf_Shdr *sechdr)
 {
 	Elf_Rel *rel;
@@ -1507,7 +1507,7 @@ static void section_rel(const char *modname, struct elf_info *elf,
 			fatal("Please add code to calculate addend for this architecture\n");
 		}
 
-		check_section_mismatch(modname, elf, elf->symtab_start + r_sym,
+		check_section_mismatch(mod, elf, elf->symtab_start + r_sym,
 				       fsecndx, fromsec, r.r_offset, r.r_addend);
 	}
 }
@@ -1524,19 +1524,19 @@ static void section_rel(const char *modname, struct elf_info *elf,
  * to find all references to a section that reference a section that will
  * be discarded and warns about it.
  **/
-static void check_sec_ref(const char *modname, struct elf_info *elf)
+static void check_sec_ref(struct module *mod, struct elf_info *elf)
 {
 	int i;
 	Elf_Shdr *sechdrs = elf->sechdrs;
 
 	/* Walk through all sections */
 	for (i = 0; i < elf->num_sections; i++) {
-		check_section(modname, elf, &elf->sechdrs[i]);
+		check_section(mod->name, elf, &elf->sechdrs[i]);
 		/* We want to process only relocation sections and not .init */
 		if (sechdrs[i].sh_type == SHT_RELA)
-			section_rela(modname, elf, &elf->sechdrs[i]);
+			section_rela(mod, elf, &elf->sechdrs[i]);
 		else if (sechdrs[i].sh_type == SHT_REL)
-			section_rel(modname, elf, &elf->sechdrs[i]);
+			section_rel(mod, elf, &elf->sechdrs[i]);
 	}
 }
 
@@ -1707,7 +1707,7 @@ static void read_symbols(const char *modname)
 					     sym_get_data(&info, sym));
 	}
 
-	check_sec_ref(modname, &info);
+	check_sec_ref(mod, &info);
 
 	if (!mod->is_vmlinux) {
 		version = get_modinfo(&info, "version");
-- 
2.39.2

