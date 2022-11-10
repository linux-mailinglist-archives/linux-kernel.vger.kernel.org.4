Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CCC623ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiKJD6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiKJD6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:58:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AF9210;
        Wed,  9 Nov 2022 19:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=keXUAxgrNWLuszDntPbAOoOeHmeCOhm4tmODurQ4ZNI=; b=sC+ncqvIsvRuENRISslzGz3luV
        FbWKRAvyTFUKuWwJOMwO3iH+w5o8F49KGg7WL57bcJRw60qdY1y/ne/207pkRB7c+UZMbOkJQ02V+
        bKJekcrFbDKcc51eXP6ZOBNro0/b4lO7Qvox1HL/4qHKzxzrpmCVX1k7d4zMfpqFOuYPVZf3Re6QZ
        7NA8zYeKSdNgFkv+482+h8y6v7cEd7LMcFrh9B1GfBHlyWR4JmMfjHTHqzWz8Q8eUS4sGXFpylskZ
        Ani3MpAI7+7EySXiMmfttQi8QKtMmIYpErKIydH9URBLuz6DJJy5aoq4BIC6fujdmZUtC3rseaRvi
        Yzd7uGpA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osyhm-002TDf-E9; Thu, 10 Nov 2022 03:58:18 +0000
Date:   Wed, 9 Nov 2022 19:58:18 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, mcgrof@kernel.org
Subject: Re: [PATCH v9 2/8] kbuild: add modules_thick.builtin
Message-ID: <Y2x22mKtaZvC7ZSk@bombadil.infradead.org>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
 <20221109134132.9052-3-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109134132.9052-3-nick.alcock@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 01:41:26PM +0000, Nick Alcock wrote:
> I am not wedded to the approach used to construct this file, but I don't
> see any other way to do it despite spending a week or so trying to tie
> it into Kbuild without using a separate Makefile.modbuiltin: unlike the
> names of builtin modules (which are also recorded in the source files
> themseves via MODULE_*() macros) the mapping from object file name to
> built-in module name is not recorded anywhere but in the makefiles
> themselves, so we have to at least reparse them with something to
> indicate the builtin-ness of each module (i.e., tristate.conf) if we are
> to figure out which modules are built-in and which are not.

Please try this patch, unless I am not understanding perhaps we may be
able to replace the first two patches with this one? It also seems
to capture a bit more data than the modules_thick.builtin file.

From 3e5ce9141c25fd4eb23b5423d9aa9f1c4ebe4e8e Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Wed, 9 Nov 2022 17:58:57 -0800
Subject: [PATCH] kbuild: add modules.builtin.objs

The file modules.builtin contains all modules that are built into
the kernel and this is used by modprobe to not fail when trying to
load something builtin. But for tools which want to see which object
files come from what modules we want to help them with such a mapping
as it is not easy to get this otherwise.

We do this by just extending scripts/Makefile.lib with a new variable
and define to capture all possible objects, and stuff this into a new
modinfo.

Note that this doesn't bloat the kernel as all because as you can see
in include/asm-generic/vmlinux.lds.h, the .modinfo section is discarded
at the link stage.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 .gitignore                      |  2 +-
 Documentation/dontdiff          |  2 +-
 Documentation/kbuild/kbuild.rst |  5 +++++
 Makefile                        | 10 +++++++---
 include/linux/module.h          |  4 +++-
 scripts/Makefile.lib            |  5 ++++-
 scripts/Makefile.vmlinux_o      | 15 ++++++++++++++-
 7 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/.gitignore b/.gitignore
index 5da004814678..ef8665c64f21 100644
--- a/.gitignore
+++ b/.gitignore
@@ -67,7 +67,7 @@ modules.order
 /System.map
 /Module.markers
 /modules.builtin
-/modules.builtin.modinfo
+/modules.builtin.*
 /modules.nsdeps
 
 #
diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 352ff53a2306..ed1fbc711f33 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -180,7 +180,7 @@ mkutf8data
 modpost
 modules-only.symvers
 modules.builtin
-modules.builtin.modinfo
+modules.builtin.*
 modules.nsdeps
 modules.order
 modversions.h*
diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 08f575e6236c..504f31517cb4 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -17,6 +17,11 @@ modules.builtin
 This file lists all modules that are built into the kernel. This is used
 by modprobe to not fail when trying to load something builtin.
 
+modules.builtin.objs
+-----------------------
+This file contains object mapping of modules that are built into the kernel
+to their corresponding object files used to build the module.
+
 modules.builtin.modinfo
 -----------------------
 This file contains modinfo from all modules that are built into the kernel.
