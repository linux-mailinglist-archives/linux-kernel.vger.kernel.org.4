Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB747430C2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjF2Wwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjF2WwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:52:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075752D62
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688079082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=97bfxa2ildUUs8zNadKQMWE3XSHS8OGi9guqfFdEnRY=;
        b=dVpcnYvEmJFN/r3HH6yJ3BwXbwUVGBcwjgijkhXji9kkfFjmNawLmqf01kOHr0fmrKVgDL
        7A+A9oINqQCLLZXZQPYN9D1lX0qvVUgOOtiR+q28YG4tEuUM4TWC/jZkJxXihhaKEEA3ug
        Qf72d3WTlhNgn/wXAAgXVYWi2+gRBXU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-9xlgq7hcN0SaImwnj5PqVA-1; Thu, 29 Jun 2023 18:51:21 -0400
X-MC-Unique: 9xlgq7hcN0SaImwnj5PqVA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-313ec030acbso514627f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688079079; x=1690671079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97bfxa2ildUUs8zNadKQMWE3XSHS8OGi9guqfFdEnRY=;
        b=ExWOiADfnuzK4CceQOK2IPBvhY7ifzNYcSA1dUxGnCuGadOYUJAAQfV61khC+fdeZL
         eFHdSWogZt/qDbCHhWV02FJBQELxnlfEKl3mn2udZuDhoDyLTyTasGNVK63RRH0YelYK
         oAJH42OSuQqSfDNLu6bpdlazY1YMl4kzTFekpVkyz5EAnKk5CWmu/+xCaQmkJ+5+NAK3
         yJEmD7x6nBigXycS8vRP8xMpqKWX03Qrb3OeGQ0VGftplF34aj0Fq9XuKnc8BFE0tNez
         Blbc2jQKQddSU5/thhp4A4R4A7BlCWrFiewlfCnCIuaG9l/wsnUFF1giroa8yQ1TTx9m
         FoIQ==
X-Gm-Message-State: AC+VfDz0IbOEwL9tESu6Cwq5cqflBbiz/+ddZnBbBnzNA1ILLmbHLqtC
        Py8K6BHKZ5XZrwctpEnR0XMDovTXVQtyQXBfRZIa1JXWS5LWEWMv9+ssGxPYRHDSXwqIZKbJRmX
        68/PaULAQSm3eLnXNye9+3bsHaHiOS1RFoGM8HAxMXEG0VEPYiv0rTb3SYZAxO83CeqjVVG96fI
        hnWUZjUsU=
X-Received: by 2002:adf:cf0d:0:b0:313:ed10:7f52 with SMTP id o13-20020adfcf0d000000b00313ed107f52mr6115117wrj.18.1688079079589;
        Thu, 29 Jun 2023 15:51:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5yNLJ3SOH2DLnOJkryCoLwduMQdbLlL8LCtjNfgrXWsfzKraLofJ9rCFcQyRlq9jVxkKfBSg==
X-Received: by 2002:adf:cf0d:0:b0:313:ed10:7f52 with SMTP id o13-20020adfcf0d000000b00313ed107f52mr6115089wrj.18.1688079079281;
        Thu, 29 Jun 2023 15:51:19 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i6-20020adff306000000b00311339f5b06sm16795690wro.57.2023.06.29.15.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 15:51:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
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
Subject: [PATCH 0/2] Allow disabling all native fbdev drivers and only keeping DRM emulation
Date:   Fri, 30 Jun 2023 00:51:02 +0200
Message-ID: <20230629225113.297512-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
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

This patch series splits the fbdev core support in two different Kconfig
symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
be disabled, while still having the the core fbdev support needed for the
CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
disabling all fbdev drivers instead of having to be disabled individually.

The reason for doing this is that now with simpledrm, there's no need for
the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
now disable them. But it would simplify the config a lot fo have a single
Kconfig symbol to disable all fbdev drivers.

I've build tested with possible combinations of CONFIG_FB, CONFIG_FB_CORE,
CONFIG_DRM_FBDEV_EMULATION and CONFIG_FB_DEVICE symbols set to 'y' or 'n'.

Patch 1/2 makes the CONFIG_FB split that is mentioned above and patch 2/2
makes DRM fbdev emulation depend on the new FB_CORE symbol instead of FB.


Javier Martinez Canillas (2):
  fbdev: Split frame buffer support in FB and FB_CORE symbols
  drm: Make fbdev emulation depend on FB_CORE instead of FB

 arch/x86/Makefile                 |  2 +-
 arch/x86/video/Makefile           |  2 +-
 drivers/gpu/drm/Kconfig           |  2 +-
 drivers/video/console/Kconfig     |  2 +-
 drivers/video/fbdev/Kconfig       | 62 ++++++++++++++++++-------------
 drivers/video/fbdev/core/Makefile | 14 +++----
 6 files changed, 48 insertions(+), 36 deletions(-)

-- 
2.41.0

