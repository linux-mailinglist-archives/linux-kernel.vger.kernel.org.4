Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F23D7019D0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjEMUqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbjEMUqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:46:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A50049E2;
        Sat, 13 May 2023 13:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B609F61575;
        Sat, 13 May 2023 20:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB5DC433D2;
        Sat, 13 May 2023 20:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684010738;
        bh=MK50kQzYPm9nr14jP1vittYESWZFYCDkDk5qdO0JFYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kjosXOAe8a+7yCECWXziTSeLRdI5oux1AnfMVV12bnTMdNWN0rS/cFOC//2AwKtIA
         HFBpCHQzb1Q7kJQdaGomnX5bckQQDAzsXs+zJ3Gli+NdsY2hdC1IeFBgWBsvWBnKCS
         U1W7D7zC7khJqgf//ru7vig5vtQiAs43d2Ucpqhet8E1jhSHbUCTJ93Xvwjf/w2Ehy
         3R2K7DfnWhLuISTaYm4ml9eawopQvf9LQ6WX+HCX9sRi3TMksGIxE1gTd1eE4bf+aa
         M0qmQ3wXHF7zJP9fHRj5fgNlzl/TqvYB9e82NQ3s9duw23DiArgGMiAaX2Qazi13Yf
         yFlKh8KSLxfDw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 12/21] modpost: unify 'sym' and 'to' in default_mismatch_handler()
Date:   Sun, 14 May 2023 05:44:53 +0900
Message-Id: <20230513204502.1593923-13-masahiroy@kernel.org>
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

find_better_symbol() takes 'sym' and stores the return value to
another variable 'to'.

We can use the same variable because we want to replace the original
one if possible.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d2a9c655f6ea..9e81cd6803a7 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1160,11 +1160,10 @@ static bool is_executable_section(struct elf_info *elf, unsigned int secndx)
 
 static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 				     const struct sectioncheck* const mismatch,
-				     Elf_Rela *r, Elf_Sym *sym,
+				     Elf_Rela *r, Elf_Sym *tsym,
 				     unsigned int fsecndx, const char *fromsec,
 				     const char *tosec)
 {
-	Elf_Sym *to;
 	Elf_Sym *from;
 	const char *tosym;
 	const char *fromsym;
@@ -1172,8 +1171,8 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	from = find_nearest_symbol(elf, r->r_offset, fsecndx);
 	fromsym = sym_name(elf, from);
 
-	to = find_better_symbol(elf, r->r_addend, sym);
-	tosym = sym_name(elf, to);
+	tsym = find_better_symbol(elf, r->r_addend, tsym);
+	tosym = sym_name(elf, tsym);
 
 	/* check whitelist - we may ignore it */
 	if (!secref_whitelist(mismatch, fromsec, fromsym, tosec, tosym))
@@ -1208,7 +1207,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 			      "You might get more information about where this is\n"
 			      "coming from by using scripts/check_extable.sh %s\n",
 			      fromsec, (long)r->r_offset, tosec, modname);
-		else if (is_executable_section(elf, get_secindex(elf, sym)))
+		else if (is_executable_section(elf, get_secindex(elf, tsym)))
 			warn("The relocation at %s+0x%lx references\n"
 			     "section \"%s\" which is not in the list of\n"
 			     "authorized sections.  If you're adding a new section\n"
-- 
2.39.2

