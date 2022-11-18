Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EB862FE5C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiKRTxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKRTxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:53:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADA5B855C;
        Fri, 18 Nov 2022 11:53:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBEAA62739;
        Fri, 18 Nov 2022 19:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40283C433B5;
        Fri, 18 Nov 2022 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668801198;
        bh=jkwieIU3zqT3Yga+W23Ydeot77NTQwoHFuXOZC5ErRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OmJDJst66s2v8a78YN50j8I5Rvjz5x7Ho/PMNoazQk7DzEsi41V9cX1SW75iuf82y
         XX4EqgRBE2nQpjjOCaNuXsaxuu+dSKz8b88mlWbLTO+FqmTYhN9z1FMEsf5axB/55Z
         t8TH7w40XCtlGRQG4ojD7ORPgwVCUVnfpG5uHTMplLZti4/g9FVIrxdmBPl+Elm8dv
         +z2XhZ/EnWl2KWCkADI015z94ufqK5Z8RfniuXynzGeRMYEkojTb4P5xdNfw523X7N
         23nkPUmy4fBCC67m8+jFYqrND7/YTTvM/PvjIzDtqJKILNDYlsQ7CR+evEvKb6V6vz
         6LzibfRfR/EGA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/6] kbuild: implement {gcc,clang}-min-version only with built-in functions
Date:   Sat, 19 Nov 2022 04:53:04 +0900
Message-Id: <20221118195307.86049-4-masahiroy@kernel.org>
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

Now CONFIG_{GCC,CLANG}_VERSION are always 6-digit, replace the shell
invocations with the test-ge macro.

Please note gcc-min-version must be used against a 6-digit number.
Add '0' prefix.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/kbuild/makefiles.rst          | 6 +++---
 Makefile                                    | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 2 +-
 scripts/Makefile.compiler                   | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 6b7368d1f516..4144f1ce1ab5 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -669,18 +669,18 @@ more details, with real examples.
 
     gcc-min-version
 	gcc-min-version tests if the value of $(CONFIG_GCC_VERSION) is greater than
-	or equal to the provided value and evaluates to y if so.
+	or equal to the provided value (in 6-digit form) and evaluates to y if so.
 
 	Example::
 
-		cflags-$(call gcc-min-version, 70100) := -foo
+		cflags-$(call gcc-min-version, 070100) := -foo
 
 	In this example, cflags-y will be assigned the value -foo if $(CC) is gcc and
 	$(CONFIG_GCC_VERSION) is >= 7.1.
 
     clang-min-version
 	clang-min-version tests if the value of $(CONFIG_CLANG_VERSION) is greater
-	than or equal to the provided value and evaluates to y if so.
+	than or equal to the provided value (in 6-digit form) and evaluates to y if so.
 
 	Example::
 
diff --git a/Makefile b/Makefile
index 303516c035f6..03e6ae36c815 100644
--- a/Makefile
+++ b/Makefile
@@ -1050,7 +1050,7 @@ endif
 # ignored, continuing to default to PTRDIFF_MAX. So, left with no other
 # choice, we must perform a versioned check to disable this warning.
 # https://lore.kernel.org/lkml/20210824115859.187f272f@canb.auug.org.au
-KBUILD_CFLAGS-$(call gcc-min-version, 90100) += -Wno-alloc-size-larger-than
+KBUILD_CFLAGS-$(call gcc-min-version, 090100) += -Wno-alloc-size-larger-than
 KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
 
 # disable invalid "can't wrap" optimizations for signed / pointers
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index ca7d24000621..8006801d1b56 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -34,7 +34,7 @@ dml_ccflags := -mhard-float -maltivec
 endif
 
 ifdef CONFIG_CC_IS_GCC
-ifneq ($(call gcc-min-version, 70100),y)
+ifneq ($(call gcc-min-version, 070100),y)
 IS_OLD_GCC = 1
 endif
 endif
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 20d353dcabfb..db6f0546b0fc 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -62,12 +62,12 @@ cc-disable-warning = $(call try-run,\
 	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
 
 # gcc-min-version
-# Usage: cflags-$(call gcc-min-version, 70100) += -foo
-gcc-min-version = $(shell [ $(CONFIG_GCC_VERSION)0 -ge $(1)0 ] && echo y)
+# Usage: cflags-$(call gcc-min-version, 070100) += -foo
+gcc-min-version = $(call test-ge, $(CONFIG_GCC_VERSION), $1)
 
 # clang-min-version
 # Usage: cflags-$(call clang-min-version, 110000) += -foo
-clang-min-version = $(shell [ $(CONFIG_CLANG_VERSION)0 -ge $(1)0 ] && echo y)
+clang-min-version = $(call test-ge, $(CONFIG_CLANG_VERSION), $1)
 
 # ld-option
 # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
-- 
2.34.1

