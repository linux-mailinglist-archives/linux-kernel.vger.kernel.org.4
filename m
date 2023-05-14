Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24202701E06
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 17:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjENP2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 11:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237729AbjENP2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 11:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5872D71;
        Sun, 14 May 2023 08:28:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5064360BC9;
        Sun, 14 May 2023 15:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E0CC4339C;
        Sun, 14 May 2023 15:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684078079;
        bh=jbC/dpcVk49KvymLiywF5ReeRJJkXEV051g5YJJC5YE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X4zq1fZVtIF2I66r9xVZuN0I6rX3ha2El+7EE2vI9GTXdB/hFN7Ye7esoLbTKjnxn
         gG8d9of5r3d72wmLzQ9ZEuojJEm1spge3tHd3fNCtN+mi48/FFVffON9F7jAEKL2df
         DJi2EbBb1K9cF+qIO+w3cFgMHQfwhT1ij33L+DPMC99vxyFcdYNTtD4W2menLWfImV
         JZWpx1vN0iMfk1veNy3nWqnRl/IL3gxvLX/k1hm7US8hkYnXPB/8qZP5K27AYnBdd1
         3RNbuipjIGQtbtBKRdtitcGQNQBuMIuP2SUs3tTV4e+lL+sO8jeOpsF1zdi+lvxTg0
         PRUMfw26Z/wHg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v5 06/21] modpost: clean up is_executable_section()
Date:   Mon, 15 May 2023 00:27:24 +0900
Message-Id: <20230514152739.962109-7-masahiroy@kernel.org>
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

SHF_EXECINSTR is a bit flag (#define SHF_EXECINSTR 0x4).
Compare the masked flag to '!= 0'.

There is no good reason to stop modpost immediately even if a special
section index is given. You will get a section mismatch error anyway.

Also, change the return type to bool.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index bb7d1d87bae7..0bda2f22c985 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1207,6 +1207,14 @@ static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
 	return near;
 }
 
+static bool is_executable_section(struct elf_info *elf, unsigned int secndx)
+{
+	if (secndx > elf->num_sections)
+		return false;
+
+	return (elf->sechdrs[secndx].sh_flags & SHF_EXECINSTR) != 0;
+}
+
 static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 				     const struct sectioncheck* const mismatch,
 				     Elf_Rela *r, Elf_Sym *sym, const char *fromsec)
@@ -1252,14 +1260,6 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	}
 }
 
-static int is_executable_section(struct elf_info* elf, unsigned int section_index)
-{
-	if (section_index > elf->num_sections)
-		fatal("section_index is outside elf->num_sections!\n");
-
-	return ((elf->sechdrs[section_index].sh_flags & SHF_EXECINSTR) == SHF_EXECINSTR);
-}
-
 static void extable_mismatch_handler(const char* modname, struct elf_info *elf,
 				     const struct sectioncheck* const mismatch,
 				     Elf_Rela* r, Elf_Sym* sym,
-- 
2.39.2

