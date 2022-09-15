Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E715D5B91C4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiIOAdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiIOAdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C2C89913
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663201969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H68P8iepWfLJpYbHEar6qJMBNCk2+2oF4KGUobttlNs=;
        b=eS46ztdqi+o05aYnMnUPbthUlRgLEXmOqybd4i/buJ/4kqwgVxNbOktJglQbazR9E15GvC
        NEIAh/d77ap9a/92PwSXGQFey1luEVILJMtAU9eu+gTT3kPXabEcVfuov86EU79w6/JPtW
        z/R8P3VtVyxGH7U9gIdvuHnXyLPhRmE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-102-TIBDoH7oNw-3AVYUQLJkrw-1; Wed, 14 Sep 2022 20:32:48 -0400
X-MC-Unique: TIBDoH7oNw-3AVYUQLJkrw-1
Received: by mail-ej1-f72.google.com with SMTP id oz30-20020a1709077d9e00b0077239b6a915so6858269ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=H68P8iepWfLJpYbHEar6qJMBNCk2+2oF4KGUobttlNs=;
        b=i4GeSpZXEIazd9kinTIPjqoWRl12suaXG8ANtkCYljey3L0hjdrSPUw+4e98CrXqP2
         Y4ilcCNVyWV6eLDJC6OIlYwugYU8GPZ/4XfIvCwiYvd+G4YXoA/dOntlJin9xNZrT2YA
         z86ufkwULtoXj19pREclOZP4Tjo2Tcl26GBx2YcQBHiR2VpdAtiOt5Jeo3/injXrCMo6
         vfk3jsTYAbvVzNN5JwTkhyufewKTZD6aQMnFU4dfnvzc+avhQtsuLkgCgbsNPcvsj43L
         LT/YMVtvxb+clkg+SNSQL1ZNdHSLZyq2yoNF65xv2kQuKgOoji7hYvTIKQSVl+eP9sIR
         d2CA==
X-Gm-Message-State: ACgBeo1rmyRfNrkwl1Odg9QKOi04K5j0LmMtzhcPk83ph39qqXOn1IVx
        qy2fQWx+2BFRs7TV4J/kci5XOoidulJWt5fKZTva0Ia8f80RC6wFnTjMpZcWoSul9t0OyweqoSw
        0XM+eaGSaBq31J0xrQpshCe6/
X-Received: by 2002:a05:6402:4449:b0:445:cdb6:2de9 with SMTP id o9-20020a056402444900b00445cdb62de9mr32642910edb.59.1663201964988;
        Wed, 14 Sep 2022 17:32:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7XNJXfGvj3h4Jld1qFi2NofTMl3y+rFRcL6dz+AggRntBTERzg0GqzFfVhJIIbLhDdTFEEtw==
X-Received: by 2002:a05:6402:4449:b0:445:cdb6:2de9 with SMTP id o9-20020a056402444900b00445cdb62de9mr32642901edb.59.1663201964831;
        Wed, 14 Sep 2022 17:32:44 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id s15-20020aa7c54f000000b004466f5375a5sm10786760edr.53.2022.09.14.17.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:32:44 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 2/8] drm/fsl-dcu: replace drm->dev_private with drm_to_fsl_dcu_drm_dev()
Date:   Thu, 15 Sep 2022 02:32:25 +0200
Message-Id: <20220915003231.363447-3-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220915003231.363447-1-dakr@redhat.com>
References: <20220915003231.363447-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

