Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C087172B298
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjFKPvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjFKPvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:51:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC46110DD;
        Sun, 11 Jun 2023 08:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4710D6111F;
        Sun, 11 Jun 2023 15:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171EFC433A1;
        Sun, 11 Jun 2023 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686498677;
        bh=y6jqiQg293+aEfQ+v45/BZNtXoJs+5js+pYlS3odLxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bImMTjKrRkjZ4w/6d128wuRwTQ4IMqkvaPX4WPj8/Fr8Jul/PlaDBEhN/RJLa8p/k
         /5fYLUop8t1QqLAafST+MCmP6Olfau1VxJmJQX/nXL59Z+RksK6wX2AEEwn0scTKts
         z+2BYMGsooOtF9g/okuwmhyfaj+D6M3vP7qm0XQQQeTogelZLsbzTGWdHFk81cHJRi
         fxH2woO6YiWxONOiOscn8nja/xTUYU5pwFQrmtY5X6Pw263/3vM+kdwb0bEq+c9q53
         tzQGbGRq0WTH/WQX4MV7FpCWqN2jxZq0q8J9wIOdpuotAQOTlXRhPxQeaxcXhgNyr/
         sQrxsHStMCYIw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-snps-arc@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v9 05/11] modpost: check static EXPORT_SYMBOL* by modpost again
Date:   Mon, 12 Jun 2023 00:50:54 +0900
Message-Id: <20230611155100.2553804-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230611155100.2553804-1-masahiroy@kernel.org>
References: <20230611155100.2553804-1-masahiroy@kernel.org>
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
index 4119e737fe87..210142c3ff00 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -222,8 +222,6 @@ cmd_gen_ksymdeps = \
 	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
 endif
 
-cmd_check_local_export = $(srctree)/scripts/check-local-export $@
-
 ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
 cmd_warn_shared_object = $(if $(word 2, $(modname-multi)),$(warning $(kbuild-file): $*.o is added to multiple modules: $(modname-multi)))
 endif
@@ -231,7 +229,6 @@ endif
 define rule_cc_o_c
 	$(call cmd_and_fixdep,cc_o_c)
 	$(call cmd,gen_ksymdeps)
-	$(call cmd,check_local_export)
 	$(call cmd,checksrc)
 	$(call cmd,checkdoc)
 	$(call cmd,gen_objtooldep)
@@ -243,7 +240,6 @@ endef
 define rule_as_o_S
 	$(call cmd_and_fixdep,as_o_S)
 	$(call cmd,gen_ksymdeps)
-	$(call cmd,check_local_export)
 	$(call cmd,gen_objtooldep)
 	$(call cmd,gen_symversions_S)
 	$(call cmd,warn_shared_object)
diff --git a/scripts/check-local-export b/scripts/check-local-export
deleted file mode 100755
index 86ad94647164..000000000000
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
-($3 ~ /^__export_symbol_.*/) {
-	export_symbols[i] = $3
-	sub(/^__export_symbol_/, "", export_symbols[i])
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
index bdf4244da993..10da82ad5874 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1210,6 +1210,13 @@ static void check_export_symbol(struct module *mod, struct elf_info *elf,
 		return;
 	}
 
+	if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL &&
+	    ELF_ST_BIND(sym->st_info) != STB_WEAK) {
+		error("%s: local symbol '%s' was exported\n", mod->name,
+		      label_name + strlen(prefix));
+		return;
+	}
+
 	name = sym_name(elf, sym);
 	if (strcmp(label_name + strlen(prefix), name)) {
 		error("%s: .export_symbol section references '%s', but it does not seem to be an export symbol\n",
-- 
2.39.2

