Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B9F60E4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiJZPfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbiJZPez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE5B6362
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666798491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3W/r9ElK7sh/SFf0M/t1SVrs5dFd+1CxEY7lkRSmLhk=;
        b=Z05caYannmq9/rH3/6PuYTSk6eJLrFWp31M2FhEFz0qz72N8/a0ZMF+ElBxtKWDrBNyZhX
        NZ0ZNv0C/n6rWlt1PPdRq4pd2QGwAxlaCjQ5qQ6Js/NILzCNji8H5LwgMixuTK2SOo6rDz
        HeTe3S0z/Mptn+0zC5P3QGqfUFmCE9w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-9cYeD-raMfe-RLU8VtjsCg-1; Wed, 26 Oct 2022 11:34:50 -0400
X-MC-Unique: 9cYeD-raMfe-RLU8VtjsCg-1
Received: by mail-ej1-f69.google.com with SMTP id sa6-20020a1709076d0600b0078d84ed54b9so4715991ejc.18
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3W/r9ElK7sh/SFf0M/t1SVrs5dFd+1CxEY7lkRSmLhk=;
        b=u3xvuum/BWaxi2rI0LZnpMyaTBBWNj4s0nkYl1rS9K1spoyEOS+1l2zeXMPzp3dPD4
         yFGEI8vu/KfBo0+kAKvRsjjV+isxEOvIwZk5nBYjy6z1oTux0UYEt5THgrefepbnmJFt
         6iry9oLGRiRXFC88Yv5CAQ2gM8/2rwAsN2JeYFb3fIEq1uVgiE83HmMNE9Pbf8McdwDk
         vIxItJORhfbUsEs3T0UHW3HvcxPP70ICW8ERnhs0nrSyIJMEVge2SelDZoqRVvrLQqYx
         7yMgZfb/h2raJvN1JHlEMuskN1abF2b4R5g06MZETeGWBEBqDixEcfxredoW8ElqL/0Z
         c9Hg==
X-Gm-Message-State: ACrzQf0iv4HkSK5S/HB3Lu7IG+cCkA+PRit5DlzQDvoWRHyHgdL4qK+w
        +TJz2zscYQMJhZSWZYZakHmS27RN22VJqG21eD/3Rc7LhO8rEpjBzXmTqI9yGaKsYqxq8v3KVQq
        a61eUtr8hSwv27ZdDWNUi7m5A
X-Received: by 2002:a17:906:8a65:b0:7ad:88f8:7ecc with SMTP id hy5-20020a1709068a6500b007ad88f87eccmr205488ejc.535.1666798489134;
        Wed, 26 Oct 2022 08:34:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7hZV+nzwBhtCJNCfdWd9aTbL+g+XhULTYvMLCYKRB9T7riygaPgFJlt+DyvtV2u2xPOacYiQ==
X-Received: by 2002:a17:906:8a65:b0:7ad:88f8:7ecc with SMTP id hy5-20020a1709068a6500b007ad88f87eccmr205472ejc.535.1666798489007;
        Wed, 26 Oct 2022 08:34:49 -0700 (PDT)
Received: from pollux.. ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id m24-20020a056402051800b00459e3a3f3ddsm3684370edv.79.2022.10.26.08.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:34:48 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v4 3/4] drm/arm/hdlcd: plane: use drm managed resources
Date:   Wed, 26 Oct 2022 17:34:30 +0200
Message-Id: <20221026153431.72033-4-dakr@redhat.com>
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

Use drm managed resource allocation (drmm_universal_plane_alloc()) in
order to get rid of the explicit destroy hook in struct drm_plane_funcs.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_crtc.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index 2055b1abcec3..1de0f7b23766 100644
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
@@ -301,21 +300,16 @@ static struct drm_plane *hdlcd_plane_init(struct drm_device *drm)
 	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
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

