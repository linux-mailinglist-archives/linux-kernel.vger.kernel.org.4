Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3FD722012
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjFEHtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjFEHtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECBEAD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685951296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jb5ZBNmOsLwdAeIIsEiIHMvr3a3yTgXtkOj9ysBMgic=;
        b=hNeixPh2c2HqSpfm6WLH/Fl6qDeUW0JMk+6P+TT7w0knieL4HBZ8WFDdu9saCM/vocywgJ
        S0wyv16kAOC3wSOeXRJIN3QTcTZ3WahY/9T5+NrFCNLMl9hDlaztx4euouLvlV1SXHsha5
        7RVefQ2DsWF0fAipLhWDGIvFW8TYE0I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-CtHHOdk6N3OX9jaHnt-4bw-1; Mon, 05 Jun 2023 03:48:15 -0400
X-MC-Unique: CtHHOdk6N3OX9jaHnt-4bw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4ef455ba61cso2873341e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 00:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685951293; x=1688543293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb5ZBNmOsLwdAeIIsEiIHMvr3a3yTgXtkOj9ysBMgic=;
        b=etqLAv3l0yH2slY1NLzXeAAIQPTell94MwULDOWFeufwkiCk2IqhMHa1VPC5g7bVyW
         pCAST+1l7isbPahGZrq4bs9Z0lYRQdNtPyMoyFDLln0vBsiUBzWg1ORWeNHDbfoWokxS
         zl+pWA7C88tBNROIH4mmz0VxS39lcqeUplNE/rXANQ6CFesKqG2ELmkTYEBN5D1qeYzz
         5IZWXUO7U4aWQFUI9xTZS+YAr+4MURHbOu5EZULIJ7yQaG/CMeUA0sfWznAwYvPZuPPx
         Wt7FIY9KxEq4TLlG4peeAOuPFEjorUli8gDbFpH5ScFHvUIfMpEgOeBGcyK05fI6XswW
         RaEA==
X-Gm-Message-State: AC+VfDxrGfOHYc48W2hpZHa0JPqfwXa+mhRb7hHGcFBUjBOBVR+hJL/0
        jqm9sRNKFM/DyjMJottWuRO2xqLq7+dDdSy2Ikax9n13JNvKJBU6fEJdZmg67S7iqTs3FikqtGh
        lFBYwTdJazsC6HQek1yoKXeMWMO9vOVk0wCWt8GXeOQ5DBrNtArCIRMlXnjoIykPJE5vfedq7FQ
        pdCPq9TeE=
X-Received: by 2002:a05:6512:24b:b0:4f2:5aae:937 with SMTP id b11-20020a056512024b00b004f25aae0937mr5246345lfo.64.1685951293710;
        Mon, 05 Jun 2023 00:48:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7bqR8PicwO8eChYyt0UvbKtzS7nL0qmlSCkFqy6xk6A9Rh2IHMPd0RSsywg3FEcXJyOuukLA==
X-Received: by 2002:a05:6512:24b:b0:4f2:5aae:937 with SMTP id b11-20020a056512024b00b004f25aae0937mr5246326lfo.64.1685951293248;
        Mon, 05 Jun 2023 00:48:13 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q21-20020a1ce915000000b003f4fb5532a1sm9715192wmc.43.2023.06.05.00.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:48:12 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 4/5] drm/ssd130x: Don't allocate buffers on each plane update
Date:   Mon,  5 Jun 2023 09:47:52 +0200
Message-Id: <20230605074753.562332-5-javierm@redhat.com>
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

The resolutions for these panels are fixed and defined in the Device Tree,
so there's no point to allocate the buffers on each plane update and that
can just be done once.

Let's do the allocation and free on the encoder enable and disable helpers
since that's where others initialization and teardown operations are done.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x.c | 88 +++++++++++++++++++------------
 drivers/gpu/drm/solomon/ssd130x.h |  3 ++
 2 files changed, 56 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 5cac1149e34e..0be3b476dc60 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -146,6 +146,31 @@ static inline struct ssd130x_device *drm_to_ssd130x(struct drm_device *drm)
 	return container_of(drm, struct ssd130x_device, drm);
 }
 
+static int ssd130x_buf_alloc(struct ssd130x_device *ssd130x)
+{
+	unsigned int page_height = ssd130x->device_info->page_height;
+	unsigned int pages = DIV_ROUND_UP(ssd130x->height, page_height);
+
+	ssd130x->buffer = kcalloc(DIV_ROUND_UP(ssd130x->width, 8),
+				  ssd130x->height, GFP_KERNEL);
+	if (!ssd130x->buffer)
+		return -ENOMEM;
+
+	ssd130x->data_array = kcalloc(ssd130x->width, pages, GFP_KERNEL);
+	if (!ssd130x->data_array) {
+		kfree(ssd130x->buffer);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void ssd130x_buf_free(struct ssd130x_device *ssd130x)
+{
+	kfree(ssd130x->data_array);
+	kfree(ssd130x->buffer);
+}
+
 /*
  * Helper to write data (SSD130X_DATA) to the device.
  */
@@ -434,11 +459,12 @@ static int ssd130x_init(struct ssd130x_device *ssd130x)
 				 SSD130X_SET_ADDRESS_MODE_HORIZONTAL);
 }
 
