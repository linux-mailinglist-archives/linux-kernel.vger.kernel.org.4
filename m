Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B0762FE58
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiKRTxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiKRTxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:53:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B61B7E93;
        Fri, 18 Nov 2022 11:53:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D59B46269B;
        Fri, 18 Nov 2022 19:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62005C433B5;
        Fri, 18 Nov 2022 19:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668801195;
        bh=wUrXcoJycZccOLz2aaej5UsJmc9Iwi2+dKKmMfDV/h0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RGlUo4bz3GmYt03qSb/ffXbUyEfN55vN6z4W8851GmJwNQyrsLId8hwfNopcQXRVz
         SvtPfgdADwvMZBSWXT+GhRpZZq0Hl6AURqOZoR7KMX3JdLkd416INftQaVRJQ2wtR+
         o94oSPE5mQIyHFPaVn9hmrLsO3zWuiqGF3Tf9d4rXOU+cFNOG5qbr70pSMefCDRYhZ
         HEOaaWDXeKf28Pd5SHpB5PMds+ZGRrCkYJlxrshyCLCqVkDALBivieo8KNndzmV+eZ
         39ZVJGGKEwPJXOw2lQBMlMG3NrbeIsyxxd/vcf/DyjSeLh2rFb7NOFIl5K+n04FIV8
         XMMA13BKlVNjg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/6] kbuild: add test-{le,ge,lt,gt} macros
Date:   Sat, 19 Nov 2022 04:53:02 +0900
Message-Id: <20221118195307.86049-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221118195307.86049-1-masahiroy@kernel.org>
References: <20221118195307.86049-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because GNU Make is only able to handle strings, it is very hard to
perform arighmetic in Makefiles.

When we compare two integers, we invokes shell. One example is in the
top Makefile:

  ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 130000; echo $$?),0)

This is more expensive than using built-in functions since it forks a
process.

If we know the two have the same number of digits, we can do better.

This commit adds four macros, test-le, test-ge, test-lt, test-gt.

$(call test-lt, A, B) is evaluated to 'y' if A is less than B, or
empty otherwise. This will replace $(call shell test A -lt B).

Again, the limitation is that A and B must have the same number of
digits because these macros are based on $(sort ) function.

  $(call test-lt, 1, 9)    -->  y        (Works!)
  $(call test-lt, 10, 9)   -->  y        (Not work...)

To make the latter work, you need to add '0' prefix to align the number
of digits:

  $(call test-lt, 10, 09)  -->  empty    (Works!)

Actually, we can live with this limitation in many places. As for the
example above, we know $(CONFIG_LLD_VERSION) is 6-digits because the
minimal supported version of LLVM is 11.0.0.

So, the shell invocation can be replaced with more efficient code:

  ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)

Of course, this assumption will break when LLVM 100 is released, but it
will be far in the future.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile               |  2 +-
 arch/riscv/Makefile    |  2 +-
 arch/x86/Makefile      |  2 +-
 scripts/Kbuild.include | 10 ++++++++++
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 58cd4f5e1c3a..303516c035f6 100644
--- a/Makefile
+++ b/Makefile
@@ -986,7 +986,7 @@ KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
 # Check for frame size exceeding threshold during prolog/epilog insertion
 # when using lld < 13.0.0.
 ifneq ($(CONFIG_FRAME_WARN),0)
-ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 130000; echo $$?),0)
+ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
 KBUILD_LDFLAGS	+= -plugin-opt=-warn-stack-size=$(CONFIG_FRAME_WARN)
 endif
 endif
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 0d13b597cb55..faf2c2177094 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -37,7 +37,7 @@ else
 endif
 
 ifeq ($(CONFIG_LD_IS_LLD),y)
-ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 150000; echo $$?),0)
+ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 150000),y)
 	KBUILD_CFLAGS += -mno-relax
 	KBUILD_AFLAGS += -mno-relax
 ifndef CONFIG_AS_IS_LLVM
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 415a5d138de4..e72c7a49cd59 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -211,7 +211,7 @@ endif
 KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
 
 ifdef CONFIG_LTO_CLANG
-ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 130000; echo $$?),0)
+ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
 KBUILD_LDFLAGS	+= -plugin-opt=-stack-alignment=$(if $(CONFIG_X86_32),4,8)
 endif
 endif
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index cbe28744637b..9996f34327cb 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -11,6 +11,16 @@ space   := $(empty) $(empty)
 space_escape := _-_SPACE_-_
 pound := \#
 
+###
+# Comparison macros.
+# Usage: $(call test-le, A, B)
+# works like shell's "test A -le B", but A and B must have the same number of
+# digits since it is just ASCII sort.
+test-le = $(if $(filter $1, $(firstword $(sort $1 $2))),y)
+test-ge = $(call test-le, $2, $1)
+test-lt = $(if $(filter-out $2, $(firstword $(sort $1 $2))),y)
+test-gt = $(call test-lt, $2, $1)
+
 ###
 # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
 dot-target = $(dir $@).$(notdir $@)
-- 
2.34.1

