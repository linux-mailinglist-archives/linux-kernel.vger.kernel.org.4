Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA64702FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbjEOOat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjEOOar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:30:47 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B50E11D;
        Mon, 15 May 2023 07:30:45 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51f1b6e8179so9069157a12.3;
        Mon, 15 May 2023 07:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684161045; x=1686753045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wnZ9D21xzUPORZdBoaAd712UMhIWRfvjN7BdaMIkqdk=;
        b=jsjrWitfOWbVsXPs6B5Lia8wkg2dLmz6o1d406QcFVfo+pyvuvyJUDtrVrDpo/x51a
         iUa7DRKHwe+Y2TYOh6H7L7rJBd8pZRgLa3kotBIFD06zze2ApQWxZrM2yzbSsnqGdws3
         hB1E9KHVnknZjM8apmNiuBCAODD+L13Fcr5+7UOnasTmc5gVCqNDJJok5hG9lTQFzSsI
         47Y0FVm+ddZICgDFbREMkvMQ/ZcCD3jE5hkRDfNFpaYibHWTOrI7kTQRxbZCp4MVl3Uh
         vapTVORVVlzm24Z4RNvraER4YgtSeUjYDoCIpROMsN47KKOZBGd7rtydXTkojkexyeLA
         DKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684161045; x=1686753045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnZ9D21xzUPORZdBoaAd712UMhIWRfvjN7BdaMIkqdk=;
        b=klMGzvTej/i1u0QCh2QwlwfA2BdG+I0RMfjeeOH6Mi9uQPVWGD1GRvDXpU2klQlfGG
         CwNySVrpj3R5T0RoZcpmnmlkuR7ZUMOjPDgoGP9l3EhYotT8JuhG1XhKj62aeAToHuMh
         FTH8eioBVscCA5CZLNsCAUHa3UnOHu2AOAj5fK4W5AKKlpHxUg+EKDC3kaFbuo/ZnGnT
         kYO98xgk6RFZJ7T4uXNk14mhzUFiy6W17mUaz7JTuLKeccCb5LLI2pJTOOTBd8IpMoCL
         udJxOuSjff7waKy8xhwo2eRm8IpGjdZ3z6r6i1X6O6Eyf1y/k4BqBpZVDA8vUq33clJE
         pRLQ==
X-Gm-Message-State: AC+VfDyvRK9W/jMceZlnPiR3iuPCA2GrhJuh43UWvZNEXiqRHJe4QKDM
        aGxwyiqfxebxIgSlVDXVfWY=
X-Google-Smtp-Source: ACHHUZ4nzYaFbPRfq7KOx4sRIQWnNBXWBHnP0pDxZJRMeUoSpyIWQjFgCTyi+zlwTFFGBymq4HyWYw==
X-Received: by 2002:a05:6a20:7fa3:b0:ef:f558:b76 with SMTP id d35-20020a056a207fa300b000eff5580b76mr42340931pzj.5.1684161044688;
        Mon, 15 May 2023 07:30:44 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id e4-20020aa78244000000b0064928cb5f03sm2590440pfn.69.2023.05.15.07.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 07:30:44 -0700 (PDT)
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
        Bjorn Andersson <andersson@kernel.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lijo Lazar <lijo.lazar@amd.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        Mario Limonciello <mario.limonciello@amd.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Peter Maucher <bellosilicio@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH v4 0/9] drm: fdinfo memory stats
Date:   Mon, 15 May 2023 07:30:07 -0700
Message-Id: <20230515143023.801167-1-robdclark@gmail.com>
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
 include/drm/drm_gem.h                      |  32 +++++
 13 files changed, 378 insertions(+), 47 deletions(-)

-- 
2.40.1

