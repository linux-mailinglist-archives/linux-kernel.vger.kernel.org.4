Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7F0719BA1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjFAMK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjFAMKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:10:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1DD185;
        Thu,  1 Jun 2023 05:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E16D8641A9;
        Thu,  1 Jun 2023 12:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BC9C433EF;
        Thu,  1 Jun 2023 12:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685621429;
        bh=TumhD82QuLF3iemxAixVbZIrBkyosIOpPKFtYaO9xHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hGgyvVuZ5OVhoGMX5ceciMv+KWLO8ZPAesvX1NWRUurLKmwfbYvxzOqdr54Vue2/6
         EOVfYclvxj7ruH6+I9anSh7koqj0GmxAq+VSrJLipKoykEL2pJSeOQqNdGZaE5eed4
         RnhpQY9NeXw2fskX+uNs0feNwN51vqkrP84jkz9DaminwiWeNNP1hbq/fON/6JiW/W
         9mOPaHzGkMdioEcOZUH4pH14c7a6HJzJizPXBAtfuvNbaTrXjMRUpnzl7K0tf1W3PT
         Y6kZ9OqTIBHmqYwhuSiSkKpt7RqU539SLl29uSg8l3wUJubpTIWu2W9634H5YzReiz
         f4Z4hPIw0Sw8w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 4/7] modpost: refactor find_fromsym() and find_tosym()
Date:   Thu,  1 Jun 2023 21:09:58 +0900
Message-Id: <20230601121001.1071533-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601121001.1071533-1-masahiroy@kernel.org>
References: <20230601121001.1071533-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_fromsym() and find_tosym() are similar - both of them iterate
in the .symtab section and return the nearest symbol.

The difference between them is that find_tosym() allows a negative
distance, but the distance must be less than 20.

Factor out the common part into find_nearest_sym().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 95 ++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 59 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 5a5e802b160c..32d56efe3f3b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1075,81 +1075,58 @@ static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
 	return !is_mapping_symbol(name);
 }
 
-/**
- * Find symbol based on relocation record info.
- * In some cases the symbol supplied is a valid symbol so
- * return refsym. If is_valid_name() == true, we assume this is a valid symbol.
- * In other cases the symbol needs to be looked up in the symbol table
- * based on section and address.
- *  **/
-static Elf_Sym *find_tosym(struct elf_info *elf, Elf64_Sword addr,
-			   Elf_Sym *relsym)
+/* Look up the nearest symbol based on the section and the address */
+static Elf_Sym *find_nearest_sym(struct elf_info *elf, Elf_Addr addr,
+				 unsigned int secndx, bool allow_negative,
+				 Elf_Addr min_distance)
 {
 	Elf_Sym *sym;
 	Elf_Sym *near = NULL;
-	Elf64_Sword distance = 20;
-	Elf64_Sword d;
-	unsigned int relsym_secindex;
-
-	if (is_valid_name(elf, relsym))
-		return relsym;
-
-	/*
-	 * Strive to find a better symbol name, but the resulting name may not
-	 * match the symbol referenced in the original code.
-	 */
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
 	return near;
 }
 
+static Elf_Sym *find_fromsym(struct elf_info *elf, Elf_Addr addr,
+			     unsigned int secndx)
+{
+	return find_nearest_sym(elf, addr, secndx, false, ~0);
+}
+
+static Elf_Sym *find_tosym(struct elf_info *elf, Elf_Addr addr, Elf_Sym *sym)
+{
+	/* If the supplied symbol has a valid name, return it */
+	if (is_valid_name(elf, sym))
+		return sym;
+
+	/*
+	 * Strive to find a better symbol name, but the resulting name may not
+	 * match the symbol referenced in the original code.
+	 */
+	return find_nearest_sym(elf, addr, get_secindex(elf, sym), true, 20);
+}
+
 static bool is_executable_section(struct elf_info *elf, unsigned int secndx)
 {
 	if (secndx > elf->num_sections)
-- 
2.39.2

