Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1502365EDD7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjAENue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjAENtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:49:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4CE5AC57;
        Thu,  5 Jan 2023 05:47:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CABFFB81AE7;
        Thu,  5 Jan 2023 13:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F226C433EF;
        Thu,  5 Jan 2023 13:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926464;
        bh=hvYlZun1V9ia6MvbkglHwpnSsKWMQMEdGZSkjARxpus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pslL6VhveSNnnvoa7GN/G2CXo4AomFZlhKE8+BqKSIwC5tmQD9zS4Y+nwwxF5BVtP
         lcqEtw9oqeh5GcYfq4YW2vz2b9AvXqHVrdwrM9458+wvEU/hS3EfE2zSy4kn1ryPT6
         gA9yzsWM+6dP0bmIP5XU8uKQSbUXZITHxFwSlC57wcTB7yJlZyMiTtImnOGGVAD1/z
         kFnYmpms6I4BZnOR96m9jRbh5ZPBjjv+6ONSzRff6bdvDaLIdWhgI0Aa2xvfgkSL60
         Ww1z89/t2uJslv6fWyoO57RjlrRdpd5jd1qUs12568hlG0iHgyLgnN61e3tV6ki+Wk
         nqokI4NmcDWIg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 23/27] fbdev: remove w100fb driver
Date:   Thu,  5 Jan 2023 14:46:18 +0100
Message-Id: <20230105134622.254560-24-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

The w100fb was used on various PXA based pocketpc machines,
all of which are now removed, so remove this dirver sd well.

Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/Kconfig  |   17 -
 drivers/video/fbdev/Makefile |    1 -
 drivers/video/fbdev/w100fb.c | 1644 ----------------------------------
 drivers/video/fbdev/w100fb.h |  924 -------------------
 include/video/w100fb.h       |  147 ---
 5 files changed, 2733 deletions(-)
 delete mode 100644 drivers/video/fbdev/w100fb.c
 delete mode 100644 drivers/video/fbdev/w100fb.h
 delete mode 100644 include/video/w100fb.h

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 3152f1a06a39..2f5219cc36b4 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1841,23 +1841,6 @@ config FB_FSL_DIU
 	help
 	  Framebuffer driver for the Freescale SoC DIU
 
-config FB_W100
-	tristate "W100 frame buffer support"
-	depends on FB && HAS_IOMEM && (ARCH_PXA || COMPILE_TEST)
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  Frame buffer driver for the w100 as found on the Sharp SL-Cxx series.
-	  It can also drive the w3220 chip found on iPAQ hx4700.
-
-	  This driver is also available as a module ( = code which can be
-	  inserted and removed from the running kernel whenever you want). The
-	  module will be called w100fb. If you want to compile it as a module,
-	  say M here and read <file:Documentation/kbuild/modules.rst>.
-
-	  If unsure, say N.
-
 config FB_SH_MOBILE_LCDC
 	tristate "SuperH Mobile LCDC framebuffer support"
 	depends on FB && HAVE_CLK && HAS_IOMEM
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index e5206c3331d6..e6b0ae094b8b 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -84,7 +84,6 @@ obj-$(CONFIG_FB_PXA)		  += pxafb.o
 obj-$(CONFIG_FB_PXA168)		  += pxa168fb.o
 obj-$(CONFIG_PXA3XX_GCU)	  += pxa3xx-gcu.o
 obj-$(CONFIG_MMP_DISP)           += mmp/
-obj-$(CONFIG_FB_W100)		  += w100fb.o
 obj-$(CONFIG_FB_AU1100)		  += au1100fb.o
 obj-$(CONFIG_FB_AU1200)		  += au1200fb.o
 obj-$(CONFIG_FB_VT8500)		  += vt8500lcdfb.o
diff --git a/drivers/video/fbdev/w100fb.c b/drivers/video/fbdev/w100fb.c
deleted file mode 100644
index 4e641a780726..000000000000
diff --git a/drivers/video/fbdev/w100fb.h b/drivers/video/fbdev/w100fb.h
deleted file mode 100644
index 52c96d155b4c..000000000000
diff --git a/include/video/w100fb.h b/include/video/w100fb.h
deleted file mode 100644
index a614654d8598..000000000000
-- 
2.39.0

