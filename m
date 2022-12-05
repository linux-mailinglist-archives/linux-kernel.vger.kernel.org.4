Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499E26420B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 01:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiLEAOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 19:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiLEANy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 19:13:54 -0500
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33648101E1
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 16:13:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id E7B2D20116;
        Mon,  5 Dec 2022 01:13:51 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JEfmdvrDKHrQ; Mon,  5 Dec 2022 01:13:51 +0100 (CET)
Received: from begin (lfbn-bor-1-376-208.w109-215.abo.wanadoo.fr [109.215.91.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 4B52D20145;
        Mon,  5 Dec 2022 01:13:51 +0100 (CET)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@aquilenet.fr>)
        id 1p1z7G-00FkeK-2z;
        Mon, 05 Dec 2022 01:13:50 +0100
Message-ID: <20221205000959.412595871@ens-lyon.org>
User-Agent: quilt/0.66
Date:   Mon, 05 Dec 2022 01:09:55 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [patch 1/1] font: Leverage KD_FONT_OP_GET/SET_TALL font operations
References: <20221205000739.583233140@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,MISSING_HEADERS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Apparently-To: <SRS0=K5TJ=4D=aquilenet.fr=samuel.thibault@bounce.ens-lyon.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
To:     unlisted-recipients:; (no To-header on input)

The new KD_FONT_OP_GET/SET_TALL font operations allow to load fonts taller
than 32 pixels by dropping the VGA-specific vertical pitch limitation.

The new maximum font size has thus been raised to 64x128.

We however continue using the older font operations for smaller fonts, to
continue supporting older kernels.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Index: kbd-2.5.1/src/compat/linux-kd.h
===================================================================
--- kbd-2.5.1.orig/src/compat/linux-kd.h
+++ kbd-2.5.1/src/compat/linux-kd.h
@@ -90,7 +90,8 @@ struct console_font_op {
 	unsigned int flags; /* KD_FONT_FLAG_* */
 	unsigned int width, height;
 	unsigned int charcount;
-	unsigned char *data; /* font data with height fixed to 32 */
+	unsigned char *data; /* font data with vpitch fixed to 32 for
+                              * KD_FONT_OP_SET/GET */
 };
 
 #define KD_FONT_OP_SET 0         /* Set font */
@@ -98,6 +99,8 @@ struct console_font_op {
 #define KD_FONT_OP_SET_DEFAULT 2 /* Set font to default, \
                                     data points to name / NULL */
 #define KD_FONT_OP_COPY 3        /* Copy from another console */
+#define KD_FONT_OP_SET_TALL 4    /* Set font with arbitrary vpitch */
+#define KD_FONT_OP_GET_TALL 5    /* Get font with arbitrary vpitch */
 
 #define KD_FONT_FLAG_OLD 0x80000000 /* Invoked via old interface */
 #define KD_FONT_FLAG_DONT_RECALC 1  /* Don't call adjust_height() */
Index: kbd-2.5.1/src/libkfont/kdfontop.c
===================================================================
--- kbd-2.5.1.orig/src/libkfont/kdfontop.c
+++ kbd-2.5.1/src/libkfont/kdfontop.c
@@ -51,19 +51,33 @@ get_font_kdfontop(struct kfont_context *
 		unsigned char *buf,
 		unsigned int *count,
 		unsigned int *width,
-		unsigned int *height)
+		unsigned int *height,
+		unsigned int *vpitch)
 {
 	struct console_font_op cfo;
 
+#ifdef KD_FONT_OP_GET_TALL
+	cfo.op = KD_FONT_OP_GET_TALL;
+#else
 	cfo.op = KD_FONT_OP_GET;
+#endif
 	cfo.flags = 0;
-	cfo.width = cfo.height = 32;
+	cfo.width = 64;
+	cfo.height = 128;
 	cfo.charcount = *count;
 	cfo.data = buf;
 
+retry:
 	errno = 0;
 
 	if (ioctl(consolefd, KDFONTOP, &cfo)) {
+#ifdef KD_FONT_OP_GET_TALL
+		if (errno == ENOSYS && cfo.op == KD_FONT_OP_GET_TALL) {
+			/* Kernel before 6.2.  */
+			cfo.op = KD_FONT_OP_GET;
+			goto retry;
+		}
+#endif
 		if (errno != ENOSYS && errno != EINVAL) {
 			KFONT_ERR(ctx, "ioctl(KDFONTOP): %m");
 			return -1;
@@ -76,6 +90,14 @@ get_font_kdfontop(struct kfont_context *
 		*height = cfo.height;
 	if (width)
 		*width = cfo.width;
+	if (vpitch) {
+#ifdef KD_FONT_OP_GET_TALL
+		if (cfo.op == KD_FONT_OP_GET_TALL)
+			*vpitch = cfo.height;
+		else
+#endif
+			*vpitch = 32;
+	}
 	return 0;
 }
 
@@ -88,16 +110,17 @@ int
 kfont_get_font(struct kfont_context *ctx, int fd, unsigned char *buf,
 		unsigned int *count,
 		unsigned int *width,
-		unsigned int *height)
+		unsigned int *height,
+		unsigned int *vpitch)
 {
-	return get_font_kdfontop(ctx, fd, buf, count, width, height);
+	return get_font_kdfontop(ctx, fd, buf, count, width, height, vpitch);
 }
 
 int unsigned
 kfont_get_fontsize(struct kfont_context *ctx, int fd)
 {
 	unsigned int count = 0;
-	if (!kfont_get_font(ctx, fd, NULL, &count, NULL, NULL))
+	if (!kfont_get_font(ctx, fd, NULL, &count, NULL, NULL, NULL))
 		return count;
 	return 256;
 }
@@ -106,11 +129,20 @@ static int
 put_font_kdfontop(struct kfont_context *ctx, int consolefd, unsigned char *buf,
 		unsigned int count,
 		unsigned int width,
-		unsigned int height)
+		unsigned int height,
+		unsigned int vpitch)
 {
 	struct console_font_op cfo;
 
-	cfo.op        = KD_FONT_OP_SET;
+	if (vpitch == 32 && width <= 32)
+		cfo.op        = KD_FONT_OP_SET;
+	else {
+#ifdef KD_FONT_OP_SET_TALL
+		cfo.op        = KD_FONT_OP_SET_TALL;
+#else
+		return 1;
+#endif
+	}
 	cfo.flags     = 0;
 	cfo.width     = width;
 	cfo.height    = height;
@@ -154,7 +186,7 @@ put_font_kdfontop(struct kfont_context *
 
 int
 kfont_put_font(struct kfont_context *ctx, int fd, unsigned char *buf, unsigned int count,
-        unsigned int width, unsigned int height)
+        unsigned int width, unsigned int height, unsigned int vpitch)
 {
 	if (!width)
 		width = 8;
@@ -162,5 +194,5 @@ kfont_put_font(struct kfont_context *ctx
 	if (!height)
 		height = font_charheight(buf, count, width);
 
-	return put_font_kdfontop(ctx, fd, buf, count, width, height);
+	return put_font_kdfontop(ctx, fd, buf, count, width, height, vpitch);
 }
Index: kbd-2.5.1/src/libkfont/kfont.h
===================================================================
--- kbd-2.5.1.orig/src/libkfont/kfont.h
+++ kbd-2.5.1/src/libkfont/kfont.h
@@ -171,7 +171,8 @@ int kfont_load_unicodemap(struct kfont_c
  * Sets number of glyphs in COUNT, glyph size in WIDTH and HEIGHT.
  */
 int kfont_get_font(struct kfont_context *ctx, int consolefd, unsigned char *buf,
-		unsigned int *count, unsigned int *width, unsigned int *height)
+		unsigned int *count, unsigned int *width, unsigned int *height,
+		unsigned int *vpitch)
 	__attribute__((nonnull(1)));
 
 /*
@@ -180,7 +181,8 @@ int kfont_get_font(struct kfont_context
  * Return 0 on success, -1 on failure.
  */
 int kfont_put_font(struct kfont_context *ctx, int consolefd, unsigned char *buf,
-		unsigned int count, unsigned int width, unsigned int height)
+		unsigned int count, unsigned int width, unsigned int height,
+		unsigned int vpitch)
 	__attribute__((nonnull(1)));
 
 /*
@@ -239,7 +241,7 @@ void kfont_disactivatemap(int fd);
 #include <stdio.h>
 
 /* Maximum font size that we try to handle */
-#define MAXFONTSIZE 65536
+#define MAXFONTSIZE (512*64*128)
 
 /**
  * readpsffont reads a PSF font.
Index: kbd-2.5.1/src/libkfont/setfont.c
===================================================================
--- kbd-2.5.1.orig/src/libkfont/setfont.c
+++ kbd-2.5.1/src/libkfont/setfont.c
@@ -45,8 +45,9 @@ findpartialfont(struct kfont_context *ct
 static int erase_mode = 1;
 
 static int
-do_loadfont(struct kfont_context *ctx, int fd, const unsigned char *inbuf,
-		unsigned int width, unsigned int height, unsigned int hwunit,
+try_loadfont(struct kfont_context *ctx, int fd, const unsigned char *inbuf,
+		unsigned int width, unsigned int height, unsigned int vpitch,
+		unsigned int hwunit,
 		unsigned int fontsize, const char *filename)
 {
 	unsigned char *buf = NULL;
@@ -54,13 +55,13 @@ do_loadfont(struct kfont_context *ctx, i
 	int bad_video_erase_char = 0;
 	int ret;
 
-	if (height < 1 || height > 32) {
-		KFONT_ERR(ctx, _("Bad character height %d"), height);
+	if (height < 1 || height > 64) {
+		KFONT_ERR(ctx, _("Bad character height %d (limit is 64)"), height);
 		return -EX_DATAERR;
 	}
 
-	if (width < 1 || width > 32) {
-		KFONT_ERR(ctx, _("Bad character width %d"), width);
+	if (width < 1 || width > 128) {
+		KFONT_ERR(ctx, _("Bad character width %d (limit is 128)"), width);
 		return -EX_DATAERR;
 	}
 
@@ -68,8 +69,8 @@ do_loadfont(struct kfont_context *ctx, i
 		hwunit = height;
 
 	if ((ctx->options & (1 << kfont_double_size)) &&
-	    (height > 16 || width > 16)) {
-		KFONT_ERR(ctx, _("Cannot double %dx%d font (limit is 16x16)"), width, height);
+	    (height > 32 || width > 64)) {
+		KFONT_ERR(ctx, _("Cannot double %dx%d font (limit is 32x64)"), width, height);
 		kfont_unset_option(ctx, kfont_double_size);
 	}
 
@@ -78,7 +79,7 @@ do_loadfont(struct kfont_context *ctx, i
 		unsigned int kbytewidth = (2 * width + 7) / 8;
 		unsigned int charsize   = height * bytewidth;
 
-		kcharsize = 32 * kbytewidth;
+		kcharsize = vpitch * kbytewidth;
 		buflen    = kcharsize * ((fontsize < 128) ? 128 : fontsize);
 
 		buf = calloc(1, buflen);
@@ -112,7 +113,7 @@ do_loadfont(struct kfont_context *ctx, i
 		unsigned int bytewidth = (width + 7) / 8;
 		unsigned int charsize  = height * bytewidth;
 
-		kcharsize = 32 * bytewidth;
+		kcharsize = vpitch * bytewidth;
 		buflen    = kcharsize * ((fontsize < 128) ? 128 : fontsize);
 
 		buf = calloc(1, buflen);
@@ -169,7 +170,7 @@ do_loadfont(struct kfont_context *ctx, i
 		KFONT_INFO(ctx, _("Loading %d-char %dx%d (%d) font"),
 		       fontsize, width, height, hwunit);
 
-	if (kfont_put_font(ctx, fd, buf, fontsize, width, hwunit) < 0) {
+	if (kfont_put_font(ctx, fd, buf, fontsize, width, hwunit, vpitch) < 1) {
 		ret = -EX_OSERR;
 		goto err;
 	}
@@ -181,6 +182,20 @@ err:
 }
 
 static int
+do_loadfont(struct kfont_context *ctx, int fd, const unsigned char *inbuf,
+		unsigned int width, unsigned int height, unsigned int hwunit,
+		unsigned int fontsize, const char *filename)
+{
+	int ret;
+
+	if (height <= 32 && width <= 32)
+		/* This can work with pre-6.2 kernels and its size and vpitch limitations */
+		return try_loadfont(ctx, fd, inbuf, width, height, 32, hwunit, fontsize, filename);
+	else
+		return try_loadfont(ctx, fd, inbuf, width, height, height, hwunit, fontsize, filename);
+}
+
+static int
 do_loadtable(struct kfont_context *ctx, int fd, struct unicode_list *uclistheads,
 		unsigned int fontsize)
 {
@@ -585,19 +600,19 @@ save_font(struct kfont_context *ctx, int
 /* this is the max font size the kernel is willing to handle */
 	unsigned char buf[MAXFONTSIZE];
 
-	unsigned int i, ct, width, height, bytewidth, charsize, kcharsize;
+	unsigned int i, ct, width, height, bytewidth, charsize, kcharsize, vpitch;
 	int ret;
 
-	ct = sizeof(buf) / (32 * 32 / 8); /* max size 32x32, 8 bits/byte */
+	ct = sizeof(buf) / (64 * 128 / 8); /* max size 64x128, 8 bits/byte */
 
-	if (kfont_get_font(ctx, consolefd, buf, &ct, &width, &height) < 0)
+	if (kfont_get_font(ctx, consolefd, buf, &ct, &width, &height, &vpitch) < 0)
 		return -EX_OSERR;
 
 	/* save as efficiently as possible */
 	bytewidth = (width + 7) / 8;
 	height    = font_charheight(buf, ct, width);
 	charsize  = height * bytewidth;
-	kcharsize = 32 * bytewidth;
+	kcharsize = vpitch * bytewidth;
 
 /* Do we need a psf header? */
 /* Yes if ct==512 - otherwise we cannot distinguish
Index: kbd-2.5.1/src/showconsolefont.c
===================================================================
--- kbd-2.5.1.orig/src/showconsolefont.c
+++ kbd-2.5.1/src/showconsolefont.c
@@ -205,7 +205,7 @@ int main(int argc, char **argv)
 	if (info) {
 		nr = rows = cols = 0;
 
-		ret = kfont_get_font(kfont, fd, NULL, &nr, &rows, &cols);
+		ret = kfont_get_font(kfont, fd, NULL, &nr, &rows, &cols, NULL);
 		if (ret != 0)
 			leave(kfont, EXIT_FAILURE);
 
Index: kbd-2.5.1/tests/libtswrap/ioctl.c
===================================================================
--- kbd-2.5.1.orig/tests/libtswrap/ioctl.c
+++ kbd-2.5.1/tests/libtswrap/ioctl.c
@@ -93,6 +93,12 @@ static struct translate_names kd_font_op
 	{ KD_FONT_OP_GET, "KD_FONT_OP_GET" },
 	{ KD_FONT_OP_SET_DEFAULT, "KD_FONT_OP_SET_DEFAULT" },
 	{ KD_FONT_OP_COPY, "KD_FONT_OP_COPY" },
+#ifdef KD_FONT_OP_SET_TALL
+	{ KD_FONT_OP_SET_TALL, "KD_FONT_OP_SET_TALL" },
+#endif
+#ifdef KD_FONT_OP_GET_TALL
+	{ KD_FONT_OP_GET_TALL, "KD_FONT_OP_GET_TALL" },
+#endif
 	{ 0, NULL }
 };
 

