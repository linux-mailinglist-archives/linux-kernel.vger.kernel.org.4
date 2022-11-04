Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B9A619B02
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiKDPIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiKDPI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:08:26 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FF1BE0C;
        Fri,  4 Nov 2022 08:08:23 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso7976183pjn.0;
        Fri, 04 Nov 2022 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JMPOdF+o0zNjI5oSIE1GsSu6N/ryN9SMeyxLPWXhVBs=;
        b=RyhdIpGXQUD3R+si/9tPRnDaLMca3cbp3VLQ/v85H/ZaZ3gaR756lwv5SkgBd5x4G7
         ekwGjJryWjPw2SdQ8n/mJPge5zWihLtr2DcyFD0mttD2WyDGJfEHKqLjIxPF5sZdkYvL
         OvH9tU41qQ+8ZoC9t6FOPy4BJBJ55d3MQzq41uH4TPDvoidaLWevBZVEbiGGDCXHQxtb
         VwebHuDywesjdUf+2x7nU6Zilu676jnTUQoS+Dh8PzC+BorW4EkltFg4jsGa72pqaXRP
         VxjjFJwoSWC3956lN26S63DUxw3eJ504d7wd7tG6ASkiJGrAYlBDgBlq7QyDMVneeC3l
         xUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMPOdF+o0zNjI5oSIE1GsSu6N/ryN9SMeyxLPWXhVBs=;
        b=K/z11idtwcjV7Ta2+TrK7SkGCJR9g62jlV/V7V1NF4WboAZabFNuO1j77YvArzXbU/
         kxyy56LqEHpjx39eewhHNgq8TgTPahn84sDbAkY0u59cy/KK5KaNcrL6T/+To5jbTkbi
         ltdmQkPb0qGTqQ4dUyceoGg/r6WHbguwfoKRIUlDz3JjuTjtg9dyrgoiFgFKzB9yizQE
         s7x3i0s1ssYCAlZyTwDQcBTaOdsjze16LwTeSCXQIKnVHg27dX6VyT7n7iu7u3debfyU
         rXS1aCllonYrd3nKxyD7mmi844qDwsVT1z+pYRCqOX9JBdJPSMQO08L8hwohR6xv0BuK
         lXqg==
X-Gm-Message-State: ACrzQf23/aO7OWj5uvIojZAlSkhRqeTzaaLsc7+RNPACY+UV65ElXjOo
        DFDq2J6iBgerC7lWo88hlS0=
X-Google-Smtp-Source: AMsMyM5KzINUyMORzunyuK5891yHttCtmYcq8nB9pAJbJjysO0tEd1LCg8MnTXG3THRjnogaziLMVg==
X-Received: by 2002:a17:90a:c705:b0:213:1455:1326 with SMTP id o5-20020a17090ac70500b0021314551326mr37110567pjt.244.1667574503114;
        Fri, 04 Nov 2022 08:08:23 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ce8200b00176acd80f69sm2805024plg.102.2022.11.04.08.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:08:22 -0700 (PDT)
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
Subject: [PATCH v3 0/2] drm/msm: Improved hang detection
Date:   Fri,  4 Nov 2022 08:08:37 -0700
Message-Id: <20221104150847.525173-1-robdclark@gmail.com>
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
 drivers/gpu/drm/msm/msm_gpu.h               | 15 +++---
 drivers/gpu/drm/msm/msm_ringbuffer.h        | 24 +++++++++
 10 files changed, 125 insertions(+), 49 deletions(-)

-- 
2.38.1

