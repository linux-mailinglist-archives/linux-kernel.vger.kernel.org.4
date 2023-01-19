Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB08E673D54
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjASPUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjASPT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:19:57 -0500
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607278102C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:19:55 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 9ECA52010A;
        Thu, 19 Jan 2023 16:19:53 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WYkChXdJS0qk; Thu, 19 Jan 2023 16:19:53 +0100 (CET)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 071C3200FB;
        Thu, 19 Jan 2023 16:19:53 +0100 (CET)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1pIWhk-008cHp-29;
        Thu, 19 Jan 2023 16:19:52 +0100
Message-ID: <20230119151934.932642243@ens-lyon.org>
User-Agent: quilt/0.66
Date:   Thu, 19 Jan 2023 16:19:15 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org
Cc:     linux-kernel@vger.kernel.org,
        "linux-kernel@vger.kernel.org, Samuel Thibault" 
        <samuel.thibault@ens-lyon.org>
Subject: [PATCHv3 1/3] VT: Add height parameter to con_font_get/set consw operations
References: <20230119151914.931619963@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current con_font_get/set API currently hardcodes a 32-pixel-tall
limitation, which only dates from the old VGA hardware which could not
handle taller fonts than that.

This change just adds a vpitch parameter to release this
constraint. Drivers which do not support vpitch != 32 can just return
EINVAL when it is not 32, font loading tools will revert to trying 32
and succeed.

This change makes the fbcon driver consider vpitch appropriately, thus
making it able to load large fonts.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
V1 -> V3: Drop (bogus) sisusb_con.c change, it was phased out