diff --git a/Makefile b/Makefile
index d148a55bfd0f..cd563d9713c9 100644
--- a/Makefile
+++ b/Makefile
@@ -1228,7 +1228,11 @@ PHONY += vmlinux_o
 vmlinux_o: vmlinux.a $(KBUILD_VMLINUX_LIBS)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_o
 
-vmlinux.o modules.builtin.modinfo modules.builtin: vmlinux_o
+MODULES_BUILTIN := modules.builtin.modinfo
+MODULES_BUILTIN += modules.builtin
+MODULES_BUILTIN += modules.builtin.objs
+
+vmlinux.o $(MODULES_BUILTIN): vmlinux_o
 	@:
 
 PHONY += vmlinux
@@ -1558,7 +1562,7 @@ __modinst_pre:
 	fi
 	@sed 's:^:kernel/:' modules.order > $(MODLIB)/modules.order
 	@cp -f modules.builtin $(MODLIB)/
-	@cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
+	@cp -f $(objtree)/modules.builtin.* $(MODLIB)/
 
 endif # CONFIG_MODULES
 
@@ -1571,7 +1575,7 @@ endif # CONFIG_MODULES
 
 # Directories & files removed with 'make clean'
 CLEAN_FILES += include/ksym vmlinux.symvers modules-only.symvers \
-	       modules.builtin modules.builtin.modinfo modules.nsdeps \
+	       modules.builtin modules.builtin.* modules.nsdeps \
 	       compile_commands.json .thinlto-cache rust/test rust/doc \
 	       .vmlinux.objs .vmlinux.export.c
 
diff --git a/include/linux/module.h b/include/linux/module.h
index ec61fb53979a..ce044cffd43d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -179,7 +179,9 @@ extern void cleanup_module(void);
 #ifdef MODULE
 #define MODULE_FILE
 #else
-#define MODULE_FILE	MODULE_INFO(file, KBUILD_MODFILE);
+#define MODULE_FILE					                      \
+			MODULE_INFO(file, KBUILD_MODFILE);                    \
+			MODULE_INFO(objs, KBUILD_MODOBJS);
 #endif
 
 /*
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3aa384cec76b..f7e5a83572fa 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -112,6 +112,8 @@ modname-multi = $(sort $(foreach m,$(multi-obj-ym),\
 __modname = $(or $(modname-multi),$(basetarget))
 
 modname = $(subst $(space),:,$(__modname))
+modname-objs = $($(modname)-objs) $($(modname)-y) $($(modname)-Y)
+modname-objs-prefixed = $(sort $(strip $(addprefix $(obj)/, $(modname-objs))))
 modfile = $(addprefix $(obj)/,$(__modname))
 
 # target with $(obj)/ and its suffix stripped
@@ -125,7 +127,8 @@ name-fix = $(call stringify,$(call name-fix-token,$1))
 basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
 modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname)) \
 		 -D__KBUILD_MODNAME=kmod_$(call name-fix-token,$(modname))
-modfile_flags  = -DKBUILD_MODFILE=$(call stringify,$(modfile))
+modfile_flags  = -DKBUILD_MODFILE=$(call stringify,$(modfile)) \
+                 -DKBUILD_MODOBJS=$(call stringify,$(modfile).o:$(subst $(space),|,$(modname-objs-prefixed)))
 
 _c_flags       = $(filter-out $(CFLAGS_REMOVE_$(target-stem).o), \
                      $(filter-out $(ccflags-remove-y), \
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 0edfdb40364b..9b4ca83f0695 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 PHONY := __default
-__default: vmlinux.o modules.builtin.modinfo modules.builtin
+__default: vmlinux.o modules.builtin.modinfo modules.builtin modules.builtin.objs
 
 include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
@@ -86,6 +86,19 @@ targets += modules.builtin
 modules.builtin: modules.builtin.modinfo FORCE
 	$(call if_changed,modules_builtin)
 
+# module.builtin.objs
+# ---------------------------------------------------------------------------
+quiet_cmd_modules_builtin_objs = GEN     $@
+      cmd_modules_builtin_objs = \
+	tr '\0' '\n' < $< | \
+	sed -n 's/^[[:alnum:]:_]*\.objs=//p' | \
+	tr ' ' '\n' | uniq | sed -e 's|:|: |' -e 's:|: :g' | \
+	tr -s ' ' > $@
+
+targets += modules.builtin.objs
+modules.builtin.objs: modules.builtin.modinfo FORCE
+	$(call if_changed,modules_builtin_objs)
+
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
 
-- 
2.35.1

