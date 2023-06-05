Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A021A722009
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjFEHtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjFEHs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:48:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ECDE9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685951294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g4KVF35q3WBd9EqBejhEs82WHdBZCv0emJ0RazkmxtQ=;
        b=ASCcV27GJu1jgJ/7WzA9YdSdtqEgoTKP5gkOBwvzzzIh3vXbc1QRob2xTZ3Tu3nVa0UmCB
        +KT9sF9RYc4mK08JcMCAjmJuD1glvqcNv0kXAy/BYmvdx4TQ3dDCPao+lk5m+P0JKxU0qs
        kEOcNET9B9gIuxzj+00cNsuGhsLbgF8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-pFTy6LjGOw24tN-mfzMwjA-1; Mon, 05 Jun 2023 03:48:13 -0400
X-MC-Unique: pFTy6LjGOw24tN-mfzMwjA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f72720c592so17829815e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 00:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685951291; x=1688543291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4KVF35q3WBd9EqBejhEs82WHdBZCv0emJ0RazkmxtQ=;
        b=fkiyy21LGEQP4mSTBKJXmesFLPVrUlU+FIk9gqWdf24cAoo78ozW8GwL91PVa/Tlzs
         Pxtz5pRE4V7Va+RJcZZORDEnirHG/+gDUBWnQ3z+6vxYPuczwwgnlUeBa842cbYoRVEY
         RHWa2Wnp9Lk5zchnt0xjSJM/7bzcmVlGoOC/axqZ//KQCIipiaO92pDBB6zqIbDiZbwX
         qBpdwWEEbCVE1/aTKoq3tUngBmlidWT82X6B488l53qrkdM4OQwDHyHr1yowUz7HZA6f
         bHCeJzYKRsuZ/ARzmIbXPqvZQJ2wRsujyDJmq5UKcnfBX77tVD8Cho+ZIcHE6+6965Zo
         dQHg==
X-Gm-Message-State: AC+VfDwMzEYV8vRU5IN/QTYWjKGmXrLnVdD81c1YVLcHZtTW14xSPy+C
        lCqAut7CyNZdj+V6z8uE8bQSYitPotgul5oQ2HjBj0ixUxoJdeB9tWNVKEEoMOaFH6UL2sp6Vla
        XiSPU1HyoQKxyHmwU0Naos2FzwPfatj1IhOgluNQtFSag9ZPmpJ1BZt1FFDdt/1U8HmtWBVY/kp
        /QVy1ICxI=
X-Received: by 2002:a1c:cc06:0:b0:3f6:cf3:dba8 with SMTP id h6-20020a1ccc06000000b003f60cf3dba8mr6585890wmb.34.1685951291681;
        Mon, 05 Jun 2023 00:48:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uUoaBIg2ErX2rEl1Ihe8Mg/m56SNQQp37Cn9eD4HysfFWzxkC30GePmgb+XQHaSfZx9srPQ==
X-Received: by 2002:a1c:cc06:0:b0:3f6:cf3:dba8 with SMTP id h6-20020a1ccc06000000b003f60cf3dba8mr6585872wmb.34.1685951291413;
        Mon, 05 Jun 2023 00:48:11 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q21-20020a1ce915000000b003f4fb5532a1sm9715192wmc.43.2023.06.05.00.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:48:11 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 3/5] drm/ssd130x: Set the page height value in the device info data
Date:   Mon,  5 Jun 2023 09:47:51 +0200
Message-Id: <20230605074753.562332-4-javierm@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605074753.562332-1-javierm@redhat.com>
References: <20230605074753.562332-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver only supports OLED controllers that have a page height of 8 but
there are devices that have different page heights. So it is better to not
hardcode this value and instead have it as a per controller data value.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x.c | 15 +++++++++++----
 drivers/gpu/drm/solomon/ssd130x.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index a0e5e26c0bc9..5cac1149e34e 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -102,6 +102,7 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.default_width = 132,
 		.default_height = 64,
 		.page_mode_only = 1,
+		.page_height = 8,
 	},
 	[SSD1305_ID] = {
 		.default_vcomh = 0x34,
@@ -109,6 +110,7 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.default_dclk_frq = 7,
 		.default_width = 132,
 		.default_height = 64,
+		.page_height = 8,
 	},
 	[SSD1306_ID] = {
 		.default_vcomh = 0x20,
@@ -117,6 +119,7 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.need_chargepump = 1,
 		.default_width = 128,
 		.default_height = 64,
+		.page_height = 8,
 	},
 	[SSD1307_ID] = {
 		.default_vcomh = 0x20,
@@ -125,6 +128,7 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.need_pwm = 1,
 		.default_width = 128,
 		.default_height = 39,
+		.page_height = 8,
 	},
 	[SSD1309_ID] = {
 		.default_vcomh = 0x34,
@@ -132,6 +136,7 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.default_dclk_frq = 10,
 		.default_width = 128,
 		.default_height = 64,
+		.page_height = 8,
 	}
 };
 EXPORT_SYMBOL_NS_GPL(ssd130x_variants, DRM_SSD130X);
@@ -437,7 +442,8 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x, u8 *buf,
 	unsigned int width = drm_rect_width(rect);
 	unsigned int height = drm_rect_height(rect);
 	unsigned int line_length = DIV_ROUND_UP(width, 8);
-	unsigned int pages = DIV_ROUND_UP(height, 8);
+	unsigned int page_height = ssd130x->device_info->page_height;
+	unsigned int pages = DIV_ROUND_UP(height, page_height);
 	struct drm_device *drm = &ssd130x->drm;
 	u32 array_idx = 0;
 	int ret, i, j, k;
@@ -559,16 +565,17 @@ static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_m
 				struct drm_rect *rect)
 {
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
+	unsigned int page_height = ssd130x->device_info->page_height;
 	struct iosys_map dst;
 	unsigned int dst_pitch;
 	int ret = 0;
 	u8 *buf = NULL;
 
 	/* Align y to display page boundaries */
-	rect->y1 = round_down(rect->y1, 8);
-	rect->y2 = min_t(unsigned int, round_up(rect->y2, 8), ssd130x->height);
+	rect->y1 = round_down(rect->y1, page_height);
+	rect->y2 = min_t(unsigned int, round_up(rect->y2, page_height), ssd130x->height);
 
-	dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), 8);
+	dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), page_height);
 	buf = kcalloc(dst_pitch, drm_rect_height(rect), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index a2bc8d75078b..87968b3e7fb8 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -39,6 +39,7 @@ struct ssd130x_deviceinfo {
 	u32 default_dclk_frq;
 	u32 default_width;
 	u32 default_height;
+	u32 page_height;
 	int need_pwm;
 	int need_chargepump;
 	bool page_mode_only;
-- 
2.40.1

