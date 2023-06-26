Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D0D73EF54
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 01:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjFZXae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 19:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjFZXa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC3C19A2;
        Mon, 26 Jun 2023 16:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AB0760FA2;
        Mon, 26 Jun 2023 23:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FEDC433CC;
        Mon, 26 Jun 2023 23:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687822223;
        bh=AkTW18VRFm3aTIK6VmGPviMroWucajIDz7AXevpDt4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fI2hZvtsgQcib8dtlCMxbdZzfe6K44XYN+DUS+FsUW64uLhr/otCBQXo7Y15Ofz2d
         UnEiosmv4Ws7w1c5jPTtoz8/7wlF3jPZfb4S1tUgrw+sm8dCLKmLE/czZbrPR/JuKY
         7xike14a+dtWTgrCDTSZyrbnAuJFZG78IaZRZdbn8Udi4rOjYQij2ROC7JSNGy/xdw
         ccPdhzZH2KB23DGWnYjY2N8kkMcCz/2ZsaD/DsD8Xc7ZlvCvehxYjoE5AAeT9yZCXU
         LijpBR437U82jckTyleFkWTVn4ZwKpIH/aMBlh10PiaNrq0ZSwRm3DCSeN3m6VM45P
         8ytF5BjzEV8/Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <n.schier@avm.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v4 3/3] kbuild: respect GNU Make -w flag
Date:   Tue, 27 Jun 2023 08:30:14 +0900
Message-Id: <20230626233014.66549-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626233014.66549-1-masahiroy@kernel.org>
References: <20230626233014.66549-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

If none of them is given, print "Entering directory ..." when Kbuild
changes the working directory at the start of building. (default)

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Tested-by: Nicolas Schier <n.schier@avm.de>
---

(no changes since v2)

Changes in v2:
  - new patch

 Makefile | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 7edb00603b7e..c9864f83a3d2 100644
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
 this-makefile := $(lastword $(MAKEFILE_LIST))
 export abs_srctree := $(realpath $(dir $(this-makefile)))
 export abs_objtree := $(CURDIR)
@@ -95,12 +101,6 @@ endif
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
@@ -215,12 +215,16 @@ else
 need-sub-make := 1
 endif
 
+ifeq ($(findstring w, $(short-opts)),)
 ifeq ($(filter --no-print-directory, $(MAKEFLAGS)),)
 # If --no-print-directory is unset, recurse once again to set it.
 # You may end up recursing into __sub-make twice. This is needed due to the
 # behavior change in GNU Make 4.4.1.
 need-sub-make := 1
 endif
+else
+no-print-directory :=
+endif
 
 ifeq ($(need-sub-make),1)
 
-- 
2.39.2

