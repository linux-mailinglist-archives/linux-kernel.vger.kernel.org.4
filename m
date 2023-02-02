Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A761268740B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjBBDk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjBBDjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:39:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99107BE52;
        Wed,  1 Feb 2023 19:38:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D47E619AB;
        Thu,  2 Feb 2023 03:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28117C433A1;
        Thu,  2 Feb 2023 03:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675309114;
        bh=JOstGkfwG8D5eh52wwoTtq8OkUqGBqYqmVGY1qdUjgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=arcnWMp7qxSPT3213lprYFMZ8g3ZRO/RMXCW+6sLDXTLfbJVWMsOTy3HrYfyK08La
         aqVYDAjD6qqMVrQFqdA81wQhu7+CB3Vj0f9OPn0JdShDjWQ+zL+Dbe5MsYlZ6NZhh5
         6ZvDuPuk5i6XJyVXp2SzxsFvF3aUQ/0jkJ6dkoeX5ZVoN2TnEmWj5hjjpHKRebEJ00
         Bapqokhe5WfJsiLuCknY1RAFjBaPlIdJYhoL7xjq/thdnKoqjQnZeBhKWkVMrzxX5A
         tOKjM00RdTXbQpmosGnsm6UvmcdpUzLTYOVGh4NopOMSMiKlBpzUnxa1PivuKBKTJp
         Lo2PrwLYOeblg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 5/6] kbuild: deb-pkg: hide KDEB_SOURCENAME from Makefile
Date:   Thu,  2 Feb 2023 12:37:15 +0900
Message-Id: <20230202033716.341858-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202033716.341858-1-masahiroy@kernel.org>
References: <20230202033716.341858-1-masahiroy@kernel.org>
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

(no changes since v3)

Changes in v3:
  - Move cmd_debianize

Changes in v2:
  - New patch

 scripts/Makefile.package | 23 +++++++++++++++--------
 scripts/package/mkdebian |  2 +-
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 6732632a0259..5135a5419a72 100644
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
@@ -80,17 +78,26 @@ binrpm-pkg:
 	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
 		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec
 
+quiet_cmd_debianize = GEN     $@
+      cmd_debianize = $(srctree)/scripts/package/mkdebian
+
+PHONY += debian
+debian:
+	$(call cmd,debianize)
+
+PHONY += debian-tarball
+debian-tarball: source = $(shell dpkg-parsechangelog -S Source)
+debian-tarball: orig-version = $(shell dpkg-parsechangelog -S Version | sed 's/-[^-]*$$//')
+debian-tarball: debian
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.package ../$(source)_$(orig-version).orig.tar.gz
+
 PHONY += deb-pkg
-deb-pkg:
-	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
-	$(Q)origversion=$$(dpkg-parsechangelog -SVersion |sed 's/-[^-]*$$//');\
-		$(MAKE) -f $(srctree)/scripts/Makefile.package ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
+deb-pkg: debian-tarball
 	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) \
 		--build=source,binary --source-option=-sP -nc -us -uc
 
 PHONY += bindeb-pkg
-bindeb-pkg:
-	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
+bindeb-pkg: debian
 	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) -b -nc -uc
 
 PHONY += intdeb-pkg
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 2f612617cbcf..0c1ed6215a02 100755
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

