Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36531638A1B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiKYMhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiKYMhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:37:03 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530964E436
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:36:59 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so6059578wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dzy/pv8LpfaZCGMyLs3UqXEZ7XhwmH1hafdtceOiRFg=;
        b=fJJR4QeEbYbrdwi9ZTqdfFKUfYSWnqAF9EsGpW+uixxx2zbe9q7zL6OjmJDVxo0hMd
         myn/rr/7wFhiBZK6cB5qCvfGKPEZtb+sRmw126yZDnQwCxANmo0Oh+U4EFrSdp2x1iJl
         7UiEwCOzYCrdFXVbEvP3xmPo1LlYddEPa5BeLWNC9uN/Y07gDn6T4APWzdU6VnfYkl/f
         YgnnPFhlo1K9NH8gc2xdQABhjJNkSIaSJfI/SIzJ2kJp9bvf6WpqooO4PqFuUwijSl9Q
         Q0SX1O6YKPIDBWjYNc1F6gMZPbKITblTsOBUf+xzeu3d7iIVmmGvDKCQTPUOmu5Py1nl
         rrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dzy/pv8LpfaZCGMyLs3UqXEZ7XhwmH1hafdtceOiRFg=;
        b=QghkwHpLqrmdNY5fELZVwi1CdgFTzTt1gRdvRpSpuqzQsLmKtjyZ+598tr3VNaVbug
         nwz16A2Ssn2Asd6YGjON7DZlCKCzuhwL/7/oEYyOg8KjFgiiptpMUeQGJUJ7L7cVMzzE
         AD+2YYHI2vnZuwCSjef84tD6D2fHPqdcCCtxowruXzXctemD7hTrGJOaNmAWmixEWJwj
         uVKIuDAZckeFyr1QyB5WaPXpcsvDuFUCK57JpLTDI+mcZE+FY2FfRO2Phfk45IMYGfl7
         iQ7Y7NHL/kGY1rOJaa1CSsindrmMDCtO4FM1AG88IeEPy/hoZNo7dQSfz9SGGajK98St
         TzWw==
X-Gm-Message-State: ANoB5pkW8XoGrzJzrKxXywaogxsjvQl1in/PmLo6jBuAUI4HPBXgRQEL
        fn79Rp0tYDnn9HnmXRGQEiheBg==
X-Google-Smtp-Source: AA0mqf4C+BIzB93Y+GyJoAW9Q84AZU7HlHwF5CeORzNqfFwZ5t3SbSpe4RxDy89uLI7h+t3HQNpsJw==
X-Received: by 2002:a1c:f216:0:b0:3c6:c2ae:278b with SMTP id s22-20020a1cf216000000b003c6c2ae278bmr27105879wmc.127.1669379817884;
        Fri, 25 Nov 2022 04:36:57 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6d4f000000b002366dd0e030sm3574111wri.68.2022.11.25.04.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:36:57 -0800 (PST)
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
Subject: [PATCH v4 13/18] arm64: dts: qcom: sc7180: Add compat qcom,sc7180-dsi-ctrl
Date:   Fri, 25 Nov 2022 12:36:33 +0000
Message-Id: <20221125123638.823261-14-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,sc7180-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for sc7180 against the yaml documentation.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index d2c374e9d8c03..cfe44afc52b4a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2985,7 +2985,8 @@ opp-460000000 {
 			};
 
 			dsi0: dsi@ae94000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,sc7180-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae94000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

