Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9126520B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiLTMiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiLTMhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:37:05 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D93E192B7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o5-20020a05600c510500b003d21f02fbaaso11000068wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPzBwr0BhPjdigQ+qhuhYo7cFKy33u7lIc5bsk5u6zc=;
        b=zdYDioXderfwfcpoqEGSszKKxODISIK+eKBQGtZazVtj03hImGlDylU1a+r60Dr6K+
         pjoH9kaVjyulD41ZfMC9FuYp+wIXMBfi1szB6Fr3e3hOKh0nqIUPbgOLdnQZ+GnrvLTY
         kLhPZJIFez08nw6BHtEz8yYbSQ1SI4ugFS7pcAL8ZHB9HBZBBADtKjYAPVlU98fBoWVp
         gDPn6XCWO3UMYNK7sY1Gs+zO0hg0xHgjBiQ7Uo55RO8N/5bt4VDlyIssqT038bPRLfnh
         yY7YK2BEuq/4diuvujMDCfwvaxwZMDZe/m2jJSmV6uJk6KELOygUGLJUqgsdkVYnlzYs
         F4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPzBwr0BhPjdigQ+qhuhYo7cFKy33u7lIc5bsk5u6zc=;
        b=PCQ2AZr6zRPtGC/6lDmHZNEGWB38bOvhWbMstSCPDz+GyTzwpaBleJ9B2VlRl0d2pU
         B91TYhH/haw4cwh9pMvi6ZiMw/T9Rr3T10XA1CJWAfMaakvDJbE6nLyHuecDpqDzNDPi
         1PbxQV16Gr8iK5UPuybykep4HNeLG8XMmKzy8We7qZRtShOGp0ThPgOfu5wFXM/Q93RY
         kTFVGhfTV9uZ1zQOQsM2YPIlp6zqX4zIEkXb0DNI30YMVS8OWyhPgZWwqsylb4LL0oT/
         DcQsiqb0UGFTmeL1WmwHrF4TIEZA9a/9fuYdUEvWOS6z6yZuNyUk54AdmAzd1Mkii9+l
         7QTQ==
X-Gm-Message-State: ANoB5pmi6PtkMll9CJbFf4T3ETSvE+qo+PPLNFDfnEfMf5+sKnDOqBuO
        aXmc1mcCpmAhgRcHd9DVenVQ0A==
X-Google-Smtp-Source: AA0mqf6VMHNvsxwSU1zPalndDOSTwMiH2KTdJZPfExa9hIaCyC9VM0n9H7myjiH4rhd1cZpyqvVTDA==
X-Received: by 2002:a05:600c:253:b0:3d2:17a5:17fe with SMTP id 19-20020a05600c025300b003d217a517femr28733739wmj.18.1671539815933;
        Tue, 20 Dec 2022 04:36:55 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id da13-20020a056000408d00b00242257f2672sm12641208wrb.77.2022.12.20.04.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:36:55 -0800 (PST)
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
Subject: [PATCH v5 16/21] arm64: dts: qcom: sc7180: Add compat qcom,sc7180-dsi-ctrl
Date:   Tue, 20 Dec 2022 12:36:29 +0000
Message-Id: <20221220123634.382970-17-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,sc7180-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for sc7180 against the yaml documentation.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index f71cf21a8dd8a..fbd6a7b31eac2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3022,7 +3022,8 @@ opp-460000000 {
 			};
 
 			dsi0: dsi@ae94000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,sc7180-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae94000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

