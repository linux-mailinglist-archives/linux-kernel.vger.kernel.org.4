Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E7E68740E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjBBDkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjBBDjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:39:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC27D7D6DD;
        Wed,  1 Feb 2023 19:38:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C176619E8;
        Thu,  2 Feb 2023 03:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B21EC433A0;
        Thu,  2 Feb 2023 03:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675309116;
        bh=q+6WIWIgdV8iv/IIa/6uMtSiTo1opal/OruDUNHzygM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZ4TYa3hUVo//cGVT9wCIRN2RIiYwn5/BzvtUZde6EmRCfxXZXGUE4WRlhid8/OmH
         kUXkmEIEgknC0wbPaqndPoLt1lbtMxLxapwMzxdmA10uL39DqHn5kPbkExo5NT1w1s
         ha8PernNgJKGazEzqLWghxhVjbv68JXxl8rwZ9kEUQ+i4l4guiWmin9pN5C5B51Oqp
         M9cgwx6s+pmCqvyp9gWnx4YzpKd5T4bclV1MbOqgryUaNfKHkSKg9mmKPh4l16p9zj
         pqFEewShOzO+L+0eUOUrjKrS4lfj2gBr3aN/06t+9i+h0WKNDigiY9/MHWP/21TLAZ
         HbUluvTgY8vfw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 6/6] kbuild: deb-pkg: switch over to format 3.0 (quilt)
Date:   Thu,  2 Feb 2023 12:37:16 +0900
Message-Id: <20230202033716.341858-7-masahiroy@kernel.org>
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

Switch from "1.0" to "3.0 (quilt)" because it works more cleanly.

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

Changes in v4:
  - New patch

 scripts/Makefile.package |  2 +-
 scripts/package/mkdebian | 42 +++++++++++++++++-----------------------
 2 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 5135a5419a72..454268a37af1 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -94,7 +94,7 @@ debian-tarball: debian
 PHONY += deb-pkg
 deb-pkg: debian-tarball
 	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG_FLAGS) \
-		--build=source,binary --source-option=-sP -nc -us -uc
+		--build=source,binary -nc -us -uc
 
 PHONY += bindeb-pkg
 bindeb-pkg: debian
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 0c1ed6215a02..1ab4c6ee76d9 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -135,30 +135,24 @@ else
 fi
 
 mkdir -p debian/source/
-echo "1.0" > debian/source/format
-
-# Ugly: ignore anything except .config or debian/
-# (is there a cleaner way to do this?)
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

