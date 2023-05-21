Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC970AEC1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjEUQF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjEUQFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:05:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5206ECD;
        Sun, 21 May 2023 09:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7A6F60FA7;
        Sun, 21 May 2023 16:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86ECC433D2;
        Sun, 21 May 2023 16:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684685119;
        bh=WHBV7iLszGwzqmoBiBCGvksDMYSMzg3ZUVZdErHe9Yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jSg/z3aGOvkuyn5c5Urq2Q/TCkD0gnjBzHJ/S1qxaUK6+Fl/neoCMcMq5PMDX2t3U
         x9DBmCetn/NGYRUL1voVIqs4beFG+xlcjSGp79Lz+hdx+0uO+1mC+PYjv6jYLQkfnW
         EAOnq0H7IpKBFNsauz47zEInl1/v0r2Ng3o5w+2/USxCuOt9JCXpCWnYxMlDJlLAVn
         OudINlJvQf4Zpe7uXDiCMXBYD++Farbf5mi1SC7h7kBCmQJxecGbt4NuY4yAk1zoGN
         jHeFGEqZwxWAWyrbtkdvBXTvCiew1GQqsHcSYC2Buwx0HvDtVtXzUS0ZP9cE4Appn5
         jbpzCkZPaVyzA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 03/20] modpost: detect section mismatch for R_ARM_MOVW_ABS_NC and R_ARM_MOVT_ABS
Date:   Mon, 22 May 2023 01:04:08 +0900
Message-Id: <20230521160426.1881124-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230521160426.1881124-1-masahiroy@kernel.org>
References: <20230521160426.1881124-1-masahiroy@kernel.org>
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

ARM defconfig misses to detect some section mismatches.

  [test code]

    #include <linux/init.h>

    int __initdata foo;
    int get_foo(int x) { return foo; }

It is apparently a bad reference, but modpost does not report anything
for ARM defconfig (i.e. multi_v7_defconfig).

The test code above produces the following relocations.

  Relocation section '.rel.text' at offset 0x200 contains 2 entries:
   Offset     Info    Type            Sym.Value  Sym. Name
  00000000  0000062b R_ARM_MOVW_ABS_NC 00000000   .LANCHOR0
  00000004  0000062c R_ARM_MOVT_ABS    00000000   .LANCHOR0

  Relocation section '.rel.ARM.exidx' at offset 0x210 contains 2 entries:
   Offset     Info    Type            Sym.Value  Sym. Name
  00000000  0000022a R_ARM_PREL31      00000000   .text
  00000000  00001000 R_ARM_NONE        00000000   __aeabi_unwind_cpp_pr0

Currently, R_ARM_MOVW_ABS_NC and R_ARM_MOVT_ABS are just skipped.

Add code to handle them. I checked arch/arm/kernel/module.c to learn
how the offset is encoded in the instruction.

The referenced symbol in relocation might be a local anchor.
If is_valid_name() returns false, let's search for a better symbol name.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 34fbbd85bfde..ed2301e951a9 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1108,7 +1108,7 @@ static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
 /**
  * Find symbol based on relocation record info.
  * In some cases the symbol supplied is a valid symbol so
- * return refsym. If st_name != 0 we assume this is a valid symbol.
+ * return refsym. If is_valid_name() == true, we assume this is a valid symbol.
  * In other cases the symbol needs to be looked up in the symbol table
  * based on section and address.
  *  **/
@@ -1121,7 +1121,7 @@ static Elf_Sym *find_tosym(struct elf_info *elf, Elf64_Sword addr,
 	Elf64_Sword d;
 	unsigned int relsym_secindex;
 
-	if (relsym->st_name != 0)
+	if (is_valid_name(elf, relsym))
 		return relsym;
 
 	/*
@@ -1312,11 +1312,19 @@ static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
 	Elf_Sym *sym = elf->symtab_start + ELF_R_SYM(r->r_info);
 	unsigned int inst = TO_NATIVE(*reloc_location(elf, sechdr, r));
+	int offset;
 
 	switch (r_typ) {
 	case R_ARM_ABS32:
 		r->r_addend = inst + sym->st_value;
 		break;
+	case R_ARM_MOVW_ABS_NC:
+	case R_ARM_MOVT_ABS:
+		offset = ((inst & 0xf0000) >> 4) | (inst & 0xfff);
+		offset = (offset ^ 0x8000) - 0x8000;
+		offset += sym->st_value;
+		r->r_addend = offset;
+		break;
 	case R_ARM_PC24:
 	case R_ARM_CALL:
 	case R_ARM_JUMP24:
-- 
2.39.2

