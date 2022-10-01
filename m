Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3592E5F1863
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiJABXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiJABWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29CF113C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664587177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FflVPY5URLlO/QnD0oVlID0lCcDMEG9+FRQWDZ3uQVQ=;
        b=VxU5y0OkNRq/bHunntn/G99Fe2V88WVDMYvSgg+bQ8zQYsxOfSgjG+YhrzWpU/WCXPF2kd
        fse1rAuZ69tGnNj5tWYwzLdNXLOB0OUJ7l/MtehNDK8mntTrspdbVTrJnhm41me1JaBJ+s
        Ggt7XVfTAejc6V3tPw+PPlrgYM7QNhs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-81-ZJwmnA6MO3mopCO5aGBlFQ-1; Fri, 30 Sep 2022 21:19:36 -0400
X-MC-Unique: ZJwmnA6MO3mopCO5aGBlFQ-1
Received: by mail-ed1-f70.google.com with SMTP id x5-20020a05640226c500b00451ec193793so4667657edd.16
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FflVPY5URLlO/QnD0oVlID0lCcDMEG9+FRQWDZ3uQVQ=;
        b=WL1xcXJQmiJeTGbxplKBaggA6by2sUi6jwc+fCiensvgphQfrZoO5gjTwB8y7CxOEj
         jWMocl+1NeShT4NUI1NvJq3dA+PI/o5w4HkobkouhSPL6p6XY8pYxADngZ7gIoL8yny6
         oL0un7iPmJWJlSWz2ExAFJiLK71aeLpXInWvY23lnJiPpIhWjswMRimCanOT6pg7Zzwf
         cocqa4tU8iLb1MsDtEJeC34JmaDrL06Eghxb8xmGX+bWDCnicINr+p+6QXkOo4X5Pxn6
         j+Hq8miszhOV9OSSD79ZyvaWfOSKKza3wSocnpP4A2k6CjkaGOMmpgAc00FcrhG3nHtW
         uVoA==
X-Gm-Message-State: ACrzQf1FoSKlOUuWcK9I0JesRYS+tmRzoV//VDiE5T4sheVqVvFaXAFG
        xt40Y80VtMVWDGM0Uf2n2doqeFaNIBmNJNs0htYIUkUZCvvWqQBdObRccK2mIxufYXmOfhakLb5
        X+SEXcnQ3kCbJ74HL0EeGgAzu
X-Received: by 2002:a17:906:7310:b0:782:cfd4:9c07 with SMTP id di16-20020a170906731000b00782cfd49c07mr8553112ejc.708.1664587174774;
        Fri, 30 Sep 2022 18:19:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4x4xTB6S0FGXzv4kk/zNUKjUE/t9WGKOcAeGn0jSeAtcx2ggB6JSwppKVYxMJjyrcRCJ5xeQ==
X-Received: by 2002:a17:906:7310:b0:782:cfd4:9c07 with SMTP id di16-20020a170906731000b00782cfd49c07mr8553105ejc.708.1664587174628;
        Fri, 30 Sep 2022 18:19:34 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b0073c8d4c9f38sm1927167eja.177.2022.09.30.18.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 18:19:34 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 7/7] drm/arm/hdlcd: remove calls to drm_mode_config_cleanup()
Date:   Sat,  1 Oct 2022 03:19:05 +0200
Message-Id: <20221001011905.433408-8-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001011905.433408-1-dakr@redhat.com>
References: <20221001011905.433408-1-dakr@redhat.com>
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

drm_mode_config_init() simply calls drmm_mode_config_init(), hence
cleanup is automatically handled through registering
drm_mode_config_cleanup() with drmm_add_action_or_reset().

While at it, get rid of the deprecated drm_mode_config_init() and
replace it with drmm_mode_config_init() directly.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 020c7d0c70a5..e242b6223d77 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -175,14 +175,21 @@ static const struct drm_mode_config_funcs hdlcd_mode_config_funcs = {
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
-static void hdlcd_setup_mode_config(struct drm_device *drm)
+static int hdlcd_setup_mode_config(struct drm_device *drm)
 {
-	drm_mode_config_init(drm);
+	int ret;
+
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		return ret;
+
 	drm->mode_config.min_width = 0;
 	drm->mode_config.min_height = 0;
 	drm->mode_config.max_width = HDLCD_MAX_XRES;
 	drm->mode_config.max_height = HDLCD_MAX_YRES;
 	drm->mode_config.funcs = &hdlcd_mode_config_funcs;
+
+	return 0;
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -263,7 +270,10 @@ static int hdlcd_drm_bind(struct device *dev)
 
 	dev_set_drvdata(dev, drm);
 
-	hdlcd_setup_mode_config(drm);
+	ret = hdlcd_setup_mode_config(drm);
+	if (ret)
+		goto err_free;
+
 	ret = hdlcd_load(drm, 0);
 	if (ret)
 		goto err_free;
@@ -322,9 +332,7 @@ static int hdlcd_drm_bind(struct device *dev)
 	hdlcd_irq_uninstall(hdlcd);
 	of_reserved_mem_device_release(drm->dev);
 err_free:
-	drm_mode_config_cleanup(drm);
 	dev_set_drvdata(dev, NULL);
-
 	return ret;
 }
 
@@ -345,7 +353,6 @@ static void hdlcd_drm_unbind(struct device *dev)
 	if (pm_runtime_enabled(dev))
 		pm_runtime_disable(dev);
 	of_reserved_mem_device_release(dev);
-	drm_mode_config_cleanup(drm);
 	dev_set_drvdata(dev, NULL);
 }
 
-- 
2.37.3

