Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9631D636323
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbiKWPTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbiKWPT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:19:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2872AE08;
        Wed, 23 Nov 2022 07:19:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14AF0B8201C;
        Wed, 23 Nov 2022 15:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E926C433D6;
        Wed, 23 Nov 2022 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669216763;
        bh=zZ9vzObwysMPcl9yyFyu+hM9JhD2sJD/mwetUOgE8Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u78ZRFdhLLKDOiXCo43KHNi5x4eN+sGMnlkZhZxhh3Zo0KVTH0mpwpKJoTiizKtaw
         UMEtdoP5kGu2uwa92JY1T16CK+MW1zge+M3dhb1ztCGfyNyycOs/Ses6zKE2tpIwc2
         /V1N2q5WazBhktgQHq26rhp21iNgXR5vg58MchCLIBNIdtW4VTQcn2MBX2QV0d2JP3
         Kggcc4K2uibSlJkbFNo496Fzv4PM2P1a3WoFr32yWGh6fB84EkxOdqgfl57WUCpbMu
         guv5ppWMHxrcwqfxWb+2V9j1zhrskW9jryNi0H1Io6Uu+w9YTTHBg+L4oSqHB6OjE0
         p+QAlYHf/p0Pw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
Subject: [PATCH v2 2/5] kbuild: implement {gcc,clang}-min-version only with built-in functions
Date:   Thu, 24 Nov 2022 00:18:25 +0900
Message-Id: <20221123151828.509565-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123151828.509565-1-masahiroy@kernel.org>
References: <20221123151828.509565-1-masahiroy@kernel.org>
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

Converting clang-min-version is straightforward because the versions
are always 6-digit.

gcc-min-version is somewhat tricky because the minimal GCC version
is GCC 5.2; prepend '0' to the version that is less than 10 so that
test-ge is always passed with 6-digit versions.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Covert gcc-min-version in a different way

 scripts/Makefile.compiler | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 20d353dcabfb..cd75f81e88ef 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -63,11 +63,15 @@ cc-disable-warning = $(call try-run,\
 
 # gcc-min-version
 # Usage: cflags-$(call gcc-min-version, 70100) += -foo
-gcc-min-version = $(shell [ $(CONFIG_GCC_VERSION)0 -ge $(1)0 ] && echo y)
+
+# Preprend 0 to the version that is less than 10 so test-ge works.
+gcc-min-version = $(call test-ge, \
+                  $(or $(filter 1%, $(CONFIG_GCC_VERSION)), 0$(CONFIG_GCC_VERSION)), \
+                  $(or $(filter 1%, $1), 0$(strip $1)))
 
 # clang-min-version
 # Usage: cflags-$(call clang-min-version, 110000) += -foo
-clang-min-version = $(shell [ $(CONFIG_CLANG_VERSION)0 -ge $(1)0 ] && echo y)
+clang-min-version = $(call test-ge, $(CONFIG_CLANG_VERSION), $1)
 
 # ld-option
 # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
-- 
2.34.1

