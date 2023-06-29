Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E71E7430C1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjF2Wwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjF2WwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6382D69
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688079085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAXyw5cSv19lHG5FT64qf0eoLGlTjWx7HZp8kfcWz1U=;
        b=QlJDXI8/WIuK8OPLdG2ouG/0q3nKHL5PTRboceABpoez7JUh4i2nJ/aRLc+nI89jnhR6hT
        8lc8JcdMVX4CLY1u1CgQz8ja3p77HZFpM5kkoh002j/slzsoH3L1mlSy4VyJpJDtUnlIkf
        yGu3a65YjVKjwYuOr0Ixqq9LwugC574=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-CuHuE50HP66X3eDFXb0p0w-1; Thu, 29 Jun 2023 18:51:22 -0400
X-MC-Unique: CuHuE50HP66X3eDFXb0p0w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30932d15a30so755216f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688079081; x=1690671081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAXyw5cSv19lHG5FT64qf0eoLGlTjWx7HZp8kfcWz1U=;
        b=dHEjGxUQokhuLortMX0GjyYealddJVDL135NZJQt4rwNM9q7iT4GVjEdWvAQjecQZg
         3nDIoivhlF/i2pexX+u9CYrBCyCi39WXDJb4hCWRr0oN+9M1H1DOfbpxDVQ5uxn03fJo
         BDSTV+2h+iCfyDYFQ2/MXfYAAYn0Sbmp8Z7Dk3MuWmPDDjcZO3vOVEk1DrDVd27FDyc+
         U6H70ZnMfXo18hVr0OTXwhQTRFjGhyYHCn65Uz9KUuIjhGzzFqeoy27ADaEc4Zb4hX5A
         KvNCkzOHCC5XHa8rTAk3coKGO1so/vKukOlX4nYx7wTsU8cDvCaYSw787ORIAUvwx4mn
         +XvQ==
X-Gm-Message-State: ABy/qLbq9X67qDC7Jr7dubKVaXr4x8i43ZNdKc3b46ZnT/y2lLLC8Odg
        EhZu3fsbIQIUxNB0iPWvwm5CtlB/JtMx88LC1P+9KXFLDsYCa8ox2981KiuvHQxMfMrFKAB87W5
        w9j1PFe5ofPymEl9RJq1bbrScvsYzs5LrusWRTmoeQIuwh3UhEYqDa5poeLkZabsOWK9FbuEVEy
        JDs0tBTTQ=
X-Received: by 2002:a5d:4688:0:b0:313:f8ca:989f with SMTP id u8-20020a5d4688000000b00313f8ca989fmr740621wrq.10.1688079081018;
        Thu, 29 Jun 2023 15:51:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFZ7b9QmVUmLNGAXuU3X5c4NLO4EQJ8+1xJQDGKxGNR00wBDY9lQ9qneS1jBj0+hGrRnG7Zzg==
X-Received: by 2002:a5d:4688:0:b0:313:f8ca:989f with SMTP id u8-20020a5d4688000000b00313f8ca989fmr740589wrq.10.1688079080610;
        Thu, 29 Jun 2023 15:51:20 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i6-20020adff306000000b00311339f5b06sm16795690wro.57.2023.06.29.15.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 15:51:20 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH 1/2] fbdev: Split frame buffer support in FB and FB_CORE symbols
Date:   Fri, 30 Jun 2023 00:51:03 +0200
Message-ID: <20230629225113.297512-2-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629225113.297512-1-javierm@redhat.com>
References: <20230629225113.297512-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the CONFIG_FB option has to be enabled even if no legacy fbdev
drivers are needed (e.g: only to have support for framebuffer consoles).

The DRM subsystem has a fbdev emulation layer, but depends on CONFIG_FB
and so it can only be enabled if that dependency is enabled as well.

That means fbdev drivers have to be explicitly disabled if users want to
enable CONFIG_FB, only to use fbcon and/or the DRM fbdev emulation layer.

This patch introduces a CONFIG_FB_CORE option that could be enabled just
to have the core support needed for CONFIG_DRM_FBDEV_EMULATION, allowing
CONFIG_FB to be disabled (and automatically disabling all fbdev drivers).

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 arch/x86/Makefile                 |  2 +-
 arch/x86/video/Makefile           |  2 +-
 drivers/video/console/Kconfig     |  2 +-
 drivers/video/fbdev/Kconfig       | 62 ++++++++++++++++++-------------
 drivers/video/fbdev/core/Makefile | 14 +++----
 5 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index b39975977c03..89a02e69be5f 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -259,7 +259,7 @@ drivers-$(CONFIG_PCI)            += arch/x86/pci/
 # suspend and hibernation support
 drivers-$(CONFIG_PM) += arch/x86/power/
 
