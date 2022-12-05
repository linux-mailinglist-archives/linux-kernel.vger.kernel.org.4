Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA09642D33
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiLEQkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiLEQjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:39:20 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5769E20350
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:38:06 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id vv4so29146474ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 08:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikVD0DfwFm4BefZfjV8KlOgWa9wgGHVQ5qduHZ3YKJI=;
        b=Tw/QVM0P9PmY/myId1uSMoV/+vdpASaSP247AGtd0Am6EWFgZzPH+GdQvB8mOIQlZO
         sLZuMfr5anncSiT3AMTjfCN6k9o28ooIGjE9/1155kzFn0icUtygfdTTnsTIfIApKeZc
         uBOIsjQLeVyRfEkKdUcqWeJVZLCkVyM3Wkn+/XcpkN5ws7dZZg8FPYE4yZ/+YZgsECYj
         NXE6drlG4IX1jhD5IMbZmVsxX8nWF9KZh9XncckpxzbK/F8HlgoMoQo9IVcsG1rbIV8f
         J3c+w0zd8oMKXzv47Egqvpl9+OTa0ptqloQuWijvZ6QE/keuu3x4B++TsoXKCv5ZUGcU
         OTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikVD0DfwFm4BefZfjV8KlOgWa9wgGHVQ5qduHZ3YKJI=;
        b=JfnGYJPI44jycSnAEPcHFGyUc3s8SZ0vKfgoHFcgbOUNFEBq5cU021yGrwjaiN6z/v
         aE0wHAJQw0kPSgFIWHz2KV7oGfvPqTZvSdfsd/r9E4EHeKdzojLsDoCLU6o9vZKnUQNP
         BAdMXl2SQ9AVs6W49kWUyF00IZTQVYpopRnhNX7SoffvkHc8mub+P7nxGG0C86XKv1Eb
         EzO3McyrJnRC7kiyrrs50xH1se5WGaWarR9hEuNKOVYdV/59JGvM4mqZEj5jKowDMF2o
         CLquSqrM1p2trVAEWKvHNPWe86xFRCgjM6f4p8Rh6Rb1czsHYcliIMeiPx18E6dJqj77
         MyMA==
X-Gm-Message-State: ANoB5pkb0HbLPPUhb/ituJln+0N2KRzam4prB602zlWlFfGiUC2IZisS
        o/2OPYxkHOeNdX7vmfaSBbP0WA==
X-Google-Smtp-Source: AA0mqf4GCqnjHAkihknASAn0yi5G+Mq3odla2UDNvKPhEwC6fSs2KP4dmfXWt5u/x4RRFQ1j57oPAQ==
X-Received: by 2002:a17:906:cc92:b0:7c0:beef:79e2 with SMTP id oq18-20020a170906cc9200b007c0beef79e2mr13796496ejb.148.1670258285960;
        Mon, 05 Dec 2022 08:38:05 -0800 (PST)
Received: from prec5560.localdomain (ip5f58f364.dynamic.kabel-deutschland.de. [95.88.243.100])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906315500b007bed316a6d9sm6413610eje.18.2022.12.05.08.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:38:05 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        quic_kalyant@quicinc.com, angelogioacchino.delregno@somainline.org,
        robert.foss@linaro.org, loic.poulain@linaro.org,
        swboyd@chromium.org, quic_vpolimer@quicinc.com, vkoul@kernel.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com, andersson@kernel.org
Subject: [PATCH v3 04/11] drm/msm/dpu: Add support for SM8350
Date:   Mon,  5 Dec 2022 17:37:47 +0100
Message-Id: <20221205163754.221139-5-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205163754.221139-1-robert.foss@linaro.org>
References: <20221205163754.221139-1-robert.foss@linaro.org>
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

Add compatibles string, "qcom,sm8350-dpu", for the display processing unit
used on Qualcomm SM8350 platform.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 9827914dc096..6048bfae0824 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1322,6 +1322,7 @@ static const struct of_device_id dpu_dt_match[] = {
 	{ .compatible = "qcom,sc8180x-dpu", },
 	{ .compatible = "qcom,sm8150-dpu", },
 	{ .compatible = "qcom,sm8250-dpu", },
+	{ .compatible = "qcom,sm8350-dpu", },
 	{ .compatible = "qcom,sm8450-dpu", },
 	{}
 };
-- 
2.34.1

