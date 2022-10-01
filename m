Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0675F1D0B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJAO6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJAO62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46FD9C216
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664636305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OuGypoVnJNhzQ829OSUgv+IQ/uot1AKSMTgWYQGrHy8=;
        b=OSUjilZe4+amow3pM51i/xyAvYws5izoC2t4GsHMjnVOeu996QzTnGqzFVZDYY/sbFccfv
        SDjib9PNML39rbnpxC15baBSlIt/aW2joZsHgJE8d2LkbKT5yYCvtjE9h1K7LdJRzpgjCP
        Qwloc6C+QsZWN5lZgBo9CFhM0Q3PY9Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-ytc08axIMHW4n763tzxVLQ-1; Sat, 01 Oct 2022 10:58:23 -0400
X-MC-Unique: ytc08axIMHW4n763tzxVLQ-1
Received: by mail-ed1-f69.google.com with SMTP id h11-20020a05640250cb00b004580ee86ca8so5522312edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 07:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OuGypoVnJNhzQ829OSUgv+IQ/uot1AKSMTgWYQGrHy8=;
        b=Wd1yUDHWc5SOdeMwxwaOgvtKU0eW5LIIlzPONJyDBThBtz4h2LwzNKTI4DOI5WDghn
         eiSnRAeYbMo7sgqrghfg2za3GN6FuMAmCj+b4oFcJaVMoAuDZp16bubjnxRn7B2ghaRv
         Mb1sO/fDmdDJhCOr8Umx2DhfYnWkaMBv7Evo9kgZzInUX6sD7iA3BlCdGxw1Yu04KLxS
         KxEmCI6GRXZKX6eVuAsV4fqX6gnR3UuTjsmHeHScKddowR0gqpRwAAt4teM1rT79L73N
         7HdLj0wHQJTflAtfQvfD1Jti/xr4MckSU7ssmEyLR6hKWl1Dbg6+7AbygF4ZPAkqEtzA
         RIQg==
X-Gm-Message-State: ACrzQf3Pix0tr7GxokvDT+09fyfpe2gTus/tNLVK/qrbT9wtOzSuiHH5
        rMR6ZiDAeOx2lP58IUi8M7ilENJdf/7Y7iQHfC5P9WHruoPHAKDBaEeUWjnOkjllB1MJEZPT201
        ifrHa08E8NB/Kc21D9rWBM3Fl
X-Received: by 2002:a17:907:75c6:b0:788:e57b:e809 with SMTP id jl6-20020a17090775c600b00788e57be809mr3735267ejc.381.1664636302382;
        Sat, 01 Oct 2022 07:58:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6tYvJN/BoUijgGJpiQA9gruyLcr6e+s4NgjahO10nZI7Z+Sz0VARMJ4HyrIlczlfiZU4mzZw==
X-Received: by 2002:a17:907:75c6:b0:788:e57b:e809 with SMTP id jl6-20020a17090775c600b00788e57be809mr3735257ejc.381.1664636302172;
        Sat, 01 Oct 2022 07:58:22 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id y8-20020a056402358800b0044dbecdcd29sm3761029edc.12.2022.10.01.07.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 07:58:21 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 4/9] drm/fsl-dcu: plane: use drm managed resources
Date:   Sat,  1 Oct 2022 16:57:57 +0200
Message-Id: <20221001145802.515916-5-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001145802.515916-1-dakr@redhat.com>
References: <20221001145802.515916-1-dakr@redhat.com>
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
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c  |  4 ++--
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c | 25 ++++++++-------------
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index 0b70624260fc..1dad90f701c8 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -176,8 +176,8 @@ int fsl_dcu_drm_crtc_create(struct fsl_dcu_drm_device *fsl_dev)
 	fsl_dcu_drm_init_planes(drm);
 
 	primary = fsl_dcu_drm_primary_create_plane(drm);
-	if (!primary)
-		return -ENOMEM;
+	if (IS_ERR(primary))
+		return PTR_ERR(primary);
 
 	ret = drmm_crtc_init_with_planes(drm, crtc, primary, NULL,
 					 &fsl_dcu_drm_crtc_funcs, NULL);
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
index 91865956da02..23ff285da477 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
@@ -174,7 +174,6 @@ static const struct drm_plane_helper_funcs fsl_dcu_drm_plane_helper_funcs = {
 static const struct drm_plane_funcs fsl_dcu_drm_plane_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
-	.destroy = drm_plane_helper_destroy,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.reset = drm_atomic_helper_plane_reset,
 	.update_plane = drm_atomic_helper_update_plane,
@@ -206,24 +205,18 @@ void fsl_dcu_drm_init_planes(struct drm_device *dev)
 struct drm_plane *fsl_dcu_drm_primary_create_plane(struct drm_device *dev)
 {
 	struct drm_plane *primary;
-	int ret;
-
-	primary = kzalloc(sizeof(*primary), GFP_KERNEL);
-	if (!primary) {
-		DRM_DEBUG_KMS("Failed to allocate primary plane\n");
-		return NULL;
-	}
 
 	/* possible_crtc's will be filled in later by crtc_init */
-	ret = drm_universal_plane_init(dev, primary, 0,
-				       &fsl_dcu_drm_plane_funcs,
-				       fsl_dcu_drm_plane_formats,
-				       ARRAY_SIZE(fsl_dcu_drm_plane_formats),
-				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
-	if (ret) {
-		kfree(primary);
-		primary = NULL;
+	primary = drmm_universal_plane_alloc(dev, struct drm_plane, dev, 0,
+					     &fsl_dcu_drm_plane_funcs,
+					     fsl_dcu_drm_plane_formats,
+					     ARRAY_SIZE(fsl_dcu_drm_plane_formats),
+					     NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (IS_ERR(primary)) {
+		DRM_DEBUG_KMS("Failed to create primary plane\n");
+		return primary;
 	}
+
 	drm_plane_helper_add(primary, &fsl_dcu_drm_plane_helper_funcs);
 
 	return primary;
-- 
2.37.3

