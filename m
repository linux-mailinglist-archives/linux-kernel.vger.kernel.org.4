Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD09A638A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiKYMh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiKYMhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:37:06 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B244F180
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:37:00 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b12so6596716wrn.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIJDbyegl6u8zeEPDRjfbckMoUQq7Dd8VduqGlrKmeE=;
        b=iTTFGz8jy339GLHg541jLaT9dA4HA9fvcmEO/fxQQLN90d/PvISNhJ/6lYpUa33DqM
         BuZdaImi1QmDyjXNVpnbNKH+CWWBgx5+tewEjSOPxCX1DPPUPRlE+WdVGb8nNY23febT
         8c3i6qBRHyNv7rtI67twEqc7kXcrUYF352w+JFNABHyOqoeX7Z3wE1ci8CT2Pb4FzIRA
         ybr7jZ+zmXuoDO8tmc64YSTOjG9AV03zMEQjW2N+z9quZHX5m6qcf4QDlHz1lVzhlllL
         onWM8RRIVU+eEb8Ec/Ynjf85tRle8T2COWlcdqEFXsG0z9Bm+R+XE+c6aKJh6Z4DAAgx
         nGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIJDbyegl6u8zeEPDRjfbckMoUQq7Dd8VduqGlrKmeE=;
        b=5dkQ86CooXniwD9AbhsT71fI3Sl5B376KN/9RGVLn/FxdW8Lb+CQg3FrJbSAJ/Ya1N
         e4HpZMPgnNY6qTOY9vYVNySqfK5CutlfwIbCjsug5ik1xbw0/AT6cjKT7SR3w4vgHsMK
         Z4G1wC2sK2hKMSUQg09+pHnFw4pitEChe2I5dtD8lu8YjkMAtO2HzY0M93U/giarxqkv
         J7K8VgaAJjRFuBe0x8gFhCNwLr0gHg0Fyv2vrspYLRpk25VoPr3xu34NIfU58h1U/g7q
         7nK92TFl6pGgVuGADmo1aYUdX69QlxRg2UvBqpt4ttORWWabYw/3/LZDszNdx1n4jCON
         rZQw==
X-Gm-Message-State: ANoB5pnz5dWzrwQZFoHWJVu+/hvV2s8QQ+OvvoCliBRqw+SQnjYuDqku
        4FFNM2icmTfZWy3Yo+LV5X40Aw==
X-Google-Smtp-Source: AA0mqf7ptg6Hh54tGkUUz+d4qRCLeoMdzWcd+Am87+jMuUBCw7bWpqd12qOjMU+fHgv/lRZIaUCVmw==
X-Received: by 2002:adf:ec49:0:b0:22e:28fe:39d6 with SMTP id w9-20020adfec49000000b0022e28fe39d6mr23382964wrn.701.1669379819110;
        Fri, 25 Nov 2022 04:36:59 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6d4f000000b002366dd0e030sm3574111wri.68.2022.11.25.04.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:36:58 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v4 14/18] arm64: dts: qcom: sc7280: Add compat qcom,sc7280-dsi-ctrl
Date:   Fri, 25 Nov 2022 12:36:34 +0000
Message-Id: <20221125123638.823261-15-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,sc7280-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for sc7280 against the yaml documentation.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index a4d6e866b5999..3368531e004e8 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3903,7 +3903,8 @@ opp-506666667 {
 			};
 
 			mdss_dsi: dsi@ae94000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,sc7280-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae94000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

