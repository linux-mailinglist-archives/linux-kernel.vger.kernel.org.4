Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830F2639886
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 23:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiKZW4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 17:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiKZW4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 17:56:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EAE140D7;
        Sat, 26 Nov 2022 14:56:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95E45B80A36;
        Sat, 26 Nov 2022 22:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22713C43470;
        Sat, 26 Nov 2022 22:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669503397;
        bh=AtKhQp8FtKxLMmPcpUUV2Sk+OJL/9nVhE5GmwRmFJ/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tpc49ynONcF6JHmKmUmDdKQimA5CgkjPa8g75uKF3gIHTiUVOidbUq2NaO6AeRXx0
         faxfC5+C9SN6n5m+MPij0NW62dlLfBpi7HxSJroADn90szqn4nHcQu8UBpLs3+rAJB
         9LJ1mI9J308cAk3h7csqYE6R7ZI55mERJRQa3DhK0xPqskmehF0MX4MSnYugRxuQTO
         VkjIj//94z3zPL6+wpocM42sbe1HZIFzsSU/pqLWjQHG0T2tI+uHvCged6RCISfpQ4
         ZnUipha/lMiCSMezbryYnutETrFVNA7hX6AMJmPVpT1DvnxMRes6lZCPLwE1tDiNUD
         g5dUyW76vsYbw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 3/5] kbuild: add read-file macro
Date:   Sun, 27 Nov 2022 07:56:22 +0900
Message-Id: <20221126225624.751661-3-masahiroy@kernel.org>
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

Since GNU Make 4.2, $(file ...) supports the read operater '<', which
is useful to read a file without forking any process. No warning is
shown even if the input file is missing.

For older Make versions, it falls back to the cat command.

The added ifeq will break when GNU Make 4.10 or 10.0 is released.
It will take a long time if the current release pace continues.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

(no changes since v1)

 Makefile                  |  2 +-
 scripts/Kbuild.include    | 15 +++++++++++++++
 scripts/Makefile.modfinal |  2 +-
 scripts/Makefile.modinst  |  2 +-
 4 files changed, 18 insertions(+), 3 deletions(-)

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
index 4b8cf464b53b..55c2243f91c8 100644
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
@@ -55,6 +59,17 @@ stringify = $(squote)$(quote)$1$(quote)$(squote)
 kbuild-dir = $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
 kbuild-file = $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
 
+###
+# Read a file, replacing newlines with spaces
+#
+# This ifeq will break when GNU Make 4.10 is released.
+# Remove this conditional until then.
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

