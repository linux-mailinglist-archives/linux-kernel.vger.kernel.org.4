Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28EC5BD46F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiISSHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiISSGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:06:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C146445F5B;
        Mon, 19 Sep 2022 11:06:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c2-20020a1c3502000000b003b2973dafb7so5243615wma.2;
        Mon, 19 Sep 2022 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nFv4Tohd2giyViEtmIJ+DkJDZX8rBCWBLAqJ264IXgc=;
        b=DzprM+EVmuciNfN5MjSEQFntwLFiXzYspWF+B8bHoRhRHYpGlIVNhYHAe7LVd+vnr2
         9BCGJDWuiMto327LPx14iISVBQ5Qj3fWVvHvF9LCn6M41LDDRFpLJEBaw8tT9iDodJjN
         VcefXkiyM+p062WpDtMt1T82mQNKf3nGj+5So538bvFvLFfj4mTxg+1Oo8CS4mvB93Bt
         QDPaFnA0kZfDZUTVOihlCCBUn9N7+6NslsFCG4mq1lTTcTpxipqx36udcZVym3apBMaX
         HkuadDB+Zaf6ZNvgpPCIUhA1upFAb+aPU1F/FQuj8ruv//jwYPhX3lCUGaOiYM50PD/9
         h04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nFv4Tohd2giyViEtmIJ+DkJDZX8rBCWBLAqJ264IXgc=;
        b=k6IfS4SV+fgQtSFq3z0GF6+2c8/xtxFVmkRNJex5eT0G+9kMKdx06Uk6lKMhAdRw/p
         oJTqaRlVL66C6gSSzuW4AUEOWmcDPfZZdZsG0cHgFRzJKpywP/kVg/YC6k4a2qkNRkHn
         n9dOS1pct82/V8qEjNaPOolWbVd1YCVW0Xe3GinIQnWTySqDT+M4IUdYfGg97W5iYTUS
         rG4u6DrusJamGmDAgbshn9VIEZTyhhwQ63QQjue6HhaElhdnzbLhcsPMCRuaIDL/SK4I
         nmrxnuqqR6l0n0Hoo+nnkWjo4s9FFcPJtTGMXLz78rjJWIHhsDYZfvYNSjLfA77rh1GE
         DHyA==
X-Gm-Message-State: ACgBeo2oFSQLocl2N///qSL4KHEw+0GeEpQAQ9wBcLB5yFpSEjPMrFlt
        C3VH3Iq7SNzLlbNS1QPh07s=
X-Google-Smtp-Source: AA6agR7WFHf/c/7ZGkKNjSowQOgBbUt0q40ZFOAhfWInvty/BMFYjQ17wi0j/rWq2kman714us9Bsw==
X-Received: by 2002:a7b:c84c:0:b0:3b3:3faa:10c3 with SMTP id c12-20020a7bc84c000000b003b33faa10c3mr20015521wml.94.1663610801419;
        Mon, 19 Sep 2022 11:06:41 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b003b332a7bf15sm15051410wmq.7.2022.09.19.11.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 11:06:41 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] dt-bindings: phy: qcom,qmp-ufs: Fix SM6115 clocks, regs
Date:   Mon, 19 Sep 2022 21:06:15 +0300
Message-Id: <20220919180618.1840194-6-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919180618.1840194-1-iskren.chernev@gmail.com>
References: <20220919180618.1840194-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sm6115 UFS PHY has 2 clocks and 3 regs.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
index 6e3c186b9972..815c375d0f7b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
@@ -121,6 +121,7 @@ allOf:
               - qcom,sc8180x-qmp-ufs-phy
               - qcom,sc8280xp-qmp-ufs-phy
               - qcom,sdm845-qmp-ufs-phy
+              - qcom,sm6115-qmp-ufs-phy
               - qcom,sm6350-qmp-ufs-phy
               - qcom,sm8150-qmp-ufs-phy
               - qcom,sm8250-qmp-ufs-phy
@@ -180,7 +181,6 @@ allOf:
           contains:
             enum:
               - qcom,sc8180x-qmp-ufs-phy
-              - qcom,sm6115-qmp-ufs-phy
     then:
       patternProperties:
         "^phy@[0-9a-f]+$":
@@ -198,6 +198,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8996-qmp-ufs-phy
+              - qcom,sm6115-qmp-ufs-phy
     then:
       patternProperties:
         "^phy@[0-9a-f]+$":
-- 
2.37.3

