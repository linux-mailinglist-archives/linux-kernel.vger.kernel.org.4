Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861BD639882
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 23:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKZW4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 17:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKZW4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 17:56:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1733A14033;
        Sat, 26 Nov 2022 14:56:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49BE860C68;
        Sat, 26 Nov 2022 22:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F234C433D6;
        Sat, 26 Nov 2022 22:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669503393;
        bh=m3ZEUK0zXePJycyJFWyVV/OydFcxPrFRvDSAjxSAbFg=;
        h=From:To:Cc:Subject:Date:From;
        b=PO2FYMebNnz4Pbfnw8L4jSaDjHMCbBhjOKGHHL0XHqdTEbi9z/rQObYtc5Y1R8A90
         BfP+J0A5NJQO/9ZpskWhGvFqo5+N4UbA0/KELhr4nfVkR0ZcrD5JbPC1XmRdq5UvCz
         pFFTHtOLfHL63Xa2FRll9c/1SMNrWbyeqdSa70SK2xcfK3idyIdASCNjALTZ63eR3K
         ohcsiMfWB1/6ELvIZtYDEiD5am3qskj/aG4I3aGJiffQ6/AUoPbLkPFBggduWJ0HJm
         nCMros1t7GTgCwsh69Z3buA7Ohtivt+nh04MO1b+ORFjDV8YmaxH8p9/yBPTU9m54E
         8g2ZlTEp/i1OA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, x86@kernel.org
Subject: [PATCH v3 1/5] kbuild: add test-{le,ge,lt,gt} macros
Date:   Sun, 27 Nov 2022 07:56:20 +0900
Message-Id: <20221126225624.751661-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Because GNU Make is handle strings, it is very hard to perform math in
Makefiles.

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
minimal supported version of LLVM is 11.0.0 (or CONFIG_LLD_VERSION=0
if the linker is not LLD, this case also works.)

So, the shell invocation can be replaced with more efficient code:

  ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)

Of course, this assumption will break when LLVM 100 is released, but it
will be far in the future.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

Changes in v3:
  - Ensure the given parameters are not empty

 Makefile               |  2 +-
 arch/riscv/Makefile    |  2 +-
 arch/x86/Makefile      |  2 +-
 scripts/Kbuild.include | 10 ++++++++++
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 6f846b1f2618..eb80332f7b51 100644
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
index cbe28744637b..4b8cf464b53b 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -11,6 +11,16 @@ space   := $(empty) $(empty)
 space_escape := _-_SPACE_-_
 pound := \#
 
+###
+# Comparison macros.
+# Usage: $(call test-le, A, B)
+# works like shell's "test A -le B", use with care bacause it is ASCII sort.
+# If A and B have the same number of digits, it works as expected.
+test-le = $(and $(strip $1),$(strip $2),$(filter $1, $(firstword $(sort $1 $2))),y)
+test-ge = $(call test-le, $2, $1)
+test-lt = $(and $(strip $1),$(strip $2),$(filter-out $2, $(firstword $(sort $1 $2))),y)
+test-gt = $(call test-lt, $2, $1)
+
 ###
 # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
 dot-target = $(dir $@).$(notdir $@)
-- 
2.34.1

