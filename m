Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D44A65AE7E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjABI7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjABI7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:59:15 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708892662
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:59:14 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id y25so40782296lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 00:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4q/jhl+3gZkrvW3nGc8IjCx71O7qM9VQv4+FQ3jfK4=;
        b=OODQjf8rzsECesI4/DlAy5E/7P5nVKNg0lV1B9Xv8ILMlNkm2Yym4c4r0lwkXnCoEq
         3YS9B9m/beohywqDiF2OhJGAqWnhcaSnOzHoxkeMAdz2UQABwhHOzQCk2Yx7ZEmCv8/h
         kZEJn37eo//zRMt8mznFLHx2FAlUAmBPp0C2gP8MfuN1nF+svRmVUCEECKrP7pHlA0aa
         queXEG8Xu074Yc6TbMYcBe7vp8D00EgyFek3AllapVNNtn+ODVq3S5+OnpXD5uTMRRYk
         l3hb30Zs3VwvJwxOwO59q+0VzB11eyBOZMGhMLAMA10psY7CSzJasLBDwj3isGK3iX6l
         /24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4q/jhl+3gZkrvW3nGc8IjCx71O7qM9VQv4+FQ3jfK4=;
        b=O0jeCju5t05hSa7FwsnS3dDOkHT1knUUTAHCjECVB4PYSvnNebQF/Pm7Nf+F30rMfw
         lzxvr4eC2moybxh2BTfjnuDPIVdcq4ts/9KzRXDUK07dKaFQ1qymFlHsOqie+dI1JJKH
         TOrAO0eATNo8g3kjwd1XSCrPZ82vdFDBpT6COa6NNMwxoaYd7RJxbny1XrhzA3BLZLvN
         fsb9Ml3dt3/irz/KwD8HlEQzTnEtwNcaWMAoD6jGljZX60VQk6GBM5NB7ylQoqHB0HjL
         zvaOoHF0HFC3GGegw/TekJkEN9f7pKpjJx1ofD6A2Eyk+H5jPNIUBTL2qFHLQeWHEKa9
         pEYg==
X-Gm-Message-State: AFqh2kqXLblSdJEotSO6sOmH3BH9oKkjt1ORxdx44tQazulD4yyV7lR6
        EKEyWaimK5ZgYJ9Pr8A74I98ZQ==
X-Google-Smtp-Source: AMrXdXspJWKdIifZHT3HNdT448iaptTWyDEqqaBpjqDxBVVjJnOAtDMpV+0t1lZYPG9PjGA2DRekLA==
X-Received: by 2002:a05:6512:3901:b0:4a4:68b7:e71c with SMTP id a1-20020a056512390100b004a468b7e71cmr11302705lfu.6.1672649952849;
        Mon, 02 Jan 2023 00:59:12 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y2-20020ac24202000000b004bd8534ebbcsm4370798lfh.37.2023.01.02.00.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 00:59:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: clock: qcom,gcc-sc8280xp: document power domain
Date:   Mon,  2 Jan 2023 09:59:09 +0100
Message-Id: <20230102085909.24620-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

GCC clock controller is supplied by CX power domain:

  sc8280xp-crd.dtb: clock-controller@100000: Unevaluated properties are not allowed ('power-domains' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml       | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
index c9d8e436d73a..5681e535fede 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
@@ -55,6 +55,10 @@ properties:
       - description: First EMAC controller reference clock
       - description: Second EMAC controller reference clock
 
+  power-domains:
+    items:
+      - description: CX domain
+
   protected-clocks:
     maxItems: 389
 
@@ -70,6 +74,8 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
     clock-controller@100000 {
       compatible = "qcom,gcc-sc8280xp";
       reg = <0x00100000 0x1f0000>;
@@ -106,6 +112,7 @@ examples:
                <&pcie4_lane>,
                <&rxc0_ref_clk>,
                <&rxc1_ref_clk>;
+      power-domains = <&rpmhpd SC8280XP_CX>;
 
       #clock-cells = <1>;
       #reset-cells = <1>;
-- 
2.34.1

