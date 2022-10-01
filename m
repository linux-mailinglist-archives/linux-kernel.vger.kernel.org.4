Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CCD5F1862
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiJABXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbiJABV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B23F3C7D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664587158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZIl1OKGrL3KJyd7ruXlclzCfjtYvrZNcDLCxG8/BBY=;
        b=Axqjy2xWBoG45kdWLPudk3agk+oVMxYTId/CAEhe8ikIrYIVKrEKvl5hNsXSBa/i6hz6FR
        G+BfVKHSg4/cotEfHeRxruL13EN7h+/qbFFd9pgXiTqXdVqatFeAv/izCfr5It5YA60xhJ
        OAnpKsCNcLaimu4wZ2VTf9R5vw9vFKw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-459-EAU4_hTOPwqGGzwpJ3KKEw-1; Fri, 30 Sep 2022 21:19:17 -0400
X-MC-Unique: EAU4_hTOPwqGGzwpJ3KKEw-1
Received: by mail-ed1-f72.google.com with SMTP id b16-20020a056402279000b0044f1102e6e2so4743371ede.20
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yZIl1OKGrL3KJyd7ruXlclzCfjtYvrZNcDLCxG8/BBY=;
        b=4Lpej9dc6+OhKgy/t2g6CbMkaCg8hAy1HZ7hkdkrVkPEEUXBjPy/Tl1zsn+tABVdDW
         HBeMXqQGAov6EHP0jpKjW5KjgR0tsaPPdEGNhM8m4XcmYh+8PjHO4qOyRrtxdAUBxl/y
         EhRQJ7oEk0cWBdD/7tTx6JIG8LGe7HE10uz7DQLPBCJCALdLWUEGi5sd1AOiYwn2GTsO
         +zjys77FWyywQ2uN2fhuwnLI25auaaHAGQp8Kf2YUmU2OOGxwYQe5eLBx+e7cDQju3Ca
         m2aTuPxC7Up1TV3q5w/aeuikbJ23q1K/9uS+2xpNmtIwsBddCXYlt0jEH1N2Ys1hAFEh
         1qKQ==
X-Gm-Message-State: ACrzQf3djMFJv7hfJ5BXEi/aBfVa8+f7YHAv999rZoY+VLFr7YTbSDFF
        Owo+si7+JX7jVilwkhnKuJbhHmTXrVRKuQeJftDt2xixc5vVlG8Ba/fCE/FIqLzacKaB4E4jiHO
        a0qPYYx3eCg42qyXVKEBSmGEh
X-Received: by 2002:a17:907:a044:b0:770:da0d:171d with SMTP id gz4-20020a170907a04400b00770da0d171dmr7828114ejc.742.1664587156484;
        Fri, 30 Sep 2022 18:19:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4eBxmC9x/tkFzxVy0Ywf9ks7MiJUJ5b/u5kQtcjdJwQnAOGv3FCHcSaFJN6022V7sq0e0VMg==
X-Received: by 2002:a17:907:a044:b0:770:da0d:171d with SMTP id gz4-20020a170907a04400b00770da0d171dmr7828106ejc.742.1664587156315;
        Fri, 30 Sep 2022 18:19:16 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906a10e00b0077e6be40e4asm1914914ejy.175.2022.09.30.18.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 18:19:16 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 2/7] drm/arm/hdlcd: replace drm->dev_private with drm_to_hdlcd_priv()
Date:   Sat,  1 Oct 2022 03:19:00 +0200
Message-Id: <20221001011905.433408-3-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001011905.433408-1-dakr@redhat.com>
References: <20221001011905.433408-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/gpu/drm/arm/hdlcd_crtc.c |  4 ++--
 drivers/gpu/drm/arm/hdlcd_drv.c  | 10 ++++------
 drivers/gpu/drm/arm/hdlcd_drv.h  |  1 +
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index 7030339fa232..4a8959d0b2a6 100644
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

