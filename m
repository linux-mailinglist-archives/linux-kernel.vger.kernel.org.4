Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F304692537
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjBJSTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjBJSS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:18:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C66268AE5;
        Fri, 10 Feb 2023 10:18:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1627D61E00;
        Fri, 10 Feb 2023 18:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1021C4339B;
        Fri, 10 Feb 2023 18:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676053126;
        bh=S9ku+PHQJhdA2T48EMJ9NZiif3Y3/eyMvf3hs1erLEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qiFF5L/RQYnfZjXuON5e0fb60QBvxGtAiCo7SuOvKohv4hCBzj0mk0H95sYKCiTkM
         GvRtJ6GsFZAjTEBhVKSfRuLgHImaGKEIC+5KfRHbHzESw1KFweNvAjWbKojVG1cQ/L
         20WndPp2vEiGPfsKls86YzxoAxfMiW8KquBvQAJgmyJMNfByft0Vp8iQK4nVRxDu3P
         yRqsRJdPA+K0ZJZ+h0BBr2pBrOs4CiwG5zVwcRT37i39g+/a9SJGpfTcUtTSoNGl3u
         KpZIt0mPDpP7i0gWXgu8IUYo41S3UN5epj3sD0T3CYUvKma8aZVlCY3mgFMMzieVb3
         CTFqnDLkykH1Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v5 6/7] kbuild: deb-pkg: switch over to source format 3.0 (quilt)
Date:   Sat, 11 Feb 2023 03:18:27 +0900
Message-Id: <20230210181828.124765-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210181828.124765-1-masahiroy@kernel.org>
References: <20230210181828.124765-1-masahiroy@kernel.org>
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

Change the source format from "1.0" to "3.0 (quilt)" because it works
more cleanly.

All files except .config and debian/ go into the .orig tarball.
You can add a single patch, debian/patches/config, and delete the ugly
extend-diff-ignore patterns.

The debian tarball will be compressed into *.debian.tar.xz by default.
If you like to use a different compression mode, you can pass the
command line option, DPKG_FLAGS=-Zgzip, for example.

The .orig tarball only supports gzip for now. The combination of
gzip and xz is somewhat clumsy, but it is not a practical problem.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v4)

Changes in v4:
  - New patch

 scripts/Makefile.package |  2 +-
 scripts/package/mkdebian | 41 ++++++++++++++++++----------------------
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index b591f036e63f..55be31d0e040 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -67,7 +67,7 @@ debian-orig: linux.tar.gz debian
 PHONY += deb-pkg
 deb-pkg: debian-orig
 	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) \
-		--build=source,binary --source-option=-sP -nc -us -uc
+		--build=source,binary -nc -us -uc
 
 PHONY += bindeb-pkg
 bindeb-pkg: debian
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 534e9713761a..1ab4c6ee76d9 100755
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
+	diff -u /dev/null .config | tail -n +3
+} > debian/patches/config
+echo config > debian/patches/series
 
 echo $debarch > debian/arch
 extra_build_depends=", $(if_enabled_echo CONFIG_UNWINDER_ORC libelf-dev:native)"
-- 
2.34.1

