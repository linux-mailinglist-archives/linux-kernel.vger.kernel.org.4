Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314BE675F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjATVBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjATVBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:01:44 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7BBD0DA9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:01:30 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id v6so17006899ejg.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cplHg6mmZO77Jj4HjyqBizHDxHYMI91dvrCE+XRo9rU=;
        b=pyRBjQVaxGEuZeJXBEpUNUgHxD9Z3JgDHkxja3xv85n7MIQizfzpRmIhWtSLcKVsv6
         iGYQFUwZI//O/otLG9lQuAt1TAoUpqzw08rUfl50jZHBjljox+1s/hxc5umAE5SnxaXa
         uHJ2c6+dg/u5IPYb2Uks5dQ0BZNKfUo7jO+XBeUD13tQZ3yRFm4IzQRz8dhhvJVosxTu
         yrdRgGkZqkqZBUi0Ti7vGNGeyxN0xxUO03WgtrRFXGXS1vzNl62xuahhRFyrGG96JcTO
         QCKAxNUcKP6xhwWaTMC5oyaKEVYdDOTQ4oft3361FdqmpUmy8RSM6loxW6HJWB5iLPjx
         75+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cplHg6mmZO77Jj4HjyqBizHDxHYMI91dvrCE+XRo9rU=;
        b=FzZ3isXsIbRskJjo4lHg0+gswCJaa68POTcIi4T4puUfPw4pFJkqKrDUK7luQOMXJg
         AtvjkttpS8owWkmmY/CCrjTQLhx1ngFtGBnBezPjYc8oLR/JkLqAvdvMhefaoGKfDFcC
         QTa8y8gSn23bo+IKtrm8yFEQpl9eLqFvoH0EqFzM3UmXX/0OtmolO6REgX5uGtINrGdr
         fgj9paUQNdqGqRlWs93MTDNv9+Ku1ck4nAveaaKKzPyFIS2ixGB23xkGJ/NZq7lBQMtH
         4RSB21XgQ08t4qPZxcmFeg2eWDpEpjlgnfGMINLcdIoX6vAdGmjI0oPG6QbFGxB0rmhx
         GvVw==
X-Gm-Message-State: AFqh2koj0GfnZiRRqHCCISyLNd9IZF7JlrvSzLl3ATpyELCT64qhGLrz
        KKaJ5Yhb9kDipOHPjiitQ2XONg==
X-Google-Smtp-Source: AMrXdXvhQI54/4nyNC2unGCcARW/ouKy70qQqZ5Werikg+NU9C96Tk/aCyOTWsXVvSMVhDpZ2CTH0A==
X-Received: by 2002:a17:906:a88c:b0:7c1:5098:907a with SMTP id ha12-20020a170906a88c00b007c15098907amr16687692ejb.35.1674248489093;
        Fri, 20 Jan 2023 13:01:29 -0800 (PST)
Received: from localhost.localdomain (abyk37.neoplus.adsl.tpnet.pl. [83.9.30.37])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906595600b0087221268e49sm6581229ejr.186.2023.01.20.13.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 13:01:28 -0800 (PST)
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
        devicetree@vger.kernel.org
Subject: [PATCH 7/8] arm64: dts: qcom: sm8350: Add mdss_ prefix to DSIn out labels
Date:   Fri, 20 Jan 2023 22:00:59 +0100
Message-Id: <20230120210101.2146852-7-konrad.dybcio@linaro.org>
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

Add the mdss_ prefix to DSIn labels, so that the hardware blocks can
be organized near each other while retaining the alphabetical order
in device DTs when referencing by label.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts |  2 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi    | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 5a4c4ea4d122..df841230d1b7 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -309,7 +309,7 @@ port@0 {
 				reg = <0>;
 
 				lt9611_a: endpoint {
-					remote-endpoint = <&dsi0_out>;
+					remote-endpoint = <&mdss_dsi0_out>;
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index b09eb8880376..0f9427f3319f 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2952,7 +2952,7 @@ ports {
 					port@0 {
 						reg = <0>;
 						dpu_intf1_out: endpoint {
-							remote-endpoint = <&dsi0_in>;
+							remote-endpoint = <&mdss_dsi0_in>;
 						};
 					};
 				};
@@ -3024,14 +3024,14 @@ ports {
 
 					port@0 {
 						reg = <0>;
-						dsi0_in: endpoint {
+						mdss_dsi0_in: endpoint {
 							remote-endpoint = <&dpu_intf1_out>;
 						};
 					};
 
 					port@1 {
 						reg = <1>;
-						dsi0_out: endpoint {
+						mdss_dsi0_out: endpoint {
 						};
 					};
 				};
@@ -3122,13 +3122,13 @@ ports {
 
 					port@0 {
 						reg = <0>;
-						dsi1_in: endpoint {
+						mdss_dsi1_in: endpoint {
 						};
 					};
 
 					port@1 {
 						reg = <1>;
-						dsi1_out: endpoint {
+						mdss_dsi1_out: endpoint {
 						};
 					};
 				};
-- 
2.39.1

