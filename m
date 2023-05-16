Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5C8704B21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjEPKwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjEPKwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:52:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC531FC2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:52:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965ac4dd11bso2788143266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684234367; x=1686826367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpFcS6/U9h/RuUhlPguO2VViFIPJnqooFYL21zecDWc=;
        b=oSwt8ld8+bVPwcINZk+d5vBEei0mVDF0WO/J6YM7l5ysuBQvGHgKIXSd3W1NTAhgu9
         06XkGhYdkyewpOZkUUmE7Va9dC+PjzAwflNxd3VPu9zyGe9pesszAYKPsimh0f2whMpn
         WUkyh/qpp5ygRQVkVWsuDVqaDI7R++cimIYYyL17PuI/fKwCZhk7ydYqxa52j+VzFE+L
         /k4CEqYTuyLTc91kyamhimmfQUVAuMtmhRscbb04CW7DZwC1wcJaFJ2yZLgop48dn5++
         picHH5Z9j9hw+Cjkufhup3hIw8EQEA0x1VpPVDpUncqsIVGrf+r7T/LaZtms3kWV6nuC
         JYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684234367; x=1686826367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpFcS6/U9h/RuUhlPguO2VViFIPJnqooFYL21zecDWc=;
        b=QgYqNE6Wcw1mfjgJlRyYhym8um6g4nAVfEAm1ZD9tYrCVBRrBqgaRw1Zl5asrvjHKj
         7tS76JoF+yJlRwDYg8Pm+2CIiHM3XQ/o5ETZvI/MfKMjhQ/1uCiKbwwYF0vLX0xZ9XVI
         5FniesixJUy/lq1YbWMkSQ94e/KsThDvr2GN/6C0GAwAUiTvJD1FANrGg4CkqDWgN+Aq
         gey1EgHm1HokTnznxNqNZzSsIHvT8VyIAUzix4ElVRYC4ycsfPBW8m+YB7GI7Sk4bCJ5
         PwHoDcXWiebPx8bAobtDnzX/ZtbXluDLCfn6jUZRP4AgzYGsFpPVaMfWcnluFm2l1XLM
         hkeg==
X-Gm-Message-State: AC+VfDzECEQ2xUOjAwq1tGKCgvme6eNptWIIF9w1NgrE8bnRMdY3WU7a
        cwlj1wteIAqV9gTMUDypQHHk5Q==
X-Google-Smtp-Source: ACHHUZ4WIw3zHChy/kqbDEGUphyZGJjoFdQUKQslKtrGgvitcaudx5Cg32uWGTNUi43IpRsUm7pY/w==
X-Received: by 2002:a17:907:6d23:b0:96a:349a:6c91 with SMTP id sa35-20020a1709076d2300b0096a349a6c91mr20924070ejc.23.1684234367633;
        Tue, 16 May 2023 03:52:47 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id d1-20020a1709067a0100b0096b0e93193asm3679019ejo.90.2023.05.16.03.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 03:52:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: clock: qcom,gcc-sc7180: document CX power domain
Date:   Tue, 16 May 2023 12:52:40 +0200
Message-Id: <20230516105241.30091-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516105241.30091-1-krzysztof.kozlowski@linaro.org>
References: <20230516105241.30091-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCC clock controller needs CX power domain, at least according to
DTS:

  sc7180-trogdor-pompom-r3.dtb: clock-controller@100000: Unevaluated properties are not allowed ('power-domains' was unexpected)

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Add tags
---
 .../devicetree/bindings/clock/qcom,gcc-sc7180.yaml         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
index 06dce0c6b7d0..8bf9b6f49550 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
@@ -32,6 +32,10 @@ properties:
       - const: bi_tcxo_ao
       - const: sleep_clk
 
+  power-domains:
+    items:
+      - description: CX domain
+
 required:
   - compatible
   - clocks
@@ -45,6 +49,8 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
     clock-controller@100000 {
       compatible = "qcom,gcc-sc7180";
       reg = <0x00100000 0x1f0000>;
@@ -52,6 +58,7 @@ examples:
                <&rpmhcc RPMH_CXO_CLK_A>,
                <&sleep_clk>;
       clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
+      power-domains = <&rpmhpd SC7180_CX>;
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
-- 
2.34.1

