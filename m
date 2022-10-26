Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF72F60E49A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiJZPev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiJZPeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E5F2628
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666798484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLaZVg/Gn3THIn1ghLrf5MedEqRFiq/AUqXfvtIcrvk=;
        b=A8FJ42TFOP+y1eWeENKbPz5IMfTdr15MYay4H06kIQRerm4e55hy6wtAtGbUsvmofKJjkl
        eSP+axnOo7ye8u6GmKb0GGzFBqFXM/zq5rY6jDhz9soJSWNqoxsPGvN4xT7GONiuR08c3U
        6MmgXUTpyA1/LSqP0YnzDXeWBusl/eo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-658-IY0JA37cPIylFt2f-8E5dg-1; Wed, 26 Oct 2022 11:34:43 -0400
X-MC-Unique: IY0JA37cPIylFt2f-8E5dg-1
Received: by mail-ej1-f69.google.com with SMTP id nc4-20020a1709071c0400b0078a5ceb571bso4734916ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLaZVg/Gn3THIn1ghLrf5MedEqRFiq/AUqXfvtIcrvk=;
        b=x8THGMax7naQROJiiaUM6W8ahVbn+kjc9wCnaAMtAY2YNBNElVKvkj59ZnL3RblroF
         Lal8cj5RSznWL5/2iDVaYfdzfHCmt58D/MlpW9qZqyiLz8DcLfrteNF4fHP/Mud+Pqdr
         2/ygy6au4TTSygcyOY9/S7qmVBKfZ8LYD9+5VhsKxhuN75WxdU8klsC6EYQ2AJg0LMd6
         EKy2yQ7l0p8ojj7LD59LXyZDGpYxRzOJGUEF51jVRIkS8no7q7kprnnPq4c3JT26h5ro
         +hwTR4SZN1ebrsfsLD7U2RyuTMwHdA7VrNAcxjXNh3nL2T/EMEsKgfjfLNVNHd/MO8cS
         zOCA==
X-Gm-Message-State: ACrzQf1Y8SEaxUR8aVsovqIoyHqD559MPkRMIs4kJ8Sf+UmsJjvnTl9X
        txI0kwOJ0ph9jbE4JzVMVhz7UjpcDb50vyxUP8Md1ASUZVL4e4mRL0qmd4xAh17JaC/TAIP501n
        oL9KXdyzApZJf5ET/XgE7R1dV
X-Received: by 2002:a05:6402:27c6:b0:461:e426:dc8b with SMTP id c6-20020a05640227c600b00461e426dc8bmr12855799ede.403.1666798482012;
        Wed, 26 Oct 2022 08:34:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7dYi2tzVQq42OFzB50D9ddEtWodBh0BQMxyElzqyZXWM3GFmgLvhs6sr8aj83t2ilqgGbccA==
X-Received: by 2002:a05:6402:27c6:b0:461:e426:dc8b with SMTP id c6-20020a05640227c600b00461e426dc8bmr12855779ede.403.1666798481834;
        Wed, 26 Oct 2022 08:34:41 -0700 (PDT)
Received: from pollux.. ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906271100b0078a543e9301sm3048896ejc.200.2022.10.26.08.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:34:41 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v4 1/4] drm/arm/hdlcd: use drmm_* to allocate driver structures
Date:   Wed, 26 Oct 2022 17:34:28 +0200
Message-Id: <20221026153431.72033-2-dakr@redhat.com>
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

