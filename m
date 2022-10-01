Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C705F1DC5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJAQkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiJAQk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C8B3054C
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 09:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664642412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpNq1qUZhKiifLu+KM9SiJRwdNZ6qs1ZpRyRyQhvDJU=;
        b=iFEEP9qNvGuiLuSJnxFWSD9GDnLucOenpo4FoLMhj8iVnr7OiXMrYCkPF1AqKD2rbWKkPW
        DE+d44kky9CYxA6q4WMb/LM2KUAsotH/Bwx/ZZccRilq6SBzsJEmTgRHhDBZhOVt2x7cyG
        bVAUPVmUCsYUe6zlQCpdh2mdRoAP9hk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-JfRlQj9IMQajs7ACL-51xQ-1; Sat, 01 Oct 2022 12:40:06 -0400
X-MC-Unique: JfRlQj9IMQajs7ACL-51xQ-1
Received: by mail-ed1-f70.google.com with SMTP id z9-20020a05640240c900b00458dae4ed9cso94729edb.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 09:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gpNq1qUZhKiifLu+KM9SiJRwdNZ6qs1ZpRyRyQhvDJU=;
        b=Jzf9bvJVN8lzotjLG+SKW1M8LZBsbxnMPM22Bb58YPRPPs6XkYGVG7JO8rAfqgV86Z
         fxO9s/4z9NSx/WZeIBq1DRTK27Mm/xQGwnM4mIP+zlUqIgVk0FA0r0QxkM+NXPul8/YJ
         2B/UPp+WLLVvTIYyrX1DErXvnCzrUAz/+tcZPVNzPgi5i5FDlS1LSsh/CxDNIdpRN1na
         ZOG9VfIETjHfU+RF6ba9uT/gyQwZS9wzA0vdNiqmk5Fcgoz/1e7NcUoXG1uRnadvraQk
         Xs+w2GvBjjWprHVvLKhGniu5UlD5Dx5FXSKpPE7pwZrJuGTL5Hd3C8rEC53quJyWTcog
         2GzQ==
X-Gm-Message-State: ACrzQf1vkd+7LM7E7Hb+BKRE/mGq1nDUJxe6xMkhTI9E3dIkJc+Is1fW
        K0Pme8Mh4kNZ4xkCVd+0u8aexdY2PD8NW4KAuWaf/+4O0werHt3hbTi+MRqxwuJF576lqjH+3EL
        9esg8RIm5EwhgrtXTDeSkmTpZ
X-Received: by 2002:a17:906:58c6:b0:782:bfb1:eae8 with SMTP id e6-20020a17090658c600b00782bfb1eae8mr10275543ejs.546.1664642404594;
        Sat, 01 Oct 2022 09:40:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6dlsCgBFNn35lBrJDeKfcylAkcj1My9M18VcnXKYSMaZYumIZ4S/welPhel8+NRewGbsWS3w==
X-Received: by 2002:a17:906:58c6:b0:782:bfb1:eae8 with SMTP id e6-20020a17090658c600b00782bfb1eae8mr10275528ejs.546.1664642404187;
        Sat, 01 Oct 2022 09:40:04 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090653ce00b00781d411a63csm2878086ejo.151.2022.10.01.09.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 09:40:03 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 4/9] drm/arm/malidp: plane: use drm managed resources
Date:   Sat,  1 Oct 2022 18:39:41 +0200
Message-Id: <20221001163946.534067-5-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001163946.534067-1-dakr@redhat.com>
References: <20221001163946.534067-1-dakr@redhat.com>
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
 drivers/gpu/drm/arm/malidp_planes.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 815d9199752f..34547edf1ee3 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -68,14 +68,6 @@
 /* readahead for partial-frame prefetch */
 #define MALIDP_MMU_PREFETCH_READAHEAD		8
 
-static void malidp_de_plane_destroy(struct drm_plane *plane)
-{
-	struct malidp_plane *mp = to_malidp_plane(plane);
-
-	drm_plane_cleanup(plane);
-	kfree(mp);
-}
-
 /*
  * Replicate what the default ->reset hook does: free the state pointer and
  * allocate a new empty object. We just need enough space to store
@@ -260,7 +252,6 @@ static bool malidp_format_mod_supported_per_plane(struct drm_plane *plane,
 static const struct drm_plane_funcs malidp_de_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.destroy = malidp_de_plane_destroy,
 	.reset = malidp_plane_reset,
 	.atomic_duplicate_state = malidp_duplicate_plane_state,
 	.atomic_destroy_state = malidp_destroy_plane_state,
@@ -972,12 +963,6 @@ int malidp_de_planes_init(struct drm_device *drm)
 	for (i = 0; i < map->n_layers; i++) {
 		u8 id = map->layers[i].id;
 
-		plane = kzalloc(sizeof(*plane), GFP_KERNEL);
-		if (!plane) {
-			ret = -ENOMEM;
-			goto cleanup;
-		}
-
 		/* build the list of DRM supported formats based on the map */
 		for (n = 0, j = 0;  j < map->n_pixel_formats; j++) {
 			if ((map->pixel_formats[j].layer & id) == id)
@@ -990,13 +975,14 @@ int malidp_de_planes_init(struct drm_device *drm)
 		/*
 		 * All the layers except smart layer supports AFBC modifiers.
 		 */
-		ret = drm_universal_plane_init(drm, &plane->base, crtcs,
-				&malidp_de_plane_funcs, formats, n,
-				(id == DE_SMART) ? linear_only_modifiers : modifiers,
-				plane_type, NULL);
-
-		if (ret < 0)
+		plane = drmm_universal_plane_alloc(drm, struct malidp_plane, base,
+						   crtcs, &malidp_de_plane_funcs, formats, n,
+						   (id == DE_SMART) ? linear_only_modifiers :
+						   modifiers, plane_type, NULL);
+		if (IS_ERR(plane)) {
+			ret = PTR_ERR(plane);
 			goto cleanup;
+		}
 
 		drm_plane_helper_add(&plane->base,
 				     &malidp_de_plane_helper_funcs);
-- 
2.37.3

