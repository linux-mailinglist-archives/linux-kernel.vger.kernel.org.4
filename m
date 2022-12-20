Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA2B6520B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiLTMiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiLTMhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:37:00 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAAB19C35
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:56 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ja17so8587342wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKsehGcz374PW4Oaqc03FTNTJ/WJN4Esos64GXOFLAY=;
        b=h2sziuXwG6sjPr+BLoosxPre5o0Zs1SnFy6sNIMS1Z7mXntNvSk7VogqF3ISC572TB
         rvxRhnehnxmnmAgIxciV/rfrRqoQh2uiNBL6gKkCUygHoVmNkqlvbxaDRAnwlMR43aJP
         faLB6JAAdr19rgg3l7RCeVMJxbRCbL252wKrvvdao/eFKbeHhcjQX5RraERSmF65Efw6
         Fzoal6V45HaCqM1EWA+scwPqPuIHdD1s44USd9gHHZnRUNCDwdBMUBVEnlm6r7qmZpk/
         p9quS9ss8Hx333VgUmlZ2l+TAIK4xgF9tFc6bhteGcO2mFLGqQG/3yo6mX1EZVKwsOcn
         gyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKsehGcz374PW4Oaqc03FTNTJ/WJN4Esos64GXOFLAY=;
        b=AbWBCEdwUyg1sPTkV2F+bY+2H1T2d9oLHcQVkbrzbgDJrVVhqL/pyf24Rt/g3zK090
         GshkKyYWI3g6//obbEanp4sWEdP3Wvedy+YSCOERfMUP495zGX96NTnnsJzYsJpoTnF1
         vnmZkrHPgqrYMbd59Ua78iKFfjbvPi3rq1BtsQ5cNWZ6qnljg3d34OWCELxMoghvW49o
         fTMlZiOyaLt7wLBoHK72hRXBxLMEBy5ArkrOTyy2NE1xi7tJKZhCgzpM0vpTYGS/O/qe
         OFsO3/pyrroBBeTGHqcAECVgZJlw48MetRaVzjxUlSY12+K9Dv+yyqfQIeZwjQGOln7/
         /e4A==
X-Gm-Message-State: ANoB5pnn3eioY+I0i381gpa9kTBdhx4FpcZms00iDv7/KOwAbWd/3JNq
        exxoG5TyNZCG+IYEaj9SmiJ7Rw==
X-Google-Smtp-Source: AA0mqf74KclPWOpqVvzCUumx4JRwY1BH8ImGDpuAhQaKiXZgfqUWUxLsUGnA2RmHz8bZMGUHSnfsPw==
X-Received: by 2002:a7b:c40c:0:b0:3d2:392b:3169 with SMTP id k12-20020a7bc40c000000b003d2392b3169mr18519561wmi.28.1671539814709;
        Tue, 20 Dec 2022 04:36:54 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id da13-20020a056000408d00b00242257f2672sm12641208wrb.77.2022.12.20.04.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:36:54 -0800 (PST)
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
Subject: [PATCH v5 15/21] arm64: dts: qcom: msm8996: Add compat qcom,msm8996-dsi-ctrl
Date:   Tue, 20 Dec 2022 12:36:28 +0000
Message-Id: <20221220123634.382970-16-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
References: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,msm8996-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for msm8996 against the yaml documentation.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index d31464204f696..c6d8371043a9a 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -989,7 +989,8 @@ mdp5_intf2_out: endpoint {
 			};
 
 			dsi0: dsi@994000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,msm8996-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0x00994000 0x400>;
 				reg-names = "dsi_ctrl";
 
@@ -1056,7 +1057,8 @@ dsi0_phy: phy@994400 {
 			};
 
 			dsi1: dsi@996000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,msm8996-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0x00996000 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

