Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC2E65992E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiL3N5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiL3N5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:57:02 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54C81B9F1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:56:56 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id y25so31829442lfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEDYZvgVyPAOOlZ0Tdi3/I1XVgoXj6+wIYuf6RkBBcQ=;
        b=SVYgleMkK1GY8G6ghzN0sBA+L3RE32NOprRkU2Dt+303nLWwJEUytp3TW1g93UUhwT
         HmMC9qFUWPrMlzfmswbpZmbKDxxg/Y2QSz1Ju4/AyQ0rv4CndbOIaXguFHQuF4Xmc1Hx
         XR+RF2+q5V5TqnaUeTnmfl0hW09OyUE5iTbuipGl7cPirU4URUArmR+jPV71KzWLu//Q
         oisQKPmIR4r08ipRuw0oAUHrpsbM0Ovek5gCn2cPaH93BESuNNy38ebTN6soaI0GtiOm
         jCdqSY3An56/1omkjVitHHg9RKgFU1BaEb4xsysLaFlst7zGGeQ4skSvJVBqGSbCjKDX
         BwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEDYZvgVyPAOOlZ0Tdi3/I1XVgoXj6+wIYuf6RkBBcQ=;
        b=8CgsF5Idsnzeq6vaRECrflB0vgV4KdxOq59q8kvMwZu9U6Jdmir522e+MrhCVUWINq
         PEm08hutFetM0e4DNQHGOgtIiVCcCNMeq01ENYUdN7eCYyrOVDMoxskTR4in8LH3Ll6T
         5CLOLSP+shNnfJ7ZAUnUuXbIQD5JfHJMSJ1LZwiEkzRDEqZQcIrLzuW2U5KuSTrTQY46
         HrogDMGo5czv3zwDvfjpxv5Zy4OvJK4+cjBUEKD9owj8PGkSHYCReDTcQJpWJT2N/dzR
         3mQ+8t/cSPW/KMQBtOwf6plZrvHGSZB+OMaCjpjirRrDps388NcatvvZ1imumrPdbkvk
         Y5pA==
X-Gm-Message-State: AFqh2kq5957fXa/4eWmtb6CiGOP7XqmCTO4tVscFmgsAUXokVcFMXrKU
        1S8Kn8c0jtI7MTKyVPRFMcDzvg==
X-Google-Smtp-Source: AMrXdXu8hYQd0R8KQAFYEmjNDR+a1cROCHaSs8wU8I3jVHKf4C8rdiFUk4xvRpUb9yvn7mD+M7jd+Q==
X-Received: by 2002:a05:6512:131d:b0:4cb:c3:9363 with SMTP id x29-20020a056512131d00b004cb00c39363mr6508692lfu.11.1672408615248;
        Fri, 30 Dec 2022 05:56:55 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d9-20020a056512368900b004a26ba3458fsm3454787lfs.62.2022.12.30.05.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 05:56:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/9] dt-bindings: pinctrl: qcom,sm8350-tlmm: correct pins pattern
Date:   Fri, 30 Dec 2022 14:56:42 +0100
Message-Id: <20221230135645.56401-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
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

SM8350 TLMM pin controller has GPIOs 0-202.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml
index 7795cae01e26..7b483e93bfe1 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml
@@ -68,7 +68,7 @@ $defs:
           subnode.
         items:
           oneOf:
-            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-3])$"
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-2])$"
             - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd, sdc2_data ]
         minItems: 1
         maxItems: 36
-- 
2.34.1

