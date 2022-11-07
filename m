Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC8D62044B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiKGX6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiKGX52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:57:28 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A2A27B36
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:57:13 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso8089571wmp.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 15:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1fdF8L0sW5KTb/YS4QVa8k0yiXyWoXhMbKOIwuHjto=;
        b=CxaF9TLdAp8eXLashbK5nNP72P5DURASHhS9cPKPqghAdAr3UEXkoVu6skvY7Ep3fF
         f90HBRjhF9WmoSUzkxFE+hiNTFVYWJC7mM11PBepOU3VoapaZe+27DkqJAAOKI1p6RJU
         wFQhd5+nT+tjsOIRJhVVkEbKnkPua0erTVc8WxBBqedbVF7aBOQa50u0B1P6Erzy1SmU
         btmdjgUh7QyABg5DUpTd4VAWnIZ6Uvvn/9Jg+X/OvlZpMWNsFRZ0EYzyRkE2nMlZGnSY
         8u7bsIiYQKVDL7zZGg+3jWl3IlJi6PdKemVAmpvFpCtT28vV9jc39lgVV5hoDZEmrgEf
         e3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1fdF8L0sW5KTb/YS4QVa8k0yiXyWoXhMbKOIwuHjto=;
        b=irMuMUqxnz/XGbc31h1QYkBQ9Kr4azpyaNbXhBeGrpqFxRhMkK/0VuMJpQG+JZIE0T
         jbzmMaCv9Y3y6qNpDhSfG1JOjo+/PqyHoK1iV6E5393Gg4ugIqgbhl3TeiYgE7b0jRut
         gdG9uXRTdQudj0PL7VS/3t6FRKqRWhzbBsES4HfdieP62ArnCeZ9zbNPrc/lsa/ImfAO
         CUTC16c+PvWZGRwPI7WmY+6+w71HGVOr4x4WsOrYf10gk3rrdUfDASNo+19dD8luVFrb
         +4Zl31NnN36WCvvDPv/ZF3ncxsyAquhtoUJu94c8edf5JYD34EkjtpF1v+GoGpFZD+7D
         F5dw==
X-Gm-Message-State: ACrzQf1zahBmZfI56i/eR8iO8XSk/YJrrKxYa/WcpajfFh0KSVl37oNy
        KHjdKE0ugoYlvnwU/2C3HFxs0w==
X-Google-Smtp-Source: AMsMyM7AAKhJzfP4Q3UOLJsHP1CRF63+aUq2y9rgXP7psRQw8WqejiO1qCVXOsFiP3u9Scf2BY9Cvg==
X-Received: by 2002:a05:600c:896:b0:3cf:8e70:f341 with SMTP id l22-20020a05600c089600b003cf8e70f341mr16835095wmp.74.1667865431670;
        Mon, 07 Nov 2022 15:57:11 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b18-20020a056000055200b00236545edc91sm8386161wrf.76.2022.11.07.15.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:57:11 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, quic_mkrishn@quicinc.com,
        linux-arm-msm@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH v2 14/18] arm64: dts: qcom: sc7280: Add compat qcom,mdss-dsi-ctrl-sc7280
Date:   Mon,  7 Nov 2022 23:56:50 +0000
Message-Id: <20221107235654.1769462-15-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,mdss-dsi-ctrl-sc7280 to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for sc7280 against the yaml documentation.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Sibi Sankar <sibis@codeaurora.org>
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index a4d6e866b5999..7d4df38348e4f 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3903,7 +3903,8 @@ opp-506666667 {
 			};
 
 			mdss_dsi: dsi@ae94000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,mdss-dsi-ctrl-sc7280",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae94000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

