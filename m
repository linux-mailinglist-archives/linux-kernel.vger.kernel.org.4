Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031A86520B2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiLTMiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiLTMg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:36:56 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F1D186BF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:53 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h7so11595447wrs.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7tCG2RVp+L8qHK6ZCOnqZpsqAhvGiGNti+CNMhR8tY=;
        b=ffyRCS2eCVKTryWXqz8CT2NMUZJVY8SDdeQUiDy7E8XS/irF1nKsOboxRtIH501w6i
         BmY6oH1AOaJkmMvkTD7vhKoKdKDxRS9i+A74OfqwTeOArVvva61WIR1HkZY685HGPRru
         bGwmDtp9qX4mMqlJSJ/zO8S0et4BRQUHakShMRZio7/EPvSFUy6XJVNBEot63BbZszP7
         I6pM3Y9VrWFTkn8ahvAvv+BoTnkqjaAb3C6ZIG2zR6bK1QwWus8FnzeK6T5d9Vt20Dwl
         mAxcH/26v24jkViLHp24lMxQ/diS5jdh3J7wKsft4/SGmnWsewoaVB7Y7OyU63LVj19C
         8suA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7tCG2RVp+L8qHK6ZCOnqZpsqAhvGiGNti+CNMhR8tY=;
        b=NgOnlBwEn42aB98tghbkeg6Y0hwm/K2l0tVCYiDSU0QZ9KYnG1h/HlHvw25HU/n20z
         dfcbr8xHiFy/Xxtu+bwEIarYTldrCvGLw1QlSucfYh8m/N9Mo9/uuxdJWOnZ/zh2IoeY
         L9ttbSQdkL1cux1Bc9NhonilQAaiN+HWpBuWai0arnNnwRQHA3N9MAciyLyiHN8VPCoL
         qLsMoc36fwmVWyt3et3+YwZZtQirQUTOSp2x6j774Y10XyGnmuZ6IuF9GSHRgh0jdgdJ
         0z0sx+DauF+piMOVg1FrVrf7nHauu/fmSoOnKd23l+vL/uS2KgyNjNePfYvDZtE3uDsW
         ib9Q==
X-Gm-Message-State: AFqh2kpp6zHUd9p0alL8OMKxTuxytluKx69xU/xrInyj20PbQ45COcGO
        hXc7xLGXz4Okse38UCu60XIz4g==
X-Google-Smtp-Source: AMrXdXv+Mu93c4tBp5no0FI1gfLVaHzebCHZzfVM85absa0AE+HC3wozZF6AHMDlrvtASq1J8xyWTg==
X-Received: by 2002:a05:6000:714:b0:242:fa3:3824 with SMTP id bs20-20020a056000071400b002420fa33824mr1848694wrb.12.1671539813554;
        Tue, 20 Dec 2022 04:36:53 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id da13-20020a056000408d00b00242257f2672sm12641208wrb.77.2022.12.20.04.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:36:53 -0800 (PST)
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
Subject: [PATCH v5 14/21] arm64: dts: qcom: msm8953: Add compat qcom,msm8953-dsi-ctrl
Date:   Tue, 20 Dec 2022 12:36:27 +0000
Message-Id: <20221220123634.382970-15-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,msm8953-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for msm8953 against the yaml documentation.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 32349174c4bd9..acbe100d9b5be 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -797,7 +797,7 @@ mdp5_intf2_out: endpoint {
 			};
 
 			dsi0: dsi@1a94000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,msm8953-dsi-ctrl", "qcom,mdss-dsi-ctrl";
 				reg = <0x1a94000 0x400>;
 				reg-names = "dsi_ctrl";
 
@@ -867,7 +867,7 @@ dsi0_phy: phy@1a94400 {
 			};
 
 			dsi1: dsi@1a96000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,msm8953-dsi-ctrl", "qcom,mdss-dsi-ctrl";
 				reg = <0x1a96000 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

