Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1E8675F55
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjATVBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjATVB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:01:29 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B37DA839D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:01:24 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w14so8195064edi.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXpRK66Qxpazw7ZBSDhL2VuarYJmczwhTFpn31yFY6A=;
        b=h0j0tqp1w3CO7sLntH/Nj7Q3502f/+thyrgH/kZl+06qK6bFfQainS6HYKgabaCqZa
         2SenyT+Zynf64H7S77s/s4ZA7ZPqXiFqgJBPzO6GIf9QgOuopU7d+AvYUgVShhWzUPsa
         ccl3Wgrfy4LY1sxsVXfPKKmjzgHM8nTE/ZjFHhkhRKfpqvECIK0CaDIX75+JOdXE0jQU
         HOG9f3TJau/PDMyyun9j5IlkZ/TqbuQHlFFqqG66fjcSehSWaGKm2m7lwl9z5YEnwli3
         9TLmbAnSkUxdtRVgJIZL8LY6WH8dJ31ntenfHEcXkAoK78JYd3yzXFCbUv9ttCr2CmVb
         qp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXpRK66Qxpazw7ZBSDhL2VuarYJmczwhTFpn31yFY6A=;
        b=QrLyIJ90IZd0WSQvaq9nuQziPYHTZk5O9FWx+0/8Z65tVXC83cUR56uHgjxtJXZNqq
         GxtHEABWDOunF7bQtI+K/n6iILUYBT2/J5Nop5MtOkimbFxOKeB4XweYCCx+zdDh3C9y
         gN7QgYh9up/Umq7KV0WyxbO0T8pj6gTYA+qsr1P3Vz0+aadbwwcPZKBtOgj2U7TEEkQG
         5RJakkZnmkvCsOUnZS2gqJxHJs9od6BWwCh3h0xt7spZ0uHZAFh49bKEY33edv5fFKqf
         IUoDlypPwJ9u+2nSbHrqMVPk+F3mwP+eGOAc13vUpMoIes9X+rHE0jsVdp5axSHoeSqr
         hRPA==
X-Gm-Message-State: AFqh2kotk7vL5wL8G6KLaN8yAVpJfv6KkBif2b718Szc6mT6XkXxV0AQ
        KjOzJQrERR3vLnKS+WL+GlTJcg==
X-Google-Smtp-Source: AMrXdXvc3+ZcD59sVWvBuYUWfY+UrxFOxehiFF1cS8qCPTMQQJktRtG9mdhI20ZezkeaPgmLt7Piuw==
X-Received: by 2002:a05:6402:454:b0:492:8c77:7dad with SMTP id p20-20020a056402045400b004928c777dadmr15808302edw.8.1674248483799;
        Fri, 20 Jan 2023 13:01:23 -0800 (PST)
Received: from localhost.localdomain (abyk37.neoplus.adsl.tpnet.pl. [83.9.30.37])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906595600b0087221268e49sm6581229ejr.186.2023.01.20.13.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 13:01:23 -0800 (PST)
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
        Douglas Anderson <dianders@chromium.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 5/8] arm64: dts: qcom: sm8350: Fix DSI PHY compatibles
Date:   Fri, 20 Jan 2023 22:00:57 +0100
Message-Id: <20230120210101.2146852-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120210101.2146852-1-konrad.dybcio@linaro.org>
References: <20230120210101.2146852-1-konrad.dybcio@linaro.org>
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

The compatibles were wrong, resulting in the driver not probing. Fix
that.

Fixes: d4a4410583ed ("arm64: dts: qcom: sm8350: Add display system nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index c964d939289b..22bf6239c757 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -3038,7 +3038,7 @@ dsi0_out: endpoint {
 			};
 
 			mdss_dsi0_phy: phy@ae94400 {
-				compatible = "qcom,dsi-phy-5nm-8350";
+				compatible = "qcom,sm8350-dsi-phy-5nm";
 				reg = <0 0x0ae94400 0 0x200>,
 				      <0 0x0ae94600 0 0x280>,
 				      <0 0x0ae94900 0 0x260>;
@@ -3135,7 +3135,7 @@ dsi1_out: endpoint {
 			};
 
 			mdss_dsi1_phy: phy@ae96400 {
-				compatible = "qcom,dsi-phy-5nm-8350";
+				compatible = "qcom,sm8350-dsi-phy-5nm";
 				reg = <0 0x0ae96400 0 0x200>,
 				      <0 0x0ae96600 0 0x280>,
 				      <0 0x0ae96900 0 0x260>;
-- 
2.39.1

