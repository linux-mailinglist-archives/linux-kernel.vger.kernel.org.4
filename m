Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7863160E4A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiJZPfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbiJZPe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1DF5FCB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666798495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ejOPhJEJNpELka6gD2XD7ypHfsFu2fomcMBYmFfmxuI=;
        b=Gtumf4iXtC4PIGmYTt/hbBvZVllSpKZZx+AQdjTqdO7ySNz2GtFkqbnQAvfoOwYv9D5xWn
        ytYTQB66M+PKJ/lEqQ0vKDRdUxe2WDUy2nVJ6RohUc5pZqDvucKnhYHFUF7Oplrh4nyVZd
        CXt96jbV2Z5nf7gl7PSsrDCotWpUaZw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-s_vnf-pPNICNtQpcXHpzYg-1; Wed, 26 Oct 2022 11:34:53 -0400
X-MC-Unique: s_vnf-pPNICNtQpcXHpzYg-1
Received: by mail-ed1-f72.google.com with SMTP id v18-20020a056402349200b004622e273bbbso3091253edc.14
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejOPhJEJNpELka6gD2XD7ypHfsFu2fomcMBYmFfmxuI=;
        b=TyvaWycLQ5CmCR9td99sfm/bAOHfecYiMHZV/KZnG1XT6xkcLsJ4AzxaUGP01zBdy7
         E42+/TLORrlEAuRgVQDHxklWGh2wxLqz9hIrCqTsjaLrXOaZgiGbJrc/B0bEwZLnYRGi
         w+ZDr8zD+LkIEDNaD9GnyON8NvWpm/9j+7jI1SIVCzxg+GmK0/Ldj41lP5Rte0NASA5U
         SeuHsv2oopMj6W+kEc6XksnrBOFciWKskQgNvfxz6+cKh50i5tmcbLPk4FnS5fl+AAP4
         r9fHofcqzFN0mepfbTFoGbdPA3nQsbBrB63ONe3AVX1+bKBIzYZnBuqP3KH1sq4ZAxai
         8AYw==
X-Gm-Message-State: ACrzQf3OGN7CGvphnr04aQw1Jlahf3Rkdksa3aMR6k9Hbwoeaq6KEgFp
        LiGTa2K4oHyYWxjJHn/oSLXAwSV7u0OpUgTiUw7lh4TB/INqrYOj8pkC4F60opM2adn/BqQE5gF
        3dI4+bZIw3j+ho+CfYFprD+L1
X-Received: by 2002:a17:906:2f87:b0:78a:c0d5:d019 with SMTP id w7-20020a1709062f8700b0078ac0d5d019mr37917828eji.158.1666798492571;
        Wed, 26 Oct 2022 08:34:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5EBkDZr7mSHI/IJXrOR7VYqX6OqCiEF3KuvriT6LLy2miYkg3LlwMcfHJamXcTxJp1LQpWvw==
X-Received: by 2002:a17:906:2f87:b0:78a:c0d5:d019 with SMTP id w7-20020a1709062f8700b0078ac0d5d019mr37917812eji.158.1666798492434;
        Wed, 26 Oct 2022 08:34:52 -0700 (PDT)
Received: from pollux.. ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709063f8c00b0078d4e39d87esm3114855ejj.225.2022.10.26.08.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:34:52 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v4 4/4] drm/arm/hdlcd: remove calls to drm_mode_config_cleanup()
Date:   Wed, 26 Oct 2022 17:34:31 +0200
Message-Id: <20221026153431.72033-5-dakr@redhat.com>
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
index 120c87934a91..49c977cdae40 100644
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
@@ -255,7 +262,10 @@ static int hdlcd_drm_bind(struct device *dev)
 
 	dev_set_drvdata(dev, drm);
 
-	hdlcd_setup_mode_config(drm);
+	ret = hdlcd_setup_mode_config(drm);
+	if (ret)
+		goto err_free;
+
 	ret = hdlcd_load(drm, 0);
 	if (ret)
 		goto err_free;
@@ -314,9 +324,7 @@ static int hdlcd_drm_bind(struct device *dev)
 	hdlcd_irq_uninstall(hdlcd);
 	of_reserved_mem_device_release(drm->dev);
 err_free:
-	drm_mode_config_cleanup(drm);
 	dev_set_drvdata(dev, NULL);
-
 	return ret;
 }
 
@@ -337,7 +345,6 @@ static void hdlcd_drm_unbind(struct device *dev)
 	if (pm_runtime_enabled(dev))
 		pm_runtime_disable(dev);
 	of_reserved_mem_device_release(dev);
-	drm_mode_config_cleanup(drm);
 	dev_set_drvdata(dev, NULL);
 }
 
-- 
2.37.3

