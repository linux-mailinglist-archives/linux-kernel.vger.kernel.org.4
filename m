Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DAE5F1865
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiJABYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiJABXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:23:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75B224F12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664587261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOw+nn7ti+m5Q8fWTW3IpLkOdVFAAWp2wbEVH0hCZZg=;
        b=bymKsMN9ihNMksK9IMJv1tO+WfMv78zcMQdAldbpGKuExcTO60sTqNxO3IYhG//qIRR/sc
        +3fHKD1VIyThxlb4LwGUsPnl56K0pZUSl1pko7aCfJDYyoy09taWX9yG7P0N6SNTXkyXQS
        8pxxw+1eVVKfuaobsxF2pefu52N0l4U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-2-IkMrQ0KHP-yJnwUxAIqabQ-1; Fri, 30 Sep 2022 21:19:28 -0400
X-MC-Unique: IkMrQ0KHP-yJnwUxAIqabQ-1
Received: by mail-ed1-f70.google.com with SMTP id s17-20020a056402521100b004511c8d59e3so4684098edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VOw+nn7ti+m5Q8fWTW3IpLkOdVFAAWp2wbEVH0hCZZg=;
        b=TIx9wK7iteOxtW5Um3VNVlRpPzzESjAcOzNMZj27sH9u6+LPAvBOkXCraB72c14WXn
         IaEo3yA2dmUg4PeawlnO5SdPYX6vxFBSa755lOFuQFAXbQL0jz314QtI8h1ZT1SoCSo+
         ArFOAb2iqytGRTAv1MAo6Mi36LNk/cQTB6tIj0Ery34xsaimoqEXz/ZxRYb8qYSx9PTp
         KGt5IMmYi3LX/y/EZ4ZJLFdcwU7lsTpGXBCxwLULDt3Fvs0BT1P7vt959DeiB+lUnQiy
         6cQvOM9KOEqLOrJCBirAaU/suxl0EPZexM7zfKsJX148TPTXEOeagXC0yzgrRUc+tKAe
         JK4g==
X-Gm-Message-State: ACrzQf19Zzw47Q4XMFCdqEQoFCA+DnzUufQluBXkOZJcER0ZzcqUKANJ
        1p4Dnvo3gCRrFf97DXUWNQLoqJ3M3XNLrgvarkzgylLh1KkQ2dkZ43+C3X9bAgxusEnRrTtpv73
        rwk5DCLHLH2jhxPYNySevM1AW
X-Received: by 2002:a05:6402:1f89:b0:453:8093:c4e5 with SMTP id c9-20020a0564021f8900b004538093c4e5mr10144849edc.182.1664587167487;
        Fri, 30 Sep 2022 18:19:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Cz2MhkPwjR82bZuuI/cuJB5Tw0OCSgZ/P3E5KDFUBi+NqgMptkOjbE77f1V0GFF7/gDVgWg==
X-Received: by 2002:a05:6402:1f89:b0:453:8093:c4e5 with SMTP id c9-20020a0564021f8900b004538093c4e5mr10144830edc.182.1664587167242;
        Fri, 30 Sep 2022 18:19:27 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090618a900b007821f4bc328sm1948804ejf.178.2022.09.30.18.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 18:19:26 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 5/7] drm/arm/hdlcd: crtc: protect device resources after removal
Date:   Sat,  1 Oct 2022 03:19:03 +0200
Message-Id: <20221001011905.433408-6-dakr@redhat.com>
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

(Hardware) resources which are bound to the driver and device lifecycle
must not be accessed after the device and driver are unbound.

However, the DRM device isn't freed as long as the last user didn't
close it, hence userspace can still call into the driver.

Therefore protect the critical sections which are accessing those
resources with drm_dev_enter() and drm_dev_exit().

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_crtc.c | 60 +++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index 1de0f7b23766..7ce88fb6e822 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -18,6 +18,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_framebuffer.h>
@@ -39,28 +40,50 @@
 static void hdlcd_crtc_cleanup(struct drm_crtc *crtc)
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
+	int idx;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		goto cleanup;
 
 	/* stop the controller on cleanup */
 	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 0);
+
+	drm_dev_exit(idx);
+
+cleanup:
 	drm_crtc_cleanup(crtc);
 }
 
 static int hdlcd_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
