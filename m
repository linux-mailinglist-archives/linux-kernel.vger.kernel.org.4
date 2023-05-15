Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F297020E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 02:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237950AbjEOAye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 20:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjEOAyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 20:54:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0FA10DF;
        Sun, 14 May 2023 17:54:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAE19618A8;
        Mon, 15 May 2023 00:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE70C433D2;
        Mon, 15 May 2023 00:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684112070;
        bh=dK+m8ExSLg1/Xdbg8Lkb6eK8yh4H4j645K0PpXqtwRk=;
        h=From:To:Cc:Subject:Date:From;
        b=hf+Ww+p1WClDZHI/4UF0izLlInAGTiBLQg6t55k4T8s2QZU/eoHVGA59yJeUXjCyC
         +VU33v2wcqQP4xAsit+Cp7iqbYNhiz8BIR+BFyVRTAhhTlvGJ9z1yzTi0eg3Cgv0Fy
         uSjaOLP1RArGWfy7jBmkh2N6wD9zO1Fl5FhCH9e68fopxHysNjp3UEQ0uF15saOBk9
         50wsr5/SmYp9dyIgH0UDRrfvvPWcuHMX9tkVzGZK6eA4FgmxzeA20RvkYX16uGifY/
         MK2lpygFxAgoQoSGswijS26kqwXYrrV6rQqEyAaswRRrVGtXQWHqZ0a7eOm3pPuMAb
         yIOfI5JPL0RDg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] modpost: fix section mismatch message for R_ARM_ABS32
Date:   Mon, 15 May 2023 09:54:19 +0900
Message-Id: <20230515005419.1293357-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
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

The section mismatch check does not show proper warning messages for ARM.

Here, very simple test code.

    #include <linux/init.h>

    static int __initdata foo;

    void set_foo(int x)
    {
            foo = x;
    }

    int get_foo(int x)
    {
            return foo;
    }

If I compile it for ARM, modpost does not show the symbol name.

  WARNING: modpost: vmlinux.o: section mismatch in reference: set_foo (section: .text) -> (unknown) (section: .init.data)
  WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (section: .text) -> (unknown) (section: .init.data)

If I compile it for other architectures, modpost shows the correct symbol name.

  WARNING: modpost: vmlinux.o: section mismatch in reference: set_foo (section: .text) -> foo (section: .init.data)
  WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (section: .text) -> foo (section: .init.data)

For R_ARM_ABS32, addend_arm_rel() sets r->r_addend to a wrong value.

arch/arm/kernel/module.c handles R_ARM_ABS32 as follows:

        case R_ARM_ABS32:
        case R_ARM_TARGET1:
                *(u32 *)loc += sym->st_value;

I just mimicked it in modpost.

Fixes: 56a974fa2d59 ("kbuild: make better section mismatch reports on arm")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d4531d09984d..c93780d93caf 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1460,12 +1460,13 @@ static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 {
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
+	unsigned int *location = reloc_location(elf, sechdr, r);
+	Elf_Sym *sym;
 
 	switch (r_typ) {
 	case R_ARM_ABS32:
-		/* From ARM ABI: (S + A) | T */
-		r->r_addend = (int)(long)
-			      (elf->symtab_start + ELF_R_SYM(r->r_info));
+		sym = elf->symtab_start + ELF_R_SYM(r->r_info);
+		r->r_addend = TO_NATIVE(*location) + sym->st_value;
 		break;
 	case R_ARM_PC24:
 	case R_ARM_CALL:
-- 
2.39.2

