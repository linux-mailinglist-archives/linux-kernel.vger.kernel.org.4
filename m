Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A699873EF51
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 01:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFZXa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 19:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjFZXaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764E9FB;
        Mon, 26 Jun 2023 16:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0208460F9D;
        Mon, 26 Jun 2023 23:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3914CC433C8;
        Mon, 26 Jun 2023 23:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687822220;
        bh=cjJsx6TjubpGMxRoEjJsSsu/4pIX4weGQrf/DhGnRwM=;
        h=From:To:Cc:Subject:Date:From;
        b=TxIfBg0wkRWHpL0I3cKAWbAYQvCwixUZRiHMJ5JvVbrGo3yea6cFyXZiT3cDkorn6
         6Wv/Fbyh3aiTqyAqDJCuJEwUybPSX9E4ryQdrKPyzzcOQCqWT8qr+EgQ7MaNVA9txD
         vOuS+ZxRar2p91fvXePl+2VVURM+oYIqPIeUhNh5Gu0PsR2x6fqXTzITteMcyH5lmA
         0D1W7ZD4PX9MwIk1ojtPGgWd7DnlYPgTkjKeAP3MWrlHuKu0jdHqlRhGzEAUmtW6vm
         hUA8JcZRhcq1w4evon/LoZN/Nco4NkRqXCo5KnbYBI5IbPkxoXl7C94xaZe4tGtTrZ
         couq/E4em9y+w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v4 1/3] kbuild: set correct abs_srctree and abs_objtree for package builds
Date:   Tue, 27 Jun 2023 08:30:12 +0900
Message-Id: <20230626233014.66549-1-masahiroy@kernel.org>
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

When you run 'make rpm-pkg', the rpmbuild tool builds the kernel in
rpmbuild/BUILD, but $(abs_srctree) and $(abs_objtree) point to the
directory path where make was started, not the kernel is actually
being built. The same applies to 'make snap-pkg'. Fix it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v4:
 - Export abs_{src,obj}tree again

Changes in v3:
 - New patch

 Makefile | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index f18d59c81241..70b314059d8b 100644
--- a/Makefile
+++ b/Makefile
@@ -38,6 +38,10 @@ __all:
 # descending is started. They are now explicitly listed as the
 # prepare rule.
 
+this-makefile := $(lastword $(MAKEFILE_LIST))
+export abs_srctree := $(realpath $(dir $(this-makefile)))
+export abs_objtree := $(CURDIR)
+
 ifneq ($(sub_make_done),1)
 
 # Do not use make's built-in rules and variables
@@ -185,8 +189,6 @@ $(if $(abs_objtree),, \
 
 # $(realpath ...) resolves symlinks
 abs_objtree := $(realpath $(abs_objtree))
-else
-abs_objtree := $(CURDIR)
 endif # ifneq ($(KBUILD_OUTPUT),)
 
 ifeq ($(abs_objtree),$(CURDIR))
@@ -196,9 +198,6 @@ else
 need-sub-make := 1
 endif
 
-this-makefile := $(lastword $(MAKEFILE_LIST))
-abs_srctree := $(realpath $(dir $(this-makefile)))
-
 ifneq ($(words $(subst :, ,$(abs_srctree))), 1)
 $(error source directory cannot contain spaces or colons)
 endif
@@ -211,7 +210,6 @@ need-sub-make := 1
 $(this-makefile): ;
 endif
 
-export abs_srctree abs_objtree
 export sub_make_done := 1
 
 ifeq ($(need-sub-make),1)
-- 
2.39.2

