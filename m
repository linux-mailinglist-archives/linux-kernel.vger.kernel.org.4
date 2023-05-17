Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9734706EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjEQQuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjEQQuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:50:21 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AD555B5
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:50:20 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ac8cc8829fso10240681fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684342218; x=1686934218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSc4FWFPOC7I3VWo73gY6L/30rahECGBPz2uIJ+lIl8=;
        b=BD8AfYiBBLe/6Sigf9ZlRzi45spq2zvlb9stWhpy/B76+Jo9AW2w/rG8iX61pPBnMm
         TbkSE/bggMhlhsyxikrySK76J+/Ie+K+tcMI2+yT83I2H14Sq29eGSisfEYP4ucH6vjK
         +tRAm4kWroqXMMX3aLcWDnnYuVCymm5tk8FFHMWTwf7rzAW/HOoytDQIvoHIPOH0r+ao
         hOOxeWGkadd65nhQ5uMROg0B69Wg1SH/aafUlEDnOe9tXgZ4Npo+XT7nOnFCNJSSnUKX
         Ci5vHMFUQ6ZoP66qkzuGc4PMeLBhTlrrbX9IJ9oyvNZnyqwxiovbQRVb2fzG64wUEKPT
         R/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684342218; x=1686934218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSc4FWFPOC7I3VWo73gY6L/30rahECGBPz2uIJ+lIl8=;
        b=LhOOLIlCbNPxezHzNqlEAUdv9gxw7lTgyXyVonh7w0yr2iKDCmFEyB4dDYDGnnYxMV
         /PiejqG4Nyx/2gn0VsU1l7Zj5h9Cr3A4yG/1Hh56YE/jSDNPVwp+Iqm3ZDM6/EvTOWNS
         fd3ae9c8lsHAocqrH54uWXsGxn/ZYo7Ttvsni8R+xr/eb+fxSaZop/6qxS38nGEE3hGZ
         QHi12VHF7xrqeJy3QkV0oNi0a+k1GhcQnrWhY0gXnS99PJMSEiBpdeJn6Lw03g4WLltr
         NPu7vTKNo4G7VCX9uBgtk9PAbD5QSQpYCuvE23/cxNZuUVtbgcSkkfBm+Q+XPTnMCpXp
         akQQ==
X-Gm-Message-State: AC+VfDzg572V8EHi7C6V9qympcaxpGbZE19Y7yXUxm9/afC6XB/gMnOx
        taKI33Byl6gl0wcTNqF6lxO8dg==
X-Google-Smtp-Source: ACHHUZ6FaHQHgcfK2D22hwdfeZnqMr16EgduhClje7jaP2zHD6BkuFkOVZcicAq/MtCp+EGdtBFGfQ==
X-Received: by 2002:a2e:3012:0:b0:2ad:983c:3453 with SMTP id w18-20020a2e3012000000b002ad983c3453mr9404123ljw.5.1684342218479;
        Wed, 17 May 2023 09:50:18 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id g6-20020a2e9cc6000000b002af0e9abaf6sm159224ljj.131.2023.05.17.09.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:50:18 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 18:50:10 +0200
Subject: [PATCH 3/6] drm/msm/a6xx: Ensure clean GMU state in
 a6xx_gmu_fw_start
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-a7xx_prep-v1-3-7a964f2e99c2@linaro.org>
References: <20230517-topic-a7xx_prep-v1-0-7a964f2e99c2@linaro.org>
In-Reply-To: <20230517-topic-a7xx_prep-v1-0-7a964f2e99c2@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684342212; l=1213;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=AafR4gmpdLdCW49giEqj+iQDIXWZqQQlcHizyhfpHRg=;
 b=BhCdzTabSPUF9ByKOuuSnx0F7aPAwFydWOHefDYIo9iawEJ0RnTP/Cui8OHVcudCT+qo1U893
 IYCczZPwG9FAeeywaBmx4XWmqx/x1vTG5047BD/4b/JOC20BN7uYaX6
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While it's not very well understood, there is some sort of a fault
handler implemented in the GMU firmware which triggers when a certain
bit is set, resulting in the M3 core not booting up the way we expect
it to.

Write a magic value to a magic register to hopefully prevent that
from happening.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index e16b4b3f8535..ea6d671e7c6c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -796,6 +796,12 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 	gmu_write(gmu, REG_A6XX_GMU_AHB_FENCE_RANGE_0,
 		(1 << 31) | (0xa << 18) | (0xa0));
 
+	/*
+	 * Snapshots toggle the NMI bit which will result in a jump to the NMI
+	 * handler instead of __main. Set the M3 config value to avoid that.
+	 */
+	gmu_write(gmu, REG_A6XX_GMU_CM3_CFG, 0x4052);
+
 	chipid = adreno_gpu->rev.core << 24;
 	chipid |= adreno_gpu->rev.major << 16;
 	chipid |= adreno_gpu->rev.minor << 12;

-- 
2.40.1

