Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB23636F67
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiKXAtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiKXAtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:49:07 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1241A1025C4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:23 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id g12so221375wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIJDbyegl6u8zeEPDRjfbckMoUQq7Dd8VduqGlrKmeE=;
        b=JlbA9+8W450YbRnk4VYcS3AdEM2Va8QQwzmvPTb8phkZo5MqG61ujr+F5SSG69Cno2
         gT+l/WoqdumqULNpM6lhJ0OjoDUsE2q0lTwhFGghl6zjlw2W59ARTkvIZEDMKzuB8PlE
         sbA+1FaOJ2oj/L8puLQ6gTSfV5HMDvEFaLHZ/Rm290qPmUtxeJNTDzLRYe8FyFQIo7MB
         /FfraxLNDYUvD49gv+HXzXrLd/vsNctsoRz6CHOEgt0jPpapG7KF2rUXTRuHvqqkfHaS
         AoO8NXOQshhQ6WWpWGSTDtoU6WXrQfPFLANtBFGxQ9UoFNdgvA3tAxxcS8g+GThC0Gg6
         i3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIJDbyegl6u8zeEPDRjfbckMoUQq7Dd8VduqGlrKmeE=;
        b=VUHuLoM537r7gY/sOH0Ei+f2nP3Gr2cU2Ts889TqfDM5a/T9P8fpJHXDLcME2K8qog
         KMQwlWWJNsEhFSpS/ZHBEm3RNtZVcvh6YF0Uh0u+Xf3d0D6CBE5wDROrU0qa1ANqMXAf
         +Ecw4FSBV+efob0V5EPgC5zb6+tB73jWGIAT5++eBZMBN/19VERnLa03Iz9Bw76HQTIP
         Biqkmrxd91nyUmqH6IbUBIR7mhlTwTBNflc45FM1Nu2dLCMNKodDvWzE5mT+66l8pvCK
         HhD1sYreGKpvWhOHDNn/Qx1GBjc4WVxHeO6tjC4YIUNH4jDdFhmIqOSYby+OAtaitwo9
         WiqA==
X-Gm-Message-State: ANoB5pka0AvXcwKMX1NObksohBiPGcztyqYpcd7IcWTNuJ9DQG7+SqgU
        JSZipOqajJ7NViYR1fifwoBU3A==
X-Google-Smtp-Source: AA0mqf4MZt+wx+bbi0GWwMA/YGWDOYht44nKXvQxpfQF4vjdgr98EfXiMvTzdAqTsh34jZ5BlSjkKA==
X-Received: by 2002:a05:6000:46:b0:241:bc67:c7af with SMTP id k6-20020a056000004600b00241bc67c7afmr13010638wrx.91.1669250901571;
        Wed, 23 Nov 2022 16:48:21 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c3ba600b003c6bbe910fdsm5245076wms.9.2022.11.23.16.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 16:48:21 -0800 (PST)
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
Subject: [PATCH v3 14/18] arm64: dts: qcom: sc7280: Add compat qcom,sc7280-dsi-ctrl
Date:   Thu, 24 Nov 2022 00:47:57 +0000
Message-Id: <20221124004801.361232-15-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,sc7280-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for sc7280 against the yaml documentation.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index a4d6e866b5999..3368531e004e8 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3903,7 +3903,8 @@ opp-506666667 {
 			};
 
 			mdss_dsi: dsi@ae94000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,sc7280-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae94000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

