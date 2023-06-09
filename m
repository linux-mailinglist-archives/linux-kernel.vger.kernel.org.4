Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A3372A0FA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjFIRLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjFIRLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587793A90
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686330602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bc1LYu0VxicAbeViPWlWxEzFMdxQOVZhpaNTOwtL/hg=;
        b=dUr6eLUnI9y07SSB80Ht6+bDDKCHzTdzI59/TIH3DD/yEoM16z4s3AyOygEuwERx87HDXC
        YlOJfKpGJrQh7j3eLWE0rYX9PuO9IRPH0oaBv/l/qPfWCVVUVa/+IYeRamq7xPdz1QRMnI
        hn89lWqWFbguzXcls0yi5g+HzQB00hs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-sTr0OLniOZigBGqoKYtIuA-1; Fri, 09 Jun 2023 13:09:53 -0400
X-MC-Unique: sTr0OLniOZigBGqoKYtIuA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7e7cfcae4so11173415e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686330592; x=1688922592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bc1LYu0VxicAbeViPWlWxEzFMdxQOVZhpaNTOwtL/hg=;
        b=XfbTHJDH9wE+xz24owqwPB5Qye/Y9/2ubGqW1J5vrWQIiRrIWpk0BMd3I6e1L4vosh
         Ks/5lI5H8+hg5APk4On6MeaPZtzvsk9jA2AUI1RvQSkpTUnTXem8RAHvEO9jjsq2JWS+
         fO/Hx3JJ0skrur5l3YtPZI+VuotSe9lBfnspSD97a9Ho0LPt6EKRxcIkMlcbfgG56IqR
         YR4Of81Jx3aLauO1I2x17obCZAhrrpykM7pzVVo0JlWz45sshmRC78RSW7DBrfUc9Bda
         TLnO7/nOuS+Ej9Vv/U6RjsR7OgG8zTKHvyFZqzo/fJZk0b5/JUQpqbR1/RvIVuMmeZhX
         KKaw==
X-Gm-Message-State: AC+VfDwUv0ggYD6wmu5taScX54rlGXnFlvg/Xz1WlgVKvbOU0/OPnIJy
        F5VjLC3xWKmehFcImuR1FrOYIxrKy966izaawrmqIlOxsdw2jTbLy1L/pG2GyZNOYGP8neTRaRc
        y8gO2vloWhP+LaiNpf5xYvXQmiwEJiAoOtbXuc/WiZcGQ2ytmERhVGE/yBayHQRVgKRiEmp8GMV
        bGS4NHBxk=
X-Received: by 2002:a05:600c:21c7:b0:3f5:ce4:6c3f with SMTP id x7-20020a05600c21c700b003f50ce46c3fmr1652661wmj.7.1686330592184;
        Fri, 09 Jun 2023 10:09:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wjFaw/BVu+9Gvq+xAzeThM+FlH6UNA9UpjkJJiDQkMhPrOSGy6f7edHqXEEEv7fxbnnCJng==
X-Received: by 2002:a05:600c:21c7:b0:3f5:ce4:6c3f with SMTP id x7-20020a05600c21c700b003f50ce46c3fmr1652644wmj.7.1686330591943;
        Fri, 09 Jun 2023 10:09:51 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003f7310a3ffasm3265526wmr.2.2023.06.09.10.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 10:09:51 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 5/5] drm/ssd130x: Remove hardcoded bits-per-pixel in ssd130x_buf_alloc()
Date:   Fri,  9 Jun 2023 19:09:40 +0200
Message-Id: <20230609170941.1150941-6-javierm@redhat.com>
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

The driver only supports OLED controllers that have a native DRM_FORMAT_C1
pixel format and that is why it has harcoded a division of the width by 8.

But the driver might be extended to support devices that have a different
pixel format. So it's better to use the struct drm_format_info helpers to
compute the size of the buffer, used to store the pixels in native format.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v1)

 drivers/gpu/drm/solomon/ssd130x.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 0be3b476dc60..b3dc1ca9dc10 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -150,9 +150,16 @@ static int ssd130x_buf_alloc(struct ssd130x_device *ssd130x)
 {
 	unsigned int page_height = ssd130x->device_info->page_height;
 	unsigned int pages = DIV_ROUND_UP(ssd130x->height, page_height);
+	const struct drm_format_info *fi;
+	unsigned int pitch;
 
-	ssd130x->buffer = kcalloc(DIV_ROUND_UP(ssd130x->width, 8),
-				  ssd130x->height, GFP_KERNEL);
+	fi = drm_format_info(DRM_FORMAT_C1);
+	if (!fi)
+		return -EINVAL;
+
+	pitch = drm_format_info_min_pitch(fi, 0, ssd130x->width);
+
+	ssd130x->buffer = kcalloc(pitch, ssd130x->height, GFP_KERNEL);
 	if (!ssd130x->buffer)
 		return -ENOMEM;
 
-- 
2.40.1

