Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DDD70AEBE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjEUQF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjEUQFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:05:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E3CD;
        Sun, 21 May 2023 09:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E88F960F36;
        Sun, 21 May 2023 16:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A2BC4339E;
        Sun, 21 May 2023 16:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684685117;
        bh=fNR4CDXASXYl6s1DvjTHLO1BvaWuFWmKCQClVKnCc7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h9MbM1JfV/RDfTfTvRsMuDs9iyR1i4Yb5uoJ/nLE4syQQxu7iQkF89kxdZiYsxWTD
         ZTD8cLNzJFauyIFbbMVl6tlYJpeU5kl7o+GStYWQU/u94eqU4c4bQAk2M1YrBy7jiY
         JLMZbn/012F3GlLcshbLfhRgjMSyvGJSIRjkIBH/tWKm+3nv469IVUcZ7iEdUoaLzv
         CW0Rpe7UC2E6KcTkujjKuy6x7tc5/OJfi+mW37CbhZKOZTeCZCsKo7KS0TntbvUI/y
         e+p0GFNB5Sofu6R+77TzNg080f2tjm3Zk2oxf8Ljr51NoZ6y8U8C/WaCcy8CRwtA5y
         Y/GwpNMgFlU4w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 02/20] modpost: fix section mismatch message for R_ARM_ABS32
Date:   Mon, 22 May 2023 01:04:07 +0900
Message-Id: <20230521160426.1881124-3-masahiroy@kernel.org>
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

addend_arm_rel() processes R_ARM_ABS32 in a wrong way.

Here, simple test code.

  [test code 1]

    #include <linux/init.h>

    int __initdata foo;
    int get_foo(int x) { return foo; }

If you compile it with ARM versatile_defconfig, modpost will show the
symbol name, (unknown).

  WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (section: .text) -> (unknown) (section: .init.data)

If you compile it for other architectures, modpost will show the correct
symbol name.

  WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (section: .text) -> foo (section: .init.data)

For R_ARM_ABS32, addend_arm_rel() sets r->r_addend to a wrong value.

I just mimicked the code in arch/arm/kernel/module.c.

However, there is more difficulty for ARM.

Here, test code.

  [test code 2]

    #include <linux/init.h>

    int __initdata foo;
    int get_foo(int x) { return foo; }

    int __initdata bar;
    int get_bar(int x) { return bar; }

With this commit applied, modpost will show the following messages
for ARM versatile_defconfig:

  WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (section: .text) -> foo (section: .init.data)
  WARNING: modpost: vmlinux.o: section mismatch in reference: get_bar (section: .text) -> foo (section: .init.data)

The reference from 'get_bar' to 'foo' seems wrong.

I have no solution for this because it is true in assembly level.

In the following output, relocation at 0x1c is no longer associated
with 'bar'. The two relocation entries point to the same symbol, and
the offset to 'bar' is encoded in the instruction 'r0, [r3, #4]'.

  Disassembly of section .text:

  00000000 <get_foo>:
     0: e59f3004          ldr     r3, [pc, #4]   @ c <get_foo+0xc>
     4: e5930000          ldr     r0, [r3]
     8: e12fff1e          bx      lr
     c: 00000000          .word   0x00000000

  00000010 <get_bar>:
    10: e59f3004          ldr     r3, [pc, #4]   @ 1c <get_bar+0xc>
    14: e5930004          ldr     r0, [r3, #4]
    18: e12fff1e          bx      lr
    1c: 00000000          .word   0x00000000

  Relocation section '.rel.text' at offset 0x244 contains 2 entries:
   Offset     Info    Type            Sym.Value  Sym. Name
  0000000c  00000c02 R_ARM_ABS32       00000000   .init.data
  0000001c  00000c02 R_ARM_ABS32       00000000   .init.data

When find_elf_symbol() gets into a situation where relsym->st_name is
zero, there is no guarantee to get the symbol name as written in C.

I am keeping the current logic because it is useful in many architectures,
but the symbol name is not always correct depending on the optimization
of the relocation. I left some comments in find_tosym().

Fixes: 56a974fa2d59 ("kbuild: make better section mismatch reports on arm")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v6:
 - More detailed commit log

 scripts/mod/modpost.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 71de14544432..34fbbd85bfde 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1124,6 +1124,10 @@ static Elf_Sym *find_tosym(struct elf_info *elf, Elf64_Sword addr,
 	if (relsym->st_name != 0)
 		return relsym;
 
+	/*
+	 * Strive to find a better symbol name, but the resulting name does not
+	 * always match the symbol referenced in the original code.
+	 */
 	relsym_secindex = get_secindex(elf, relsym);
 	for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
 		if (get_secindex(elf, sym) != relsym_secindex)
@@ -1306,12 +1310,12 @@ static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 {
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
+	Elf_Sym *sym = elf->symtab_start + ELF_R_SYM(r->r_info);
+	unsigned int inst = TO_NATIVE(*reloc_location(elf, sechdr, r));
 
 	switch (r_typ) {
 	case R_ARM_ABS32:
-		/* From ARM ABI: (S + A) | T */
-		r->r_addend = (int)(long)
-			      (elf->symtab_start + ELF_R_SYM(r->r_info));
+		r->r_addend = inst + sym->st_value;
 		break;
 	case R_ARM_PC24:
 	case R_ARM_CALL:
-- 
2.39.2

