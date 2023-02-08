Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AED268EC96
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjBHKQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjBHKP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:15:56 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2952F785
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:15:55 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso1080831wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKDdeglkNeUYsDE7dNCq4DvipvOoaBQXMMUdKEcJp/s=;
        b=qTVFa5RgMhys3GGm+9g32DXDiQdSAtwy7Tat/X4xAnd7P8SEoasyyDRs1XC9nKwmeU
         0ZcERYTUzqS0h8Fifuvv030i2nnLbLTpe0Wa1Dx4VtAdieO6w3URXqUO79G/uP60dZUk
         fFDKxEbS3T2Stj+vlpB79Zjf2RDMMvWWf9JPpXoAnlpgfj/0clsFkoky6tUJfZD3r28T
         2wu4U556PcVC9fv3jXr53TRx0vLrRKig/P7QQzfaKosLHOQyTofjIX/ePz8m75QjTGfQ
         Rp6/2HcNJbA1vMk6dSo18wRNOe807ufBom05YO1/hhLrVU0yuTwtxC9b7ayiKt/rkoSd
         TtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKDdeglkNeUYsDE7dNCq4DvipvOoaBQXMMUdKEcJp/s=;
        b=7ZfNM9RJuBPuX3RfrDi6qa5vYgiLQ36tX8NaNreusGg2sOmhvhxchxdMYMfE3ngY8e
         gFIcLKr2tCYColNx8BzUC+vj182cgXUkyfGJVSZ2HW9dieKQTwCO0eYATBMnot2AJYJa
         2KzFwtOIa74bOnkx0Taqjj2LmLgTkxUUS4NPLoH8sqd+9i7B6LnZndIPLumLK3g6/TJb
         T+PSKU20JJSoSK4sKzSSa8f14SepoOI8gWTlKGpJ17TUB0AXuxRVWFoT2fW6O/w/hP6r
         6fNlepnymFdYBGLPP2+iLpnMOX9xpgEAuEkJ2HmAO2QcQ3MCtHvDf80owu7TD0kGbncO
         n1UA==
X-Gm-Message-State: AO0yUKXuVHjqMEaXEp0OS0NUx8s4030Q3u4WTfZDkOegpXEgYAq071x5
        8kIhgwtxt/Tf9ISlM+9QGvSOxg==
X-Google-Smtp-Source: AK7set9I7FQyv5QlH9tUgviBZftDZjVnw+tfEbullhD6mNVpLl6bzzA6hwk4pWCze2U3YVWY1ZsX7Q==
X-Received: by 2002:a05:600c:331a:b0:3d2:392e:905f with SMTP id q26-20020a05600c331a00b003d2392e905fmr5835162wmp.24.1675851353876;
        Wed, 08 Feb 2023 02:15:53 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003dc4ecfc4d7sm1496328wmq.29.2023.02.08.02.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 02:15:53 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 3/7] arm64: dts: qcom: msm8996: align RPM G-Link clock-controller node with bindings
Date:   Wed,  8 Feb 2023 11:15:41 +0100
Message-Id: <20230208101545.45711-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
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

qcom,rpmcc bindings expect RPM clock controller to be named generic
"clock-controller":

  rpm-glink: rpm-requests: 'qcom,rpmcc' does not match any of the regexes: '^regulators(-[01])?$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

---

Changes since v1:
1. Add Rb tag.
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 55180586f7b6..e0d46dbd498f 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -483,7 +483,7 @@ rpm_requests: rpm-requests {
 			compatible = "qcom,rpm-msm8996";
 			qcom,glink-channels = "rpm_requests";
 
-			rpmcc: qcom,rpmcc {
+			rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-msm8996", "qcom,rpmcc";
 				#clock-cells = <1>;
 				clocks = <&xo_board>;
-- 
2.34.1

