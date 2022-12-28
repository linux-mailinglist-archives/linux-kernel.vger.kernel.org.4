Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7931F6571D2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiL1Bt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiL1Bte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:49:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5B7FD7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672192096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVRZWETGH6ZWArylwAp+hcdkJg08dz7DN+pWXc29+fo=;
        b=UdWPG0AGhag+aXpeo98W+argHBDaMjFEc1fX40DXqg3kAPwTbZPyfbA6QDSDt5r60uUB1K
        GOdaODbYtv1QZ5+WGLXtCZ/tiUi89v2rBiyTGFUnN1b3W/pVDkG5nRIiXGr0aB6vQWtCUQ
        LKId8Q2hY1ZuN1XET196OosaxdMOZQc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-82-7M8K9dbzPqS4CeckLzM7CA-1; Tue, 27 Dec 2022 20:48:15 -0500
X-MC-Unique: 7M8K9dbzPqS4CeckLzM7CA-1
Received: by mail-wm1-f72.google.com with SMTP id p34-20020a05600c1da200b003d990064285so1230615wms.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVRZWETGH6ZWArylwAp+hcdkJg08dz7DN+pWXc29+fo=;
        b=ruzwFHIRrTjHQi5+MKeFt4fG4HO2nOA+2XA9B2UZEPKPyeo3oozAPLd8Sgk6l17qws
         KnGAY0yo3D86B8GlsrP5jCnBUnwWVi3EMTpzxhF+kQfS6t16nMZpiWwXuUqDp3QqiYoz
         rUr1vTAW2RUnWZvdr0x/W4Hr/c3LUsUnjXPRngJfczW70JoH4MmntJ9S+ISlFYKatpqW
         lFIO2gAA7CWN+JdMElNaMd153PLRDMt0Xt6eQ+wX1K8qfC9KEpfDJQmhgbONVQvDJn4/
         DfSKIsw8H9qIYsJ7GMGycySuO4kDXkGTND/8VTMDQE8wj0IoL1DfRRDvkEQsE762R5Ow
         hTig==
X-Gm-Message-State: AFqh2kqJA/izalIHoOsMf0heGJex1VswTziGbwWd6cr7oZ5bHs2OvemH
        CBYkm8KUmq1HmnKPL60Mf36yuwLMwARCzdOhPLBSGg2kKqW7Y594tAc4QjlCeEEGAGAMXx2z7V4
        oztdIEMiyBj7RbS8V5UrrY5lMcOq+yV3xfm8tfWV9z4KgZ1HbFEHzc2C8n6e6Hcm02xSecXvElJ
        s=
X-Received: by 2002:adf:ee52:0:b0:25d:d243:4f3c with SMTP id w18-20020adfee52000000b0025dd2434f3cmr13553306wro.69.1672192094272;
        Tue, 27 Dec 2022 17:48:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtaoDohriVGDqNtNH1suISrVVz7wzewDzWmFBOFjilDu6cmmOLQCCgEM/ufMGlv7ZwkWINAzg==
X-Received: by 2002:adf:ee52:0:b0:25d:d243:4f3c with SMTP id w18-20020adfee52000000b0025dd2434f3cmr13553292wro.69.1672192094038;
        Tue, 27 Dec 2022 17:48:14 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm14158873wrx.61.2022.12.27.17.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:48:13 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 07/14] drm/panel-novatek-nt35950: Drop custom DSI write macro
Date:   Wed, 28 Dec 2022 02:47:50 +0100
Message-Id: <20221228014757.3170486-8-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221228014757.3170486-1-javierm@redhat.com>
References: <20221228014757.3170486-1-javierm@redhat.com>
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
---

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

