Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A675B72AD28
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjFJQSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 12:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjFJQR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 12:17:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31E5421B;
        Sat, 10 Jun 2023 09:17:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF2A4619AC;
        Sat, 10 Jun 2023 16:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DE7C433EF;
        Sat, 10 Jun 2023 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686413841;
        bh=cwe7A4zfkcXQUnvweZ3lV0jtq7ys0o2b40JuaMCUZYk=;
        h=From:To:Cc:Subject:Date:From;
        b=H0TwLYCx+bx5rIb7tEOz5QGFcHy15y6S8G6ZQXDqhPCxWs8aXWCzcVrJsQI8EZIFn
         thw3DEr+JxdSWB0VhwMoID70sdPb3UP1h2xPfQmjyOR6x0HkBY1W2Nj2kXg9lFJ67Q
         8jk0eAOmK4dxQarOrugv/bLx3/DxIk1d1+uJZEqNrIHfXrKMqPfUKoy/1GBKWz9h0E
         nnRxGJtj9UAn6WcHCRFjeJvfa6caQETOjsFotcsB01tweLQHzWiSq+v/9DOl7q3qjZ
         bOWuN9rPvLny+337PjWCGANemEm8HolcO5bP4fc12UF+ifXwOABjXgU1jY5ecrhbai
         OI7oj510jkN8A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: revive "Entering directory" for Make >= 4.4.1
Date:   Sun, 11 Jun 2023 01:17:11 +0900
Message-Id: <20230610161711.1094231-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
GNU Make 4.4.1.

The behavior was changed by GNU Make commit 8f9e7722ff0f ("[SV 63537]
Fix setting -w in makefiles"). Previously, setting --no-print-directory
to MAKEFLAGS only affected child makes, but it is now interpreted in
the current make as soon as it is set.

[test code]

  $ cat /tmp/Makefile
  MAKEFLAGS += --no-print-directory
  all: ; :

[before 8f9e7722ff0f]

  $ make -C /tmp
  make: Entering directory '/tmp'
  :
  make: Leaving directory '/tmp'

[after 8f9e7722ff0f]

  $ make -C /tmp
  :

This commit restores the previous behavior for GNU Make >= 4.4.1.

Reported-by: David Howells <dhowells@redhat.com>
Closes: https://lore.kernel.org/all/2427604.1686237298@warthog.procyon.org.uk/
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index cc3fe09c4dec..9868186deb66 100644
--- a/Makefile
+++ b/Makefile
@@ -191,7 +191,7 @@ endif # ifneq ($(KBUILD_OUTPUT),)
 
 ifeq ($(abs_objtree),$(CURDIR))
 # Suppress "Entering directory ..." unless we are changing the work directory.
-MAKEFLAGS += --no-print-directory
+no-print-directory := --no-print-directory
 else
 need-sub-make := 1
 endif
@@ -203,6 +203,15 @@ ifneq ($(words $(subst :, ,$(abs_srctree))), 1)
 $(error source directory cannot contain spaces or colons)
 endif
 
+ifneq ($(filter jobserver-fifo,$(.FEATURES)),) # test $(MAKE_VERSION) >= 4.4
+ifeq ($(filter 4.4,$(MAKE_VERSION)),)
+# With GNU Make >= 4.4.1, a change in MAKEFLAGS takes effect as soon as it is
+# set. Run __sub-make all the time so that we can pass --no-print-directory
+# via the command line.
+need-sub-make := 1
+endif
+endif
+
 ifneq ($(filter 3.%,$(MAKE_VERSION)),)
 # 'MAKEFLAGS += -rR' does not immediately become effective for GNU Make 3.x
 # We need to invoke sub-make to avoid implicit rules in the top Makefile.
@@ -223,7 +232,8 @@ $(filter-out $(this-makefile), $(MAKECMDGOALS)) __all: __sub-make
 
 # Invoke a second make in the output directory, passing relevant variables
 __sub-make:
-	$(Q)$(MAKE) -C $(abs_objtree) -f $(abs_srctree)/Makefile $(MAKECMDGOALS)
+	$(Q)$(MAKE) $(no-print-directory) -C $(abs_objtree) \
+	-f $(abs_srctree)/Makefile $(MAKECMDGOALS)
 
 endif # need-sub-make
 endif # sub_make_done
@@ -234,6 +244,8 @@ ifeq ($(need-sub-make),)
 # Do not print "Entering directory ...",
 # but we want to display it when entering to the output directory
 # so that IDEs/editors are able to understand relative filenames.
+# This line is needed to allow Make < 4.4.1 to skip __sub-make.
+# The newer Make versions runs __sub-make before seeing this line.
 MAKEFLAGS += --no-print-directory
 
 ifeq ($(abs_srctree),$(abs_objtree))
-- 
2.39.2

