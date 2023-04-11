Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C706B6DE797
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjDKW5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDKW5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:57:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D8440D7;
        Tue, 11 Apr 2023 15:57:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h24so9546471plr.1;
        Tue, 11 Apr 2023 15:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681253861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nII3QwEycAnovqWQfjWZu+6YGPxxA4KRFjzFYjJblIQ=;
        b=ZAC+uXDhUxji26Ze6K9nnsc/qkqNfO/BNR+cWRfv0hEqJWuCAoTGY1LTVUBy4ONBTf
         d5T8GAeHi8KkynlfafbWzNvIw8wZ0uFodWqaCNwNH0rH6wqDKr5SayKPsyT7ylkMtLcC
         pZX//qJfNqMpJOx/Ig3MPM377p5o6FHoboEBNshuT+8sJ4dqh9QgsSyozzxjDaXnSTQv
         YF+g/WDxpn77tLAABR4mVDSCUoE4ya4pOQ7XFK62nfOirsVqbS5WMoPIH30lmx+68HyH
         YWchXD690VQkVdW5neJpK+KTaD9WQ6vzmlCtQISpk7MCZ4jnFlY4JIi4AKUB6bxeUnAD
         XuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681253861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nII3QwEycAnovqWQfjWZu+6YGPxxA4KRFjzFYjJblIQ=;
        b=dlnJnh6YIad13SHspy3vnAadBZpco8jrJ0kvjPjOyWSeBy9thX3bg9xpHIs2Z4CB9v
         rzVdM+j5/qqP7gcXkUQzD7twej7fIF3UKVJyJlUZ4AalhiwoWoO1zHV7fnZC9G37Ailw
         SB3BUX86fxNE5G9PStjc8szoQjVOREUrXIT2noG28w8SYSShGxO6yd7gZVnCelfmpapY
         bhub4jr0zDp54ZWIdtY5kyvV2PhwkmiAG6FjfVcmS1xn0KpK8dkSFzMq90Z0N+8Mq9IU
         rBYN8W4HJoL6Wh1h8/jjZo1zCLuWqPdyn2RgPqy4MX9PTyAT0XxxULADsR7cNyWk98I0
         giaQ==
X-Gm-Message-State: AAQBX9cSGPUyUvfhx4l3TjX1ONedENdVApBeHiDXYlPAPGhGqE9aVJEv
        uQKsDjj6vpZbQIrY80oCCcY=
X-Google-Smtp-Source: AKy350b3kN3Vv7Rn1Xudjo2ScWIpD4ohPF62kNG35kDDgi5zG4c7QyA4AJOOZxCvGcg2yWirfkC2pA==
X-Received: by 2002:a05:6a20:1b11:b0:db:4fae:ad15 with SMTP id ch17-20020a056a201b1100b000db4faead15mr15979423pzb.42.1681253861084;
        Tue, 11 Apr 2023 15:57:41 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id n4-20020aa78a44000000b006338e0a9728sm6657912pfa.109.2023.04.11.15.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 15:57:40 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE
        GPU IP), Evan Quan <evan.quan@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        Mario Limonciello <mario.limonciello@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Sean Paul <sean@poorly.run>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH v3 0/7] drm: fdinfo memory stats
Date:   Tue, 11 Apr 2023 15:56:05 -0700
Message-Id: <20230411225725.2032862-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Similar motivation to other similar recent attempt[1].  But with an
attempt to have some shared code for this.  As well as documentation.

It is probably a bit UMA-centric, I guess devices with VRAM might want
some placement stats as well.  But this seems like a reasonable start.

Basic gputop support: https://patchwork.freedesktop.org/series/116236/
And already nvtop support: https://github.com/Syllo/nvtop/pull/204

[1] https://patchwork.freedesktop.org/series/112397/

Rob Clark (7):
  drm: Add common fdinfo helper
  drm/msm: Switch to fdinfo helper
  drm/amdgpu: Switch to fdinfo helper
  drm/i915: Switch to fdinfo helper
  drm/etnaviv: Switch to fdinfo helper
  drm: Add fdinfo memory stats
  drm/msm: Add memory stats to fdinfo

 Documentation/gpu/drm-usage-stats.rst      |  21 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  16 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h |   2 +-
 drivers/gpu/drm/drm_file.c                 | 115 +++++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_drv.c      |  10 +-
 drivers/gpu/drm/i915/i915_driver.c         |   3 +-
 drivers/gpu/drm/i915/i915_drm_client.c     |  18 +---
 drivers/gpu/drm/i915/i915_drm_client.h     |   2 +-
 drivers/gpu/drm/msm/msm_drv.c              |  11 +-
 drivers/gpu/drm/msm/msm_gem.c              |  15 +++
 drivers/gpu/drm/msm/msm_gpu.c              |   2 -
 include/drm/drm_drv.h                      |   7 ++
 include/drm/drm_file.h                     |   5 +
 include/drm/drm_gem.h                      |  19 ++++
 15 files changed, 208 insertions(+), 41 deletions(-)

-- 
2.39.2

