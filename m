Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5930360E4A0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiJZPe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiJZPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D7926D0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666798487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wv7XhFHELyxghr92um+sD68M2S8O9jxLDlBijfPgaUI=;
        b=e99EHaJuAInK0tRiigI3E5OI0kPoqBn6+YBngJ2I4oy++apMF/0HOVIIu6s+sdZ7UyFTGF
        Yp4U/gbJRfHkjVjmAyQm1DipdjOE0BaZqYEKGq/gwoLnBR4aiHBjdAfLNehXuIUAHe+bKT
        /jiOvYTvDwQN1Gc/fCjuXmt6DpGZ3ms=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-400-_29Ajp7dNbeH3u7JtMZeQQ-1; Wed, 26 Oct 2022 11:34:46 -0400
X-MC-Unique: _29Ajp7dNbeH3u7JtMZeQQ-1
Received: by mail-ed1-f72.google.com with SMTP id e15-20020a056402190f00b00461b0576620so8101595edz.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wv7XhFHELyxghr92um+sD68M2S8O9jxLDlBijfPgaUI=;
        b=iI6yXbnSRPGv0fI5I4V4pqUagYdeg8W+fhApS+uKOwwaD5qhEGHIOYPNLMlj9rt5Ec
         fWVLoTLESVW6HNoCxGYbz/3PDIt6ehV7HHdBW9o183WP/0BVe1PcoIDJ00jMf5PUul6I
         YgeQT5pbQK+NvZbJCfuD44iIDJryFMjm6AZL0gBsS0qGlSW6fgEHq2axDXp8uwiAxH+G
         P56urJffo43/o9dmJtGBRgVdeKp5+J6gsXCuxS1XOirRYwTm0VmC8vwI8uI0odFwqoJ+
         Qcm88zito1OeI1XW2/ExQtU+C4jvabeYWKBThRa7Tthu6SBH16kO+4pGXBAuVgEkSgJP
         Rq7g==
X-Gm-Message-State: ACrzQf1vmVAyX6Y8OUtK1YoTf5xc4GtmTv3D5kU7ed8M6SPUVBAQKn5B
        RGXdPqWzeB4DSInGazy+t2+Rsv1XtoOqloYcP+Tr90tA0g1v1Q3LZHVl3Mqnd+QtZDZ7z3DU/xx
        ht4Y88vMwzwpfYjl4JovD7bIa
X-Received: by 2002:aa7:cd92:0:b0:456:cbb5:2027 with SMTP id x18-20020aa7cd92000000b00456cbb52027mr41214705edv.384.1666798485501;
        Wed, 26 Oct 2022 08:34:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4hSmFGZW5A+vOVIQIYLIAaA5j5SuIKXayCNg+a/tMrty6G3mAQlX05AW6FSdwf0iYaX8xCKg==
X-Received: by 2002:aa7:cd92:0:b0:456:cbb5:2027 with SMTP id x18-20020aa7cd92000000b00456cbb52027mr41214687edv.384.1666798485360;
        Wed, 26 Oct 2022 08:34:45 -0700 (PDT)
