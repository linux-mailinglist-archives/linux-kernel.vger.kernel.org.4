Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0996520A7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiLTMhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbiLTMgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:36:54 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748551263F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:51 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m14so11582712wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqJ/2ht7lbI+cE9vNUibll19HYg9bvHab40pOiTr8QE=;
        b=bWiX1bT4m3K5rX8A5b9lYS9TWaxEfROhuNxLiByd3L6Cwp6mtPbZ+0zrxBO/POeUi7
         76ZB/l3/eli14mBS3i22/0Y6W9Z+u1gJxbqlG7LweUCn2giuESt/HVd86OaxcH/+UW75
         EIJo5sLLdasrKwwHvClaM6/d5ZHcWuH8AGoqEU+AbdNn9/MXFV9Pxc26SHa6oX0L6XWF
         t/nD78fMJPAY7U0O6RRCq5tbUf1vIYief2ktc17hGyGJ/jfLQ03ZGgbc+pwgPVCkP04A
         xfCEXNsnPsHImBDjseF8P1TjXN8kN99aBEcHi+DB3hpzJPjyARm6FaybKXqooS6pKG7+
         Diwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqJ/2ht7lbI+cE9vNUibll19HYg9bvHab40pOiTr8QE=;
        b=cixA5sPX04WOodQjHb0ShTacdeu1MqZYReSXHXGh8KTwfcIP93Xpp3EeaYBsvr4Sx6
         Bc4Ps4xOzdaDGaV8qHg6oIfQmTVRMDFkyVwwQmTggBycf44dK5eglTqcfqmmdFmpgriV
         0U7rmVtsnmvau+HNxE+tKjkNVbaLZjwIpUYltxFZpgxMYMJHiohC4jriErWK/37xCnv0
         QiYlTLOiG2qZOuUKc6XRn5v1gZ/t3atKVRHg5TAbNPBEMdFCOmBIkbm9uB3Nbd/b2rid
         d2i+AqAim+6hJ2bjCmPw/d1u/qQMKFnjY8ExqjkdcHYsqCrw2Rplf6eKZgXKdZklENUL
         0fSg==
X-Gm-Message-State: ANoB5pmAJ9OlDy+AaRYX05Jt5LYrntK0B8tEe16KYAjhgreRdY6ojTks
        EZBzfWji5t4mH+O3PeC155SpSQ==
X-Google-Smtp-Source: AA0mqf6Sc9Y+9CNxhHcnsKtt7FIMeS3KstnOErEjMMoR2KOLlNbcn4cz/d+S1IX5I0KfAVTuzBy7gQ==
X-Received: by 2002:a5d:5d0b:0:b0:23a:5a31:29f5 with SMTP id ch11-20020a5d5d0b000000b0023a5a3129f5mr32784279wrb.23.1671539810014;
        Tue, 20 Dec 2022 04:36:50 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id da13-20020a056000408d00b00242257f2672sm12641208wrb.77.2022.12.20.04.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:36:49 -0800 (PST)
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
Subject: [PATCH v5 11/21] ARM: dts: qcom: apq8064: add compat qcom,apq8064-dsi-ctrl
Date:   Tue, 20 Dec 2022 12:36:24 +0000
Message-Id: <20221220123634.382970-12-bryan.odonoghue@linaro.org>
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

Append silicon specific compatible qcom,apq8064-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for apq8064 against the yaml documentation.

Reviewed-by: David Heidelberg <david@ixit.cz>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 0da9623ea0849..1f3e0aa9ab0c8 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1277,7 +1277,8 @@ mmss_sfpb: syscon@5700000 {
 		};
 
 		dsi0: dsi@4700000 {
-			compatible = "qcom,mdss-dsi-ctrl";
+			compatible = "qcom,apq8064-dsi-ctrl",
+				     "qcom,mdss-dsi-ctrl";
 			label = "MDSS DSI CTRL->0";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.38.1

