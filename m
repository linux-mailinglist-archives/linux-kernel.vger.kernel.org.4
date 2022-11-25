Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1882638A18
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiKYMhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiKYMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:36:57 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5CF4E428
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:36:55 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so6121154wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+k5fH615JqiFsP7tNa0DK5jiBnHb78Vs4d6jr8q48o=;
        b=jQ6Zd7GyZIgl/JY44Vp2h+1APXR5T6P4Kf0y0vEo9HUPL9nTB/TV5heH9EKYPYL+Sz
         lzws6Vz3Y8Q6ZFfnK6Xya74aiexAZ/TrJLfW9tKffNBEwOewRK+POhu51QrxJ2HQjTPt
         SwV2JDLZuI+3CVXCoUKmjoTwA0aFqUnPJI+FeHmVHun3/ou9HYOK7ZbE/QlH85rVxrG7
         tcu5soKz3zJgtKDj2HV7wqB2gy0JQQo5lJ1T9jk/ocnGegzbTx+Ohh7KisWDX1hzntcr
         TJ/1Dp02dlvDYpq/wqHbj/m6XLt56kDa9+SgTORGoB8PgvZdY6rHey1HhODZrddJ+NCh
         GMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+k5fH615JqiFsP7tNa0DK5jiBnHb78Vs4d6jr8q48o=;
        b=i4dunJTi0qNfrCJ7oIY7MzohMN0V+fXP6Gdn6II13gjhvpVLRFjcXRrHyvTF1qvZxO
         ZHHOS48RcXSwsbcs6j63ojuL3eImQ0OQYpW+edLHlROfX433Ev2gkcn3HEsVMHxQ5nvS
         De5QF2x9P/ll4vdprxNYOhlz2QqkK1jIFxH23WwtcKWraEspUUMRWnmYYXxe3mTsl1O0
         1pZi8Zw9lJLvLt34bCMsxcsmLQX3rkybZUH1WBDIlDNyVZ8Qi++GcDIVszVT6CoCXEVq
         vshOgdYLFHnu4dfd7cpoqd5gTJtNJxtOdolzo0TdCNci2ZXhr+/P5Pc3pIcByLkKwkf2
         SYkw==
X-Gm-Message-State: ANoB5pkCRlAnDXtWbJVCOaH7zEw+IqFsesPvmc4ePVME5/1n0eDp1zjP
        p/PN95dxSgV3K6BB3IXJM86Gzg==
X-Google-Smtp-Source: AA0mqf4giw5RG8Q/UzlwLRZ1kyrijQNXVYA+s9uBtjUGeAdawHL1V0fytg/2MVZEqDg9+4Ck722HxQ==
X-Received: by 2002:a05:600c:4aa9:b0:3cf:68bb:f5b8 with SMTP id b41-20020a05600c4aa900b003cf68bbf5b8mr30754573wmp.67.1669379814001;
        Fri, 25 Nov 2022 04:36:54 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6d4f000000b002366dd0e030sm3574111wri.68.2022.11.25.04.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:36:53 -0800 (PST)
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
Subject: [PATCH v4 10/18] ARM: dts: qcom: msm8974: Add compat qcom,msm8974-dsi-ctrl
Date:   Fri, 25 Nov 2022 12:36:30 +0000
Message-Id: <20221125123638.823261-11-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
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

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 21d943d4b02d7..b4361f4318ece 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1545,7 +1545,8 @@ mdp5_intf1_out: endpoint {
 			};
 
 			dsi0: dsi@fd922800 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,msm8974-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0xfd922800 0x1f8>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

