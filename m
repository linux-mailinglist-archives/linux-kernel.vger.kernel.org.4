Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E421661151
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 20:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjAGTTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 14:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjAGTTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 14:19:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3836C34D76
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 11:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673119117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eWX5iZJ1QilDMtUsJNw4q2HTHoN8NIM/H5E+VNzuK5w=;
        b=XQUyalmbh3aQTsYn5Vb9TJ/Ce7mC2vm086rGOvqgPzE71jFGyu79o+Ho4WqLRi9KSVwWP5
        sQYIIP/G69drMyHUqcCpYiY8Pj17iWtKjtEBxgyRew67BdojP1bO4mSw1fIXEPpvUkTxmZ
        Qkgi0mTIIUATw0IT6dWkLC/AaZP3rKU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-248-wjh6Osh5M06rGoxqH9oBsA-1; Sat, 07 Jan 2023 14:18:35 -0500
X-MC-Unique: wjh6Osh5M06rGoxqH9oBsA-1
Received: by mail-wm1-f72.google.com with SMTP id c66-20020a1c3545000000b003d355c13229so4660610wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 11:18:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWX5iZJ1QilDMtUsJNw4q2HTHoN8NIM/H5E+VNzuK5w=;
        b=hv4PJQXJ0ffr6DFLJy1I6tD7uYhY6S97ZqPzdjnxJ3gRlMcC02eTPgqPa0o94eyP7r
         sG7G9l4ObymnCOGosWl2Flp/il8XpsE9wmo56JZHOSJ3kN5JO4aYvvXWfzpAuB8lyahq
         2p690pzfbG0djmWcaSIf1DElYsg9SNqQYAZ8AodY3TH30X/hYrEc2FxmNa767kPJDlAP
         9eyr0Hu8LlQpf6c/aROzchQoxljHCjvVRPdSKzPtpZN+1USxYZBktS5CkyhU5eoA/JuN
         Gfsum9h8hL0vHtscSTmVqhxVUfxMw0Ok/HwyHu6uX6iYlq+COWN3XQeN8xPabtZVO8rq
         7VaA==
X-Gm-Message-State: AFqh2kpHhViuKUsjRtHVHkEvgBR8dHcEP7QjSG2DJJudPJwTHI0xTPC3
        So7hxHtlbrZ8friepRgD1x8Z4PVNO2SUhFHVByF3UlsqKXj54ELTSc3zWHN6fvsZ08KUkBa431A
        /W4m45EeZeXWFweZ+IF1TRsyd9T2PTxf5intgS/HvRuVsH/iEorPHLTZo74Pn0Izyp2WJIQY9hT
        k=
X-Received: by 2002:adf:e8c3:0:b0:28f:29b3:1a85 with SMTP id k3-20020adfe8c3000000b0028f29b31a85mr20235968wrn.2.1673119114328;
        Sat, 07 Jan 2023 11:18:34 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu+D2gHcRKr9bal9kpO6q62YXON4g5hSVZL3IdrLGzZqEYq/G5KzUjhTIHxfFc++6pp1EnTcQ==
X-Received: by 2002:adf:e8c3:0:b0:28f:29b3:1a85 with SMTP id k3-20020adfe8c3000000b0028f29b31a85mr20235950wrn.2.1673119113920;
        Sat, 07 Jan 2023 11:18:33 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm4553900wrb.107.2023.01.07.11.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:18:33 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Ondrej Jirman <megous@megous.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 02/13] drm/panel-sitronix-st7703: Drop custom DSI write macros
Date:   Sat,  7 Jan 2023 20:18:11 +0100
Message-Id: <20230107191822.3787147-3-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230107191822.3787147-1-javierm@redhat.com>
References: <20230107191822.3787147-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are macros for these already in the <drm/drm_mipi_dsi.h> header, use
that instead and delete the custom DSI write macros defined in the driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2:
- Add Sam Ravnborg's Reviewed-by tag.
- Fix identation on macro usage (Sam Ravnborg).

 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 341 +++++++++---------
 1 file changed, 162 insertions(+), 179 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 86a472b01360..6747ca237ced 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -73,14 +73,6 @@ static inline struct st7703 *panel_to_st7703(struct drm_panel *panel)
 	return container_of(panel, struct st7703, panel);
 }
 
