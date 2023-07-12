Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25421750A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjGLOBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjGLOB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:01:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0161BF5;
        Wed, 12 Jul 2023 07:01:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5C39A1FE45;
        Wed, 12 Jul 2023 14:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689170472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hbkrw+Y8Z1P5bMkowr2XXMkWBVqN2gEHuamxYK92xU4=;
        b=OscZ7he4/KK8vOpchq5n2waFvvi7aHK+q3JHNzvx/lBWoHe2ff3kXS3tToV272jJabsGy3
        BIq6f0lL8qcnjRRzwO9ECwyRd9qNb/rD75HS1zbtwioYjvIyrTdVZFLgvSubRLWn9aMy11
        FMaCnP4IPFoyYpI8kq4icpgpflAazkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689170472;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hbkrw+Y8Z1P5bMkowr2XXMkWBVqN2gEHuamxYK92xU4=;
        b=JS3RRZ7OvztD1547G6OgoaSS9XJaCLOVyheGF8lYu81q67D9C0JSmAgqkvLULh9XHqUKrb
        OneKDXCbL6uM8iBQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 0A0982C145;
        Wed, 12 Jul 2023 14:01:12 +0000 (UTC)
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
Subject: [PATCH kmod v2 3/4] kmod: Add config command to show compile time configuration as JSON
Date:   Wed, 12 Jul 2023 16:00:47 +0200
Message-ID: <20230712140103.5468-3-msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711153126.28876-1-msuchanek@suse.de>
References: <20230711153126.28876-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show prefix (where configuration files are searched/to be installed),
module compressions, and module signatures supported.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: mention module signature in commit message
---
 man/kmod.xml |  6 ++++++
 tools/kmod.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/man/kmod.xml b/man/kmod.xml
index 0706ad58c2cc..f992a500f836 100644
--- a/man/kmod.xml
+++ b/man/kmod.xml
@@ -71,6 +71,12 @@
           <para>Show the help message.</para>
         </listitem>
       </varlistentry>
+      <varlistentry>
+        <term><command>config</command></term>
+        <listitem>
+          <para>Show compile time options in JSON.</para>
+        </listitem>
+      </varlistentry>
       <varlistentry>
         <term><command>list</command></term>
         <listitem>
diff --git a/tools/kmod.c b/tools/kmod.c
index 55689c075ab1..5a13716955c1 100644
--- a/tools/kmod.c
+++ b/tools/kmod.c
@@ -37,9 +37,11 @@ static const struct option options[] = {
 };
 
 static const struct kmod_cmd kmod_cmd_help;
+static const struct kmod_cmd kmod_cmd_config;
 
 static const struct kmod_cmd *kmod_cmds[] = {
 	&kmod_cmd_help,
+	&kmod_cmd_config,
 	&kmod_cmd_list,
 	&kmod_cmd_static_nodes,
 
@@ -95,6 +97,43 @@ static const struct kmod_cmd kmod_cmd_help = {
 	.help = "Show help message",
 };
 
+static const char *compressions[] = {
+#ifdef ENABLE_ZSTD
+			"zstd",
+#endif
+#ifdef ENABLE_XZ
+			"xz",
+#endif
+#ifdef ENABLE_ZLIB
+			"gz",
+#endif
+			NULL
+};
+
+static int kmod_config(int argc, char *argv[])
+{
+	unsigned i;
+	printf("{\"prefix\":\"" PREFIX "\""
+			",\"module_signature\":["
+#ifdef ENABLE_OPENSSL
+			"\"PKCS#7\","
+#endif
+			"\"legacy\"]"
+			",\"module_compression\":[");
+	for(i = 0; compressions[i]; i++) {
+		printf("%s\"%s\"", i ? "," : "", compressions[i]);
+	}
+	printf("]}\n");
+
+	return EXIT_SUCCESS;
+}
+
+static const struct kmod_cmd kmod_cmd_config = {
+	.name = "config",
+	.cmd = kmod_config,
+	.help = "Show compile time options in JSON",
+};
+
 static int handle_kmod_commands(int argc, char *argv[])
 {
 	const char *cmd;
-- 
2.41.0

