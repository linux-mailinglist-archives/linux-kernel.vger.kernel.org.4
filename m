Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A8E74660C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 01:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjGCXGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 19:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjGCXGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 19:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D91E6D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 16:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688425546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ytjztKBchoEvkVL0L2ZNLjWuHPbCVbw9mTADb8BljqM=;
        b=iyVbExEM/Ig8+OI6/DjEsn92J0UflPkClLvYQQya1WWUayIHv2d5nsog+QFXuI5VgFIP3g
        jF5+2814X86yC/By2+/bWbczg57p3ZHKI3V6qHwqXK+Mw9yeK8jj+6TSxLxmDisGERmRYE
        qaSKsMhxtFso8FLSxHdqiADEnIqA4lE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-TBFi6Dg1P4iwMRlenfUFmA-1; Mon, 03 Jul 2023 19:05:45 -0400
X-MC-Unique: TBFi6Dg1P4iwMRlenfUFmA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-314256aedcbso1691217f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 16:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688425544; x=1691017544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytjztKBchoEvkVL0L2ZNLjWuHPbCVbw9mTADb8BljqM=;
        b=kgh8PmFx3Vzdo3ZBwBtGi22TfgJA09xJptdhzbXqToUzJ+tSFh2rJ0S+WWy8JuKd/s
         +af+W6d3IEqH/adRo7rQgfUVBu/DWM0KsZO6N1mjp3x5QlspkI2Ct0tsERYVEM3P2hBR
         0HcA5ZBFT7GILOSzo63Zwccta7elFEWit3/Hz2OoAV7m7L1S5Ugd8aLuLBpBXYaj3RZW
         wpAek05K8sAYzK5HIlw3+FyAUTeLCVxi5XGrisHEdlRDyiSzbRpENWWYztKldwt1Ekwm
         AV/EDKbGSQ57fYolnrXn4IkmYe+ptPe8iZ5C/cdgSA5dvlukcRvN2aLQGptZXyAlTSIM
         ae5g==
X-Gm-Message-State: ABy/qLZW42o/HFsabe8dxoxtMnTM+hKlAz7rmbe4evbwYBCN7+DMKxWz
        1mNnJnCdxC4kGrsEFxs/EcIwioD6b4eEqnTyQJUhmSzK+BNEWyD6zMGnk46tL4otpLsMaX7pfJM
        ZNfOXslXNxCyrxa4/OxAOcPFh4yz/VPDCIIFlEM/oNwtOSNnXRfRnrYHcgtls57r3wDNMjs25rb
        V5EMpMsY0=
X-Received: by 2002:a5d:554d:0:b0:314:824:3777 with SMTP id g13-20020a5d554d000000b0031408243777mr8906999wrw.48.1688425544156;
        Mon, 03 Jul 2023 16:05:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGzsi7jw2pVMvf1cUHJuTkFvIkETnk1vKsAwCVPqrqfEA796y4p5Tm6goJkpt2WZcJLjJCgFg==
X-Received: by 2002:a5d:554d:0:b0:314:824:3777 with SMTP id g13-20020a5d554d000000b0031408243777mr8906981wrw.48.1688425543753;
        Mon, 03 Jul 2023 16:05:43 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id cw13-20020a056000090d00b003112f836d4esm26504465wrb.85.2023.07.03.16.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 16:05:43 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v4 2/5] fbdev: Move core fbdev symbols to a separate Kconfig file
Date:   Tue,  4 Jul 2023 01:05:26 +0200
Message-ID: <20230703230534.997525-3-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703230534.997525-1-javierm@redhat.com>
References: <20230703230534.997525-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drivers/video/fbdev/Kconfig defines both symbols for fbdev drivers and
core fbdev symbols, that can be enabled independently of the fbdev drivers.

Split the Kconfig in two, one that only has the symbols for fbdev drivers
and another one that contains the fbdev core symbols.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/video/fbdev/Kconfig      | 203 +------------------------------
 drivers/video/fbdev/core/Kconfig | 202 ++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+), 201 deletions(-)
 create mode 100644 drivers/video/fbdev/core/Kconfig

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index cecf15418632..06199f044546 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -3,9 +3,6 @@
 # fbdev configuration
 #
 
-config FB_NOTIFY
-	bool
-
 menuconfig FB
 	tristate "Support for frame buffer devices"
 	select FB_NOTIFY
@@ -42,204 +39,6 @@ menuconfig FB
 	  (e.g. an accelerated X server) and that are not frame buffer
 	  device-aware may cause unexpected results. If unsure, say N.
 