-static int ssd130x_update_rect(struct ssd130x_device *ssd130x, u8 *buf,
-			       struct drm_rect *rect)
+static int ssd130x_update_rect(struct ssd130x_device *ssd130x, struct drm_rect *rect)
 {
 	unsigned int x = rect->x1;
 	unsigned int y = rect->y1;
+	u8 *buf = ssd130x->buffer;
+	u8 *data_array = ssd130x->data_array;
 	unsigned int width = drm_rect_width(rect);
 	unsigned int height = drm_rect_height(rect);
 	unsigned int line_length = DIV_ROUND_UP(width, 8);
@@ -447,14 +473,9 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x, u8 *buf,
 	struct drm_device *drm = &ssd130x->drm;
 	u32 array_idx = 0;
 	int ret, i, j, k;
-	u8 *data_array = NULL;
 
 	drm_WARN_ONCE(drm, y % 8 != 0, "y must be aligned to screen page\n");
 
-	data_array = kcalloc(width, pages, GFP_KERNEL);
-	if (!data_array)
-		return -ENOMEM;
-
 	/*
 	 * The screen is divided in pages, each having a height of 8
 	 * pixels, and the width of the screen. When sending a byte of
@@ -488,11 +509,11 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x, u8 *buf,
 		/* Set address range for horizontal addressing mode */
 		ret = ssd130x_set_col_range(ssd130x, ssd130x->col_offset + x, width);
 		if (ret < 0)
-			goto out_free;
+			return ret;
 
 		ret = ssd130x_set_page_range(ssd130x, ssd130x->page_offset + y / 8, pages);
 		if (ret < 0)
-			goto out_free;
+			return ret;
 	}
 
 	for (i = 0; i < pages; i++) {
@@ -522,11 +543,11 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x, u8 *buf,
 						   ssd130x->page_offset + i,
 						   ssd130x->col_offset + x);
 			if (ret < 0)
-				goto out_free;
+				return ret;
 
 			ret = ssd130x_write_data(ssd130x, data_array, width);
 			if (ret < 0)
-				goto out_free;
+				return ret;
 
 			array_idx = 0;
 		}
@@ -536,14 +557,11 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x, u8 *buf,
 	if (!ssd130x->page_address_mode)
 		ret = ssd130x_write_data(ssd130x, data_array, width * pages);
 
-out_free:
-	kfree(data_array);
 	return ret;
 }
 
 static void ssd130x_clear_screen(struct ssd130x_device *ssd130x)
 {
-	u8 *buf = NULL;
 	struct drm_rect fullscreen = {
 		.x1 = 0,
 		.x2 = ssd130x->width,
@@ -551,14 +569,7 @@ static void ssd130x_clear_screen(struct ssd130x_device *ssd130x)
 		.y2 = ssd130x->height,
 	};
 
-	buf = kcalloc(DIV_ROUND_UP(ssd130x->width, 8), ssd130x->height,
-		      GFP_KERNEL);
-	if (!buf)
-		return;
-
-	ssd130x_update_rect(ssd130x, buf, &fullscreen);
-
-	kfree(buf);
+	ssd130x_update_rect(ssd130x, &fullscreen);
 }
 
 static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_map *vmap,
@@ -569,30 +580,27 @@ static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_m
 	struct iosys_map dst;
 	unsigned int dst_pitch;
 	int ret = 0;
-	u8 *buf = NULL;
+	u8 *buf = ssd130x->buffer;
+
+	if (!buf)
+		return 0;
 
 	/* Align y to display page boundaries */
 	rect->y1 = round_down(rect->y1, page_height);
 	rect->y2 = min_t(unsigned int, round_up(rect->y2, page_height), ssd130x->height);
 
 	dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), page_height);
-	buf = kcalloc(dst_pitch, drm_rect_height(rect), GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
 
 	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
 	if (ret)
-		goto out_free;
+		return ret;
 
 	iosys_map_set_vaddr(&dst, buf);
 	drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, vmap, fb, rect);
 
 	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
 
-	ssd130x_update_rect(ssd130x, buf, rect);
-
-out_free:
-	kfree(buf);
+	ssd130x_update_rect(ssd130x, rect);
 
 	return ret;
 }
@@ -701,14 +709,22 @@ static void ssd130x_encoder_helper_atomic_enable(struct drm_encoder *encoder,
 		return;
 
 	ret = ssd130x_init(ssd130x);
-	if (ret) {
-		ssd130x_power_off(ssd130x);
-		return;
-	}
+	if (ret)
+		goto power_off;
+
+	ret = ssd130x_buf_alloc(ssd130x);
+	if (ret)
+		goto power_off;
 
 	ssd130x_write_cmd(ssd130x, 1, SSD130X_DISPLAY_ON);
 
 	backlight_enable(ssd130x->bl_dev);
+
+	return;
+
+power_off:
+	ssd130x_power_off(ssd130x);
+	return;
 }
 
 static void ssd130x_encoder_helper_atomic_disable(struct drm_encoder *encoder,
@@ -721,6 +737,8 @@ static void ssd130x_encoder_helper_atomic_disable(struct drm_encoder *encoder,
 
 	ssd130x_write_cmd(ssd130x, 1, SSD130X_DISPLAY_OFF);
 
+	ssd130x_buf_free(ssd130x);
+
 	ssd130x_power_off(ssd130x);
 }
 
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index 87968b3e7fb8..161588b1cc4d 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -89,6 +89,9 @@ struct ssd130x_device {
 	u8 col_end;
 	u8 page_start;
 	u8 page_end;
+
+	u8 *buffer;
+	u8 *data_array;
 };
 
 extern const struct ssd130x_deviceinfo ssd130x_variants[];
-- 
2.40.1

