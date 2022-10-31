Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C3E6140EC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJaWyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJaWyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:54:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A92812088;
        Mon, 31 Oct 2022 15:54:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l2so12001231pld.13;
        Mon, 31 Oct 2022 15:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=maJKyobLPXCPnwTwIQXAL/b/lOc2Vm9xJT2P1QP/26E=;
        b=fKZqAinGAoCrUEi6BcEABxVqovgpGs/So8dMU+TGLeFSpnDEPO6yunXqKkJMHWHjJU
         OCJShEXZKbkWESkzoZdlPYimrfT+1pwXUPweFSCeO/BUH5st3dCOUcMGwuXzm+VxEljI
         LjwTyR/wpNZT/T0p/ppS9VajRAOWl4vmxpi+pVLYTkN/gRxYv06a93X4Y5e8nQ3fZsul
         roO0MEtO79mZ7MHmKbpC6E/MfbOdVe+8DzO7hOC+URdT5GZOGcysNOF7OCrX1fD0Q+ev
         AJiuU6VE17UODAEV7hC1wQ4tYtCflBQZfZ97513l7w2qi358TMlHOFvxK8Rv2zC/4sjo
         Gm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maJKyobLPXCPnwTwIQXAL/b/lOc2Vm9xJT2P1QP/26E=;
        b=b7jSpkKYb6SAI/APyX57IOpfDFQ+O/IXOnTPLf4KXq7VlPho5psd80v1tzbANJ4j2y
         h2yb4nS7zhl5nDdll89Amn/MrIOG26McvD3nvEUvOR1ARaIRDpTJpLh+9gmfHAbN+HhQ
         r87ysDkNSRpys9+CsGn/9SD95TIiT4HtMMJRFjqYV5530KeEQIw24ORN7ANi5HF/hHJM
         V+fDqJamwMXkbsHNRLxaepN2V2MFv+hZPdpzY8+sv+3LMK6myrPth0IrKwj2hoiNwS4o
         IPily+Q6Vmekuo3JMI6kx8U11juhY1vITVPdRn4X+o1UwaAm99vblrrxwHQUOa6PKRLD
         huxQ==
X-Gm-Message-State: ACrzQf0MiOz6bgCkapkeQz3T2h8hAy7H4ni8sAj6uzM/Ujavf6YnvXGl
        /8LSnYGvd/JmvBtRhsjvGyY=
X-Google-Smtp-Source: AMsMyM5c3503xFzP/Q4764SIgGLaQXB+xemTW4iyoJCATUoLaIjv2fO8ZlLZOrCryAVzvX9Y1ix+ow==
X-Received: by 2002:a17:90b:1d0f:b0:20d:1ec3:f732 with SMTP id on15-20020a17090b1d0f00b0020d1ec3f732mr16997862pjb.84.1667256840879;
        Mon, 31 Oct 2022 15:54:00 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b001769e6d4fafsm4915431plb.57.2022.10.31.15.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 15:54:00 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org (open list),
        Sean Paul <sean@poorly.run>,
        Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: [PATCH 0/2] drm/msm: Improved hang detection
Date:   Mon, 31 Oct 2022 15:54:05 -0700
Message-Id: <20221031225414.1280169-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.3
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
 drivers/gpu/drm/msm/msm_drv.h               |  8 ++-
 drivers/gpu/drm/msm/msm_gpu.c               | 20 ++++++-
 drivers/gpu/drm/msm/msm_gpu.h               | 17 +++---
 drivers/gpu/drm/msm/msm_ringbuffer.h        | 24 +++++++++
 9 files changed, 115 insertions(+), 49 deletions(-)

-- 
2.37.3

