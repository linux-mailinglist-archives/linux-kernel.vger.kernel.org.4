Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA7B67CFE3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjAZPSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjAZPS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:18:27 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9AB30FD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:17:48 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v13so2121271eda.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqTPYHx/hvizibC2oIfeh1taRPi/dzef4/4GDfwh7Dc=;
        b=KsgaCMzJGUttXQbMZMLFzqt5edS2JcAVI4+R1nFjny115+xCxVFm9Kv/SLnAzTzI+E
         qNGehiy4EkCTNEAe1345QISl0Q0j2ZnUD78xWmYuc3+dBajuWDZyoEOqu8fLkfJa55UX
         4L9xUKNkjnZWbB0qsV1/L1rFSNzvnY9609dhOZ2MqvpLpw/JNlAvah0sQgwQdrbXehi6
         SXDrYzDh+9vZPZWsZOxiY9ybCMO5MkxhZUC4IrY4ibe581wfYo5gnT2zxP9g4ZB7mjH/
         UAqKu0fISq5b09kZoSASxmyq3l3UDjzk0S443DyTsvkuI8w+30YDo56q5TM2y/ugNCPH
         ufrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqTPYHx/hvizibC2oIfeh1taRPi/dzef4/4GDfwh7Dc=;
        b=8Pe9t0eEYmOGQNpdmSmagWkpeVwz8Qzej0PKiNvLQRi3m3T0tKBsaPXl1CiBio3+EB
         nJIExziwHtSaZ2+SHGCtqOsbfeW1pukJg13ubH1tPkZAaqZJWKkeRc1cJV9SSgIEq73i
         lljeyWJNTzmBRQUnwpSIvzWicDknYPDvhGghwdMhK5icCirGejYwc3iyPlA6iIYWUKpg
         2b0eUcASqsRsfCzCgvdWByRGRQ/PKiUQNnvhGYtX2oM0FvY0ZPmd7ubetFwDtoLYnYLq
         eMe/rg7Z2yjVSKz2TiRMaP1T3iQuBVf5tIokzWuPAOwLjVnPi2NaS+Lpqhlr8Cn48vcH
         5vUw==
X-Gm-Message-State: AO0yUKU7sPuSv0D26MCnfY6o3iiCqbnspzK53FrhO07fSfMcfzTAhhdG
        OL5fuFtFIzgA679bNN36gzQD/A==
X-Google-Smtp-Source: AK7set9j/7oS+bafs6ZfNNGeVHpGPgbFsEu7Z9kE7S+kC33GSD1Ulk89vyxivtHiPxAmpydf06Xfng==
X-Received: by 2002:aa7:c149:0:b0:4a0:91be:1db6 with SMTP id r9-20020aa7c149000000b004a091be1db6mr8227773edp.16.1674746245170;
        Thu, 26 Jan 2023 07:17:25 -0800 (PST)
Received: from localhost.localdomain (abyk108.neoplus.adsl.tpnet.pl. [83.9.30.108])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm842808edr.28.2023.01.26.07.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:17:24 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] drm/msm/a6xx: Remove both GBIF and RBBM GBIF halt on hw init
Date:   Thu, 26 Jan 2023 16:16:08 +0100
Message-Id: <20230126151618.225127-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126151618.225127-1-konrad.dybcio@linaro.org>
References: <20230126151618.225127-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we're only deasserting REG_A6XX_RBBM_GBIF_HALT, but we also
need REG_A6XX_GBIF_HALT to be set to 0. For GMU-equipped GPUs this is
done in a6xx_bus_clear_pending_transactions(), but for the GMU-less
ones we have to do it *somewhere*. Unhalting both side by side sounds
like a good plan and it won't cause any issues if it's unnecessary.

Also, add a memory barrier to ensure it's gone through.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 22dac65cfa8c..158d6453cf3e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1004,8 +1004,12 @@ static int hw_init(struct msm_gpu *gpu)
 	}
 
 	/* Clear GBIF halt in case GX domain was not collapsed */
-	if (a6xx_has_gbif(adreno_gpu))
+	if (a6xx_has_gbif(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
 		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
+		/* Let's make extra sure that the GPU can access the memory.. */
+		mb();
+	}
 
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
 
-- 
2.39.1