Index: linux-6.0/drivers/tty/vt/vt.c
===================================================================
--- linux-6.0.orig/drivers/tty/vt/vt.c
+++ linux-6.0/drivers/tty/vt/vt.c
@@ -4604,7 +4604,7 @@ static int con_font_get(struct vc_data *
 	if (vc->vc_mode != KD_TEXT)
 		rc = -EINVAL;
 	else if (vc->vc_sw->con_font_get)
-		rc = vc->vc_sw->con_font_get(vc, &font);
+		rc = vc->vc_sw->con_font_get(vc, &font, 32);
 	else
 		rc = -ENOSYS;
 	console_unlock();
@@ -4665,7 +4665,7 @@ static int con_font_set(struct vc_data *
 	else if (vc->vc_sw->con_font_set) {
 		if (vc_is_sel(vc))
 			clear_selection();
-		rc = vc->vc_sw->con_font_set(vc, &font, op->flags);
+		rc = vc->vc_sw->con_font_set(vc, &font, 32, op->flags);
 	} else
 		rc = -ENOSYS;
 	console_unlock();
Index: linux-6.0/drivers/video/console/vgacon.c
===================================================================
--- linux-6.0.orig/drivers/video/console/vgacon.c
+++ linux-6.0/drivers/video/console/vgacon.c
@@ -1029,7 +1029,7 @@ static int vgacon_adjust_height(struct v
 }
 
 static int vgacon_font_set(struct vc_data *c, struct console_font *font,
-			   unsigned int flags)
+			   unsigned int vpitch, unsigned int flags)
 {
 	unsigned charcount = font->charcount;
 	int rc;
@@ -1037,7 +1037,7 @@ static int vgacon_font_set(struct vc_dat
 	if (vga_video_type < VIDEO_TYPE_EGAM)
 		return -EINVAL;
 
-	if (font->width != VGA_FONTWIDTH ||
+	if (font->width != VGA_FONTWIDTH || vpitch != 32 ||
 	    (charcount != 256 && charcount != 512))
 		return -EINVAL;
 
@@ -1050,9 +1050,9 @@ static int vgacon_font_set(struct vc_dat
 	return rc;
 }
 
-static int vgacon_font_get(struct vc_data *c, struct console_font *font)
+static int vgacon_font_get(struct vc_data *c, struct console_font *font, unsigned int vpitch)
 {
-	if (vga_video_type < VIDEO_TYPE_EGAM)
+	if (vga_video_type < VIDEO_TYPE_EGAM || vpitch != 32)
 		return -EINVAL;
 
 	font->width = VGA_FONTWIDTH;
Index: linux-6.0/drivers/video/fbdev/core/fbcon.c
===================================================================
--- linux-6.0.orig/drivers/video/fbdev/core/fbcon.c
+++ linux-6.0/drivers/video/fbdev/core/fbcon.c
@@ -2271,7 +2271,7 @@ static int fbcon_debug_leave(struct vc_d
 	return 0;
 }
 
-static int fbcon_get_font(struct vc_data *vc, struct console_font *font)
+static int fbcon_get_font(struct vc_data *vc, struct console_font *font, unsigned int vpitch)
 {
 	u8 *fontdata = vc->vc_font.data;
 	u8 *data = font->data;
@@ -2290,8 +2290,8 @@ static int fbcon_get_font(struct vc_data
 
 		for (i = 0; i < font->charcount; i++) {
 			memcpy(data, fontdata, j);
-			memset(data + j, 0, 32 - j);
-			data += 32;
+			memset(data + j, 0, vpitch - j);
+			data += vpitch;
 			fontdata += j;
 		}
 	} else if (font->width <= 16) {
@@ -2301,8 +2301,8 @@ static int fbcon_get_font(struct vc_data
 
 		for (i = 0; i < font->charcount; i++) {
 			memcpy(data, fontdata, j);
-			memset(data + j, 0, 64 - j);
-			data += 64;
+			memset(data + j, 0, 2*vpitch - j);
+			data += 2*vpitch;
 			fontdata += j;
 		}
 	} else if (font->width <= 24) {
@@ -2316,8 +2316,8 @@ static int fbcon_get_font(struct vc_data
 				*data++ = fontdata[2];
 				fontdata += sizeof(u32);
 			}
-			memset(data, 0, 3 * (32 - j));
-			data += 3 * (32 - j);
+			memset(data, 0, 3 * (vpitch - j));
+			data += 3 * (vpitch - j);
 		}
 	} else {
 		j = vc->vc_font.height * 4;
@@ -2326,8 +2326,8 @@ static int fbcon_get_font(struct vc_data
 
 		for (i = 0; i < font->charcount; i++) {
 			memcpy(data, fontdata, j);
-			memset(data + j, 0, 128 - j);
-			data += 128;
+			memset(data + j, 0, 4 * vpitch - j);
+			data += 4 * vpitch;
 			fontdata += j;
 		}
 	}
@@ -2461,19 +2461,12 @@ err_out:
 }
 
 /*
- *  User asked to set font; we are guaranteed that
- *	a) width and height are in range 1..32
- *	b) charcount does not exceed 512
- *  but lets not assume that, since someone might someday want to use larger
- *  fonts. And charcount of 512 is small for unicode support.
- *
- *  However, user space gives the font in 32 rows , regardless of
- *  actual font height. So a new API is needed if support for larger fonts
- *  is ever implemented.
+ *  User asked to set font; we are guaranteed that charcount does not exceed 512
+ *  but lets not assume that, since charcount of 512 is small for unicode support.
  */
 
 static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
-			  unsigned int flags)
+			  unsigned int vpitch, unsigned int flags)
 {
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	unsigned charcount = font->charcount;
@@ -2516,7 +2509,7 @@ static int fbcon_set_font(struct vc_data
 	FNTSIZE(new_data) = size;
 	REFCOUNT(new_data) = 0;	/* usage counter */
 	for (i=0; i< charcount; i++) {
-		memcpy(new_data + i*h*pitch, data +  i*32*pitch, h*pitch);
+		memcpy(new_data + i*h*pitch, data +  i*vpitch*pitch, h*pitch);
 	}
 
 	/* Since linux has a nice crc32 function use it for counting font
Index: linux-6.0/include/linux/console.h
===================================================================
--- linux-6.0.orig/include/linux/console.h
+++ linux-6.0/include/linux/console.h
@@ -58,8 +58,9 @@ struct consw {
 	int	(*con_switch)(struct vc_data *vc);
 	int	(*con_blank)(struct vc_data *vc, int blank, int mode_switch);
 	int	(*con_font_set)(struct vc_data *vc, struct console_font *font,
-			unsigned int flags);
-	int	(*con_font_get)(struct vc_data *vc, struct console_font *font);
+			unsigned int vpitch, unsigned int flags);
+	int	(*con_font_get)(struct vc_data *vc, struct console_font *font,
+			unsigned int vpitch);
 	int	(*con_font_default)(struct vc_data *vc,
 			struct console_font *font, char *name);
 	int     (*con_resize)(struct vc_data *vc, unsigned int width,
Index: linux-6.0/drivers/video/console/newport_con.c
===================================================================
--- linux-6.0.orig/drivers/video/console/newport_con.c
+++ linux-6.0/drivers/video/console/newport_con.c
@@ -497,7 +497,7 @@ static int newport_blank(struct vc_data
 	return 1;
 }
 
-static int newport_set_font(int unit, struct console_font *op)
+static int newport_set_font(int unit, struct console_font *op, unsigned int vpitch)
 {
 	int w = op->width;
 	int h = op->height;
@@ -507,7 +507,7 @@ static int newport_set_font(int unit, st
 
 	/* ladis: when I grow up, there will be a day... and more sizes will
 	 * be supported ;-) */
-	if ((w != 8) || (h != 16)
+	if ((w != 8) || (h != 16) || (vpitch != 32)
 	    || (op->charcount != 256 && op->charcount != 512))
 		return -EINVAL;
 
@@ -569,9 +569,10 @@ static int newport_font_default(struct v
 	return newport_set_def_font(vc->vc_num, op);
 }
 
-static int newport_font_set(struct vc_data *vc, struct console_font *font, unsigned flags)
+static int newport_font_set(struct vc_data *vc, struct console_font *font,
+			    unsigned int vpitch, unsigned int flags)
 {
-	return newport_set_font(vc->vc_num, font);
+	return newport_set_font(vc->vc_num, font, vpitch);
 }
 
 static bool newport_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
Index: linux-6.0/drivers/video/console/sticon.c
===================================================================
--- linux-6.0.orig/drivers/video/console/sticon.c
+++ linux-6.0/drivers/video/console/sticon.c
@@ -169,7 +169,8 @@ static int sticon_set_def_font(int unit,
 	return 0;
 }
 
-static int sticon_set_font(struct vc_data *vc, struct console_font *op)
+static int sticon_set_font(struct vc_data *vc, struct console_font *op,
+			   unsigned int vpitch)
 {
 	struct sti_struct *sti = sticon_sti;
 	int vc_cols, vc_rows, vc_old_cols, vc_old_rows;
@@ -181,7 +182,7 @@ static int sticon_set_font(struct vc_dat
 	struct sti_cooked_font *cooked_font;
 	unsigned char *data = op->data, *p;
 
-	if ((w < 6) || (h < 6) || (w > 32) || (h > 32)
+	if ((w < 6) || (h < 6) || (w > 32) || (h > 32) || (vpitch != 32)
 	    || (op->charcount != 256 && op->charcount != 512))
 		return -EINVAL;
 	pitch = ALIGN(w, 8) / 8;
@@ -267,9 +268,9 @@ static int sticon_font_default(struct vc
 }
 
 static int sticon_font_set(struct vc_data *vc, struct console_font *font,
-			   unsigned int flags)
+			   unsigned int vpitch, unsigned int flags)
 {
-	return sticon_set_font(vc, font);
+	return sticon_set_font(vc, font, vpitch);
 }
 
 static void sticon_init(struct vc_data *c, int init)


