Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A835E701E23
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 17:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjENPaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 11:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbjENP36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 11:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29C03C27;
        Sun, 14 May 2023 08:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C17CC6181D;
        Sun, 14 May 2023 15:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88579C433D2;
        Sun, 14 May 2023 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684078097;
        bh=TjK5vRQ4AG9lfNTTEX4WG1cFCBfFWQ69ySiU2xVg33I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpUtzLukxKl9IfHjnbn7g+E9RDy351uv6gDpCfdBYL3LaEHi9jTEgbQMJvXVwZfSF
         VvxH83aQ43TqdBXIGWDWmnadtx0UdS7+HSYqEXl3Ln8AKIMUa0QTRbsfagMy49fJxq
         xAmuKiLnwdH5SWl17rG5yIYKwnbXgni1/qLFHR8Mi5ZqK2hFgRjmJXX7KzI0WDq/P+
         c7+bnBZ43c29UZvkNvnojWP8Mpm4Vuyf8pk6FDR8X7Z8kANCkeXfskVySLmzFQq6jI
         O82+7bp4JIuNTLsrkAtqL0NrX7eKPAPQIXvkGvRygpajgjvS7B+x0cWdXgju/c6gOp
         PL90KJ9tscB4A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v5 14/21] modpost: remove is_shndx_special() check from section_rel(a)
Date:   Mon, 15 May 2023 00:27:32 +0900
Message-Id: <20230514152739.962109-15-masahiroy@kernel.org>
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

This check is unneeded. Without it, sec_name() will returns the null
string "", then section_mismatch() will return immediately.

Anyway, special section indices do not appear quite often in these
loops.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0ef9d6964b6a..28db215ecc71 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1370,7 +1370,6 @@ static int addend_mips_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 static void section_rela(const char *modname, struct elf_info *elf,
 			 Elf_Shdr *sechdr)
 {
-	Elf_Sym  *sym;
 	Elf_Rela *rela;
 	Elf_Rela r;
 	unsigned int r_sym;
@@ -1413,11 +1412,8 @@ static void section_rela(const char *modname, struct elf_info *elf,
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
@@ -1425,7 +1421,6 @@ static void section_rela(const char *modname, struct elf_info *elf,
 static void section_rel(const char *modname, struct elf_info *elf,
 			Elf_Shdr *sechdr)
 {
-	Elf_Sym *sym;
 	Elf_Rel *rel;
 	Elf_Rela r;
 	unsigned int r_sym;
@@ -1472,11 +1467,8 @@ static void section_rel(const char *modname, struct elf_info *elf,
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
-- 
2.39.2

