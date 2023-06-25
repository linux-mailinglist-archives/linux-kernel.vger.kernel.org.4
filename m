Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93D773D145
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjFYOGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYOGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:06:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD11A1B1;
        Sun, 25 Jun 2023 07:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03F1E602E2;
        Sun, 25 Jun 2023 14:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F87C433C0;
        Sun, 25 Jun 2023 14:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687701999;
        bh=S3NHgH5zR4/XnZv9Sf+BiVy8WcLky1GXrScxBb3Sw4o=;
        h=From:To:Cc:Subject:Date:From;
        b=hR+Wy0YVxhHo8php6titEefdXjx1gFvxWnuNQ2CDek9qP7xqcXDn37IlecsY2msYL
         jkXNhtz9OlfCckR2GvVk86VSaIwzBturcRYHT8arRZpD0C/0z6PMmgKtZIEhDjdVQQ
         LhfU8lnolLSy30nXxUoBTbZP2jB4FjNhQrnrrl45tVEWSW66ZaUULokO9D/5U48oJT
         1BwlFtlc9IGSLPBdqLpdRwWB2+x8OpEdm4wDG7Xv1Yy9rq6MnUsfG9NOKJtgTS6b+u
         QISLl0aNzk+1KyyrMDpOuU6Ei6NUAHSn6mBIDdUa6tcqbQJpOEknnnlw+tN3BP4xXG
         6A5BBFwRKwUYQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v3 1/3] kbuild: unexport abs_srctree and abs_objtree
Date:   Sun, 25 Jun 2023 23:06:28 +0900
Message-Id: <20230625140630.2134298-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
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

'make rpm-pkg' builds the kernel in rpmbuild/BUILD, but $(abs_srctree)
and $(abs_objtree) point to the directory path where make was started,
not the kernel is actually being built. Fix it.

In hindsight, there was no need to export abs_srctree and abs_objtree.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v3:
 - New patch

 Makefile | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index f18d59c81241..6f9bbb0d9172 100644
--- a/Makefile
+++ b/Makefile
@@ -38,6 +38,10 @@ __all:
 # descending is started. They are now explicitly listed as the
 # prepare rule.
 
+this-makefile := $(lastword $(MAKEFILE_LIST))
+abs_srctree := $(realpath $(dir $(this-makefile)))
+abs_objtree := $(CURDIR)
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

