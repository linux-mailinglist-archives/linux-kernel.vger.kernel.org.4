Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B36970AEC9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjEUQFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjEUQFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:05:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1459118;
        Sun, 21 May 2023 09:05:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AE3D60F9D;
        Sun, 21 May 2023 16:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CCCC433A0;
        Sun, 21 May 2023 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684685128;
        bh=zRzYFZ5lz7mHPL94B6DS35Xto1/srS4BQ/bsgLZFHtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dv23FCUuRpa+ZEAYxnbcBXiZtmulasqyIrSh8r9/2+5am8ohuf6zVRSwxHaxNCfYb
         LBB8YG3NeWJnXaHLCc6TejAnMgRV1sUtv8so12TbAgLtIzst4SBrW0CZISIl2lDmXY
         ZnFYRh1fkJHDOAVuFdk7Y88Fn2nCLjqCQuSjY5bBdx+SSe/JfjLO+DVYdSQzs1mc/l
         XXUyTIYKapKFM0kWcmeMyiOhxRjtaPKKJSLCTTKAuYPukwEndFB917bfiU27rbX+Fz
         zi6LuZbk/dq2n8zX/40hartEu++K5PNXlWATifFDKSOjC0pRTT+Afi0HlbEaa8FXxt
         MUuCLR3zeilDg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 08/20] modpost: remove is_shndx_special() check from section_rel(a)
Date:   Mon, 22 May 2023 01:04:13 +0900
Message-Id: <20230521160426.1881124-9-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230521160426.1881124-1-masahiroy@kernel.org>
References: <20230521160426.1881124-1-masahiroy@kernel.org>
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

This check is unneeded. Without it, sec_name() will returns the null
string "", then section_mismatch() will return immediately.

Anyway, special section indices rarely appear in these loops.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v6:
  - Remove is_shndx_special() definition

 scripts/mod/modpost.c | 16 ++++------------
 scripts/mod/modpost.h |  5 -----
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f364738a236e..40fac4f64fcd 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1361,7 +1361,6 @@ static int addend_mips_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 static void section_rela(const char *modname, struct elf_info *elf,
 			 Elf_Shdr *sechdr)
 {
-	Elf_Sym  *sym;
 	Elf_Rela *rela;
 	Elf_Rela r;
 	unsigned int r_sym;
@@ -1404,11 +1403,8 @@ static void section_rela(const char *modname, struct elf_info *elf,
 				continue;
 			break;
 		}
-		sym = elf->symtab_start + r_sym;
-		/* Skip special sections */
-		if (is_shndx_special(sym->st_shndx))
-			continue;
-		check_section_mismatch(modname, elf, sym,
+
+		check_section_mismatch(modname, elf, elf->symtab_start + r_sym,
 				       fsecndx, fromsec, r.r_offset, r.r_addend);
 	}
 }
@@ -1416,7 +1412,6 @@ static void section_rela(const char *modname, struct elf_info *elf,
 static void section_rel(const char *modname, struct elf_info *elf,
 			Elf_Shdr *sechdr)
 {
-	Elf_Sym *sym;
 	Elf_Rel *rel;
 	Elf_Rela r;
 	unsigned int r_sym;
@@ -1463,11 +1458,8 @@ static void section_rel(const char *modname, struct elf_info *elf,
 		default:
 			fatal("Please add code to calculate addend for this architecture\n");
 		}
-		sym = elf->symtab_start + r_sym;
-		/* Skip special sections */
-		if (is_shndx_special(sym->st_shndx))
-			continue;
-		check_section_mismatch(modname, elf, sym,
+
+		check_section_mismatch(modname, elf, elf->symtab_start + r_sym,
 				       fsecndx, fromsec, r.r_offset, r.r_addend);
 	}
 }
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 1178f40a73f3..b1e2d95f8047 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -151,11 +151,6 @@ struct elf_info {
 	Elf32_Word   *symtab_shndx_stop;
 };
 
-static inline int is_shndx_special(unsigned int i)
-{
-	return i != SHN_XINDEX && i >= SHN_LORESERVE && i <= SHN_HIRESERVE;
-}
-
 /* Accessor for sym->st_shndx, hides ugliness of "64k sections" */
 static inline unsigned int get_secindex(const struct elf_info *info,
 					const Elf_Sym *sym)
-- 
2.39.2

