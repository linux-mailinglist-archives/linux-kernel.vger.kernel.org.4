Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BEF639889
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 23:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiKZW4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 17:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiKZW4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 17:56:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FDF14033;
        Sat, 26 Nov 2022 14:56:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1C7BB80990;
        Sat, 26 Nov 2022 22:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3BCC43146;
        Sat, 26 Nov 2022 22:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669503398;
        bh=wCew/KSYiW5FMRpAcbkMMNoa0Tg0Yys9AnOHzoZ6il8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iU09oV6qH+haiGzgiXuF0/S4LQyMadKXIFcYKmTSKU7kOMjP5o7K2kFLjGtY4w8Pa
         FAMmfl9dlKJdVGA8U4FUbnZwE41c3RVhqICFpRrRkcaf8RlP9CZ+7AGaAeACbrRcYJ
         4lb8cKx9Klcs267OGILTJR1W8dsyzNumUzs8Xpc7F2/YEMh5SQq5lSW6rBEA9kWFIx
         AU7DLCb0Le6BX7XwVIj8Uf6MEedqDTXtDib5+AqyA02UK1agU6k81fMQpQ1umOQKQt
         Kr9684qmU8D4BV6+HNeeEsHsdMfCgFJtjUL/YQ5D+V5aD6r9qaOyZPT17IHaBVRdNE
         q2vjtoPnsvasg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v3 4/5] kconfig: refactor Makefile to reduce process forks
Date:   Sun, 27 Nov 2022 07:56:23 +0900
Message-Id: <20221126225624.751661-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221126225624.751661-1-masahiroy@kernel.org>
References: <20221126225624.751661-1-masahiroy@kernel.org>
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

Refactor Makefile and use read-file macro. For Make >= 4.2, it can read
out a file by using the built-in function.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

(no changes since v1)

 scripts/kconfig/.gitignore   |  4 +++-
 scripts/kconfig/Makefile     | 43 +++++++++++++++++++-----------------
 scripts/kconfig/gconf-cfg.sh |  7 ++++--
 scripts/kconfig/mconf-cfg.sh | 25 ++++++++++++---------
 scripts/kconfig/nconf-cfg.sh | 23 ++++++++++---------
 scripts/kconfig/qconf-cfg.sh | 10 ++++++---
 scripts/remove-stale-files   |  2 ++
 7 files changed, 67 insertions(+), 47 deletions(-)

diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
index 500e7424b3ef..c8a3f9cd52f0 100644
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /conf
 /[gmnq]conf
-/[gmnq]conf-cfg
+/[gmnq]conf-cflags
+/[gmnq]conf-libs
+/qconf-bin
 /qconf-moc.cc
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index b8ef0fb4bbef..da7da9775a4b 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -159,11 +159,12 @@ conf-objs	:= conf.o $(common-objs)
 hostprogs	+= nconf
 nconf-objs	:= nconf.o nconf.gui.o $(common-objs)
 
-HOSTLDLIBS_nconf	= $(shell . $(obj)/nconf-cfg && echo $$libs)
-HOSTCFLAGS_nconf.o	= $(shell . $(obj)/nconf-cfg && echo $$cflags)
-HOSTCFLAGS_nconf.gui.o	= $(shell . $(obj)/nconf-cfg && echo $$cflags)
+HOSTLDLIBS_nconf       = $(call read-file, $(obj)/nconf-libs)
+HOSTCFLAGS_nconf.o     = $(call read-file, $(obj)/nconf-cflags)
+HOSTCFLAGS_nconf.gui.o = $(call read-file, $(obj)/nconf-cflags)
 
-$(obj)/nconf.o $(obj)/nconf.gui.o: $(obj)/nconf-cfg
+$(obj)/nconf: | $(obj)/nconf-libs
+$(obj)/nconf.o $(obj)/nconf.gui.o: | $(obj)/nconf-cflags
 
 # mconf: Used for the menuconfig target based on lxdialog
 hostprogs	+= mconf
@@ -171,27 +172,28 @@ lxdialog	:= $(addprefix lxdialog/, \
 		     checklist.o inputbox.o menubox.o textbox.o util.o yesno.o)
 mconf-objs	:= mconf.o $(lxdialog) $(common-objs)
 
