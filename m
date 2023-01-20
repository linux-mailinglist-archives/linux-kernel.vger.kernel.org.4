Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF19B675F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjATVBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjATVBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:01:33 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2B7CD23C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:01:28 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id u19so16964007ejm.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMsCj9RG25O4A3HEOR6OR/jKZMnByaByNeXu250+UU0=;
        b=UblonUr+s3jct0bytTz09CEi/dhtVtIrCOEUydaKUCV/nj16FhVjCmy54wjNSZm3+J
         ilMkrDQHn9ekTI+QHM7HysK9lmccuS18P7DqbuUnIAHp1vxkoiUdP8jTxlyGqBHOrApL
         95czCWtwnx3dVgFJ9x6Qa6L4CdiFEUuTlrff5BsWS0WB/XvshTs+WnF2fvlcveY2+bRd
         8Gs6f4pmBQx6Jytc3dBfH7Ia0NZ8yYgBcDQ463zYzUpU0VtJwUodwawbWHH76FuenpAv
         180PMagFbFmzpRk2XcLSTA5IVHgWiciW8XotlLwTP+US0JryCSTsCwqy99RK2ANUZMjK
         +OZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMsCj9RG25O4A3HEOR6OR/jKZMnByaByNeXu250+UU0=;
        b=sd873v3qAglWfIWl2KJVzJgYS97PIfzk+8TStO1TTNYw4JVHRBL/hdZk7s51Wm41Js
         6cPzIneXISQkmJD1h8aHU20n5CnvwP7DnXHgtNQoU2FcaakwT3LOiSHt8yE9cJwaYvBR
         sv6iisyVDGDByb/9pkvdldgBqVqvVquyEJZxhmJ+Lcs5ALlSVbcEp/XMIh5lyrYQd04h
         IDIZvfQO0edMn9PyJ/GufruJz7wGUQvjHJrAItwIVDtzCeWL//jJ9xb8vf+7wBiYEwHP
         7mJyYSRLMZIIE7CZj2qIjIGzZrLgNR1qPMTSpIqzM8AcSJ0oSY5qG23AkiNBuSU6inpk
         9ztg==
X-Gm-Message-State: AFqh2kr+XLAAZtfCt2N5QBaDqwSZd6tviUH56zhOQe5ofW2Z5c4Kxe+u
        j2QXTmjvLwHWESw/KXJrIqI3iQ==
X-Google-Smtp-Source: AMrXdXsnKTMnn8pBggT8wypvx4ly24qXZso6gSXtYC3gBFgndudQ2tx35A3eKs1c9jb4wVpBxKIXeg==
X-Received: by 2002:a17:906:3610:b0:7c1:8ba7:3182 with SMTP id q16-20020a170906361000b007c18ba73182mr17143993ejb.69.1674248486565;
        Fri, 20 Jan 2023 13:01:26 -0800 (PST)
Received: from localhost.localdomain (abyk37.neoplus.adsl.tpnet.pl. [83.9.30.37])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906595600b0087221268e49sm6581229ejr.186.2023.01.20.13.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 13:01:26 -0800 (PST)
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
Subject: [PATCH 6/8] arm64: dts: qcom: sm8350: Fix DSI PLL size
Date:   Fri, 20 Jan 2023 22:00:58 +0100
Message-Id: <20230120210101.2146852-6-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120210101.2146852-1-konrad.dybcio@linaro.org>
References: <20230120210101.2146852-1-konrad.dybcio@linaro.org>
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

As downstream indicates, DSI PLL is actually 0x27c and not 0x260-
wide. Fix that to reserve the correct registers.

Fixes: d4a4410583ed ("arm64: dts: qcom: sm8350: Add display system nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 22bf6239c757..b09eb8880376 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -3041,7 +3041,7 @@ mdss_dsi0_phy: phy@ae94400 {
 				compatible = "qcom,sm8350-dsi-phy-5nm";
 				reg = <0 0x0ae94400 0 0x200>,
 				      <0 0x0ae94600 0 0x280>,
-				      <0 0x0ae94900 0 0x260>;
+				      <0 0x0ae94900 0 0x27c>;
 				reg-names = "dsi_phy",
 					    "dsi_phy_lane",
 					    "dsi_pll";
@@ -3138,7 +3138,7 @@ mdss_dsi1_phy: phy@ae96400 {
 				compatible = "qcom,sm8350-dsi-phy-5nm";
 				reg = <0 0x0ae96400 0 0x200>,
 				      <0 0x0ae96600 0 0x280>,
-				      <0 0x0ae96900 0 0x260>;
+				      <0 0x0ae96900 0 0x27c>;
 				reg-names = "dsi_phy",
 					    "dsi_phy_lane",
 					    "dsi_pll";
-- 
2.39.1

