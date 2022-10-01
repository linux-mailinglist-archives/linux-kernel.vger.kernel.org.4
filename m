Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3535F1D07
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJAO6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJAO6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:58:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AF09C202
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664636300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H68P8iepWfLJpYbHEar6qJMBNCk2+2oF4KGUobttlNs=;
        b=LGvpllU2Hta5T+Mec7FgAtz77lXsK76XE6VTeXr+AzSws94PwCh0XIYy5oJNEPDDBf/lry
        OnSjSdfOhzgGQQ3pVfuAfUKzfL9wHoutG2kvOJZbZrlFUFTnVVZrzlv834sXIdH+mon7sC
        thrFc4enq3XugY6/Ta3P6OaFzPt2jNY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-rBbNq1aaOzSvT-6IdySe0Q-1; Sat, 01 Oct 2022 10:58:16 -0400
X-MC-Unique: rBbNq1aaOzSvT-6IdySe0Q-1
Received: by mail-ed1-f69.google.com with SMTP id f10-20020a0564021e8a00b00451be6582d5so5646817edf.15
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 07:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=H68P8iepWfLJpYbHEar6qJMBNCk2+2oF4KGUobttlNs=;
        b=B3bzUn3LTK0MrtCvbhOqMUUhVeYqIHASgnAXzfIZ0rZR4y9Y1mKkYbv2fuqbSne1DF
         +PrdEgZaq7vsIaLkN/2cCmolrARCaAixqxGakLRAhF8o9fufe9vb+6w6nUM9zE2mfodp
         JeWQzDUkhvXFNWo+EAGF6XNKQcAeGQnr8uJGGhxeqMTvC9IFs4gEHr59yHDRpfcrWkhj
         vwV4skSKJWs/JvuXck9ptqT/NgIJcyctVtiqBFd7B7WhzCoyNRIc6STzk2IoTkGlRw6T
         EBrZx4z7/7WHckRGUL+Fe0nvsCoOdfEa8KfFNvKiBQTr1RpQcjHFKWaBp0FxL67l9Ri3
         e6bg==
X-Gm-Message-State: ACrzQf0QDnyvnP4hNNpHUR7Ls/y1UB3urXMJSVFdJp3JaH2AviVqruAT
        cMgsUQw2EUuJADRbskeA4S+sBMhFHyfgRwdk2cXfnoxjsmNhkCfjLbn+uQ5loGIZNLI+c9dvodT
        kJTDOrYzQqhVtcmcDlQqMEsA2
X-Received: by 2002:a17:907:1607:b0:788:799e:dc97 with SMTP id hb7-20020a170907160700b00788799edc97mr4561647ejc.747.1664636295093;
        Sat, 01 Oct 2022 07:58:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5VJBdJUX0WjKukx6WE4HACChCOch/Y067lt40Lp/eZFkvVlX4nIZuEOa8HPfaHF1kX200UDQ==
X-Received: by 2002:a17:907:1607:b0:788:799e:dc97 with SMTP id hb7-20020a170907160700b00788799edc97mr4561641ejc.747.1664636294860;
        Sat, 01 Oct 2022 07:58:14 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id p20-20020a1709066a9400b0072f112a6ad2sm2805616ejr.97.2022.10.01.07.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 07:58:14 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 2/9] drm/fsl-dcu: replace drm->dev_private with drm_to_fsl_dcu_drm_dev()
