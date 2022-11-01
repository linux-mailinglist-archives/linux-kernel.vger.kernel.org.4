Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3424A61551C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiKAWej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiKAWdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:33:46 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C338EEBE;
        Tue,  1 Nov 2022 15:33:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v17so11870105plo.1;
        Tue, 01 Nov 2022 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jGENntLfOCR8ozrjU0gP3ahdz7LS9qRpY/T4IjONjfE=;
        b=ePNbBYmMrBWf14035Ml6F9See1fo11rsu5nojA/frdjk6+kB6ylOkz0WOOtInV2YUw
         k8uE+nlZiPdngARdYCJel4lYD1k+mFF16JBtSIQVlx4ueuc9jPQ32mrSme0y5RRIAxod
         MiZF7abfG/tVvGmF/f338+N2d2SQvzMqQsOtLT6bAAh9v4qcDeOrI5nHi4RkFEGcnWKz
         cf0KCti865++nvT9QL0QhYqqUQttK8NWlxZt0PRJC/ojNhtqDzjxIgR57Q4C+uSGJ4HE
         Z/Di7T9DiUE/eVPhAiyZ/rzyTvj7RlWXaXA06Lpsa3Ko91F2mXRuVPUD3ux/O7VKooUi
         VOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGENntLfOCR8ozrjU0gP3ahdz7LS9qRpY/T4IjONjfE=;
        b=FYayfl4qZ7u/q6V+GPf3aUpFhVmQIXZE7kKYBxaHhjTQGflQ82isEroCsU+sDqkH+C
         NpJAtMTnrqn2TJPNdWQXv55nNuZsJqu52tAIwzU4a+vkkFW65d2EfbZ3GjC3NgcYd9l2
         Pz2OKWm3FM8sP95QmP4SR+GHFYFQA8tHKe9B4UacWMqHrI9SiKRXA480rMA9C6rF0+c6
         85a8h8d7UpRlPpKZ3Pw5Yk2Oq6ExSsYvI62Ut4LBuNFobpdvRFkCL7G8MAxmudo2e5Vo
         LehItGA8HVPKL+ZMMV/ViYDTJ0VcXoYpq0JvIE6r7ft6gpGk32k/xWRaN1J5C4cRo/Jg
         RJ4g==
X-Gm-Message-State: ACrzQf16juoVJZ4S471QHSLDqKOedzUCkY4hUnqc0eESpBUebwEjOeL3
        gOzajz6qPpxgFWLN45mnmvk=
X-Google-Smtp-Source: AMsMyM7RCutusfpBemA0YCYWXd5vhzuK8RyIImMWAWCB3UJilDp/SJYM0ty/SZsO8O7AN1t1HSfQkA==
X-Received: by 2002:a17:902:e8c4:b0:186:6d63:7e with SMTP id v4-20020a170902e8c400b001866d63007emr22106758plg.122.1667342025099;
        Tue, 01 Nov 2022 15:33:45 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c3c400b001754064ac31sm6821074plj.280.2022.11.01.15.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:33:44 -0700 (PDT)
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
Subject: [PATCH v2 0/2] drm/msm: Improved hang detection
Date:   Tue,  1 Nov 2022 15:33:08 -0700
Message-Id: <20221101223319.165493-1-robdclark@gmail.com>
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
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c       | 43 +++++++++------
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c   |  4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       | 58 +++++++++++++++------
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  3 +-
 drivers/gpu/drm/msm/msm_drv.h               |  8 ++-
 drivers/gpu/drm/msm/msm_gpu.c               | 20 ++++++-
 drivers/gpu/drm/msm/msm_gpu.h               | 17 +++---
 drivers/gpu/drm/msm/msm_ringbuffer.h        | 24 +++++++++
 9 files changed, 131 insertions(+), 49 deletions(-)

-- 
2.38.1

