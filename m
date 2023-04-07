Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A856C6DAB56
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbjDGKQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjDGKQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:16:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C565493EA;
        Fri,  7 Apr 2023 03:16:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AC5864F13;
        Fri,  7 Apr 2023 10:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1803FC4339E;
        Fri,  7 Apr 2023 10:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680862600;
        bh=CKzFfekVaBNvU9m5gXHN+n1Z/uYMoDtKwhblrUGGlII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRrp1yO24AlnRDuPIVq6WBifDugBAX4NldgVCmGVHQ0GVCrgYk2spE6wlSIBFVTE7
         YEwgtU/VYoKcYI5wFQWHpq19+QqG7GsJ2yBV5ZyuNW1oZT5cJTyW0ab4Gz63kegS0W
         UQVm/2xbDcyno0ABSqUh87ju+087QkMj2IY5zbZN2pKf1EmqC4F5FGEf5T7wiNR/mr
         kEw3W4LlAv1hJ38+yTnuyzHI01w0mYMwd5HrarCL3fSujux+LC0M3SZPt70atR+u0H
         uFVXWUktlIKhzxb04dARYtFrwIN7vEUQ7wGmsME1D72RHtNwIkcVO0Ad5xZ40o3E6N
         euy3A8P6Blraw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 3/3] kbuild: do not create intermediate *.tar for tar packages
Date:   Fri,  7 Apr 2023 19:16:29 +0900
Message-Id: <20230407101629.1298051-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230407101629.1298051-1-masahiroy@kernel.org>
References: <20230407101629.1298051-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 05e96e96a315 ("kbuild: use git-archive for source package
creation") split the compression as a separate step to factor out
the common build rules.

With the previous commit, we got back to the situation where
compressed source tarballs are created by a single rule.
There is no reason to keep the separate compression rules.

Generate the comressed tar packages directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 7707975f729b..e0e18d7dfbd5 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -2,7 +2,6 @@
 # Makefile for the different targets used to generate full packages of a kernel
 
 include $(srctree)/scripts/Kbuild.include
-include $(srctree)/scripts/Makefile.lib
 
 KERNELPATH := kernel-$(subst -,_,$(KERNELRELEASE))
 KBUILD_PKG_ROOTCMD ?="fakeroot -u"
@@ -27,21 +26,6 @@ fi ; \
 tar -I $(KGZIP) -c $(RCS_TAR_IGNORE) -f $(2).tar.gz \
 	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3)
 
-# tarball compression
-# ---------------------------------------------------------------------------
-
-%.tar.gz: %.tar
-	$(call cmd,gzip)
-
-%.tar.bz2: %.tar
-	$(call cmd,bzip2)
-
-%.tar.xz: %.tar
-	$(call cmd,xzmisc)
-
-%.tar.zst: %.tar
-	$(call cmd,zstd)
-
 # Git
 # ---------------------------------------------------------------------------
 
@@ -153,10 +137,17 @@ tar-install: FORCE
 	$(Q)$(MAKE) -f $(srctree)/Makefile
 	+$(Q)$(srctree)/scripts/package/buildtar $@
 
+compress-tar.gz  = -I "$(KGZIP)"
+compress-tar.bz2 = -I "$(KBZIP2)"
+compress-tar.xz  = -I "$(XZ)"
+compress-tar.zst = -I "$(ZSTD)"
+
 quiet_cmd_tar = TAR     $@
-      cmd_tar = cd $<; tar cf ../$@ --owner=root --group=root --sort=name *
+      cmd_tar = cd $<; tar cf ../$@ $(compress-tar$(suffix $@)) --owner=root --group=root --sort=name *
+
+dir-tarballs := $(addprefix linux-$(KERNELRELEASE)-$(ARCH), .tar .tar.gz .tar.bz2 .tar.xz .tar.zst)
 
-linux-$(KERNELRELEASE)-$(ARCH).tar: tar-install
+$(dir-tarballs): tar-install
 	$(call cmd,tar)
 
 PHONY += dir-pkg
-- 
2.37.2

