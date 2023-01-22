Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FF6676D79
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjAVOOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjAVOOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:14:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6E6FF0A;
        Sun, 22 Jan 2023 06:14:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2848CB80AC6;
        Sun, 22 Jan 2023 14:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390B3C433D2;
        Sun, 22 Jan 2023 14:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674396873;
        bh=UAb92+qz5f4FAlarsxoJmAqQlkj41WIegpJbo4Iliyk=;
        h=From:To:Cc:Subject:Date:From;
        b=LkGO/5gK8yhGB1ezwFoTxm/hSmjzyI2MSP4Cw/WkIh2H5yyBlsgsARWLY/7fimRuh
         EyopLDwPdL47fpaXVZbvApWy25rPFMk5PW2xQsV74K0GjBsRJY/lsEKqv5tPIpAYVN
         0o6FLc8KHvjnaedyqa3x06l9rFtzAGqJw65neo6iJZKPDLEWMGDAzqeDbjpcEDrxKp
         hmO03s4QLEKKFjON8xw4L63wdoarOrUDNZq9d5h/Gm2U0VJ/Tynj05RjgaqteTpi35
         wuMe5Z6IAwqIXqMcVOBunlnZvnTSuQKQTX+jupMp7yjTlK3UFSX/x3/tLhxXNBVsUB
         GQzsOXM7axs3g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 1/7] kbuild: do not put .scmversion into the source tarball
Date:   Sun, 22 Jan 2023 23:14:21 +0900
Message-Id: <20230122141428.115372-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.scmversion is used by (src)rpm-pkg and deb-pkg to carry KERNELRELEASE.

In fact, deb-pkg does not rely on it any more because the generated
debian/rules specifies KERNELRELEASE from the command line.

Do likwise for (src)rpm-pkg, and remove this feature.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package |  6 ++----
 scripts/package/mkspec   |  6 +++---
 scripts/setlocalversion  | 19 +------------------
 3 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 525a2820976f..e84c4e8ceb8e 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -32,7 +32,7 @@ export KDEB_SOURCENAME
 TAR_CONTENT := Documentation LICENSES arch block certs crypto drivers fs \
                include init io_uring ipc kernel lib mm net rust \
                samples scripts security sound tools usr virt \
-               .config .scmversion Makefile \
+               .config Makefile \
                Kbuild Kconfig COPYING $(wildcard localversion*)
 MKSPEC     := $(srctree)/scripts/package/mkspec
 
@@ -47,10 +47,8 @@ if test "$(objtree)" != "$(srctree)"; then \
 	echo >&2; \
 	false; \
 fi ; \
-$(srctree)/scripts/setlocalversion --save-scmversion; \
 tar -I $(KGZIP) -c $(RCS_TAR_IGNORE) -f $(2).tar.gz \
-	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3); \
-rm -f $(objtree)/.scmversion
+	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3)
 
 # rpm-pkg
 # ---------------------------------------------------------------------------
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index adab28fa7f89..d3c6701b7769 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -90,7 +90,7 @@ $S	rm -f scripts/basic/fixdep scripts/kconfig/conf
 $S	rm -f tools/objtool/{fixdep,objtool}
 $S
 $S	%build
-$S	$MAKE %{?_smp_mflags} KBUILD_BUILD_VERSION=%{release}
+$S	$MAKE %{?_smp_mflags} KERNELRELEASE=%{version} KBUILD_BUILD_VERSION=%{release}
 $S
 	%install
 	mkdir -p %{buildroot}/boot
@@ -101,8 +101,8 @@ $S
 	%else
 	cp \$($MAKE -s image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
 	%endif
-$M	$MAKE %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
-	$MAKE %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
+$M	$MAKE %{?_smp_mflags} KERNELRELEASE=%{version} INSTALL_MOD_PATH=%{buildroot} modules_install
+	$MAKE %{?_smp_mflags} KERNELRELEASE=%{version} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
 	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
 	cp .config %{buildroot}/boot/config-$KERNELRELEASE
 $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index af4754a35e66..3b31702b4a4a 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -11,16 +11,11 @@
 #
 
 usage() {
-	echo "Usage: $0 [--save-scmversion] [srctree]" >&2
+	echo "Usage: $0 [srctree]" >&2
 	exit 1
 }
 
-scm_only=false
 srctree=.
-if test "$1" = "--save-scmversion"; then
-	scm_only=true
-	shift
-fi
 if test $# -gt 0; then
 	srctree=$1
 	shift
@@ -35,10 +30,6 @@ scm_version()
 	short=false
 
 	cd "$srctree"
-	if test -e .scmversion; then
-		cat .scmversion
-		return
-	fi
 	if test "$1" = "--short"; then
 		short=true
 	fi
@@ -103,14 +94,6 @@ collect_files()
 	echo "$res"
 }
 
-if $scm_only; then
-	if test ! -e .scmversion; then
-		res=$(scm_version)
-		echo "$res" >.scmversion
-	fi
-	exit
-fi
-
 if ! test -e include/config/auto.conf; then
 	echo "Error: kernelrelease not valid - run 'make prepare' to update it" >&2
 	exit 1
-- 
2.34.1

