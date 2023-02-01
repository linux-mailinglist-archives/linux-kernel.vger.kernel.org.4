Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3280E686A5B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjBAPbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjBAPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:30:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547255DC1A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:30:42 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k16so12974610wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14Mi7+OhNuEyZNc7DiLz+rkr+x6COhOfkexl0o6kozQ=;
        b=s+wRAp1uEsnL/+iaA/XDYYGqFrEXhmBd5iSGiNp0AXDZ94Vj6VE5FSgXpvxmrVCB1+
         fzgxmglsxGxXm5EjLeStK6BhzYzNvPxZbbgYp5Dfd0VogrUk3FNWlkIF0MfM93wbR9lG
         SVp3s82gf/qWDUQJlR3pv5/BRDXslPQsiInWuqNl+7KW9kkx45tHJMM7xiyYG3Ry23W2
         yMmSXzj9HCkWcAoV0Uk6qwnTP+CJbH0p5ViVp9MZi3COvL4tz5RYG31ZuFlShO6xZyzl
         cU1aG7q0sBdP8aAVghh0+rCnzTEQv0E8dCLFFnmjW6Gdd1RvxbTy1F2PbkI7ruxKBYpv
         hXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14Mi7+OhNuEyZNc7DiLz+rkr+x6COhOfkexl0o6kozQ=;
        b=0+DlK8KCm897vTyG3pgLpVRLAYPKo54n7C3qqXdzReC6fVHdMSj7YOLuv+1pSLIuGU
         MV2R+rBMLpZ28CIlPnmzBjAOzbIQnTQjujz+oFH0dA2pa/+E03hBVTS14F3/xXdkXgiz
         PU6FCB93NuIQq8lMWjBeeJJmeLrqn99OhsUvGxBwhgCNOC5LLQ4zah5zFIsAPJMHNwgS
         qH+Yh19ZQGdCHWiDGKgy87aq5MIPuznDHCWosj7tFn3WHgZhruIt0gtZ9a10ISCEqKvK
         KDeuQgnMz+pUyO1cBlJVlGByIaPk90VCR3NCZ8agFif++yXkTA7K5sOTzutn+txOFCNr
         x+7A==
X-Gm-Message-State: AO0yUKX3jOYwkBmHf0OMiGWFth5GwAdJnPBSOBVWRWVEHLFTefQnkQUC
        C4ZCxQN7Jho833n6CE2nUwq1HA==
X-Google-Smtp-Source: AK7set+/fxIw/6AP66xR4HipmCgO57GDV2jpI4cZMsP3FKcEAGub+CNfBOvv5AUv6ssGk6Ana/tqmA==
X-Received: by 2002:a05:600c:b88:b0:3d3:5a4a:9103 with SMTP id fl8-20020a05600c0b8800b003d35a4a9103mr2506288wmb.31.1675265440772;
        Wed, 01 Feb 2023 07:30:40 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c544b000000b003dc4fd6e624sm2168032wmi.19.2023.02.01.07.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:30:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/7] dt-bindings: pinctrl: qcom,sdx55: correct GPIO name pattern
Date:   Wed,  1 Feb 2023 16:30:17 +0100
Message-Id: <20230201153019.269718-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201153019.269718-1-krzysztof.kozlowski@linaro.org>
References: <20230201153019.269718-1-krzysztof.kozlowski@linaro.org>
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

The SDX55 TLMM pin controller has GPIOs 0-107, so narrow the pattern.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
index add3c7e64520..a40175258495 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
@@ -55,7 +55,7 @@ $defs:
           List of gpio pins affected by the properties specified in this subnode.
         items:
           oneOf:
-            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-1][0-6])$"
+            - pattern: "^gpio([0-9]|[1-9][0-9]|10[0-7])$"
             - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd, sdc2_data ]
         minItems: 1
         maxItems: 36
-- 
2.34.1

