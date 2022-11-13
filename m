Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C87626F3C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 12:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiKMLP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 06:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiKMLPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 06:15:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7F32DD8;
        Sun, 13 Nov 2022 03:15:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFBD960B7D;
        Sun, 13 Nov 2022 11:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78B1C4347C;
        Sun, 13 Nov 2022 11:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668338139;
        bh=CChkGirQ7tNdW0xs9Ao2IBhdo5UClPyAQeNzBiEycCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rOV2ODH+mFiGalOdh3cb8F6arVpi9UcFhM4xPe6LxP7hq1R6oP2As6BM59t22SrMN
         e30nEec80SxAVR5p4t8cB+t15H4GzWD2F8RPfPruUHRC+esXPQQKJPwVEaMxMvPomw
         mm8xh1ve7CMidpLRRBnUwZmsMnviHeCh0+7nnxO3A4jFMzbdhsuTfvKrnnr8UJUTB0
         R7JW4TysTS5EntFzIsE8e06QFQmcj3eTn0R/vFZB6ApxUT/ieRAlnV54A2RlJN8k2k
         trbp9c8MTzgmB1G4rWco+YFIc7vBP2gnB09Z9Ae26YZOI04W3LetDiGn7cOYX1pcpL
         skimVcVu+7M6A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 1/3] kbuild: add kbuild-file macro
Date:   Sun, 13 Nov 2022 20:15:23 +0900
Message-Id: <20221113111525.3762483-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113111525.3762483-1-masahiroy@kernel.org>
References: <20221113111525.3762483-1-masahiroy@kernel.org>
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

While building, installing, cleaning, Kbuild visits sub-directories
and includes 'Kbuild' or 'Makefile' that exists there.

Add 'kbuild-file' macro, and reuse it from scripts/Makefie.*

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Kbuild.include       | 5 +++++
 scripts/Makefile.asm-generic | 6 +++---
 scripts/Makefile.build       | 6 +-----
 scripts/Makefile.clean       | 5 +----
 scripts/Makefile.dtbinst     | 2 +-
 5 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 2bc08ace38a3..cbe28744637b 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -40,6 +40,11 @@ escsq = $(subst $(squote),'\$(squote)',$1)
 # Quote a string to pass it to C files. foo => '"foo"'
 stringify = $(squote)$(quote)$1$(quote)$(squote)
 
+###
+# The path to Kbuild or Makefile. Kbuild has precedence over Makefile.
+kbuild-dir = $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
+kbuild-file = $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
+
 ###
 # Easy method for doing a status message
        kecho := :
diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
index 1d501c57f9ef..8d01b37b7677 100644
--- a/scripts/Makefile.asm-generic
+++ b/scripts/Makefile.asm-generic
@@ -10,15 +10,15 @@ PHONY := all
 all:
 
 src := $(subst /generated,,$(obj))
--include $(src)/Kbuild
+
+include $(srctree)/scripts/Kbuild.include
+-include $(kbuild-file)
 
 # $(generic)/Kbuild lists mandatory-y. Exclude um since it is a special case.
 ifneq ($(SRCARCH),um)
 include $(srctree)/$(generic)/Kbuild
 endif
 
-include $(srctree)/scripts/Kbuild.include
-
 redundant := $(filter $(mandatory-y) $(generated-y), $(generic-y))
 redundant += $(foreach f, $(generic-y), $(if $(wildcard $(srctree)/$(src)/$(f)),$(f)))
 redundant := $(sort $(redundant))
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 41f3602fc8de..37cf88d076e8 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -38,11 +38,7 @@ subdir-ccflags-y :=
 
 include $(srctree)/scripts/Kbuild.include
 include $(srctree)/scripts/Makefile.compiler
-
-# The filename Kbuild has precedence over Makefile
-kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
-include $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
-
+include $(kbuild-file)
 include $(srctree)/scripts/Makefile.lib
 
 # Do not include hostprogs rules unless needed.
diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
index 878cec648959..3649900696dd 100644
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
@@ -9,10 +9,7 @@ PHONY := __clean
 __clean:
 
 include $(srctree)/scripts/Kbuild.include
-
-# The filename Kbuild has precedence over Makefile
-kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
-include $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
+include $(kbuild-file)
 
 # Figure out what we need to build from the various variables
 # ==========================================================================
diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
index 190d781e84f4..2ab936e4179d 100644
--- a/scripts/Makefile.dtbinst
+++ b/scripts/Makefile.dtbinst
@@ -15,7 +15,7 @@ __dtbs_install:
 
 include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
-include $(src)/Makefile
+include $(kbuild-file)
 
 dtbs    := $(addprefix $(dst)/, $(dtb-y) $(if $(CONFIG_OF_ALL_DTBS),$(dtb-)))
 subdirs := $(addprefix $(obj)/, $(subdir-y) $(subdir-m))
-- 
2.34.1

