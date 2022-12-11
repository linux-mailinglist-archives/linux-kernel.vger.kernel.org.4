Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DF764944C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiLKNE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiLKNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:04:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4947665;
        Sun, 11 Dec 2022 05:04:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E3CF60DEC;
        Sun, 11 Dec 2022 13:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2563FC433F2;
        Sun, 11 Dec 2022 13:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670763865;
        bh=MLS1s8ktcG2Xasg/KRaUChCLQv9pvRwRoCqpTltawqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nlOm1ebyH3IY4LHcZpPojtLI2FB6N8ATGeYAEeLrTLZe0DW6XJbWA78ih0g6TPkeJ
         y6SJAwp65Y1jdsap/D6rX2405K9KRnIVuu58OZfIshZsmXYPwjsWZDnjbpAWKZXVKc
         Tvub9SiJXqgBCk5+N/og7JhX3FuiEsjPzbhEyGo2+wgkqkG1fEBQoWdZAjW8wYtRWU
         j4sZMst2ziykzLY03sBIu7hGWHWy81MjbRVUC3PE+NEDsOoaiLQIuwk/rRgdkUbTgQ
         Ms9V1acjd2Oy6zIkxafRxbCMAg5uw7giK3QdDcuQrZLP8usizTaHf+W2mZ0q1U3OIZ
         9m2/koJ11+Hig==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 2/2] kbuild: refactor the prerequisites of the modpost rule
Date:   Sun, 11 Dec 2022 22:04:08 +0900
Message-Id: <20221211130408.2800314-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221211130408.2800314-1-masahiroy@kernel.org>
References: <20221211130408.2800314-1-masahiroy@kernel.org>
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

The prerequisites of modpost are cluttered. The variables *-if-present
and *-if-needed are unreadable.

It is cleaner to append them into modpost-deps.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.modpost | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index f814a6acd200..5eb5e8280379 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -38,6 +38,8 @@ __modpost:
 include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
 
+MODPOST = scripts/mod/modpost
+
 modpost-args =										\
 	$(if $(CONFIG_MODVERSIONS),-m)							\
 	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)					\
@@ -46,6 +48,8 @@ modpost-args =										\
 	$(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_NSDEPS),-N)	\
 	-o $@
 
+modpost-deps := $(MODPOST)
+
 # 'make -i -k' ignores compile errors, and builds as many modules as possible.
 ifneq ($(findstring i,$(filter-out --%,$(MAKEFLAGS))),)
 modpost-args += -n
@@ -78,12 +82,13 @@ targets += .vmlinux.objs
 .vmlinux.objs: vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
 	$(call if_changed,vmlinux_objs)
 
-vmlinux.o-if-present := $(wildcard vmlinux.o)
-output-symdump := vmlinux.symvers
-
-ifdef KBUILD_MODULES
-output-symdump := $(if $(vmlinux.o-if-present), Module.symvers, modules-only.symvers)
-missing-input := $(filter-out $(vmlinux.o-if-present),vmlinux.o)
+ifeq ($(wildcard vmlinux.o),)
+missing-input := vmlinux.o
+output-symdump := modules-only.symvers
+else
+modpost-args += vmlinux.o
+modpost-deps += vmlinux.o
+output-symdump := $(if $(KBUILD_MODULES), Module.symvers, vmlinux.symvers)
 endif
 
 else
@@ -95,11 +100,16 @@ src := $(obj)
 # Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
 include $(kbuild-file)
 
-module.symvers-if-present := $(wildcard Module.symvers)
 output-symdump := $(KBUILD_EXTMOD)/Module.symvers
-missing-input := $(filter-out $(module.symvers-if-present), Module.symvers)
 
-modpost-args += -e $(addprefix -i ,$(module.symvers-if-present) $(KBUILD_EXTRA_SYMBOLS))
+ifeq ($(wildcard Module.symvers),)
+missing-input := Module.symvers
+else
+modpost-args += -i Module.symvers
+modpost-deps += Module.symvers
+endif
+
+modpost-args += -e $(addprefix -i , $(KBUILD_EXTRA_SYMBOLS))
 
 endif # ($(KBUILD_EXTMOD),)
 
@@ -108,12 +118,10 @@ modpost-args += -w
 endif
 
 ifdef KBUILD_MODULES
-modorder-if-needed := $(MODORDER)
 modpost-args += -T $(MODORDER)
+modpost-deps += $(MODORDER)
 endif
 
-MODPOST = scripts/mod/modpost
-
 # Read out modules.order to pass in modpost.
 # Otherwise, allmodconfig would fail with "Argument list too long".
 quiet_cmd_modpost = MODPOST $@
@@ -122,10 +130,10 @@ quiet_cmd_modpost = MODPOST $@
 		echo >&2 "WARNING: $(missing-input) is missing."; \
 		echo >&2 "         Modules may not have dependencies or modversions."; \
 		echo >&2 "         You may get many unresolved symbol warnings.";) \
-	$(MODPOST) $(modpost-args) $(vmlinux.o-if-present)
+	$(MODPOST) $(modpost-args)
 
 targets += $(output-symdump)
-$(output-symdump): $(modorder-if-needed) $(vmlinux.o-if-present) $(module.symvers-if-present) $(MODPOST) FORCE
+$(output-symdump): $(modpost-deps) FORCE
 	$(call if_changed,modpost)
 
 __modpost: $(output-symdump)
-- 
2.34.1

