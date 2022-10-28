Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EB66110C1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiJ1MI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiJ1MIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:08:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CDE1D3C41
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:08:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q9so12551390ejd.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UwiNY00/B1wEnev9eGZy7ZKGi1I0cycL/iCTh2NCnA=;
        b=WFhXjhcB/pX6k4XKVx6xAYZLBxEgJdoEEs9MDz3R7vvSnjTjzj3EIsZlVoBXpuvkbH
         GsqErhVmgMJW8jJd5lHD7vEIxvtc6IdDBL+3YkOBwCfIxSgcKnSHv22isGw3/DLmwsIT
         dLzxwBEZ5Xa0RPFkro0DoKSUYyw421m2IhRQvVHH9gq0eaDlBjq1vmeatdkaZRBB/IaS
         9lzxb5B5mSN8jBcRUYKlA3fBlhT8y8IQOZRx/nOa+Rl+swZOxoKl0Hxr+Ldt9U0d+I18
         KM3rNI90JCpcR+S016feJFLdeCkTppGDQwaxJhiFItHs822f4JE2db0Ay8m8X7d67wx8
         pxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UwiNY00/B1wEnev9eGZy7ZKGi1I0cycL/iCTh2NCnA=;
        b=NIZi7MfsVnMwINdK2aAA6mvhPz7E9j5n8x+/EEHq9ZtsfrK2v6Bm6tufMaGgCCt35t
         Xxf+Jpd6FSpt8Dw1GZdORB1geLGE62VWPDvsOyHi9hJAsdKfPqbG+nwAQ7LhNAtdwyYQ
         ARVuRQ+0TYkOjjWHUDvuIae5s/DOIzsYWAs9b3MWPgyewFb5wnQvwgVSMbJp3y90qwUD
         Q7d3IGMNZDwFeso3v7Y6viZcJLT02zSPaZwL4jka5mEEVMAwOgZnr8ICSMOjFDPELGB3
         PI0uHFxNqeeFf03IvjJLdASdwIpSI9DRKdO24hml0WOPr/EOwqdNSIOdFoXUKLB/+2X2
         7Zlg==
X-Gm-Message-State: ACrzQf3oa1s/5CoQonEOtCIDRKcPdtrLS4AwBBD7X8hl+ViHDd8BBbA1
        Neci+3H0RoSdbhWyf3DtPp881g==
X-Google-Smtp-Source: AMsMyM6qMEgjzC2J8dgTEwYSZlt5kH905cdXrte36zXs4B6iGshkk5H9+3G7jMgli094NZ6MLD10hw==
X-Received: by 2002:a17:906:db0c:b0:77b:7d7d:5805 with SMTP id xj12-20020a170906db0c00b0077b7d7d5805mr48359888ejb.726.1666958900428;
        Fri, 28 Oct 2022 05:08:20 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id u13-20020a170906124d00b00782e3cf7277sm2067258eja.120.2022.10.28.05.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 05:08:19 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        quic_kalyant@quicinc.com, swboyd@chromium.org,
        robert.foss@linaro.org, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, quic_vpolimer@quicinc.com,
        vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com
Subject: [PATCH v1 1/9] drm/msm: Add compatibles for SM8350 display
Date:   Fri, 28 Oct 2022 14:08:04 +0200
Message-Id: <20221028120812.339100-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028120812.339100-1-robert.foss@linaro.org>
References: <20221028120812.339100-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for "qcom,sm8350-dpu" and
"qcom,sm8350-mdss".

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 1 +
 drivers/gpu/drm/msm/msm_mdss.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 008e1420e6e5..70683dbc6b32 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1315,6 +1315,7 @@ static const struct of_device_id dpu_dt_match[] = {
 	{ .compatible = "qcom,sc8180x-dpu", },
 	{ .compatible = "qcom,sm8150-dpu", },
 	{ .compatible = "qcom,sm8250-dpu", },
+	{ .compatible = "qcom,sm8350-dpu", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dpu_dt_match);
diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index e13c5c12b775..fd5a95cace16 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -447,6 +447,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sc8180x-mdss" },
 	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },
+	{ .compatible = "qcom,sm8350-mdss" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mdss_dt_match);
-- 
2.34.1

