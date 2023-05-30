Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8EE716BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjE3SDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjE3SD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:03:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E71E5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:03:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A793E62C1E
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB31C4339B;
        Tue, 30 May 2023 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685469803;
        bh=rRFiekp/e4p9IosGOeiClcA0ZQRFHAsurfVAIwKYtNA=;
        h=From:To:Cc:Subject:Date:From;
        b=kfKhO+115F+K6AN+J8c3KwpDdC0A/fljxKFJOwFNZTrsM0wqJ47qSC4SmyDG/ywQa
         rpWpiB6ciiDy+op+OmmhgwSRoI3V7MI0SkNvepDwfBp02IZq1cX02k1ZXMOVDTtsg4
         abXf+RQ9Hl4Enio2jc8gYZ85+o1svPLjfQ3Exim4U7LMa+rj/fl61MfnwhFhXhZrGv
         jHw/nlB7deHg/gajRIxZidsczL0WIRfX0lnwPgKL8RR2ZIZTpEeVnxr+/1GRq2lNza
         oASt27IP2SarlOpnEDJt5txd4KdxEMyg0xE8jYiyCHqhpElaemCQkpW/B5ESBXJGSr
         A+haUxRPOhcfw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH] ARM: module: use sign_extend32() to extend the signedness
Date:   Wed, 31 May 2023 03:03:08 +0900
Message-Id: <20230530180308.112297-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
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

The function name clarifies the intention.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v6.4-rc1

 arch/arm/kernel/module.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index d59c36dc0494..e74d84f58b77 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -169,8 +169,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 
 			offset = __mem_to_opcode_arm(*(u32 *)loc);
 			offset = (offset & 0x00ffffff) << 2;
-			if (offset & 0x02000000)
-				offset -= 0x04000000;
+			offset = sign_extend32(offset, 25);
 
 			offset += sym->st_value - loc;
 
@@ -236,7 +235,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 		case R_ARM_MOVT_PREL:
 			offset = tmp = __mem_to_opcode_arm(*(u32 *)loc);
 			offset = ((offset & 0xf0000) >> 4) | (offset & 0xfff);
-			offset = (offset ^ 0x8000) - 0x8000;
+			offset = sign_extend32(offset, 15);
 
 			offset += sym->st_value;
 			if (ELF32_R_TYPE(rel->r_info) == R_ARM_MOVT_PREL ||
@@ -344,8 +343,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 				((~(j2 ^ sign) & 1) << 22) |
 				((upper & 0x03ff) << 12) |
 				((lower & 0x07ff) << 1);
-			if (offset & 0x01000000)
-				offset -= 0x02000000;
+			offset = sign_extend32(offset, 24);
 			offset += sym->st_value - loc;
 
 			/*
@@ -401,7 +399,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			offset = ((upper & 0x000f) << 12) |
 				((upper & 0x0400) << 1) |
 				((lower & 0x7000) >> 4) | (lower & 0x00ff);
-			offset = (offset ^ 0x8000) - 0x8000;
+			offset = sign_extend32(offset, 15);
 			offset += sym->st_value;
 
 			if (ELF32_R_TYPE(rel->r_info) == R_ARM_THM_MOVT_PREL ||
-- 
2.39.2

