Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CE77282AB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbjFHOZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbjFHOZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:25:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901472D71;
        Thu,  8 Jun 2023 07:24:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6DA164E17;
        Thu,  8 Jun 2023 14:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED04C4339E;
        Thu,  8 Jun 2023 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686234285;
        bh=wDZYNwqiVuH0V8gWt3bQO0dgJiIU1kJv/naJ4wK8eyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f5eyupytjMru7y+zKUf+neYzJmNN/qDO1yks3ibrmWIyBDDfHdmEMPqrYbXFoFRml
         v4TPOg+NVeepAQ1LJ6RVR7SLOICOQX/jjZJcdkdTiQmC8iNB+OpHFL0zLOWYqZul1/
         Q0Ly5ObC4xq67L546vHmIP0i6cxu7vfIMochFxeJPeT3C2XSvLfO9KGd6DY29ox1mb
         YvYgTXPTmh8OaTNxbFNY+/5HBoNxoOlwFPT6JPlv2dx5kfTPf/WU+inMIqbgbzOfp5
         MrSn9fanDBshrjHHZnrj08MUM2hZr+ZGS37CBpsF2ci09sxbD85hP87bqjm4q2RU1B
         pOiNv7OmW3usg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v7 05/11] modpost: check static EXPORT_SYMBOL* by modpost again
Date:   Thu,  8 Jun 2023 23:24:22 +0900
Message-Id: <20230608142428.256985-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608142428.256985-1-masahiroy@kernel.org>
References: <20230608142428.256985-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 31cb50b5590f ("kbuild: check static EXPORT_SYMBOL* by script
instead of modpost") moved the static EXPORT_SYMBOL* check from the
mostpost to a shell script because I thought it must be checked per
compilation unit to avoid false negatives.

I came up with an idea to do this in modpost, against combined ELF
files. The relocation entries in ELF will find the correct exported
symbol even if there exist symbols with the same name in different
compilation units.

Again, the same sample code.

  Makefile:

    obj-y += foo1.o foo2.o

  foo1.c:

    #include <linux/export.h>
    static void foo(void) {}
    EXPORT_SYMBOL(foo);

  foo2.c:

    void foo(void) {}

Then, modpost can catch it correctly.

    MODPOST Module.symvers
  ERROR: modpost: vmlinux: local symbol 'foo' was exported

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

(no changes since v6)

Changes in v6:
  - Make the symbol name in the warning more precise

 scripts/Makefile.build     |  4 ---
 scripts/check-local-export | 70 --------------------------------------
 scripts/mod/modpost.c      |  7 ++++
 3 files changed, 7 insertions(+), 74 deletions(-)
 delete mode 100755 scripts/check-local-export

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 6bf026a304e4..bd4123795299 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -220,8 +220,6 @@ cmd_gen_ksymdeps = \
 	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
 endif
 
-cmd_check_local_export = $(srctree)/scripts/check-local-export $@
-
 ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
 cmd_warn_shared_object = $(if $(word 2, $(modname-multi)),$(warning $(kbuild-file): $*.o is added to multiple modules: $(modname-multi)))
 endif
@@ -229,7 +227,6 @@ endif
 define rule_cc_o_c
 	$(call cmd_and_fixdep,cc_o_c)
 	$(call cmd,gen_ksymdeps)
-	$(call cmd,check_local_export)
 	$(call cmd,checksrc)
 	$(call cmd,checkdoc)
 	$(call cmd,gen_objtooldep)
@@ -241,7 +238,6 @@ endef
 define rule_as_o_S
 	$(call cmd_and_fixdep,as_o_S)
 	$(call cmd,gen_ksymdeps)
-	$(call cmd,check_local_export)
 	$(call cmd,gen_objtooldep)
 	$(call cmd,gen_symversions_S)
 	$(call cmd,warn_shared_object)
diff --git a/scripts/check-local-export b/scripts/check-local-export
deleted file mode 100755
index 969a313b9299..000000000000
--- a/scripts/check-local-export
+++ /dev/null
@@ -1,70 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Copyright (C) 2022 Masahiro Yamada <masahiroy@kernel.org>
-# Copyright (C) 2022 Owen Rafferty <owen@owenrafferty.com>
-#
-# Exit with error if a local exported symbol is found.
-# EXPORT_SYMBOL should be used for global symbols.
-
-set -e
-pid=$$
-
-# If there is no symbol in the object, ${NM} (both GNU nm and llvm-nm) shows
-# 'no symbols' diagnostic (but exits with 0). It is harmless and hidden by
-# '2>/dev/null'. However, it suppresses real error messages as well. Add a
-# hand-crafted error message here.
-#
-# TODO:
-# Use --quiet instead of 2>/dev/null when we upgrade the minimum version of
-# binutils to 2.37, llvm to 13.0.0.
-# Then, the following line will be simpler:
-#   { ${NM} --quiet ${1} || kill 0; } |
-
-{ ${NM} ${1} 2>/dev/null || { echo "${0}: ${NM} failed" >&2; kill $pid; } } |
-${AWK} -v "file=${1}" '
-BEGIN {
-	i = 0
-}
-
-# Skip the line if the number of fields is less than 3.
-#
-# case 1)
-#   For undefined symbols, the first field (value) is empty.
-#   The outout looks like this:
-#     "                 U _printk"
-#   It is unneeded to record undefined symbols.
-#
-# case 2)
-#   For Clang LTO, llvm-nm outputs a line with type t but empty name:
-#     "---------------- t"
-!length($3) {
-	next
-}
-
-# save (name, type) in the associative array
-{ symbol_types[$3]=$2 }
-
-# append the exported symbol to the array
-($3 ~ /^__export_symbol_(gpl)?_.*/) {
-	export_symbols[i] = $3
-	sub(/^__export_symbol_(gpl)?_/, "", export_symbols[i])
-	i++
-}
-
-END {
-	exit_code = 0
-	for (j = 0; j < i; ++j) {
-		name = export_symbols[j]
-		# nm(3) says "If lowercase, the symbol is usually local"
-		if (symbol_types[name] ~ /[a-z]/) {
-			printf "%s: error: local symbol %s was exported\n",
-				file, name | "cat 1>&2"
-			exit_code = 1
-		}
-	}
-
-	exit exit_code
-}'
-
-exit $?
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0ae6c9c5bdf6..a3185ee6ec1a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1217,6 +1217,13 @@ static void check_export_symbol(struct module *mod, struct elf_info *elf,
 		return;
 	}
 
+	if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL &&
+	    ELF_ST_BIND(sym->st_info) != STB_WEAK) {
+		error("%s: local symbol '%s' was exported\n", mod->name,
+		      label_name + strlen(prefix));
+		return;
+	}
+
 	if (strcmp(label_name + strlen(prefix), name)) {
 		error("%s: .export_symbol section references '%s', but it does not seem to be an export symbol\n",
 		      mod->name, name);
-- 
2.39.2

