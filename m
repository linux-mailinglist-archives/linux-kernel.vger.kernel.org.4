Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE3364921C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiLKCzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKCy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:54:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22751A1A1;
        Sat, 10 Dec 2022 18:54:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0EB6B808C8;
        Sun, 11 Dec 2022 02:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E129FC433D2;
        Sun, 11 Dec 2022 02:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670727295;
        bh=tEabLVM+TJJXt+SeBNnybwbN+Grz6A4b2Mnbyj7yiKg=;
        h=From:To:Cc:Subject:Date:From;
        b=ZLESujB13DFfoRvI09cmaCmKiA5ABpSBeV/EHQ9ye0C7rygcsADw8Oc4zU0keDGGd
         lhX1TOueCyorBhMRQ051AfUv/o37f8GFK2fVc4HWKCQO134Wxa2BW9Kf1sybem5JWV
         Pbr7phn36mZvGnPoDB+THn1FgUYdOSobgdXnEKhs3Eiy9Td67jpjp3LKpqF5NmSsu7
         7l/dcRBnOIp2klpoEGPW7iv/fC8/SIY2J5QYzquKVNFO+yoUo+dcbBuWC/z8h0iAe9
         P8thfOOWB3Hhsq42yK2mkzZfObajxBC6mOGz+CXxVUxF2v0bBmRizqSRTzBT5qkEQf
         t4nNhfVOII/dA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 1/2] kbuild: add read-file macro
Date:   Sun, 11 Dec 2022 11:54:47 +0900
Message-Id: <20221211025448.2620799-1-masahiroy@kernel.org>
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

Since GNU Make 4.2, $(file ...) supports the read operater '<', which
is useful to read a file without forking a new process. No warning is
shown even if the input file is missing.

For older Make versions, it falls back to the cat command.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Tested-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---

Changes in v3:
  - Check the MAKE_VERSION in an ad-hoc way

 Makefile                  |  2 +-
 scripts/Kbuild.include    | 14 ++++++++++++++
 scripts/Makefile.modfinal |  2 +-
 scripts/Makefile.modinst  |  2 +-
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 8801cac4d3d5..2dda1e9a717a 100644
--- a/Makefile
+++ b/Makefile
@@ -376,7 +376,7 @@ else # !mixed-build
 include $(srctree)/scripts/Kbuild.include
 
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
-KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
+KERNELRELEASE = $(call read-file, include/config/kernel.release)
 KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
 export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
 
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 5019bc1e38e4..abdc269a51da 100644
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
@@ -61,6 +65,16 @@ stringify = $(squote)$(quote)$1$(quote)$(squote)
 kbuild-dir = $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
 kbuild-file = $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
 
+###
+# Read a file, replacing newlines with spaces
+#
+# Make 4.2 or later can read a file by using its builtin function.
+ifneq ($(filter-out 3.% 4.0 4.1, $(MAKE_VERSION)),)
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