-	unsigned int mask = hdlcd_read(hdlcd, HDLCD_REG_INT_MASK);
+	unsigned int mask;
+	int idx;
 
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return -ENODEV;
+
+	mask = hdlcd_read(hdlcd, HDLCD_REG_INT_MASK);
 	hdlcd_write(hdlcd, HDLCD_REG_INT_MASK, mask | HDLCD_INTERRUPT_VSYNC);
 
+	drm_dev_exit(idx);
+
 	return 0;
 }
 
 static void hdlcd_crtc_disable_vblank(struct drm_crtc *crtc)
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
-	unsigned int mask = hdlcd_read(hdlcd, HDLCD_REG_INT_MASK);
+	unsigned int mask;
+	int idx;
 
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return;
+
+	mask = hdlcd_read(hdlcd, HDLCD_REG_INT_MASK);
 	hdlcd_write(hdlcd, HDLCD_REG_INT_MASK, mask & ~HDLCD_INTERRUPT_VSYNC);
+
+	drm_dev_exit(idx);
 }
 
 static const struct drm_crtc_funcs hdlcd_crtc_funcs = {
@@ -171,21 +194,33 @@ static void hdlcd_crtc_atomic_enable(struct drm_crtc *crtc,
 				     struct drm_atomic_state *state)
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
+	int idx;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return;
 
 	clk_prepare_enable(hdlcd->clk);
 	hdlcd_crtc_mode_set_nofb(crtc);
 	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 1);
 	drm_crtc_vblank_on(crtc);
+
+	drm_dev_exit(idx);
 }
 
 static void hdlcd_crtc_atomic_disable(struct drm_crtc *crtc,
 				      struct drm_atomic_state *state)
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
+	int idx;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return;
 
 	drm_crtc_vblank_off(crtc);
 	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 0);
 	clk_disable_unprepare(hdlcd->clk);
+
+	drm_dev_exit(idx);
 }
 
 static enum drm_mode_status hdlcd_crtc_mode_valid(struct drm_crtc *crtc,
@@ -193,15 +228,23 @@ static enum drm_mode_status hdlcd_crtc_mode_valid(struct drm_crtc *crtc,
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
 	long rate, clk_rate = mode->clock * 1000;
+	enum drm_mode_status status = MODE_OK;
+	int idx;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return MODE_NOCLOCK;
 
 	rate = clk_round_rate(hdlcd->clk, clk_rate);
 	/* 0.1% seems a close enough tolerance for the TDA19988 on Juno */
 	if (abs(rate - clk_rate) * 1000 > clk_rate) {
 		/* clock required by mode not supported by hardware */
-		return MODE_NOCLOCK;
+		status = MODE_NOCLOCK;
+		goto out;
 	}
 
-	return MODE_OK;
+out:
+	drm_dev_exit(idx);
+	return status;
 }
 
 static void hdlcd_crtc_atomic_begin(struct drm_crtc *crtc,
@@ -268,10 +311,14 @@ static void hdlcd_plane_atomic_update(struct drm_plane *plane,
 	struct hdlcd_drm_private *hdlcd;
 	u32 dest_h;
 	dma_addr_t scanout_start;
+	int idx;
 
-	if (!fb)
+	if (!drm_dev_enter(plane->dev, &idx))
 		return;
 
+	if (!fb)
+		goto out;
+
 	dest_h = drm_rect_height(&new_plane_state->dst);
 	scanout_start = drm_fb_dma_get_gem_addr(fb, new_plane_state, 0);
 
@@ -280,6 +327,9 @@ static void hdlcd_plane_atomic_update(struct drm_plane *plane,
 	hdlcd_write(hdlcd, HDLCD_REG_FB_LINE_PITCH, fb->pitches[0]);
 	hdlcd_write(hdlcd, HDLCD_REG_FB_LINE_COUNT, dest_h - 1);
 	hdlcd_write(hdlcd, HDLCD_REG_FB_BASE, scanout_start);
+
+out:
+	drm_dev_exit(idx);
 }
 
 static const struct drm_plane_helper_funcs hdlcd_plane_helper_funcs = {
-- 
2.37.3

