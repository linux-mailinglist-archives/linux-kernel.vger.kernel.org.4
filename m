Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC89745048
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjGBTQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGBTQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6ED100
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 12:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688325344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4kLj8dmTPlNd9hpuLLmsoj1kmn9VFM9AznQMmSVeuFI=;
        b=Rs/DzK4YH0/554twzALjT2p64PL12lDZUgTHiMFjPDhi6B3nQtrNC95DWl8sDKWSIb2IKG
        3k56AFlU4BWkVqnpmA3w7XU5ULF/P0sAyQZOiBfUsDaZ+AGorLzwjsuA8rDtbe0OEW0fzO
        IF9rmNaDn+nAZNx4c/+X1rk/Tw1Gunc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-YgKrx6fCN7iu9X5EJuXWCQ-1; Sun, 02 Jul 2023 15:15:43 -0400
X-MC-Unique: YgKrx6fCN7iu9X5EJuXWCQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fb416d7731so18920145e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 12:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688325342; x=1690917342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kLj8dmTPlNd9hpuLLmsoj1kmn9VFM9AznQMmSVeuFI=;
        b=CKKUxYKSFqgX2Bsz532IdRnFrJwVYskfC6Y/zfJ94HkBu5ZUxkKK7I6xL6UtmqgcVg
         re4d4dJnFSvsDbR9+PdVLnf1qzLYIb2XRRaNCJdf4G7gOaHUm+jhzoDjcPRAkrygCP3e
         ST+tSk3ymQqI7z7K14f5fZdDwz6Oa0EeoG/wADF7oHF+jaCRy3Jnlt3ZrMJCe1rcQSpT
         82LiAVrSh9bC0NFBfE5zHS41XDDS8Zt8G3R8Ujj8oe9vhwMjErpKMCJpIGAItPSUoH9X
         mTJa14M3jy4Tkf2MVd1VOXx0X0Y2r4pwnUrDxgyItLd1k5EefUi5LpyRBjcdV+WDpq0S
         OXRg==
X-Gm-Message-State: AC+VfDy06WwdDa1FX+JeH3nPCaHme3vhVGhzzMw8m8htX2RK6TzJPbis
        TVQ8H0QxQFotTSeStk24lHcw4PJboyLopvwpbWOM6oqb6Gtkhil5P0nWkaVcDQz91tRsvm+PTkN
        No671zIw4JiF+Jj5pQkxoS6XG8DMN74vhUAEKJpgotAwRRH1PdRTL0o8LqO5scPe50n9qbSrpBk
        5MWzD53bs=
X-Received: by 2002:a05:600c:294a:b0:3fa:770c:5918 with SMTP id n10-20020a05600c294a00b003fa770c5918mr5858784wmd.9.1688325342041;
        Sun, 02 Jul 2023 12:15:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zvHRJ6y1/LCj1vDiagN6ACwcdgHIj6l3XviwcGwUovId3cFIYrKqPqTFSB9KPelIQ9jAP7w==
X-Received: by 2002:a05:600c:294a:b0:3fa:770c:5918 with SMTP id n10-20020a05600c294a00b003fa770c5918mr5858748wmd.9.1688325341581;
        Sun, 02 Jul 2023 12:15:41 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g11-20020a7bc4cb000000b003fbab76165asm14144231wmk.48.2023.07.02.12.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 12:15:41 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v3 0/3] Allow disabling all native fbdev drivers and only keeping DRM emulation
Date:   Sun,  2 Jul 2023 21:15:17 +0200
Message-ID: <20230702191529.768248-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series splits the fbdev core support in two different Kconfig
symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
be disabled, while still having the the core fbdev support needed for the
CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
disabling all fbdev drivers instead of having to be disabled individually.

The reason for doing this is that now with simpledrm, there's no need for
the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
now disable them. But it would simplify the config a lot fo have a single
Kconfig symbol to disable all fbdev drivers.

I've built tested with possible combinations of CONFIG_FB, CONFIG_FB_CORE,
CONFIG_DRM_FBDEV_EMULATION and CONFIG_FB_DEVICE symbols set to 'y' or 'n'.

Patch #1 is just a cleanup for the DRM symbol prompt and help texts, patch
DRM symbol to select FB_CORE if CONFIG_DRM_FBDEV_EMULATION was enabled.

This is a v3 of the patch-set that addresses issues pointed out by Arnd
Bergmann, Thomas Zimmermann and Geert Uytterhoeven in the previous v2:

https://lists.freedesktop.org/archives/dri-devel/2023-July/411660.html

Changes in v3:
- Really make a hidden symbol by removing the prompt (Arnd Bergmann).
- Change FB_CORE to config instead of menuconfig (Arnd Bergmann).
- Keep "depends on FB" for FIRMWARE_EDID (Arnd Bergmann).
- Compile out fb_backlight.o and fbmon.o that are only needed for FB
  (Arnd Bergmann).
- Make FB_DEVICE to depend on FB_CORE instead of selecting it.
- Make the DRM symbol to select FB_CORE if DRM_FBDEV_EMULATION is
  enabled (Arnd Bergmann).
- Also make DRM select FB_SYS_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
- Make DRM_FBDEV_EMULATION to depend on DRM instead of DRM_KMS_HELPER.

Changes in v2:
- Keep "depends on FB" for FB_DDC, FB_HECUBA, FB_SVGALIB, FB_MACMODES,
  FB_BACKLIGHT, FB_MODE_HELPERS and FB_TILEBLITTING (Arnd Bergmann).
- Don't change the fb.o object name (Arnd Bergmann).
- Make FB_CORE a non-visible Kconfig symbol instead (Thomas Zimmermann).
- Make CONFIG_DRM_FBDEV_EMULATION to select FB_CORE (Thomas Zimmermann).

Javier Martinez Canillas (3):
  drm: Improve Kconfig symbol prompt and help texts
  fbdev: Split frame buffer support in FB and FB_CORE symbols
  drm: Make FB_CORE to be selected if DRM fbdev emulation is enabled

 arch/x86/Makefile                 |  2 +-
 arch/x86/video/Makefile           |  2 +-
 drivers/gpu/drm/Kconfig           | 29 ++++++++++++----------
 drivers/video/console/Kconfig     |  2 +-
 drivers/video/fbdev/Kconfig       | 40 +++++++++++++++++++------------
 drivers/video/fbdev/core/Makefile |  8 +++----
 6 files changed, 49 insertions(+), 34 deletions(-)

-- 
2.41.0

