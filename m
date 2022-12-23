Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD0F654B07
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiLWCMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbiLWCLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:11:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABE3D2D1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:10:46 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i7so3381288wrv.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI/lLtloM4Tug4sA61Civ+cVcFduOFVW5YccHSGp9ig=;
        b=Lixs1LtEmxS//vCTrerJk1KgAHJNQEhXyIFjU8wANYI4EzWGUrB1M8R3vcEt3sMz97
         97sFqlabHsvnk7jlW8M04OyRODzQYe4QH5Gg3JTsQBCe5VQt2kII5Xqx7A/yMcMcrm4z
         9HujaErRwi1Xyh127xnT65LeCPl3ZsvFstn2+LSTFY9SHLBXmDd1P9j9qN88iOTyCLHR
         ow8si8IEq5RTdawFy27ba3RL4ZUAMEn/QrE56VcnFPaSDHccoGick03G4R85huF6DUE2
         mmMchZz2rVDkrvYw9bYaFcvxFJzaFsIcU0OGHpKtKW5nK8qEo/HSiIWNYoHPVI8DFlZt
         GHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZI/lLtloM4Tug4sA61Civ+cVcFduOFVW5YccHSGp9ig=;
        b=PigATi7CQMQTMbqTpGeEU53jb0RVzZgLeQmmRuxm5MUl7oVzCsX5hnvsoI5dyprh2r
         4Z1z4ZfOmIedR/Xy2UjyVD2pZK8bKmcTQE1XUrba1yNrkvuDeS8PqSwS4kZOCM0THSmF
         zawsbvfSlcOh3YPMqTwgnbzJ0nHax6sOk8XC2khUiYvdU7GvdzBEqB7NtRLABYuEOrQV
         Vzupehnl3pJ9tj5F5uMNErdbBAR9mDdEMl/yb3pEoY2nH//xAnLoFj+aKe2jCZ5eD9wc
         iivenC5VS+38bTj4a3fZqV5Wx0rq3LIa3y69jcjaGDDMAKDnw9A3Gy/mWwGE8fZoCWqH
         itBg==
X-Gm-Message-State: AFqh2kpIog188xJL7LlNI1zE4WWT+brSbdRRLAlQW0ema2ekvnVaRPNf
        LUzW00TU13vdrolF/P2SRMgW0w==
X-Google-Smtp-Source: AMrXdXu0Ct5sH64r5l0zVx5XSTFPb97WZmvS9DEvDVB13mOCtVUu/cj4T64SwhJp3Zu63rwRBDxBXg==
X-Received: by 2002:adf:a15b:0:b0:256:ffcc:49b7 with SMTP id r27-20020adfa15b000000b00256ffcc49b7mr6150135wrr.62.1671761446435;
        Thu, 22 Dec 2022 18:10:46 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d452b000000b0022cc0a2cbecsm1849725wra.15.2022.12.22.18.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 18:10:46 -0800 (PST)
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
Subject: [PATCH v6 17/18] arm64: dts: qcom: sdm845: Add compat qcom,sdm845-dsi-ctrl
Date:   Fri, 23 Dec 2022 02:10:24 +0000
Message-Id: <20221223021025.1646636-18-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
References: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,sdm845-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for sdm845 against the yaml documentation.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 65032b94b46d6..623e5d7dddfd2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4645,7 +4645,8 @@ opp-810000000 {
 			};
 
 			dsi0: dsi@ae94000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,sdm845-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae94000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
@@ -4716,7 +4717,8 @@ dsi0_phy: phy@ae94400 {
 			};
 
 			dsi1: dsi@ae96000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,sdm845-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae96000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

