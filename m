Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F6B701E14
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 17:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbjENP3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 11:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbjENP2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 11:28:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C4426BB;
        Sun, 14 May 2023 08:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21193617ED;
        Sun, 14 May 2023 15:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D070BC433A0;
        Sun, 14 May 2023 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684078088;
        bh=8ZBP8uGhdn6vymdReCFLqoFR/6d0pI8J40+zPKwqxLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kev9/qXTSyKaeSlY42WQz9vaY+u7B6/qITizsJc1S12FQ8OmG2JxdmXpIJ6DkA8eC
         TM4willLy7IYQGrRi6sNIDL9zL4cXbmJcn9J2iPj+EnVc95ru6iBcNpLLlKhTGh2uQ
         UtzZn5Q+Lr6LzP8WcYAVyGglC4un8IZHjngPPVU//yQ5k9WAcAR5VVXham6TKHhejQ
         u4ih9digWpY2dYt2H2pWkqDmW3+W7HqTtEZXAxJ0cz6rWjzEYUiAJqMLPW/RmE1IXO
         cS/6kLsTLnwQyg/HVkfmv6iT5HmT2IJO0I+lamUcQe6oCD4KI2IY9XPnPnne36eBuD
         79h5tSbzIB6Wg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v5 10/21] modpost: rename find_elf_symbol() and find_elf_symbol2()
Date:   Mon, 15 May 2023 00:27:28 +0900
Message-Id: <20230514152739.962109-11-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230514152739.962109-1-masahiroy@kernel.org>
References: <20230514152739.962109-1-masahiroy@kernel.org>
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

Rename them to find_tosym(), find_fromsym(), respectively.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v5:
  - Change the names

 scripts/mod/modpost.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 3b7b78e69137..0d2c2aff2c03 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1124,8 +1124,8 @@ static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
  * In other cases the symbol needs to be looked up in the symbol table
  * based on section and address.
  *  **/
-static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr,
-				Elf_Sym *relsym)
+static Elf_Sym *find_tosym(struct elf_info *elf, Elf64_Sword addr,
+			   Elf_Sym *relsym)
 {
 	Elf_Sym *sym;
 	Elf_Sym *near = NULL;
@@ -1168,8 +1168,8 @@ static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr,
  * The ELF format may have a better way to detect what type of symbol
  * it is, but this works for now.
  **/
-static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
-				 unsigned int secndx)
+static Elf_Sym *find_fromsym(struct elf_info *elf, Elf_Addr addr,
+			     unsigned int secndx)
 {
 	Elf_Sym *sym;
 	Elf_Sym *near = NULL;
@@ -1207,10 +1207,10 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	const char *tosym;
 	const char *fromsym;
 
-	from = find_elf_symbol2(elf, r->r_offset, fsecndx);
+	from = find_fromsym(elf, r->r_offset, fsecndx);
 	fromsym = sym_name(elf, from);
 
-	to = find_elf_symbol(elf, r->r_addend, sym);
+	to = find_tosym(elf, r->r_addend, sym);
 	tosym = sym_name(elf, to);
 
 	/* check whitelist - we may ignore it */
-- 
2.39.2

