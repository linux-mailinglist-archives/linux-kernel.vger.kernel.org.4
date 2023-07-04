Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAC374770E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjGDQm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjGDQmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:42:14 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D277210FD;
        Tue,  4 Jul 2023 09:42:12 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso93768851fa.0;
        Tue, 04 Jul 2023 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688488931; x=1691080931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEUe4ghhfetmw/fCeUTDTMc801j3sRXLiEJrKSWT/UQ=;
        b=rMMOsB+v0x3Q5r+BEUgXQJOpot1P7bGTCXUAkRfhBsAlL/lzzbWBMKs8v5pkyaEVca
         +ytyjS4AsaeSOJAgm2pl7Jxx1aPBZSka/4OR2eabj2pm4AJ3TY5CnCCq+bYP81g3cukL
         5q9Cm+AOClxNirOqrUgbzKC9GojKyStKPsnSrsT9z5rxyVEPkVTDniWD3SUQO9vK0m1P
         V1FAwApTuThb8K8ArwTd3zz/rlaFH9ugqc/CT9U6tyO8ED3VuA0OCoXXCjpRkFaDyvAb
         HEHMMi3VeZ8eVb+OFMeWTUi/LFpb2FAOLTWXYErSGdjyiux7ri6yNFR+XYFpq9pHVv2R
         uVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688488931; x=1691080931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEUe4ghhfetmw/fCeUTDTMc801j3sRXLiEJrKSWT/UQ=;
        b=Inez5/+NLBAuKyhT53axlGiAQdSLurU+IZ46ANQqN3EefngHZqPXeHGTiUS3wUKLex
         dNHmv4Nlk3dbReb3+WaIS2lrpBdWd3ZerMQnApz1aHtAdtDaODm4oSS8FjW3bGULS9Nr
         bb5eZUHpLf8zhAEaaNwHzsVloLlunpMbRajQuXb+SxW2fvaq6rmzNzeS7PNN03icyNiz
         xT21tiAvpY+TiYOKP/npdmBpviwkqaoZq8PE/mzNBondU8qAj7wlDCHTffpHBomBp54B
         021PrEWQymY0l6CaiRV9dxgWas+fl71hyyyD9lKSOiUbicqclpPj4Hsd32PFunipCPFQ
         V0KA==
X-Gm-Message-State: ABy/qLYw6wRuHlCbeypQMqV6WRUQu946UvO6qPgTPuk7HRtBc+dDW8SN
        Dey18ehqbvOQ+bsDxLoxIQw=
X-Google-Smtp-Source: APBJJlFMtQF7T6uEdmN+jTwHy84oFCpCf7dl6KqwV9Qo6/EPWbp/L0rY4k+TPkM0WjCKfMvDfHaxyQ==
X-Received: by 2002:a2e:868b:0:b0:2b6:d0af:effd with SMTP id l11-20020a2e868b000000b002b6d0afeffdmr8998391lji.4.1688488930838;
        Tue, 04 Jul 2023 09:42:10 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.169.176])
        by smtp.googlemail.com with ESMTPSA id u15-20020a2e2e0f000000b002b6eb5db863sm1181920lju.43.2023.07.04.09.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:42:10 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH 2/7] dt-bindings: arm: qcom: Document SM7125 and xiaomi,joyeuse board
Date:   Tue,  4 Jul 2023 18:31:55 +0200
Message-ID: <20230704163848.169853-4-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704163848.169853-2-davidwronek@gmail.com>
References: <20230704163848.169853-2-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the xiaomi,joyeuse board based on the Qualcomm SM7125 SoC.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 450f616774e0..862957f845f6 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -77,6 +77,7 @@ description: |
         sm6125
         sm6350
         sm6375
+        sm7125
         sm7225
         sm8150
         sm8250
@@ -929,6 +930,11 @@ properties:
               - sony,pdx225
           - const: qcom,sm6375
 
+      - items:
+          - enum:
+              - xiaomi,joyeuse
+          - const: qcom,sm7125
+
       - items:
           - enum:
               - fairphone,fp4
-- 
2.41.0

