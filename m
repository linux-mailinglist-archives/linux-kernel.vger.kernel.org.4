Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A312D697383
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjBOBWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjBOBWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:22:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB9334C08;
        Tue, 14 Feb 2023 17:21:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB762B81F8F;
        Wed, 15 Feb 2023 01:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6CCC433A0;
        Wed, 15 Feb 2023 01:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676424104;
        bh=1ifncx4mS+h9vwXHr2C/Xo2uXi8XsaHG4mWZBULRw1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XtQoInXqwBBDqL5I5+ZdSX1wJAP66Af55RnkhqvPKRs2BxZyd4v56MJUN/onpbptt
         mp1flP19iQ/ANlIUuocu9BC1yPnSTiw/c6VkJPcIFn8LFRl2Du6SfXb8PujfxMVQ9T
         Sp6djTtBF39C9uHv1Gk2icPhAkugamAKnlZSDw8Afm4NqHwo76zgYq058yYuSiQNWr
         Uca0cLwmw4V2n+Eo/QJl0GqEsFoOxDnMx6ZrBh/8qMoSwRZaaSQSnJl8/SRa8PUp/u
         frMO7YWv4UabEq4FGtnIO6t57Rxut89k8WmdPDt7TdvvVglvs0ebH288PypFNVhVBy
         GP7KnJWdhBEnw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v6 07/12] kbuild: deb-pkg: switch over to source format 3.0 (quilt)
Date:   Wed, 15 Feb 2023 10:20:29 +0900
Message-Id: <20230215012034.403356-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230215012034.403356-1-masahiroy@kernel.org>
References: <20230215012034.403356-1-masahiroy@kernel.org>
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

Change the source format from "1.0" to "3.0 (quilt)" because it works
more cleanly.

All files except .config and debian/ go into the orig tarball.
Add a single patch, debian/patches/config, and delete the ugly
extend-diff-ignore patterns.

The debian tarball will be compressed into *.debian.tar.xz by default.
If you like to use a different compression mode, you can pass the
command line option, DPKG_FLAGS=-Zgzip, for example.

The orig tarball only supports gzip for now. The combination of
gzip and xz is somewhat clumsy, but it is not a practical problem.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v6:
  - Fix error when KCONFIG_CONFIG is set

Changes in v4:
  - New patch

 scripts/Makefile.package |  2 +-
 scripts/package/mkdebian | 41 ++++++++++++++++++----------------------
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 80a96eb61426..5538deacb136 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -105,7 +105,7 @@ debian-orig: linux.tar.gz debian
 PHONY += deb-pkg
 deb-pkg: debian-orig
 	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) \
-		--build=source,binary --source-option=-sP -nc -us -uc
+		--build=source,binary -nc -us -uc
 
 PHONY += bindeb-pkg
 bindeb-pkg: debian
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 534e9713761a..22fc73a5e4f2 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -135,29 +135,24 @@ else
 fi
 
 mkdir -p debian/source/
-echo "1.0" > debian/source/format
-
-# Ugly: ignore anything except .config or debian/
-cat<<'EOF' > debian/source/local-options
-diff-ignore
-
-extend-diff-ignore = ^[^.d]
-
-extend-diff-ignore = ^\.[^c]
-extend-diff-ignore = ^\.c($|[^o])
-extend-diff-ignore = ^\.co($|[^n])
-extend-diff-ignore = ^\.con($|[^f])
-extend-diff-ignore = ^\.conf($|[^i])
-extend-diff-ignore = ^\.confi($|[^g])
-extend-diff-ignore = ^\.config.
-
-extend-diff-ignore = ^d($|[^e])
-extend-diff-ignore = ^de($|[^b])
-extend-diff-ignore = ^deb($|[^i])
-extend-diff-ignore = ^debi($|[^a])
-extend-diff-ignore = ^debia($|[^n])
-extend-diff-ignore = ^debian[^/]
-EOF
+echo "3.0 (quilt)" > debian/source/format
+
+{
+	echo "diff-ignore"
+	echo "extend-diff-ignore = .*"
+} > debian/source/local-options
+
+# Add .config as a patch
+mkdir -p debian/patches
+{
+	echo "Subject: Add .config"
+	echo "Author: ${maintainer}"
+	echo
+	echo "--- /dev/null"
+	echo "+++ linux/.config"
+	diff -u /dev/null "${KCONFIG_CONFIG}" | tail -n +3
+} > debian/patches/config
+echo config > debian/patches/series
 
 echo $debarch > debian/arch
 extra_build_depends=", $(if_enabled_echo CONFIG_UNWINDER_ORC libelf-dev:native)"
-- 
2.34.1

