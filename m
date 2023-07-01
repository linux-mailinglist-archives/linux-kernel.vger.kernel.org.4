Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05C3744B2F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 23:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjGAVqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 17:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGAVqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 17:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FE7170A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688247915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ixfgD95cECm9IJRwnBAQBSBQpbSMzbZAJ/z6SVP266o=;
        b=E+cz8KTbCGpapu9tEo/WukvIQE2GBX26mgR/tZ26wgi8lFLTeiM2oV+OUoXz/+hEOFBaMv
        83Q7a0xIgOWwMexnX9EUWJu9BQwdYkdgRY8elUKD02/IzbQlYJ4IBl0ydGUsRHI1SG0Py0
        /kES+py0LOj/I1S7xiOLON64E878Exg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-RZQweCHUP12bF0looVVDbg-1; Sat, 01 Jul 2023 17:45:14 -0400
X-MC-Unique: RZQweCHUP12bF0looVVDbg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fa871e1eaaso38697855e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 14:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688247912; x=1690839912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixfgD95cECm9IJRwnBAQBSBQpbSMzbZAJ/z6SVP266o=;
        b=d7ZjoD8DPWVixwyqZm3HUnfDkPsYfcUgZlENtO9sw79wuPsEA57ANtCA244yUyKads
         XniCiosKsXFkVP6XiVHgVi8YTc/A5ZJ5aGFxuKEVsqUIlUg+wzb63aNzUZ/ENdPjflBk
         llkqrWTkpvZ8AwRJ3FM7JZaQpTFRp7fsNS8wchVrHd9tfedbXHba5mWhSRROjLt9+jI4
         a0ETNrhDbJWgJODrXalhpKoN894JzwBVh2iS9zJPHCZfKz69I0B+neba8GRCVqHaAkdF
         ZO2LPwUBocCVYXBt726JhWNyN6utARakm6CF/xM1ukPTtiq6ch98MyhgqZYBskrw5j2K
         zQjg==
X-Gm-Message-State: AC+VfDzo/r9Sps1zTm9JetuH7HwhD/JV8PpD3yjimG3BR+5jpwR7sbly
        rgSaeYXE1Fgpu+/TmuXMnsHAKmSBwz8cn9lv2AbJO6ORUdPFotWZbZ4HOqlWqWFW3JNYQ/sJsVV
        mC5fDCvjgOI7hMDYRhd9ODTRSFVldonRpRuv4cOr7ZuLn6w6DxzdA0xvFQEYXBBWW5E12oB/UFe
        epb/964M8=
X-Received: by 2002:a7b:cd8e:0:b0:3fa:8aed:d57f with SMTP id y14-20020a7bcd8e000000b003fa8aedd57fmr6784958wmj.24.1688247912689;
        Sat, 01 Jul 2023 14:45:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4VVFAC+mKe4oPCU8/6h1nc/0/NeVojU7eqWExkSndccFGWikoSilyCREx/O03MkmAP6nkbXg==
X-Received: by 2002:a7b:cd8e:0:b0:3fa:8aed:d57f with SMTP id y14-20020a7bcd8e000000b003fa8aedd57fmr6784914wmj.24.1688247912252;
        Sat, 01 Jul 2023 14:45:12 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fbc0ea491dsm6913800wmc.40.2023.07.01.14.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 14:45:11 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v2 0/2] Allow disabling all native fbdev drivers and only keeping DRM emulation
Date:   Sat,  1 Jul 2023 23:44:49 +0200
Message-ID: <20230701214503.550549-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

Patch 1/2 makes the CONFIG_FB split that is mentioned above and patch 2/2
makes the DRM fbdev emulation to select the new FB_CORE symbol instead of
depending on FB.

This is a v2 of the patch-set that addresses issues pointed out by Arnd
Bergmann and Thomas Zimmermann in the previous version:

https://lists.freedesktop.org/archives/dri-devel/2023-June/411435.html


Changes in v2:
- Keep "depends on FB" for FB_DDC, FB_HECUBA, FB_SVGALIB, FB_MACMODES,
  FB_BACKLIGHT, FB_MODE_HELPERS and FB_TILEBLITTING (Arnd Bergmann).
- Don't change the fb.o object name (Arnd Bergmann).
- Make FB_CORE a non-visible Kconfig symbol instead (Thomas Zimmermann).
- Make CONFIG_DRM_FBDEV_EMULATION to select FB_CORE (Thomas Zimmermann).

Javier Martinez Canillas (2):
  fbdev: Split frame buffer support in FB and FB_CORE symbols
  drm: Make fbdev emulation select FB_CORE instead of depends on FB

 arch/x86/Makefile                 |  2 +-
 arch/x86/video/Makefile           |  2 +-
 drivers/gpu/drm/Kconfig           |  2 +-
 drivers/video/console/Kconfig     |  2 +-
 drivers/video/fbdev/Kconfig       | 40 +++++++++++++++++++------------
 drivers/video/fbdev/core/Makefile |  2 +-
 6 files changed, 30 insertions(+), 20 deletions(-)


base-commit: 270689d257c88fd1ad7050041ed196a8188e6914
-- 
2.41.0

