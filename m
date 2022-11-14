Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62114628956
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbiKNTab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiKNTa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:30:29 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A983B7C8;
        Mon, 14 Nov 2022 11:30:28 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id b29so11949046pfp.13;
        Mon, 14 Nov 2022 11:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dQ5k2V/5A62gTc5QTJzii5/7/7JddLuFSJid46RtM2M=;
        b=nxNwaZQF3x3j/8J7fd3JPVe2TA2jnQ1TY9yPid8kBPgGXiH/wqaKXKDplSO8bE6Xx7
         ux0MlDQI+3wHxJQ6DYbk6y9teN33iquwvm2t65lqkjW85pnxD+ILPrp3S53vAVlACSzp
         smGA/JiQrDN4/8ln2Piq8lWn3ktFCz5+PZje315plOQL2DA4rAKSsHzJceJkbeW6/iJC
         hJXq1g3Y58t8ULi9QLcIz2G8hnNzKntU6xXIoGgRnYtBGgc+WuU2JaMFP9RGSEUnotnk
         UNJuRz1K3lZjD00XbeLtBDtX9PKbOR3KyIr529GB2X3QeDemkNS0cSEsmAoCLOHoWK2K
         bj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQ5k2V/5A62gTc5QTJzii5/7/7JddLuFSJid46RtM2M=;
        b=18pG/yZ31nP8qcHQViVi6m1LafwY4MsTj6+F/z7crFXqwwmkgs9fGGP77lkoKIeMc+
         KvUE+I8CBRdZMOh7s/68B24sxMVasqPAjLy+yXHVzIT2Yx7VU+nTytCKrpEW16mwKI5w
         f78Qpe/5dx72DYYSlX02JTmyu4mzV/vxjw9/qayEP6aBYXlJAMYqde4uhiqG5ARskUBt
         5IJVToEu9+tCpj69qhFLNs2k0zb/eBhuVZOMiZVozwEDp57SiqFbyPibKn4tN6HzxgTO
         or6iqqBs4wSgffhMV4DTylzoXB5IbhtqsQpixXIb2zpkFR2mW78IQNEz69ODBZ1AJPKG
         oz7Q==
X-Gm-Message-State: ANoB5plC41oo30sGYhmeYu5RMftlBU3G5eeW8xzk4949zxGHIge1wzue
        iOlRm2JkWQ/63nrNkDY8WQfa6lkmn3Y=
X-Google-Smtp-Source: AA0mqf6DXVzjWtfbg4JRMidH3O7mZe4qw/QhB6mGJ0GThYrSgcF8XvaC+Dxn9w9hH8+JcPjIqTEshw==
X-Received: by 2002:a63:ed18:0:b0:45c:eb5a:3361 with SMTP id d24-20020a63ed18000000b0045ceb5a3361mr12484027pgi.346.1668454227941;
        Mon, 14 Nov 2022 11:30:27 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id 79-20020a621552000000b0056c704abca7sm7082468pfv.220.2022.11.14.11.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:30:27 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org (open list),
        Sean Paul <sean@poorly.run>,
        Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: [PATCH v4 0/2] drm/msm: Improved hang detection
Date:   Mon, 14 Nov 2022 11:30:39 -0800
Message-Id: <20221114193049.1533391-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Try to detect when submit jobs are making forward progress and give them
a bit more time.

Rob Clark (2):
  drm/msm/adreno: Simplify read64/write64 helpers
  drm/msm: Hangcheck progress detection

 drivers/gpu/drm/msm/adreno/a4xx_gpu.c       |  3 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c       | 27 ++++------
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c   |  4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       | 58 +++++++++++++++------
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  3 +-
 drivers/gpu/drm/msm/msm_drv.c               |  1 -
 drivers/gpu/drm/msm/msm_drv.h               |  8 ++-
 drivers/gpu/drm/msm/msm_gpu.c               | 31 ++++++++++-
 drivers/gpu/drm/msm/msm_gpu.h               | 22 +++++---
 drivers/gpu/drm/msm/msm_ringbuffer.h        | 28 ++++++++++
 10 files changed, 136 insertions(+), 49 deletions(-)

-- 
2.38.1

