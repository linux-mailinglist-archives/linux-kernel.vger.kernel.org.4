Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC365B7CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIMWPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIMWPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFECD13F80
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663107306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLaZVg/Gn3THIn1ghLrf5MedEqRFiq/AUqXfvtIcrvk=;
        b=LYcsX+jcn6+LNHbKGpTe3gia265m0UcG3TSI5NCXqI7yF6cTuuzy0ep0v8FDR/NemRmRs7
        RuEoH84mPW/QumRUpM8WooyU6Uv0UwrDoZXyYZUfthVGIQqFyZTK2ZacRIxn5KV/XXPy0N
        7gpshf2TSldDDp1+7927mqxNejLHQkM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-219-2dISxnWVNquHq3ZnY7Efpw-1; Tue, 13 Sep 2022 18:15:04 -0400
X-MC-Unique: 2dISxnWVNquHq3ZnY7Efpw-1
Received: by mail-ed1-f69.google.com with SMTP id f18-20020a056402355200b0045115517911so9083971edd.14
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fLaZVg/Gn3THIn1ghLrf5MedEqRFiq/AUqXfvtIcrvk=;
        b=YARwYKL/wsFo6MdQh4P2DWDwiypOSc2y3k3+5o2q4NqWj9ZydbUS7M1n51ZfakFznc
         LMOAtbpqVKyTZKLBIrp87/ZXRcTMUAmldpnNCelcjykOTyLaxEKbt19+mGoFPjwmFDrp
         rgNE34uoK//WUA2UlYNICk7RCTmPJkQcU8ddncfTFd8UT8qHBFzn0RVTTvaMuymdp7EG
         r3TzE+GN31XQcaiRJxjo2mnNRBWx/QSCxuKu5Gx7TUe/PdSOSaN9HcqGkb2qrJh5r1le
         VP08cQx7CG721uHepU/4JBBrHmttp/VTiKnEjs7jNTULSwazx78pWb+qkcfOoH9ytOqX
         cUiQ==
X-Gm-Message-State: ACgBeo36pfxBtvXi06zWaP5lgyws/rnHuZLZhCM750wbUohh35spsZAH
        g5kpUxtmOZGBGFFutYOW89A+W/3yMZdhrMyNF5TFjFb/+3qrnmrAMGBdENT8yy507mUHgqBwe/S
        bgYaJ0S1/YqXKBUVWrmzmz797
X-Received: by 2002:a17:907:e9e:b0:77f:9688:2714 with SMTP id ho30-20020a1709070e9e00b0077f96882714mr5606878ejc.208.1663107303648;
        Tue, 13 Sep 2022 15:15:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6CWbWIsmU+jbsRrkPOx16ZPv+euqGiqID/bCT9pQvDeXNytvGsUpuMTtiOi0r9m4i33dXEqQ==
X-Received: by 2002:a17:907:e9e:b0:77f:9688:2714 with SMTP id ho30-20020a1709070e9e00b0077f96882714mr5606872ejc.208.1663107303439;
        Tue, 13 Sep 2022 15:15:03 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906539600b0076fa6d9d891sm6609451ejo.46.2022.09.13.15.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 15:15:03 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 1/6] drm/arm/hdlcd: use drmm_* to allocate driver structures
Date:   Wed, 14 Sep 2022 00:14:51 +0200
Message-Id: <20220913221456.147937-2-dakr@redhat.com>
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

