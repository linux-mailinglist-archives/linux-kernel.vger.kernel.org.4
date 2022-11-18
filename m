Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4218362FE5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiKRTxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiKRTxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:53:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219C7B5C67;
        Fri, 18 Nov 2022 11:53:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9F10B82515;
        Fri, 18 Nov 2022 19:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FC5C433C1;
        Fri, 18 Nov 2022 19:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668801199;
        bh=uuzKJuSL9U4I6WHbVaSjSwOBgCBIs163TnW2EI3m5+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E0JeKu6Z8lXqKFDfyG317cfY5aNZTtC7IcIZEEhM/mwnAXvQgpyLFvLiUDIKqsKdg
         lTg1pkn8jYZKB3/nCAJ9Qj5/6C9IJqydO8wC81xtg3vZSHkIojeW8v3PZqKo+HbiiA
         B4CkFfQ9dBsQAlcXYtfZ4NgTttG8SQL0sDSMaIBNn5WZVah2NTlmByKnEVZ1C66H6c
         iBArhSYEFYOWhYWk3wlJ1sJAZ1aJ9PFT7R782cD6oA6Yb0ScaMCvR5isTB5JhvmLVR
         dYMIBuy53qscKzFOiqsiFCghbwoQ6ICV7yZD6ehyJxzizAqb2xsPPJUC3S05rfmqqm
         GYrtgWH4hI4hg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 4/6] kbuild: add read-file macro
Date:   Sat, 19 Nov 2022 04:53:05 +0900
Message-Id: <20221118195307.86049-5-masahiroy@kernel.org>
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

Since GMU Make 4.2, $(file ...) supports the read operater '<', which is
useful to read a file without forking any process. No warning is shown even
if the input file is missing.

For older Make versions, it falls back to the cat command.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                  |  2 +-
 scripts/Kbuild.include    | 12 ++++++++++++
 scripts/Makefile.modfinal |  2 +-
 scripts/Makefile.modinst  |  2 +-
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 03e6ae36c815..93e5749ace55 100644
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

