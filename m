Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660F47019CE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjEMUqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbjEMUqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:46:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAAF30DD;
        Sat, 13 May 2023 13:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D6C761560;
        Sat, 13 May 2023 20:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74892C433D2;
        Sat, 13 May 2023 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684010736;
        bh=UBmbLHMdFpSRpFyV2wZhJFy40YVEfPTeOi0mqPgGBZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ralk35dnMK8RRPBgmtUGBCK5Dz2Cqz0JkKMiNTJpuIOZpdQ6Fl6K5ZVZzVz5A9ucx
         jqvaT2OI45ea17Je2Mhnpb0ZFVytc/54/1NGWshzBDwhBW8bgRKWqT2ih1B8QD0TFN
         4hVHeveU7QLdBTMXMssx3M7vT6rv9zabvEryKtK8/lTdRVgfMO9Higq1ClPhDWFaB0
         jI60tZuN3sp0JxBaKQSEgs+ikpuK617mAfJCwLV6w5x/sXy1sKCriD1Jxnq4nt4uST
         NiNRigqon1SQut2QUbl2Dcl+AckiL8odO04ul04PRr2cmuNrTBSzp9TLV+LAoiiNSy
         QXUtkcfn8OSKA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 11/21] modpost: rename find_elf_symbol() and find_elf_symbol2()
Date:   Sun, 14 May 2023 05:44:52 +0900
Message-Id: <20230513204502.1593923-12-masahiroy@kernel.org>
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

find_elf_symbol() and find_elf_symbol2() are not good names.

Rename them to find_better_symbol(), find_nearest_symbol(),
respectively.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index b4fa9e0be4d1..d2a9c655f6ea 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1118,8 +1118,8 @@ static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
 }
 
 /* Look up the nearest symbol based on the section and the address */
-static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
-				 unsigned int secndx)
+static Elf_Sym *find_nearest_symbol(struct elf_info *elf, Elf_Addr addr,
+				    unsigned int secndx)
 {
 	Elf_Sym *sym;
 	Elf_Sym *near = NULL;
@@ -1140,14 +1140,14 @@ static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
 	return near;
 }
 
-static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf_Addr addr, Elf_Sym *sym)
+static Elf_Sym *find_better_symbol(struct elf_info *elf, Elf_Addr addr, Elf_Sym *sym)
 {
 	/* If the supplied symbol is valid, return it */
 	if (sym->st_name != 0)
 		return sym;
 
 	/* Otherwise, look up a better symbol */
-	return find_elf_symbol2(elf, addr, get_secindex(elf, sym));
+	return find_nearest_symbol(elf, addr, get_secindex(elf, sym));
 }
 
 static bool is_executable_section(struct elf_info *elf, unsigned int secndx)
@@ -1169,10 +1169,10 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	const char *tosym;
 	const char *fromsym;
 
-	from = find_elf_symbol2(elf, r->r_offset, fsecndx);
+	from = find_nearest_symbol(elf, r->r_offset, fsecndx);
 	fromsym = sym_name(elf, from);
 
-	to = find_elf_symbol(elf, r->r_addend, sym);
+	to = find_better_symbol(elf, r->r_addend, sym);
 	tosym = sym_name(elf, to);
 
 	/* check whitelist - we may ignore it */
-- 
2.39.2

