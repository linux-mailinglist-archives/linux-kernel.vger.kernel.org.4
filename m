Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E0565EDD2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjAENuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjAENta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:49:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F62F57920;
        Thu,  5 Jan 2023 05:47:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CFAEB81AE6;
        Thu,  5 Jan 2023 13:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76EEC4339E;
        Thu,  5 Jan 2023 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926462;
        bh=XuR37xXrcd0/TuJKu14bocihydtY8dKg7n2lIjRAEQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWHliiv7BJ1D6fbS5sffYcy54TkQVc1hIWKgdDAM10KEQ+3rd/ZElK61AfgX4U3iE
         2lNh/DSH8aKPjOiz8+IlbNZZnhCID9xY8y2lcN4UF81DqCyIz9Bs3AsbT77WFTdHr/
         4c8N6GoQuDxqD+WLd69cuKCcDoE9y6stdYtrJD12WLbf1k32yRJ0zFUd41vSQRLOjC
         bNB+0/FE6fD/VJIi4lUxNFTjI5fIBUt1rd6VUMvLP07v/alzNzd8As/yEIsUWTVbM3
         Z6RAnwwJB0OqQB8N0WyC6Cv7wLCbYdmcH1U2y4aAWoM7YOdnBYFlRsZP/EDpl+xUTQ
         hFXWYUrex7MGw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 22/27] fbdev: remove tmiofb driver
Date:   Thu,  5 Jan 2023 14:46:17 +0100
Message-Id: <20230105134622.254560-23-arnd@kernel.org>
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

With the TMIO MFD support removed, the framebuffer driver can be
removed as well.

Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/Kconfig  |   22 -
 drivers/video/fbdev/Makefile |    1 -
 drivers/video/fbdev/tmiofb.c | 1040 ----------------------------------
 3 files changed, 1063 deletions(-)
 delete mode 100644 drivers/video/fbdev/tmiofb.c

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 28febf400666..3152f1a06a39 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1871,28 +1871,6 @@ config FB_SH_MOBILE_LCDC
 	help
 	  Frame buffer driver for the on-chip SH-Mobile LCD controller.
 
-config FB_TMIO
-	tristate "Toshiba Mobile IO FrameBuffer support"
-	depends on FB && (MFD_TMIO || COMPILE_TEST)
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  Frame buffer driver for the Toshiba Mobile IO integrated as found
-	  on the Sharp SL-6000 series
-
-	  This driver is also available as a module ( = code which can be
-	  inserted and removed from the running kernel whenever you want). The
-	  module will be called tmiofb. If you want to compile it as a module,
-	  say M here and read <file:Documentation/kbuild/modules.rst>.
-
-	  If unsure, say N.
-
-config FB_TMIO_ACCELL
-	bool "tmiofb acceleration"
-	depends on FB_TMIO
-	default y
-
 config FB_S3C
 	tristate "Samsung S3C framebuffer support"
 	depends on FB && HAVE_CLK && HAS_IOMEM
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index 1bb870b98848..e5206c3331d6 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -85,7 +85,6 @@ obj-$(CONFIG_FB_PXA168)		  += pxa168fb.o
 obj-$(CONFIG_PXA3XX_GCU)	  += pxa3xx-gcu.o
 obj-$(CONFIG_MMP_DISP)           += mmp/
 obj-$(CONFIG_FB_W100)		  += w100fb.o
-obj-$(CONFIG_FB_TMIO)		  += tmiofb.o
 obj-$(CONFIG_FB_AU1100)		  += au1100fb.o
 obj-$(CONFIG_FB_AU1200)		  += au1200fb.o
 obj-$(CONFIG_FB_VT8500)		  += vt8500lcdfb.o
diff --git a/drivers/video/fbdev/tmiofb.c b/drivers/video/fbdev/tmiofb.c
deleted file mode 100644
index 50111966c981..000000000000
-- 
2.39.0

