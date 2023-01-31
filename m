Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E0E68328C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjAaQ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjAaQ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:27:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFE056196;
        Tue, 31 Jan 2023 08:27:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32538B81DAE;
        Tue, 31 Jan 2023 16:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DE8C433A4;
        Tue, 31 Jan 2023 16:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675182449;
        bh=g/PguSDXjg6VLI4lh9MpBwOaQPS/+vjk/LM6FEYEX3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6G7SP2S/BdD/6qKiVdYXuTw3I5yjQjR3bEONpTev0/P/WY3nK/iUqJtRalNKQCu+
         EUcsQDSvQCmeZCNF17SOxjfGCNaGJPxwKnS0NKQRJX6Yqui/ThcFNsrbuOQjyl6L0t
         ZPJAoNw3R7HgPE4KMYsYzh4/yIWihJaNzNLefvJFD6DhvSU7MpSTrnt6aeQidq3KCw
         ZrzbF9M5YVoKHd67hDNRJASZ+zekkjdxx0Vcg2a31jkaQmKYqr+wzK+Ot1sqeWbtXQ
         gjAQBqWps4OhScvie1n/Y4/10z7iunHwrj66HCxoZ+IZJUPcr8NaBlHSfUuVXDsCfW
         /G3snRZk6ComA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v3 5/5] kbuild: deb-pkg: hide KDEB_SOURCENAME from Makefile
Date:   Wed,  1 Feb 2023 01:26:15 +0900
Message-Id: <20230131162615.1575215-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131162615.1575215-1-masahiroy@kernel.org>
References: <20230131162615.1575215-1-masahiroy@kernel.org>
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

scripts/Makefile.package does not need to know the value of
KDEB_SOURCENAME because the source name can be taken from
debian/changelog by using dpkg-parsechangelog.

Move the default of KDEB_SOURCENAME (i.e. linux-upstream) to
scripts/package/mkdebian.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v2)

Changes in v2:
  - New patch

 scripts/Makefile.package | 23 +++++++++++++++--------
 scripts/package/mkdebian |  2 +-
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 1383160d0eee..677692b9c74c 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -3,9 +3,7 @@
 
 include $(srctree)/scripts/Kbuild.include
 
-KDEB_SOURCENAME ?= linux-upstream
 KBUILD_PKG_ROOTCMD ?="fakeroot -u"
-export KDEB_SOURCENAME
 MKSPEC     := $(srctree)/scripts/package/mkspec
 
 # Source Tarball
@@ -59,19 +57,28 @@ binrpm-pkg:
 	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
 		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec
 
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
 
+quiet_cmd_debianize = GEN     $@
+      cmd_debianize = $(srctree)/scripts/package/mkdebian
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

