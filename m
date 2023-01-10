Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B451664FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjAJXOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjAJXOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:14:45 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E7812AC8;
        Tue, 10 Jan 2023 15:14:45 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so15197909pjj.4;
        Tue, 10 Jan 2023 15:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kYQIennFxviwmYcSwf3vI6zjgdWqQpoESJjvtOEJngs=;
        b=QylWbY3EZHiwSX6vZUzNyhSVz8+6G5nB1q7XGH8P5SjVkZB+xBLLjm8cAJ+yqXI1mG
         yiPs5wWwRekqoHiWIeruX4iqoYQoT5zJOz1GiHaZRzo7XWFIaXaYgmoRZFrfv8UUvJA7
         dwECbRABKNDAnPIWp8iVqes5kS/QhHqkE8m/OgMBFSq9RZAixW2Yqd3EVz4bAtvI9I5A
         aH+Q/0fix/+uisYg0Q5xITINRZiRN2Nr5dsEf4xxHHvRsV5I6IOBt6vktYewLt4EnY+l
         UDGrL3KRDfSgcW3AUuEhFG9VEWgVs1yHOQikB/Hsfh82le238JnphMN+cSM/51KWKfM+
         +VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYQIennFxviwmYcSwf3vI6zjgdWqQpoESJjvtOEJngs=;
        b=ItJYYeEkqb3/KEoU+DlrR49Od4DtNWNt7tfnYW+NtHHsf8VFDtVA4VEEqy2YTT2/wm
         r3WEyCZjNyOw8tCWcMD26IZTftKaz3FlJAE/U3vMJKC8eLc+mtc/wGNeb5X1iTdwCbbw
         wp5en+kubb8WzWimXHjsk2LJf5U8/6Tqs3uXFBa6WowRxihMQHB1zEfO0bWsLFMsO7h+
         doBe0OX0mt9i4miyt0+pSOeyV9XsljdwD6nj/SwSwQM44quLdLI2gIhMbQ0mc+go8uBo
         Yue2GrvzLY2Zou1dV9QDHEiUk65zIyW1YgPq6NyzO6pFHJXU9M+M8/FKXSDmM2GdBI+7
         F/pw==
X-Gm-Message-State: AFqh2krzv7+5RieyXyeZpqLOnWkzSrayBOWbtlwvg/z8VhAuzXhizZVj
        SGPNJi4YRC8h0+urJzYiTRM=
X-Google-Smtp-Source: AMrXdXuVr4+jnHInPBlky23R9pRNdzS5jz+U1t8ZEFU1/iKc1c6EHE7KAU090kQNoD+lqHx2oud4Zg==
X-Received: by 2002:a17:90a:5791:b0:227:1c85:f5f4 with SMTP id g17-20020a17090a579100b002271c85f5f4mr7019607pji.5.1673392484574;
        Tue, 10 Jan 2023 15:14:44 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a098500b00216df8f03fdsm9379409pjo.50.2023.01.10.15.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 15:14:44 -0800 (PST)
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
Subject: [PATCH v2 0/3] drm/msm/gpu: Devfreq fixes+tuning
Date:   Tue, 10 Jan 2023 15:14:41 -0800
Message-Id: <20230110231447.1939101-1-robdclark@gmail.com>
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

 drivers/gpu/drm/msm/Kconfig           |   1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c |   2 +-
 drivers/gpu/drm/msm/msm_debugfs.c     |  12 +++
 drivers/gpu/drm/msm/msm_drv.h         |   9 ++
 drivers/gpu/drm/msm/msm_gpu.h         |  15 ++-
 drivers/gpu/drm/msm/msm_gpu_devfreq.c | 148 ++++++++++++--------------
 6 files changed, 100 insertions(+), 87 deletions(-)

-- 
2.38.1

