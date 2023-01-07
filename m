Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77A9661157
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 20:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjAGTUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 14:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjAGTUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 14:20:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B65D35902
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 11:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673119122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWoU2jTRjKSY+Qo+tb2CBqwxtQSMhlldhpuQhSNUC9M=;
        b=LCgz5JCSPz+olV3Zm4iCNevF8j3Q/vBjAUNebgXvMP2vDXwtJ0jlrU7Jcwhu5cIy3PTQVD
        6ec9ZqefzciMMp7iGhH765vI5FiKAwa7SEdaE9lpX+L0fUlchsSO3EvAkJNMo+nI7Te/e+
        qjmV0lTJG1DKwqpIwVEqDjAqYg7tEac=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-9Dl6hUd0M2yO9-a_eRBdkw-1; Sat, 07 Jan 2023 14:18:41 -0500
X-MC-Unique: 9Dl6hUd0M2yO9-a_eRBdkw-1
Received: by mail-wm1-f72.google.com with SMTP id m38-20020a05600c3b2600b003d1fc5f1f80so4645126wms.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 11:18:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWoU2jTRjKSY+Qo+tb2CBqwxtQSMhlldhpuQhSNUC9M=;
        b=cKphWjJOI9pnps5PRGm0YY4kl7iMF6YtV6OoBcmH5t6RGmEUhLmux47/L8wYJTCU6S
         Pua67uDxVHX7BAu14Wa901W5Ed9mWAMyLGG9hI9LfdOtTPZZu4XhZ8TsLsgLPKcHujc9
         bxtPMU5dgIT6FoyXIPvT7podrATnz29oiAjiLp5uG/h5bAAF+dmWLBrQstHFoxogRtgd
         6ri2v2WEAUw0emOUhzrJm2MeYaCrykQwwIbXQWTUGLkkGpzaLYKaTPVhO7j4TS2BtXYF
         Vp+o3qc0qX0MfChzt8w0AobDKpx6MSYx2RwUNYpz9fv39ZMbzdW6dlO1OHqXxt31j4Rc
         irWw==
X-Gm-Message-State: AFqh2kogJu0cp6SYX3C7w2vr4JuXLHOkSeoBwInrG3Fh8eYkijccmUhy
        T7ayHRsIrAQ53YJz9hLQvsFQ44oNpJZ7n8oL7ocmRZeG0kBhnjbZ2/hFiQ/RI3h5wrQoRJNT/8n
        fFRpC8PTvI+EGfMpwKEogW0XzABAhj2ZnAvpvb2pU/GA+YO0Qn53AR517pyUybWV2mTso69cANr
        M=
X-Received: by 2002:a5d:624d:0:b0:242:4d70:7882 with SMTP id m13-20020a5d624d000000b002424d707882mr36919659wrv.15.1673119119731;
        Sat, 07 Jan 2023 11:18:39 -0800 (PST)
X-Google-Smtp-Source: AMrXdXslQosbrbw6pw/4AHiDYKneqeQtd0nCtwjU8AvmIMFQQ96Mo+Yg9sRxu263Nao8IzQ210H4jA==
X-Received: by 2002:a5d:624d:0:b0:242:4d70:7882 with SMTP id m13-20020a5d624d000000b002424d707882mr36919642wrv.15.1673119119489;
        Sat, 07 Jan 2023 11:18:39 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm4553900wrb.107.2023.01.07.11.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:18:39 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 06/13] drm/panel-novatek-nt35950: Drop custom DSI write macro
Date:   Sat,  7 Jan 2023 20:18:15 +0100
Message-Id: <20230107191822.3787147-7-javierm@redhat.com>
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

 drivers/gpu/drm/panel/panel-novatek-nt35950.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index 3a844917da07..abf752b36a52 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -89,14 +89,6 @@ static inline struct nt35950 *to_nt35950(struct drm_panel *panel)
 	return container_of(panel, struct nt35950, panel);
 }
 
-#define dsi_dcs_write_seq(dsi, seq...) do {				\
-		static const u8 d[] = { seq };				\
-		int ret;						\
-		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static void nt35950_reset(struct nt35950 *nt)
 {
 	gpiod_set_value_cansleep(nt->reset_gpio, 1);
@@ -338,7 +330,7 @@ static int nt35950_on(struct nt35950 *nt)
 		return ret;
 
 	/* Unknown command */
-	dsi_dcs_write_seq(dsi, 0xd4, 0x88, 0x88);
+	mipi_dsi_dcs_write_seq(dsi, 0xd4, 0x88, 0x88);
 
 	/* CMD2 Page 7 */
 	ret = nt35950_set_cmd2_page(nt, 7);
@@ -346,10 +338,10 @@ static int nt35950_on(struct nt35950 *nt)
 		return ret;
 
 	/* Enable SubPixel Rendering */
-	dsi_dcs_write_seq(dsi, MCS_PARAM_SPR_EN, 0x01);
+	mipi_dsi_dcs_write_seq(dsi, MCS_PARAM_SPR_EN, 0x01);
 
 	/* SPR Mode: YYG Rainbow-RGB */
-	dsi_dcs_write_seq(dsi, MCS_PARAM_SPR_MODE, MCS_SPR_MODE_YYG_RAINBOW_RGB);
+	mipi_dsi_dcs_write_seq(dsi, MCS_PARAM_SPR_MODE, MCS_SPR_MODE_YYG_RAINBOW_RGB);
 
 	/* CMD3 */
 	ret = nt35950_inject_black_image(nt);
-- 
2.38.1