-#define dsi_generic_write_seq(dsi, seq...) do {				\
-		static const u8 d[] = { seq };				\
-		int ret;						\
-		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static int jh057n_init_sequence(struct st7703 *ctx)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
@@ -90,50 +82,50 @@ static int jh057n_init_sequence(struct st7703 *ctx)
 	 * resemble the ST7703 but the number of parameters often don't match
 	 * so it's likely a clone.
 	 */
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETEXTC,
-			      0xF1, 0x12, 0x83);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETRGBIF,
-			      0x10, 0x10, 0x05, 0x05, 0x03, 0xFF, 0x00, 0x00,
-			      0x00, 0x00);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETSCR,
-			      0x73, 0x73, 0x50, 0x50, 0x00, 0x00, 0x08, 0x70,
-			      0x00);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETVDC, 0x4E);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETPANEL, 0x0B);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETCYC, 0x80);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETDISP, 0xF0, 0x12, 0x30);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETEQ,
-			      0x07, 0x07, 0x0B, 0x0B, 0x03, 0x0B, 0x00, 0x00,
-			      0x00, 0x00, 0xFF, 0x00, 0xC0, 0x10);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETBGP, 0x08, 0x08);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETEXTC,
+				   0xF1, 0x12, 0x83);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETRGBIF,
+				   0x10, 0x10, 0x05, 0x05, 0x03, 0xFF, 0x00, 0x00,
+				   0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETSCR,
+				   0x73, 0x73, 0x50, 0x50, 0x00, 0x00, 0x08, 0x70,
+				   0x00);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETVDC, 0x4E);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETPANEL, 0x0B);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETCYC, 0x80);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETDISP, 0xF0, 0x12, 0x30);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETEQ,
+				   0x07, 0x07, 0x0B, 0x0B, 0x03, 0x0B, 0x00, 0x00,
+				   0x00, 0x00, 0xFF, 0x00, 0xC0, 0x10);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETBGP, 0x08, 0x08);
 	msleep(20);
 
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETVCOM, 0x3F, 0x3F);
-	dsi_generic_write_seq(dsi, ST7703_CMD_UNKNOWN_BF, 0x02, 0x11, 0x00);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETGIP1,
-			      0x82, 0x10, 0x06, 0x05, 0x9E, 0x0A, 0xA5, 0x12,
-			      0x31, 0x23, 0x37, 0x83, 0x04, 0xBC, 0x27, 0x38,
-			      0x0C, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00,
-			      0x03, 0x00, 0x00, 0x00, 0x75, 0x75, 0x31, 0x88,
-			      0x88, 0x88, 0x88, 0x88, 0x88, 0x13, 0x88, 0x64,
-			      0x64, 0x20, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
-			      0x02, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETGIP2,
-			      0x02, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			      0x00, 0x00, 0x00, 0x00, 0x02, 0x46, 0x02, 0x88,
-			      0x88, 0x88, 0x88, 0x88, 0x88, 0x64, 0x88, 0x13,
-			      0x57, 0x13, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
-			      0x75, 0x88, 0x23, 0x14, 0x00, 0x00, 0x02, 0x00,
-			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x0A,
-			      0xA5, 0x00, 0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETGAMMA,
-			      0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41, 0x37,
-			      0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10, 0x11,
-			      0x18, 0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41,
-			      0x37, 0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10,
-			      0x11, 0x18);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETVCOM, 0x3F, 0x3F);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_UNKNOWN_BF, 0x02, 0x11, 0x00);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETGIP1,
+				   0x82, 0x10, 0x06, 0x05, 0x9E, 0x0A, 0xA5, 0x12,
+				   0x31, 0x23, 0x37, 0x83, 0x04, 0xBC, 0x27, 0x38,
+				   0x0C, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00,
+				   0x03, 0x00, 0x00, 0x00, 0x75, 0x75, 0x31, 0x88,
+				   0x88, 0x88, 0x88, 0x88, 0x88, 0x13, 0x88, 0x64,
+				   0x64, 0x20, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
+				   0x02, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETGIP2,
+				   0x02, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				   0x00, 0x00, 0x00, 0x00, 0x02, 0x46, 0x02, 0x88,
+				   0x88, 0x88, 0x88, 0x88, 0x88, 0x64, 0x88, 0x13,
+				   0x57, 0x13, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
+				   0x75, 0x88, 0x23, 0x14, 0x00, 0x00, 0x02, 0x00,
+				   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x0A,
+				   0xA5, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETGAMMA,
+				   0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41, 0x37,
+				   0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10, 0x11,
+				   0x18, 0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41,
+				   0x37, 0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10,
+				   0x11, 0x18);
 
 	return 0;
 }
