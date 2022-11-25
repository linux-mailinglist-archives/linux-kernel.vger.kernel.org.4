Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CF0638A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiKYMh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiKYMhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:37:14 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C994E402
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:37:04 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso6277705wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx2lQyIeBTqpqJ7X6Q0LzKVhxGjP5f4ToZ9EXleXAr8=;
        b=zL1kLPDxZd8QFdr1kbsDaEbxJo5nPTa3ap05Rfe4QZjimKYqzsubfXUXxysfcNGUI+
         TsW4yI7Kzs8nDVwrQCnVJyQqek0Fv2wvN8u3eSloAP++Hk5YBQOg97G2zypVK2hFEWlA
         ElowF0V6CwhPaRUoQdIlKf4vdF34xCPdpVGV/HCrNI5rApZXWeWb6CmcvtWeslRMqLe2
         kXRULzCzdCnsyuYMLGKO3CIsXdFQGp97A6jmOPJiZXHyItAvK7b8wp/2Bu4EQ9nni+1l
         KYqD/HgkrlVjlSbE+DxAcMffIasPjPybObBNNSxtk3n9p9I8+BWwUz+uBe+PvGTRSIaC
         HV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dx2lQyIeBTqpqJ7X6Q0LzKVhxGjP5f4ToZ9EXleXAr8=;
        b=m05CP254Vrq2p0jjvNcYehJ/BOTObdWL/BExKuiPxVOr1hkZapSiL6dAZDJDkflOsn
         FCCAVlZUX1/7d3JUOAkiPw9ja6JvRMbRLQAKU+hpx7gDVBVZXGj7MW05irtq/O9Hjo9c
         KeXWfaGC5wK3vWaMA6NDCm5fI95LzC2BrOqOq3CNiOfeHSrmSwHnPUeRUBmnyMz+YV59
         pH1C0Bf2/k9dRFMfBGDmEAFDFn860MYBunIHoGgRaj5raho06xlaI0WJBP9aNeLC8TH6
         hGP/Rn/WE8wIV3cYL1iUma5hocOwzWND8m5reU4oyHpV66xxycZidnFX8t8Iv4maY0v1
         1NRA==
X-Gm-Message-State: ANoB5pnjfRM0IOiluecvNt4Dugycodb5Qs5skdPKNDFDiZHte/tSsKrl
        vnZZVKVINWWfi3ge96aT7bbKjg==
X-Google-Smtp-Source: AA0mqf5x4cWUrXL5IEWLm84sdI/yALSHQjV/u+S/A6ZSDK1EiE1plFgxTlYUNwfJSCErQBdxPi3WTA==
X-Received: by 2002:a7b:c048:0:b0:3a8:3e58:bb9b with SMTP id u8-20020a7bc048000000b003a83e58bb9bmr17356780wmc.168.1669379822645;
        Fri, 25 Nov 2022 04:37:02 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6d4f000000b002366dd0e030sm3574111wri.68.2022.11.25.04.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:37:02 -0800 (PST)
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
Subject: [PATCH v4 17/18] arm64: dts: qcom: sdm845: Add compat qcom,sdm845-dsi-ctrl
Date:   Fri, 25 Nov 2022 12:36:37 +0000
Message-Id: <20221125123638.823261-18-bryan.odonoghue@linaro.org>
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

