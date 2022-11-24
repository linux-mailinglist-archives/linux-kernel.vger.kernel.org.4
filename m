Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54236636F71
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiKXAtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiKXAtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:49:11 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE5A105AA6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:26 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id x17so243033wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx2lQyIeBTqpqJ7X6Q0LzKVhxGjP5f4ToZ9EXleXAr8=;
        b=nZq0LPUCzHJydTVKuG9joKgS9Qp7pU83zNbU+NQ20OQf1e1drNWPcarofOJ4TPxY6G
         pbgtIt4W4cAFvpt/5B36QxjMAnM0ENr16AZ5xM16GtVrRWHgkasfMF2utVpixdDgr874
         Wrd0HZtJd2D1Hgs4C4YuVOIZZ/2QgE6WsklCpndc26fisc3bqhvtjZMlvTAyCG19jWFL
         EKwUlZsWoF3zpsRp78kz5avnTgN8Igg2lJ0XLzYQhQP6dVoCCSqjM9nnFP21Rncvnm+j
         RiRcKyiF2cfiUeeuUcuf6MdqkScJw2iIN44qGBZZ6pU042/jvy9B7RqBJRtGtpxU7kfo
         iSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dx2lQyIeBTqpqJ7X6Q0LzKVhxGjP5f4ToZ9EXleXAr8=;
        b=U+Cgx9M3I5Q4SCbdEUmwdz5sVCgnP+LscsD7rNpQSapTQUU4nw4cBQUbSZGBOPOqwf
         uCJAIovvWqNbDmEj8middmY8UIoJNJDvLH/lDRBz3lRpnUOw3qxEsvSIRL+w5TDoxybK
         88qeILrQ7ytVtCSFRqF7A0x68VKDpcu05rlBOCjmPHBzPHtUScNhQb1IONlYifx65utc
         VsmJGEvnAvGrfo6zMLqUj/ckDynOzilRIwjxxxrphUHKB0wcOX0WRiAyuqGvnRsary/0
         4l3KDlh6F3CHuJX9ODD3ULv9Ph1ZJwxKfZvbNb6Pkckk9volKwK4F1L8IRMUnma/UIQ4
         nMnQ==
X-Gm-Message-State: ANoB5plSuvC6gNWcPX4epjNOA9lR/Pfi1P3txEUteAYz7brat5MbJ/6l
        ZCfbFUhR6N3u8AgB5i0p1J/XXg==
X-Google-Smtp-Source: AA0mqf6wmkoiUIkHFGYgoiY9tEn7mW3LakV3Zlc0BdyUOyrcyG1anqxl5v9rPZjACtASN9zGPvI3fA==
X-Received: by 2002:a05:6000:1564:b0:241:e722:3f8e with SMTP id 4-20020a056000156400b00241e7223f8emr5430030wrz.133.1669250905128;
        Wed, 23 Nov 2022 16:48:25 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c3ba600b003c6bbe910fdsm5245076wms.9.2022.11.23.16.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 16:48:24 -0800 (PST)
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
Subject: [PATCH v3 17/18] arm64: dts: qcom: sdm845: Add compat qcom,sdm845-dsi-ctrl
Date:   Thu, 24 Nov 2022 00:48:00 +0000
Message-Id: <20221124004801.361232-18-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
References: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,sdm845-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for sdm845 against the yaml documentation.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5420205417c81..c14e49c9655c3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4522,7 +4522,8 @@ opp-430000000 {
 			};
 
 			dsi0: dsi@ae94000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,sdm845-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae94000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
@@ -4593,7 +4594,8 @@ dsi0_phy: dsi-phy@ae94400 {
 			};
 
 			dsi1: dsi@ae96000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,sdm845-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae96000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

