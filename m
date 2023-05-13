Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3DC7019CA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbjEMUqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjEMUpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:45:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F8A4C24;
        Sat, 13 May 2023 13:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73A276152F;
        Sat, 13 May 2023 20:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7BCC433D2;
        Sat, 13 May 2023 20:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684010731;
        bh=5jnQxwz3UmV9tj1v34IDrOsiFFXLCh6HDE2/jdtbZ2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QohGou5ZTY5KWaadOLy2Vk/PnirEEDRwSStMNmFRS5NUQnUDy/Zk3JPlgNuAnabvl
         MNVvaVaTNrriZD5bGhTmST/86gjH5MnNH78zYPogedHobmq4UHYyXzx80fu1trN4ah
         Zdn+cy7ujuksSFwp8fWXNxweE+cDF3D4I551yqqQOYzRGnN5L7ZI7Wp+v31cF3nAjc
         L+GtVPkLpga8GAJ7XktqPrpNZSet+VUbAp95PJ8DTvejiWHFHR3vctCbo646Mh7qDD
         L8xItwuxItL+EZss8PvPiZGUPXf2KRRsPEUCVMz7MWPfT2D4Je6HuT/0zUUW9PstOw
         LZYAfNm78vkFg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 09/21] modpost: pass section index to find_elf_symbol2()
Date:   Sun, 14 May 2023 05:44:50 +0900
Message-Id: <20230513204502.1593923-10-masahiroy@kernel.org>
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

find_elf_symbol2() converts the section index to the section name,
then compares the two section names in each iteration. This is slow.

It is faster to compare the section indices (i.e. integers) directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 2cc9c2a4aadc..3b7b78e69137 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1169,19 +1169,14 @@ static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr,
  * it is, but this works for now.
  **/
 static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
-				 const char *sec)
+				 unsigned int secndx)
 {
 	Elf_Sym *sym;
 	Elf_Sym *near = NULL;
 	Elf_Addr distance = ~0;
 
 	for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
-		const char *symsec;
-
-		if (is_shndx_special(sym->st_shndx))
-			continue;
-		symsec = sec_name(elf, get_secindex(elf, sym));
-		if (strcmp(symsec, sec) != 0)
+		if (get_secindex(elf, sym) != secndx)
 			continue;
 		if (!is_valid_name(elf, sym))
 			continue;
@@ -1203,7 +1198,8 @@ static bool is_executable_section(struct elf_info *elf, unsigned int secndx)
 
 static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 				     const struct sectioncheck* const mismatch,
-				     Elf_Rela *r, Elf_Sym *sym, const char *fromsec,
+				     Elf_Rela *r, Elf_Sym *sym,
+				     unsigned int fsecndx, const char *fromsec,
 				     const char *tosec)
 {
 	Elf_Sym *to;
@@ -1211,7 +1207,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	const char *tosym;
 	const char *fromsym;
 
-	from = find_elf_symbol2(elf, r->r_offset, fromsec);
+	from = find_elf_symbol2(elf, r->r_offset, fsecndx);
 	fromsym = sym_name(elf, from);
 
 	to = find_elf_symbol(elf, r->r_addend, sym);
@@ -1267,7 +1263,8 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 }
 
 static void check_section_mismatch(const char *modname, struct elf_info *elf,
-				   Elf_Rela *r, Elf_Sym *sym, const char *fromsec)
+				   Elf_Rela *r, Elf_Sym *sym,
+				   unsigned int fsecndx, const char *fromsec)
 {
 	const char *tosec = sec_name(elf, get_secindex(elf, sym));
 	const struct sectioncheck *mismatch = section_mismatch(fromsec, tosec);
@@ -1275,7 +1272,8 @@ static void check_section_mismatch(const char *modname, struct elf_info *elf,
 	if (!mismatch)
 		return;
 
-	default_mismatch_handler(modname, elf, mismatch, r, sym, fromsec, tosec);
+	default_mismatch_handler(modname, elf, mismatch, r, sym, fsecndx, fromsec,
+				 tosec);
 }
 
 static unsigned int *reloc_location(struct elf_info *elf,
@@ -1390,12 +1388,11 @@ static void section_rela(const char *modname, struct elf_info *elf,
 	Elf_Rela *rela;
 	Elf_Rela r;
 	unsigned int r_sym;
-	const char *fromsec;
-
+	unsigned int fsecndx = sechdr->sh_info;
+	const char *fromsec = sec_name(elf, fsecndx);
 	Elf_Rela *start = (void *)elf->hdr + sechdr->sh_offset;
 	Elf_Rela *stop  = (void *)start + sechdr->sh_size;
 
-	fromsec = sec_name(elf, sechdr->sh_info);
 	/* if from section (name) is know good then skip it */
 	if (match(fromsec, section_white_list))
 		return;
@@ -1434,7 +1431,7 @@ static void section_rela(const char *modname, struct elf_info *elf,
 		/* Skip special sections */
 		if (is_shndx_special(sym->st_shndx))
 			continue;
-		check_section_mismatch(modname, elf, &r, sym, fromsec);
+		check_section_mismatch(modname, elf, &r, sym, fsecndx, fromsec);
 	}
 }
 
@@ -1445,12 +1442,11 @@ static void section_rel(const char *modname, struct elf_info *elf,
 	Elf_Rel *rel;
 	Elf_Rela r;
 	unsigned int r_sym;
-	const char *fromsec;
-
+	unsigned int fsecndx = sechdr->sh_info;
+	const char *fromsec = sec_name(elf, fsecndx);
 	Elf_Rel *start = (void *)elf->hdr + sechdr->sh_offset;
 	Elf_Rel *stop  = (void *)start + sechdr->sh_size;
 
-	fromsec = sec_name(elf, sechdr->sh_info);
 	/* if from section (name) is know good then skip it */
 	if (match(fromsec, section_white_list))
 		return;
@@ -1493,7 +1489,7 @@ static void section_rel(const char *modname, struct elf_info *elf,
 		/* Skip special sections */
 		if (is_shndx_special(sym->st_shndx))
 			continue;
-		check_section_mismatch(modname, elf, &r, sym, fromsec);
+		check_section_mismatch(modname, elf, &r, sym, fsecndx, fromsec);
 	}
 }
 
-- 
2.39.2

