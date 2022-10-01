Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891A45F1D18
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJAO7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJAO7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:59:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492CF9F8C8
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664636323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkvjlmHN1GT70TYbeV/tCW9Fb42UM2HGXIPJtWzhOMU=;
        b=CDFtKro91D2ktCeOCqm7wmu97p2qItE7+WWq9JlnR50nnKLqBDJWiElO7yvTsTdAkRqTjJ
        GCVpW7p8jbgreSOB/9QLRWXE3ppD4WuO/wxKVMkZHnaWVA0Eh6SKTPbiOFUGpEYNHXlzO8
        N3Z+vh1l9TZp1Uf8CxqH2djSJ2aopks=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-101-3TBHzHeDPx2Dae5J3MMNxg-1; Sat, 01 Oct 2022 10:58:42 -0400
X-MC-Unique: 3TBHzHeDPx2Dae5J3MMNxg-1
Received: by mail-ed1-f70.google.com with SMTP id m13-20020a056402510d00b004519332f0b1so5587921edd.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 07:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kkvjlmHN1GT70TYbeV/tCW9Fb42UM2HGXIPJtWzhOMU=;
        b=q//p9AusQup3jn2M3dxSj43HnIOMsHneyQ7oRb22O9NkUoN8KOZn320b2iYFBUx3D5
         8l6U9b6a9N1aWqNSgnLhPzY0ZX69Q4weoeCE3oXO+UbDrr47Z0/T+a+0fgspe5mvD+XX
         TWCAbkZwX+6i7Zmmpc6RT5JCUmYI8irB1bHUavjAe3K+mbtXalZOBpvOhpcBo4nZFMml
         RUeNG7x97qYSQXRgDnSPLpUzKPD7YSjOay19GcEBqFbt1+35s6Ui/0LSIXanibJ+dFOL
         4XGs4XoWtvnxgQL3x3Zi3ceBnDrgGfvZpbB6+P/gAyptXf87Bf9BDeFKrFRCb06kfmqO
         PcKw==
X-Gm-Message-State: ACrzQf0uVYo49+K6P32C5V+nq4zVP2IEVwNQJGgknpmPKcWgTMufVy2z
        ZvyGnIXeTHjWdZ1lBVz4j2EqIa00j+wmfqFkPkO+ZT9dQn91rsSfBgzbIXDqvGQeUa3308txd13
        5pfdzYwiIlRDWdFwioNkxU5f8
X-Received: by 2002:a17:906:8461:b0:78a:5e7c:a46b with SMTP id hx1-20020a170906846100b0078a5e7ca46bmr368869ejc.592.1664636320785;
        Sat, 01 Oct 2022 07:58:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6iCEsOFNwU2idahd/mpe75sVMBpercNJiTFFD1VX3LoGxt69klTiFnKH/4LCENoljmciJjXw==
X-Received: by 2002:a17:906:8461:b0:78a:5e7c:a46b with SMTP id hx1-20020a170906846100b0078a5e7ca46bmr368859ejc.592.1664636320624;
        Sat, 01 Oct 2022 07:58:40 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id la15-20020a170907780f00b007812ba2a360sm2868328ejc.149.2022.10.01.07.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 07:58:40 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 9/9] drm/fsl-dcu: remove calls to drm_mode_config_cleanup()
Date:   Sat,  1 Oct 2022 16:58:02 +0200
Message-Id: <20221001145802.515916-10-dakr@redhat.com>
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

drm_mode_config_init() simply calls drmm_mode_config_init(), hence
cleanup is automatically handled through registering
drm_mode_config_cleanup() with drmm_add_action_or_reset().

While at it, get rid of the deprecated drm_mode_config_init() and
replace it with drmm_mode_config_init() directly.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 4 +---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c | 5 +++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 3ac57516c3fe..cb74ae663f25 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -128,10 +128,9 @@ static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
 	}
 
 	return 0;
+
 done_irq:
 	drm_kms_helper_poll_fini(dev);
-
-	drm_mode_config_cleanup(dev);
 done_vblank:
 	return ret;
 }
@@ -141,7 +140,6 @@ static void fsl_dcu_unload(struct drm_device *dev)
 	drm_atomic_helper_shutdown(dev);
 	drm_kms_helper_poll_fini(dev);
 
-	drm_mode_config_cleanup(dev);
 	fsl_dcu_irq_uninstall(dev);
 }
 
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
index c3d55c0aca9f..219ca539dedd 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
@@ -23,7 +23,9 @@ int fsl_dcu_drm_modeset_init(struct fsl_dcu_drm_device *fsl_dev)
 	struct drm_device *drm = &fsl_dev->base;
 	int ret;
 
-	drm_mode_config_init(drm);
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		goto err;
 
 	drm->mode_config.min_width = 0;
 	drm->mode_config.min_height = 0;
@@ -49,6 +51,5 @@ int fsl_dcu_drm_modeset_init(struct fsl_dcu_drm_device *fsl_dev)
 	return 0;
 
 err:
-	drm_mode_config_cleanup(drm);
 	return ret;
 }
-- 
2.37.3

