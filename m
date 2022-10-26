Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E8F60E51D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiJZQAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbiJZQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960BF025
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666799989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TF2idh4cfIfrFOF9EVS0R3ai/ZWpJhhFk/BXprIYCn4=;
        b=QYUUfs88OFE9U/EbEOpE0bBY6UgdrL3JutiAmiFTEbfaorjBJN/YzYynPBYLhC6rn3tvIk
        0dw9dkwRSJYoZ/GMH1EdFY7mS4tv10wUKMD3+0muI1hbilG6IoL39T7JE1ZhOv7eBzytR8
        /0NYoTjc8qCnnsnAwNrp6oW1V+aJv5Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-52-KFPqdEdDOKS2NnKWye_PeQ-1; Wed, 26 Oct 2022 11:59:45 -0400
X-MC-Unique: KFPqdEdDOKS2NnKWye_PeQ-1
Received: by mail-ed1-f69.google.com with SMTP id m7-20020a056402430700b0045daff6ee5dso14245434edc.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TF2idh4cfIfrFOF9EVS0R3ai/ZWpJhhFk/BXprIYCn4=;
        b=QGhy6XT28ZLIgxXYM86LclKqyWuZtoHRxEAOQQZrufZAZ1c92zzWG1BJgBrScheziD
         3kpIhR6mRp+YONRtewoVn19/vyUWi+aPF9UA0LJluUVey4FZM7ElIhIAP+xMY7DIM9FB
         3hbwBLr6Z/QxmmaD4YVXz10WJoJ7wtVWDzkoDAoQZSu6T4fbP36hiPjjaA2dY7PVUora
         B5WjzaZAqNQufypQhAXWVTGxDMZQ5usrD4+e1n19OthlKWQHsW9ZFFrxkCLDP9Ur6g/9
         wdWjRtCXR5KJlu6S6+kh5O1rvARg4UJ3hE835Dp5xfVE8TV/nccj5+PiVLU4ojwswKKI
         9SJQ==
X-Gm-Message-State: ACrzQf0lB5c4o1GUtlJQyjNbFlepMhqM+uf3kFNLDrk5FPbxl7+tpWaU
        7iZb+1YF8NpbxZpFHcaYZmGrYRhTTyoG1gMwBtLXLLq/4aGWN2el7g6fc9LYInYLkx13UXINQa2
        Q96CbsTSlLmZ/2v9l7Bje4Qzv
X-Received: by 2002:a17:907:96a0:b0:78d:dd45:a6d4 with SMTP id hd32-20020a17090796a000b0078ddd45a6d4mr38610050ejc.643.1666799984313;
        Wed, 26 Oct 2022 08:59:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ii8CCAKar6QQOlbxy2yn47jUIqPXJUP1rbe5ZDO3WgicXHPJpDAiPJobAr6N1Rie8IEkLUw==
X-Received: by 2002:a17:907:96a0:b0:78d:dd45:a6d4 with SMTP id hd32-20020a17090796a000b0078ddd45a6d4mr38610038ejc.643.1666799984183;
        Wed, 26 Oct 2022 08:59:44 -0700 (PDT)
Received: from pollux.. ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id a29-20020a509b5d000000b00461c1804cdasm3876740edj.3.2022.10.26.08.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:59:43 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 1/5] drm/arm/malidp: use drmm_* to allocate driver structures
Date:   Wed, 26 Oct 2022 17:59:30 +0200
Message-Id: <20221026155934.125294-2-dakr@redhat.com>
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

Use drm managed resources to allocate driver structures and get rid of
the deprecated drm_dev_alloc() call and replace it with
devm_drm_dev_alloc().

This also serves as preparation to get rid of drm_device->dev_private
and to fix use-after-free issues on driver unload.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 20 +++++++-------------
 drivers/gpu/drm/arm/malidp_drv.h |  1 +
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 1d0b0c54ccc7..41c80e905991 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -23,6 +23,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_module.h>
 #include <drm/drm_of.h>
@@ -716,11 +717,13 @@ static int malidp_bind(struct device *dev)
 	int ret = 0, i;
 	u32 version, out_depth = 0;
 
-	malidp = devm_kzalloc(dev, sizeof(*malidp), GFP_KERNEL);
-	if (!malidp)
-		return -ENOMEM;
+	malidp = devm_drm_dev_alloc(dev, &malidp_driver, typeof(*malidp), base);
+	if (IS_ERR(malidp))
+		return PTR_ERR(malidp);
+
+	drm = &malidp->base;
 
-	hwdev = devm_kzalloc(dev, sizeof(*hwdev), GFP_KERNEL);
+	hwdev = drmm_kzalloc(drm, sizeof(*hwdev), GFP_KERNEL);
 	if (!hwdev)
 		return -ENOMEM;
 
@@ -753,12 +756,6 @@ static int malidp_bind(struct device *dev)
 	if (ret && ret != -ENODEV)
 		return ret;
 
-	drm = drm_dev_alloc(&malidp_driver, dev);
-	if (IS_ERR(drm)) {
-		ret = PTR_ERR(drm);
-		goto alloc_fail;
-	}
-
 	drm->dev_private = malidp;
 	dev_set_drvdata(dev, drm);
 
@@ -887,8 +884,6 @@ static int malidp_bind(struct device *dev)
 		malidp_runtime_pm_suspend(dev);
 	drm->dev_private = NULL;
 	dev_set_drvdata(dev, NULL);
-	drm_dev_put(drm);
-alloc_fail:
 	of_reserved_mem_device_release(dev);
 
 	return ret;
@@ -917,7 +912,6 @@ static void malidp_unbind(struct device *dev)
 		malidp_runtime_pm_suspend(dev);
 	drm->dev_private = NULL;
 	dev_set_drvdata(dev, NULL);
-	drm_dev_put(drm);
 	of_reserved_mem_device_release(dev);
 }
 
diff --git a/drivers/gpu/drm/arm/malidp_drv.h b/drivers/gpu/drm/arm/malidp_drv.h
index cdfddfabf2d1..00be369b28f1 100644
--- a/drivers/gpu/drm/arm/malidp_drv.h
+++ b/drivers/gpu/drm/arm/malidp_drv.h
@@ -29,6 +29,7 @@ struct malidp_error_stats {
 };
 
 struct malidp_drm {
+	struct drm_device base;
 	struct malidp_hw_device *dev;
 	struct drm_crtc crtc;
 	struct drm_writeback_connector mw_connector;
-- 
2.37.3

