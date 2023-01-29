Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A246800E7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 19:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbjA2Sq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 13:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbjA2SqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 13:46:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B01F938;
        Sun, 29 Jan 2023 10:46:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E53C660DF4;
        Sun, 29 Jan 2023 18:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F0AC433A1;
        Sun, 29 Jan 2023 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675017978;
        bh=Am7o6h7aD81CH6Z4Tu70SMeW1u4ly7ixefRGPzQn4rI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ka4Up4KM2UEEgzcvL+y48WEo+e0g5mwoSyayb3OYFFE1fbvrmMOhyJ2zIbFILcbcH
         ApplZwVbHVC+e7BNLBCtTQvtHGDwYwdIhvP0KMcrospvA0fQrm/HvCGiGprWbdlneJ
         dynWUVHutF9GaOtOF6QLC6ppgi73FTHEs9f3OfeJCtJ5eavNViBjIgg0jwV+ro5OnD
         2oijWszMaeBFj+0DHtSQD+/38xmRvq8mE8rv+bJ9kLBcVUDvsKIpJ8UFgHqqpE4KRF
         2LmEegbXkrX/sGc9e68n5Dfzzer4ZFhfrCZY/lc13BgGA9EsUvVfGsY9b52T0Zev7q
         4aqHY66xtA9OA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 5/5] kbuild: deb-pkg: hide KDEB_SOURCENAME from Makefile
Date:   Mon, 30 Jan 2023 03:46:02 +0900
Message-Id: <20230129184602.3974058-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230129184602.3974058-1-masahiroy@kernel.org>
References: <20230129184602.3974058-1-masahiroy@kernel.org>
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

Changes in v2:
 - New patch

 scripts/Makefile.package | 23 +++++++++++++++--------
 scripts/package/mkdebian |  2 +-
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 0e16ecfddad6..2ee39e0f24ee 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -3,9 +3,7 @@
 
 include $(srctree)/scripts/Kbuild.include
 
-KDEB_SOURCENAME ?= linux-upstream
 KBUILD_PKG_ROOTCMD ?="fakeroot -u"
-export KDEB_SOURCENAME
 MKSPEC     := $(srctree)/scripts/package/mkspec
 
 # Source Tarball
@@ -52,19 +50,28 @@ binrpm-pkg:
 	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
 		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec
 
+# deb-pkg, bindeb-pkg
+# ---------------------------------------------------------------------------
+
 PHONY += deb-pkg
-deb-pkg:
-	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
-	$(Q)origversion=$$(dpkg-parsechangelog -SVersion |sed 's/-[^-]*$$//');\
-		$(MAKE) -f $(srctree)/scripts/Makefile.package ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
+deb-pkg: source = $(shell dpkg-parsechangelog -S Source)
+deb-pkg: orig-version = $(shell dpkg-parsechangelog -S Version | sed 's/-[^-]*$$//')
+deb-pkg: debian
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.package ../$(source)_$(orig-version).orig.tar.gz
 	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) \
 		--build=source,binary --source-option=-sP -nc -us -uc
 
 PHONY += bindeb-pkg
-bindeb-pkg:
-	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
+bindeb-pkg: debian
 	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) -b -nc -uc
 
+quiet_cmd_debianize = GEN     $@
+      cmd_debianize = $(srctree)/scripts/package/mkdebian
+
+PHONY += debian
+debian:
+	$(call cmd,debianize)
+
 PHONY += intdeb-pkg
 intdeb-pkg:
 	+$(CONFIG_SHELL) $(srctree)/scripts/package/builddeb
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

