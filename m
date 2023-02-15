Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702FC697384
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjBOBWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjBOBWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:22:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBD432CD2;
        Tue, 14 Feb 2023 17:21:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED1076199C;
        Wed, 15 Feb 2023 01:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DBCC433D2;
        Wed, 15 Feb 2023 01:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676424108;
        bh=WszWYo1Dp3gtPmdsDTDcLO4U185HID5tYaADLVl+YJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tuXS3J3lUbtayvg3n33el4JAI3hK8xT9eZMWTj6IPX1KusGuisadhyvWNeu5MGZh5
         wFDikPC6YAbtPrvVF0ls/l2XO93KH2ogMTlvoRm8g3//MatM+WVGiEy1dqnsETc6bE
         qiHXJrxo5cCvqh/lHPXO+fFmOot3/DrhSXEbUo0i6K2lqjBs15VYDMxobws3pweOuG
         dqkl2/QnvzWD9h6wgefhNvPpg7Hf3M4hGpsnTfqyIhZIMRYEvsOTvT2FusR7JvHpUp
         y7cV2B5Xh83kEp3LuFB4DWn9+9+QqdhJq7rLSOBwHcl+TBNzp+DPq2H8amFcQNprLJ
         3hmB9vs4eI7PQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v6 09/12] kbuild: tar-pkg: use tar rules in scripts/Makefile.package
Date:   Wed, 15 Feb 2023 10:20:31 +0900
Message-Id: <20230215012034.403356-9-masahiroy@kernel.org>
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

Use %.tar, %.tar.gz, %.tar.bz2, %.tar.xz, %.tar.zst rules in
scripts/Makefile.package.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v6:
 - New patch

 scripts/Makefile.package | 29 +++++++++++++++++-----
 scripts/package/buildtar | 52 +---------------------------------------
 2 files changed, 24 insertions(+), 57 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 50b86b325d7a..b941e6341b36 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -145,13 +145,30 @@ snap-pkg:
 	cd $(objtree)/snap && \
 	snapcraft --target-arch=$(UTS_MACHINE)
 
-# tarball targets
+# dir-pkg tar*-pkg - tarball targets
 # ---------------------------------------------------------------------------
-tar-pkgs := dir-pkg tar-pkg targz-pkg tarbz2-pkg tarxz-pkg tarzst-pkg
-PHONY += $(tar-pkgs)
-$(tar-pkgs):
-	$(MAKE) -f $(srctree)/Makefile
-	+$(CONFIG_SHELL) $(srctree)/scripts/package/buildtar $@
+
+tar-pkg-tarball = linux-$(KERNELRELEASE)-$(ARCH).$(1)
+tar-pkg-phony = $(subst .,,$(1))-pkg
+
+tar-install: FORCE
+	$(Q)$(MAKE) -f $(srctree)/Makefile
+	+$(Q)$(srctree)/scripts/package/buildtar $@
+
+PHONY += dir-pkg
+dir-pkg: tar-install
+	@echo "Kernel tree successfully created in $<"
+
+define tar-pkg-rule
+PHONY += $(tar-pkg-phony)
+$(tar-pkg-phony): $(tar-pkg-tarball)
+	@:
+
+$(tar-pkg-tarball): private tar-rootdir := tar-install
+$(tar-pkg-tarball): tar-install
+endef
+
+$(foreach x, tar tar.gz tar.bz2 tar.xz tar.zst, $(eval $(call tar-pkg-rule,$(x))))
 
 # perf-tar*-src-pkg - generate a source tarball with perf source
 # ---------------------------------------------------------------------------
diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index 4d6f0b128efd..65b4ea502962 100755
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -16,39 +16,7 @@ set -e
 #
 # Some variables and settings used throughout the script
 #
-tmpdir="${objtree}/tar-install"
-tarball="${objtree}/linux-${KERNELRELEASE}-${ARCH}.tar"
-
-
-#
-# Figure out how to compress, if requested at all
-#
-case "${1}" in
-	dir-pkg|tar-pkg)
-		opts=
-		;;
-	targz-pkg)
-		opts="-I ${KGZIP}"
-		tarball=${tarball}.gz
-		;;
-	tarbz2-pkg)
-		opts="-I ${KBZIP2}"
-		tarball=${tarball}.bz2
-		;;
-	tarxz-pkg)
-		opts="-I ${XZ}"
-		tarball=${tarball}.xz
-		;;
-	tarzst-pkg)
-		opts="-I ${ZSTD}"
-		tarball=${tarball}.zst
-		;;
-	*)
-		echo "Unknown tarball target \"${1}\" requested, please add it to ${0}." >&2
-		exit 1
-		;;
-esac
-
+tmpdir=$1
 
 #
 # Clean-up and re-create the temporary directory
@@ -148,21 +116,3 @@ case "${ARCH}" in
 		sleep 5
 		;;
 esac
-
-if [ "${1}" = dir-pkg ]; then
-	echo "Kernel tree successfully created in $tmpdir"
-	exit 0
-fi
-
-#
-# Create the tarball
-#
-if tar --owner=root --group=root --help >/dev/null 2>&1; then
-	opts="$opts --owner=root --group=root"
-fi
-
-tar cf $tarball -C $tmpdir $opts $dirs
-
-echo "Tarball successfully created in $tarball"
-
-exit 0
-- 
2.34.1

