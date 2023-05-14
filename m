Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A21B701E10
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 17:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbjENP3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbjENP2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 11:28:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F34530E1;
        Sun, 14 May 2023 08:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 892D66177B;
        Sun, 14 May 2023 15:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE91C433A1;
        Sun, 14 May 2023 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684078092;
        bh=QEbX8slSLfdvKL7Judwq4MdAmwErOXYMizfNrkW0R2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvaA802YG5i64zcCH5bkd2MiFB9dxW07sbZ9brxB4sYAO3DuPmIMTsgWpsNmR2Bcx
         GdyYb81TnBG7+jMoUTqVnEg8FEmIYNwuGaL4Ry3U96M7EeHGD3aZmw4PUbbzs8hNAf
         IHrgVjocKb0TuqmdP+TSDSstluVD5NzPB8Dk2BAFTMeB2CVL+LPlHqBux6DVAUCDPb
         rFLq8t+JLkRJoehTyaIqnMwlTjuBxcuQC1T6JwQa8mIns461CxzfVVn4bi9CmPY7cn
         D88tIDJk7M4trYqiDlLxGNfz+zpGPpq9N+ACNpAf9P6wr54fvmQILMIWx9xxmeNpDu
         fx0fTqi7yLlhA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v5 12/21] modpost: unify 'sym' and 'to' in default_mismatch_handler()
Date:   Mon, 15 May 2023 00:27:30 +0900
Message-Id: <20230514152739.962109-13-masahiroy@kernel.org>
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

find_tosym() takes 'sym' and stores the return value to another
variable 'to'. You can use the same variable because we want to
replace the original one when appropriate.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d147e8f63e52..7601f2ca28ed 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1183,11 +1183,10 @@ static bool is_executable_section(struct elf_info *elf, unsigned int secndx)
 
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
@@ -1195,8 +1194,8 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	from = find_fromsym(elf, r->r_offset, fsecndx);
 	fromsym = sym_name(elf, from);
 
-	to = find_tosym(elf, r->r_addend, sym);
-	tosym = sym_name(elf, to);
+	tsym = find_tosym(elf, r->r_addend, tsym);
+	tosym = sym_name(elf, tsym);
 
 	/* check whitelist - we may ignore it */
 	if (!secref_whitelist(mismatch, fromsec, fromsym, tosec, tosym))
@@ -1231,7 +1230,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
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

