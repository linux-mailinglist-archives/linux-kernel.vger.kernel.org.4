Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C2469738C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjBOBWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjBOBWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:22:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B9C34C12;
        Tue, 14 Feb 2023 17:21:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A83B86197C;
        Wed, 15 Feb 2023 01:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7EBC433D2;
        Wed, 15 Feb 2023 01:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676424112;
        bh=FeChVdeQN1bgxPs5mJTWw9fvEMDfbK6uQA/n72DiAws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qt+Wbrl84eyJmA99AQr0Rc42SzoZMETg5jj+aNK2ecAcg9UgANmfkOzMx0T2tyv65
         ocSizuZyPfTEP/xmMxWDl4W/eloh2O5XS3oa/CfxvSxMN84fBM9z6l6xl+ij6QN5Xi
         vec+W3pKT/qGSrjvDAUiSrpbiJ3X9xMHrxmiZ/+aizfmYChNr2NNGmOJ0PehTYDBIB
         4Kz3jnJiKsGyIt9z6zud54ybNgnKzhUW9ObsLR1Obon13/0gUN+DsA9x+L0/3al2IN
         9Tf54kcEwAQBueHHZJ7zsnk+Oe6pg1eFi/rKCd4xxYpIF9rbh8bXh7Dbjd9ZkKMJys
         ztUvcGsY3T/EQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v6 11/12] kbuild: deb-pkg: improve the usability of source package
Date:   Wed, 15 Feb 2023 10:20:33 +0900
Message-Id: <20230215012034.403356-11-masahiroy@kernel.org>
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

Improve the source package support in case the dpkg-buildpackage is
directly used to build binary packages.

For cross-compiling, you can set CROSS_COMPILE via the environment
variable, but it is better to set it automatically - set it to
${DEB_HOST_GNU_TYPE}- if we are cross-compiling but not from the top
Makefile.

The generated source package may be carried to a different build
environment, which may have a different compiler installed.
Run olddefconfig first to set new CONFIG options to their default
values without prompting.

Take KERNELRELEASE and KBUILD_BUILD_VERSION from the version field of
debian/changelog in case it is updated afterwards.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v6:
  - New patch

 scripts/package/deb-build-option | 16 ++++++++++++++++
 scripts/package/mkdebian         |  9 ++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)
 create mode 100755 scripts/package/deb-build-option

diff --git a/scripts/package/deb-build-option b/scripts/package/deb-build-option
new file mode 100755
index 000000000000..b079b0d121d4
--- /dev/null
+++ b/scripts/package/deb-build-option
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+
+# Set up CROSS_COMPILE if we are cross-compiling, but not called from the
+# kernel toplevel Makefile
+if [ -z "${CROSS_COMPILE}${cross_compiling}" -a "${DEB_HOST_ARCH}" != "${DEB_BUILD_ARCH}" ]; then
+	echo CROSS_COMPILE=${DEB_HOST_GNU_TYPE}-
+fi
+
+version=$(dpkg-parsechangelog -S Version)
+version_upstream="${version%-*}"
+debian_revision="${version#${version_upstream}}"
+debian_revision="${debian_revision#*-}"
+
+echo KERNELRELEASE=${version_upstream}
+echo KBUILD_BUILD_VERSION=${debian_revision}
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index eef20d5dc288..f74380036bb5 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -90,10 +90,8 @@ rm -rf debian
 version=$KERNELRELEASE
 if [ -n "$KDEB_PKGVERSION" ]; then
 	packageversion=$KDEB_PKGVERSION
-	revision=${packageversion##*-}
 else
-	revision=$($srctree/init/build-version)
-	packageversion=$version-$revision
+	packageversion=$version-$($srctree/init/build-version)
 fi
 sourcename=${KDEB_SOURCENAME:-linux-upstream}
 
@@ -244,8 +242,9 @@ srctree ?= .
 
 build-indep:
 build-arch:
-	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} \
-	KBUILD_BUILD_VERSION=${revision} -f \$(srctree)/Makefile
+	\$(MAKE) -f \$(srctree)/Makefile ARCH=${ARCH} \
+	\$(shell \$(srctree)/scripts/package/deb-build-option) \
+	olddefconfig all
 
 build: build-arch
 
-- 
2.34.1

