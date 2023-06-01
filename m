Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D056D719B97
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjFAMLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjFAMKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE301B8;
        Thu,  1 Jun 2023 05:10:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 125AF643FB;
        Thu,  1 Jun 2023 12:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCA2C433A4;
        Thu,  1 Jun 2023 12:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685621434;
        bh=eRGe47kX3cGM5w4r8Dems50P7VdGPg3OOcR4aC02b70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8NKzkee9vISUaZPJodekn7NPcjTrI7T4bZTLzyDUPhJPCb/VPXyphc66ouv2Ccqv
         x9KwiLJsSMx0NJa1lQynQ7F5ckRdFc45kCK/rzI/I+uPAsZd5gLLgQ5LS61xSOJX5i
         2KMSa3pPcU8TjwFyxQul8yT4Bw/bFQHpSTxPXCCpo86tFbTi4d0blMBWVRAfimemUY
         nXNHvmbcUuktNWNcjr1nvh1Ny9lYyI+eC03OxqMdkMJeJQfP9JMtWNs4bOY19xXJ/t
         L8IiodTAQOPzflB4mGhCKNEKBhdvpgN4Cywsl0flQMC6sYvGrCtnKJmIWEVoOw2noA
         RVFF8L9HCvfVw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "David A. Long" <dave.long@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 6/7] modpost: fix section_mismatch message for R_ARM_THM_{CALL,JUMP24,JUMP19}
Date:   Thu,  1 Jun 2023 21:10:00 +0900
Message-Id: <20230601121001.1071533-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601121001.1071533-1-masahiroy@kernel.org>
References: <20230601121001.1071533-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

addend_arm_rel() processes R_ARM_THM_CALL, R_ARM_THM_JUMP24,
R_ARM_THM_JUMP19 in a wrong way.

Here, test code.

[test code for R_ARM_THM_JUMP24]

  .section .init.text,"ax"
  bar:
          bx      lr

  .section .text,"ax"
  .globl foo
  foo:
          b       bar

[test code for R_ARM_THM_CALL]

  .section .init.text,"ax"
  bar:
          bx      lr

  .section .text,"ax"
  .globl foo
  foo:
          push    {lr}
          bl      bar
          pop     {pc}

If you compile it with CONFIG_THUMB2_KERNEL=y, modpost will show the
symbol name, (unknown).

  WARNING: modpost: vmlinux.o: section mismatch in reference: foo (section: .text) -> (unknown) (section: .init.text)

(You need to use GNU linker instead of LLD to reproduce it.)

Fix the code to make modpost show the correct symbol name. I checked
arch/arm/kernel/module.c to learn the encoding of R_ARM_THM_CALL and
R_ARM_THM_JUMP24. The module does not support R_ARM_THM_JUMP19, but
I checked its encoding in ARM ARM.

The '+4' is the compensation for pc-relative instruction. It is
documented in "ELF for the Arm Architecture" [1].

  "If the relocation is pc-relative then compensation for the PC bias
  (the PC value is 8 bytes ahead of the executing instruction in Arm
  state and 4 bytes in Thumb state) must be encoded in the relocation
  by the object producer."

[1]: https://github.com/ARM-software/abi-aa/blob/main/aaelf32/aaelf32.rst

Fixes: c9698e5cd6ad ("ARM: 7964/1: Detect section mismatches in thumb relocations")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 53 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 528aa9175e84..55d142bb000b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1276,7 +1276,7 @@ static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
 	Elf_Sym *sym = elf->symtab_start + ELF_R_SYM(r->r_info);
 	void *loc = reloc_location(elf, sechdr, r);
-	uint32_t inst, upper, lower;
+	uint32_t inst, upper, lower, sign, j1, j2;
 	int32_t offset;
 
 	switch (r_typ) {
@@ -1309,13 +1309,54 @@ static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 				       15);
 		r->r_addend = offset + sym->st_value;
 		break;
+	case R_ARM_THM_JUMP19:
+		/*
+		 * Encoding T3:
+		 * S     = upper[10]
+		 * imm6  = upper[5:0]
+		 * J1    = lower[13]
+		 * J2    = lower[11]
+		 * imm11 = lower[10:0]
+		 * imm32 = SignExtend(S:J2:J1:imm6:imm11:'0')
+		 */
+		upper = TO_NATIVE(*(uint16_t *)loc);
+		lower = TO_NATIVE(*((uint16_t *)loc + 1));
+
+		sign = (upper >> 10) & 1;
+		j1 = (lower >> 13) & 1;
+		j2 = (lower >> 11) & 1;
+		offset = sign_extend32((sign << 20) | (j2 << 19) | (j1 << 18) |
+				       ((upper & 0x03f) << 12) |
+				       ((lower & 0x07ff) << 1),
+				       20);
+		r->r_addend = offset + sym->st_value + 4;
+		break;
 	case R_ARM_THM_CALL:
 	case R_ARM_THM_JUMP24:
-	case R_ARM_THM_JUMP19:
-		/* From ARM ABI: ((S + A) | T) - P */
-		r->r_addend = (int)(long)(elf->hdr +
-			      sechdr->sh_offset +
-			      (r->r_offset - sechdr->sh_addr));
+		/*
+		 * Encoding T4:
+		 * S     = upper[10]
+		 * imm10 = upper[9:0]
+		 * J1    = lower[13]
+		 * J2    = lower[11]
+		 * imm11 = lower[10:0]
+		 * I1    = NOT(J1 XOR S)
+		 * I2    = NOT(J2 XOR S)
+		 * imm32 = SignExtend(S:I1:I2:imm10:imm11:'0')
+		 */
+		upper = TO_NATIVE(*(uint16_t *)loc);
+		lower = TO_NATIVE(*((uint16_t *)loc + 1));
+
+		sign = (upper >> 10) & 1;
+		j1 = (lower >> 13) & 1;
+		j2 = (lower >> 11) & 1;
+		offset = sign_extend32((sign << 24) |
+				       ((~(j1 ^ sign) & 1) << 23) |
+				       ((~(j2 ^ sign) & 1) << 22) |
+				       ((upper & 0x03ff) << 12) |
+				       ((lower & 0x07ff) << 1),
+				       24);
+		r->r_addend = offset + sym->st_value + 4;
 		break;
 	default:
 		return 1;
-- 
2.39.2

