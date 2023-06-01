Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB2D719B9C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjFAMKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjFAMK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:10:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD32FC;
        Thu,  1 Jun 2023 05:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6B4463AD1;
        Thu,  1 Jun 2023 12:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6299FC433A0;
        Thu,  1 Jun 2023 12:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685621427;
        bh=l8pAEKo80YCNxNTbkTmM13VW7qxFsKV/QhE7nwuJWrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KrhuaH7LZ/RQ/+MSwWzLiNquVNkd0wGhx/fRtIGdvLCiXXpQqO2FqmGhcSWZXYD1C
         FIGbKvip4KGcAUy48afS7bWi3lsEKbIf1OedIGJKxtK441R00ObOih5QJnDOpWiFnf
         LaZzKgcngiLE0AKqyN7xALGJWRlEQ790MDueiPj6itTFSTpBnOE8Lx5nnKSqh/2lpb
         Nnq5CrlxdbfQoXLODJdV6mQOhNlUsZTwrmSCwrTh9vQIMrnS7lVAbhR76z+dopkW7j
         IVT7pjpIOUaS8kPmMYR9GplggmIeUn9NeMJiKDIxuyuzAWT9zdprm09VicLdOO8lkv
         6T+yeXs8xDLbw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 3/7] modpost: detect section mismatch for R_ARM_{MOVW_ABS_NC,MOVT_ABS}
Date:   Thu,  1 Jun 2023 21:09:57 +0900
Message-Id: <20230601121001.1071533-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601121001.1071533-1-masahiroy@kernel.org>
References: <20230601121001.1071533-1-masahiroy@kernel.org>
MIME-Version: 1.0
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

For ARM defconfig (i.e. multi_v7_defconfig), modpost fails to detect
some types of section mismatches.

  [test code]

    #include <linux/init.h>

    int __initdata foo;
    int get_foo(void) { return foo; }

It is apparently a bad reference, but modpost does not report anything.

The test code above produces the following relocations.

  Relocation section '.rel.text' at offset 0x200 contains 2 entries:
   Offset     Info    Type            Sym.Value  Sym. Name
  00000000  0000062b R_ARM_MOVW_ABS_NC 00000000   .LANCHOR0
  00000004  0000062c R_ARM_MOVT_ABS    00000000   .LANCHOR0

Currently, R_ARM_MOVW_ABS_NC and R_ARM_MOVT_ABS are just skipped.

Add code to handle them. I checked arch/arm/kernel/module.c to learn
how the offset is encoded in the instruction.

The referenced symbol in relocation might be a local anchor.
If is_valid_name() returns false, let's search for a better symbol name.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index e47bba7cfad2..5a5e802b160c 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1078,7 +1078,7 @@ static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
 /**
  * Find symbol based on relocation record info.
  * In some cases the symbol supplied is a valid symbol so
- * return refsym. If st_name != 0 we assume this is a valid symbol.
+ * return refsym. If is_valid_name() == true, we assume this is a valid symbol.
  * In other cases the symbol needs to be looked up in the symbol table
  * based on section and address.
  *  **/
@@ -1091,7 +1091,7 @@ static Elf_Sym *find_tosym(struct elf_info *elf, Elf64_Sword addr,
 	Elf64_Sword d;
 	unsigned int relsym_secindex;
 
-	if (relsym->st_name != 0)
+	if (is_valid_name(elf, relsym))
 		return relsym;
 
 	/*
@@ -1297,6 +1297,13 @@ static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 		inst = TO_NATIVE(*(uint32_t *)loc);
 		r->r_addend = inst + sym->st_value;
 		break;
+	case R_ARM_MOVW_ABS_NC:
+	case R_ARM_MOVT_ABS:
+		inst = TO_NATIVE(*(uint32_t *)loc);
+		offset = sign_extend32(((inst & 0xf0000) >> 4) | (inst & 0xfff),
+				       15);
+		r->r_addend = offset + sym->st_value;
+		break;
 	case R_ARM_PC24:
 	case R_ARM_CALL:
 	case R_ARM_JUMP24:
-- 
2.39.2

