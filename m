Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72A8719B88
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjFAMKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjFAMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6F3D7;
        Thu,  1 Jun 2023 05:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BFA6637B9;
        Thu,  1 Jun 2023 12:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFB2C433EF;
        Thu,  1 Jun 2023 12:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685621425;
        bh=PEcdZVhDuhBQ+xzAg//irJiyn8poLhX+cHlMc0n1u9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AceQvPqRM3KtwlgBB5UkRQbl23xq46V7w8u3OwmU6aIrg9u2A62nZGZqxv9Gxn3/j
         sUDJgsIcdKhl0IHak3JXYxLL0pi2bIvIBu6f+2wk3Z/GvE3ZCraPlnKp9pDbblONYI
         /ZTpP312891+mBwMGF3SvOAp19x9RJkGSHP+umt4j2eP4iaqTbQv9VIX90mY9w4MPv
         DRiPoIRK+RenTigsgxon9ZuF38xV/MyW5xwBCpmggPwQZMdzX7VnM9Og0A2neWmHwu
         W7XOmmrJoabLtV2kTGz2QCfsDBvatNbG8XVKoPxoyOI3yc+ryRtL/Y6RLa60LoWn2g
         MW62ColJsDfWQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/7] modpost: fix section mismatch message for R_ARM_{PC24,CALL,JUMP24}
Date:   Thu,  1 Jun 2023 21:09:56 +0900
Message-Id: <20230601121001.1071533-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601121001.1071533-1-masahiroy@kernel.org>
References: <20230601121001.1071533-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

addend_arm_rel() processes R_ARM_PC24, R_ARM_CALL, R_ARM_JUMP24 in a
wrong way.

Here, test code.

[test code for R_ARM_JUMP24]

  .section .init.text,"ax"
  bar:
          bx      lr

  .section .text,"ax"
  .globl foo
  foo:
          b       bar

[test code for R_ARM_CALL]

  .section .init.text,"ax"
  bar:
          bx      lr

  .section .text,"ax"
  .globl foo
  foo:
          push    {lr}
          bl      bar
          pop     {pc}

If you compile it with ARM multi_v7_defconfig, modpost will show the
symbol name, (unknown).

  WARNING: modpost: vmlinux.o: section mismatch in reference: foo (section: .text) -> (unknown) (section: .init.text)

(You need to use GNU linker instead of LLD to reproduce it.)

Fix the code to make modpost show the correct symbol name.

I imported (with adjustment) sign_extend32() from include/linux/bitops.h.

The '+8' is the compensation for pc-relative instruction. It is
documented in "ELF for the Arm Architecture" [1].

  "If the relocation is pc-relative then compensation for the PC bias
  (the PC value is 8 bytes ahead of the executing instruction in Arm
  state and 4 bytes in Thumb state) must be encoded in the relocation
  by the object producer."

[1]: https://github.com/ARM-software/abi-aa/blob/main/aaelf32/aaelf32.rst

Fixes: 56a974fa2d59 ("kbuild: make better section mismatch reports on arm")
Fixes: 6e2e340b59d2 ("ARM: 7324/1: modpost: Fix section warnings for ARM for many compilers")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c68dad45ace2..e47bba7cfad2 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1277,12 +1277,20 @@ static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 #define	R_ARM_THM_JUMP19	51
 #endif
 
+static int32_t sign_extend32(int32_t value, int index)
+{
+	uint8_t shift = 31 - index;
+
+	return (int32_t)(value << shift) >> shift;
+}
+
 static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 {
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
 	Elf_Sym *sym = elf->symtab_start + ELF_R_SYM(r->r_info);
 	void *loc = reloc_location(elf, sechdr, r);
 	uint32_t inst;
+	int32_t offset;
 
 	switch (r_typ) {
 	case R_ARM_ABS32:
@@ -1292,6 +1300,10 @@ static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 	case R_ARM_PC24:
 	case R_ARM_CALL:
 	case R_ARM_JUMP24:
+		inst = TO_NATIVE(*(uint32_t *)loc);
+		offset = sign_extend32((inst & 0x00ffffff) << 2, 25);
+		r->r_addend = offset + sym->st_value + 8;
+		break;
 	case R_ARM_THM_CALL:
 	case R_ARM_THM_JUMP24:
 	case R_ARM_THM_JUMP19:
-- 
2.39.2

