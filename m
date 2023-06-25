Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA1B73D149
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjFYOGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjFYOGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926731B1;
        Sun, 25 Jun 2023 07:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2941660A27;
        Sun, 25 Jun 2023 14:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1316C433CB;
        Sun, 25 Jun 2023 14:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687702001;
        bh=dvDrQ39eJfUmS1xCtZGwDsgxhBGFWLRiRVbAAdfWTdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GwUmkGw+0aF6chF4Gmy+8AeX27Kr2v8Zaqr1xwUTNzD0x/4jETPVJ8WA+YHYlevTc
         4zQJy/x3NvnTVr5HQWl04sOU2AlvXw5l7oVqcihvXGDAUNgrMpHwWX9mNG3oGbeRcO
         skkpyeYAhT5zPQthghkWftQ9qvlZxPHJw/dCIr0HanHhqxVxL+JwdKuz0THOKGTath
         cy7MIU0h7K65twvaEnHryArMZOflQwbjXEEhVQl5BBseBwWOKbZUEHLD6EN0p2heAR
         v+LnsYzx4BHeJUlWcXvR/bud/365Wr1acswMHy7gjoirBREc63QSF7afTj8Xc4vf6O
         jU0j/iH11jouQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Nicolas Schier <n.schier@avm.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v3 2/3] kbuild: revive "Entering directory" for Make >= 4.4.1
Date:   Sun, 25 Jun 2023 23:06:29 +0900
Message-Id: <20230625140630.2134298-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230625140630.2134298-1-masahiroy@kernel.org>
References: <20230625140630.2134298-1-masahiroy@kernel.org>
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

With commit 9da0763bdd82 ("kbuild: Use relative path when building in
a subdir of the source tree"), compiler messages in out-of-tree builds
include relative paths, which are relative to the build directory, not
the directory where make was started.

To help IDEs/editors find the source files, Kbuild lets GNU Make print
"Entering directory ..." when it changes the working directory. It has
been working fine for a long time, but David reported it is broken with
the latest GNU Make.

The behavior was changed by GNU Make commit 8f9e7722ff0f ("[SV 63537]
Fix setting -w in makefiles"). Previously, setting --no-print-directory
to MAKEFLAGS only affected child makes, but it is now interpreted in
the current make as soon as it is set.

[test code]

  $ cat /tmp/Makefile
  ifneq ($(SUBMAKE),1)
  MAKEFLAGS += --no-print-directory
  all: ; $(MAKE) SUBMAKE=1
  else
  all: ; :
  endif

[before 8f9e7722ff0f]

  $ make -C /tmp
  make: Entering directory '/tmp'
  make SUBMAKE=1
  :
  make: Leaving directory '/tmp'

[after 8f9e7722ff0f]

  $ make -C /tmp
  make SUBMAKE=1
  :

Previously, the effect of --no-print-directory was delayed until Kbuild
started the directory descending, but it is no longer true with GNU Make
4.4.1.

This commit adds one more recursion to cater to GNU Make >= 4.4.1.

When Kbuild needs to change the working directory, __submake will be
executed twice.

  __submake without --no-print-directory  --> show "Entering directory ..."
  __submake with    --no-print-directory  --> parse the rest of Makefile

We end up with one more recursion than needed for GNU Make < 4.4.1, but
I do not want to complicate the version check.

Reported-by: David Howells <dhowells@redhat.com>
Closes: https://lore.kernel.org/all/2427604.1686237298@warthog.procyon.org.uk/
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Tested-by: Nicolas Schier <n.schier@avm.de>
---

Changes in v3:
  - Fix build breakage of 'make rpm-pkg'.

Changes in v2:
  - Fix the code. V1 did not work.
  - Remove the version check to simplify the code

 Makefile | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index 6f9bbb0d9172..0663c99e050b 100644
--- a/Makefile
+++ b/Makefile
@@ -191,13 +191,6 @@ $(if $(abs_objtree),, \
 abs_objtree := $(realpath $(abs_objtree))
 endif # ifneq ($(KBUILD_OUTPUT),)
 
-ifeq ($(abs_objtree),$(CURDIR))
-# Suppress "Entering directory ..." unless we are changing the work directory.
-MAKEFLAGS += --no-print-directory
-else
-need-sub-make := 1
-endif
-
 ifneq ($(words $(subst :, ,$(abs_srctree))), 1)
 $(error source directory cannot contain spaces or colons)
 endif
@@ -212,6 +205,23 @@ endif
 
 export sub_make_done := 1
 
+endif # sub_make_done
+
+ifeq ($(abs_objtree),$(CURDIR))
+# Suppress "Entering directory ..." if we are at the final work directory.
+no-print-directory := --no-print-directory
+else
+# Recursion to show "Entering directory ..."
+need-sub-make := 1
+endif
+
+ifeq ($(filter --no-print-directory, $(MAKEFLAGS)),)
+# If --no-print-directory is unset, recurse once again to set it.
+# You may end up recursing into __sub-make twice. This is needed due to the
+# behavior change in GNU Make 4.4.1.
+need-sub-make := 1
+endif
+
 ifeq ($(need-sub-make),1)
 
 PHONY += $(MAKECMDGOALS) __sub-make
@@ -221,18 +231,12 @@ $(filter-out $(this-makefile), $(MAKECMDGOALS)) __all: __sub-make
 
 # Invoke a second make in the output directory, passing relevant variables
 __sub-make:
-	$(Q)$(MAKE) -C $(abs_objtree) -f $(abs_srctree)/Makefile $(MAKECMDGOALS)
+	$(Q)$(MAKE) $(no-print-directory) -C $(abs_objtree) \
+	-f $(abs_srctree)/Makefile $(MAKECMDGOALS)
 
-endif # need-sub-make
-endif # sub_make_done
+else # need-sub-make
 
 # We process the rest of the Makefile if this is the final invocation of make
-ifeq ($(need-sub-make),)
-
-# Do not print "Entering directory ...",
-# but we want to display it when entering to the output directory
-# so that IDEs/editors are able to understand relative filenames.
-MAKEFLAGS += --no-print-directory
 
 ifeq ($(abs_srctree),$(abs_objtree))
         # building in the source tree
-- 
2.39.2

