Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF7172A0F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjFIRLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFIRLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26CA3A91
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686330596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osHYEg9JMVxcIID/3FozYzoCPjrYA2Xwquo9voZzxrU=;
        b=K7w0l/x1JJYWVfKzUyGcOceebIbQyq7peaPFgdPcjZ9WUlPV9cJb5GLRd+KwDpVu+9OwNv
        uLYmKtRk83MOi8ISCS05FruaN9nDQBJGJOtsZ18kfUcnkUtWwbfe253BFNoAZrP56lUv29
        rSdwJOz9kQb4wtte+V/oq5dtAmeFR6M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-5E6H4JA9NRy8DozdvDF6Jw-1; Fri, 09 Jun 2023 13:09:52 -0400
X-MC-Unique: 5E6H4JA9NRy8DozdvDF6Jw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7ecc15771so9674835e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686330591; x=1688922591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osHYEg9JMVxcIID/3FozYzoCPjrYA2Xwquo9voZzxrU=;
        b=VK3+RdG2GmL/2IJFGVAUjtcWcum0ZJpEh7ulniXL2IAMznUMAMRp99TxQ8BHd6OzOY
         /Li5eNeiVBjiEFulm/MryMhq2HOUBJ7ORRZ2JcWfTFlTtlhGEDca87bLKdsfcA40L5jS
         BYBwUaAa35ahwj33JkVXq0NLA4KRrUwdVRTNwm2WRQzUlpxKnFIDBdfuVu8DdLorMF5t
         hjSCkda543KE2bq3gkLMlXe7NsoL9P55JN53OpSZTtNBMQkIhXwAOQ5DFsQmzAb5s2g4
         vaotA5B5kh8r727dgCRpGnRZ1boiGa4ma1/sjNDQFeD1XV8M150jZaPDCUmltGLFKMdB
         /32g==
X-Gm-Message-State: AC+VfDz/3Q3uHBhqHokfM2wDgKLv5ywx4h/bhsanLaAedhEvzh9nJPyU
        oGIo6lPwGkzM1OClM9EAOP83b+qvqtRISgYeAnXpJoqYciNeLFSbMcncDRGqHek0A8rxbV9ibVH
        DA5IIBbmQWllZI5CjxCUB3Vi767B4N2IpVDEwtgpuZBSvoYiCk+Fhig71aG3Phc17K7TzrYDWFs
        vmivSEE0c=
X-Received: by 2002:a05:600c:1c15:b0:3f7:aee8:c23a with SMTP id j21-20020a05600c1c1500b003f7aee8c23amr4211146wms.19.1686330591010;
        Fri, 09 Jun 2023 10:09:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6DJBJR1m0HtIRW4IMJAA2OUlhq5FLYjJDGioHzrTZbWaUfAcQHxCZLv5OsSW8RuiWv6LcW8g==
X-Received: by 2002:a05:600c:1c15:b0:3f7:aee8:c23a with SMTP id j21-20020a05600c1c1500b003f7aee8c23amr4211127wms.19.1686330590735;
        Fri, 09 Jun 2023 10:09:50 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003f7310a3ffasm3265526wmr.2.2023.06.09.10.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 10:09:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 4/5] drm/ssd130x: Don't allocate buffers on each plane update
Date:   Fri,  9 Jun 2023 19:09:39 +0200
Message-Id: <20230609170941.1150941-5-javierm@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609170941.1150941-1-javierm@redhat.com>
References: <20230609170941.1150941-1-javierm@redhat.com>
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
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v1)

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

