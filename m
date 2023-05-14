Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083A1701E22
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 17:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbjENPaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 11:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbjENP35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 11:29:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2584C11;
        Sun, 14 May 2023 08:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D5E561825;
        Sun, 14 May 2023 15:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011BEC4339C;
        Sun, 14 May 2023 15:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684078090;
        bh=fhR5EjRHQOWqBwC6o7KBtApN+RZJKOZ2Jxm08oS087U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DnAzqVXAO0KjJ3yE5NdfUYgtXrg54if+wRTlfaAnAdSRK8UpgwCjvxTuberat6wxR
         XPcc/EoLJtvMv+2AMylE52Xrm0HhrRuCI+3cVsVdCXuJoq0NTLIlLzoa7GJ/sQ5zNP
         6cURnuBto0DGlQ3puFXY8Px5nY1H0/1TCyR/78EVKlNPrI5+dclb3T7DDtgKztzsbz
         mOcJL/McHz/31DP8Y2a7J/0iru077y3f/fxZ+653QyZkZ7wXB3qRFKejROhnXQQBln
         ViMFiG9uVm/kJfUlTj7eL3KPaTtgu/B1fMssumX5SllrwL9oiugW6sQ1Fr0asZvKuo
         iriiLh82D3T/A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v5 11/21] modpost: modpost: refactor find_fromsym() and find_tosym()
Date:   Mon, 15 May 2023 00:27:29 +0900
Message-Id: <20230514152739.962109-12-masahiroy@kernel.org>
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

find_fromsym() and find_tosym() are similar - both of them iterate
in the .symtab section and return the near symbol.

Factor out the common part into find_nearest_sym().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v5:
  - Fix broken symbol name in x86_64

 scripts/mod/modpost.c | 95 ++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 55 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0d2c2aff2c03..d147e8f63e52 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1117,77 +1117,62 @@ static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
 	return !is_mapping_symbol(name);
 }
 
-/**
- * Find symbol based on relocation record info.
- * In some cases the symbol supplied is a valid symbol so
- * return refsym. If st_name != 0 we assume this is a valid symbol.
- * In other cases the symbol needs to be looked up in the symbol table
- * based on section and address.
- *  **/
-static Elf_Sym *find_tosym(struct elf_info *elf, Elf64_Sword addr,
-			   Elf_Sym *relsym)
+/* Look up the nearest symbol based on the section and the address */
+static Elf_Sym *find_nearest_sym(struct elf_info *elf, Elf_Addr addr,
+				 unsigned int secndx, bool allow_negative)
 {
 	Elf_Sym *sym;
 	Elf_Sym *near = NULL;
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
-static Elf_Sym *find_fromsym(struct elf_info *elf, Elf_Addr addr,
-			     unsigned int secndx)
-{
-	Elf_Sym *sym;
-	Elf_Sym *near = NULL;
-	Elf_Addr distance = ~0;
+	Elf_Addr min_distance = ~0;
+	Elf_Addr distance;
 
 	for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
 		if (get_secindex(elf, sym) != secndx)
 			continue;
 		if (!is_valid_name(elf, sym))
 			continue;
-		if (sym->st_value <= addr && addr - sym->st_value <= distance) {
+
+		if (addr >= sym->st_value)
 			distance = addr - sym->st_value;
+		else if (allow_negative)
+			distance = sym->st_value - addr;
+		else
+			continue;
+
+		if (distance <= min_distance) {
+			min_distance = distance;
 			near = sym;
 		}
+
+		if (min_distance == 0)
+			break;
 	}
+
 	return near;
 }
 
+static Elf_Sym *find_fromsym(struct elf_info *elf, Elf_Addr addr,
+			     unsigned int secndx)
+{
+	return find_nearest_sym(elf, addr, secndx, false);
+}
+
+static Elf_Sym *find_tosym(struct elf_info *elf, Elf_Addr addr, Elf_Sym *sym)
+{
+	/* If the supplied symbol has a name, return it */
+	if (sym->st_name != 0)
+		return sym;
+
+	/*
+	 * Otherwise, look up the symbol.
+	 * For example, if the referenced symbol is static, sym->st_name is
+	 * zero. So, we need the look-up to know the symbol name.
+	 * The 'addr' might be smaller than the st_value of the symbol we are
+	 * looking for. Hence, allow_negative=true.
+	 */
+	return find_nearest_sym(elf, addr, get_secindex(elf, sym), true);
+}
+
 static bool is_executable_section(struct elf_info *elf, unsigned int secndx)
 {
 	if (secndx > elf->num_sections)
-- 
2.39.2

