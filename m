Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B87B72A0F5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjFIRKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjFIRKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:10:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70AB3A8C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686330592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jdi1ahNEpgpsHvIKoDJGTzIDYZ+gLZdkQID+ItWX/g4=;
        b=CZBgk98/RWvnAhp/bjF+uLk8Y6svAVbF4yVcWEXerOJnTG/vOxOaPSiyJMb6hm2NIp8CX5
        NKty/oNtb5CrxBAstUfzxf/It50HVRbz8TsULvlUwuQy3LuT9Gc7y8f87hDUlTJqcJ8VRZ
        kNvlQ0c7Lx/CG7HIGwRE5NUlMz9HVWE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-ySsOBsUtPdyA0hdmLO4Avg-1; Fri, 09 Jun 2023 13:09:51 -0400
X-MC-Unique: ySsOBsUtPdyA0hdmLO4Avg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7e7cfcae4so11173215e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686330589; x=1688922589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jdi1ahNEpgpsHvIKoDJGTzIDYZ+gLZdkQID+ItWX/g4=;
        b=Ok4VSyX07Qg//N8/6y0UqZENdS6w7UPzAPLph57tre+UZ/c+urWfF7/C8XJEWDCyVM
         FfqWFd6IZjA57BQwJdl7pPrMXmGxnQN6wCFiiwpiihubPCnBVWLnxI5MSZ4Cz0e4IENO
         IArRCD6kCUFepyt0flF8d6gRmHcPeR24+N/yzWAK7GqIyt4jK+462h3vVskHnTuH9TBC
         1gcG3v5Y5Cw50wK6Z+guR62CJBVqrVsWzmT9hVFrVLBC1nmly3FJldtbI9En/E671mxX
         ugAz1xv3VI2l5cahSwrAgRPYO7osf59FDbEpviPgtX4iz5C+TgDLQDF+uB3G8rZefIPy
         yUTw==
X-Gm-Message-State: AC+VfDy1gavdQRnCZuIfCoEeSoQ5jTUZprD7PIK5UVr06XC16eH8Npuh
        Si0ExwtfHNTH8QlO2bg8RBtmt0IPuuuLnC7hmIBZGW8CLRS6mLPmcDUnORHQJDQjdEpDeSymRSi
        fYXXxxnuCys+wQc9/m5WvA+82skaiOh96xidYdD7qlsgF9hE7Fi1elQuAyqj1Ba8/9bJLMaPfNa
        ur8lx3TvM=
X-Received: by 2002:a05:600c:b41:b0:3f7:eadb:941d with SMTP id k1-20020a05600c0b4100b003f7eadb941dmr1733495wmr.19.1686330589592;
        Fri, 09 Jun 2023 10:09:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49SbMDizpqOezr2iQZk3XoEoL+OAzSiMPqUuMSREper0lOeVD4/Oq8Xk7SYTZOS1sEaSGSrg==
X-Received: by 2002:a05:600c:b41:b0:3f7:eadb:941d with SMTP id k1-20020a05600c0b4100b003f7eadb941dmr1733473wmr.19.1686330589330;
        Fri, 09 Jun 2023 10:09:49 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003f7310a3ffasm3265526wmr.2.2023.06.09.10.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 10:09:48 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 3/5] drm/ssd130x: Set the page height value in the device info data
Date:   Fri,  9 Jun 2023 19:09:38 +0200
Message-Id: <20230609170941.1150941-4-javierm@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609170941.1150941-1-javierm@redhat.com>
References: <20230609170941.1150941-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver only supports OLED controllers that have a page height of 8 but
there are devices that have different page heights. So it is better to not
hardcode this value and instead have it as a per controller data value.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v1)

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

