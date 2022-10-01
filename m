Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10065F1DB5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJAQkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJAQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1056F22BEE
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664642395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TF2idh4cfIfrFOF9EVS0R3ai/ZWpJhhFk/BXprIYCn4=;
        b=aro/Xyfz8vBLbISXXh6t9Qp5NJQiTpmYtsEXzVZfKvJa7bHAYFGrpqyP4Wg1qCFxTy7R8j
        JTSgw25rFBBKLVnWiuRlvq4Ijl35W9yS83u8ZUihH7BB5trrHUxh6LyhgYnp7GmLCjY4nu
        sRdv1UyHe6DTQ/HETZlDFi+u5SZjZd4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-157-XGEoWS_HOGmUg73vbP35YA-1; Sat, 01 Oct 2022 12:39:54 -0400
X-MC-Unique: XGEoWS_HOGmUg73vbP35YA-1
Received: by mail-ed1-f71.google.com with SMTP id v11-20020a056402348b00b004516e0b7eedso5743563edc.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 09:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TF2idh4cfIfrFOF9EVS0R3ai/ZWpJhhFk/BXprIYCn4=;
        b=srhDU42aYd7g64QxwFvLTSUkS/cEJNaMxlTVIX4yLV3vj6IWmGqySUW1z/hoOoxjgr
         SmgCNCVK+j/cs/kOV6z2fPCqUpwu41hQgy52yKuL+2iWWNec5QpYQyO72+dP6M8a0WMb
         qBLEiYZVp+V4J1REaSAJiFSOtpSoiFTNlszCJoc2gu05X3qS5VCao7J2PCgiWZfLhYkX
         cDR0fLah6LoWuu//2nfzYk9Rxro/+CPZ6nTG0NGyKaZiBF9Yk3KHY1/xPjvxm0xKNX/r
         7mcMdhUZn8BmaG76w2fKemQkIyK/Qrx/Try5vkXf8qsBoi+9JH9h0mFFrmz2okLreQHq
         M+UQ==
X-Gm-Message-State: ACrzQf2DWmuzZ8LBXKYaL3ofm4Kxf0W0TQiBL9Jw6KcIkIovHv6RNfcJ
        TjLIdxjpR8X01ipyJZuInhTL8O5Hx6LdR3UJl0/kOIzZJYTDRp37nOi9mdtZHQFhEAOkrgr+xtq
        Tpao21g2qgIFHb5lLQrcwsegu
X-Received: by 2002:a17:907:7f13:b0:782:9f6f:edbc with SMTP id qf19-20020a1709077f1300b007829f6fedbcmr10285484ejc.544.1664642393319;
        Sat, 01 Oct 2022 09:39:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4YiWo0W/l5+cQbA+w/X6w8Td19k+zzcWJMDh5uRvB8+XjnLfEvERBP2DIzt/cps2Y5Dr7exw==
X-Received: by 2002:a17:907:7f13:b0:782:9f6f:edbc with SMTP id qf19-20020a1709077f1300b007829f6fedbcmr10285478ejc.544.1664642393151;
        Sat, 01 Oct 2022 09:39:53 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id f18-20020a05640214d200b004588ef795easm2841896edx.34.2022.10.01.09.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 09:39:52 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 1/9] drm/arm/malidp: use drmm_* to allocate driver structures
Date:   Sat,  1 Oct 2022 18:39:38 +0200
Message-Id: <20221001163946.534067-2-dakr@redhat.com>
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

