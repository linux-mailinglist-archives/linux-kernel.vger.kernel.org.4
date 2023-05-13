Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A0B7019CC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjEMUqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjEMUpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EAB5244;
        Sat, 13 May 2023 13:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BF3061568;
        Sat, 13 May 2023 20:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3BAC433EF;
        Sat, 13 May 2023 20:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684010733;
        bh=S8sfGMpcdCc3zG1JWXx9HjEnM+c5xOpRm1043WmmzDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWnqIErO2n0H2Cb5QoKDjBuibxX8HiMOclrzZf/FDE5xmRftN9b8g1NMdw+Wp8wyo
         TingOCmn49PBN0A8qRokwH1l1wzIzPxbHPZWI95s3erD+ZNxolysHuA/9L9SINnCnK
         bTRWK3v68p/kgdKEsrZUOl0h40Cnrn2L0GdSk7KdP3wH/ZDbBhe2JGVsMjcS2Gv3pl
         58kVZUrAUbOkYyybxegNT9N+iKMLwzLmWZ3Obj5R2jhIibjm6bhbf+ErD6dRXpoWpq
         eKfxah3KOwkExT0M+2WDsL9FKuGlrmRNBE/wNfufeD7uf/qJsufjaTAGms+wTU+S9Z
         EEYwlxU+CquEg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 10/21] modpost: simplify find_elf_symbol()
Date:   Sun, 14 May 2023 05:44:51 +0900
Message-Id: <20230513204502.1593923-11-masahiroy@kernel.org>
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

I do not know why commit 157c23c80eed ("kbuild: use simpler section
mismatch warnings in modpost") is only applicable to find_elf_symbol2().

Simplify find_elf_symbol() based on find_elf_symbol2().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 64 +++++++++----------------------------------
 1 file changed, 13 insertions(+), 51 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 3b7b78e69137..b4fa9e0be4d1 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1117,57 +1117,7 @@ static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
 	return !is_mapping_symbol(name);
 }
 
-/**
- * Find symbol based on relocation record info.
- * In some cases the symbol supplied is a valid symbol so
- * return refsym. If st_name != 0 we assume this is a valid symbol.
- * In other cases the symbol needs to be looked up in the symbol table
- * based on section and address.
- *  **/
-static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr,
-				Elf_Sym *relsym)
-{
-	Elf_Sym *sym;
-	Elf_Sym *near = NULL;
-	Elf64_Sword distance = 20;
-	Elf64_Sword d;
-	unsigned int relsym_secindex;
-
-	if (relsym->st_name != 0)
-		return relsym;
-
-	relsym_secindex = get_secindex(elf, relsym);
-	for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
-		if (get_secindex(elf, sym) != relsym_secindex)
-			continue;
-		if (ELF_ST_TYPE(sym->st_info) == STT_SECTION)
-			continue;
-		if (!is_valid_name(elf, sym))
-			continue;
-		if (sym->st_value == addr)
-			return sym;
-		/* Find a symbol nearby - addr are maybe negative */
-		d = sym->st_value - addr;
-		if (d < 0)
-			d = addr - sym->st_value;
-		if (d < distance) {
-			distance = d;
-			near = sym;
-		}
-	}
-	/* We need a close match */
-	if (distance < 20)
-		return near;
-	else
-		return NULL;
-}
-
-/*
- * Find symbols before or equal addr and after addr - in the section sec.
- * If we find two symbols with equal offset prefer one with a valid name.
- * The ELF format may have a better way to detect what type of symbol
- * it is, but this works for now.
- **/
+/* Look up the nearest symbol based on the section and the address */
 static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
 				 unsigned int secndx)
 {
@@ -1178,6 +1128,8 @@ static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
 	for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
 		if (get_secindex(elf, sym) != secndx)
 			continue;
+		if (ELF_ST_TYPE(sym->st_info) == STT_SECTION)
+			continue;
 		if (!is_valid_name(elf, sym))
 			continue;
 		if (sym->st_value <= addr && addr - sym->st_value <= distance) {
@@ -1188,6 +1140,16 @@ static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
 	return near;
 }
 
+static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf_Addr addr, Elf_Sym *sym)
+{
+	/* If the supplied symbol is valid, return it */
+	if (sym->st_name != 0)
+		return sym;
+
+	/* Otherwise, look up a better symbol */
+	return find_elf_symbol2(elf, addr, get_secindex(elf, sym));
+}
+
 static bool is_executable_section(struct elf_info *elf, unsigned int secndx)
 {
 	if (secndx > elf->num_sections)
-- 
2.39.2

