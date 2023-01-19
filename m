Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03599674BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjATFFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjATFEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:04:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA5B74393;
        Thu, 19 Jan 2023 20:51:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FA5CB8213D;
        Thu, 19 Jan 2023 08:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE05C433D2;
        Thu, 19 Jan 2023 08:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674116623;
        bh=HzjZyRkTwXHwL2rK9JRNqbNaOgZ7IJvMj6nMH/wRd4I=;
        h=From:To:Cc:Subject:Date:From;
        b=YYHGrvIihfKlmvQK4nJKMlTHh8+ze3mmYwxNiccF3TQKCoe9CffJgJ9zMg0+4EXl4
         haBP3p4Uh2Cm127o7gcUOByTsWxlQ2vr4q00ABuXs/8se2jH3Uo+fIuUz3ZJkNmKl8
         AK8RM5KxLLjktImiuejI/4WuOecsmsqCEN/JkwesKBu6nb1h6BC7R/uTgzAlqK+Dab
         UBx93EeuXVeNeF0fBUIpu3SoHGg0qqyXk2nBRtjf+oGdGD5T3dmhSkbyQ1Lg7qd/2Q
         BODfsueIhrLiXEXZuMIQImPiJiNrjfIHsU6I8Ki+EX0+wsg6otYM4jLRyb3vjSAkbS
         6fXkR0y1vmM9A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] powerpc: remove checks for binutils older than 2.25
Date:   Thu, 19 Jan 2023 17:22:50 +0900
Message-Id: <20230119082250.151485-1-masahiroy@kernel.org>
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

Commit e4412739472b ("Documentation: raise minimum supported version of
binutils to 2.25") allows us to remove the checks for old binutils.

There is no more user for ld-ifversion. Remove it as well.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/Makefile     | 22 +---------------------
 arch/powerpc/lib/Makefile |  2 +-
 scripts/Makefile.compiler |  4 ----
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index dc4cbf0a5ca9..3d265b16c0ae 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -42,18 +42,13 @@ machine-$(CONFIG_PPC64) += 64
 machine-$(CONFIG_CPU_LITTLE_ENDIAN) += le
 UTS_MACHINE := $(subst $(space),,$(machine-y))
 
-# XXX This needs to be before we override LD below
-ifdef CONFIG_PPC32
-KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
-else
-ifeq ($(call ld-ifversion, -ge, 22500, y),y)
+ifeq ($(CONFIG_PPC64)$(CONFIG_LD_IS_BFD),yy)
 # Have the linker provide sfpr if possible.
 # There is a corresponding test in arch/powerpc/lib/Makefile
 KBUILD_LDFLAGS_MODULE += --save-restore-funcs
 else
 KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
 endif
-endif
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 KBUILD_CFLAGS	+= -mlittle-endian
@@ -389,8 +384,6 @@ vdso_prepare: prepare0
 		$(build)=arch/powerpc/kernel/vdso include/generated/vdso64-offsets.h)
 endif
 
-archprepare: checkbin
-
 archheaders:
 	$(Q)$(MAKE) $(build)=arch/powerpc/kernel/syscalls all
 
@@ -405,16 +398,3 @@ else
 	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TASK_CANARY") print $$3;}' include/generated/asm-offsets.h))
 endif
 endif
-
-PHONY += checkbin
-# Check toolchain versions:
-# - gcc-4.6 is the minimum kernel-wide version so nothing required.
-checkbin:
-	@if test "x${CONFIG_LD_IS_LLD}" != "xy" -a \
-		"x$(call ld-ifversion, -le, 22400, y)" = "xy" ; then \
-		echo -n '*** binutils 2.24 miscompiles weak symbols ' ; \
-		echo 'in some circumstances.' ; \
-		echo    '*** binutils 2.23 do not define the TOC symbol ' ; \
-		echo -n '*** Please use a different binutils version.' ; \
-		false ; \
-	fi
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 4de71cbf6e8e..c53618c34b70 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -42,7 +42,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
 # 64-bit linker creates .sfpr on demand for final link (vmlinux),
 # so it is only needed for modules, and only for older linkers which
 # do not support --save-restore-funcs
-ifeq ($(call ld-ifversion, -lt, 22500, y),y)
+ifndef CONFIG_LD_IS_BFD
 extra-$(CONFIG_PPC64)	+= crtsavres.o
 endif
 
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 3d8adfd34af1..ad07a4efc253 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -72,7 +72,3 @@ clang-min-version = $(call test-ge, $(CONFIG_CLANG_VERSION), $1)
 # ld-option
 # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
 ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2),$(3))
-
-# ld-ifversion
-# Usage:  $(call ld-ifversion, -ge, 22252, y)
-ld-ifversion = $(shell [ $(CONFIG_LD_VERSION)0 $(1) $(2)0 ] && echo $(3) || echo $(4))
-- 
2.34.1