-HOSTLDLIBS_mconf = $(shell . $(obj)/mconf-cfg && echo $$libs)
+HOSTLDLIBS_mconf = $(call read-file, $(obj)/mconf-libs)
 $(foreach f, mconf.o $(lxdialog), \
-  $(eval HOSTCFLAGS_$f = $$(shell . $(obj)/mconf-cfg && echo $$$$cflags)))
+  $(eval HOSTCFLAGS_$f = $$(call read-file, $(obj)/mconf-cflags)))
 
-$(addprefix $(obj)/, mconf.o $(lxdialog)): $(obj)/mconf-cfg
+$(obj)/mconf: | $(obj)/mconf-libs
+$(addprefix $(obj)/, mconf.o $(lxdialog)): | $(obj)/mconf-cflags
 
 # qconf: Used for the xconfig target based on Qt
 hostprogs	+= qconf
 qconf-cxxobjs	:= qconf.o qconf-moc.o
 qconf-objs	:= images.o $(common-objs)
 
-HOSTLDLIBS_qconf	= $(shell . $(obj)/qconf-cfg && echo $$libs)
-HOSTCXXFLAGS_qconf.o	= $(shell . $(obj)/qconf-cfg && echo $$cflags)
-HOSTCXXFLAGS_qconf-moc.o = $(shell . $(obj)/qconf-cfg && echo $$cflags)
-
-$(obj)/qconf.o: $(obj)/qconf-cfg
+HOSTLDLIBS_qconf         = $(call read-file, $(obj)/qconf-libs)
+HOSTCXXFLAGS_qconf.o     = -std=c++11 -fPIC $(call read-file, $(obj)/qconf-cflags)
+HOSTCXXFLAGS_qconf-moc.o = -std=c++11 -fPIC $(call read-file, $(obj)/qconf-cflags)
+$(obj)/qconf: | $(obj)/qconf-libs
+$(obj)/qconf.o $(obj)/qconf-moc.o: | $(obj)/qconf-cflags
 
 quiet_cmd_moc = MOC     $@
-      cmd_moc = $(shell . $(obj)/qconf-cfg && echo $$moc) $< -o $@
+      cmd_moc = $(call read-file, $(obj)/qconf-bin)/moc $< -o $@
 
-$(obj)/qconf-moc.cc: $(src)/qconf.h $(obj)/qconf-cfg FORCE
+$(obj)/qconf-moc.cc: $(src)/qconf.h FORCE | $(obj)/qconf-bin
 	$(call if_changed,moc)
 
 targets += qconf-moc.cc
@@ -200,15 +202,16 @@ targets += qconf-moc.cc
 hostprogs	+= gconf
 gconf-objs	:= gconf.o images.o $(common-objs)
 
-HOSTLDLIBS_gconf    = $(shell . $(obj)/gconf-cfg && echo $$libs)
-HOSTCFLAGS_gconf.o  = $(shell . $(obj)/gconf-cfg && echo $$cflags)
+HOSTLDLIBS_gconf   = $(call read-file, $(obj)/gconf-libs)
+HOSTCFLAGS_gconf.o = $(call read-file, $(obj)/gconf-cflags)
 
-$(obj)/gconf.o: $(obj)/gconf-cfg
+$(obj)/gconf: | $(obj)/gconf-libs
+$(obj)/gconf.o: | $(obj)/gconf-cflags
 
 # check if necessary packages are available, and configure build flags
-filechk_conf_cfg = $(CONFIG_SHELL) $<
+cmd_conf_cfg = $< $(addprefix $(obj)/$*conf-, cflags libs bin)
 
-$(obj)/%conf-cfg: $(src)/%conf-cfg.sh FORCE
-	$(call filechk,conf_cfg)
+$(obj)/%conf-cflags $(obj)/%conf-libs $(obj)/%conf-bin: $(src)/%conf-cfg.sh
+	$(call cmd,conf_cfg)
 
 clean-files += *conf-cfg
