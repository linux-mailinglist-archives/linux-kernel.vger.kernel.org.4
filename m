Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697FD736B88
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjFTMFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjFTMF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:05:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DFE170C;
        Tue, 20 Jun 2023 05:05:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1F1C611EA;
        Tue, 20 Jun 2023 12:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C678FC433C8;
        Tue, 20 Jun 2023 12:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687262727;
        bh=fo/HY+4/U2YoL8+5myRX8J+xt11fEMJWxO7l4IEHPH8=;
        h=From:To:Cc:Subject:Date:From;
        b=BdJBhZ2pi6yfDXYGE1RXqL+cmvlCGxYZJ3/FD0mqpEWoHOfavsABlo5ii6L5HoPvl
         GeQsxNRHs3NimIw8hB438iHjwAHWncN5XGRiyYI0iourWuzGJEGmlwXSskFvi4ncGe
         +Q6fqMMSS5Bc/DgF/2wElaJuuBTg5WUfyt2kUp6LRKFXGT/ruYPee1WJ0JWdzY6xh9
         kWzscZNA0+18nP8SJedpsX83oTz+CRHvV1V9Iha53KJSKjMQAudIZTNEIN+VlQejgB
         7e1MDtVirm4VgCZJNHTkVkb7noEd794QJ+GcEe2P78q8TsQWtB/BmJFRHSahjTQ6kz
         B4gaoRVlkLHqQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 1/3] modpost: factor out inst location calculation to section_rel()
Date:   Tue, 20 Jun 2023 21:05:19 +0900
Message-Id: <20230620120521.688124-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
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

All the addend_*_rel() functions calculate the instruction location in
the same way.

Factor out the similar code to the caller. Squash reloc_location() too.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6e0b8be32648..2551ac9d5bd3 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1256,16 +1256,9 @@ static void check_section_mismatch(struct module *mod, struct elf_info *elf,
 				 tosec, taddr);
 }
 
-static unsigned int *reloc_location(struct elf_info *elf,
-				    Elf_Shdr *sechdr, Elf_Rela *r)
-{
-	return sym_get_data_by_offset(elf, sechdr->sh_info, r->r_offset);
-}
-
-static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
+static int addend_386_rel(uint32_t *location, Elf_Rela *r)
 {
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
-	unsigned int *location = reloc_location(elf, sechdr, r);
 
 	switch (r_typ) {
 	case R_386_32:
@@ -1302,11 +1295,10 @@ static int32_t sign_extend32(int32_t value, int index)
 	return (int32_t)(value << shift) >> shift;
 }
 
-static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
+static int addend_arm_rel(void *loc, struct elf_info *elf, Elf_Rela *r)
 {
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
 	Elf_Sym *sym = elf->symtab_start + ELF_R_SYM(r->r_info);
-	void *loc = reloc_location(elf, sechdr, r);
 	uint32_t inst, upper, lower, sign, j1, j2;
 	int32_t offset;
 
@@ -1396,11 +1388,10 @@ static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 	return 0;
 }
 
-static int addend_mips_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
+static int addend_mips_rel(uint32_t *location, Elf_Rela *r)
 {
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
-	unsigned int *location = reloc_location(elf, sechdr, r);
-	unsigned int inst;
+	uint32_t inst;
 
 	if (r_typ == R_MIPS_HI16)
 		return 1;	/* skip this */
@@ -1502,6 +1493,8 @@ static void section_rel(struct module *mod, struct elf_info *elf,
 		return;
 
 	for (rel = start; rel < stop; rel++) {
+		void *loc;
+
 		r.r_offset = TO_NATIVE(rel->r_offset);
 #if KERNEL_ELFCLASS == ELFCLASS64
 		if (elf->hdr->e_machine == EM_MIPS) {
@@ -1519,17 +1512,20 @@ static void section_rel(struct module *mod, struct elf_info *elf,
 		r_sym = ELF_R_SYM(r.r_info);
 #endif
 		r.r_addend = 0;
+
+		loc = sym_get_data_by_offset(elf, fsecndx, r.r_offset);
+
 		switch (elf->hdr->e_machine) {
 		case EM_386:
-			if (addend_386_rel(elf, sechdr, &r))
+			if (addend_386_rel(loc, &r))
 				continue;
 			break;
 		case EM_ARM:
-			if (addend_arm_rel(elf, sechdr, &r))
+			if (addend_arm_rel(loc, elf, &r))
 				continue;
 			break;
 		case EM_MIPS:
-			if (addend_mips_rel(elf, sechdr, &r))
+			if (addend_mips_rel(loc, &r))
 				continue;
 			break;
 		default:
-- 
2.39.2

