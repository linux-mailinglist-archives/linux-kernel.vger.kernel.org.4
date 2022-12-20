Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179886520CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbiLTMil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiLTMh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:37:28 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5248B1A07D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:37:02 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id co23so11607185wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHjoTnRNTZFA0ZBsqDkIXARH9jeUb+0DAfgRumKgoyA=;
        b=rs4vgJC3RjuWDo/TltLbOoul1JyKztAoXim5pF33Rv50LulrE9vvKu2elONP3paQwe
         ZuineT+WHrcIQqs7witjl7gO9IqNDgmcvxWBoeTIlFBxALafwhO1dp2zpWPAk5J3HXqO
         6PcI+bdsQKR2DeFVOD2VUekON4gFQVu06bcOA9Eomy5+MB94rtg3o1DP2lM8vkJlrdVp
         6BWQ6jHBAitCdsj9JtUOcfyyki9SSd2tswGsluN8vkIudGrclGUCbUAi2Ae/c0+JnMsJ
         SN963JlDQpGO4LQYghqtsu5zZv//f4aJQZESsyZZAqzev4J9Q1z69r9EOm0huSA6haWf
         RsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHjoTnRNTZFA0ZBsqDkIXARH9jeUb+0DAfgRumKgoyA=;
        b=J4SsYLdI6bG9kykD3zaNhbDgok00jdcAhXmPauNfqgVY+Yl2ikr1JaWQphZSkRflmo
         /o+gOZpgKTyVRS4Wzjzyeut4GBNG5elG7AJZ+uXZU4XiDiKi4MHiw2NA553Qt7ovlFRW
         juIPOtAgchFzP8RHUxcWrfk0QCKeKz2GAD4E7U2uQ1Fe0+ETKlEMn3GLTH5HsvpmHlwX
         zZZ++XZ85uyXacxT8ZsLzfZFMUkK9DjXHGHPH2Xc89ad2MVPMXKvqIGo5k7ziZlMy5Hn
         xGE7zs6jgCrOjA5eGrljvDRKnWKwXoqMJZCHD3jS0IhD9cdNEIHXiX2KzjbySZSOM95a
         9giQ==
X-Gm-Message-State: ANoB5pm2FAf7CKghLzT5S9ujBR/6yu/SEqULJO7fJ77UuaD432I+PmqM
        5wAmmAkDNfvAjyLQqCYGtFkIgg==
X-Google-Smtp-Source: AA0mqf76Dkn/qsfn4A7uaYveYdNp3mxxfhohI84VViwRDT4kCZjSM4XJBKu3rIUNeF9yuK1lessWFA==
X-Received: by 2002:adf:f30e:0:b0:253:62a0:2dbf with SMTP id i14-20020adff30e000000b0025362a02dbfmr17910945wro.62.1671539821883;
        Tue, 20 Dec 2022 04:37:01 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id da13-20020a056000408d00b00242257f2672sm12641208wrb.77.2022.12.20.04.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:37:01 -0800 (PST)
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
Subject: [PATCH v5 21/21] arm64: dts: qcom: sm8250: Add compat qcom,sm8250-dsi-ctrl
Date:   Tue, 20 Dec 2022 12:36:34 +0000
Message-Id: <20221220123634.382970-22-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,sm8250-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for sm8250 against the yaml documentation.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index dab5579946f35..9240132efa75e 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4050,7 +4050,8 @@ opp-460000000 {
 			};
 
 			dsi0: dsi@ae94000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,sm8250-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae94000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
@@ -4141,7 +4142,8 @@ dsi0_phy: phy@ae94400 {
 			};
 
 			dsi1: dsi@ae96000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,sm8250-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae96000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

