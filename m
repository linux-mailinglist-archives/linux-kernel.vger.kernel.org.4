Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A5D5F1DCA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJAQlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiJAQkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FCE386A1
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664642425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abXRF2x6PmkkxgNipX/KKomtwvHsLuue5IHJHi8dXLg=;
        b=FYuv0wu0icqQjGTwGWp2im17b0qaQuBHfQ7EmfJD7iCS0BLMePAWLvL7/HxVRKpTatF4g9
        U9+E4hr2haGHIKD2UG3Tu9JHonjgMMmQDaevhn8o0V8a2B1ryxKlbrGwRmGQkVn1C9RVOD
        7EH1GsMF6uqo+BJ9dEA14ZASiZC5rGk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-cDf9RxTCOtOUMI-gjmwxvw-1; Sat, 01 Oct 2022 12:40:24 -0400
X-MC-Unique: cDf9RxTCOtOUMI-gjmwxvw-1
Received: by mail-ed1-f70.google.com with SMTP id b17-20020a056402351100b00453b19d9bd0so5687057edd.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 09:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=abXRF2x6PmkkxgNipX/KKomtwvHsLuue5IHJHi8dXLg=;
        b=MSLqd1O5YZoWn0dibPWx6XMbzAVgqeIuDu3pss2HIv6Keh0Jomh9qkW3+3m+4N1uC3
         lsXvyEiOUNwGKsqwoRtofY8EKcyoNZPCNcqiFH6TJeQfzFE/JjqiBQHt5xGbO2pwfMG5
         wwpPbpnsCIUKG7KiY3yA1b0b7gaxh5b0qiB5R46DPL0eLyq3me7aT3SsH67paIleEHKI
         AZtSDqcMwVsqkXsiMwosqQP3wmrwBv8QfbwkJPSPIN6h3sZcXyC4SFVv9yX7h2o+VAgG
         y33eg1dcALYu323Fn7EEUFgid+jz3PsCTVi6xSV8cv8D4LTqDQ/67d61G0hrwqXzXjaV
         iVoA==
X-Gm-Message-State: ACrzQf1l1ANbcIYbxpOMR5aoU0cfm2g5+IyukWGeQhGSXjsM6pLEhTUI
        ypMR/YfNCG5xzUHYPG4TTd3bfHaWfW9IF8OiZuN1YU7c8vZ41EdMFT6mfwSHGqll/SncOWX3LA+
        aO9P8vHE5wsvn3Y2of04wSG4t
X-Received: by 2002:aa7:c3d7:0:b0:457:e335:20a9 with SMTP id l23-20020aa7c3d7000000b00457e33520a9mr12146835edr.423.1664642422843;
        Sat, 01 Oct 2022 09:40:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5c2q88b9WNyAEwkZN6tMyNNztnVJ4pVe2/TWskbOVxN+6Ua71UqSEuXJApBRk2W+5Mjn8+xw==
X-Received: by 2002:aa7:c3d7:0:b0:457:e335:20a9 with SMTP id l23-20020aa7c3d7000000b00457e33520a9mr12146827edr.423.1664642422703;
        Sat, 01 Oct 2022 09:40:22 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id rp9-20020a170906d96900b0077fb63da010sm2907882ejb.114.2022.10.01.09.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 09:40:22 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 9/9] drm/arm/malidp: remove calls to drm_mode_config_cleanup()
Date:   Sat,  1 Oct 2022 18:39:46 +0200
Message-Id: <20221001163946.534067-10-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001163946.534067-1-dakr@redhat.com>
References: <20221001163946.534067-1-dakr@redhat.com>
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

drm_mode_config_init() simply calls drmm_mode_config_init(), hence
cleanup is automatically handled through registering
drm_mode_config_cleanup() with drmm_add_action_or_reset().

While at it, get rid of the deprecated drm_mode_config_init() and
replace it with drmm_mode_config_init() directly.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 8bb8e8d14461..ef6a9fc1c864 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -401,7 +401,9 @@ static int malidp_init(struct drm_device *drm)
 	struct malidp_drm *malidp = drm_to_malidp(drm);
 	struct malidp_hw_device *hwdev = malidp->dev;
 
-	drm_mode_config_init(drm);
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		goto out;
 
 	drm->mode_config.min_width = hwdev->min_line_size;
 	drm->mode_config.min_height = hwdev->min_line_size;
@@ -412,24 +414,16 @@ static int malidp_init(struct drm_device *drm)
 
 	ret = malidp_crtc_init(drm);
 	if (ret)
-		goto crtc_fail;
+		goto out;
 
 	ret = malidp_mw_connector_init(drm);
 	if (ret)
-		goto crtc_fail;
-
-	return 0;
+		goto out;
 
-crtc_fail:
-	drm_mode_config_cleanup(drm);
+out:
 	return ret;
 }
 
-static void malidp_fini(struct drm_device *drm)
-{
-	drm_mode_config_cleanup(drm);
-}
-
 static int malidp_irq_init(struct platform_device *pdev)
 {
 	int irq_de, irq_se, ret = 0;
@@ -879,7 +873,6 @@ static int malidp_bind(struct device *dev)
 bind_fail:
 	of_node_put(malidp->crtc.port);
 	malidp->crtc.port = NULL;
-	malidp_fini(drm);
 query_hw_fail:
 	pm_runtime_put(dev);
 	if (pm_runtime_enabled(dev))
@@ -907,7 +900,6 @@ static void malidp_unbind(struct device *dev)
 	component_unbind_all(dev, drm);
 	of_node_put(malidp->crtc.port);
 	malidp->crtc.port = NULL;
-	malidp_fini(drm);
 	pm_runtime_put(dev);
 	if (pm_runtime_enabled(dev))
 		pm_runtime_disable(dev);
-- 
2.37.3