@@ -162,15 +154,6 @@ static const struct st7703_panel_desc jh057n00900_panel_desc = {
 	.init_sequence = jh057n_init_sequence,
 };
 
-#define dsi_dcs_write_seq(dsi, cmd, seq...) do {			\
-		static const u8 d[] = { seq };				\
-		int ret;						\
-		ret = mipi_dsi_dcs_write(dsi, cmd, d, ARRAY_SIZE(d));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
-
 static int xbd599_init_sequence(struct st7703 *ctx)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
@@ -180,154 +163,154 @@ static int xbd599_init_sequence(struct st7703 *ctx)
 	 */
 
 	/* Magic sequence to unlock user commands below. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETEXTC, 0xF1, 0x12, 0x83);
-
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETMIPI,
-			  0x33, /* VC_main = 0, Lane_Number = 3 (4 lanes) */
-			  0x81, /* DSI_LDO_SEL = 1.7V, RTERM = 90 Ohm */
-			  0x05, /* IHSRX = x6 (Low High Speed driving ability) */
-			  0xF9, /* TX_CLK_SEL = fDSICLK/16 */
-			  0x0E, /* HFP_OSC (min. HFP number in DSI mode) */
-			  0x0E, /* HBP_OSC (min. HBP number in DSI mode) */
-			  /* The rest is undocumented in ST7703 datasheet */
-			  0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			  0x44, 0x25, 0x00, 0x91, 0x0a, 0x00, 0x00, 0x02,
-			  0x4F, 0x11, 0x00, 0x00, 0x37);
-
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETPOWER_EXT,
-			  0x25, /* PCCS = 2, ECP_DC_DIV = 1/4 HSYNC */
-			  0x22, /* DT = 15ms XDK_ECP = x2 */
-			  0x20, /* PFM_DC_DIV = /1 */
-			  0x03  /* ECP_SYNC_EN = 1, VGX_SYNC_EN = 1 */);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETEXTC, 0xF1, 0x12, 0x83);
+
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETMIPI,
+			       0x33, /* VC_main = 0, Lane_Number = 3 (4 lanes) */
+			       0x81, /* DSI_LDO_SEL = 1.7V, RTERM = 90 Ohm */
+			       0x05, /* IHSRX = x6 (Low High Speed driving ability) */
+			       0xF9, /* TX_CLK_SEL = fDSICLK/16 */
+			       0x0E, /* HFP_OSC (min. HFP number in DSI mode) */
+			       0x0E, /* HBP_OSC (min. HBP number in DSI mode) */
+			       /* The rest is undocumented in ST7703 datasheet */
+			       0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			       0x44, 0x25, 0x00, 0x91, 0x0a, 0x00, 0x00, 0x02,
+			       0x4F, 0x11, 0x00, 0x00, 0x37);
+
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETPOWER_EXT,
+			       0x25, /* PCCS = 2, ECP_DC_DIV = 1/4 HSYNC */
+			       0x22, /* DT = 15ms XDK_ECP = x2 */
+			       0x20, /* PFM_DC_DIV = /1 */
+			       0x03  /* ECP_SYNC_EN = 1, VGX_SYNC_EN = 1 */);
 
 	/* RGB I/F porch timing */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETRGBIF,
