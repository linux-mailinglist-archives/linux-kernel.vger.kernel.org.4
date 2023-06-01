Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307D6719B98
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjFAMLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjFAMKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:10:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8DEE50;
        Thu,  1 Jun 2023 05:10:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 282C2641A9;
        Thu,  1 Jun 2023 12:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1781C433A0;
        Thu,  1 Jun 2023 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685621436;
        bh=eMacqv00K8bJeMNK92sV1H4jFGoCI1e91wlVYvSCA6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbJwf4gmpXiXBcoZnqcOtwMctCfgu2govvYcmytWmux8JMSq+1RHR2N8rpx5KZ6UF
         61/5EPxVCs0pxoO+Cl7pnYYQdM5MLEND+6FtFQW07RgnQDL0wPPTjpytv2U9+o3u8w
         K4m/fy0y5W+ZffGmTazVcbnRCHk9hfC5uNOrOXXL/rGv+WrlFRPr8bYFK2Egu7vrnv
         rNqA92cuyyZ30DO+n2qxlQyMyzhdXr0tjpdf4DSQRxxMiU0SZnqzhYibEkuE+Lg+I1
         rTiYQDHSJiFa+EobEK9N1ZeM2SvTguMeOX45UOjKaIc11CEEFiA9L7TA7Bp8rBJed+
         Inyd6OuukOmzw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 7/7] modpost: detect section mismatch for R_ARM_REL32
Date:   Thu,  1 Jun 2023 21:10:01 +0900
Message-Id: <20230601121001.1071533-8-masahiroy@kernel.org>
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

For ARM, modpost fails to detect some types of section mismatches.

  [test code]

    .section .init.data,"aw"
    bar:
            .long 0

    .section .data,"aw"
    .globl foo
    foo:
            .long bar - .

It is apparently a bad reference, but modpost does not report anything.

The test code above produces the following relocations.

  Relocation section '.rel.data' at offset 0xe8 contains 1 entry:
   Offset     Info    Type            Sym.Value  Sym. Name
  00000000  00000403 R_ARM_REL32       00000000   .init.data

Currently, R_ARM_REL32 is just skipped.

Handle it like R_ARM_ABS32.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 55d142bb000b..9f0c87064ca5 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1281,6 +1281,7 @@ static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 
 	switch (r_typ) {
 	case R_ARM_ABS32:
+	case R_ARM_REL32:
 		inst = TO_NATIVE(*(uint32_t *)loc);
 		r->r_addend = inst + sym->st_value;
 		break;
-- 
2.39.2

