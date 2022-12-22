Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E989654516
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiLVQZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbiLVQZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:25:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B85248E9;
        Thu, 22 Dec 2022 08:25:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 789BF61C27;
        Thu, 22 Dec 2022 16:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD17C433F1;
        Thu, 22 Dec 2022 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671726348;
        bh=GvfDctaGNc7i2KzNMI69jvMZBKWAND366R+TzK2H2YU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I2KLf4OXmjVVPJMPAuwOAsnB5ms/iSEINkvPQrnoRBc/+D2l1u8ctvE6WaBu0jD0Z
         ZJzJFfH1avicNkqWN03tJbvs32HIgCyuQEgGbcyvUFQufIKfH3nOw2yyI78noAUFHQ
         jQsOze9t/2MLAVhTSo71xAtX4XV0o9NiU2NV1J6CkOagTF1D6UMiiDkfRTo0ZsPuSv
         l90EoKhdVtugYpwsLVV2Zj6418x8VUo0i1zHUCHOCY75YC+6Vx9crV2FxuJc5zAPw4
         EcjZtXDkpTeMmdLmXESRNfFPRDE62yQ3h9n0oTYPror8n8KGlqjVo6IrZn7ErQIWAg
         1+mzvTdprzeog==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vipin Sharma <vipinsh@google.com>, x86@kernel.org
Subject: [PATCH 4/5] kbuild: allow to combine multiple V= levels
Date:   Fri, 23 Dec 2022 01:25:34 +0900
Message-Id: <20221222162535.1578462-4-masahiroy@kernel.org>
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

Commit a6de553da01c ("kbuild: Allow to combine multiple W= levels")
supported W=123 to enable all the extra warning groups.

I think a similar idea is applicable to the V= option.

  V=1 echos the whole command
  V=2 prints the reason for rebuilding

These are orthogonal, and can be enabled at the same time.

This commit supports V=12 to enable both of them.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                | 18 +++++++++---------
 arch/x86/tools/Makefile |  2 +-
 scripts/Kbuild.include  |  4 ++--
 scripts/tags.sh         |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index ce98dfd8359a..bd69bf73a256 100644
--- a/Makefile
+++ b/Makefile
@@ -69,9 +69,8 @@ unexport GREP_OPTIONS
 #
 #    $(Q)$(MAKE) $(build)=scripts/basic
 #
-# If KBUILD_VERBOSE equals 0 then the above command will be hidden.
-# If KBUILD_VERBOSE equals 1 then the above command is displayed.
-# If KBUILD_VERBOSE equals 2 then give the reason why each target is rebuilt.
+# If KBUILD_VERBOSE contains 1, the whole command is echoed.
+# If KBUILD_VERBOSE contains 2, the reason for rebuilding is printed.
 #
 # To put more focus on warnings, be less verbose as default
 # Use 'make V=1' to see the full commands
@@ -83,12 +82,12 @@ ifndef KBUILD_VERBOSE
   KBUILD_VERBOSE = 0
 endif
 
-ifeq ($(KBUILD_VERBOSE),1)
+quiet = quiet_
+Q = @
+
+ifneq ($(findstring 1, $(KBUILD_VERBOSE)),)
   quiet =
   Q =
-else
-  quiet=quiet_
-  Q = @
 endif
 
 # If the user is running make -s (silent mode), suppress echoing of
@@ -1762,8 +1761,9 @@ help:
 		printf "  %-16s - Show all of the above\\n" help-boards; \
 		echo '')
 
-	@echo  '  make V=0|1 [targets] 0 => quiet build (default), 1 => verbose build'
-	@echo  '  make V=2   [targets] 2 => give reason for rebuild of target'
+	@echo  '  make V=n   [targets] 0: quiet build (default), 1: verbose build'
+	@echo  '                       2: give reason for rebuild of target'
+	@echo  '                       V=1 and V=2 can be combined with V=12'
 	@echo  '  make O=dir [targets] Locate all output files in "dir", including .config'
 	@echo  '  make C=1   [targets] Check re-compiled c source with $$CHECK'
 	@echo  '                       (sparse by default)'
diff --git a/arch/x86/tools/Makefile b/arch/x86/tools/Makefile
index bddfc9a46645..90e820ac9771 100644
--- a/arch/x86/tools/Makefile
+++ b/arch/x86/tools/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 PHONY += posttest
 
-ifeq ($(KBUILD_VERBOSE),1)
+ifneq ($(findstring 1, $(KBUILD_VERBOSE)),)
   posttest_verbose = -v
 else
   posttest_verbose =
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index faae3c7986b0..10cf8d2d82ef 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -132,7 +132,7 @@ clean := -f $(srctree)/scripts/Makefile.clean obj
 # If quiet is empty, print short log and whole command
 silent_log_print = exec >/dev/null;
  quiet_log_print = $(if $(quiet_cmd_$1), echo '  $(call escsq,$(quiet_cmd_$1)$(why))';)
-       log_print = echo '$(pound) $(call escsq,$(or $(quiet_cmd_$1),cmd_$1 $@))'; \
+       log_print = echo '$(pound) $(call escsq,$(or $(quiet_cmd_$1),cmd_$1 $@)$(why))'; \
                    echo '  $(call escsq,$(cmd_$1))';
 
 # Delete the target on interruption
@@ -233,7 +233,7 @@ if_changed_rule = $(if $(if-changed-cond),$(rule_$(1)),@:)
 # (5) No dir/.target.cmd file (used to store command line)
 # (6) No dir/.target.cmd file and target not listed in $(targets)
 #     This is a good hint that there is a bug in the kbuild file
-ifeq ($(KBUILD_VERBOSE),2)
+ifneq ($(findstring 2, $(KBUILD_VERBOSE)),)
 _why =                                                                        \
     $(if $(filter $@, $(PHONY)),- due to target is PHONY,                    \
         $(if $(wildcard $@),                                                 \
diff --git a/scripts/tags.sh b/scripts/tags.sh
index e137cf15aae9..2e756bee1fa9 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -8,7 +8,7 @@
 # Uses the following environment variables:
 # SUBARCH, SRCARCH, srctree
 
-if [ "$KBUILD_VERBOSE" = "1" ]; then
+if [[ "$KBUILD_VERBOSE" =~ 1 ]]; then
 	set -x
 fi
 
-- 
2.34.1

