Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997CA6B5F1D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjCKRg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCKRgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:36:20 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF87E64A99;
        Sat, 11 Mar 2023 09:35:47 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q189so4791467pga.9;
        Sat, 11 Mar 2023 09:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678556119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bX0H6uhIC4ov1xkv+p6jNtndq/gYH/2wBvMKwtDIDLQ=;
        b=FhW19A9pZrBAeUUapuy9VvgFIHwhTCFZ02o8yP87iXiSXPh3wNHgO1vb9Bk5wXZAu7
         C78hPaGsIngWsB5srbxsWdblnkORDK1rJbdPEBw9AKN9VIbb7c6IOTdley0OW3uq5BKj
         kcrkYr/EuWmUHax09MwonxJ8spjrJoeaFQYAlJY3oRqXLyp5Srkh411Lnpo0bCZpNVat
         h1XXVcil+w5q4bnCUO0+uEf4DpQ/S9LG9Fz9xMwa42vk2H+pBxLJaiceHwzN/LiJ1Csf
         rBR3hY4pvJeUcT3YE2S3J9rlR40szai0DtD9VfVlWfq7E/WnPinbKBgSiZoreqDkKFXu
         pBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bX0H6uhIC4ov1xkv+p6jNtndq/gYH/2wBvMKwtDIDLQ=;
        b=7aIVywtv5C50V/pXAvevd7q6UZmw/6mhqnaj4MLiHANcHxOhxQtUzvj9V5bYqSrGO7
         6B/lj7kW9Ffof2kSWqeWsrAkQU04Kq1aEZm6r3ipPBdjxuSAJ0V98DTcLuCFcqbW9PQs
         IrREfyLZx922h6bXO3E6Lf+YcCfyToNsW+tlt9djsPtXHd9YsOj+GelLYsV+2Swzmuz0
         IFDy4s+RSiy84ubD3VjFh+5ZFaVkMd4nq8CMBos1VVGKGBbSWBHZ6CqNUNsk7PZGd630
         TH2FBjYfsaDxsJYuGnD2vR4szFujAO33IKDrOt1RqfUkO+Ct8KsjfQkQSI0zh7rIubzx
         D1pA==
X-Gm-Message-State: AO0yUKWGXpfoHA50icUHas4bEyf4I1x2MPjLXnEtqVG2GDFmADWc9o/S
        0JywdngrBB/JgQFucdZptug=
X-Google-Smtp-Source: AK7set9lHGl60nFxzCoe2K1Dt4CQazs+Af39jhU2HvhFfxq2bii3Z5qax1ogs64ixQu+sQqi8O8byw==
X-Received: by 2002:aa7:9984:0:b0:5a9:d5c7:199e with SMTP id k4-20020aa79984000000b005a9d5c7199emr25298760pfh.9.1678556119404;
        Sat, 11 Mar 2023 09:35:19 -0800 (PST)
Received: from localhost ([2601:1c0:5080:d9fa:9b45:95de:f47d:f85e])
        by smtp.gmail.com with ESMTPSA id i3-20020aa787c3000000b00580e3917af7sm1721677pfo.117.2023.03.11.09.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:35:18 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        Sean Paul <sean@poorly.run>
Subject: [PATCH 0/2] drm/msm: Get rid of fence allocation in job_run()
Date:   Sat, 11 Mar 2023 09:35:10 -0800
Message-Id: <20230311173513.1080397-1-robdclark@gmail.com>
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

Inspired by https://lore.kernel.org/dri-devel/20200604081224.863494-10-daniel.vetter@ffwll.ch/
it seemed like a good idea to get rid of memory allocation in job_run()
by embedding the hw dma_fence in the job/submit struct.

Applies on top of https://patchwork.freedesktop.org/series/93035/ but I
can re-work it to swap the order.  I think the first patch would be
useful to amdgpu and perhaps anyone else embedding the hw_fence in the
struct containing drm_sched_job.

Rob Clark (2):
  dma-buf/dma-fence: Add dma_fence_init_noref()
  drm/msm: Embed the hw_fence in msm_gem_submit

 drivers/dma-buf/dma-fence.c          | 43 +++++++++++++++++++-------
 drivers/gpu/drm/msm/msm_fence.c      | 45 +++++++++++-----------------
 drivers/gpu/drm/msm/msm_fence.h      |  2 +-
 drivers/gpu/drm/msm/msm_gem.h        | 10 +++----
 drivers/gpu/drm/msm/msm_gem_submit.c |  8 ++---
 drivers/gpu/drm/msm/msm_gpu.c        |  4 +--
 drivers/gpu/drm/msm/msm_ringbuffer.c |  4 +--
 include/linux/dma-fence.h            |  2 ++
 8 files changed, 66 insertions(+), 52 deletions(-)

-- 
2.39.2

