Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A4A654517
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiLVQZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiLVQZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:25:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCD5F5D;
        Thu, 22 Dec 2022 08:25:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 649AE61C77;
        Thu, 22 Dec 2022 16:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87544C433F1;
        Thu, 22 Dec 2022 16:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671726341;
        bh=zmw5dd2+nTjePoq18Ny9AwtSOVSb9PF/qBiIkTnKoys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GnlPxbd2rp+6nR5yFh3rtyqpu7uYWZWEs+DXV0eyjaf72X2L71y0Sz9fi3ea5YzVT
         mkk+1WJkRIOD1LHgj5mHTKBXqgTXt2X6TEaCCDLA1M6KuVAb5RWVIpTYPpOyya2gj5
         Y95Fwtbzm5w3xlxYQM1GJFFiFs2IKqMsy1fwfmT3pHOSzpBxkWfGosvxdtqrMSvDtB
         INuWzjL4WalsV6VI0B8cEz6vPvOhhsKQWB4X226R136NSfa/lWo//uv+Pa0wdrRB/p
         2ZI0g+jFKm3TAMNggoRJLy6SMumnpqIG+2soe+FsLhs/s89RVjpd0agcpZkOQaRJhN
         VmgKMgBEkeniQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 2/5] kbuild: print short log in addition to the whole command with V=1
Date:   Fri, 23 Dec 2022 01:25:32 +0900
Message-Id: <20221222162535.1578462-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222162535.1578462-1-masahiroy@kernel.org>
References: <20221222162535.1578462-1-masahiroy@kernel.org>
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

"make V=1" prints the whole command instead of the short log, but I
think it is nicer to print both so that you can easily spot the build
rule of your interest.

This commit changes V=1 to print the short log (the line starts with
'#'), followed by the full log.

In parallel builds, the short/full logs from the same build rule may
be interspersed. To avoid it, please add -Otarget along with the -j<N>
option. Kbuild will never set -Otarget by default because Make would
buffer the logs and lose the escape sequences. (Modern compilers print
warnings and errors in color, but only when they write to a terminal.)

This is also a preparation for supporting V=12 because V=2 appends the
reason for rebuilding to the short log.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile               | 18 +++++++-----------
 scripts/Kbuild.include | 26 +++++++++++++-------------
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/Makefile b/Makefile
index e8ce3e2b30d6..ce98dfd8359a 100644
--- a/Makefile
+++ b/Makefile
@@ -56,22 +56,18 @@ unexport GREP_OPTIONS
 # Beautify output
 # ---------------------------------------------------------------------------
 #
-# Normally, we echo the whole command before executing it. By making
-# that echo $($(quiet)$(cmd)), we now have the possibility to set
-# $(quiet) to choose other forms of output instead, e.g.
+# Most of build commands in Kbuild start with "cmd_". You can optionally define
+# "quiet_cmd_*". If defined, the short log is printed. Otherwise, no log from
+# that command is printed by default.
 #
-#         quiet_cmd_cc_o_c = Compiling $(RELDIR)/$@
-#         cmd_cc_o_c       = $(CC) $(c_flags) -c -o $@ $<
-#
-# If $(quiet) is empty, the whole command will be printed.
-# If it is set to "quiet_", only the short version will be printed.
-# If it is set to "silent_", nothing will be printed at all, since
-# the variable $(silent_cmd_cc_o_c) doesn't exist.
+# e.g.)
+#    quiet_cmd_depmod = DEPMOD  $(MODLIB)
+#          cmd_depmod = $(srctree)/scripts/depmod.sh $(DEPMOD) $(KERNELRELEASE)
 #
 # A simple variant is to prefix commands with $(Q) - that's useful
 # for commands that shall be hidden in non-verbose mode.
 #
-#	$(Q)ln $@ :<
+#    $(Q)$(MAKE) $(build)=scripts/basic
 #
 # If KBUILD_VERBOSE equals 0 then the above command will be hidden.
 # If KBUILD_VERBOSE equals 1 then the above command is displayed.
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 2f7356b2990b..faae3c7986b0 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -125,15 +125,15 @@ dtbinst := -f $(srctree)/scripts/Makefile.dtbinst obj
 # $(Q)$(MAKE) $(clean)=dir
 clean := -f $(srctree)/scripts/Makefile.clean obj
 
-# echo command.
-# Short version is used, if $(quiet) equals `quiet_', otherwise full one.
-echo-cmd = $(if $($(quiet)cmd_$(1)),\
-	echo '  $(call escsq,$($(quiet)cmd_$(1)))$(echo-why)';)
-
-# sink stdout for 'make -s'
-       redirect :=
- quiet_redirect :=
-silent_redirect := exec >/dev/null;
+# pring log
+#
+# If quiet is "silent_", print nothing and sink stdout
+# If quiet is "quiet_", print short log
+# If quiet is empty, print short log and whole command
+silent_log_print = exec >/dev/null;
+ quiet_log_print = $(if $(quiet_cmd_$1), echo '  $(call escsq,$(quiet_cmd_$1)$(why))';)
+       log_print = echo '$(pound) $(call escsq,$(or $(quiet_cmd_$1),cmd_$1 $@))'; \
+                   echo '  $(call escsq,$(cmd_$1))';
 
 # Delete the target on interruption
 #
@@ -156,8 +156,8 @@ delete-on-interrupt = \
 		$(foreach sig, HUP INT QUIT TERM PIPE, \
 			trap 'rm -f $@; trap - $(sig); kill -s $(sig) $$$$' $(sig);))
 
-# printing commands
-cmd = @set -e; $(echo-cmd) $($(quiet)redirect) $(delete-on-interrupt) $(cmd_$(1))
+# print and execute commands
+cmd = @$(if $(cmd_$(1)),set -e; $($(quiet)log_print) $(delete-on-interrupt) $(cmd_$(1)),:)
 
 ###
 # if_changed      - execute command if any prerequisite is newer than
@@ -234,7 +234,7 @@ if_changed_rule = $(if $(if-changed-cond),$(rule_$(1)),@:)
 # (6) No dir/.target.cmd file and target not listed in $(targets)
 #     This is a good hint that there is a bug in the kbuild file
 ifeq ($(KBUILD_VERBOSE),2)
-why =                                                                        \
+_why =                                                                        \
     $(if $(filter $@, $(PHONY)),- due to target is PHONY,                    \
         $(if $(wildcard $@),                                                 \
             $(if $(newer-prereqs),- due to: $(newer-prereqs),                \
@@ -251,7 +251,7 @@ why =                                                                        \
          )                                                                   \
      )
 
-echo-why = $(call escsq, $(strip $(why)))
+why = $(space)$(strip $(_why))
 endif
 
 ###############################################################################
-- 
2.34.1