diff --git a/scripts/kconfig/gconf-cfg.sh b/scripts/kconfig/gconf-cfg.sh
index cbd90c28c05f..040d8f338820 100755
--- a/scripts/kconfig/gconf-cfg.sh
+++ b/scripts/kconfig/gconf-cfg.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+cflags=$1
+libs=$2
+
 PKG="gtk+-2.0 gmodule-2.0 libglade-2.0"
 
 if [ -z "$(command -v ${HOSTPKG_CONFIG})" ]; then
@@ -26,5 +29,5 @@ if ! ${HOSTPKG_CONFIG} --atleast-version=2.0.0 gtk+-2.0; then
 	exit 1
 fi
 
-echo cflags=\"$(${HOSTPKG_CONFIG} --cflags $PKG)\"
-echo libs=\"$(${HOSTPKG_CONFIG} --libs $PKG)\"
+${HOSTPKG_CONFIG} --cflags ${PKG} > ${cflags}
+${HOSTPKG_CONFIG} --libs ${PKG} > ${libs}
diff --git a/scripts/kconfig/mconf-cfg.sh b/scripts/kconfig/mconf-cfg.sh
index 025b565e0b7c..1e61f50a5905 100755
--- a/scripts/kconfig/mconf-cfg.sh
+++ b/scripts/kconfig/mconf-cfg.sh
@@ -1,19 +1,22 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+cflags=$1
+libs=$2
+
 PKG="ncursesw"
 PKG2="ncurses"
 
 if [ -n "$(command -v ${HOSTPKG_CONFIG})" ]; then
 	if ${HOSTPKG_CONFIG} --exists $PKG; then
-		echo cflags=\"$(${HOSTPKG_CONFIG} --cflags $PKG)\"
-		echo libs=\"$(${HOSTPKG_CONFIG} --libs $PKG)\"
+		${HOSTPKG_CONFIG} --cflags ${PKG} > ${cflags}
+		${HOSTPKG_CONFIG} --libs ${PKG} > ${libs}
 		exit 0
 	fi
 
-	if ${HOSTPKG_CONFIG} --exists $PKG2; then
-		echo cflags=\"$(${HOSTPKG_CONFIG} --cflags $PKG2)\"
-		echo libs=\"$(${HOSTPKG_CONFIG} --libs $PKG2)\"
+	if ${HOSTPKG_CONFIG} --exists ${PKG2}; then
+		${HOSTPKG_CONFIG} --cflags ${PKG2} > ${cflags}
+		${HOSTPKG_CONFIG} --libs ${PKG2} > ${libs}
 		exit 0
 	fi
 fi
@@ -22,22 +25,22 @@ fi
 # (Even if it is installed, some distributions such as openSUSE cannot
 # find ncurses by pkg-config.)
 if [ -f /usr/include/ncursesw/ncurses.h ]; then
-	echo cflags=\"-D_GNU_SOURCE -I/usr/include/ncursesw\"
-	echo libs=\"-lncursesw\"
+	echo -D_GNU_SOURCE -I/usr/include/ncursesw > ${cflags}
+	echo -lncursesw > ${libs}
 	exit 0
 fi
 
 if [ -f /usr/include/ncurses/ncurses.h ]; then
-	echo cflags=\"-D_GNU_SOURCE -I/usr/include/ncurses\"
-	echo libs=\"-lncurses\"
+	echo -D_GNU_SOURCE -I/usr/include/ncurses > ${cflags}
+	echo -lncurses > ${libs}
 	exit 0
 fi
 
 # As a final fallback before giving up, check if $HOSTCC knows of a default
 # ncurses installation (e.g. from a vendor-specific sysroot).
 if echo '#include <ncurses.h>' | ${HOSTCC} -E - >/dev/null 2>&1; then
-	echo cflags=\"-D_GNU_SOURCE\"
-	echo libs=\"-lncurses\"
+	echo -D_GNU_SOURCE > ${cflags}
+	echo -lncurses > ${libs}
 	exit 0
 fi
 
diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
index 3a10bac2adb3..f871a2160e36 100755
--- a/scripts/kconfig/nconf-cfg.sh
+++ b/scripts/kconfig/nconf-cfg.sh
@@ -1,19 +1,22 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+cflags=$1
+libs=$2
+
 PKG="ncursesw menuw panelw"
 PKG2="ncurses menu panel"
 
 if [ -n "$(command -v ${HOSTPKG_CONFIG})" ]; then
 	if ${HOSTPKG_CONFIG} --exists $PKG; then
