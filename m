Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6132C70FB35
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjEXQBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238110AbjEXQAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:00:51 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EF410C6;
        Wed, 24 May 2023 09:00:10 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-528dd896165so368654a12.2;
        Wed, 24 May 2023 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684944009; x=1687536009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B9cfnkHSvu3f3znujma+mgkhmHw3+ATd1xiyn5rWq0o=;
        b=I5y87xsIqIVtUw8NgQ8OzPnVVGKTBzR2XyPln4kjDcANDchFlG1CpGRW66ZRtFPNud
         gzeNokAw24CRm2J0jQ6I8jlG2FaYli9xZVT3Q3GzbnSvGVuPIf/NvQvBrFrbMDQEUAKg
         GV7UpSEiGg7fODuQMj7B6LXb0+SAmBCTsNMeXZGEBZu6up//eHEaHRZMFhbPt0psAweQ
         Vk4M0fggq5SAxZ3k3KIHlUQOYYXrEB5fJweYPEJwyDwn6PvEjH89Aucqbe4ZLBKovTKh
         sosgavmsbc82w+Y9U3Mw/jVLqiyeUqeMZ7DtP7atQx3IY1WYwmdN7cH7AS+3gV8WMkG0
         H15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684944009; x=1687536009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9cfnkHSvu3f3znujma+mgkhmHw3+ATd1xiyn5rWq0o=;
        b=FCVtQSkSwfhgHZgEm702aSV2aDcvdYfLA3FH3OoltxK411My7RoPZySpTk+v64iqiz
         gsESMTrQFWFecgW0KyDT/W8NbSCUfVQwLgnbcXzgNOXpWTfQ6CNXFj70wVTtyUm9L0tR
         BGSY2HcDVnXYDROw6c27E2nwcnGLdSYWQVL8y9XrVsZx6D698psfsuBRrm+6lmKU/g3N
         dbw6O3s2tMXdLUirH5P3H4V1l/7g8m1slwVR0UbED3TF/tY/ELzYlklNMH47cwE+Ry9s
         ZJpu4BIyNqDm5u0XRLQI2EatQMpCj3S9fXlFU/JTIDcsERV88AYOmFT7oxm2cjMstlAQ
         ZNaw==
X-Gm-Message-State: AC+VfDwyImYXf0rABmULF76fa6jmwZQVMyEUNM278YZobTMqwKrM+fQb
        7aVKeeVUZfqtuJLtwe//uDA=
X-Google-Smtp-Source: ACHHUZ4yDiUIV+Y7x/9WTGapmKYECnfSMNNF8AnZWdTT01U+ku9Z92d6dTBweuROpFldZkLALHJ09Q==
X-Received: by 2002:a17:903:244a:b0:1ac:63b6:f1ca with SMTP id l10-20020a170903244a00b001ac63b6f1camr23696631pls.0.1684944009268;
        Wed, 24 May 2023 09:00:09 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id g23-20020a170902869700b001a98f844e60sm8930176plo.263.2023.05.24.09.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:00:08 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Sean Paul <sean@poorly.run>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH v5 0/7] drm: fdinfo memory stats
Date:   Wed, 24 May 2023 08:59:30 -0700
Message-Id: <20230524155956.382440-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

I've combined the separate series to add comm/cmdline override onto
the end of this, simply out of convenience (they would otherwise
conflict in a bunch of places).

v2: Extend things to allow for multiple regions other than just system
    "memory", make drm_show_memory_stats() a helper so that, drivers
    can use it or not based on their needs (but in either case, re-
    use drm_print_memory_stats()
v3: Docs fixes
v4: use u64 for drm_memory_stats, small docs update and collected
    Tvrtko's a-b
v5: Rebase on drm-misc-next, drop comm/cmdline override patches

[1] https://patchwork.freedesktop.org/series/112397/

Rob Clark (7):
  drm/docs: Fix usage stats typos
  drm: Add common fdinfo helper
  drm/msm: Switch to fdinfo helper
  drm/amdgpu: Switch to fdinfo helper
  drm: Add fdinfo memory stats
  drm/msm: Add memory stats to fdinfo
  drm/doc: Relax fdinfo string constraints

 Documentation/gpu/drm-usage-stats.rst      |  91 ++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  32 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h |   2 +-
 drivers/gpu/drm/drm_file.c                 | 132 +++++++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.c              |  13 +-
 drivers/gpu/drm/msm/msm_gem.c              |  15 +++
 drivers/gpu/drm/msm/msm_gpu.c              |   2 -
 include/drm/drm_drv.h                      |   7 ++
 include/drm/drm_file.h                     |  32 +++++
 include/drm/drm_gem.h                      |  32 +++++
 11 files changed, 308 insertions(+), 53 deletions(-)

-- 
2.40.1

