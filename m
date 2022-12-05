Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1AC6420B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 01:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiLEANz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 19:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiLEANx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 19:13:53 -0500
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B676E101C0
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 16:13:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 9338C20147;
        Mon,  5 Dec 2022 01:13:51 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8OIftdRiWjX4; Mon,  5 Dec 2022 01:13:51 +0100 (CET)
Received: from begin (lfbn-bor-1-376-208.w109-215.abo.wanadoo.fr [109.215.91.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 3F81120116;
        Mon,  5 Dec 2022 01:13:51 +0100 (CET)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@aquilenet.fr>)
        id 1p1z7G-00FkeH-2u;
        Mon, 05 Dec 2022 01:13:50 +0100
Message-ID: <20221205000807.896278194@ens-lyon.org>
User-Agent: quilt/0.66
Date:   Mon, 05 Dec 2022 01:07:42 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org
Cc:     linux-kernel@vger.kernel.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [patch 3/3] VT: Bump font size limitation to 64x128 pixels
References: <20221205000739.583233140@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves 32x32 font size limitation checking down to drivers, so that
fbcon can allow large fonts.

We still keep a limitation to 64x128 pixels so as to have a simple bounded
allocation for con_font_get and in the userland kbd tool. That glyph size
will however be enough to have 128x36 characters on a "16/9 8K display".

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Index: linux-6.0/drivers/tty/vt/vt.c
===================================================================
--- linux-6.0.orig/drivers/tty/vt/vt.c
+++ linux-6.0/drivers/tty/vt/vt.c
@@ -4575,17 +4575,20 @@ void reset_palette(struct vc_data *vc)
 /*
  *  Font switching
  *
- *  Currently we only support fonts up to 32 pixels wide, at a maximum height
- *  of 32 pixels. Userspace fontdata is stored with 32 bytes (shorts/ints, 
- *  depending on width) reserved for each character which is kinda wasty, but 
- *  this is done in order to maintain compatibility with the EGA/VGA fonts. It 
- *  is up to the actual low-level console-driver convert data into its favorite
- *  format (maybe we should add a `fontoffset' field to the `display'
- *  structure so we won't have to convert the fontdata all the time.
+ *  Currently we only support fonts up to 128 pixels wide, at a maximum height
+ *  of 128 pixels. Userspace fontdata may have to be stored with 32 bytes
+ *  (shorts/ints, depending on width) reserved for each character which is
+ *  kinda wasty, but this is done in order to maintain compatibility with the
+ *  EGA/VGA fonts. It is up to the actual low-level console-driver convert data
+ *  into its favorite format (maybe we should add a `fontoffset' field to the
+ *  `display' structure so we won't have to convert the fontdata all the time.
  *  /Jes
  */
 
-#define max_font_size 65536
+#define max_font_width	64
+#define max_font_height	128
+#define max_font_glyphs	512
+#define max_font_size	(max_font_glyphs*max_font_width*max_font_height)
 
 static int con_font_get(struct vc_data *vc, struct console_font_op *op)
 {
@@ -4645,9 +4648,10 @@ static int con_font_set(struct vc_data *
 		return -EINVAL;
 	if (!op->data)
 		return -EINVAL;
-	if (op->charcount > 512)
+	if (op->charcount > max_font_glyphs)
 		return -EINVAL;
-	if (op->width <= 0 || op->width > 32 || !op->height || op->height > 32)
+	if (op->width <= 0 || op->width > max_font_width || !op->height ||
+	    op->height > max_font_height)
 		return -EINVAL;
 	if (vpitch < op->height)
 		return -EINVAL;
Index: linux-6.0/drivers/usb/misc/sisusbvga/sisusb_con.c
===================================================================
--- linux-6.0.orig/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ linux-6.0/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -1203,7 +1203,7 @@ sisusbcon_font_set(struct vc_data *c, st
 	struct sisusb_usb_data *sisusb;
 	unsigned charcount = font->charcount;
 
-	if (font->width != 8 || vpitch != 32 ||
+	if (font->width != 8 || font->height > 32 || vpitch != 32 ||
 	    (charcount != 256 && charcount != 512))
 		return -EINVAL;
 
Index: linux-6.0/drivers/video/console/vgacon.c
===================================================================
--- linux-6.0.orig/drivers/video/console/vgacon.c
+++ linux-6.0/drivers/video/console/vgacon.c
@@ -1037,7 +1037,7 @@ static int vgacon_font_set(struct vc_dat
 	if (vga_video_type < VIDEO_TYPE_EGAM)
 		return -EINVAL;
 
-	if (font->width != VGA_FONTWIDTH || vpitch != 32 ||
+	if (font->width != VGA_FONTWIDTH || font->height > 32 || vpitch != 32 ||
 	    (charcount != 256 && charcount != 512))
 		return -EINVAL;
 
Index: linux-6.0/drivers/video/fbdev/core/fbcon.c
===================================================================
--- linux-6.0.orig/drivers/video/fbdev/core/fbcon.c
+++ linux-6.0/drivers/video/fbdev/core/fbcon.c
@@ -2279,6 +2279,8 @@ static int fbcon_get_font(struct vc_data
 
 	font->width = vc->vc_font.width;
 	font->height = vc->vc_font.height;
+	if (font->height > vpitch)
+		return -ENOSPC;
 	font->charcount = vc->vc_hi_font_mask ? 512 : 256;
 	if (!font->data)
 		return 0;