-		echo cflags=\"$(${HOSTPKG_CONFIG} --cflags $PKG)\"
-		echo libs=\"$(${HOSTPKG_CONFIG} --libs $PKG)\"
+		${HOSTPKG_CONFIG} --cflags ${PKG} > ${cflags}
+		${HOSTPKG_CONFIG} --libs ${PKG} > ${libs}
 		exit 0
 	fi
 
 	if ${HOSTPKG_CONFIG} --exists $PKG2; then
-		echo cflags=\"$(${HOSTPKG_CONFIG} --cflags $PKG2)\"
-		echo libs=\"$(${HOSTPKG_CONFIG} --libs $PKG2)\"
+		${HOSTPKG_CONFIG} --cflags ${PKG2} > ${cflags}
+		${HOSTPKG_CONFIG} --libs ${PKG2} > ${libs}
 		exit 0
 	fi
 fi
@@ -22,20 +25,20 @@ fi
 # (Even if it is installed, some distributions such as openSUSE cannot
 # find ncurses by pkg-config.)
 if [ -f /usr/include/ncursesw/ncurses.h ]; then
-	echo cflags=\"-D_GNU_SOURCE -I/usr/include/ncursesw\"
-	echo libs=\"-lncursesw -lmenuw -lpanelw\"
+	echo -D_GNU_SOURCE -I/usr/include/ncursesw > ${cflags}
+	echo -lncursesw -lmenuw -lpanelw > ${libs}
 	exit 0
 fi
 
 if [ -f /usr/include/ncurses/ncurses.h ]; then
-	echo cflags=\"-D_GNU_SOURCE -I/usr/include/ncurses\"
-	echo libs=\"-lncurses -lmenu -lpanel\"
+	echo -D_GNU_SOURCE -I/usr/include/ncurses > ${cflags}
+	echo -lncurses -lmenu -lpanel > ${libs}
 	exit 0
 fi
 
 if [ -f /usr/include/ncurses.h ]; then
-	echo cflags=\"-D_GNU_SOURCE\"
-	echo libs=\"-lncurses -lmenu -lpanel\"
+	echo -D_GNU_SOURCE > ${cflags}
+	echo -lncurses -lmenu -lpanel > ${libs}
 	exit 0
 fi
 
diff --git a/scripts/kconfig/qconf-cfg.sh b/scripts/kconfig/qconf-cfg.sh
index ad652cb53947..117f36e568fc 100755
--- a/scripts/kconfig/qconf-cfg.sh
+++ b/scripts/kconfig/qconf-cfg.sh
@@ -1,6 +1,10 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+cflags=$1
+libs=$2
+bin=$3
+
 PKG="Qt5Core Qt5Gui Qt5Widgets"
 
 if [ -z "$(command -v ${HOSTPKG_CONFIG})" ]; then
@@ -11,9 +15,9 @@ if [ -z "$(command -v ${HOSTPKG_CONFIG})" ]; then
 fi
 
 if ${HOSTPKG_CONFIG} --exists $PKG; then
-	echo cflags=\"-std=c++11 -fPIC $(${HOSTPKG_CONFIG} --cflags $PKG)\"
-	echo libs=\"$(${HOSTPKG_CONFIG} --libs $PKG)\"
-	echo moc=\"$(${HOSTPKG_CONFIG} --variable=host_bins Qt5Core)/moc\"
+	${HOSTPKG_CONFIG} --cflags ${PKG} > ${cflags}
+	${HOSTPKG_CONFIG} --libs ${PKG} > ${libs}
+	${HOSTPKG_CONFIG} --variable=host_bins Qt5Core > ${bin}
 	exit 0
 fi
 
diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
index ccadfa3afb2b..64b14aa5aebf 100755
--- a/scripts/remove-stale-files
+++ b/scripts/remove-stale-files
@@ -47,3 +47,5 @@ rm -f arch/riscv/purgatory/kexec-purgatory.c
 rm -f scripts/extract-cert
 
 rm -f arch/x86/purgatory/kexec-purgatory.c
+
+rm -f scripts/kconfig/[gmnq]conf-cfg
-- 
2.34.1