-drivers-$(CONFIG_FB) += arch/x86/video/
+drivers-$(CONFIG_FB_CORE) += arch/x86/video/
 
 ####
 # boot loader support. Several targets are kept for legacy purposes
diff --git a/arch/x86/video/Makefile b/arch/x86/video/Makefile
index 11640c116115..5ebe48752ffc 100644
--- a/arch/x86/video/Makefile
+++ b/arch/x86/video/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_FB)               += fbdev.o
+obj-$(CONFIG_FB_CORE)		+= fbdev.o
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index a2a88d42edf0..1b5a319971ed 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -72,7 +72,7 @@ config DUMMY_CONSOLE_ROWS
 
 config FRAMEBUFFER_CONSOLE
 	bool "Framebuffer Console support"
-	depends on FB && !UML
+	depends on FB_CORE && !UML
 	select VT_HW_CONSOLE_BINDING
 	select CRC32
 	select FONT_SUPPORT
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index cecf15418632..74d7a305657a 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -6,10 +6,8 @@
 config FB_NOTIFY
 	bool
 
-menuconfig FB
-	tristate "Support for frame buffer devices"
-	select FB_NOTIFY
-	select VIDEO_CMDLINE
+menuconfig FB_CORE
+	tristate "Core support for frame buffer devices"
 	help
 	  The frame buffer device provides an abstraction for the graphics
 	  hardware. It represents the frame buffer of some video hardware and
@@ -33,6 +31,20 @@ menuconfig FB
 	  <http://www.munted.org.uk/programming/Framebuffer-HOWTO-1.3.html> for more
 	  information.
 
+	  This options enables the core support for frame buffer devices.
+
+menuconfig FB
+	tristate "Support for frame buffer device drivers"
+	depends on FB_CORE
+	select FB_NOTIFY
+	select VIDEO_CMDLINE
+	help
+	  This enables support for native frame buffer device (fbdev) drivers.
+
+	  The DRM subsystem provides support for emulated frame buffer devices
+	  on top of KMS drivers, but this option allows legacy fbdev drivers to
+	  be enabled as well.
+
 	  Say Y here and to the driver for your graphics board below if you
 	  are compiling a kernel for a non-x86 architecture.
 
@@ -44,7 +56,7 @@ menuconfig FB
 
 config FIRMWARE_EDID
 	bool "Enable firmware EDID"
-	depends on FB
+	depends on FB_CORE
 	help
 	  This enables access to the EDID transferred from the firmware.
 	  On the i386, this is from the Video BIOS. Enable this if DDC/I2C
@@ -59,7 +71,7 @@ config FIRMWARE_EDID
 
 config FB_DEVICE
 	bool "Provide legacy /dev/fb* device"
-	depends on FB
+	depends on FB_CORE
 	default y
 	help
 	  Say Y here if you want the legacy /dev/fb* device file and
@@ -69,13 +81,13 @@ config FB_DEVICE
 
 config FB_DDC
 	tristate
-	depends on FB
+	depends on FB_CORE
 	select I2C_ALGOBIT
 	select I2C
 
 config FB_CFB_FILLRECT
 	tristate
-	depends on FB
+	depends on FB_CORE
 	help
 	  Include the cfb_fillrect function for generic software rectangle
 	  filling. This is used by drivers that don't provide their own
@@ -83,7 +95,7 @@ config FB_CFB_FILLRECT
 
 config FB_CFB_COPYAREA
 	tristate
-	depends on FB
+	depends on FB_CORE
 	help
 	  Include the cfb_copyarea function for generic software area copying.
 	  This is used by drivers that don't provide their own (accelerated)
@@ -91,7 +103,7 @@ config FB_CFB_COPYAREA
 
 config FB_CFB_IMAGEBLIT
 	tristate
-	depends on FB
+	depends on FB_CORE
 	help
 	  Include the cfb_imageblit function for generic software image
 	  blitting. This is used by drivers that don't provide their own
@@ -99,7 +111,7 @@ config FB_CFB_IMAGEBLIT
 
 config FB_CFB_REV_PIXELS_IN_BYTE
 	bool
-	depends on FB
+	depends on FB_CORE
 	help
 	  Allow generic frame-buffer functions to work on displays with 1, 2
 	  and 4 bits per pixel depths which has opposite order of pixels in
@@ -107,7 +119,7 @@ config FB_CFB_REV_PIXELS_IN_BYTE
 
 config FB_SYS_FILLRECT
 	tristate
