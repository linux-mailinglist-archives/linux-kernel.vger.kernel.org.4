Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEC0732375
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbjFOXWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbjFOXVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:21:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95AE2D57
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:21:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f845060481so1674239e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686871292; x=1689463292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3aBLLbacTh+Ex0pHk2CQnOlcKWWCMhpUkJM7hf2NJ5E=;
        b=pQO28YupZ9aQNmPH57PCXKbJ7ClPx9R1cSV4mAVW+5eLTWiXUmsNKoirLZy4DR7DgN
         IQRYHL8ZMpnexAqMsly1t4iumFD081Iw6mrv313VThuAodq5nIQ+cr2JszLerO9N5fUf
         XioSLLQc42j1rZd4rz6+U3sudyX9DlwA3KwIvrTCfEfdlLMaJautR4UuunWxnWdQG1R0
         Sdp2z7V9kYwDfXKkUELtOYAu++LQ103aGLurNt+y91vWJd4BhsLMD6lkASUmVXpCQp0x
         Cxe48vDsVBteyrJ2Uz7ns+8sdlnjmPMdX1kT9JA1e3gW5Pkpux+jYkIXo/Wu14aE1bV/
         Dorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686871292; x=1689463292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aBLLbacTh+Ex0pHk2CQnOlcKWWCMhpUkJM7hf2NJ5E=;
        b=ImCpwBtdo1A9W5D0YR2/p94J5PZja4IfZHPjZxTEEIFfohoxbkIKfSEBxRHz4oRVqi
         Mg7Hr9s2riRqUdMIwWIxTtrJL9ac+mViX/nQbCbFXSqVi9Qe+PIJiA6AdhapQdQhnQPG
         wWhyFngCASV3pDKC8K7Npn8V5Gjf5BcYntTCKdhtYZTgbVtDmcY9oSsyVwcNM40SvMNG
         x+Bv54GFGj4tLxFOJnsyQ9TcUi5lwvMM82qYGgMKFTXwGHnqXe9mUHHHNkaU9y+GPoo5
         2NON6NAT2VZ1sL9S7GUdemhMn66QVdOHLW4kDu2BiUWwg8jWHdaTVzF2qZLIaeJL6cpK
         CoDw==
X-Gm-Message-State: AC+VfDyEsMw/tjYhlytqAKHqHJ16ZDKzR7+C96Vwq7HuDzbe57WpLuQH
        p6euPInl63w7I4S8TaeedlewEA==
X-Google-Smtp-Source: ACHHUZ6uSakf1tY4JEIXkQ0gM3/D3sQL606O7CbVblONG2RLtbxQfY630L3KUjtWs8Od6iZ8M4iS8Q==
X-Received: by 2002:a19:4f56:0:b0:4f7:6a7e:f079 with SMTP id a22-20020a194f56000000b004f76a7ef079mr93019lfk.31.1686871292167;
        Thu, 15 Jun 2023 16:21:32 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id u25-20020a056512041900b004f24ee39661sm2744852lfk.137.2023.06.15.16.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:21:31 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 16 Jun 2023 01:20:50 +0200
Subject: [PATCH v9 09/20] drm/msm/a6xx: Remove both GBIF and RBBM GBIF halt
 on hw init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v9-9-890d8f470c8b@linaro.org>
References: <20230223-topic-gmuwrapper-v9-0-890d8f470c8b@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v9-0-890d8f470c8b@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686871277; l=1283;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mn897aEmmor9k1FnbUx226+ojITBGwyH7cFTcD9yASI=;
 b=gtQN0aOUrpE5N6ygJFNwpAMGUaAS5m1yMnYkP9WZlpYHW2rsdM5BsDSIgdCIKhJ0JgiI3IihR
 ow8xjMnR/wYDUV6MSxRwx9w2Cdu1vFlojj4aomXy5dlDrNtxUka8bXX
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we're only deasserting REG_A6XX_RBBM_GBIF_HALT, but we also
need REG_A6XX_GBIF_HALT to be set to 0.

This is typically done automatically on successful GX collapse, but in
case that fails, we should take care of it.

Also, add a memory barrier to ensure it's gone through before jumping
to further initialization.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index b627be3f6360..7e0d1dfcd993 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1111,8 +1111,12 @@ static int hw_init(struct msm_gpu *gpu)
 	a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
 
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
2.41.0

