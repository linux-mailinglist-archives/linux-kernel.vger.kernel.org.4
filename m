Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B02774504B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjGBTQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjGBTQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B301AB
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 12:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688325351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BtebbbtsycpwEyNSye/8z5gGh26uqgxI4WhcsSrx/V0=;
        b=E8j3CgK+3dldu3/aQbeZfNDGsAfvDYAqm/zmmKN0wLX6hTKf3n7b/U7fAJ8nVVQ9L7TS/+
        +pl4isgcAoQxwObXp+vjfOG+hUzSntCbUBNUMk26o2Hdf0BKvKHxqTTa56aZL/+YLywdjW
        5kJjiiilntrjyKPyDulQep7X/d2WPRY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-az7lY1qUMuSKhyJ0tXx-Kg-1; Sun, 02 Jul 2023 15:15:50 -0400
X-MC-Unique: az7lY1qUMuSKhyJ0tXx-Kg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31286355338so2119643f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 12:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688325349; x=1690917349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtebbbtsycpwEyNSye/8z5gGh26uqgxI4WhcsSrx/V0=;
        b=XtzwCoEFiB72N9wGnS2xgv9boO1hrvVbs5H1S+zvBkqAIppuPqHkrQnGbtGo1fnekD
         DZ0jhI7Wiicsa1KyYxRBbbG6kYraVgAQGNd0MEUa+OP+CP3y79Z1ksblP9fkjjG/vho1
         6q3LTVklj5f6hvWgeYV5PHKstfSfH2dv1iG+hExf1brpjbwNaystPb48w0jWVL/muc0q
         rmHI+/YOUDsP2+f9GdLgy3v90bdr6vWVctO7n1Wn6oyDMXW3Rgjs3BLckxDLhH7CJ2d/
         mq4ZxIPjXiSdyIjI4TidGzIuXlCqFaJZVUFusmRY+ySRGafXAaIwOo+M8wTEEEqdu2pa
         y+/g==
X-Gm-Message-State: ABy/qLaocMzVRCBtTJCXM9jFaNj+3ncwfnmeDiMKS7Ph5d5YqcOLdRJL
        teaySZ5zm0AIN7TISCr8HqQMJtOCNpe0X3wOHabZVLtkM3+AgBhZ5VDx3fjxruREv6iqr0PAO3A
        qKTJDm6V6F+zMqNKbv1of4d+YaFLK/BxH+rGgMgBxdWgLCys7gOU1g6dScET9zogQYRwZwwVchN
        AVZCrQSoI=
X-Received: by 2002:adf:df03:0:b0:314:f88:4fea with SMTP id y3-20020adfdf03000000b003140f884feamr7089533wrl.8.1688325348987;
        Sun, 02 Jul 2023 12:15:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEyklTA8x1D+VHvsQUZVf1gre+qa/Wgc/bQ4CPKiC6Ihq07p7WS1Q0iaaxUngWXac/drZSALQ==
X-Received: by 2002:adf:df03:0:b0:314:f88:4fea with SMTP id y3-20020adfdf03000000b003140f884feamr7089512wrl.8.1688325348614;
        Sun, 02 Jul 2023 12:15:48 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g11-20020a7bc4cb000000b003fbab76165asm14144231wmk.48.2023.07.02.12.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 12:15:48 -0700 (PDT)
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
Subject: [PATCH v3 3/3] drm: Make FB_CORE to be selected if DRM fbdev emulation is enabled
Date:   Sun,  2 Jul 2023 21:15:20 +0200
Message-ID: <20230702191529.768248-4-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230702191529.768248-1-javierm@redhat.com>
References: <20230702191529.768248-1-javierm@redhat.com>
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
index 373f85e174c2..07077708efd8 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -10,6 +10,9 @@ menuconfig DRM
 	tristate "Direct Rendering Manager (DRM) and Kernel Mode Settings (KMS)"
 	depends on (AGP || AGP=n) && !EMULATED_CMPXCHG && HAS_DMA
 	select DRM_PANEL_ORIENTATION_QUIRKS
+	select DRM_KMS_HELPER if DRM_FBDEV_EMULATION
+	select FB_CORE if DRM_FBDEV_EMULATION
+	select FB_SYS_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
 	select HDMI
 	select I2C
 	select DMA_SHARED_BUFFER
@@ -99,7 +102,6 @@ config DRM_KUNIT_TEST
 config DRM_KMS_HELPER
 	tristate
 	depends on DRM
-	select FB_SYS_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
 	help
 	  CRTC helpers for KMS drivers.
 
@@ -135,8 +137,7 @@ config DRM_DEBUG_MODESET_LOCK
 
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

