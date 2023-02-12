Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5383693725
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 13:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBLMI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 07:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBLMI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 07:08:56 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AC612048
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 04:08:55 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4PF5q45FzFz9sX0;
        Sun, 12 Feb 2023 13:08:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1676203728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GfE8sJ2Fi8pFKSAvvyoCwUemDhq2N1MdT14BaHkKkiQ=;
        b=1rLyIWuFy2QkHYr3CqNdCWKQwYLJ2UZL7PnxfkjO1qf77rEw7vnDakqEPE7JoI26UiAwXO
        plQkr40e5ZC1zDtfsJHeA7ABfyHX5bO+RqXeXOOKf7o8QKUXpPN195f2AiYyV8XbVUcmtI
        q4bNa3YxiKRvDDOtP+5LQOhNd2FFedZwUCTZaVTB5jLGLaGe5lhh/JtpU7Hbwmn3gPeL4D
        4Akdi69cL69bi06SBrI7tMfyq1O1H+JxnZNCDiKdR9+wGCwhuZz5ns81YshmO6Efn/l47m
        XgnumBnWnH/bvnsSk8YFZm7vwKvl2nE8+glQuvYeljjtEuHmqcbdQpuEEvKZGg==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Ondrej Jirman <megous@megous.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM PANEL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Frank Oltmanns <frank@oltmanns.dev>, Ondrej Jirman <megi@xff.cz>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/1] drm/panel: st7703: Fix resume of XBD599 panel
Date:   Sun, 12 Feb 2023 13:08:29 +0100
Message-Id: <20230212120830.46880-2-frank@oltmanns.dev>
In-Reply-To: <20230212120830.46880-1-frank@oltmanns.dev>
References: <20230212120830.46880-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PF5q45FzFz9sX0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In contrast to the JH057N panel, the XBD599 panel does not require a 20
msec delay after initialization and exiting sleep mode. Therefore, move
the delay into the already existing device specific initialization
function.

Also, the timing contraints after entering and exiting sleep mode differ
between the two panels:
 - The JH057N requires a shorter delay than the XDB599 after waking up
   from sleep mode and before enabling the display.
 - The XDB599 requires a delay in order to drain the display of charge,
   which is not required on the JH057N.

Therefore, introduce panel specific functions for the delays.

The XDB599 does not require a 20 msec delay between the SETBGP and
SETVCOM commands. Therefore, remove the delay from the device specific
initialization function.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
Cc: Ondrej Jirman <megi@xff.cz>
Reported-by: Samuel Holland <samuel@sholland.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 40 ++++++++++++++++---
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 6747ca237ced..a149341c4a8b 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -66,6 +66,8 @@ struct st7703_panel_desc {
 	unsigned long mode_flags;
 	enum mipi_dsi_pixel_format format;
 	int (*init_sequence)(struct st7703 *ctx);
+	void (*wait_after_sleep_out)(void);
+	void (*drain_charge)(void);
 };
 
 static inline struct st7703 *panel_to_st7703(struct drm_panel *panel)
@@ -126,10 +128,24 @@ static int jh057n_init_sequence(struct st7703 *ctx)
 				   0x18, 0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41,
 				   0x37, 0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10,
 				   0x11, 0x18);
+	msleep(20);
 
 	return 0;
 }
 
+static void jh057n_wait_after_sleep_out(void)
+{
+	/*
+	 * Panel is operational 120 msec after reset, i.e. 60 msec after
+	 * sleep out.
+	 */
+	msleep(60);
+}
+
+static void jh057n_drain_charge(void)
+{
+}
+
 static const struct drm_display_mode jh057n00900_mode = {
 	.hdisplay    = 720,
 	.hsync_start = 720 + 90,
@@ -152,6 +168,8 @@ static const struct st7703_panel_desc jh057n00900_panel_desc = {
 		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE,
 	.format = MIPI_DSI_FMT_RGB888,
 	.init_sequence = jh057n_init_sequence,
+	.wait_after_sleep_out = jh057n_wait_after_sleep_out,
+	.drain_charge = jh057n_drain_charge,
 };
 
 static int xbd599_init_sequence(struct st7703 *ctx)
@@ -273,7 +291,6 @@ static int xbd599_init_sequence(struct st7703 *ctx)
 	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETBGP,
 			       0x07, /* VREF_SEL = 4.2V */
 			       0x07  /* NVREF_SEL = 4.2V */);
-	msleep(20);
 
 	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETVCOM,
 			       0x2C, /* VCOMDC_F = -0.67V */
@@ -315,6 +332,18 @@ static int xbd599_init_sequence(struct st7703 *ctx)
 	return 0;
 }
 
+static void xbd599_wait_after_sleep_out(void)
+{
+	msleep(120);
+}
+
+static void xbd599_drain_charge(void)
+{
+	/* Drain diplay of charge, to work correctly on next power on. */
+	msleep(120);
+}
+
+
 static const struct drm_display_mode xbd599_mode = {
 	.hdisplay    = 720,
 	.hsync_start = 720 + 40,
@@ -336,6 +365,8 @@ static const struct st7703_panel_desc xbd599_desc = {
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE,
 	.format = MIPI_DSI_FMT_RGB888,
 	.init_sequence = xbd599_init_sequence,
+	.wait_after_sleep_out = xbd599_wait_after_sleep_out,
+	.drain_charge = xbd599_drain_charge,
 };
 
 static int st7703_enable(struct drm_panel *panel)
@@ -350,16 +381,13 @@ static int st7703_enable(struct drm_panel *panel)
 		return ret;
 	}
 
-	msleep(20);
-
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Failed to exit sleep mode: %d\n", ret);
 		return ret;
 	}
 
-	/* Panel is operational 120 msec after reset */
-	msleep(60);
+	ctx->desc->wait_after_sleep_out();
 
 	ret = mipi_dsi_dcs_set_display_on(dsi);
 	if (ret)
@@ -384,6 +412,8 @@ static int st7703_disable(struct drm_panel *panel)
 	if (ret < 0)
 		dev_err(ctx->dev, "Failed to enter sleep mode: %d\n", ret);
 
+	ctx->desc->drain_charge();
+
 	return 0;
 }
 
-- 
2.39.1

