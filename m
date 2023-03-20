Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69ED46C20B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCTTCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjCTTCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:02:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F8F3D919;
        Mon, 20 Mar 2023 11:54:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d13so13225204pjh.0;
        Mon, 20 Mar 2023 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679338461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e7SOUWq19KHl9pAXwlvUo3lhcDDEgQm+oF8TmF0uNlg=;
        b=MVK8SzRElpv99qoW4uCh2e3Anb9Up80En9f7QGrYRLGbvgHkg9thBuZMqpVtudo3qz
         O9h1KEt7r/xEg6KbpRIuh3kewbAIIyjrUA+9gIC7vBjxtLwYwvz7SCHO6KKF5Ki9kAHB
         J+Hk0IXaekXqn24wqDiSOjWZqjdl66EW6V+u6RbYSMhLNP2b56aGVWRbs3PmOR0DwbaH
         /cNcFVGH7EhKza5pAL77lnFwY8EkhlrcnCOzSO96/zaJs0ky7HUIWXkgow/nisSLLN5A
         3gO0gJ8dNaYULNvPwMFCT2X9i1LrbD4lAQML7SmHAVvNOIpFNOIu6I0F6b6WpacWZBfu
         6USQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679338461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7SOUWq19KHl9pAXwlvUo3lhcDDEgQm+oF8TmF0uNlg=;
        b=zVQATpsoX4GLIsYmLlCmyN7+oXcJ5SNGMJ36UQmEAUixKma48M21Kn8uEWbVsQQUnT
         YtyhjYx5Ef6GrDgt7FnfUaCG+t3iME1BZvC9v0767hemyFLoKdklIgP7sZlagJ+SPaI2
         R9kcHZQTQpMS3z3TMk0wLn39aV2C284VF/e0v1IFRjarcuJrAFaAztOFiCUcgXi2C2Qg
         TIb/r14AFvnYQFMTYAyZD+dB3YL3QzoVSc87SVogdIWdSWgS1gbo6lGc7U3gCwD5YmOW
         KmLJ20u7l29XIv5+FoR8j1kiqVP73+B3T1c2PhRcdwVGmVZ6hiamfUltN0c6mfROsBNS
         J2zQ==
X-Gm-Message-State: AO0yUKUpADivbaa2rRXjV5gz7z3btaY3hfLbp0TrdJy2GtlC2JtxQ+ob
        XkAMgoauH6CM4f9AAg4WACfVk87rTx0=
X-Google-Smtp-Source: AK7set+KXQUBNJrPFz4KWD3QvDFqwgQqpFC8XJrTFnBiXGyx9ShsF5weoD9AtU/uJIMDG4F/+bOndw==
X-Received: by 2002:a17:902:e807:b0:19f:2e2b:3577 with SMTP id u7-20020a170902e80700b0019f2e2b3577mr22175098plg.41.1679338461283;
        Mon, 20 Mar 2023 11:54:21 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902849800b0019f27fd7cecsm7051443plo.197.2023.03.20.11.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 11:54:20 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/msm/a6xx: Some reg64 conversion
Date:   Mon, 20 Mar 2023 11:54:13 -0700
Message-Id: <20230320185416.938842-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
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

The next generated header update will drop the _LO/_HI suffix, now that
the userspace tooling properly understands 64b vs 32b regs (and the _LO/
_HI workarounds are getting cleaned up).  So convert to using the 64b
reg helpers in prep.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 89049094a242..f26e258c6021 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1053,12 +1053,9 @@ static int hw_init(struct msm_gpu *gpu)
 	gpu_write(gpu, REG_A6XX_RBBM_PERFCTR_GPU_BUSY_MASKED, 0xffffffff);
 
 	/* Disable L2 bypass in the UCHE */
-	gpu_write(gpu, REG_A6XX_UCHE_WRITE_RANGE_MAX_LO, 0xffffffc0);
-	gpu_write(gpu, REG_A6XX_UCHE_WRITE_RANGE_MAX_HI, 0x0001ffff);
-	gpu_write(gpu, REG_A6XX_UCHE_TRAP_BASE_LO, 0xfffff000);
-	gpu_write(gpu, REG_A6XX_UCHE_TRAP_BASE_HI, 0x0001ffff);
-	gpu_write(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_LO, 0xfffff000);
-	gpu_write(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_HI, 0x0001ffff);
+	gpu_write64(gpu, REG_A6XX_UCHE_WRITE_RANGE_MAX_LO, 0x0001ffffffffffc0llu);
+	gpu_write64(gpu, REG_A6XX_UCHE_TRAP_BASE_LO, 0x0001fffffffff000llu);
+	gpu_write64(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_LO, 0x1fffffffff000llu);
 
 	if (!adreno_is_a650_family(adreno_gpu)) {
 		/* Set the GMEM VA range [0x100000:0x100000 + gpu->gmem - 1] */
-- 
2.39.2

