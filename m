Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F1F692538
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjBJSTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjBJSS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:18:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164D15DC0C;
        Fri, 10 Feb 2023 10:18:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB163B825A9;
        Fri, 10 Feb 2023 18:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5430C433D2;
        Fri, 10 Feb 2023 18:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676053124;
        bh=qGlkzx4kts7v08dgnhKLSWrqXLO9a0rN1+g/GlO6Wr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQjeMU5RMEO6p4sBNGm7WyCDrChwYmHd1BAZ3BjbRYWvYOZENCNGc319TUJGwZt0Q
         Cr32jFChEwdvhy+tCo+0ispSPJ85Xi+kHD7Jm/YZzxIwrBYB49oZirBixE/VTboOym
         rWvhWTpwQnXjLV6Wb1OJTKvB8JASqzPaCzYUzfkWGcwGv0ts5XZj3zhe4kl0wjK9qZ
         YC7wgemv9EM2RqlSZNN4gdG5vHoPVcjwTcl8RhcmEC7rKh2CublwwShlD3sT3aWXAD
         P0PX8yc4lIuJfxF8a6MvjZH/WeerqFWOkGwZ0UPrimFaL0JorFicPSSL8gF0rszcWO
         rtCBodF6MHOSQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v5 5/7] kbuild: deb-pkg: hide KDEB_SOURCENAME from Makefile
Date:   Sat, 11 Feb 2023 03:18:26 +0900
Message-Id: <20230210181828.124765-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210181828.124765-1-masahiroy@kernel.org>
References: <20230210181828.124765-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/Makefile.package does not need to know the value of
KDEB_SOURCENAME because the source name can be taken from
debian/changelog by using dpkg-parsechangelog.

Move the default of KDEB_SOURCENAME (i.e. linux-upstream) to
scripts/package/mkdebian.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v5:
  - Copy linux.tar.gz to .orig tarball

Changes in v3:
  - Move cmd_debianize

Changes in v2:
  - New patch

 scripts/Makefile.package | 22 ++++++++++++++--------
 scripts/package/mkdebian |  2 +-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 39f67f876092..b591f036e63f 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -4,9 +4,7 @@
 include $(srctree)/scripts/Kbuild.include
 
 KERNELPATH := kernel-$(subst -,_,$(KERNELRELEASE))
-KDEB_SOURCENAME ?= linux-upstream
 KBUILD_PKG_ROOTCMD ?="fakeroot -u"
-export KDEB_SOURCENAME
 # Include only those top-level files that are needed by make, plus the GPL copy
 TAR_CONTENT := Documentation LICENSES arch block certs crypto drivers fs \
                include init io_uring ipc kernel lib mm net rust \
@@ -54,17 +52,25 @@ binrpm-pkg:
 	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
 		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec
 
+quiet_cmd_debianize = GEN     $@
+      cmd_debianize = $(srctree)/scripts/package/mkdebian
+
+debian: FORCE
+	$(call cmd,debianize)
+
+PHONY += debian-orig
+debian-orig: private source = $(shell dpkg-parsechangelog -S Source)
+debian-orig: private version = $(shell dpkg-parsechangelog -S Version | sed 's/-[^-]*$$//')
+debian-orig: linux.tar.gz debian
+	$(Q)cp $< ../$(source)_$(version).orig.tar.gz
+
 PHONY += deb-pkg
-deb-pkg: linux.tar.gz
-	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
-	$(Q)origversion=$$(dpkg-parsechangelog -SVersion |sed 's/-[^-]*$$//');\
-		cp linux.tar.gz ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
+deb-pkg: debian-orig
 	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) \
 		--build=source,binary --source-option=-sP -nc -us -uc
 
 PHONY += bindeb-pkg
-bindeb-pkg:
-	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
+bindeb-pkg: debian
 	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) -b -nc -uc
 
 PHONY += intdeb-pkg
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 68b13ef590ba..534e9713761a 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -95,7 +95,7 @@ else
 	revision=$($srctree/init/build-version)
 	packageversion=$version-$revision
 fi
-sourcename=$KDEB_SOURCENAME
+sourcename=${KDEB_SOURCENAME:-linux-upstream}
 
 if [ "$ARCH" = "um" ] ; then
 	packagename=user-mode-linux
-- 
2.34.1

