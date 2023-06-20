Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48648736B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjFTMFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjFTMFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:05:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C951010F3;
        Tue, 20 Jun 2023 05:05:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B9D5611FB;
        Tue, 20 Jun 2023 12:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0CEC433CA;
        Tue, 20 Jun 2023 12:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687262728;
        bh=2ReNXn5QKyfmsIaf+RPx+AKwwDkxRAR+rcyRaaWC81Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgueyVrtoivd4awbdEnSIoa4Jbw+JcNKE+wbISLopEeSRnV96cql5isRbTSgBJbzQ
         25YKqrFH+ofdk+3xOhIXEWAr1sIpkrC6NXYhiT8O7G4awRamuhivH9umAUmhN7Jdfm
         sA/VauSD3Pn097KlGDesTcvIrqZNn81ZiOKfnmXHl71sqO1v3xPoC6To8wMZvrrQvP
         Ovv/8b7THfmlLF1Q+RX2oU/mlDJVxWUt/ZPOG5b6FczqIPF+6m29sOE0Hs79Ml1+RR
         MUkP7sZDDZGyF3Ymm6oZsJbV79gaNaP0vkv2I/1rR2ZqI9CFSzfiixmpHSmdl2x6ft
         aHDygN0MS8ueQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 2/3] modpost: factor out Elf_Sym pointer calculation to section_rel()
Date:   Tue, 20 Jun 2023 21:05:20 +0900
Message-Id: <20230620120521.688124-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230620120521.688124-1-masahiroy@kernel.org>
References: <20230620120521.688124-1-masahiroy@kernel.org>
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

Pass the Elf_Sym pointer to addend_arm_rel() as well as to
check_section_mismatch().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 2551ac9d5bd3..ffe45c54f024 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1295,10 +1295,9 @@ static int32_t sign_extend32(int32_t value, int index)
 	return (int32_t)(value << shift) >> shift;
 }
 
-static int addend_arm_rel(void *loc, struct elf_info *elf, Elf_Rela *r)
+static int addend_arm_rel(void *loc, Elf_Sym *sym, Elf_Rela *r)
 {
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
-	Elf_Sym *sym = elf->symtab_start + ELF_R_SYM(r->r_info);
 	uint32_t inst, upper, lower, sign, j1, j2;
 	int32_t offset;
 
@@ -1493,6 +1492,7 @@ static void section_rel(struct module *mod, struct elf_info *elf,
 		return;
 
 	for (rel = start; rel < stop; rel++) {
+		Elf_Sym *tsym;
 		void *loc;
 
 		r.r_offset = TO_NATIVE(rel->r_offset);
@@ -1514,6 +1514,7 @@ static void section_rel(struct module *mod, struct elf_info *elf,
 		r.r_addend = 0;
 
 		loc = sym_get_data_by_offset(elf, fsecndx, r.r_offset);
+		tsym = elf->symtab_start + ELF_R_SYM(r.r_info);
 
 		switch (elf->hdr->e_machine) {
 		case EM_386:
@@ -1521,7 +1522,7 @@ static void section_rel(struct module *mod, struct elf_info *elf,
 				continue;
 			break;
 		case EM_ARM:
-			if (addend_arm_rel(loc, elf, &r))
+			if (addend_arm_rel(loc, tsym, &r))
 				continue;
 			break;
 		case EM_MIPS:
@@ -1532,7 +1533,7 @@ static void section_rel(struct module *mod, struct elf_info *elf,
 			fatal("Please add code to calculate addend for this architecture\n");
 		}
 
-		check_section_mismatch(mod, elf, elf->symtab_start + r_sym,
+		check_section_mismatch(mod, elf, tsym,
 				       fsecndx, fromsec, r.r_offset, r.r_addend);
 	}
 }
-- 
2.39.2

