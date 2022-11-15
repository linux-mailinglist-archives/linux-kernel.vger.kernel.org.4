Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFAB629A55
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiKONb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiKONbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:31:19 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67883DFC5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:31:17 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s12so21838772edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrGveRHtb758Cq8dNpj5YeNPoOq0dxmeWZsx/PFkuqU=;
        b=U3Lu6RQx8ai/jJm4ibT2pDLvRLRyr0a0Pi5ndEpjjtGQR24t0cShQmbGk0IeNjW14W
         6QlkSm8oNE4aqWl7pmxflwBCtCPZu2wA5WUDYdkfZ9nlb+Tc3CoMAzpjVVd1A8wJOVKc
         9esdf52FG/qsDUiNb2tFGU46BsKQWjqntwIKwqd4KASMXAfu23WF8iDqnGFizdG41WQM
         XC8tnackopXr90tiUkOUOgYhLYgd3qbSYgIcIxJbqwmXy4Jbz4HBQ8XZN9wRcqSKUcgQ
         g3mhkn4o5Gk22t82pKKIHu40sz6Xs1m76WiF2sNdT4hqyBlTIW30yleMYBNb1wxlYsHx
         Jd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrGveRHtb758Cq8dNpj5YeNPoOq0dxmeWZsx/PFkuqU=;
        b=DzJr8UZ7yqeZuzl3xmlbNkgY/n8DXAIrroFdXh3c3F7saZMU4aWTAJ84fG/ylET7ll
         ZF769+P7Sdekm1y8Y4sAldYDmOY+ZQdCY92rnq0vtJlRyDouV6dNmJ1hKVlKxZaUi69c
         6I8y+ALHfMjLXweNwiv89dju4O0sZZQgTZHJtjt6lIt9qeaDN1t0MtAJfcHRI/ULN6lx
         zIPPwpFQY2dIBdTydn+KDA60+v79kD+jOX+yxBzD+l604+87QzURcuRFT9PjLMzQKhLu
         5pboIC44sX7X2mwm4zeymymL3NdQ8ldP1e+tkwwRVkBjs5HTohjOU26GpVsCRi442yEy
         HWxQ==
X-Gm-Message-State: ANoB5pkYfaQHi0+9PbMI+HKEFFeqG3KAGnGyBVNGJQ/6mAnxHjnVvLhE
        XKHHacBNSBvM4yiDC2BTukfEBA==
X-Google-Smtp-Source: AA0mqf5IglNWuhzmLuEOo1wEUQKN3RLItrJFb/suDsHE2tWdBZYCnN5udverXmrzIjmoIegD5667kw==
X-Received: by 2002:aa7:c90b:0:b0:467:4b3d:f2ed with SMTP id b11-20020aa7c90b000000b004674b3df2edmr15219917edt.101.1668519076868;
        Tue, 15 Nov 2022 05:31:16 -0800 (PST)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id q22-20020aa7d456000000b004618f2127d2sm6162176edr.57.2022.11.15.05.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:31:16 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        quic_kalyant@quicinc.com, swboyd@chromium.org,
        robert.foss@linaro.org, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, quic_khsieh@quicinc.com,
        quic_vpolimer@quicinc.com, vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org
Subject: [PATCH v2 03/12] drm/msm/dpu: Refactor sc7280_pp location
Date:   Tue, 15 Nov 2022 14:30:56 +0100
Message-Id: <20221115133105.980877-4-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115133105.980877-1-robert.foss@linaro.org>
References: <20221115133105.980877-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sc7280_pp declaration is not located by the other _pp
declarations, but rather hidden around the _merge_3d
declarations. Let's fix this to avoid confusion.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 4dac90ee5b8a..8f2d634f7b6b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -1294,6 +1294,13 @@ static const struct dpu_pingpong_cfg sm8150_pp[] = {
 			-1),
 };
 
+static const struct dpu_pingpong_cfg sc7280_pp[] = {
+	PP_BLK("pingpong_0", PINGPONG_0, 0x59000, 0, sc7280_pp_sblk, -1, -1),
+	PP_BLK("pingpong_1", PINGPONG_1, 0x6a000, 0, sc7280_pp_sblk, -1, -1),
+	PP_BLK("pingpong_2", PINGPONG_2, 0x6b000, 0, sc7280_pp_sblk, -1, -1),
+	PP_BLK("pingpong_3", PINGPONG_3, 0x6c000, 0, sc7280_pp_sblk, -1, -1),
+};
+
 static struct dpu_pingpong_cfg qcm2290_pp[] = {
 	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, 0, sdm845_pp_sblk,
 		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
@@ -1352,13 +1359,6 @@ static const struct dpu_merge_3d_cfg sm8450_merge_3d[] = {
 	MERGE_3D_BLK("merge_3d_3", MERGE_3D_3, 0x65f00),
 };
 
-static const struct dpu_pingpong_cfg sc7280_pp[] = {
-	PP_BLK("pingpong_0", PINGPONG_0, 0x59000, 0, sc7280_pp_sblk, -1, -1),
-	PP_BLK("pingpong_1", PINGPONG_1, 0x6a000, 0, sc7280_pp_sblk, -1, -1),
-	PP_BLK("pingpong_2", PINGPONG_2, 0x6b000, 0, sc7280_pp_sblk, -1, -1),
-	PP_BLK("pingpong_3", PINGPONG_3, 0x6c000, 0, sc7280_pp_sblk, -1, -1),
-};
-
 /*************************************************************
  * DSC sub blocks config
  *************************************************************/
-- 
2.34.1

