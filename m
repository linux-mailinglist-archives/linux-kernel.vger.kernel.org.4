Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3B4736B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjFTMFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjFTMFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:05:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46BBE7;
        Tue, 20 Jun 2023 05:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41354611FD;
        Tue, 20 Jun 2023 12:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F70C433CB;
        Tue, 20 Jun 2023 12:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687262730;
        bh=ZLfc+BSXjZJWCTWdJRPUCYMoN06HfdLCglJJPJ8L31Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9Y5Pp5twFPMxnncPtk/qaRl6y59jcV46j961RurHjbJBOLkh7Z/blHDOcPHOSSS/
         ozQxCkpfI8e+MEn/iGB0qYzfKHLEIDNirR5Qh9tuCEha3ijLYRpzT+LykDOdirkCbV
         0dCnCdRgxYx3dRq9PsjnxO4O4nOUVLC1yjAQsZ0pUvoAQysIE9AJx+VNl1sAcx7XWq
         lTgjpwGhTvAJUMQEyZX25gja5520ZEWYUSZOfLayal1b1WzJlA0CuRE/ePF3/gxzKL
         dXi2TdV9+bCRiCmvaw6CeVm1vDSGuI95AKpSJCdYBFerD7yoFh+axB7R7JNZqga2TU
         /l9bxglQFZqZw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 3/3] modpost: continue even with unknown relocation type
Date:   Tue, 20 Jun 2023 21:05:21 +0900
Message-Id: <20230620120521.688124-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230620120521.688124-1-masahiroy@kernel.org>
References: <20230620120521.688124-1-masahiroy@kernel.org>
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

Currently, unknown relocation types are just skipped.

The value of r_addend is only needed to get the symbol name in case
is_valid_name(elf, sym) returns false.

Even if we do not know how to calculate r_addend, we should continue.
At worst, we will get "(unknown)" as the symbol name, but it is better
than failing to detect section mismatches.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index ffe45c54f024..7e92380d4f1f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1267,6 +1267,8 @@ static int addend_386_rel(uint32_t *location, Elf_Rela *r)
 	case R_386_PC32:
 		r->r_addend = TO_NATIVE(*location) + 4;
 		break;
+	default:
+		r->r_addend = (Elf_Addr)(-1);
 	}
 	return 0;
 }
@@ -1382,7 +1384,7 @@ static int addend_arm_rel(void *loc, Elf_Sym *sym, Elf_Rela *r)
 		r->r_addend = offset + sym->st_value + 4;
 		break;
 	default:
-		return 1;
+		r->r_addend = (Elf_Addr)(-1);
 	}
 	return 0;
 }
@@ -1392,8 +1394,6 @@ static int addend_mips_rel(uint32_t *location, Elf_Rela *r)
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
 	uint32_t inst;
 
-	if (r_typ == R_MIPS_HI16)
-		return 1;	/* skip this */
 	inst = TO_NATIVE(*location);
 	switch (r_typ) {
 	case R_MIPS_LO16:
@@ -1405,6 +1405,8 @@ static int addend_mips_rel(uint32_t *location, Elf_Rela *r)
 	case R_MIPS_32:
 		r->r_addend = inst;
 		break;
+	default:
+		r->r_addend = (Elf_Addr)(-1);
 	}
 	return 0;
 }
@@ -1514,20 +1516,17 @@ static void section_rel(struct module *mod, struct elf_info *elf,
 		r.r_addend = 0;
 
 		loc = sym_get_data_by_offset(elf, fsecndx, r.r_offset);
-		tsym = elf->symtab_start + ELF_R_SYM(r.r_info);
+		tsym = elf->symtab_start + r_sym;
 
 		switch (elf->hdr->e_machine) {
 		case EM_386:
-			if (addend_386_rel(loc, &r))
-				continue;
+			addend_386_rel(loc, &r);
 			break;
 		case EM_ARM:
-			if (addend_arm_rel(loc, tsym, &r))
-				continue;
+			addend_arm_rel(loc, tsym, &r);
 			break;
 		case EM_MIPS:
-			if (addend_mips_rel(loc, &r))
-				continue;
+			addend_mips_rel(loc, &r);
 			break;
 		default:
 			fatal("Please add code to calculate addend for this architecture\n");
-- 
2.39.2

