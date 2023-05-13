Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E4E7019D3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbjEMUqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjEMUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:46:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E73C59E6;
        Sat, 13 May 2023 13:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E691361573;
        Sat, 13 May 2023 20:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E18C433EF;
        Sat, 13 May 2023 20:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684010744;
        bh=M/byfPkmRAEN53bHhhXgMLLxGO+hRrGOrMzEpdrjXfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YH7aIWT7nzIWBw9+vdEpka6kVSlxVzTRbng97XHynmyEMJZaJKOzJvnIuyqEsdemP
         fU5Ux44lDyaXM9KeTr9J+PJ2+HE+D/uWnCYCrH8eyefayvDl07yZlHtbPw4tatZjQf
         dR1Yby/HlQ3S3jcEdr5tMzH2VALXSnI0C5PDuwsZcyWI40kGA5C3/uXC/5RUjLLN7m
         utKpnyW3V7QcDFKZE/dKa1nnn9zGDnYBH2nSCcnSvK2VDbmHy3P2Y6FO6LJ1bcRFDE
         mtdyu8vp7WLAZGn6Cdpun+eTVXOMF6JeeE003dfXYJlH7rfU3SbEnNZfQ1FymMphbs
         pnZya00PeD/uQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 15/21] modpost: pass struct module pointer to check_section_mismatch()
Date:   Sun, 14 May 2023 05:44:56 +0900
Message-Id: <20230513204502.1593923-16-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230513204502.1593923-1-masahiroy@kernel.org>
References: <20230513204502.1593923-1-masahiroy@kernel.org>
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
---

 scripts/mod/modpost.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 1c5dd81c0987..e82299c90836 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1223,7 +1223,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	}
 }
 
-static void check_section_mismatch(const char *modname, struct elf_info *elf,
+static void check_section_mismatch(struct module *mod, struct elf_info *elf,
 				   Elf_Sym *sym,
 				   unsigned int fsecndx, const char *fromsec,
 				   Elf_Addr faddr, Elf_Addr taddr)
@@ -1234,7 +1234,7 @@ static void check_section_mismatch(const char *modname, struct elf_info *elf,
 	if (!mismatch)
 		return;
 
-	default_mismatch_handler(modname, elf, mismatch, sym,
+	default_mismatch_handler(mod->name, elf, mismatch, sym,
 				 fsecndx, fromsec, faddr,
 				 tosec, taddr);
 }
@@ -1344,7 +1344,7 @@ static int addend_mips_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 #define R_LARCH_SUB32		55
 #endif
 
-static void section_rela(const char *modname, struct elf_info *elf,
+static void section_rela(struct module *mod, struct elf_info *elf,
 			 Elf_Shdr *sechdr)
 {
 	Elf_Rela *rela;
@@ -1395,7 +1395,7 @@ static void section_rela(const char *modname, struct elf_info *elf,
 	}
 }
 
-static void section_rel(const char *modname, struct elf_info *elf,
+static void section_rel(struct module *mod, struct elf_info *elf,
 			Elf_Shdr *sechdr)
 {
 	Elf_Rel *rel;
@@ -1462,19 +1462,19 @@ static void section_rel(const char *modname, struct elf_info *elf,
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
 
@@ -1645,7 +1645,7 @@ static void read_symbols(const char *modname)
 					     sym_get_data(&info, sym));
 	}
 
-	check_sec_ref(modname, &info);
+	check_sec_ref(mod, &info);
 
 	if (!mod->is_vmlinux) {
 		version = get_modinfo(&info, "version");
-- 
2.39.2