-			  0x10, /* VBP_RGB_GEN */
-			  0x10, /* VFP_RGB_GEN */
-			  0x05, /* DE_BP_RGB_GEN */
-			  0x05, /* DE_FP_RGB_GEN */
-			  /* The rest is undocumented in ST7703 datasheet */
-			  0x03, 0xFF,
-			  0x00, 0x00,
-			  0x00, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETRGBIF,
+			       0x10, /* VBP_RGB_GEN */
+			       0x10, /* VFP_RGB_GEN */
+			       0x05, /* DE_BP_RGB_GEN */
+			       0x05, /* DE_FP_RGB_GEN */
+			       /* The rest is undocumented in ST7703 datasheet */
+			       0x03, 0xFF,
+			       0x00, 0x00,
+			       0x00, 0x00);
 
 	/* Source driving settings. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETSCR,
-			  0x73, /* N_POPON */
-			  0x73, /* N_NOPON */
-			  0x50, /* I_POPON */
-			  0x50, /* I_NOPON */
-			  0x00, /* SCR[31,24] */
-			  0xC0, /* SCR[23,16] */
-			  0x08, /* SCR[15,8] */
-			  0x70, /* SCR[7,0] */
-			  0x00  /* Undocumented */);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETSCR,
+			       0x73, /* N_POPON */
+			       0x73, /* N_NOPON */
+			       0x50, /* I_POPON */
+			       0x50, /* I_NOPON */
+			       0x00, /* SCR[31,24] */
+			       0xC0, /* SCR[23,16] */
+			       0x08, /* SCR[15,8] */
+			       0x70, /* SCR[7,0] */
+			       0x00  /* Undocumented */);
 
 	/* NVDDD_SEL = -1.8V, VDDD_SEL = out of range (possibly 1.9V?) */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETVDC, 0x4E);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETVDC, 0x4E);
 
 	/*
 	 * SS_PANEL = 1 (reverse scan), GS_PANEL = 0 (normal scan)
 	 * REV_PANEL = 1 (normally black panel), BGR_PANEL = 1 (BGR)
 	 */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETPANEL, 0x0B);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETPANEL, 0x0B);
 
 	/* Zig-Zag Type C column inversion. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETCYC, 0x80);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETCYC, 0x80);
 
 	/* Set display resolution. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETDISP,
-			  0xF0, /* NL = 240 */
-			  0x12, /* RES_V_LSB = 0, BLK_CON = VSSD,
-				 * RESO_SEL = 720RGB
-				 */
-			  0xF0  /* WHITE_GND_EN = 1 (GND),
-				 * WHITE_FRAME_SEL = 7 frames,
-				 * ISC = 0 frames
-				 */);
-
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETEQ,
-			  0x00, /* PNOEQ */
-			  0x00, /* NNOEQ */
-			  0x0B, /* PEQGND */
-			  0x0B, /* NEQGND */
-			  0x10, /* PEQVCI */
-			  0x10, /* NEQVCI */
-			  0x00, /* PEQVCI1 */
-			  0x00, /* NEQVCI1 */
-			  0x00, /* reserved */
-			  0x00, /* reserved */
-			  0xFF, /* reserved */
-			  0x00, /* reserved */
-			  0xC0, /* ESD_DET_DATA_WHITE = 1, ESD_WHITE_EN = 1 */
-			  0x10  /* SLPIN_OPTION = 1 (no need vsync after sleep-in)
-				 * VEDIO_NO_CHECK_EN = 0
-				 * ESD_WHITE_GND_EN = 0
-				 * ESD_DET_TIME_SEL = 0 frames
-				 */);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETDISP,
+			       0xF0, /* NL = 240 */
+			       0x12, /* RES_V_LSB = 0, BLK_CON = VSSD,
+				      * RESO_SEL = 720RGB
+				      */
+			       0xF0  /* WHITE_GND_EN = 1 (GND),
+				      * WHITE_FRAME_SEL = 7 frames,
+				      * ISC = 0 frames
+				      */);
+
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETEQ,
+			       0x00, /* PNOEQ */
+			       0x00, /* NNOEQ */
+			       0x0B, /* PEQGND */
+			       0x0B, /* NEQGND */
+			       0x10, /* PEQVCI */
+			       0x10, /* NEQVCI */
+			       0x00, /* PEQVCI1 */
+			       0x00, /* NEQVCI1 */
+			       0x00, /* reserved */
+			       0x00, /* reserved */
+			       0xFF, /* reserved */
+			       0x00, /* reserved */
+			       0xC0, /* ESD_DET_DATA_WHITE = 1, ESD_WHITE_EN = 1 */
+			       0x10  /* SLPIN_OPTION = 1 (no need vsync after sleep-in)
+				      * VEDIO_NO_CHECK_EN = 0
+				      * ESD_WHITE_GND_EN = 0
+				      * ESD_DET_TIME_SEL = 0 frames
+				      */);
 
 	/* Undocumented command. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_UNKNOWN_C6, 0x01, 0x00, 0xFF, 0xFF, 0x00);
-
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETPOWER,
-			  0x74, /* VBTHS, VBTLS: VGH = 17V, VBL = -11V */
-			  0x00, /* FBOFF_VGH = 0, FBOFF_VGL = 0 */
-			  0x32, /* VRP  */
-			  0x32, /* VRN */
-			  0x77, /* reserved */
-			  0xF1, /* APS = 1 (small),
-				 * VGL_DET_EN = 1, VGH_DET_EN = 1,
-				 * VGL_TURBO = 1, VGH_TURBO = 1
-				 */
-			  0xFF, /* VGH1_L_DIV, VGL1_L_DIV (1.5MHz) */
-			  0xFF, /* VGH1_R_DIV, VGL1_R_DIV (1.5MHz) */
-			  0xCC, /* VGH2_L_DIV, VGL2_L_DIV (2.6MHz) */
-			  0xCC, /* VGH2_R_DIV, VGL2_R_DIV (2.6MHz) */
-			  0x77, /* VGH3_L_DIV, VGL3_L_DIV (4.5MHz) */
-			  0x77  /* VGH3_R_DIV, VGL3_R_DIV (4.5MHz) */);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_UNKNOWN_C6, 0x01, 0x00, 0xFF, 0xFF, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETPOWER,
+			       0x74, /* VBTHS, VBTLS: VGH = 17V, VBL = -11V */
+			       0x00, /* FBOFF_VGH = 0, FBOFF_VGL = 0 */
+			       0x32, /* VRP  */
+			       0x32, /* VRN */
+			       0x77, /* reserved */
+			       0xF1, /* APS = 1 (small),
+				      * VGL_DET_EN = 1, VGH_DET_EN = 1,
+				      * VGL_TURBO = 1, VGH_TURBO = 1
+				      */
+			       0xFF, /* VGH1_L_DIV, VGL1_L_DIV (1.5MHz) */
+			       0xFF, /* VGH1_R_DIV, VGL1_R_DIV (1.5MHz) */
+			       0xCC, /* VGH2_L_DIV, VGL2_L_DIV (2.6MHz) */
+			       0xCC, /* VGH2_R_DIV, VGL2_R_DIV (2.6MHz) */
+			       0x77, /* VGH3_L_DIV, VGL3_L_DIV (4.5MHz) */
+			       0x77  /* VGH3_R_DIV, VGL3_R_DIV (4.5MHz) */);
 
 	/* Reference voltage. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETBGP,
-			  0x07, /* VREF_SEL = 4.2V */
-			  0x07  /* NVREF_SEL = 4.2V */);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETBGP,
+			       0x07, /* VREF_SEL = 4.2V */
+			       0x07  /* NVREF_SEL = 4.2V */);
 	msleep(20);
 
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETVCOM,
-			  0x2C, /* VCOMDC_F = -0.67V */
-			  0x2C  /* VCOMDC_B = -0.67V */);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETVCOM,
+			       0x2C, /* VCOMDC_F = -0.67V */
+			       0x2C  /* VCOMDC_B = -0.67V */);
 
 	/* Undocumented command. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_UNKNOWN_BF, 0x02, 0x11, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_UNKNOWN_BF, 0x02, 0x11, 0x00);
 
 	/* This command is to set forward GIP timing. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETGIP1,
-			  0x82, 0x10, 0x06, 0x05, 0xA2, 0x0A, 0xA5, 0x12,
-			  0x31, 0x23, 0x37, 0x83, 0x04, 0xBC, 0x27, 0x38,
-			  0x0C, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00,
-			  0x03, 0x00, 0x00, 0x00, 0x75, 0x75, 0x31, 0x88,
-			  0x88, 0x88, 0x88, 0x88, 0x88, 0x13, 0x88, 0x64,
-			  0x64, 0x20, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
-			  0x02, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETGIP1,
+			       0x82, 0x10, 0x06, 0x05, 0xA2, 0x0A, 0xA5, 0x12,
+			       0x31, 0x23, 0x37, 0x83, 0x04, 0xBC, 0x27, 0x38,
+			       0x0C, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00,
+			       0x03, 0x00, 0x00, 0x00, 0x75, 0x75, 0x31, 0x88,
+			       0x88, 0x88, 0x88, 0x88, 0x88, 0x13, 0x88, 0x64,
+			       0x64, 0x20, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
+			       0x02, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
 
 	/* This command is to set backward GIP timing. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETGIP2,
-			  0x02, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			  0x00, 0x00, 0x00, 0x00, 0x02, 0x46, 0x02, 0x88,
-			  0x88, 0x88, 0x88, 0x88, 0x88, 0x64, 0x88, 0x13,
-			  0x57, 0x13, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
-			  0x75, 0x88, 0x23, 0x14, 0x00, 0x00, 0x02, 0x00,
-			  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x0A,
-			  0xA5, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETGIP2,
+			       0x02, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			       0x00, 0x00, 0x00, 0x00, 0x02, 0x46, 0x02, 0x88,
+			       0x88, 0x88, 0x88, 0x88, 0x88, 0x64, 0x88, 0x13,
+			       0x57, 0x13, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
+			       0x75, 0x88, 0x23, 0x14, 0x00, 0x00, 0x02, 0x00,
+			       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x0A,
+			       0xA5, 0x00, 0x00, 0x00, 0x00);
 
 	/* Adjust the gamma characteristics of the panel. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETGAMMA,
-			  0x00, 0x09, 0x0D, 0x23, 0x27, 0x3C, 0x41, 0x35,
-			  0x07, 0x0D, 0x0E, 0x12, 0x13, 0x10, 0x12, 0x12,
-			  0x18, 0x00, 0x09, 0x0D, 0x23, 0x27, 0x3C, 0x41,
-			  0x35, 0x07, 0x0D, 0x0E, 0x12, 0x13, 0x10, 0x12,
-			  0x12, 0x18);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETGAMMA,
+			       0x00, 0x09, 0x0D, 0x23, 0x27, 0x3C, 0x41, 0x35,
+			       0x07, 0x0D, 0x0E, 0x12, 0x13, 0x10, 0x12, 0x12,
+			       0x18, 0x00, 0x09, 0x0D, 0x23, 0x27, 0x3C, 0x41,
+			       0x35, 0x07, 0x0D, 0x0E, 0x12, 0x13, 0x10, 0x12,
+			       0x12, 0x18);
 
 	return 0;
 }
@@ -499,7 +482,7 @@ static int allpixelson_set(void *data, u64 val)
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 
 	dev_dbg(ctx->dev, "Setting all pixels on\n");
-	dsi_generic_write_seq(dsi, ST7703_CMD_ALL_PIXEL_ON);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_ALL_PIXEL_ON);
 	msleep(val * 1000);
 	/* Reset the panel to get video back */
 	drm_panel_disable(&ctx->panel);
-- 
2.38.1