Received: from pollux.. ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id s14-20020a170906960e00b00780ab5a9116sm3164438ejx.211.2022.10.26.08.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:34:45 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v4 2/4] drm/arm/hdlcd: replace drm->dev_private with drm_to_hdlcd_priv()
Date:   Wed, 26 Oct 2022 17:34:29 +0200
Message-Id: <20221026153431.72033-3-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221026153431.72033-1-dakr@redhat.com>
References: <20221026153431.72033-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using drm_device->dev_private is deprecated. Since we've switched to
devm_drm_dev_alloc(), struct drm_device is now embedded in struct
hdlcd_drm_private, hence we can use container_of() to get the struct
drm_device instance instead.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_crtc.c |  6 +++---
 drivers/gpu/drm/arm/hdlcd_drv.c  | 10 ++++------
 drivers/gpu/drm/arm/hdlcd_drv.h  |  1 +
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index 7030339fa232..2055b1abcec3 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -275,7 +275,7 @@ static void hdlcd_plane_atomic_update(struct drm_plane *plane,
 	dest_h = drm_rect_height(&new_plane_state->dst);
 	scanout_start = drm_fb_dma_get_gem_addr(fb, new_plane_state, 0);
 
-	hdlcd = plane->dev->dev_private;
+	hdlcd = drm_to_hdlcd_priv(plane->dev);
 	hdlcd_write(hdlcd, HDLCD_REG_FB_LINE_LENGTH, fb->pitches[0]);
 	hdlcd_write(hdlcd, HDLCD_REG_FB_LINE_PITCH, fb->pitches[0]);
 	hdlcd_write(hdlcd, HDLCD_REG_FB_LINE_COUNT, dest_h - 1);
@@ -298,7 +298,7 @@ static const struct drm_plane_funcs hdlcd_plane_funcs = {
 
 static struct drm_plane *hdlcd_plane_init(struct drm_device *drm)
 {
-	struct hdlcd_drm_private *hdlcd = drm->dev_private;
+	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 	struct drm_plane *plane = NULL;
 	u32 formats[ARRAY_SIZE(supported_formats)], i;
 	int ret;
@@ -325,7 +325,7 @@ static struct drm_plane *hdlcd_plane_init(struct drm_device *drm)
 
 int hdlcd_setup_crtc(struct drm_device *drm)
 {
-	struct hdlcd_drm_private *hdlcd = drm->dev_private;
+	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 	struct drm_plane *primary;
 	int ret;
 
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 463381d11cff..120c87934a91 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -98,7 +98,7 @@ static void hdlcd_irq_uninstall(struct hdlcd_drm_private *hdlcd)
 
 static int hdlcd_load(struct drm_device *drm, unsigned long flags)
 {
-	struct hdlcd_drm_private *hdlcd = drm->dev_private;
+	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 	struct platform_device *pdev = to_platform_device(drm->dev);
 	struct resource *res;
 	u32 version;
@@ -190,7 +190,7 @@ static int hdlcd_show_underrun_count(struct seq_file *m, void *arg)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *drm = node->minor->dev;
-	struct hdlcd_drm_private *hdlcd = drm->dev_private;
+	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 
 	seq_printf(m, "underrun : %d\n", atomic_read(&hdlcd->buffer_underrun_count));
 	seq_printf(m, "dma_end  : %d\n", atomic_read(&hdlcd->dma_end_count));
@@ -203,7 +203,7 @@ static int hdlcd_show_pxlclock(struct seq_file *m, void *arg)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *drm = node->minor->dev;
-	struct hdlcd_drm_private *hdlcd = drm->dev_private;
+	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 	unsigned long clkrate = clk_get_rate(hdlcd->clk);
 	unsigned long mode_clock = hdlcd->crtc.mode.crtc_clock * 1000;
 
@@ -253,7 +253,6 @@ static int hdlcd_drm_bind(struct device *dev)
 
 	drm = &hdlcd->base;
 
-	drm->dev_private = hdlcd;
 	dev_set_drvdata(dev, drm);
 
 	hdlcd_setup_mode_config(drm);
@@ -324,7 +323,7 @@ static int hdlcd_drm_bind(struct device *dev)
 static void hdlcd_drm_unbind(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
-	struct hdlcd_drm_private *hdlcd = drm->dev_private;
+	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 
 	drm_dev_unregister(drm);
 	drm_kms_helper_poll_fini(drm);
@@ -339,7 +338,6 @@ static void hdlcd_drm_unbind(struct device *dev)
 		pm_runtime_disable(dev);
 	of_reserved_mem_device_release(dev);
 	drm_mode_config_cleanup(drm);
-	drm->dev_private = NULL;
 	dev_set_drvdata(dev, NULL);
 }
 
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.h b/drivers/gpu/drm/arm/hdlcd_drv.h
index 3892b36767ac..f1c1da2ac2db 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.h
+++ b/drivers/gpu/drm/arm/hdlcd_drv.h
@@ -21,6 +21,7 @@ struct hdlcd_drm_private {
 #endif
 };
 
+#define drm_to_hdlcd_priv(x)	container_of(x, struct hdlcd_drm_private, base)
 #define crtc_to_hdlcd_priv(x)	container_of(x, struct hdlcd_drm_private, crtc)
 
 static inline void hdlcd_write(struct hdlcd_drm_private *hdlcd,
-- 
2.37.3

