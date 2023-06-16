Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631AC73340B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345573AbjFPO6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345756AbjFPO6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:58:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BE930DD;
        Fri, 16 Jun 2023 07:57:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78B4B62FBB;
        Fri, 16 Jun 2023 14:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B3EC433CB;
        Fri, 16 Jun 2023 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686927478;
        bh=VEgG/e8fspM0F601IZYMqwpkaszvh+z+6C3I9ZOUdPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HO3j+fdwDlPrXg3XbH0O26oU15mWSLLDR2qPmFPbvajv34VOWB/sQQld0y23xbCj4
         L4wRcf90mHcgw8kYasEMrNj/YsZs3OY5IVbQIJ4amINKsobefTlLIzAhnn0kW25Xnj
         N9sNVT+BPpCmT45KGzy5arrBBufxwCI/KUi6+jR56gSeITKiaTRutVEaEhL0pqGFxO
         ymS2vKOVQ68AUMUmOPTxjJAQJfZ2u/IiSjByXYdA8qm0BcDxdh3qQtiv4QCwaV1Alr
         ji9EEm5AJaM3+RlaE1Yg7cG1qgKaRcQuE78JtWdZR6kSP4R2F8XDoICDL20szGiji5
         J52n7UFrx7XJQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 2/2] kbuild: respect GNU Make -w flag
Date:   Fri, 16 Jun 2023 23:57:51 +0900
Message-Id: <20230616145751.945864-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616145751.945864-1-masahiroy@kernel.org>
References: <20230616145751.945864-1-masahiroy@kernel.org>
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

Currently, -w (--print-directory) option is ignored, but it is better
to respect the user's choice.

This commit changes the behavior of "Entering directory ..." logging.

If -w (or --print-directory) is given via the command line or the
MAKEFLAGS environment variable, print "Entering directory ..." for every
sub make.

If --no-print-directory is given via the command line or the MAKEFLAGS
environment variable, suppress "Entering directory ..." completely.

If none of them is given, print "Entering directory ..." only when Kbuild
changes the working directory. (default)

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - new patch

 Makefile | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 916c1a7984b0..3867cdc3de5d 100644
--- a/Makefile
+++ b/Makefile
@@ -38,6 +38,12 @@ __all:
 # descending is started. They are now explicitly listed as the
 # prepare rule.
 
+ifeq ($(filter 3.%,$(MAKE_VERSION)),)
+short-opts := $(firstword -$(MAKEFLAGS))
+else
+short-opts := $(filter-out --%,$(MAKEFLAGS))
+endif
+
 ifneq ($(sub_make_done),1)
 
 # Do not use make's built-in rules and variables
@@ -91,12 +97,6 @@ endif
 # commands
 # make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
 
-ifeq ($(filter 3.%,$(MAKE_VERSION)),)
-short-opts := $(firstword -$(MAKEFLAGS))
-else
-short-opts := $(filter-out --%,$(MAKEFLAGS))
-endif
-
 ifneq ($(findstring s,$(short-opts)),)
 quiet=silent_
 override KBUILD_VERBOSE :=
@@ -217,12 +217,16 @@ else
 need-sub-make := 1
 endif
 
+ifeq ($(findstring w, $(short-opts)),)
 ifeq ($(filter --no-print-directory, $(MAKEFLAGS)),)
 # If --no-print-directory is unset, recurse once again to set it.
 # You may end up with recursing into __sub-make twice. This is due to the
 # behavior change for GNU Make 4.4.1.
 need-sub-make := 1
 endif
+else
+no-print-directory :=
+endif
 
 ifeq ($(need-sub-make),1)
 
-- 
2.39.2

