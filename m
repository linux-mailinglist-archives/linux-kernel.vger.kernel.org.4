Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0365B7CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIMWPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiIMWPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E0913D72
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663107313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3NFp4VgvnrWlpf0cR1jJD5RUagyd6mZ8BYx1FSeEHWg=;
        b=EbliY4z3kAjWMgTyFM3VwJs/bo18chNsyUFiZthO48yEyH/BfxROmP4szvCTrwaeFIU/J2
        BywdHDar9OPQX764RyVcYJSzvryQhf4iKb6iGFFP9DdQyvWj1vuXEBFwQD/YtzRGfan1uN
        GsmANFknuitNWy0NU867TI7ylFMKEyw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-436-tfTEgqS2NeiVhroYQOlM_Q-1; Tue, 13 Sep 2022 18:15:11 -0400
X-MC-Unique: tfTEgqS2NeiVhroYQOlM_Q-1
Received: by mail-ed1-f70.google.com with SMTP id v11-20020a056402348b00b004516e0b7eedso6594028edc.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3NFp4VgvnrWlpf0cR1jJD5RUagyd6mZ8BYx1FSeEHWg=;
        b=1UaxCruB1yxMHtuQcm2aL4+c6YPHs5/nyVSfDtxz83jdiWV5irUrMFCzYrH3b50vkj
         FWvSPgCP1Sk/pE8jhlqrUBiGvfYwpoYVNjt6xhxbjS6bVODSgbbB/NYCWuDxFLn3MY2R
         S4ffcE2NUX1EowgHA7bUDDEG9UAt1gvQQd73/u6YwPMiS1MPUCoc7zVrfkf0E6Psuut1
         CxKsgVZuhhRZ/KPDRRMVbSsb3vqEqrxzE5pUWs61cipdIeUWHhSa8Sgho1P3LtVGUpIw
         F1k5LatT86iF3fbBuqqA8OpY21PClaPIYX4CjG09vuPhuqrReD2Sh4vqfprrQ+guaGU4
         aLbg==
X-Gm-Message-State: ACgBeo0m1QqvVGRQRF5ubz5eLufAPWh1D+qTASUfOpw196qPTQrAYIcA
        5eRELYNfa+7u2VHIVVkdL7IUWE6CZ70KQ5XK39pJpYUassUo7ZHNlVTwVqb3e4qvLVOlZ0+W1OO
        maMFesid278Vn3fScwRwkLm+X
X-Received: by 2002:a05:6402:5008:b0:440:941a:93c3 with SMTP id p8-20020a056402500800b00440941a93c3mr11421865eda.47.1663107310593;
        Tue, 13 Sep 2022 15:15:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5KhucR8r5x09VFOVDFq9E+WrNdnLRNQO9ncHrfWTWlUc3ZuYrpuLfrhf8xvJhv8/6n25RPzg==
X-Received: by 2002:a05:6402:5008:b0:440:941a:93c3 with SMTP id p8-20020a056402500800b00440941a93c3mr11421856eda.47.1663107310449;
        Tue, 13 Sep 2022 15:15:10 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b00730b61d8a5esm6684941eju.61.2022.09.13.15.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 15:15:10 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 3/6] drm/arm/hdlcd: plane: use drm managed resources
Date:   Wed, 14 Sep 2022 00:14:53 +0200
Message-Id: <20220913221456.147937-4-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220913221456.147937-1-dakr@redhat.com>
References: <20220913221456.147937-1-dakr@redhat.com>
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

