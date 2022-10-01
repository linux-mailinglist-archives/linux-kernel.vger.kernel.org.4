Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2124C5F1860
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiJABXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiJABV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8119B7C312
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664587170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3NFp4VgvnrWlpf0cR1jJD5RUagyd6mZ8BYx1FSeEHWg=;
        b=PaN05dkn8/vKovjRUU8WjWUFhAcxmkyZYE0Gsb+J/q4dNrMExCldqBbTWlIv0YAP47fmG7
        e3Za/7u2/1tjLiJlpjgmD0688V3Lz9JjmHsBGFDytUlOV5TXiEMznT3Nv1WtTwZhBzMA2D
        oemiU3YhTwnhCKSrStfIYgyfID2nVEE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-195-il05Y-GNPbSFB8DW4yJkrA-1; Fri, 30 Sep 2022 21:19:21 -0400
X-MC-Unique: il05Y-GNPbSFB8DW4yJkrA-1
Received: by mail-ed1-f69.google.com with SMTP id s17-20020a056402521100b004511c8d59e3so4683963edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3NFp4VgvnrWlpf0cR1jJD5RUagyd6mZ8BYx1FSeEHWg=;
        b=miKzWX67nBaCnrRhjoTiVKjpY3QRXxKeU25P2w7eN6HikUSdDVy40RJmPwYnZbN/pB
         PwiNOqq/5yp+OFin0fwVSId2jF3N3CFSpCyrzHXVZo92I2Dq1XQE7LIc3Cmb3sDuB4P1
         K10u5hCOi66FIIGataF5JhQLwqW3Uql3HbXgrIgpRQ3loha6Z1AqqmXkYW/PIj80UYAh
         S26yftPb7RuEyiqcDKLQI+3rywHFkCnFfoPhe+RMNCqxMrP0TEI2WXTGztr4xaLs18yA
         PHXs2Wj18rH2CtlvlmfrSesl9uVODt0Ivw+LNpTukKRScpyq2w1FwEW9w5Bp/l/UIrPB
         6k3A==
X-Gm-Message-State: ACrzQf1BaLDiOUae5gAITRNoJ5BzVyM6Hf2UxEoqXJF7UTxvGfmziiOr
        lA8TZrLlTdfRfACvb1hk40pioGnBNDCNT2dbWRZejU8ovLFEhOeWeQ3kXTKEIlPa+TPv5NptFZe
        TXtQVh/9Tl6pxx/PyOA4FVeGr
X-Received: by 2002:a17:907:9812:b0:781:bbff:1d20 with SMTP id ji18-20020a170907981200b00781bbff1d20mr8193513ejc.33.1664587160117;
        Fri, 30 Sep 2022 18:19:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7CQSQnjdvUmSQnJbZMdXRbmz2WBI2YEXp3z+zGa5bI24ZgAEiRi9g+ipz6Q5+W+HezYugKOw==
X-Received: by 2002:a17:907:9812:b0:781:bbff:1d20 with SMTP id ji18-20020a170907981200b00781bbff1d20mr8193507ejc.33.1664587159964;
        Fri, 30 Sep 2022 18:19:19 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id rk14-20020a170907214e00b0078238c1c182sm1870090ejb.222.2022.09.30.18.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 18:19:19 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 3/7] drm/arm/hdlcd: plane: use drm managed resources
Date:   Sat,  1 Oct 2022 03:19:01 +0200
Message-Id: <20221001011905.433408-4-dakr@redhat.com>
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

Use drm managed resource allocation (drmm_universal_plane_alloc()) in
order to get rid of the explicit destroy hook in struct drm_plane_funcs.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_crtc.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index 4a8959d0b2a6..1de0f7b23766 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -290,7 +290,6 @@ static const struct drm_plane_helper_funcs hdlcd_plane_helper_funcs = {
 static const struct drm_plane_funcs hdlcd_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
-	.destroy		= drm_plane_cleanup,
 	.reset			= drm_atomic_helper_plane_reset,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
@@ -298,24 +297,19 @@ static const struct drm_plane_funcs hdlcd_plane_funcs = {
 
 static struct drm_plane *hdlcd_plane_init(struct drm_device *drm)
 {
-	struct hdlcd_drm_private *hdlcd = drm->dev_private;
+	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 	struct drm_plane *plane = NULL;
 	u32 formats[ARRAY_SIZE(supported_formats)], i;
-	int ret;
-
-	plane = devm_kzalloc(drm->dev, sizeof(*plane), GFP_KERNEL);
-	if (!plane)
-		return ERR_PTR(-ENOMEM);
 
 	for (i = 0; i < ARRAY_SIZE(supported_formats); i++)
 		formats[i] = supported_formats[i].fourcc;
 
-	ret = drm_universal_plane_init(drm, plane, 0xff, &hdlcd_plane_funcs,
-				       formats, ARRAY_SIZE(formats),
-				       NULL,
-				       DRM_PLANE_TYPE_PRIMARY, NULL);
-	if (ret)
-		return ERR_PTR(ret);
+	plane = drmm_universal_plane_alloc(drm, struct drm_plane, dev, 0xff,
+					   &hdlcd_plane_funcs,
+					   formats, ARRAY_SIZE(formats),
+					   NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (IS_ERR(plane))
+		return plane;
 
 	drm_plane_helper_add(plane, &hdlcd_plane_helper_funcs);
 	hdlcd->plane = plane;
-- 
2.37.3