-	depends on FB
+	depends on FB_CORE
 	help
 	  Include the sys_fillrect function for generic software rectangle
 	  filling. This is used by drivers that don't provide their own
@@ -115,7 +127,7 @@ config FB_SYS_FILLRECT
 
 config FB_SYS_COPYAREA
 	tristate
-	depends on FB
+	depends on FB_CORE
 	help
 	  Include the sys_copyarea function for generic software area copying.
 	  This is used by drivers that don't provide their own (accelerated)
@@ -123,7 +135,7 @@ config FB_SYS_COPYAREA
 
 config FB_SYS_IMAGEBLIT
 	tristate
-	depends on FB
+	depends on FB_CORE
 	help
 	  Include the sys_imageblit function for generic software image
 	  blitting. This is used by drivers that don't provide their own
@@ -162,22 +174,22 @@ endchoice
 
 config FB_SYS_FOPS
 	tristate
-	depends on FB
+	depends on FB_CORE
 
 config FB_DEFERRED_IO
 	bool
-	depends on FB
+	depends on FB_CORE
 
 config FB_IO_HELPERS
 	bool
-	depends on FB
+	depends on FB_CORE
 	select FB_CFB_COPYAREA
 	select FB_CFB_FILLRECT
 	select FB_CFB_IMAGEBLIT
 
 config FB_SYS_HELPERS
 	bool
-	depends on FB
+	depends on FB_CORE
 	select FB_SYS_COPYAREA
 	select FB_SYS_FILLRECT
 	select FB_SYS_FOPS
@@ -185,34 +197,34 @@ config FB_SYS_HELPERS
 
 config FB_SYS_HELPERS_DEFERRED
 	bool
-	depends on FB
+	depends on FB_CORE
 	select FB_DEFERRED_IO
 	select FB_SYS_HELPERS
 
 config FB_HECUBA
 	tristate
-	depends on FB
+	depends on FB_CORE
 	depends on FB_DEFERRED_IO
 
 config FB_SVGALIB
 	tristate
-	depends on FB
+	depends on FB_CORE
 	help
 	  Common utility functions useful to fbdev drivers of VGA-based
 	  cards.
 
 config FB_MACMODES
 	tristate
-	depends on FB
+	depends on FB_CORE
 
 config FB_BACKLIGHT
 	tristate
-	depends on FB
+	depends on FB_CORE
 	select BACKLIGHT_CLASS_DEVICE
 
 config FB_MODE_HELPERS
 	bool "Enable Video Mode Handling Helpers"
-	depends on FB
+	depends on FB_CORE
 	help
 	  This enables functions for handling video modes using the
 	  Generalized Timing Formula and the EDID parser. A few drivers rely
@@ -222,7 +234,7 @@ config FB_MODE_HELPERS
 
 config FB_TILEBLITTING
 	bool "Enable Tile Blitting Support"
-	depends on FB
+	depends on FB_CORE
 	help
 	  This enables tile blitting.  Tile blitting is a drawing technique
 	  where the screen is divided into rectangular sections (tiles), whereas
diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
index 9150bafd9e89..88ef39dad03b 100644
--- a/drivers/video/fbdev/core/Makefile
+++ b/drivers/video/fbdev/core/Makefile
@@ -1,22 +1,22 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_FB_NOTIFY)           += fb_notify.o
-obj-$(CONFIG_FB)                  += fb.o
-fb-y                              := fb_backlight.o \
+obj-$(CONFIG_FB_CORE)             += fb_core.o
+fb_core-y                         := fb_backlight.o \
                                      fb_info.o \
                                      fbmem.o fbmon.o fbcmap.o \
                                      modedb.o fbcvt.o fb_cmdline.o fb_io_fops.o
-fb-$(CONFIG_FB_DEFERRED_IO)       += fb_defio.o
-fb-$(CONFIG_FB_DEVICE)            += fb_chrdev.o \
+fb_core-$(CONFIG_FB_DEFERRED_IO)  += fb_defio.o
+fb_core-$(CONFIG_FB_DEVICE)       += fb_chrdev.o \
                                      fb_procfs.o \
                                      fbsysfs.o
 
 ifeq ($(CONFIG_FRAMEBUFFER_CONSOLE),y)
-fb-y				  += fbcon.o bitblit.o softcursor.o
+fb_core-y			  += fbcon.o bitblit.o softcursor.o
 ifeq ($(CONFIG_FB_TILEBLITTING),y)
-fb-y				  += tileblit.o
+fb_core-y			  += tileblit.o
 endif
 ifeq ($(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION),y)
-fb-y				  += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
+fb_core-y			  += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
 				     fbcon_ccw.o
 endif
 endif
-- 
2.41.0

