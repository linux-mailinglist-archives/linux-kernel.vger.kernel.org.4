Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC672676874
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 20:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjAUT0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 14:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjAUT0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 14:26:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA8A2B09C
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674329090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=t3hudovJHnxcneZUu+woal1qY/z5dLk/KSxEgxM2qkk=;
        b=Uu85tamzqotnBJItu/TcjsCrqariLoO8kmj+S2+X3Q7vJ59lHP3O7BDm2YbZ0KCfBYnf3f
        BnH8L98uA3u7OpNz8mtpyguFfWEYM/SDt+uv153+ayldHknZoV5kNA9oTUvn5pBK445x6T
        Fkn8snxEjZxoXtOTO3HpM3sgyJKtr+I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-183-WzofcmbBMzuU2RVoGWO-sA-1; Sat, 21 Jan 2023 14:24:46 -0500
X-MC-Unique: WzofcmbBMzuU2RVoGWO-sA-1
Received: by mail-wr1-f71.google.com with SMTP id o15-20020a5d684f000000b002be540246e1so847206wrw.22
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3hudovJHnxcneZUu+woal1qY/z5dLk/KSxEgxM2qkk=;
        b=0roHxnrSbzIRgmngJjbfceuq7FGx+efzNTRAzs6YriZhtqK7zUJ00uKkkhQ/pHYmu8
         FPd0pqUIWHGHCJ5mBgUjR/rz/ir/ykfjFOeCCmEL8YtypivjOy1hm0Vx3K8HxBn1DyVo
         sJMidgz3HRkO2lNbg9pAaIuR9dtawV+d872swN8KjroTqF/FKD34xJIIQOmd5XeLzpjF
         KlppqE85wSqqQY0wwOJSzQBIKaEkAc4KhymdJg5DUt5Sqx9XvoOgvk08iPe/PKJG9WLf
         XxF5iTzFteZ1XvHNavlKul8TYGLPomzM3PvgWz9CzAj85y4tSBLv65SF+RZGug9hKO5f
         8E7Q==
X-Gm-Message-State: AFqh2kq+m83cfi5Sh1YMiyXAgmMnrmDCK32YlFes2hyOL1pE+6fcOMOb
        HWCsOCJRyUbz+JrHly8XFR+P9Hh7nc3017aQxpNKS/eJMU30dtaXOo3ryMMgZyBRDNinBBxfWGS
        nWx3Jpn5bfpfZNBFlQWZP2JKxaeQvGLU78mVwoPJMM2VItC6nV9QYxJ0DtbJYS+GrOaDor6HOyX
        0=
X-Received: by 2002:a05:600c:3b91:b0:3d3:5c9e:6b27 with SMTP id n17-20020a05600c3b9100b003d35c9e6b27mr15020847wms.12.1674329084777;
        Sat, 21 Jan 2023 11:24:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsX9USPEoSwU8E0lwBmJ+d/5/Wr2ac8HU57kLtvH6Q9yQcFpRhHXcnJcvHcD2LCoyGFM1bn+A==
X-Received: by 2002:a05:600c:3b91:b0:3d3:5c9e:6b27 with SMTP id n17-20020a05600c3b9100b003d35c9e6b27mr15020826wms.12.1674329084475;
        Sat, 21 Jan 2023 11:24:44 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003daff80f16esm8544321wmg.27.2023.01.21.11.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 11:24:43 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
        Jaya Kumar <jayalk@intworks.biz>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 0/3] Fixes and cleanup for DRM fbdev emulation and deferred I/O
Date:   Sat, 21 Jan 2023 20:24:15 +0100
Message-Id: <20230121192418.2814955-1-javierm@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series contains two fixes and a cleanup for things that I noticed
while debugging a regression in the fbdev emulation for a DRM driver.

The first two patches are trivial and shoulnd't be controversial, the third
patch is less trivial, but it has been already reviewed by Thomas and I did
test it to make sure that works as expected. With it, I got rid of the WARN
that happened due a mutex used after it has been destroyed.

Best regards,
Javier

Changes in v2:
- Re-introduce the CONFIG_FB_DEFERRED_IO ifdef guard for the @fbdefio field
  declaration since the kernel test robot reported that's needed at the end.

Javier Martinez Canillas (3):
  fbdev: Remove unused struct fb_deferred_io .first_io field
  drm/fb-helper: Check fb_deferred_io_init() return value
  drm/fb-helper: Use a per-driver FB deferred I/O handler

 drivers/gpu/drm/drm_fbdev_generic.c | 15 ++++++++-------
 drivers/video/fbdev/core/fb_defio.c |  4 ----
 include/drm/drm_fb_helper.h         | 12 ++++++++++++
 include/linux/fb.h                  |  1 -
 4 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.39.0

