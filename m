Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566D87430C0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjF2Wwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjF2WwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004912D66
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688079085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h2j2ItE1hrzXRdyDj1d7Zvc9rzISUnAdMoZSXdbcCVc=;
        b=Ixkx0xVaopsJM6EZAoYpHtD20832k1NNYwsk/l6rWHECyu8GM2GHqFKRQ9PKizA3j1WeWR
        Ze6LXgWVIM9D3vXYhHo7ni1C7jwVOzMP3dipsOx16XwgPRd7sjR1jL0bCtkX+ZSaCi95ik
        D8s0RwWH8xLYbeszqvyJSpSbgBsTNrE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-wzG1ImCNNzSzim01CwCSkA-1; Thu, 29 Jun 2023 18:51:23 -0400
X-MC-Unique: wzG1ImCNNzSzim01CwCSkA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-313f5021d9bso597565f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688079082; x=1690671082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2j2ItE1hrzXRdyDj1d7Zvc9rzISUnAdMoZSXdbcCVc=;
        b=GjXQ/W68eeafXmQVHUY1QCT0cv9e9OzHoEqM2nQzI5Iv90opZnDA6xPIOLOJ5XeY0L
         r1kYnLmBkWwRzvwxKBkLiaTz+dt4kWIVOsj1blUfwmhupNVNZiYKOIsOhQ65nS5GMJu2
         5yK+dbiQhVMRV5oT+x/H9lrNT00bN/kEV28RvW0i7CwMGOYIuNGdVfcY5K2yB2uZUvYp
         z7q6x6Vi0MmMatH0ZO9bSOnSObM/NjW1T72PaPrnORPEq/YseyHMBblDpMn43+cc9u3J
         cfuZFEvU/rlpIbq7uREvIThwXzo7p/qy0P5+v5MeLWVKv5xT+56sOpqIyIHVda4nlaip
         eQuQ==
X-Gm-Message-State: ABy/qLY41pPz8+BKNjdGM+0z0PRAYw2EDqx0PGkCtCb/oYNcREmPtaNK
        XslsMwf1NL4TfwWNOterBA9tUjXmr/ZamZAFosBlNSK+8q4/NwBekymBcTSR2cJmSn4dqWrlyN2
        2uNsRFBpT+lGWnf31/98esyX/4pAdpb1V8X/WyKQR4I7YxrC8BJFKA4Uhvm2NWltwyXL6uZxrtt
        +49h1xc5Q=
X-Received: by 2002:adf:e5c4:0:b0:313:f59f:986d with SMTP id a4-20020adfe5c4000000b00313f59f986dmr442369wrn.65.1688079082198;
        Thu, 29 Jun 2023 15:51:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHd4GmNb5anZfo6xpKRMdPTwJkkfzyxrFg+R0KEc4n5GMsAHWEd5iM2tVUcAeQlbNqHWI4p8Q==
X-Received: by 2002:adf:e5c4:0:b0:313:f59f:986d with SMTP id a4-20020adfe5c4000000b00313f59f986dmr442352wrn.65.1688079081824;
        Thu, 29 Jun 2023 15:51:21 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i6-20020adff306000000b00311339f5b06sm16795690wro.57.2023.06.29.15.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 15:51:21 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm: Make fbdev emulation depend on FB_CORE instead of FB
Date:   Fri, 30 Jun 2023 00:51:04 +0200
Message-ID: <20230629225113.297512-3-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629225113.297512-1-javierm@redhat.com>
References: <20230629225113.297512-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the fbdev core has been split in FB_CORE and FB, make DRM fbdev
emulation layer to just depend on the former.

This allows to disable the CONFIG_FB option if is not needed, which will
avoid the need to explicitly disable each of the legacy fbdev drivers.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index afb3b2f5f425..6ecb984d213a 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -132,7 +132,7 @@ config DRM_DEBUG_MODESET_LOCK
 config DRM_FBDEV_EMULATION
 	bool "Enable legacy fbdev support for your modesetting driver"
 	depends on DRM_KMS_HELPER
-	depends on FB=y || FB=DRM_KMS_HELPER
+	depends on FB_CORE=y || FB=DRM_KMS_HELPER
 	select FRAMEBUFFER_CONSOLE if !EXPERT
 	select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
 	default y
-- 
2.41.0

