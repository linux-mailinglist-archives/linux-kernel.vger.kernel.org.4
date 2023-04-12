Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D646E01FB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjDLWnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLWnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:43:22 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E4065B3;
        Wed, 12 Apr 2023 15:43:21 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a3df25d44eso15395115ad.2;
        Wed, 12 Apr 2023 15:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681339401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jsDArGzo8UwzIHTKg4ZFesLzSfYls6QtUAhhPvCnIR8=;
        b=BR7mEMT/8rYu6AtMVIBgw3z4X+v7bZLyzLyaHfSGsNcVlWEC6X4Pt3CU+Q5aDWjSBw
         OyPlCcyByobDFutdLcF7xCxDH0ZYocP9rSZ51lIsNTDU9Qvxb4SHi2qYp50yzATwVHHf
         m6NWG7CkvHHOoxAEZP8+DA/PvRLnB1coRYRUltLjvi3dtAKFkazlEERm3+tq76mqhzQG
         m6Y8ViwGmo1trvUjzF4A/ldXuMGdnSNzOOAW3OufH6/DY2rFl5erI6NjC80JdIIoNN9Z
         pT/ufkyWe9KaWHs8kkT412BydAyrcC02JeTtesN13O8O0BCBvOe66XwMD90rPv1gK+aW
         mzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681339401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsDArGzo8UwzIHTKg4ZFesLzSfYls6QtUAhhPvCnIR8=;
        b=L8Oy5uJ207ny+My3pcxqWFxBfU0bcvwnRbXbwDZuHyVh+aPHuxyPYaQ1PmwRGrh5A3
         XedxmHl/dIN/NpviiHlQRMZs0NwtXOwWQwxwc1ofttIQHlloMALjRXzP9C8HRKOX1zaL
         pVXSyxu1f5qT7ozGiFo3w5/qIPSJXdlErvpaweDohukud1oWeXcyrSsYBe1hwGIfxcO4
         yk3Rxexf/IUFZNB/FEo4hLBwsLZ/0vv1w7t5cb5jlhU6KqiaHkMI3jD1fx548yjjBLcK
         mPjgk1fzg6Zp0WbICxlGLx6jcLz5jC8UyWOLZy9ztTnz+fnGxUKmoK6Ti0DddlpwKj5U
         Cggg==
X-Gm-Message-State: AAQBX9f6Pr2rBzzYSHG/43NlVTjVcmphJ4pccNyOF41ucyiRCAOGmF2j
        Dgoz0speVT1sups9e276muA=
X-Google-Smtp-Source: AKy350ZlpBPdTHWwnoS3DWIIAHEnWpX3sJfsQunpB1ugPu/RcyTRvjmYquL2lY552tk9dZGjs5kFvw==
X-Received: by 2002:a05:6a00:1508:b0:639:66e6:42d8 with SMTP id q8-20020a056a00150800b0063966e642d8mr667554pfu.19.1681339400671;
        Wed, 12 Apr 2023 15:43:20 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78295000000b00627ed4e23e0sm12253844pfm.101.2023.04.12.15.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:43:20 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        Mario Limonciello <mario.limonciello@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Sean Paul <sean@poorly.run>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH v4 0/6] drm: fdinfo memory stats
Date:   Wed, 12 Apr 2023 15:42:52 -0700
Message-Id: <20230412224311.23511-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

Rob Clark (6):
  drm: Add common fdinfo helper
  drm/msm: Switch to fdinfo helper
  drm/amdgpu: Switch to fdinfo helper
  drm/i915: Switch to fdinfo helper
  drm: Add fdinfo memory stats
  drm/msm: Add memory stats to fdinfo

 Documentation/gpu/drm-usage-stats.rst      |  31 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  16 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h |   2 +-
 drivers/gpu/drm/drm_file.c                 | 111 +++++++++++++++++++++
 drivers/gpu/drm/i915/i915_driver.c         |   3 +-
 drivers/gpu/drm/i915/i915_drm_client.c     |  18 +---
 drivers/gpu/drm/i915/i915_drm_client.h     |   2 +-
 drivers/gpu/drm/msm/msm_drv.c              |  11 +-
 drivers/gpu/drm/msm/msm_gem.c              |  15 +++
 drivers/gpu/drm/msm/msm_gpu.c              |   2 -
 include/drm/drm_drv.h                      |   7 ++
 include/drm/drm_file.h                     |   5 +
 include/drm/drm_gem.h                      |  30 ++++++
 14 files changed, 220 insertions(+), 36 deletions(-)

-- 
2.39.2

