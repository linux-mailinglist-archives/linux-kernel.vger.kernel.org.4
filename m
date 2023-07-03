Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9555A74660E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 01:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGCXHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 19:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjGCXHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 19:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60218E76
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 16:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688425551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lkg59yW6N3qp9OWXgPkPBl5HF5mAhGC8YRJ6AIKa7QU=;
        b=ecWbLF3Y1nXYYD95+nB8VZs1cEkAo2wQvByH9UVvyDH2P0lx2gdjFCzRIrZYBzIVddv8/s
        6Y1yS2PCV0PgyPag0oF41cF211eZSeikaavvG8eHwE2QGSKNr6z4Dh+wNwGRSiK/iF27Mq
        t8RrL/4TkMqKrvTRsz07hIjFBT+nkZk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-7JubERteNlig4l4Ee6XqLg-1; Mon, 03 Jul 2023 19:05:50 -0400
X-MC-Unique: 7JubERteNlig4l4Ee6XqLg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f81dda24d3so57239165e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 16:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688425549; x=1691017549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lkg59yW6N3qp9OWXgPkPBl5HF5mAhGC8YRJ6AIKa7QU=;
        b=dKDc9MsJ2Av8lGkEDKyQaJWfIBv6q0W2wew/MlBnSkTpqc7dcFDN95hCr0mlBiOmyq
         3zTE8kQ5YlnLMFKyhiTZZEKynWzGOvpx257KZjFvD/RB2rGiCQq29ibpR7KXCTbI/Frv
         bPaMuLBLXaMy8N6TwlhXEPtzKe2gi8t6FlP9Jptw06GfdgKz2DEvcNKAEpSHBRPFhVts
         KF5plpIGF1mTbaJQKIAKKoONsHa86XsMmIoY03n6id5hL4oSkCpzNGiGXmUwrn9/PXYd
         aDJgxunk59TGgoIFE6cwyI6bZFnMUeZlhyZre7NlLBT8QMY8j1QTLIJhfDZm7F94WvlR
         p31w==
X-Gm-Message-State: ABy/qLbPYVoY5jFFM/f3VofFdCX6YIXj3+9/17M8em+t+kJecmsJqNpu
        fluai3qORm5KBihdPAJFA4TrxByyxAb/5y3HUajvFBHaMWS0ihJ9gGrI8jp/jWtLNHK9H/7zJqv
        TyoQkQfJh32x7dy9bB0uNKS76ZwlFKxp8uL2eG15epEGO+BLav87+QS6V6Gn/XLSlxgy0dXhhP0
        aAOWMMGpw=
X-Received: by 2002:a7b:c3c1:0:b0:3fb:c77e:80f6 with SMTP id t1-20020a7bc3c1000000b003fbc77e80f6mr14175975wmj.36.1688425549111;
        Mon, 03 Jul 2023 16:05:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFH9VDFE2aV2/hIaFGZ0GQV1akJl6P61RNQPug3Y8zK/CzFjL40FrXKgHbC+BraT1RvK21S8Q==
X-Received: by 2002:a7b:c3c1:0:b0:3fb:c77e:80f6 with SMTP id t1-20020a7bc3c1000000b003fbc77e80f6mr14175942wmj.36.1688425548710;
        Mon, 03 Jul 2023 16:05:48 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id cw13-20020a056000090d00b003112f836d4esm26504465wrb.85.2023.07.03.16.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 16:05:47 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 5/5] drm: Make FB_CORE to be selected if DRM fbdev emulation is enabled
Date:   Tue,  4 Jul 2023 01:05:29 +0200
Message-ID: <20230703230534.997525-6-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703230534.997525-1-javierm@redhat.com>
References: <20230703230534.997525-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that fbdev core has been split in FB_CORE and FB, make the DRM symbol
to select the FB_CORE option if the DRM fbdev emulation layer is enabled.

This allows to disable the CONFIG_FB option if is not needed, which will
avoid the need to explicitly disable each of the legacy fbdev drivers.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v3)

Changes in v3:
- Make the DRM symbol to select FB_CORE if DRM_FBDEV_EMULATION is
  enabled (Arnd Bergmann).
- Also make DRM select FB_SYS_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
- Make DRM_FBDEV_EMULATION to depend on DRM instead of DRM_KMS_HELPER.

Changes in v2:
- Make CONFIG_DRM_FBDEV_EMULATION to select FB_CORE (Thomas Zimmermann).

 drivers/gpu/drm/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index afb3b2f5f425..775564558152 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -9,6 +9,9 @@ menuconfig DRM
 	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
 	depends on (AGP || AGP=n) && !EMULATED_CMPXCHG && HAS_DMA
 	select DRM_PANEL_ORIENTATION_QUIRKS
+	select DRM_KMS_HELPER if DRM_FBDEV_EMULATION
+	select FB_CORE if DRM_FBDEV_EMULATION
+	select FB_SYS_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
 	select HDMI
 	select I2C
 	select DMA_SHARED_BUFFER
@@ -95,7 +98,6 @@ config DRM_KUNIT_TEST
 config DRM_KMS_HELPER
 	tristate
 	depends on DRM
-	select FB_SYS_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
 	help
 	  CRTC helpers for KMS drivers.
 
@@ -131,8 +133,7 @@ config DRM_DEBUG_MODESET_LOCK
 
 config DRM_FBDEV_EMULATION
 	bool "Enable legacy fbdev support for your modesetting driver"
-	depends on DRM_KMS_HELPER
-	depends on FB=y || FB=DRM_KMS_HELPER
+	depends on DRM
 	select FRAMEBUFFER_CONSOLE if !EXPERT
 	select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
 	default y
-- 
2.41.0

