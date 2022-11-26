Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8F1639884
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 23:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiKZW4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 17:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiKZW4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 17:56:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE08140D7;
        Sat, 26 Nov 2022 14:56:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A1DF60C71;
        Sat, 26 Nov 2022 22:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE6EC4347C;
        Sat, 26 Nov 2022 22:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669503395;
        bh=573wZuVHPDdtLI75KSLGQVso6x98GKpafL/MbOBnj84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QKdqSqqzEeIs2ufMLbTAh2iA7e74VQUHVXj3lZnEJWwTnbXbMQmBJMDwjy6Pi47Yi
         /rSP9IjrAT4wZRHuaiJMjiK+fA+Ut98b1CIotwdwXJzAsPYIlVL+ByFAWyikTC0KjF
         9tEhumT/zYP54EN5Rf6fo2s6Mlk2NaYI75VUuhekMDmUWipvYqZeD3KsS2OGrRDgys
         +ouivD+Q6bcYcLg/PIEGOlXI8AvzaDUxCZIX+ovO4Sm6F7fYawzk5JL+TBVXfQbS3r
         nyW/BAL5VeuvxBbI2jX7xAoyYw4vu8UWC8XbJpV2R2JDnjC2rbo7TN87DgrKqGCEFY
         Ccv6854i8MvPA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Subject: [PATCH v3 2/5] kbuild: implement {gcc,clang}-min-version only with built-in functions
Date:   Sun, 27 Nov 2022 07:56:21 +0900
Message-Id: <20221126225624.751661-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221126225624.751661-1-masahiroy@kernel.org>
References: <20221126225624.751661-1-masahiroy@kernel.org>
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
is GCC 5.1; prepend '0' to the version that is less than 10 so that
test-ge is always passed with 6-digit versions.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

Changes in v3:
  - Add comments

Changes in v2:
  - Covert gcc-min-version in a different way

 scripts/Makefile.compiler | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 20d353dcabfb..4c095beda093 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -63,11 +63,16 @@ cc-disable-warning = $(call try-run,\
 
 # gcc-min-version
 # Usage: cflags-$(call gcc-min-version, 70100) += -foo
-gcc-min-version = $(shell [ $(CONFIG_GCC_VERSION)0 -ge $(1)0 ] && echo y)
+
+# Preprend 0 to the version that is less than 10 so test-ge works.
+# This will break when GCC 20 is released. Remove this workaround until then.
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

