Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFFC6607F9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbjAFUMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbjAFULP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:11:15 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F336A3C0C1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 12:10:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so4357454wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 12:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFnUrWdhcpbNtSqH6LxEFiIYrDwMlWVSmVEBxpFj6cM=;
        b=mvWNmxWZiAXb3M0bCWC6WeMr0cnhJ78K19CTFV24cLloA2Z9GDssXD6y8YoofoDGPO
         qXyLmxNG2ISmO5pEjvDDNg6Efbxd8NxM9va1pCx7COSqxEMJoYQ4rq9ScOD1Y2MYm7nB
         WZqgcGZOGnPhlKt/IGqH0OwQnDAUpy1YrcmeMwv3G7G2v/oDmQphcHsZAEU164yWWp/u
         MfSA35xdhq5QvRCR1fNDbb1mg0L0KctDRyNw/f85EuyMxYOTo4Fa25JjU6l+8tEFWgud
         /bJgqi1WTdBvaK4YtjohzZS1SVdjOEsMQbRh88lDrABv0tY25LVeV/77ITHFDF0vJS7o
         r9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFnUrWdhcpbNtSqH6LxEFiIYrDwMlWVSmVEBxpFj6cM=;
        b=0bOmq7mwK6sDQ0d4lhNy9GK6jJIDIyZgrmp/zuNbjTJCzGC39GpgxguoxzqjumOSbM
         uRhSh9oNmElPeF+2MEAnHvxwlDXO3PX0RCctIZZCfxtWBRG6CWn61zXQCJJwi6VkHPqh
         kK0oKA/4noxNn4Lq8obXY/74jSPhEC7Op58x/ClnqznbjA6/gGAuh59+Bmh1xITPuY6p
         LXt+hsO7jlSK9lDz5DtjhdbDPecnNLCJm9NxZmjv4BCVxd+jl9x/VpC/I8/Ww6z6xWx9
         QftvX3P/QjF13Oh8zZPPkvPb5YUkDwlkUZQkmhCCvBb39l8OhmtWtIlmg1dwFgPaPmI/
         Gm7g==
X-Gm-Message-State: AFqh2kpmj1jhXQHMnG9H9+QSHSKqbE/6R58CyUx+HxHkp06shGdkJQO3
        008puBke0J2+ICFCOMXxCVmVuQ==
X-Google-Smtp-Source: AMrXdXuDgG4Cvk8z78KMgAIg8T9lDwPHaDfoKaBgZ6dSjWaFFwpKcE4Lb4ba+QSog5vYq/U57wXwPQ==
X-Received: by 2002:a05:600c:348b:b0:3d2:2a72:2577 with SMTP id a11-20020a05600c348b00b003d22a722577mr39300378wmq.27.1673035855451;
        Fri, 06 Jan 2023 12:10:55 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c220e00b003d99fad7511sm2665240wml.22.2023.01.06.12.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:10:54 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 01/10] dt-bindings: arm: qcom: Document SM8550 SoC and boards
Date:   Fri,  6 Jan 2023 22:10:38 +0200
Message-Id: <20230106201047.337409-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106201047.337409-1-abel.vesa@linaro.org>
References: <20230106201047.337409-1-abel.vesa@linaro.org>
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

Document the SM8550 SoC binding and the MTP board.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 27063a045bd0..f5a8fb4aa288 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -70,6 +70,7 @@ description: |
         sm8250
         sm8350
         sm8450
+        sm8550
 
   The 'board' element must be one of the following strings:
 
@@ -845,6 +846,11 @@ properties:
               - sony,pdx224
           - const: qcom,sm8450
 
+      - items:
+          - enum:
+              - qcom,sm8550-mtp
+          - const: qcom,sm8550
+
   # Board compatibles go above
 
   qcom,msm-id:
-- 
2.34.1

