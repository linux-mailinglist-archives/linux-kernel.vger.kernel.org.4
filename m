Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28402636326
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbiKWPTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238338AbiKWPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:19:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477502AE08;
        Wed, 23 Nov 2022 07:19:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E772DB820DD;
        Wed, 23 Nov 2022 15:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469F7C43144;
        Wed, 23 Nov 2022 15:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669216765;
        bh=OBMm4QqhOlmUT3g2hDP5qvjLfDtxhBIfGMu2b58WDTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTakJUh4PdtKZVMtfRk/8rZ7yYVopIAcF1MKUjNpx4uYLT/NqB3Mf1SsYWze85pWo
         x1E90tv3bomKgNa7eh63QrDSOGbRC7OxoFGAnQ94A76NYCcLAIOSRO1VyC4sVXHJ6m
         RouFILUtkRGvx58oSm4O3dnFCDSUgN7GQb77ShPvmMADImlEcl//liBhtPSso2Gzgk
         smA/5LKHQ0uAIWgB4OAKl3D3BNNzAaVt3giuxpqE+2sWxbSGYUUl/3Hy4Px+8zdT5i
         ZHXqqA2LvfZz+hcHjs+9dN+X/Lhr4jqkIhBersDC9u6NHW0UOD7DaYK0dAHa3zix/s
         NKvwf9hY/O5Uw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v2 3/5] kbuild: add read-file macro
Date:   Thu, 24 Nov 2022 00:18:26 +0900
Message-Id: <20221123151828.509565-3-masahiroy@kernel.org>
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

Since GMU Make 4.2, $(file ...) supports the read operater '<', which is
useful to read a file without forking any process. No warning is shown even
if the input file is missing.

For older Make versions, it falls back to the cat command.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 Makefile                  |  2 +-
 scripts/Kbuild.include    | 12 ++++++++++++
 scripts/Makefile.modfinal |  2 +-
 scripts/Makefile.modinst  |  2 +-
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index eb80332f7b51..60ce9dcafc72 100644
--- a/Makefile
+++ b/Makefile
@@ -369,7 +369,7 @@ else # !mixed-build
 include $(srctree)/scripts/Kbuild.include
 
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
-KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
+KERNELRELEASE = $(call read-file, include/config/kernel.release)
 KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
 export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
 
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 9996f34327cb..722846c23264 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -10,6 +10,10 @@ empty   :=
 space   := $(empty) $(empty)
 space_escape := _-_SPACE_-_
 pound := \#
+define newline
+
+
+endef
 
 ###
 # Comparison macros.
@@ -55,6 +59,14 @@ stringify = $(squote)$(quote)$1$(quote)$(squote)
 kbuild-dir = $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
 kbuild-file = $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
 
+###
+# Read a file, replacing newlines with spaces
+ifeq ($(call test-ge, $(MAKE_VERSION), 4.2),y)
+read-file = $(subst $(newline),$(space),$(file < $1))
+else
+read-file = $(shell cat $1 2>/dev/null)
+endif
+
 ###
 # Easy method for doing a status message
        kecho := :
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 25bedd83644b..7252f6cf7837 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -13,7 +13,7 @@ include $(srctree)/scripts/Kbuild.include
 include $(srctree)/scripts/Makefile.lib
 
 # find all modules listed in modules.order
-modules := $(sort $(shell cat $(MODORDER)))
+modules := $(sort $(call read-file, $(MODORDER)))
 
 __modfinal: $(modules)
 	@:
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index a4c987c23750..509d424dbbd2 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -9,7 +9,7 @@ __modinst:
 include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
 
-modules := $(sort $(shell cat $(MODORDER)))
+modules := $(sort $(call read-file, $(MODORDER)))
 
 ifeq ($(KBUILD_EXTMOD),)
 dst := $(MODLIB)/kernel
-- 
2.34.1

