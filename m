Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46FB6F0B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243767AbjD0RyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243639AbjD0Rx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:53:59 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8954B40F0;
        Thu, 27 Apr 2023 10:53:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a920d4842bso65413825ad.2;
        Thu, 27 Apr 2023 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682618033; x=1685210033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r7JtrQ77CpqZ0uEy+tIG0NqsG9JuxMjN6QjQNJWIquU=;
        b=L2bWeqrCC2L70jQ2hEirudGn7k+FZL2/87Mjs90rkz/kPRRuHWp6OiKbwdmlBlX/lI
         rkJPrrzgxTF9LmSz7fRYLdTbO+rw1Itx49QaPkeH1pcM8AGz8Mbl/TYzqrMjSv+PP9Yr
         juW+tM4VrneECMDFdvPAiowOHNsTnWWzSaBiUd4dk9h1+gpxpCEgFqcGd4S2Qp9y5D7G
         E8nKq2Pms1ySTlONLegg6nDtIYKDbri6qtn89WuFB18GyL525Sh8tMpvU2NFnKevpObc
         pmmeeirnLl8gT35Xg3qMCAok75nL8tV69ANpVarFaES/aSTLsQb32vaxf+LpVPu5JiA3
         83OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682618033; x=1685210033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7JtrQ77CpqZ0uEy+tIG0NqsG9JuxMjN6QjQNJWIquU=;
        b=fYnyB+NIYg7LRLKUZzhGJM0jT8CWvC5jn47XqeoDkpFKsU9BLzEAGWAhug9PybCB9U
         XRzK8R0zQ26rGUF1sQgvaqd9r+2XiUbtNTH4qAu71oqXG4nKljoCOVKRETdSBSWdApdi
         Rxc5wufRaWTULz4Canh6N8v7+DuiXHaOIG+J+YNC4LDKfqpHpKnHhOhEDGMQh7ilvoy7
         fdRNXYljeLFLS2eY9Lgr8BI1XfolFoCmqcKy3SL+ccP+2rKqIEIY8R1MAzBlgDReYucg
         JiGYWRAZ7YFa0wvxw8qP+B3Ms0s6tVkIo+dIjLdiLUkuED7NKs+1gdVrZ3z5QCHU6I6g
         VLXA==
X-Gm-Message-State: AC+VfDxUtqKaMZ8onqUe1vfVyWowNIwRDyE54ZBINIKIcjlXE27j+Zae
        tb4rfHm1lJ62EaTn2FWim4M=
X-Google-Smtp-Source: ACHHUZ4LVPkiCnSflLuvp4CIOCxMflamTbbG8UY5vbds8WnhLBlUH54sQOFejjE+V3wGmE+MZojirg==
X-Received: by 2002:a17:902:f689:b0:1a6:6d1d:bbf4 with SMTP id l9-20020a170902f68900b001a66d1dbbf4mr3149993plg.11.1682618032836;
        Thu, 27 Apr 2023 10:53:52 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id az1-20020a170902a58100b0019cbe436b87sm11971018plb.81.2023.04.27.10.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 10:53:52 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        Luca Weiss <luca@z3ntu.xyz>,
        Mario Limonciello <mario.limonciello@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Sean Paul <sean@poorly.run>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH v2 0/9] drm: fdinfo memory stats
Date:   Thu, 27 Apr 2023 10:53:24 -0700
Message-Id: <20230427175340.1280952-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
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

[1] https://patchwork.freedesktop.org/series/112397/


Rob Clark (9):
  drm/docs: Fix usage stats typos
  drm: Add common fdinfo helper
  drm/msm: Switch to fdinfo helper
  drm/amdgpu: Switch to fdinfo helper
  drm: Add fdinfo memory stats
  drm/msm: Add memory stats to fdinfo
  drm/doc: Relax fdinfo string constraints
  drm/fdinfo: Add comm/cmdline override fields
  drm/msm: Wire up comm/cmdline override for fdinfo

 Documentation/gpu/drm-usage-stats.rst      | 109 +++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  16 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h |   2 +-
 drivers/gpu/drm/drm_file.c                 | 147 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |  24 +++-
 drivers/gpu/drm/msm/msm_drv.c              |  15 ++-
 drivers/gpu/drm/msm/msm_gem.c              |  15 +++
 drivers/gpu/drm/msm/msm_gpu.c              |   2 -
 drivers/gpu/drm/msm/msm_gpu.h              |  10 ++
 include/drm/drm_drv.h                      |   7 +
 include/drm/drm_file.h                     |  42 ++++++
 include/drm/drm_gem.h                      |  30 +++++
 13 files changed, 375 insertions(+), 47 deletions(-)

-- 
2.39.2

