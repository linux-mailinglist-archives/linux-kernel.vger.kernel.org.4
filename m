Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E4A67CFEE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjAZPTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjAZPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:18:34 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5AA13D48
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:18:01 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u21so2158187edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J6qSh0efJGQC1MdRpa8Z3puyGuNa/niO8IpMDoxAfU=;
        b=pgynMWONfLhM61AbGHvi2BqAJ5J1Xt0lJIRNd/X3V5KTx68IDG7Ky0q4fF0pnxAirZ
         ZTn+DfEhyoj5Nv7pPRd/QmSIXXVWI3tBLs5M4n3pvP2noMVNbxKRcSKtSx/htcVx57Ad
         6KX+ZcodRD05XU+bzH12czdbGOINh3lSYD5jhNLIodffWAwKURvSHuyDc8NFcIDa7Fi1
         vz0mskAVszXseJHgNPHTN8bGBobsQKl2i++0IFFaEjTrsjsr9To2Ikc264uNXbECE7o4
         JNATj6hWF0r+x2S86y+2rADvINXibz9y+84Wz3yZ8yuoqJkL5M3w/LjyRK+q5FfDSONf
         M4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6J6qSh0efJGQC1MdRpa8Z3puyGuNa/niO8IpMDoxAfU=;
        b=OiFITUmNpgjeyw7nusyF65e2JVAX9Iy+Im34/Ta4tiDnF7vTFn0ZybLaRg36flVOH9
         kWSAY7wpUI9YKPHhVEG9wlQAN/IVLWLX9tcvh6QbvGO7kZ6QE77leV+oDW2svsb3oeYT
         P8tasATiSE8zokgOexIoTydt5wcFTf0Vf38ORYkNNtQhMb/koTLIPj6dO3un2T/Cm42X
         9ETaTPyEhLmfGVChKB8Oy2cPdiAg4Ypy+wjoxQ9n0agaV1JrDQ2gcb1UNUlxgpqcV3m+
         Hhdqiuwuspl9ibXdkTIPmJ95aWJpzwYvqc3g3zef/G2hlV9mU9AyB7pLm52bqQXBi6kD
         jORw==
X-Gm-Message-State: AFqh2kopZFeUTJkYLsiHB7y2rw/Sk9LcN43aDeIo+Pd3qjHu+LuhozVu
        SIgs+OgFLX7TBjNdkbyh2VW2aw==
X-Google-Smtp-Source: AMrXdXtDsZVGSrVLYoAVLMYnDBYZRSw+ViON3LaOdYRhs80oYnWCOTOQHlrNOkOo7kP/6sPNcnM/Ew==
X-Received: by 2002:a05:6402:27cf:b0:488:e7ae:5cc4 with SMTP id c15-20020a05640227cf00b00488e7ae5cc4mr45916885ede.41.1674746271060;
        Thu, 26 Jan 2023 07:17:51 -0800 (PST)
Received: from localhost.localdomain (abyk108.neoplus.adsl.tpnet.pl. [83.9.30.108])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm842808edr.28.2023.01.26.07.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:17:50 -0800 (PST)
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
        Jonathan Marek <jonathan@marek.ca>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] drm/msm/a6xx: Fix up A6XX protected registers
Date:   Thu, 26 Jan 2023 16:16:14 +0100
Message-Id: <20230126151618.225127-11-konrad.dybcio@linaro.org>
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

One of the protected ranges was too small (compared to the data we
have downstream). Fix it.

Fixes: 408434036958 ("drm/msm/a6xx: update/fix CP_PROTECT initialization")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index f34ab3f39f09..62f504ed7ef5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -690,7 +690,7 @@ static const u32 a6xx_protect[] = {
 	A6XX_PROTECT_NORDWR(0x00800, 0x0082),
 	A6XX_PROTECT_NORDWR(0x008a0, 0x0008),
 	A6XX_PROTECT_NORDWR(0x008ab, 0x0024),
-	A6XX_PROTECT_RDONLY(0x008de, 0x00ae),
+	A6XX_PROTECT_RDONLY(0x008d0, 0x00bc),
 	A6XX_PROTECT_NORDWR(0x00900, 0x004d),
 	A6XX_PROTECT_NORDWR(0x0098d, 0x0272),
 	A6XX_PROTECT_NORDWR(0x00e00, 0x0001),
-- 
2.39.1

