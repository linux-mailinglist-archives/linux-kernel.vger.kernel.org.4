Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89F15F1D08
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJAO6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiJAO6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:58:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEEC9AFD1
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664636300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xaw3iUtMLKwH2xCvo5P17z6DGidg5D+TvENUAVXK2ek=;
        b=Ge4wTODCgNuMHZufQDdz2TGzLs4/Ip2i7Ymjah1Pr1oDc2vyzlurNKIS5mMyoxJBcMWPSz
        ID4ajHct3ZhDt2UfEQgUKreSZnWIe6gRMIzE0LCZwfDi3lYKpxApUw4C+LyH3CDuf/zJ4g
        LVOUJIBOJ2M6JZq/7hgia/T/ZqIo5Hc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-150-fxRw21DRPmedLVRNxM9ZIw-1; Sat, 01 Oct 2022 10:58:19 -0400
X-MC-Unique: fxRw21DRPmedLVRNxM9ZIw-1
Received: by mail-ed1-f69.google.com with SMTP id r11-20020a05640251cb00b004516feb8c09so5609652edd.10
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 07:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Xaw3iUtMLKwH2xCvo5P17z6DGidg5D+TvENUAVXK2ek=;
        b=oYyt3iYqGBsoNWKBpZja/qnYrRhMW9qJVxklkGQUoozLaOrbqHjcO0sKWXMG6+f9Iu
         ypSm0tFDtaqYgYvJ+PiW75kUxeEfNMudWLuG38rxmV3SjEbUnmnHnkjXR8LROg7DBnV7
         MAPN9kc8i/CnuDVeTaTveSornHashHaxMf/a6R7xo/iNAgF94A4XF5LtpvDxqskpx9Ul
         YCcAJvFgO0gLBKcwxxu7DHvE+sZLt31atd+knAx5ZYULjXxYPs6578K0vIMXTNjJ1F5V
         t9yvF/VX2QMDdMlcYIoVg22+DYsR7Qdu38E99sBAMUenEpHurCZLuOXdZ6tRwraH4PCU
         yH3Q==
X-Gm-Message-State: ACrzQf077iUDGtt/7q6yFvhfDf4C1Wv39zVjleSGBj8WDe/rZn4x/ibZ
        bj60CLtlmc1yygFMMZipVcjqxdABW/8tTvu8qgEpHvHccNIDyDfQdqkBSvSxlemEXgmVcXr/Wr8
        tZUxTuv+hsFEOezg6w9rmKKgo
X-Received: by 2002:a17:907:3e03:b0:722:e694:438 with SMTP id hp3-20020a1709073e0300b00722e6940438mr9931985ejc.755.1664636298702;
        Sat, 01 Oct 2022 07:58:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6McnwQbh25ByTVLN8VQt9u6fQvaQzvbsTHh1j6XxDmkF9GAiQCD/6b0HFlFj3pU/ONxJXXjQ==
X-Received: by 2002:a17:907:3e03:b0:722:e694:438 with SMTP id hp3-20020a1709073e0300b00722e6940438mr9931973ejc.755.1664636298531;
        Sat, 01 Oct 2022 07:58:18 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090676d500b0072af4af2f46sm2816338ejn.74.2022.10.01.07.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 07:58:18 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 3/9] drm/fsl-dcu: crtc: use drmm_crtc_init_with_planes()
Date:   Sat,  1 Oct 2022 16:57:56 +0200
Message-Id: <20221001145802.515916-4-dakr@redhat.com>
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

Use drmm_crtc_init_with_planes() instead of drm_crtc_init_with_planes()
to get rid of the explicit destroy hook in struct drm_plane_funcs.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index e05311e2b0e0..0b70624260fc 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -159,7 +159,6 @@ static void fsl_dcu_drm_crtc_disable_vblank(struct drm_crtc *crtc)
 static const struct drm_crtc_funcs fsl_dcu_drm_crtc_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
-	.destroy = drm_crtc_cleanup,
 	.page_flip = drm_atomic_helper_page_flip,
 	.reset = drm_atomic_helper_crtc_reset,
 	.set_config = drm_atomic_helper_set_config,
@@ -180,8 +179,8 @@ int fsl_dcu_drm_crtc_create(struct fsl_dcu_drm_device *fsl_dev)
 	if (!primary)
 		return -ENOMEM;
 
-	ret = drm_crtc_init_with_planes(drm, crtc, primary, NULL,
-					&fsl_dcu_drm_crtc_funcs, NULL);
+	ret = drmm_crtc_init_with_planes(drm, crtc, primary, NULL,
+					 &fsl_dcu_drm_crtc_funcs, NULL);
 	if (ret) {
 		primary->funcs->destroy(primary);
 		return ret;
-- 
2.37.3

