Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2F86F3601
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjEASpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjEASpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:45:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52688C6;
        Mon,  1 May 2023 11:45:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24df758db1cso1011021a91.2;
        Mon, 01 May 2023 11:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682966708; x=1685558708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4TtnDaucJ1/IdFz7cgpnnbthTRQAkVtjilDPnFIRFQ=;
        b=W9VggSOnJQ/2lFEqhx94aKQ83hIbovdIhoKb7OiLLzq75wkWPswXIcRqrzXxm2NApG
         pB27DUyrbrhmVkZrrMX4YHlRzVF4tGS68nJ8Ejm8/BroZ+7hMHJuWQDTjuahOxhawRX2
         R16bnE4Y30VLSXXwBMvtqz8tiD2ZXfTrhNCDBskt/ZknqAIGxoIei8hIn2gsyuOvFZJT
         gcvTDoUkwne1R9te7FHSfKEIs+OMrGDJPRnXrfVYvm9LGAlMfDrZKhf3rH0KGi67d7/N
         6nggw95HVE442Z2Z2BWGqs5xyzseMQ8dW3H1P1Jmk/kb8zbLKv3rSGLZgQP6m91kkrJp
         zt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682966708; x=1685558708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4TtnDaucJ1/IdFz7cgpnnbthTRQAkVtjilDPnFIRFQ=;
        b=ThZDm6Ss6OGR4T05fU8QYPc2tCTVjBLUgfiDpUI4e0tq3Ckbytf+qFH5dKJUxQOZVZ
         FXOzotuNV6SjCraBnQHwYZPLcLPK8tLucSTCi4HW66X1JOiGWBH4ZofPMfWqlVoUOdlI
         vwjemODrsblVWhktrXKPMeTJhxugXgj8b6a9un8PNbIJMPm0Da6tq5i1l8BIgP9PLxrK
         CFZ8u/iVo/qQJXD8atV8WTLOHqOFTvYolLm55Ncp52ip+CXI+jWI+WKTX8d0sAoix8kE
         b5HVo3JrvMfl9r2cWCSkIj8DUgLBLY1zUGSXfkfg7jB8tcB6Azy9XrH7jMu167S+m9zu
         lB6A==
X-Gm-Message-State: AC+VfDxYwTnwaolJeRbyb53UFpi+iVX8GgFeKMgldWlwBJfbbctoOuc2
        PLutiTOJntdwohVOy0focHY=
X-Google-Smtp-Source: ACHHUZ5eAVBIqpAYEQNPFjADJrF0hyhOUOXr1qE6lR8ApK2ME+3UgTkS6x8bvceg5F1jcgxm+mDnDg==
X-Received: by 2002:a17:90a:bd98:b0:23d:16d6:2f05 with SMTP id z24-20020a17090abd9800b0023d16d62f05mr14722184pjr.22.1682966707721;
        Mon, 01 May 2023 11:45:07 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a0f0900b0024c1f1cdf98sm6413617pjy.13.2023.05.01.11.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 11:45:07 -0700 (PDT)
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
        Jim Cromie <jim.cromie@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Sean Paul <sean@poorly.run>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH v3 0/9] drm: fdinfo memory stats
Date:   Mon,  1 May 2023 11:44:46 -0700
Message-Id: <20230501184502.1620335-1-robdclark@gmail.com>
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
v3: Docs fixes

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

 Documentation/gpu/drm-usage-stats.rst      | 101 ++++++++++----
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
 include/drm/drm_file.h                     |  51 +++++++
 include/drm/drm_gem.h                      |  30 +++++
 13 files changed, 376 insertions(+), 47 deletions(-)

-- 
2.39.2

