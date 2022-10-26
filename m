Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF4160E524
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiJZQAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbiJZQAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:00:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E184215FFE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666799998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpNq1qUZhKiifLu+KM9SiJRwdNZ6qs1ZpRyRyQhvDJU=;
        b=cQMsX/2TwhWlGCivL3TmNA3IAgeEXgqy83LsR47BA/O7JzhkgMyuRh72+TAmphXMfP5uZ0
        c+6MCE+t1ZBs1+2IGrkoBHovNW7ew48BppEDnv74s3VodbseSzlic0CN6QvMlU0SGYQY0G
        z5qHG4RMS7bg/hOY9xElUhBe/yt0Dfk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-177-cBkUlQwhPc-NlAnxL9-JFw-1; Wed, 26 Oct 2022 11:59:56 -0400
X-MC-Unique: cBkUlQwhPc-NlAnxL9-JFw-1
Received: by mail-ej1-f72.google.com with SMTP id qk31-20020a1709077f9f00b00791a3e02c80so4853157ejc.21
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpNq1qUZhKiifLu+KM9SiJRwdNZ6qs1ZpRyRyQhvDJU=;
        b=HN6CFFMctbSvd1KaLYLA6fzbAVx9G8ZOW+9tc7sf1mTSpWHh+LL1KAQhmSixyrOerI
         P3W0O/sYicWmzuTHskdj+CLK7y5NrqBFRZjj3T0rOZGtjJkfCjPtbc8sxGHqiRxVWcMN
         niy2H9BFG3k24lWIGSh5JGmJPpZAQzRuM9mb0pQV6vZBZSvEGKen5gZcSiIBL2ifOwLv
         TaIWBHsNTdAG3W+ScZ3DmkKogwmWCAbHrVvqSfJoa+Byb11tJB7npw3wsmwA/zWByJc9
         WfVFOTnodZ723l/d7cXrKdtbxH5HrZIAE3q5fIkOhTYw+ecDCZAQJXMb3dBoYcQQabrm
         YyFw==
X-Gm-Message-State: ACrzQf0YsIs5v4kQ471a72yb76EMlIT2z/4MQl2LGVKUiDEZZdLPRStT
        Dl1BBbZgikKeyrVt6TVScvaMNlCHgFfnjx+mdv++Er/h7rkyUYKlFO7sKm4EroTSnic8tA0cBFY
        I5I/ZWdWgL+IXMoVYUEXcsQpm
X-Received: by 2002:a17:907:7da5:b0:78e:2c3b:55a2 with SMTP id oz37-20020a1709077da500b0078e2c3b55a2mr37640213ejc.96.1666799995807;
        Wed, 26 Oct 2022 08:59:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5YrSAyisghiztcgWJNOopJzEmf3XBSlrRm9MEdt4PsEo1LmsNW0ikCNzTUPDQnoeFLY5vctg==
X-Received: by 2002:a17:907:7da5:b0:78e:2c3b:55a2 with SMTP id oz37-20020a1709077da500b0078e2c3b55a2mr37640195ejc.96.1666799995600;
        Wed, 26 Oct 2022 08:59:55 -0700 (PDT)
Received: from pollux.. ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709064a4100b00730bfe6adc4sm3202386ejv.37.2022.10.26.08.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:59:55 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 4/5] drm/arm/malidp: plane: use drm managed resources
Date:   Wed, 26 Oct 2022 17:59:33 +0200
Message-Id: <20221026155934.125294-5-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221026155934.125294-1-dakr@redhat.com>
References: <20221026155934.125294-1-dakr@redhat.com>
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

