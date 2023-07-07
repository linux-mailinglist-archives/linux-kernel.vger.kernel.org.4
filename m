Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DBA74AE60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjGGJ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjGGJ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:56:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B7926B6;
        Fri,  7 Jul 2023 02:56:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D30561929;
        Fri,  7 Jul 2023 09:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262D9C433C7;
        Fri,  7 Jul 2023 09:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688723759;
        bh=ZlrPUR4qDwFuSSAmVs8BdIFko0degkyaq4+ixUSpArQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m46OaoBs45HlaUEZMk7dtWry+k569Hsec688GU34tSmZ+dRaDfCZgbatKcMkoJb4W
         L+0sjRZOaq7fnXzEKqBRJ2P+kPiY3iobRJLvCN7cmCiV7bvnwyfCb9oLGJRV8u+INh
         nnkcI5UabsNZZTkO/zaZ+OeDPuMeskyUoUAeflYFXT70X/eLC7KMD+HtNQ0mnLxBxr
         9nrfbs3wYnhn+evE0EBsrUQ0eGoYcbj65uoozC1VZHBXTFuYTc52YtRPNOlifWzWQl
         BkXonaqPwL/TgLz1wZZAGwrEB4yqcrZb4E2SD8mf6sEm0HkkcApeZku5KPb+vS/sz2
         WGPb0b0Bu/Fyw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     javierm@redhat.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] dummycon: limit Arm console size hack to footbridge
Date:   Fri,  7 Jul 2023 11:52:25 +0200
Message-Id: <20230707095415.1449376-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707095415.1449376-1-arnd@kernel.org>
References: <20230707095415.1449376-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The dummycon default console size used to be determined by architecture,
but now this is a Kconfig setting on everything except ARM. Tracing this
back in the historic git trees, this was used to match the size of VGA
console or VGA framebuffer on early machines, but nowadays that code is
no longer used, except probably on the old footbridge/netwinder since
that is the only one that supports vgacon.

On machines with a framebuffer, booting with DT so far results in always
using the hardcoded 80x30 size in dummycon, while on ATAGS the setting
can come from a bootloader specific override. Both seem to be worse
choices than the Kconfig setting, since the actual text size for fbcon
also depends on the selected font.

Make this work the same way as everywhere else and use the normal
Kconfig setting, except for the footbridge with vgacon, which keeps
using the traditional code. If vgacon is disabled, footbridge can
also ignore the setting. This means the screen_info only has to be
provided when either vgacon or EFI are enabled now.

To limit the amount of surprises on Arm, change the Kconfig default
to the previously used 80x30 setting instead of the usual 80x25.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/atags_parse.c    | 2 +-
 arch/arm/kernel/setup.c          | 3 +--
 drivers/video/console/Kconfig    | 5 +++--
 drivers/video/console/dummycon.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 33f6eb5213a5a..4c815da3b77b0 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -69,7 +69,7 @@ static int __init parse_tag_mem32(const struct tag *tag)
 
 __tagtable(ATAG_MEM, parse_tag_mem32);
 
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
+#if defined(CONFIG_ARCH_FOOTBRIDGE) && defined(CONFIG_VGA_CONSOLE)
 static int __init parse_tag_videotext(const struct tag *tag)
 {
 	screen_info.orig_x            = tag->u.videotext.x;
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c66b560562b30..40326a35a179b 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -928,8 +928,7 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
 		request_resource(&ioport_resource, &lp2);
 }
 
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE) || \
-    defined(CONFIG_EFI)
+#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_EFI)
 struct screen_info screen_info = {
  .orig_video_lines	= 30,
  .orig_video_cols	= 80,
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 47c498defc211..a3e4e9a6bf79d 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -52,7 +52,7 @@ config DUMMY_CONSOLE
 
 config DUMMY_CONSOLE_COLUMNS
 	int "Initial number of console screen columns"
-	depends on DUMMY_CONSOLE && !ARM
+	depends on DUMMY_CONSOLE && !ARCH_FOOTBRIDGE
 	default 160 if PARISC
 	default 80
 	help
@@ -62,8 +62,9 @@ config DUMMY_CONSOLE_COLUMNS
 
 config DUMMY_CONSOLE_ROWS
 	int "Initial number of console screen rows"
-	depends on DUMMY_CONSOLE && !ARM
+	depends on DUMMY_CONSOLE && !ARCH_FOOTBRIDGE
 	default 64 if PARISC
+	default 30 if ARM
 	default 25
 	help
 	  On PA-RISC, the default value is 64, which should fit a 1280x1024
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index f1711b2f9ff05..70549fecee12c 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -18,7 +18,7 @@
  *  Dummy console driver
  */
 
-#if defined(__arm__)
+#if defined(CONFIG_ARCH_FOOTBRIDGE) && defined(CONFIG_VGA_CONSOLE)
 #define DUMMY_COLUMNS	screen_info.orig_video_cols
 #define DUMMY_ROWS	screen_info.orig_video_lines
 #else
-- 
2.39.2