-config FIRMWARE_EDID
-	bool "Enable firmware EDID"
-	depends on FB
-	help
-	  This enables access to the EDID transferred from the firmware.
-	  On the i386, this is from the Video BIOS. Enable this if DDC/I2C
-	  transfers do not work for your driver and if you are using
-	  nvidiafb, i810fb or savagefb.
-
-	  In general, choosing Y for this option is safe.  If you
-	  experience extremely long delays while booting before you get
-	  something on your display, try setting this to N.  Matrox cards in
-	  combination with certain motherboards and monitors are known to
-	  suffer from this problem.
-
-config FB_DEVICE
-	bool "Provide legacy /dev/fb* device"
-	depends on FB
-	default y
-	help
-	  Say Y here if you want the legacy /dev/fb* device file and
-	  interfaces within sysfs anc procfs. It is only required if you
-	  have userspace programs that depend on fbdev for graphics output.
-	  This does not affect the framebuffer console. If unsure, say N.
-
-config FB_DDC
-	tristate
-	depends on FB
-	select I2C_ALGOBIT
-	select I2C
-
-config FB_CFB_FILLRECT
-	tristate
-	depends on FB
-	help
-	  Include the cfb_fillrect function for generic software rectangle
-	  filling. This is used by drivers that don't provide their own
-	  (accelerated) version.
-
-config FB_CFB_COPYAREA
-	tristate
-	depends on FB
-	help
-	  Include the cfb_copyarea function for generic software area copying.
-	  This is used by drivers that don't provide their own (accelerated)
-	  version.
-
-config FB_CFB_IMAGEBLIT
-	tristate
-	depends on FB
-	help
-	  Include the cfb_imageblit function for generic software image
-	  blitting. This is used by drivers that don't provide their own
-	  (accelerated) version.
-
-config FB_CFB_REV_PIXELS_IN_BYTE
-	bool
-	depends on FB
-	help
-	  Allow generic frame-buffer functions to work on displays with 1, 2
-	  and 4 bits per pixel depths which has opposite order of pixels in
-	  byte order to bytes in long order.
-
-config FB_SYS_FILLRECT
-	tristate
-	depends on FB
-	help
-	  Include the sys_fillrect function for generic software rectangle
-	  filling. This is used by drivers that don't provide their own
-	  (accelerated) version and the framebuffer is in system RAM.
-
-config FB_SYS_COPYAREA
-	tristate
-	depends on FB
-	help
-	  Include the sys_copyarea function for generic software area copying.
-	  This is used by drivers that don't provide their own (accelerated)
-	  version and the framebuffer is in system RAM.
-
-config FB_SYS_IMAGEBLIT
-	tristate
-	depends on FB
-	help
-	  Include the sys_imageblit function for generic software image
-	  blitting. This is used by drivers that don't provide their own
-	  (accelerated) version and the framebuffer is in system RAM.
-
-config FB_PROVIDE_GET_FB_UNMAPPED_AREA
-	bool
-	depends on FB
-	help
-	  Allow generic frame-buffer to provide get_fb_unmapped_area
-	  function to provide shareable character device support on nommu.
-
-menuconfig FB_FOREIGN_ENDIAN
-	bool "Framebuffer foreign endianness support"
-	depends on FB
-	help
-	  This menu will let you enable support for the framebuffers with
-	  non-native endianness (e.g. Little-Endian framebuffer on a
-	  Big-Endian machine). Most probably you don't have such hardware,
-	  so it's safe to say "n" here.
-
-choice
-	prompt "Choice endianness support"
-	depends on FB_FOREIGN_ENDIAN
-
-config FB_BOTH_ENDIAN
-	bool "Support for Big- and Little-Endian framebuffers"
-
-config FB_BIG_ENDIAN
-	bool "Support for Big-Endian framebuffers only"
-
-config FB_LITTLE_ENDIAN
-	bool "Support for Little-Endian framebuffers only"
-
-endchoice
-
-config FB_SYS_FOPS
-	tristate
-	depends on FB
-
-config FB_DEFERRED_IO
-	bool
-	depends on FB
-
-config FB_IO_HELPERS
-	bool
-	depends on FB
-	select FB_CFB_COPYAREA
-	select FB_CFB_FILLRECT
-	select FB_CFB_IMAGEBLIT
-
-config FB_SYS_HELPERS
-	bool
-	depends on FB
-	select FB_SYS_COPYAREA
-	select FB_SYS_FILLRECT
-	select FB_SYS_FOPS
-	select FB_SYS_IMAGEBLIT
-
-config FB_SYS_HELPERS_DEFERRED
-	bool
-	depends on FB
-	select FB_DEFERRED_IO
-	select FB_SYS_HELPERS
-
-config FB_HECUBA
-	tristate
-	depends on FB
-	depends on FB_DEFERRED_IO
-
-config FB_SVGALIB
-	tristate
-	depends on FB
-	help
-	  Common utility functions useful to fbdev drivers of VGA-based
-	  cards.
-
-config FB_MACMODES
-	tristate
-	depends on FB
-
-config FB_BACKLIGHT
-	tristate
-	depends on FB
-	select BACKLIGHT_CLASS_DEVICE
-
-config FB_MODE_HELPERS
-	bool "Enable Video Mode Handling Helpers"
-	depends on FB
-	help
-	  This enables functions for handling video modes using the
-	  Generalized Timing Formula and the EDID parser. A few drivers rely
-	  on this feature such as the radeonfb, rivafb, and the i810fb. If
-	  your driver does not take advantage of this feature, choosing Y will
-	  just increase the kernel size by about 5K.
-
-config FB_TILEBLITTING
-	bool "Enable Tile Blitting Support"
-	depends on FB
-	help
-	  This enables tile blitting.  Tile blitting is a drawing technique
-	  where the screen is divided into rectangular sections (tiles), whereas
-	  the standard blitting divides the screen into pixels. Because the
-	  default drawing element is a tile, drawing functions will be passed
-	  parameters in terms of number of tiles instead of number of pixels.
-	  For example, to draw a single character, instead of using bitmaps,
-	  an index to an array of bitmaps will be used.  To clear or move a
-	  rectangular section of a screen, the rectangle will be described in
-	  terms of number of tiles in the x- and y-axis.
-
-	  This is particularly important to one driver, matroxfb.  If
-	  unsure, say N.
-
-comment "Frame buffer hardware drivers"
-	depends on FB
-
 config FB_GRVGA
 	tristate "Aeroflex Gaisler framebuffer support"
 	depends on FB && SPARC
