Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DB066114E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 20:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjAGTTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 14:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjAGTTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 14:19:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1711D34D78
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 11:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673119119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rD+5XNBbrJZAW/YgIxLybfi5YZERSLl6kQc4XxgcM9A=;
        b=EB4NvmjC9RIJWjvwjRJmZI9QfAthCGoSXTxSwU1UOXpGz1iJ0tUd8E1xqVl1RwuZB9Y/or
        I6jWVzuFm5WhF+F6W7k9myrVaoajM0zBqohub88xdN1B/gWm74TVwtl/wmVsklZ1XHWlCN
        RhDQ8TPp0X5cA5a/yviPcv9CIziHFD8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-77-d-MVzb2-N0aLeejX_7qhMQ-1; Sat, 07 Jan 2023 14:18:38 -0500
X-MC-Unique: d-MVzb2-N0aLeejX_7qhMQ-1
Received: by mail-wm1-f72.google.com with SMTP id j1-20020a05600c1c0100b003d99070f529so4629503wms.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 11:18:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rD+5XNBbrJZAW/YgIxLybfi5YZERSLl6kQc4XxgcM9A=;
        b=QdfzxF9mi1o6JMYha54oDgFrgYZCamExuk+g5ZzXJla8gF0pxMTx/Zr7rJ7yvwo7R7
         GnYIikvtM54F6NugvlfsfdubGCHoJlL4QjR8oWRGHiO+MxY18w0ori2YvKpASeA4v//U
         QgJHxJHYvSsQTFqejfGFmxdCnmw70Cby5AClj+mj1KjWwKKK+r7zZa17osCLf/rkajw5
         zIq0EkHM7JcI8jNV8odCh7sVAMnHQQ3JQOGjqiVXCHcWFBEtEXRCAjGVc16Do5GLv74J
         3peMdXXAWuWuRTHAihdkpyRbaQ3+bKrOctwpxIn3cKRLfa0vCDn+0R8oh1cwNOR7Gjgp
         y22w==
X-Gm-Message-State: AFqh2kpkuJFqeiTLFG9kvvACB/g7bG41AoKXRZCBU5Astu6cNfk3BjoS
        vKaQB3x4QdEzGLcnN8NN0xb/ixF4vP2bEECMcGBiQ0u0VLk/X4UeJNfWSeseIrjucZNa3eF00MN
        8TE03sMP5UbqyToqKEei1ILK5Be5Qnk3DJqVovKulbgJk5HhJ9UBnYWsrOd2n5zhb/d52mp3Bw0
        Q=
X-Received: by 2002:adf:eb8c:0:b0:242:728a:fa7 with SMTP id t12-20020adfeb8c000000b00242728a0fa7mr33769260wrn.61.1673119116690;
        Sat, 07 Jan 2023 11:18:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvE+E+NlBTd5p9Pyq5ZUX2ftUmzX2ODr9/fM3A+3zEhCen7AjJZbom7669251XvENcNq7EVFQ==
X-Received: by 2002:adf:eb8c:0:b0:242:728a:fa7 with SMTP id t12-20020adfeb8c000000b00242728a0fa7mr33769247wrn.61.1673119116483;
        Sat, 07 Jan 2023 11:18:36 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm4553900wrb.107.2023.01.07.11.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:18:36 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 04/13] drm/panel-elida-kd35t133: Drop custom DSI write macro
Date:   Sat,  7 Jan 2023 20:18:13 +0100
Message-Id: <20230107191822.3787147-5-javierm@redhat.com>
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

There is a macro for this already in the <drm/drm_mipi_dsi.h> header, use
that instead and delete the custom DSI write macro defined in the driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2:
- Add Sam Ravnborg's Reviewed-by tag.
- Fix identation on macro usage (Sam Ravnborg).

 drivers/gpu/drm/panel/panel-elida-kd35t133.c | 46 ++++++++------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
index eee714cf3f49..e7be15b68102 100644
--- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
+++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
@@ -51,14 +51,6 @@ static inline struct kd35t133 *panel_to_kd35t133(struct drm_panel *panel)
 	return container_of(panel, struct kd35t133, panel);
 }
 
-#define dsi_dcs_write_seq(dsi, cmd, seq...) do {			\
-		static const u8 b[] = { cmd, seq };			\
-		int ret;						\
-		ret = mipi_dsi_dcs_write_buffer(dsi, b, ARRAY_SIZE(b));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static int kd35t133_init_sequence(struct kd35t133 *ctx)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
@@ -68,25 +60,25 @@ static int kd35t133_init_sequence(struct kd35t133 *ctx)
 	 * Init sequence was supplied by the panel vendor with minimal
 	 * documentation.
 	 */
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_POSITIVEGAMMA,
-			  0x00, 0x13, 0x18, 0x04, 0x0f, 0x06, 0x3a, 0x56,
-			  0x4d, 0x03, 0x0a, 0x06, 0x30, 0x3e, 0x0f);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_NEGATIVEGAMMA,
-			  0x00, 0x13, 0x18, 0x01, 0x11, 0x06, 0x38, 0x34,
-			  0x4d, 0x06, 0x0d, 0x0b, 0x31, 0x37, 0x0f);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL1, 0x18, 0x17);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL2, 0x41);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_VCOMCONTROL, 0x00, 0x1a, 0x80);
-	dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x48);
-	dsi_dcs_write_seq(dsi, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_INTERFACEMODECTRL, 0x00);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_FRAMERATECTRL, 0xa0);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYINVERSIONCTRL, 0x02);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYFUNCTIONCTRL,
-			  0x20, 0x02);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_SETIMAGEFUNCTION, 0x00);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_ADJUSTCONTROL3,
-			  0xa9, 0x51, 0x2c, 0x82);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POSITIVEGAMMA,
+			       0x00, 0x13, 0x18, 0x04, 0x0f, 0x06, 0x3a, 0x56,
+			       0x4d, 0x03, 0x0a, 0x06, 0x30, 0x3e, 0x0f);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_NEGATIVEGAMMA,
+			       0x00, 0x13, 0x18, 0x01, 0x11, 0x06, 0x38, 0x34,
+			       0x4d, 0x06, 0x0d, 0x0b, 0x31, 0x37, 0x0f);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL1, 0x18, 0x17);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL2, 0x41);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_VCOMCONTROL, 0x00, 0x1a, 0x80);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x48);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_INTERFACEMODECTRL, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_FRAMERATECTRL, 0xa0);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYINVERSIONCTRL, 0x02);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYFUNCTIONCTRL,
+			       0x20, 0x02);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_SETIMAGEFUNCTION, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_ADJUSTCONTROL3,
+			       0xa9, 0x51, 0x2c, 0x82);
 	mipi_dsi_dcs_write(dsi, MIPI_DCS_ENTER_INVERT_MODE, NULL, 0);
 
 	dev_dbg(dev, "Panel init sequence done\n");
-- 
2.38.1

