Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE0D642D47
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiLEQks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiLEQjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:39:35 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1306EDF70
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:38:17 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id gu23so29147589ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 08:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCi/ES9FuqiQm+KWnSYhmAQtDDx+gMJGxqOaQjv7UIk=;
        b=ZoX2tJHWrCkPkBcrX0//rHOVwz5BahSF28MTK6X+RN/dk4h/rxeBuGVO2L+dibazut
         q7dOt93tWuJleVc7TS6TfkeNOrGDCKN1ca5iX2RNDfHSaXI847X/7X8mohGv40Ke1/q2
         1emNQzt7bVLgkfLWuIt4n2KHDh2hKi/291aFB2jQlUgBJSIbpsIzBObIh0XAxctVbAsZ
         GiIU6wjVJ4/nIttKRhlqR/oQXSLkNwlW3ph3pVawHbFgNILVk12Ec0eceGyQu72lvIX3
         97NyQ9iScu7Qv7MMp1Knw7r2uwZtfZSaqPQ+6PRNhN2RV+7qKA0P8+yxLXPFe6HMg5uN
         HmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCi/ES9FuqiQm+KWnSYhmAQtDDx+gMJGxqOaQjv7UIk=;
        b=qgQ/bT9S6+a2++rNffRBRMbQ2e1mPp6RmDR6nyJyNtn5fJ9zypIjPmJow9a5vGvhIY
         mM7cTpKfgDnK4NYjgfn7K0QcLMCwLLWgtyrUptRHFwYn9xx4yqth75IVNs+IkqUARqWW
         +rBiDSgOUiyjiOgcFwTNcgZAc3F99hTKYYLfr6aOHFOzDXBuBmd8Gnr2Xs76S8GoHOjS
         u5JLWwP0GcRfApn6AYRY2zC6E05Vm8+AeP2TsEMvXq1Gj3a4E2j9jgpCV3F3ZF8hZjBl
         nSLdY1Qx9JTvT/4z6nMi8Jtq0tX0QysxXmqVkirDdJYaRlPLPdd0bAq60ufnUNmR5D5g
         Khyg==
X-Gm-Message-State: ANoB5pk+ssTdT9txDBvnJclQS47ZOrrfpyK0sGjzK5u8XdQXCXYIOw+v
        7CGBKXQKkfpdBjO8T49DK4AmmA==
X-Google-Smtp-Source: AA0mqf4uofNU36445H7vBcqW0PrG+7W2qeGiYvP9TetTZmvHakm9v4rcNC4UpjCea/HDj5gEZrsskQ==
X-Received: by 2002:a17:906:6417:b0:7ae:937f:2c38 with SMTP id d23-20020a170906641700b007ae937f2c38mr54991745ejm.201.1670258295604;
        Mon, 05 Dec 2022 08:38:15 -0800 (PST)
Received: from prec5560.localdomain (ip5f58f364.dynamic.kabel-deutschland.de. [95.88.243.100])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906315500b007bed316a6d9sm6413610eje.18.2022.12.05.08.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:38:15 -0800 (PST)
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
Subject: [PATCH v3 10/11] arm64: dts: qcom: sm8350-hdk: Enable display & dsi nodes
Date:   Mon,  5 Dec 2022 17:37:53 +0100
Message-Id: <20221205163754.221139-11-robert.foss@linaro.org>
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

Enable the display subsystem and the dsi0 output for
the sm8350-hdk board.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index e6deb08c6da0..39462c659c58 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -213,10 +213,32 @@ &cdsp {
 	firmware-name = "qcom/sm8350/cdsp.mbn";
 };
 
+&dispcc {
+	status = "okay";
+};
+
+&dsi0 {
+	vdda-supply = <&vreg_l6b_1p2>;
+	status = "okay";
+};
+
+&dsi0_phy  {
+	vdds-supply = <&vreg_l5b_0p88>;
+	status = "okay";
+};
+
 &gpi_dma1 {
 	status = "okay";
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_mdp {
+	status = "okay";
+};
+
 &mpss {
 	status = "okay";
 	firmware-name = "qcom/sm8350/modem.mbn";
-- 
2.34.1

