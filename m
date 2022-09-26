Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD685E9B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiIZHtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbiIZHru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:47:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEEE3845F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a8so9451101lff.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mweOvkpICMOfupA+AxR3sUo6cDzRelMcpG98SvyuQUI=;
        b=jC9uGJ1Ey+WuXAAFg7tQx+ROr4bWC+MZ7BAcBHS/Xt25KellApdOodcvEds8ANPidZ
         bDZ1aTP0GKD6naMWPhyhbjHjqi7Qfv/lsvM1uBE4tbkKJ3E+Mdox0rkR9Y9dfas27geH
         TRD4VFkjWYo7B8IjLxUb8WUyUF2T82skwSDepLU6alzBFJ06GwpVy2ot33rvQ/qD/t+f
         4lXOE65toZMkes7sT9r1D2IUSHgHeNOveTbDmp9FIxo8RzgDnNgfkq3X27xrkblBOS3o
         tQhb+CNUVTkAWF8vRpS9NU5sr1YHadrDwSm3Achyl4c+wlNVUryg/1M5W/PfIAue0048
         CHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mweOvkpICMOfupA+AxR3sUo6cDzRelMcpG98SvyuQUI=;
        b=49wR06HIDzMvx76DeT+chg8PJMHUnHrLutWEkl10/sGNNGEDDY1hnyuliaWK8jvyZ6
         TWryCdo3IHX13I3pA5Rb2KqT8v3VewNZAOiHH7I9JslIHBwgAN3593ODzeXqWiTOqqV8
         QEc/J+Ov0dYCH1oa9VBQvepIt9a70ZKkq8z1D3U8vwdVsjZLJn080SjYGmN78HSFIc9l
         g9aw0AOgb/rNJ7YMg9XAms2/ETgZcVME3/kSuNYs9/EWkiWH5CHxhgLLIILC0RbppHRD
         aYkrfdtBrKPy8z7TSdKqyVGmGe127GiNKvmh7EhMPi/+8RxrrlL9LXkXOsOQf/Zzd3k6
         BYzQ==
X-Gm-Message-State: ACrzQf0f+/2azxE6TnxQDus5/6oWyJLd+aNBs3QyqqMEeORE6vUfbNJq
        00f7wJygmJgijOgw1rYupIku1Q==
X-Google-Smtp-Source: AMsMyM7h3Usjznp+bqIol+3YyF81DP5TOSGr6pZAZ3NVwPiOa1sEASGbLIItdJFVPJQRX03RlvEu1Q==
X-Received: by 2002:a19:654d:0:b0:49f:5309:1cb6 with SMTP id c13-20020a19654d000000b0049f53091cb6mr8046571lfj.522.1664178325297;
        Mon, 26 Sep 2022 00:45:25 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2453298lfj.266.2022.09.26.00.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 00:45:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 31/33] dt-bindings: pinctrl: qcom,sdx65: use common TLMM schema
Date:   Mon, 26 Sep 2022 09:44:13 +0200
Message-Id: <20220926074415.53100-32-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
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

Reference common Qualcomm TLMM pin controller schema, to bring other
regular schemas and additional checks, like function required only for
GPIOs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml       | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
index 0f796f1f0104..f5451b1a3a2f 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
@@ -142,10 +142,12 @@ patternProperties:
 
     required:
       - pins
-      - function
 
     additionalProperties: false
 
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
 required:
   - compatible
   - reg
-- 
2.34.1

