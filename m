Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E856649D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjAJSZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbjAJSZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:25:20 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D5D8E9B4;
        Tue, 10 Jan 2023 10:22:05 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 141so8850101pgc.0;
        Tue, 10 Jan 2023 10:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ogmFOZWIzMj+3duLrX2EZxxcGOpiQSLfwLDfrMyX4OM=;
        b=iTBfyH3WDaC7OnWboyWtpdRAh2d4mpfK+qixKoD9Q0ueYMxJIRO2z6FJCJhJl+tyKb
         FXzKhD87IMvMRgbJlA3TPk7VHbUW+NH+kFN6Uzjy2dXkUTtyVUkjGdjGBkbZIELB6Xq9
         yanOd9AyVREOZyuM1AlouGJO6wdflEYt5lHTemDontXABXAK2fp/pEzB1FyTZizl/Yy4
         GxO/FX3h9RQTiKwW0hfNkyT4aFyDj41XGvYoGKmuV9liaoyvM6x5+xNwY/Khd/XUtWjy
         gWExAJSr3G3rJGMGIs9E3mhcVvY7yDIJNKSGySbH5d7XhZodjW5E8hAJQjXjePueeMyw
         aCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogmFOZWIzMj+3duLrX2EZxxcGOpiQSLfwLDfrMyX4OM=;
        b=nVkDw8FoQvmQ/eZuLwbj6tsaFkyxTxIT3ghKoaRnv6KbvhrIIq2XtgPcvWPph0MlWn
         PmOX4saJnUqdWI1/8j06BQNXQtSaN35Y6yaFlUA8ycyPrblHfhwVmlwW8tR0gzKmSNuV
         BumfVZUh1yPPEU1tSpj93/Qyz1X6u3C3zvX8WismKjR+RGvxtQFIBy8qaeoZ0LxgGUFQ
         EUFm6UvQfDGv5RE+afH5OfJTkpDZ5DQpXi9R+8mwtdrIxNTU8J3K/7RqWwv8dhGkwaSt
         kJEkO0D8c5gB2Sv8JHpXaN9/c7CDVwm0ynhjFSaZ50RJ/9roRoXQNn/SR7ZmiIP/xuZ6
         pS9w==
X-Gm-Message-State: AFqh2kpLxZ6oROsZDZyBksA8UsTD/xFXjv6XOVwmhIZrNXbKTxrwsGyB
        cWqLmi71D31m6r2NzDZEC20=
X-Google-Smtp-Source: AMrXdXtQ5GUYXPLIFkdMD5Z6fjHsPDPbiLd3VACxOqDo5SU3z6yDVttD03dV+GYCTOyCEd7P0t0WUQ==
X-Received: by 2002:a05:6a00:c5:b0:582:6173:c6c5 with SMTP id e5-20020a056a0000c500b005826173c6c5mr36566828pfj.14.1673374924464;
        Tue, 10 Jan 2023 10:22:04 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id a28-20020aa78e9c000000b005774f19b41csm8369815pfr.88.2023.01.10.10.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:22:04 -0800 (PST)
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
        Sean Paul <sean@poorly.run>
Subject: [PATCH 0/3] drm/msm/gpu: Devfreq fixes+tuning
Date:   Tue, 10 Jan 2023 10:21:44 -0800
Message-Id: <20230110182150.1911031-1-robdclark@gmail.com>
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

Rob Clark (3):
  drm/msm/gpu: Add devfreq tuning debugfs
  drm/msm/gpu: Bypass PM QoS constraint for idle clamp
  drm/msm/gpu: Add default devfreq thresholds

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c |   2 +-
 drivers/gpu/drm/msm/msm_debugfs.c     |  12 +++
 drivers/gpu/drm/msm/msm_drv.h         |   9 ++
 drivers/gpu/drm/msm/msm_gpu.h         |  15 ++-
 drivers/gpu/drm/msm/msm_gpu_devfreq.c | 148 ++++++++++++--------------
 5 files changed, 99 insertions(+), 87 deletions(-)

-- 
2.38.1

