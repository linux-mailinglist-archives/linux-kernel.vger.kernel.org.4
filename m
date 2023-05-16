Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59505704B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjEPKww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjEPKwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:52:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3714173D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:52:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965ddb2093bso2099117966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684234366; x=1686826366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9EHv3ysgWqpDvJne4zzetbniLNKwuwcftVNB7lMePiI=;
        b=yJFrK6Auu1WAYPkKLNAjoCY6y5xTy6C0ggygP803Nt4uVP5fd9LfYcTmvDZrDCEBIe
         I0lSjd8j061/YMDDxpHsc140w2KOVlUNPFKhkERsu5ByVoz+Ngv5+dvfQoLVm5WsaNBD
         KqbgwF+AIslhMZWTJCDa02JaWg0UPc3PZ9jK/nos2lUQmFS+9WqEs1KYHwyMNG05f4lo
         EEY9DUvG54jRGg5XvG53OaA/wsC+MiUfQiSAfmB8nGER5hf/LVvfCpznRP6gS72Da5Z6
         q+nQCoLnBs4KGH3UcYfiDkJCZhH60JRGHkioq6mziR5dn3i9UFIVE5a+EH2P57f4ow9/
         U00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684234366; x=1686826366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EHv3ysgWqpDvJne4zzetbniLNKwuwcftVNB7lMePiI=;
        b=Ge7MpCiU1Ub4EY5JKCkxqBIZXzEEUjiX9/F4f1WwagTFzaUtPGjYZgJ1h8/XgUxRyM
         l6PMEOrndfm3g5SYVNHnH1QHWK79H4qG8k5a05HJVxY095yNIeYAdRH+GyaMrhWZl9Tx
         Tet7NJnSqh2H1SjLGnQEYQ3cEbK98da/Sgp81DnrRmhd9n/Ltm65ehDjTxRDaeF/A1M4
         OsbMjNF+GXilhfJ5gA+q6cglZLIFTUcy0xiyjhM6w0rZi/2VhsCmn1VFpaCXBac080qF
         kagubJsSEfHvQGUr44DA5M4hjymFDZ5ROUuM2N70MN4UbDoNTyw3jkheIe9Ft8pkARmu
         eppQ==
X-Gm-Message-State: AC+VfDx9FYHpz9SBiFUoTtqCjbUxM5zQwFipumD/7vmadL7b1LT12ubt
        UQdSfNWrK/zpTOvFw/lHiP9drw==
X-Google-Smtp-Source: ACHHUZ5Uh/dzH5jYCI5KzhaC6eCeKzNAtH8Ml/nK7r5kIuoHaiMfgqythN4HHaJcZq2CpDu1nfe8oQ==
X-Received: by 2002:a17:907:97ce:b0:96a:4bca:8408 with SMTP id js14-20020a17090797ce00b0096a4bca8408mr20224189ejc.60.1684234366295;
        Tue, 16 May 2023 03:52:46 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id d1-20020a1709067a0100b0096b0e93193asm3679019ejo.90.2023.05.16.03.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 03:52:45 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: clock: qcom,gcc-sm8250: add missing bi_tcxo_ao clock
Date:   Tue, 16 May 2023 12:52:39 +0200
Message-Id: <20230516105241.30091-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial SM8250 GCC driver added in commit 3e5770921a88 ("clk: qcom:
gcc: Add global clock controller driver for SM8250") already consumed it
on the clock.  This fixes warnings like:

  sm8250-xiaomi-elish-csot.dtb: clock-controller@100000: clock-names: ['bi_tcxo', 'bi_tcxo_ao', 'sleep_clk'] is too long

Fixes: 98394efb48f5 ("dt-bindings: clock: Add SM8250 GCC clock bindings")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Re-word commit msg and fixes tag (Konrad)
2. Add tags
---
 Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
index b752542ee20c..ead6665b9a45 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
@@ -23,11 +23,13 @@ properties:
   clocks:
     items:
       - description: Board XO source
+      - description: Board active XO source
       - description: Sleep clock source
 
   clock-names:
     items:
       - const: bi_tcxo
+      - const: bi_tcxo_ao
       - const: sleep_clk
 
 required:
@@ -47,8 +49,9 @@ examples:
       compatible = "qcom,gcc-sm8250";
       reg = <0x00100000 0x1f0000>;
       clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>,
                <&sleep_clk>;
-      clock-names = "bi_tcxo", "sleep_clk";
+      clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
-- 
2.34.1

