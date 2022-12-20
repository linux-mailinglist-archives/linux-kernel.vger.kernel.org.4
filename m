Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791A96520AA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiLTMhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbiLTMgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:36:55 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C5E12606
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:51 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o5so11607738wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZdjxc2y9QTXw1oO8jfVxT9zUH2M6g93k1qq74sNBIo=;
        b=VN2EHTlMijRwA2gumbvAukjq5JQGGSzpEZHISjpbp7wHa5cT/oLZL72zN6GkR4RqBx
         5xGTGNH5eCWEIIra7WEJBoK7wJjqeC9Ylk+7n25byjRFdow2zMkZ9pXMTTlnogagQf9K
         RAzL0oK46q3O3CVNLXT2z5DZyUH1OPIwtMI1Y7hPqUkGF8zDy2m7IJb+8ocdvKRAccxH
         ofhxSnNL/YW3BeBOUlZnOiNHavF5MWsXlMaRlKlACTnxvfMQYCgGtqfzQSMj4X/VpvHD
         G4nVAml5D7BlqPb7dTrlseDzWNBdJjxr3oYC+ZwgctGGd1ub5f7PLGyFpCoUg3vEyQPc
         SWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZdjxc2y9QTXw1oO8jfVxT9zUH2M6g93k1qq74sNBIo=;
        b=worTOHRHaNyfulgIZhydAFoKpLx9gUnNhRTruaIeDdtQGKKor98E7YIPKs9nPzUAd/
         MXCcBqzx49Ym9+65To4taggNi9xi472VPQR1TjdjwLhGxKUGIzViXuVDSVyYe4pqosyX
         Dlovh13uqa7yAIq5unbYyNxkD6c5M57xa0ToSdj8IAE21UZjiJdrI2/IxB0hyEf/iDf+
         Xykp5uJwjJ3KgVr6x+vllbFtzyVCcho1ftdUrIEPYroL7PAli8fdO/nJDi8JUYAmvK4R
         NIbNcDuOFpq+B+I789ggnXz6AZ6PweYp+jvrGp8U7CZrFkf1VDcrngWhOyr4lplpuQZc
         GOqA==
X-Gm-Message-State: ANoB5plgdnRkZCfGhYBTHh1GnY6UjGub2suS5guFJ70+0f+SeWDXMmJY
        iatO1CZXdo2GyesTXe5jB6urLw==
X-Google-Smtp-Source: AA0mqf4ou8Wfv7LYEJf9ZX1y6xnGlJwzjYjJHVlXJxS9zugLliWxBQgeTXDN5gQNsC2iGal62WS7/A==
X-Received: by 2002:adf:f643:0:b0:242:2ae6:7c27 with SMTP id x3-20020adff643000000b002422ae67c27mr25980964wrp.19.1671539811192;
        Tue, 20 Dec 2022 04:36:51 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id da13-20020a056000408d00b00242257f2672sm12641208wrb.77.2022.12.20.04.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:36:50 -0800 (PST)
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
Subject: [PATCH v5 12/21] ARM: dts: qcom: msm8974: Add compat qcom,msm8974-dsi-ctrl
Date:   Tue, 20 Dec 2022 12:36:25 +0000
Message-Id: <20221220123634.382970-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
References: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,msm8974-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for msm8974 against the yaml documentation.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 8d216a3c08511..3ab3665b28aaa 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1579,7 +1579,8 @@ mdp5_intf1_out: endpoint {
 			};
 
 			dsi0: dsi@fd922800 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,msm8974-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0xfd922800 0x1f8>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