Date:   Sat,  1 Oct 2022 16:57:55 +0200
Message-Id: <20221001145802.515916-3-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001145802.515916-1-dakr@redhat.com>
References: <20221001145802.515916-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using drm_device->dev_private is deprecated. Since we've switched to
devm_drm_dev_alloc(), struct drm_device is now embedded in struct
malidp_drm, hence we can use container_of() to get the struct drm_device
instance instead.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c  | 12 ++++++------
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c   | 13 ++++---------
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h   |  2 ++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c |  8 ++++----
 4 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index a1b8ce70928a..e05311e2b0e0 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -24,7 +24,7 @@ static void fsl_dcu_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 					  struct drm_atomic_state *state)
 {
 	struct drm_device *dev = crtc->dev;
-	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(dev);
 	struct drm_pending_vblank_event *event = crtc->state->event;
 
 	regmap_write(fsl_dev->regmap,
@@ -48,7 +48,7 @@ static void fsl_dcu_drm_crtc_atomic_disable(struct drm_crtc *crtc,
 	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state,
 									      crtc);
 	struct drm_device *dev = crtc->dev;
-	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(dev);
 
 	/* always disable planes on the CRTC */
 	drm_atomic_helper_disable_planes_on_crtc(old_crtc_state, true);
@@ -67,7 +67,7 @@ static void fsl_dcu_drm_crtc_atomic_enable(struct drm_crtc *crtc,
 					   struct drm_atomic_state *state)
 {
 	struct drm_device *dev = crtc->dev;
-	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(dev);
 
 	clk_prepare_enable(fsl_dev->pix_clk);
 	regmap_update_bits(fsl_dev->regmap, DCU_DCU_MODE,
@@ -82,7 +82,7 @@ static void fsl_dcu_drm_crtc_atomic_enable(struct drm_crtc *crtc,
 static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;
-	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(dev);
 	struct drm_connector *con = &fsl_dev->connector.base;
 	struct drm_display_mode *mode = &crtc->state->mode;
 	unsigned int pol = 0;
@@ -135,7 +135,7 @@ static const struct drm_crtc_helper_funcs fsl_dcu_drm_crtc_helper_funcs = {
 static int fsl_dcu_drm_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;
-	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(dev);
 	unsigned int value;
 
 	regmap_read(fsl_dev->regmap, DCU_INT_MASK, &value);
@@ -148,7 +148,7 @@ static int fsl_dcu_drm_crtc_enable_vblank(struct drm_crtc *crtc)
 static void fsl_dcu_drm_crtc_disable_vblank(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;
-	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(dev);
 	unsigned int value;
 
 	regmap_read(fsl_dev->regmap, DCU_INT_MASK, &value);
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index a47b72995fcf..4139f674c5de 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -52,7 +52,7 @@ static const struct regmap_config fsl_dcu_regmap_config = {
 
 static void fsl_dcu_irq_reset(struct drm_device *dev)
 {
-	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(dev);
 
 	regmap_write(fsl_dev->regmap, DCU_INT_STATUS, ~0);
 	regmap_write(fsl_dev->regmap, DCU_INT_MASK, ~0);
@@ -61,7 +61,7 @@ static void fsl_dcu_irq_reset(struct drm_device *dev)
 static irqreturn_t fsl_dcu_drm_irq(int irq, void *arg)
 {
 	struct drm_device *dev = arg;
-	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(dev);
 	unsigned int int_status;
 	int ret;
 
@@ -91,7 +91,7 @@ static int fsl_dcu_irq_install(struct drm_device *dev, unsigned int irq)
 
 static void fsl_dcu_irq_uninstall(struct drm_device *dev)
 {
-	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(dev);
 
 	fsl_dcu_irq_reset(dev);
 	free_irq(fsl_dev->irq, dev);
@@ -99,7 +99,7 @@ static void fsl_dcu_irq_uninstall(struct drm_device *dev)
 
 static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
 {
-	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(dev);
 	int ret;
 
 	ret = fsl_dcu_drm_modeset_init(fsl_dev);
@@ -133,8 +133,6 @@ static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
 
 	drm_mode_config_cleanup(dev);
 done_vblank:
-	dev->dev_private = NULL;
-
 	return ret;
 }
 
@@ -145,8 +143,6 @@ static void fsl_dcu_unload(struct drm_device *dev)
 
 	drm_mode_config_cleanup(dev);
 	fsl_dcu_irq_uninstall(dev);
-
-	dev->dev_private = NULL;
 }
 
 DEFINE_DRM_GEM_DMA_FOPS(fsl_dcu_drm_fops);
@@ -322,7 +318,6 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 
 	fsl_dev->dev = dev;
 	fsl_dev->np = dev->of_node;
-	drm->dev_private = fsl_dev;
 	dev_set_drvdata(dev, fsl_dev);
 
 	ret = drm_dev_register(drm, 0);
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
index 20ca13ff618a..5b61d443da96 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
@@ -193,6 +193,8 @@ struct fsl_dcu_drm_device {
 	const struct fsl_dcu_soc_data *soc;
 };
 
+#define drm_to_fsl_dcu_drm_dev(x) container_of(x, struct fsl_dcu_drm_device, base)
+
 int fsl_dcu_drm_modeset_init(struct fsl_dcu_drm_device *fsl_dev);
 
 #endif /* __FSL_DCU_DRM_DRV_H__ */
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
index 794a87d16f88..91865956da02 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
@@ -22,7 +22,7 @@
 
 static int fsl_dcu_drm_plane_index(struct drm_plane *plane)
 {
-	struct fsl_dcu_drm_device *fsl_dev = plane->dev->dev_private;
+	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(plane->dev);
 	unsigned int total_layer = fsl_dev->soc->total_layer;
 	unsigned int index;
 
@@ -63,7 +63,7 @@ static int fsl_dcu_drm_plane_atomic_check(struct drm_plane *plane,
 static void fsl_dcu_drm_plane_atomic_disable(struct drm_plane *plane,
 					     struct drm_atomic_state *state)
 {
-	struct fsl_dcu_drm_device *fsl_dev = plane->dev->dev_private;
+	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(plane->dev);
 	unsigned int value;
 	int index;
 
@@ -80,7 +80,7 @@ static void fsl_dcu_drm_plane_atomic_update(struct drm_plane *plane,
 					    struct drm_atomic_state *state)
 
 {
-	struct fsl_dcu_drm_device *fsl_dev = plane->dev->dev_private;
+	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(plane->dev);
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
 									   plane);
 	struct drm_framebuffer *fb = plane->state->fb;
@@ -194,7 +194,7 @@ static const u32 fsl_dcu_drm_plane_formats[] = {
 
 void fsl_dcu_drm_init_planes(struct drm_device *dev)
 {
-	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(dev);
 	int i, j;
 
 	for (i = 0; i < fsl_dev->soc->total_layer; i++) {
-- 
2.37.3

