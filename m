Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B7D69738D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjBOBW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjBOBWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:22:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B1B3345A;
        Tue, 14 Feb 2023 17:21:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C72E6198D;
        Wed, 15 Feb 2023 01:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8428FC4339B;
        Wed, 15 Feb 2023 01:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676424113;
        bh=3R0g8mH0HfVeY9FreGkKJ/GZs7e+F2BbvGb/IvPgPy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D48JCem6bygp0I6spR8PbF1EHyZyFI1QA8uihjpdnRla/umK2r2AQKWIOL+OUlkyg
         /Ym5JV1JbC+rVTGMNgWF1cNQSkxio2fXpXC/RabTQ0yjetzAWsuRrTgw9Wkfui3goI
         AhyEXZB+tW701Oq5pO48CMnkU6wVyStlWWQt6MM7S4e3CVofMVk8fqcqbWWn/SrmJ8
         64UV7VFJt6gUnWTgeqGaVe9NObLL98VRQZF06F4kkGCT7SfpB+rCrv1SFCTJHOcdZd
         erCACdaLNtT56XUADTUlZcMth0LHEv6ecKlZLYtdVDRUyqvsMBjp2/y0nIKyjymxTr
         G+SwMQa21l3WQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v6 12/12] kbuild: add srcdeb-pkg target
Date:   Wed, 15 Feb 2023 10:20:34 +0900
Message-Id: <20230215012034.403356-12-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230215012034.403356-1-masahiroy@kernel.org>
References: <20230215012034.403356-1-masahiroy@kernel.org>
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

This new target builds only the debian source package.

Factor similar code out to the 'build-deb-pkg' variable.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v6:
  - New patch

 scripts/Makefile.package | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index b941e6341b36..8650d9432c26 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -100,6 +100,9 @@ binrpm-pkg:
 	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
 		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec
 
+# deb-pkg srcdeb-pkg bindeb-pkg
+# ---------------------------------------------------------------------------
+
 quiet_cmd_debianize = GEN     $@
       cmd_debianize = $(srctree)/scripts/package/mkdebian
 
@@ -117,14 +120,27 @@ debian-orig: linux.tar.gz debian
 		cp $< ../$(orig-name); \
 	fi
 
+build-deb-pkg = \
+        dpkg-buildpackage \
+        --build=$(build-type) --no-pre-clean --unsigned-changes \
+        $(if $(findstring source, $(build-type)), --unsigned-source) \
+        $(if $(findstring binary, $(build-type)), -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch)) \
+        $(DPKG_FLAGS)
+
 PHONY += deb-pkg
+deb-pkg: private build-type := source,binary
 deb-pkg: debian-orig
-	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) \
-		--build=source,binary -nc -us -uc
+	+$(build-deb-pkg)
+
+PHONY += srcdeb-pkg
+srcdeb-pkg: private build-type := source
+srcdeb-pkg: debian-orig
+	+$(build-deb-pkg)
 
 PHONY += bindeb-pkg
+bindeb-pkg: private build-type := binary
 bindeb-pkg: debian
-	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) -b -nc -uc
+	+$(build-deb-pkg)
 
 PHONY += intdeb-pkg
 intdeb-pkg:
@@ -225,6 +241,7 @@ help:
 	@echo '  srcrpm-pkg          - Build only the source kernel RPM package'
 	@echo '  binrpm-pkg          - Build only the binary kernel RPM package'
 	@echo '  deb-pkg             - Build both source and binary deb kernel packages'
+	@echo '  binsrc-pkg          - Build only the source kernel deb package'
 	@echo '  bindeb-pkg          - Build only the binary kernel deb package'
 	@echo '  snap-pkg            - Build only the binary kernel snap package'
 	@echo '                        (will connect to external hosts)'
-- 
2.34.1

