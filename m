Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE9565451A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiLVQ0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbiLVQZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:25:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A5A26483;
        Thu, 22 Dec 2022 08:25:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E461961C77;
        Thu, 22 Dec 2022 16:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713BEC433D2;
        Thu, 22 Dec 2022 16:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671726351;
        bh=zg5ZJ/EbLX+RoxMOBFp+SM0c2VmypEvqfO24sgs0ND8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJ2BDphH6cGrLtbzGnYPbm37UBM2wisB026VX3/LtrACdusis4wlETid6Fo7voOdL
         07zm0jgqVVWrukJSZdcqihQavTUKhquqq3nVy1XzWqkto+hg0XcFhLT9XbqVLj/tcI
         7mE0CBasXzONnoAtWdBnWPMXh3+zHB4Qpz1dfKPTcEvSvmsWpNBXDG1jOgt1Avf+qd
         AVNxi2/quR3aqMQNPJjp6em4uC4BWpNRVGccmYlLZHLrYmUqCH1076l3AgS+BfHZmy
         Kj3nZHmaMy7C3vzz3NFk7prIzH2mON28giy3yOFb/42pvYKXi8QjVQNQOx8ro77ux/
         S/u4ZSlTwv5ww==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, linux-doc@vger.kernel.org
Subject: [PATCH 5/5] kbuild: drop V=0 support
Date:   Fri, 23 Dec 2022 01:25:35 +0900
Message-Id: <20221222162535.1578462-5-masahiroy@kernel.org>
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

The top Makefile sets KBUILD_VERBOSE to 0 by default, it looks weird
now because V=1 and V=2 can be OR'ed as V=12. The default should be
empty.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/kbuild/makefiles.rst | 4 ++--
 Makefile                           | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 6b7368d1f516..59085ffbe99a 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -523,7 +523,7 @@ more details, with real examples.
 			$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
 			@$(kecho) '  Kernel: $(boot)/$@ is ready'
 
-	When kbuild is executing with KBUILD_VERBOSE=0, then only a shorthand
+	When kbuild is executing with KBUILD_VERBOSE unset, then only a shorthand
 	of a command is normally displayed.
 	To enable this behaviour for custom commands kbuild requires
 	two variables to be set::
@@ -544,7 +544,7 @@ more details, with real examples.
 
 		  GEN     lib/crc32table.h
 
-	will be displayed with "make KBUILD_VERBOSE=0".
+	will be displayed with "make KBUILD_VERBOSE=".
 
 3.12 Command change detection
 -----------------------------
diff --git a/Makefile b/Makefile
index bd69bf73a256..99cb8c9de53a 100644
--- a/Makefile
+++ b/Makefile
@@ -78,9 +78,6 @@ unexport GREP_OPTIONS
 ifeq ("$(origin V)", "command line")
   KBUILD_VERBOSE = $(V)
 endif
-ifndef KBUILD_VERBOSE
-  KBUILD_VERBOSE = 0
-endif
 
 quiet = quiet_
 Q = @
@@ -102,7 +99,7 @@ endif
 
 ifneq ($(findstring s,$(short-opts)),)
 quiet=silent_
-KBUILD_VERBOSE = 0
+override KBUILD_VERBOSE :=
 endif
 
 export quiet Q KBUILD_VERBOSE
@@ -1761,7 +1758,7 @@ help:
 		printf "  %-16s - Show all of the above\\n" help-boards; \
 		echo '')
 
-	@echo  '  make V=n   [targets] 0: quiet build (default), 1: verbose build'
+	@echo  '  make V=n   [targets] 1: verbose build'
 	@echo  '                       2: give reason for rebuild of target'
 	@echo  '                       V=1 and V=2 can be combined with V=12'
 	@echo  '  make O=dir [targets] Locate all output files in "dir", including .config'
-- 
2.34.1

