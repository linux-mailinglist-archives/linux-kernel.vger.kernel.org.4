Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FA66420B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 01:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiLEAOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 19:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiLEANy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 19:13:54 -0500
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DD7101E9
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 16:13:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id EC4442014B;
        Mon,  5 Dec 2022 01:13:51 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DMjfWew5khfR; Mon,  5 Dec 2022 01:13:51 +0100 (CET)
Received: from begin (lfbn-bor-1-376-208.w109-215.abo.wanadoo.fr [109.215.91.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 46C2820137;
        Mon,  5 Dec 2022 01:13:51 +0100 (CET)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@aquilenet.fr>)
        id 1p1z7G-00FkeD-2m;
        Mon, 05 Dec 2022 01:13:50 +0100
Message-ID: <20221205000807.822728995@ens-lyon.org>
User-Agent: quilt/0.66
Date:   Mon, 05 Dec 2022 01:07:41 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org
Cc:     linux-kernel@vger.kernel.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [patch 2/3] VT: Add KD_FONT_OP_SET/GET_TALL operations
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

The KD_FONT_OP_SET/GET operations hardcode vpitch to be 32 pixels,
which only dates from the old VGA hardware which as asserting this.

Drivers such as fbcon however do not have such limitation, so this
introduces KD_FONT_OP_SET/GET_TALL operations, which userland can try
to use to avoid this limitation, thus opening the patch to >32 pixels
font height.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Index: linux-6.0/drivers/tty/vt/vt.c
===================================================================
--- linux-6.0.orig/drivers/tty/vt/vt.c
+++ linux-6.0/drivers/tty/vt/vt.c
@@ -4592,6 +4592,7 @@ static int con_font_get(struct vc_data *
 	struct console_font font;
 	int rc = -EINVAL;
 	int c;
+	unsigned int vpitch = op->op == KD_FONT_OP_GET_TALL ? op->height : 32;
 
 	if (op->data) {
 		font.data = kmalloc(max_font_size, GFP_KERNEL);
@@ -4604,7 +4605,7 @@ static int con_font_get(struct vc_data *
 	if (vc->vc_mode != KD_TEXT)
 		rc = -EINVAL;
 	else if (vc->vc_sw->con_font_get)
-		rc = vc->vc_sw->con_font_get(vc, &font, 32);
+		rc = vc->vc_sw->con_font_get(vc, &font, vpitch);
 	else
 		rc = -ENOSYS;
 	console_unlock();
@@ -4612,7 +4613,7 @@ static int con_font_get(struct vc_data *
 	if (rc)
 		goto out;
 
-	c = (font.width+7)/8 * 32 * font.charcount;
+	c = (font.width+7)/8 * vpitch * font.charcount;
 
 	if (op->data && font.charcount > op->charcount)
 		rc = -ENOSPC;
@@ -4638,6 +4639,7 @@ static int con_font_set(struct vc_data *
 	struct console_font font;
 	int rc = -EINVAL;
 	int size;
+	unsigned int vpitch = op->op == KD_FONT_OP_SET_TALL ? op->height : 32;
 
 	if (vc->vc_mode != KD_TEXT)
 		return -EINVAL;
@@ -4647,7 +4649,9 @@ static int con_font_set(struct vc_data *
 		return -EINVAL;
 	if (op->width <= 0 || op->width > 32 || !op->height || op->height > 32)
 		return -EINVAL;
-	size = (op->width+7)/8 * 32 * op->charcount;
+	if (vpitch < op->height)
+		return -EINVAL;
+	size = (op->width+7)/8 * vpitch * op->charcount;
 	if (size > max_font_size)
 		return -ENOSPC;
 
@@ -4665,7 +4669,7 @@ static int con_font_set(struct vc_data *
 	else if (vc->vc_sw->con_font_set) {
 		if (vc_is_sel(vc))
 			clear_selection();
-		rc = vc->vc_sw->con_font_set(vc, &font, 32, op->flags);
+		rc = vc->vc_sw->con_font_set(vc, &font, vpitch, op->flags);
 	} else
 		rc = -ENOSYS;
 	console_unlock();
@@ -4711,8 +4715,10 @@ int con_font_op(struct vc_data *vc, stru
 {
 	switch (op->op) {
 	case KD_FONT_OP_SET:
+	case KD_FONT_OP_SET_TALL:
 		return con_font_set(vc, op);
 	case KD_FONT_OP_GET:
+	case KD_FONT_OP_GET_TALL:
 		return con_font_get(vc, op);
 	case KD_FONT_OP_SET_DEFAULT:
 		return con_font_default(vc, op);
Index: linux-6.0/include/uapi/linux/kd.h
===================================================================
--- linux-6.0.orig/include/uapi/linux/kd.h
+++ linux-6.0/include/uapi/linux/kd.h
@@ -161,19 +161,25 @@ struct console_font_op {
 	unsigned int flags;	/* KD_FONT_FLAG_* */
 	unsigned int width, height;	/* font size */
 	unsigned int charcount;
-	unsigned char __user *data;	/* font data with height fixed to 32 */
+	unsigned char __user *data;	/* font data with vpitch fixed to 32 for
+					 * KD_FONT_OP_SET/GET
+					 */
 };
 
 struct console_font {
 	unsigned int width, height;	/* font size */
 	unsigned int charcount;
-	unsigned char *data;	/* font data with height fixed to 32 */
+	unsigned char *data;	/* font data with vpitch fixed to 32 for
+				 * KD_FONT_OP_SET/GET
+				 */
 };
 
 #define KD_FONT_OP_SET		0	/* Set font */
 #define KD_FONT_OP_GET		1	/* Get font */
 #define KD_FONT_OP_SET_DEFAULT	2	/* Set font to default, data points to name / NULL */
 #define KD_FONT_OP_COPY		3	/* Obsolete, do not use */
+#define KD_FONT_OP_SET_TALL	4	/* Set font with vpitch = height */
+#define KD_FONT_OP_GET_TALL	5	/* Get font with vpitch = height */
 
 #define KD_FONT_FLAG_DONT_RECALC 	1	/* Don't recalculate hw charcell size [compat] */
 

