Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D8B5F185C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiJABWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiJABVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B21F19624B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664587157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLaZVg/Gn3THIn1ghLrf5MedEqRFiq/AUqXfvtIcrvk=;
        b=TluYmOiChs4IoH9AM+n+In++qRO0U/eXVS4LaErL+AbFBH+BnhSbSuKCZk/Zf3BLiZt1I6
        OdfQDWCF9hFJ68s0o2hakl97p+gVtXfJJGY/z19o2wOImhvGlQvP76K169RfzGLpuNLGv9
        TplEKEoU0RJhmscCcbgHI7PynJiUlMU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-48-ZhG7oWhAMMS5EYoNHWQg8Q-1; Fri, 30 Sep 2022 21:19:13 -0400
X-MC-Unique: ZhG7oWhAMMS5EYoNHWQg8Q-1
Received: by mail-ed1-f72.google.com with SMTP id z2-20020a056402274200b004516734e755so4645719edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fLaZVg/Gn3THIn1ghLrf5MedEqRFiq/AUqXfvtIcrvk=;
        b=zaOa1th0rLeLJ9L47ACEuMSFU5qJ2FiTcS3dU6mwgj9TfOEDZglzEZ5kp9/3LfshP1
         09ERTSsNVFi313Nlm67jX0okk4A9OGVSi3745KqjID8zPXHwJW3/Qpk0GRx5GTjDWP7b
         z2Ey25J7FnZit/7Ce8LVkzhCCR+67ALNxV4n/NY+/KrgvBFkzg/4hPl/764UoWp8//Dl
         RDv/asEx4DWQyDhUT+3Sm02qOZVn56wJcR9iHCsj8/v6xhCQuk2cTZGibxNx8UR1vD5E
         xdT6G1w/JJvShxM7lYMu6Qo0TpEfB7gL6BTPnz2TO9ASurWy/5orFaV9h2XCEt6+JtuS
         Qmmg==
X-Gm-Message-State: ACrzQf1s0zpQyECWocRs/GYnxSuEU1oi8yDZ6oKbbqMM+maCWRGyZye2
        5IYUf+i2YJjdTA/eft6cj5ldSb7yTWYmi/5/BY8qwCgRaHyL+fSC1s/nae5lMeXoVPmk1uTztLr
        ss2j/6UyU7f1NVivujBgSByMJ
X-Received: by 2002:a17:907:8a23:b0:782:6a5:6dd5 with SMTP id sc35-20020a1709078a2300b0078206a56dd5mr7966640ejc.581.1664587152865;
        Fri, 30 Sep 2022 18:19:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM78eXx11AzAz/KYCu4ClVlwjL9PudeR4cdFQOhob9od/+BuIzr8TrZGeicdldxZ/IHZxleCMg==
X-Received: by 2002:a17:907:8a23:b0:782:6a5:6dd5 with SMTP id sc35-20020a1709078a2300b0078206a56dd5mr7966632ejc.581.1664587152705;
        Fri, 30 Sep 2022 18:19:12 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b007822196378asm1934302eja.176.2022.09.30.18.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 18:19:12 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 1/7] drm/arm/hdlcd: use drmm_* to allocate driver structures
Date:   Sat,  1 Oct 2022 03:18:59 +0200
Message-Id: <20221001011905.433408-2-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001011905.433408-1-dakr@redhat.com>
References: <20221001011905.433408-1-dakr@redhat.com>
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

Use drm managed resources to allocate driver structures and get rid of
the deprecated drm_dev_alloc() call and replace it with
devm_drm_dev_alloc().

This also serves as preparation to get rid of drm_device->dev_private
and to fix use-after-free issues on driver unload.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 12 ++++--------
 drivers/gpu/drm/arm/hdlcd_drv.h |  1 +
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index a032003c340c..463381d11cff 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -247,13 +247,11 @@ static int hdlcd_drm_bind(struct device *dev)
 	struct hdlcd_drm_private *hdlcd;
 	int ret;
 
-	hdlcd = devm_kzalloc(dev, sizeof(*hdlcd), GFP_KERNEL);
-	if (!hdlcd)
-		return -ENOMEM;
+	hdlcd = devm_drm_dev_alloc(dev, &hdlcd_driver, typeof(*hdlcd), base);
+	if (IS_ERR(hdlcd))
+		return PTR_ERR(hdlcd);
 
-	drm = drm_dev_alloc(&hdlcd_driver, dev);
-	if (IS_ERR(drm))
-		return PTR_ERR(drm);
+	drm = &hdlcd->base;
 
 	drm->dev_private = hdlcd;
 	dev_set_drvdata(dev, drm);
@@ -319,7 +317,6 @@ static int hdlcd_drm_bind(struct device *dev)
 err_free:
 	drm_mode_config_cleanup(drm);
 	dev_set_drvdata(dev, NULL);
-	drm_dev_put(drm);
 
 	return ret;
 }
@@ -344,7 +341,6 @@ static void hdlcd_drm_unbind(struct device *dev)
 	drm_mode_config_cleanup(drm);
 	drm->dev_private = NULL;
 	dev_set_drvdata(dev, NULL);
-	drm_dev_put(drm);
 }
 
 static const struct component_master_ops hdlcd_master_ops = {
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.h b/drivers/gpu/drm/arm/hdlcd_drv.h
index 909c39c28487..3892b36767ac 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.h
+++ b/drivers/gpu/drm/arm/hdlcd_drv.h
@@ -7,6 +7,7 @@
 #define __HDLCD_DRV_H__
 
 struct hdlcd_drm_private {
+	struct drm_device		base;
 	void __iomem			*mmio;
 	struct clk			*clk;
 	struct drm_crtc			crtc;
-- 
2.37.3

