Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F50658ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 10:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiL2JPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 04:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiL2JPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:15:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF2C638B;
        Thu, 29 Dec 2022 01:15:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 558DB61739;
        Thu, 29 Dec 2022 09:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E927C433F0;
        Thu, 29 Dec 2022 09:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672305308;
        bh=wtSs6J9YLnzQPlTY0VzKME94in4y1oLZtAIe70huUqE=;
        h=From:To:Cc:Subject:Date:From;
        b=UcEFphREvL1CSWRfHNQSiBEvCbzdCYvSblsfY1GzZ55jhvhdsI8UsH3HDdlRpF/t1
         2XdtBz6nmOMBxobkhx1IehWgBZO/SRgpd1EyGEdEVe2pAmXmaGlOr6j88E95Ewl5jK
         ljZ7wtS9XwHgydVIhHN0foW/zfZGSU/8rvAGhfNJSVpAY86ZZebOTb21AJQDb9dmWu
         QCSp3xt5DO+pEzAJGahamtTCdcKPMyCjsvQmXIU+2gyFMzj22jCmSCl5izvROR0YTg
         LbeSmZsEIJOo2RrmkX8wYpS9iPsuWg5fWgzqOoQMXJ1QkgS7w1oppvJS9GmOjR7aLq
         aukoscZ3qYCzw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
Subject: [PATCH 1/2] kbuild: rename cmd_$@ to savedcmd_$@ in *.cmd files
Date:   Thu, 29 Dec 2022 18:15:00 +0900
Message-Id: <20221229091501.916296-1-masahiroy@kernel.org>
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

The cmd-check macro compares $(cmd_$@) and $(cmd_$1), but a pitfall is
that you cannot use cmd_<target> as the variable name for the command.

For example, the following code will not work in the top Makefile
or ./Kbuild.

    quiet_cmd_foo = GEN     $@
          cmd_foo = touch $@

    targets += foo
    foo: FORCE
            $(call if_changed,foo)

In this case, both $@ and $1 are expanded to 'foo', so $(cmd_check)
is always empty.

We do not need to use the same prefix for cmd_$@ and cmd_$1.
Rename the former to savedcmd_$@.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Kbuild.include                      | 8 ++++----
 scripts/Makefile.modfinal                   | 2 +-
 scripts/basic/fixdep.c                      | 4 ++--
 scripts/clang-tools/gen_compile_commands.py | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 10cf8d2d82ef..1a7514f49089 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -170,10 +170,10 @@ cmd = @$(if $(cmd_$(1)),set -e; $($(quiet)log_print) $(delete-on-interrupt) $(cm
 ifneq ($(KBUILD_NOCMDDEP),1)
 # Check if both commands are the same including their order. Result is empty
 # string if equal. User may override this check using make KBUILD_NOCMDDEP=1
-cmd-check = $(filter-out $(subst $(space),$(space_escape),$(strip $(cmd_$@))), \
+cmd-check = $(filter-out $(subst $(space),$(space_escape),$(strip $(savedcmd_$@))), \
                          $(subst $(space),$(space_escape),$(strip $(cmd_$1))))
 else
-cmd-check = $(if $(strip $(cmd_$@)),,1)
+cmd-check = $(if $(strip $(savedcmd_$@)),,1)
 endif
 
 # Replace >$< with >$$< to preserve $ when reloading the .cmd file
@@ -199,7 +199,7 @@ if_changed = $(if $(if-changed-cond),$(cmd_and_savecmd),@:)
 
 cmd_and_savecmd =                                                            \
 	$(cmd);                                                              \
-	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd
+	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd
 
 # Execute the command and also postprocess generated .d dependencies file.
 if_changed_dep = $(if $(if-changed-cond),$(cmd_and_fixdep),@:)
@@ -239,7 +239,7 @@ _why =                                                                        \
         $(if $(wildcard $@),                                                 \
             $(if $(newer-prereqs),- due to: $(newer-prereqs),                \
                 $(if $(cmd-check),                                           \
-                    $(if $(cmd_$@),- due to command line change,             \
+                    $(if $(savedcmd_$@),- due to command line change,        \
                         $(if $(filter $@, $(targets)),                       \
                             - due to missing .cmd file,                      \
                             - due to $(notdir $@) not in $$(targets)         \
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index a30d5b08eee9..4703f652c009 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -54,7 +54,7 @@ newer_prereqs_except = $(filter-out $(PHONY) $(1),$?)
 # Same as if_changed, but allows to exclude specified extra dependencies
 if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
 	$(cmd);                                                              \
-	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
+	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
 
 # Re-generate module BTFs if either module's .ko or vmlinux changed
 %.ko: %.o %.mod.o scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),vmlinux) FORCE
diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index 2328f9a641da..7a408bb97478 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -70,7 +70,7 @@
  *
  * It first generates a line
  *
- *   cmd_<target> = <cmdline>
+ *   savedcmd_<target> = <cmdline>
  *
  * and then basically copies the .<target>.d file to stdout, in the
  * process filtering out the dependency on autoconf.h and adding
@@ -344,7 +344,7 @@ int main(int argc, char *argv[])
 	target = argv[2];
 	cmdline = argv[3];
 
-	printf("cmd_%s := %s\n\n", target, cmdline);
+	printf("savedcmd_%s := %s\n\n", target, cmdline);
 
 	buf = read_file(depfile);
 	parse_dep_file(buf, target);
diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index 0227522959a4..15ba56527acd 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -19,7 +19,7 @@ _DEFAULT_OUTPUT = 'compile_commands.json'
 _DEFAULT_LOG_LEVEL = 'WARNING'
 
 _FILENAME_PATTERN = r'^\..*\.cmd$'
-_LINE_PATTERN = r'^cmd_[^ ]*\.o := (.* )([^ ]*\.c) *(;|$)'
+_LINE_PATTERN = r'^savedcmd_[^ ]*\.o := (.* )([^ ]*\.c) *(;|$)'
 _VALID_LOG_LEVELS = ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
 # The tools/ directory adopts a different build system, and produces .cmd
 # files in a different format. Do not support it.
-- 
2.34.1

