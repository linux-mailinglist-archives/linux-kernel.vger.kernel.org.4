Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F066599ED
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiL3Pgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiL3PgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:36:16 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F2CDF07
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:36:11 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso12735736wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvoIQMnXY8yOCNSxPgg9R4wPyidXv2/4nGMjJvieCBs=;
        b=kQkZnSFJ15AgGEEKY55HiNDUlYDLyoEBh1YXgROxYK4o8lr2B2fxMNH46Azsx0n7Lg
         OKpSf7kaY0/HWiR5prROvKGmskVVDAU554WiUwHMf0GzEmRiMOynhNcrjTx4E9H/ZhZU
         afhLj5DI6lVhFS+MpbVvbL4+a4CQHCvPI6FvbBjc7NguYo+XYzG0EYzevrVjy5QYgUSg
         2aWtVVyfG2NKSxJsX+mm4B9ZBVnK8x91vhlgRfZ8Cqwsonqt/9YXJxNjWuYzArkS9fzc
         UU2II2sT7ShRstyMMY7WpBDTpQa7oAtgMrtntxLtYPRB42zq/GQEIa/2f1x/tSq0LjW4
         hkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvoIQMnXY8yOCNSxPgg9R4wPyidXv2/4nGMjJvieCBs=;
        b=ywXRVYpofP8bZ7BZRCBojUmCqFB3QsfLmdsNhOSm9mmYxxEHzS9eg7g0B7WwQ+gwqJ
         VBWe1606IILqdtbpQlDgCWpyDPvmBtZBg4llskKzjW1O1PYWS5F9A4fZpqmzvvTr6yic
         LGPRzzyM/uxSbH/DFlo1KtC2VcEFratLBlHzOAnN4XDmNJVZPLAMULUrLPvuiZ8jPXDa
         sbACGX5aqnUROX7FaPIFIck1wISuJKzJTBVBZSOHjRTt66w1Ex1+R0UrESRfWaVwjK1M
         hhLw55DzCnuS4bZG08PCrFdvtjUGziaFi5J4SsJg9pqqaJu7/ff2432DIB3nz8a+lWuV
         HChA==
X-Gm-Message-State: AFqh2koKe+rCGcW1hAEPRZoTmVgzKO5lrnEf7N0ZsMfu1ZHQAVucx0kh
        j2QUzsAQSBwlNj+Lpg85PhzSfg==
X-Google-Smtp-Source: AMrXdXtoJmQiYns1YtEHtp8+sf6gqykYvJor9xngXk7t1gmlGQpIcqatDuDWVMpzJn9N5SmzKrIdEQ==
X-Received: by 2002:a05:600c:4fcf:b0:3cf:68f8:790b with SMTP id o15-20020a05600c4fcf00b003cf68f8790bmr23587091wmq.11.1672414570323;
        Fri, 30 Dec 2022 07:36:10 -0800 (PST)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003cfbbd54178sm49857993wms.2.2022.12.30.07.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 07:36:09 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        quic_jesszhan@quicinc.com, robert.foss@linaro.org,
        angelogioacchino.delregno@somainline.org, loic.poulain@linaro.org,
        vkoul@kernel.org, a39.skl@gmail.com, quic_khsieh@quicinc.com,
        quic_vpolimer@quicinc.com, swboyd@chromium.org,
        dianders@chromium.org, liushixin2@huawei.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org
Subject: [PATCH v4 05/11] drm/msm: Add support for SM8350
Date:   Fri, 30 Dec 2022 16:35:48 +0100
Message-Id: <20221230153554.105856-6-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230153554.105856-1-robert.foss@linaro.org>
References: <20221230153554.105856-1-robert.foss@linaro.org>
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

Add compatibles string, "qcom,sm8350-mdss", for the multimedia display
subsystem unit used on Qualcomm SM8350 platform.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index ef31aad0c2de..34cd3df58aa1 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -297,6 +297,10 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
 		/* UBWC_2_0 */
 		msm_mdss_setup_ubwc_dec_20(msm_mdss, 0x11f);
 		break;
+	case DPU_HW_VER_700:
+		/* TODO: highest_bank_bit = 2 for LP_DDR4 */
+		msm_mdss_setup_ubwc_dec_40(msm_mdss, UBWC_4_0, 6, 1, 3, 1);
+		break;
 	case DPU_HW_VER_720:
 		msm_mdss_setup_ubwc_dec_40(msm_mdss, UBWC_3_0, 6, 1, 1, 1);
 		break;
@@ -533,6 +537,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sm6115-mdss" },
 	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },
+	{ .compatible = "qcom,sm8350-mdss" },
 	{ .compatible = "qcom,sm8450-mdss" },
 	{}
 };
-- 
2.34.1