@@ -2244,3 +2043,5 @@ config FB_SM712
 source "drivers/video/fbdev/omap/Kconfig"
 source "drivers/video/fbdev/omap2/Kconfig"
 source "drivers/video/fbdev/mmp/Kconfig"
+
+source "drivers/video/fbdev/core/Kconfig"
diff --git a/drivers/video/fbdev/core/Kconfig b/drivers/video/fbdev/core/Kconfig
new file mode 100644
index 000000000000..8e308d12c57b
--- /dev/null
+++ b/drivers/video/fbdev/core/Kconfig
@@ -0,0 +1,202 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# fbdev core configuration
+#
+
+config FB_NOTIFY
+	bool
+
+config FIRMWARE_EDID
+	bool "Enable firmware EDID"
+	depends on FB
+	help
+	  This enables access to the EDID transferred from the firmware.
+	  On the i386, this is from the Video BIOS. Enable this if DDC/I2C
+	  transfers do not work for your driver and if you are using
+	  nvidiafb, i810fb or savagefb.
+
+	  In general, choosing Y for this option is safe.  If you
+	  experience extremely long delays while booting before you get
+	  something on your display, try setting this to N.  Matrox cards in
+	  combination with certain motherboards and monitors are known to
+	  suffer from this problem.
+
+config FB_DEVICE
+	bool "Provide legacy /dev/fb* device"
+	depends on FB
+	default y
+	help
+	  Say Y here if you want the legacy /dev/fb* device file and
+	  interfaces within sysfs anc procfs. It is only required if you
+	  have userspace programs that depend on fbdev for graphics output.
+	  This does not affect the framebuffer console. If unsure, say N.
+
+config FB_DDC
+	tristate
+	depends on FB
+	select I2C_ALGOBIT
+	select I2C
+
+config FB_CFB_FILLRECT
+	tristate
+	depends on FB
+	help
+	  Include the cfb_fillrect function for generic software rectangle
+	  filling. This is used by drivers that don't provide their own
+	  (accelerated) version.
+
+config FB_CFB_COPYAREA
+	tristate
+	depends on FB
+	help
+	  Include the cfb_copyarea function for generic software area copying.
+	  This is used by drivers that don't provide their own (accelerated)
+	  version.
+
+config FB_CFB_IMAGEBLIT
+	tristate
+	depends on FB
+	help
+	  Include the cfb_imageblit function for generic software image
+	  blitting. This is used by drivers that don't provide their own
+	  (accelerated) version.
+
+config FB_CFB_REV_PIXELS_IN_BYTE
+	bool
+	depends on FB
+	help
+	  Allow generic frame-buffer functions to work on displays with 1, 2
+	  and 4 bits per pixel depths which has opposite order of pixels in
+	  byte order to bytes in long order.
+
+config FB_SYS_FILLRECT
+	tristate
+	depends on FB
+	help
+	  Include the sys_fillrect function for generic software rectangle
+	  filling. This is used by drivers that don't provide their own
+	  (accelerated) version and the framebuffer is in system RAM.
+
+config FB_SYS_COPYAREA
+	tristate
+	depends on FB
+	help
+	  Include the sys_copyarea function for generic software area copying.
+	  This is used by drivers that don't provide their own (accelerated)
+	  version and the framebuffer is in system RAM.
+
+config FB_SYS_IMAGEBLIT
+	tristate
+	depends on FB
+	help
+	  Include the sys_imageblit function for generic software image
+	  blitting. This is used by drivers that don't provide their own
+	  (accelerated) version and the framebuffer is in system RAM.
+
+config FB_PROVIDE_GET_FB_UNMAPPED_AREA
+	bool
+	depends on FB
+	help
+	  Allow generic frame-buffer to provide get_fb_unmapped_area
+	  function to provide shareable character device support on nommu.
+
+menuconfig FB_FOREIGN_ENDIAN
+	bool "Framebuffer foreign endianness support"
+	depends on FB
+	help
+	  This menu will let you enable support for the framebuffers with
+	  non-native endianness (e.g. Little-Endian framebuffer on a
+	  Big-Endian machine). Most probably you don't have such hardware,
+	  so it's safe to say "n" here.
+
+choice
+	prompt "Choice endianness support"
+	depends on FB_FOREIGN_ENDIAN
+
+config FB_BOTH_ENDIAN
+	bool "Support for Big- and Little-Endian framebuffers"
+
+config FB_BIG_ENDIAN
+	bool "Support for Big-Endian framebuffers only"
+
+config FB_LITTLE_ENDIAN
+	bool "Support for Little-Endian framebuffers only"
+
+endchoice
+
+config FB_SYS_FOPS
+	tristate
+	depends on FB
+
+config FB_DEFERRED_IO
+	bool
+	depends on FB
+
+config FB_IO_HELPERS
+	bool
+	depends on FB
+	select FB_CFB_COPYAREA
+	select FB_CFB_FILLRECT
+	select FB_CFB_IMAGEBLIT
+
+config FB_SYS_HELPERS
+	bool
+	depends on FB
+	select FB_SYS_COPYAREA
+	select FB_SYS_FILLRECT
+	select FB_SYS_FOPS
+	select FB_SYS_IMAGEBLIT
+
+config FB_SYS_HELPERS_DEFERRED
+	bool
+	depends on FB
+	select FB_DEFERRED_IO
+	select FB_SYS_HELPERS
+
+config FB_HECUBA
+	tristate
+	depends on FB
+	depends on FB_DEFERRED_IO
+
+config FB_SVGALIB
+	tristate
+	depends on FB
+	help
+	  Common utility functions useful to fbdev drivers of VGA-based
+	  cards.
+
+config FB_MACMODES
+	tristate
+	depends on FB
+
+config FB_BACKLIGHT
+	tristate
+	depends on FB
+	select BACKLIGHT_CLASS_DEVICE
+
+config FB_MODE_HELPERS
+	bool "Enable Video Mode Handling Helpers"
+	depends on FB
+	help
+	  This enables functions for handling video modes using the
+	  Generalized Timing Formula and the EDID parser. A few drivers rely
+	  on this feature such as the radeonfb, rivafb, and the i810fb. If
+	  your driver does not take advantage of this feature, choosing Y will
+	  just increase the kernel size by about 5K.
+
+config FB_TILEBLITTING
+	bool "Enable Tile Blitting Support"
+	depends on FB
+	help
+	  This enables tile blitting.  Tile blitting is a drawing technique
+	  where the screen is divided into rectangular sections (tiles), whereas
+	  the standard blitting divides the screen into pixels. Because the
+	  default drawing element is a tile, drawing functions will be passed
+	  parameters in terms of number of tiles instead of number of pixels.
+	  For example, to draw a single character, instead of using bitmaps,
+	  an index to an array of bitmaps will be used.  To clear or move a
+	  rectangular section of a screen, the rectangle will be described in
+	  terms of number of tiles in the x- and y-axis.
+
+	  This is particularly important to one driver, matroxfb.  If
+	  unsure, say N.
-- 
2.41.0

