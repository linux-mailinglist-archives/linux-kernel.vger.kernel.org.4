Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF58673231
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjASHNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjASHNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:13:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395A553E75;
        Wed, 18 Jan 2023 23:13:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D05126194E;
        Thu, 19 Jan 2023 07:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDC5C433D2;
        Thu, 19 Jan 2023 07:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674112390;
        bh=FF1TMn05drZsltGtJDjRzZ3VOTqO4eB9S3f2YG18LKY=;
        h=From:To:Cc:Subject:Date:From;
        b=M1lfl9S3dzEiHsrL10KJY3UL9Xsbhtzt9gpYrTyvm9W8NB1ERPTyBEbc5FKX8w/UA
         JhRaujlVf5yAurmW2kPLLBBiG1ERW83C+alO4VFP9z6EoOG2yQd02A70nTDmGW1QZq
         yqDGyIZo2cRvFPPFsht3D+eW3B6IOcjipKmq9Eusj55aM84/tCuX0EmUg+BnzoT5/U
         2H3FUnGxPWrZsZC9XcSv3wxnPXH0P9JOrUY4VUSQjw0qrguvPNMLS6/aGJNmzBZjWk
         rLZ2A5qPz5GIJmwSW0WPgSslqZDQTTPtdJeX1uru51xlwoNMaQuIde00BDEQ3RCVaQ
         Jj0+azRenar5A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, linux-doc@vger.kernel.org
Subject: [PATCH] scripts: remove bin2c
Date:   Thu, 19 Jan 2023 16:12:15 +0900
Message-Id: <20230119071215.23042-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Commit 80f8be7af03f ("tomoyo: Omit use of bin2c") removed the last
use of bin2c.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/dontdiff     |  1 -
 init/Kconfig               |  4 ----
 scripts/.gitignore         |  1 -
 scripts/Makefile           |  1 -
 scripts/bin2c.c            | 36 ------------------------------------
 scripts/remove-stale-files |  2 ++
 6 files changed, 2 insertions(+), 43 deletions(-)
 delete mode 100644 scripts/bin2c.c

diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 352ff53a2306..3c399f132e2d 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -91,7 +91,6 @@ asm_offsets.h
 autoconf.h*
 av_permissions.h
 bbootsect
-bin2c
 binkernel.spec
 bootsect
 bounds.h
diff --git a/init/Kconfig b/init/Kconfig
index 7ceabd320425..f66ba19f9482 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -682,10 +682,6 @@ config CPU_ISOLATION
 
 source "kernel/rcu/Kconfig"
 
-config BUILD_BIN2C
-	bool
-	default n
-
 config IKCONFIG
 	tristate "Kernel .config support"
 	help
diff --git a/scripts/.gitignore b/scripts/.gitignore
index 11bf3c075fb6..6e9ce6720a05 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /asn1_compiler
-/bin2c
 /generate_rust_target
 /insert-sys-cert
 /kallsyms
diff --git a/scripts/Makefile b/scripts/Makefile
index 0e0ae3c06ed7..32b6ba722728 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -3,7 +3,6 @@
 # scripts contains sources for various helper programs used throughout
 # the kernel for the build process.
 
-hostprogs-always-$(CONFIG_BUILD_BIN2C)			+= bin2c
 hostprogs-always-$(CONFIG_KALLSYMS)			+= kallsyms
 hostprogs-always-$(BUILD_C_RECORDMCOUNT)		+= recordmcount
 hostprogs-always-$(CONFIG_BUILDTIME_TABLE_SORT)		+= sorttable
diff --git a/scripts/bin2c.c b/scripts/bin2c.c
deleted file mode 100644
index c3d7eef3ad06..000000000000
--- a/scripts/bin2c.c
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * Unloved program to convert a binary on stdin to a C include on stdout
- *
- * Jan 1999 Matt Mackall <mpm@selenic.com>
- *
- * This software may be used and distributed according to the terms
- * of the GNU General Public License, incorporated herein by reference.
- */
-
-#include <stdio.h>
-
-int main(int argc, char *argv[])
-{
-	int ch, total = 0;
-
-	if (argc > 1)
-		printf("const char %s[] %s=\n",
-			argv[1], argc > 2 ? argv[2] : "");
-
-	do {
-		printf("\t\"");
-		while ((ch = getchar()) != EOF) {
-			total++;
-			printf("\\x%02x", ch);
-			if (total % 16 == 0)
-				break;
-		}
-		printf("\"\n");
-	} while (ch != EOF);
-
-	if (argc > 1)
-		printf("\t;\n\n#include <linux/types.h>\n\nconst size_t %s_size = %d;\n",
-		       argv[1], total);
-
-	return 0;
-}
diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
index c71bf2f68360..04fcdf739638 100755
--- a/scripts/remove-stale-files
+++ b/scripts/remove-stale-files
@@ -29,3 +29,5 @@ rm -f scripts/extract-cert
 rm -f scripts/kconfig/[gmnq]conf-cfg
 
 rm -f rust/target.json
+
+rm -f scripts/bin2c
-- 
2.34.1

