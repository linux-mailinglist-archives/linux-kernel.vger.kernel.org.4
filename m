Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DE4629A63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiKONbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbiKONbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:31:25 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA2917426
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:31:22 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id y14so36034238ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikVD0DfwFm4BefZfjV8KlOgWa9wgGHVQ5qduHZ3YKJI=;
        b=PE7uRPgaiWYfakw4e6KcbrSlzatqeCcJWPHhvYxs+/WDKX1pa86HBfti+/k53G4vir
         irgyjrd0gQrnxfGVHbF3BDjCQjos932n7Mwr0Ka2s0eMO3IUYSAEc+R/NCAHgjNWADFG
         Vycpi9u3L8J705xdsumy/W1/90lpuy7VtgN5dAi7f4jNsp3GUI8NDfi+4W09C9mYd+L/
         Lzk7iLA0hOC+QYdI2SsG66iu3A5K+fJ9lE0hFt4zk2OHx0vfihjsZ+kRJlKD2ALCKImd
         6meYgtuEB0beytabcnr+KRzE3MysmyyQPxieDiETdHkXJnZjc4JsiX0ALQZ4E3IXOeva
         HLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikVD0DfwFm4BefZfjV8KlOgWa9wgGHVQ5qduHZ3YKJI=;
        b=x5g5eb/8I3MC6sXnuJyzkOG5uKKa3Jfe3Rd181CQOjXoLJ6dsAehcqzyhJ/945uknn
         uGh1tGokXEGb/HBvlFqYSbQTkGmPfgO1wWPCbIZN6JN2sC7MeO7t2cnSB6Z97GD3OILz
         qTZtqJjP+TlPwiUcq8gOmjh2yz7UKUHDn1Kjv/nDIzWmijYvnkojmwpUGPD/f1lUkSqU
         qqyvlKTKsFWz6cOzCNVlyOKtodOVUl4UWjnyNkbH0tSW1Z0sW95nKKpyg/dx1RI/GNXW
         pgvE9s84YaUizYqvGaxWqzDC0RyjJvTwwr9Ksx5W+/nzQAYRGGdsufLm9wy/6srfqvvi
         AOeg==
X-Gm-Message-State: ANoB5pkiplLJG5u/OWPnO2WK35m86MkdqoyKtPxc2Noms+fte6X7pDHY
        9IVoKtWCwOP57DcATx4Zdc0q8w==
X-Google-Smtp-Source: AA0mqf5SCn1NbVl6jOU2e2xAbnXFfDwN0M70dzTbImWetVatVDa9OMJTM8H+PoahN/Hm4bSJj/wQOA==
X-Received: by 2002:a17:906:8d06:b0:78d:8d70:8bf8 with SMTP id rv6-20020a1709068d0600b0078d8d708bf8mr13369479ejc.15.1668519081002;
        Tue, 15 Nov 2022 05:31:21 -0800 (PST)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id q22-20020aa7d456000000b004618f2127d2sm6162176edr.57.2022.11.15.05.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:31:20 -0800 (PST)
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
Subject: [PATCH v2 05/12] drm/msm/dpu: Add support for SM8350
Date:   Tue, 15 Nov 2022 14:30:58 +0100
Message-Id: <20221115133105.980877-6-robert.foss@linaro.org>
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

