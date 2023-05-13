Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8127019DD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbjEMUrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbjEMUq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:46:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA2A40F9;
        Sat, 13 May 2023 13:46:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC4556158A;
        Sat, 13 May 2023 20:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF6CC433EF;
        Sat, 13 May 2023 20:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684010742;
        bh=SoXIycWj4KQdPY8pR5wZYEZwmM9FVSj+5ZmHcrpIoTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R++onr6agMmopZVmIWlYVYpkdqUBJqQ/SU72DJ0796Ipf7udrN2p2L+1DeMW0B1sI
         0NMjV0+YiyTrpDnZ0mF+FNKBz+NQm7zP/wd431jZBTJAgx97zwXoIArljD9QInVu7e
         GsekDjO+szMgvF68kJawfv7Oh4dOSuBkYQcpqc77XY13EBsd02Kmc80MBli4WcoRWo
         v4URHtc0GiVgoDd9uECD/fO/i9IL8dKC3Bo7KyM4Kg/O00f0xq0r5QTpJeQBYBAN/N
         zlzeTNV8YnYGuScz7S7O2cFXX9pG49U+bQzdPXXZMdlUk/09yDu5hzC4n48pxqDro+
         lfsW8mu71BTfA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 14/21] modpost: remove is_shndx_special() check from section_rel(a)
Date:   Sun, 14 May 2023 05:44:55 +0900
Message-Id: <20230513204502.1593923-15-masahiroy@kernel.org>
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

This check is unneeded. Without it, sec_name() will returns the null
string "", then section_mismatch() will return immediately.

Anyway, special section indices do not appear quite often in these
loops.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 43ce35377f6a..1c5dd81c0987 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1347,7 +1347,6 @@ static int addend_mips_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 static void section_rela(const char *modname, struct elf_info *elf,
 			 Elf_Shdr *sechdr)
 {
-	Elf_Sym  *sym;
 	Elf_Rela *rela;
 	Elf_Rela r;
 	unsigned int r_sym;
@@ -1390,11 +1389,8 @@ static void section_rela(const char *modname, struct elf_info *elf,
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
@@ -1402,7 +1398,6 @@ static void section_rela(const char *modname, struct elf_info *elf,
 static void section_rel(const char *modname, struct elf_info *elf,
 			Elf_Shdr *sechdr)
 {
-	Elf_Sym *sym;
 	Elf_Rel *rel;
 	Elf_Rela r;
 	unsigned int r_sym;
@@ -1449,11 +1444,8 @@ static void section_rel(const char *modname, struct elf_info *elf,
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

