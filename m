Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0103662043A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiKGX5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiKGX5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:57:14 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7919226AF0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:57:08 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso8089503wmp.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 15:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aR2aM+umkOavgwYVWqhmYHGmDZmfsaMfN+B0kO7Pu1o=;
        b=iSOHWTQRdZWcro4nT9FC8/iLXnfAAEPMH0mGw9t2wNso0itE+JpvaVtB5rJWtsvqR7
         chZxEBdUU+SoE+eoJ7GJhyjtf1Js07DQURVcKGkJbdolQ0PCyn7kNxZZISpTF109PBJk
         Ihh9qRR2fFjso5jO8QoNIAuRl2dDeCtJUxHtBgKYrlS3Cv61DNRPWW1jVvLNPIpqQZAk
         bBaDczlxF7keuz0xc7qIMHDzIQJSUhSwlx1XiMpVh2VoPdByBQ9RmcQhr/7JSqwHNuP6
         Rnb0T+yBDX8g3MZgmgQiOG277WIQMIr/LQ0Stmo8J7jwKBWDuSNcHeZMxFMSnPPh8SwH
         C4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aR2aM+umkOavgwYVWqhmYHGmDZmfsaMfN+B0kO7Pu1o=;
        b=y2l0UT7orx+8sJjbT9dP+/HB3uVcX+b3OHMHMPnJOpcYHO3JdYt+VKRZtvrGyoa/wW
         lbp/uG6ojA0c4v+156K3lQ1GxFSQxbCUq+DDyiK7Xd5UNcs1NBcNAXEA+2XInnZymbIN
         3IlDBJeqJGG8jIe0BcNgZiOvoAoQKkfJ/Jqcj5fHoRCEkt6jvZuC+S1KiKSHo1OSut4Y
         1a6UryWf6eXPwxHTBIhG/tUOUwEjqYLdKgrsfv8Ck9k0kUiUv3QoBrNItNetNuDzzUUu
         ixUxl7SgOuGIbetfCLBhiINaanlwU6HQ2j1DCHNUVGEZuxS+6+LOmf8Rskf/KuywndFA
         c11A==
X-Gm-Message-State: ACrzQf2vIq01yzwI4ftAvva00r0pbEnZEJvm7PBk+yNWSSe9hgRkwD0l
        Y8DBJLB6xHut9He5kFY2dwWRYw==
X-Google-Smtp-Source: AMsMyM5glwdyXlYGHMS2W9oYIwoMJoxzk1x71sZ5VcM87dx7QQY6J6nB9oQmIejDX2wShM7B5waHjA==
X-Received: by 2002:a05:600c:5398:b0:3c3:dccf:2362 with SMTP id hg24-20020a05600c539800b003c3dccf2362mr35973962wmb.89.1667865427078;
        Mon, 07 Nov 2022 15:57:07 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b18-20020a056000055200b00236545edc91sm8386161wrf.76.2022.11.07.15.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:57:06 -0800 (PST)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v2 10/18] ARM: dts: qcom: msm8974: Add compat qcom,mdss-dsi-ctrl-msm8974
Date:   Mon,  7 Nov 2022 23:56:46 +0000
Message-Id: <20221107235654.1769462-11-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,mdss-dsi-ctrl-msm8974 to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for msm8974 against the yaml documentation.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Brian Masney <masneyb@onstation.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 21d943d4b02d7..ac9e4c194051d 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1545,7 +1545,8 @@ mdp5_intf1_out: endpoint {
 			};
 
 			dsi0: dsi@fd922800 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,mdss-dsi-ctrl-msm8974",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0xfd922800 0x1f8>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

