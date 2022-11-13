Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFA4626F41
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 12:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiKMLQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 06:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbiKMLP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 06:15:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D47FBCB4;
        Sun, 13 Nov 2022 03:15:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C783AB80C71;
        Sun, 13 Nov 2022 11:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C838C433B5;
        Sun, 13 Nov 2022 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668338143;
        bh=1P63x9nTvuyG2RvATLWGR+XaRnu7BvTepYHhkKgeLKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XL8cVlk83wiEBd8Oka0LGV2ggk6Plrp7LXgvNA/fGr+11sAFvgBPoBK/2lD5/MgXZ
         qs33wgSxSBNddXpbZlmPToyCDE7yAaoH9D9//iAgRYniqlqY8d/ynn8GHkcu3zw7O7
         fClCU6xjnrdRKbriWSMQO1L2Bv2VnJF6eaaZQTEd4xVG/aM4sktSzrB1gT9L0Oa/+a
         MCb11H5oxcYl/lDeI5TW55IldyG/eOxbrTAAiZk8/c87wfjZnGLbbl3xVw8ckDgkh4
         ydXAk+rDezdAe/5IdiaoTYIfEFXIdCcmWUv5Z7JhByX3S1g7/Ru+YQmM/8olHdesc6
         NLF+1rQGsMS6Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 3/3] [pending] kbuild: make forbid sharing objects among multiple modules
Date:   Sun, 13 Nov 2022 20:15:25 +0900
Message-Id: <20221113111525.3762483-4-masahiroy@kernel.org>
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

 *** This patch is applicable after all the warnings are fixed.
 *** It may take a couple of development cycles.

Now that all the warnings are fixed, the warning can be promoted to
an error.

Simplify the modules.builtin rule because modname always consists of
a single word.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.build     | 6 ------
 scripts/Makefile.lib       | 8 ++++----
 scripts/Makefile.vmlinux_o | 5 +----
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 799df12b53f3..37cf88d076e8 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -222,10 +222,6 @@ endif
 
 cmd_check_local_export = $(srctree)/scripts/check-local-export $@
 
-ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
-cmd_warn_shared_object = $(if $(word 2, $(modname-multi)),$(warning $(kbuild-file): $*.o is added to multiple modules: $(modname-multi)))
-endif
-
 define rule_cc_o_c
 	$(call cmd_and_fixdep,cc_o_c)
 	$(call cmd,gen_ksymdeps)
@@ -235,7 +231,6 @@ define rule_cc_o_c
 	$(call cmd,gen_objtooldep)
 	$(call cmd,gen_symversions_c)
 	$(call cmd,record_mcount)
-	$(call cmd,warn_shared_object)
 endef
 
 define rule_as_o_S
@@ -244,7 +239,6 @@ define rule_as_o_S
 	$(call cmd,check_local_export)
 	$(call cmd,gen_objtooldep)
 	$(call cmd,gen_symversions_S)
-	$(call cmd,warn_shared_object)
 endef
 
 # Built-in and composite module parts
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3aa384cec76b..d73bfe0fabda 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -106,13 +106,13 @@ endif
 
 # Finds the multi-part object the current object will be linked into.
 # If the object belongs to two or more multi-part objects, list them all.
-modname-multi = $(sort $(foreach m,$(multi-obj-ym),\
+__modname-multi = $(sort $(foreach m,$(multi-obj-ym),\
 		$(if $(filter $*.o, $(call suffix-search, $m, .o, -objs -y -m)),$(m:.o=))))
 
-__modname = $(or $(modname-multi),$(basetarget))
+modname-multi = $(if $(word 2, $(__modname-multi)), $(error $(kbuild-file): $*.o is added to multiple modules: $(__modname-multi)))$(__modname-multi)
 
-modname = $(subst $(space),:,$(__modname))
-modfile = $(addprefix $(obj)/,$(__modname))
+modname = $(or $(modname-multi),$(basetarget))
+modfile = $(addprefix $(obj)/,$(modname))
 
 # target with $(obj)/ and its suffix stripped
 target-stem = $(basename $(patsubst $(obj)/%,%,$@))
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 0edfdb40364b..2faf4960aa7a 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -74,13 +74,10 @@ modules.builtin.modinfo: vmlinux.o FORCE
 # module.builtin
 # ---------------------------------------------------------------------------
 
-# The second line aids cases where multiple modules share the same object.
-
 quiet_cmd_modules_builtin = GEN     $@
       cmd_modules_builtin = \
 	tr '\0' '\n' < $< | \
-	sed -n 's/^[[:alnum:]:_]*\.file=//p' | \
-	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$$/.ko/' > $@
+	sed -n 's@^[[:alnum:]:_]*\.file=\(.*\)@kernel/\1.ko@p' | uniq > $@
 
 targets += modules.builtin
 modules.builtin: modules.builtin.modinfo FORCE
-- 
2.34.1

