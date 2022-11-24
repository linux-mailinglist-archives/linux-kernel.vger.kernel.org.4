Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C676636F66
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKXAt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKXAtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:49:00 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC003FFAA3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:21 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso166847wmp.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dzy/pv8LpfaZCGMyLs3UqXEZ7XhwmH1hafdtceOiRFg=;
        b=nNNNpAopz04epdPTLI7bA8NLeMA+bEcIIo8WK68m7TDI8HnfxQb8+yDsfu5TNqJfof
         H0uNz/m1D3ygTnXntdSQlhOTtNSdtmjL+kcbWax3p6M4frv5ZprK6m7P2Lp0Ewiw0Z+X
         mNdTqOZA5FozFQGGRbFQEzIo7lawjN48VrN7uUSMOKxf+uVs9aOzsT0fXDui/wHzHRfI
         YsK0KBN4vBSbGNdJUlRs2rc8uqDUVg8nCUZI/6MsU+vKwsbzb72UyVMMyIsqhmyij1QV
         1RQ8nTZVsnIzQ6E6jd2t3FMA7nc3oVmLoeLhmWaabdpvdWJ8hFgZvHtuSTziDHZtcTKS
         kKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dzy/pv8LpfaZCGMyLs3UqXEZ7XhwmH1hafdtceOiRFg=;
        b=rhrcgvaQ0lLNhxdV+unasPFxYW5bDEydZ8260YJYfYZW8eB3KxVXe9xTC3fk06jyoY
         w98m8R1f9S7c5rqZUb2kZ0Do3ugNw/rxWw0cJLx4HPlKn2ATxsY8xdKxDxOK6sNgY/Q+
         gzNhV6RJoSPSJ+8WysuuRU95x8u9+p2hhDtkV+OJiAsLScciWnFx0PAlr0fMO0Yb0xSs
         jkYt2yjjwbivH0XOdAZUf22ehC7xeb76UE3ZGqyXt7P2XC+zb6TkH5yhJDKZfX2rUVv7
         sak2hBVgkiOKLaeFznxfteoSR/WmnnKxk6SrggSxPUdsY9AScYfaFrBUzw97ZXYdouU1
         R0OQ==
X-Gm-Message-State: ANoB5plDeYTXwgD1I9ZHv7KOuGmoSy6L06MyOsxWo9cL0Hb1VvFyCl48
        jj2e8ssZ79S8ZbknA/AZ7ugvZw==
X-Google-Smtp-Source: AA0mqf78tVK3fum1F/dXUdTtS3hTH00hrnLPbUdoCb+RptxefA0TpwgIu8uEsk/h/PHFXYBVd4VUiA==
X-Received: by 2002:a1c:7214:0:b0:3cf:7b65:76c5 with SMTP id n20-20020a1c7214000000b003cf7b6576c5mr21825295wmc.166.1669250900396;
        Wed, 23 Nov 2022 16:48:20 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c3ba600b003c6bbe910fdsm5245076wms.9.2022.11.23.16.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 16:48:19 -0800 (PST)
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
Subject: [PATCH v3 13/18] arm64: dts: qcom: sc7180: Add compat qcom,sc7180-dsi-ctrl
Date:   Thu, 24 Nov 2022 00:47:56 +0000
Message-Id: <20221124004801.361232-14-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
References: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
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

