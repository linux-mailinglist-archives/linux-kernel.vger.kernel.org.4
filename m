Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900287019DC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbjEMUrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjEMUq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:46:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53B24C1B;
        Sat, 13 May 2023 13:45:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23DFD6152F;
        Sat, 13 May 2023 20:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB616C433D2;
        Sat, 13 May 2023 20:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684010751;
        bh=uOppWNJ6OKrWtEcyb/WZOLcPRQzIKaj9fIb8LyZK590=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PueLfi5n/cCFGP5fZw8m4Hwvgq6A50mXArJA0Ol6T6Ug9zp7Q0XJ6HQ/h32Vsj8T6
         w8w6vlDUox3lJClRI2UApc+LYcmJuc0fp361g4U1DWFgWOp5ILIztOWu/xYxhv8WwO
         LJBdOsGW15Kv4JR5bSBpyw9/J0V1vwoJ9eVUBiDRrJM19NXyaANpPktTZc/6LIYwpk
         F9TU/jTddPF2JGAEKVdeHco5fybw7gqnlPkQQDHcdvvk6V+H0fpufTd57AvcJ7bYHY
         8NrJi0vMmWiDWJWSGQFgYwbB1hHS4x+olXlb+6ocZXmVg1Gu5R2rcO9Z2w4gyqspp6
         KZ+wwPqg7nhfQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 18/21] modpost: check static EXPORT_SYMBOL* by modpost again
Date:   Sun, 14 May 2023 05:44:59 +0900
Message-Id: <20230513204502.1593923-19-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230513204502.1593923-1-masahiroy@kernel.org>
References: <20230513204502.1593923-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
---

 scripts/Makefile.build     |  4 ---
 scripts/check-local-export | 70 --------------------------------------
 scripts/mod/modpost.c      |  6 ++++
 3 files changed, 6 insertions(+), 74 deletions(-)
 delete mode 100755 scripts/check-local-export

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index c26c04aea652..94b3323dcea7 100644
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
index e54a1642c970..000000000000
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
-($3 ~ /^__export_symbol.*\..*/) {
-	export_symbols[i] = $3
-	sub(/^__export_symbol.*\./, "", export_symbols[i])
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
index 8cf6bc0ac050..3e956013a6c8 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1236,6 +1236,12 @@ static void check_export_symbol(struct module *mod, struct elf_info *elf,
 		return;
 	}
 
+	if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL &&
+	    ELF_ST_BIND(sym->st_info) != STB_WEAK) {
+		error("%s: local symbol '%s' was exported\n", mod->name, name);
+		return;
+	}
+
 	s = sym_add_exported(name, mod, is_gpl);
 	sym_update_namespace(name, sym_get_data(elf, label));
 
-- 
2.39.2

