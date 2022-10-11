Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3295FB88E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJKQvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJKQvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25F695AC8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665507110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=28aJ5XW2Re+JDVuFK2sayuEhZGIwLwkMzVSZJ8TTZjc=;
        b=DARXEa/2swtQTc/PlGoIKCVUAcwh6oPz91DQnIOhuiFgsRdm3bJeEtwKtLpQDy+5tUC06X
        su3ul1Uu3WMk4J6iKZzMJw3a0ZDRGhdw6RZi9b9LEXpEvKkmDhA6VyrxeyHpyki4BVE4Gk
        0UlPcVyPJZtLFPhN8QTv7/NNyziTIyA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-505-KEfYzlm5MXWfTFPpCyqUkQ-1; Tue, 11 Oct 2022 12:51:49 -0400
X-MC-Unique: KEfYzlm5MXWfTFPpCyqUkQ-1
Received: by mail-wr1-f72.google.com with SMTP id m20-20020adfa3d4000000b0022e2fa93dd1so4043829wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28aJ5XW2Re+JDVuFK2sayuEhZGIwLwkMzVSZJ8TTZjc=;
        b=xtvAkN8599Ak7kTY2suiWWiwl4Ia8nXznV0vW9zq8D4h4yl7HWTvlYVrtkvdQVAfBt
         h0R9VEZB0dPm7qcsOeuSaRwpFrYtNn3F/w7b9h/LpSMoJTRGl8kJWZ20/DrJf9qx4H4v
         1gDzdG4zGwsoQyye+G2yDYy89LPl0Y3INgjUwimvPDFxnjZX8/1TKelu9R0pDrxrVla/
         JHivtL3ta8aKumsFV/SrfCIjEIduMHHKXIKELeqXAEis8RDtYylIceypBPUIZ+b4durE
         YaYfzhPqjAJ1O66gyVcsj31lDjQDxOBn4n0zmJtRrHqdo5V5OSYIenZ8lpHuCGb4T6vR
         3tuw==
X-Gm-Message-State: ACrzQf0IotTn3/nfpkGcXzvlPdVlZYEdMWL7BvsWzSTxHYt1+fcJt9Uc
        1cKKXLyiOYICWTbBUv+ahliUbZcQCkN/K5DM+pxSUVcUmDcNrhAeJK12Cr0P0F6cVg2JjqX31yS
        xE9xIv4kt1fdeZH1OlOc83fCelTrt0TIapvaBnIJI+XYdusU0MTn/0YWVvUusxNCwyUEcnQxrlX
        4=
X-Received: by 2002:a05:600c:2d45:b0:3c6:cc57:be72 with SMTP id a5-20020a05600c2d4500b003c6cc57be72mr13597wmg.23.1665507107643;
        Tue, 11 Oct 2022 09:51:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4soStj05RwBkvP59zpMQ8XQ7hR8mRKFb7xVCVqVnBDoqcV30KHZ3UzBCRMhxLqCL6OIXZOOg==
X-Received: by 2002:a05:600c:2d45:b0:3c6:cc57:be72 with SMTP id a5-20020a05600c2d4500b003c6cc57be72mr13570wmg.23.1665507107176;
        Tue, 11 Oct 2022 09:51:47 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c19-20020a05600c0a5300b003c6c76b43a1sm2025629wmq.13.2022.10.11.09.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 09:51:45 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/4] Add a drm_crtc_helper_atomic_check() helper
Date:   Tue, 11 Oct 2022 18:51:32 +0200
Message-Id: <20221011165136.469750-1-javierm@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function and make drivers that have the same logic in their
struct drm_crtc_helper_funcs .atomic_check handler to use this instead.

Patch #1, #2 and #3 are just cleanups for the mgag200, simpledrm and
ssd130x drivers respectively. Finally patch #4 converts the last two
drivers to use a helper instead of open coding it the same logic.

The changes are inspired by a patch from Thomas Zimmermann for the ast
DRM driver:

https://patchwork.kernel.org/project/dri-devel/patch/20221010103625.19958-4-tzimmermann@suse.de/

This is a v2 that addresses issues pointed out also by Thomas in v1:

https://lists.freedesktop.org/archives/dri-devel/2022-October/375363.html

Best regards,
Javier

Changes in v2:
- Reference drm_plane_helper_atomic_check() from drm_crtc_atomic_check()
  kernel doc comments and viceversa (Thomas Zimmermann).

Javier Martinez Canillas (4):
  drm/mgag200: Do not call drm_atomic_add_affected_planes()
  drm/simpledrm: Do not call drm_atomic_add_affected_planes()
  drm/ssd130x: Do not call drm_atomic_add_affected_planes()
  drm/crtc-helper: Add a drm_crtc_helper_atomic_check() helper

 drivers/gpu/drm/drm_crtc_helper.c      | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/drm_plane_helper.c     |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_mode.c |  2 +-
 drivers/gpu/drm/solomon/ssd130x.c      | 20 ++------------------
 drivers/gpu/drm/tiny/simpledrm.c       | 20 ++------------------
 include/drm/drm_crtc_helper.h          |  2 ++
 6 files changed, 36 insertions(+), 38 deletions(-)

-- 
2.37.3

