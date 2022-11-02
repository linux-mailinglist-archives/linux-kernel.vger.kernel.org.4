Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B43616941
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiKBQhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiKBQgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:36:54 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A43F30548
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:32:24 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id h10so12812826qvq.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fuc9/QP7Bq99BMsjZQ93rqfxRXvHLvB+iExe/1RqSE0=;
        b=eH4qQTQH7l+DmWcmvt8NBT4516TegyhIOcmtqhvRmQmkZbskYegQN/oHgnQjtEyts4
         ZMmjymjKwT15AXtEfeR3xDbrwU1FDVtjlBD69kpYqKptfyMrmSX1Q5oqpjXvHpXjPtxS
         Q7VwD2suVVvuv+6p0SUII54NSX75Il5+YOPsj3SffuU9Cn2V1xSa+F/HOzKOAuK4skMv
         bNmwWdTY0BPWEI0N1HN6PJZ/ZM5n74nwdDQoReWWz0Bywi9Wtk8zOeUqR/mIUmR1XKk3
         J6coGodnwLatepAUxh7NiwWGpuOJ3KQq0ZRPQOGGus6G4F4mh48r+abH6hCOd1D4VKeN
         JlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuc9/QP7Bq99BMsjZQ93rqfxRXvHLvB+iExe/1RqSE0=;
        b=W1YgJdy4xk9Ja7C2aBGQ96E9+1O6lPOMGawOQiCCekhCR8fDHPTzc/187StgOiyqdv
         jsJOYIRvz20VFm4ZQH+hlKSfGLqUzNMLhH8lEW35t5zRU8RgANc3ukT0X2/iCNd1y816
         whwgqa2efB1WORNCBqxVhyhxb/ZIKvoA2p3gT6YW/Mhph6f9BoO5BKdcCz8Qe7CjVk2h
         Tjy4hWW4h3U6wNAUcDgQzWg2zUuaOHs9Ix+BqWkQP5eMviaV0n49wa6HGSBJckYzCwOk
         GlNxNJHQ/d4nZj1DVt/vlzinp+H0q+hPjRIgYPLjof3kLWHkUoQmB2JEQz0JN8fjvY4t
         TVYw==
X-Gm-Message-State: ACrzQf0bIaw99ZexEoH7OCygcKEKt6OTx9C1KLZs7CDJay4SDs+esew5
        JtLsINW6McCjT9L+SdSiuTXT8w==
X-Google-Smtp-Source: AMsMyM62yk1h+ACpFke4/NrH0cN1WANmQVh5FNIWnEi+z8uXOB4pt+yTptA8yhkeN8LkeHXLFDc6sQ==
X-Received: by 2002:a05:6214:21ca:b0:4bb:4a55:b63b with SMTP id d10-20020a05621421ca00b004bb4a55b63bmr21822954qvh.0.1667406721637;
        Wed, 02 Nov 2022 09:32:01 -0700 (PDT)
Received: from krzk-bin.. ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id t19-20020ac865d3000000b0039cc47752casm6820888qto.77.2022.11.02.09.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:32:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Martin Botka <martin.botka@somainline.org>,
        Taniya Das <tdas@codeaurora.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Govind Singh <govinds@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: clock: qcom,gcc-ipq8074: Use common GCC schema
Date:   Wed,  2 Nov 2022 12:31:52 -0400
Message-Id: <20221102163153.55460-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Reference common Qualcomm GCC schema to remove common pieces.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Add Ack.
---
 .../bindings/clock/qcom,gcc-ipq8074.yaml      | 25 +++----------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
index 21470f52ce36..ac6711ed01ba 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
@@ -17,34 +17,17 @@ description: |
   See also:
   - dt-bindings/clock/qcom,gcc-ipq8074.h
 
+allOf:
+  - $ref: qcom,gcc.yaml#
+
 properties:
   compatible:
     const: qcom,gcc-ipq8074
 
-  '#clock-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  reg:
-    maxItems: 1
-
-  protected-clocks:
-    description:
-      Protected clock specifier list as per common clock binding.
-
 required:
   - compatible
-  - reg
-  - '#clock-cells'
-  - '#power-domain-cells'
-  - '#reset-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

