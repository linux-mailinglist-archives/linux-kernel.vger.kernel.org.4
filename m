Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483EF74F389
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjGKPcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjGKPcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:32:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7178610DD;
        Tue, 11 Jul 2023 08:32:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E8BBD1FE69;
        Tue, 11 Jul 2023 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689089538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zi7pcLLSWwiwPJzQ1FjSFjmrtTNu/4ArWWuzhomcHJc=;
        b=11rlUDi0iRT+FZ1dJVq2XpnOoKesESjm/Sz/jXG81aNHOSVgoc00DdEHn8BE1KLgZ5/hZr
        XpIebYValJ/XH7l81ist0Q/klJr4RcXkldgdb+2Xqgp9C0hzsEBQpfPjO8Awf3lJQdgE4s
        wqZxUko6f9L6vVjQ9peIxhG9Sf2yrOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689089538;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zi7pcLLSWwiwPJzQ1FjSFjmrtTNu/4ArWWuzhomcHJc=;
        b=lCK2GUpcORnC0BJBdv6ftKKI3DAAHHDyQyU8Yld7IgMcbXLUTODHNN5TclHAxNSXErasmH
        IIfVm2+DgnM2arBw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id A49212C145;
        Tue, 11 Jul 2023 15:32:18 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] libkmod, depmod: Load modprobe.d, depmod.d from $prefix/lib.
Date:   Tue, 11 Jul 2023 17:31:17 +0200
Message-ID: <20230711153126.28876-3-msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711153126.28876-1-msuchanek@suse.de>
References: <20230711153126.28876-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an ongoing effort to limit use of files outside of /usr (or
$prefix on general). Currently all modprobe.d paths are hardcoded to
outside of $prefix. Teach kmod to load modprobe.d from $prefix/lib.

On some distributions /usr/lib and /lib are the same directory because
of a compatibility symlink, and it is possible to craft configuration
files with sideeffects that would behave differently when loaded twice.
However, the override semantic ensures that one 'overrides' the other,
and only one configuration file of the same name is loaded from any of
the seach directories.

Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 Makefile.am        | 1 +
 libkmod/libkmod.c  | 3 ++-
 man/Makefile.am    | 9 +++++++--
 man/depmod.d.xml   | 1 +
 man/modprobe.d.xml | 1 +
 tools/depmod.c     | 1 +
 6 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 8ba85c91a0f3..7aa5bfa5638d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -19,6 +19,7 @@ AM_CPPFLAGS = \
 	-include $(top_builddir)/config.h \
 	-I$(top_srcdir) \
 	-DSYSCONFDIR=\""$(sysconfdir)"\" \
+	-DPREFIX=\""$(prefix)"\" \
 	${zlib_CFLAGS}
 
 AM_CFLAGS = $(OUR_CFLAGS)
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 2670f9a4611a..13c82b069e84 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -65,6 +65,7 @@ static const char *const default_config_paths[] = {
 	SYSCONFDIR "/modprobe.d",
 	"/run/modprobe.d",
 	"/usr/local/lib/modprobe.d",
+	PREFIX "/lib/modprobe.d",
 	"/lib/modprobe.d",
 	NULL
 };
@@ -237,7 +238,7 @@ static char *get_kernel_release(const char *dirname)
  *                to load from user-defined configuration parameters such as
  *                alias, blacklists, commands (install, remove). If NULL
  *                defaults to /etc/modprobe.d, /run/modprobe.d,
- *                /usr/local/lib/modprobe.d and /lib/modprobe.d. Give an empty
+ *                /usr/local/lib/modprobe.d and PREFIX/lib/modprobe.d. Give an empty
  *                vector if configuration should not be read. This array must
  *                be null terminated.
  *
diff --git a/man/Makefile.am b/man/Makefile.am
index 11514d52a190..ad07c30bbd24 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -17,9 +17,14 @@ EXTRA_DIST = $(MAN5:%.5=%.xml) $(MAN8:%.8=%.xml)
 CLEANFILES = $(dist_man_MANS)
 
 %.5 %.8: %.xml
-	$(AM_V_XSLT)$(XSLT) \
+	$(AM_V_XSLT)if [ -n '$(prefix)' ] ; then \
+		sed -e 's|@PREFIX@|$(prefix)|g' $< ; \
+	else \
+		sed -e '/@PREFIX@/d' $< ; \
+	fi | \
+	$(XSLT) \
 		-o $@ \
 		--nonet \
 		--stringparam man.output.quietly 1 \
 		--param funcsynopsis.style "'ansi'" \
-		http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl $<
+		http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl -
diff --git a/man/depmod.d.xml b/man/depmod.d.xml
index 8d3d821cddc8..431ebca6654b 100644
--- a/man/depmod.d.xml
+++ b/man/depmod.d.xml
@@ -40,6 +40,7 @@
 
   <refsynopsisdiv>
     <para><filename>/lib/depmod.d/*.conf</filename></para>
+    <para><filename>@PREFIX@/lib/depmod.d/*.conf</filename></para>
     <para><filename>/usr/local/lib/depmod.d/*.conf</filename></para>
     <para><filename>/run/depmod.d/*.conf</filename></para>
     <para><filename>/etc/depmod.d/*.conf</filename></para>
diff --git a/man/modprobe.d.xml b/man/modprobe.d.xml
index 0ab3e9110a7e..e8a91d7668af 100644
--- a/man/modprobe.d.xml
+++ b/man/modprobe.d.xml
@@ -41,6 +41,7 @@
 
   <refsynopsisdiv>
     <para><filename>/lib/modprobe.d/*.conf</filename></para>
+    <para><filename>@PREFIX@/lib/modprobe.d/*.conf</filename></para>
     <para><filename>/usr/local/lib/modprobe.d/*.conf</filename></para>
     <para><filename>/run/modprobe.d/*.conf</filename></para>
     <para><filename>/etc/modprobe.d/*.conf</filename></para>
diff --git a/tools/depmod.c b/tools/depmod.c
index 1d1d41db860f..7e9339923809 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -54,6 +54,7 @@ static const char *const default_cfg_paths[] = {
 	SYSCONFDIR "/depmod.d",
 	"/run/depmod.d",
 	"/usr/local/lib/depmod.d",
+	PREFIX "/lib/depmod.d",
 	"/lib/depmod.d",
 	NULL
 };
-- 
2.41.0

