Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207E067542D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjATMJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjATMJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:09:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7EFA19A9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674216509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EorP74j3x4AQpp4pYb79LEKPx0NRfoi7hoT0sE5jwxk=;
        b=iFYk848u+spP0caBtqC0oPG8ox5qhH+e/OpNllQ9t4ostRdH+ND8iRP+G9FECiwMCtQVzP
        kaWxfxIKn2PHVUfR6fVcj9HmmSUQmCxNK4cm5cUPBSOvroA8qL7NjS8LKX5BXHpAH8W6NV
        8Jn/G2WigRZKWaI+rkil9oU2tA8UB0w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662--9xwtT93NyqOK2wan-ZczA-1; Fri, 20 Jan 2023 07:08:28 -0500
X-MC-Unique: -9xwtT93NyqOK2wan-ZczA-1
Received: by mail-wm1-f72.google.com with SMTP id k20-20020a05600c1c9400b003db2e916b3aso1292125wms.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EorP74j3x4AQpp4pYb79LEKPx0NRfoi7hoT0sE5jwxk=;
        b=qcA90FMx+sf99RzeHvj7/g5vnROngXGGsXeNIVYL5CHw5wEZy+nSJ++nH5vipQObS4
         eOHmOmCFdbaJSaC8ghc52pkxW6coXtnuMhvq7P3H37C1jUZx/Lehc9q2DECCbFLpB1de
         qNSjqPmS7tF2xFPqhCa2ehmXvh+kivQQWMR2LZHodWMrTq7MN4xzJ6AIEbiCBiPRcUe5
         QybzHExRZy5D8/6RcLr2Nkh3SPbGpa5/JKdvLB4F2lIDk7WezokrWOd25F6Tx50h31z5
         N3EFc7NvONsu7XxQ6i8XC4ocS10Guf4fcZjF0/8bQjVSUWxBJ007Cn9X7E9jV4ta5aAY
         Wtuw==
X-Gm-Message-State: AFqh2kporn/WiwywwhH+yErQosC71VjecZVnskcMvh+rQlyQ2haeE5/k
        vylWp+0TFE2l5/9dvycjkBNZz2kDUzr/Jg2k38Zzz6feEVRzXpOZ7t3Iy6ccM9ZJ9AYEoyNU3xs
        lFocFS7yQSMoifgZnB3qpJmiuaDNWFCF32+fiku/ACao1ShNEYz6RkwBuNmdfqscHVpR+Rvu8TY
        U=
X-Received: by 2002:adf:c645:0:b0:2bf:81e9:cdc5 with SMTP id u5-20020adfc645000000b002bf81e9cdc5mr954323wrg.42.1674216507112;
        Fri, 20 Jan 2023 04:08:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtxVGUJbmsvWQFDyiPS9CLawvVjvF3wsxeOlNhZMZ27WAF18x2qJNgpWWaTBA3nDIrWCUDtEA==
X-Received: by 2002:adf:c645:0:b0:2bf:81e9:cdc5 with SMTP id u5-20020adfc645000000b002bf81e9cdc5mr954296wrg.42.1674216506809;
        Fri, 20 Jan 2023 04:08:26 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b002bbb2d43f65sm32766336wrx.14.2023.01.20.04.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 04:08:25 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
        Jaya Kumar <jayalk@intworks.biz>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 0/3] Fixes and cleanup for DRM fbdev emulation and deferred I/O
Date:   Fri, 20 Jan 2023 13:08:19 +0100
Message-Id: <20230120120822.2536032-1-javierm@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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


Javier Martinez Canillas (3):
  fbdev: Remove unused struct fb_deferred_io .first_io field
  drm/fb-helper: Check fb_deferred_io_init() return value
  drm/fb-helper: Use a per-driver FB deferred I/O handler

 drivers/gpu/drm/drm_fbdev_generic.c | 15 ++++++++-------
 drivers/video/fbdev/core/fb_defio.c |  4 ----
 include/drm/drm_fb_helper.h         | 10 ++++++++++
 include/linux/fb.h                  |  1 -
 4 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.39.0

