Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25E868C56A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjBFSIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjBFSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:08:23 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06567EF3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:08:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d14so11195284wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 10:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tn5oHPpbipDMcz7STqyrZPY8+V7f853nhQ3tf36w4Eo=;
        b=li8K7Lik3LGY7JOaQ7GiUdzLXPHgOnG1lFTZlz8/YpiYdkE/lkZGLo6epPXMts6GON
         kBwXRaV1MYXx6zDSdCrsdad/d8JLDqpubAbNtkrJLpwRRp6tCK0cSZDCV+2bqAIFew+j
         bip60U5h8FtqNzjDABYqo6+7U+ZX2DQ2bWqCrcEFTD9Rm5jKt/0cxfodJPbSDjcan/Pu
         ckM62PF2lTwyBYmiONAK5dENFmT1hBy1No3p7FN35GD+YKISb3ag/ses6i37SbulBoQR
         bZdFco0aGOq7yYqhl4zsb3v4w8SzXPq7b79ilbjmKJ9soli9twQinp0rKHGB6r2ICtdL
         bjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tn5oHPpbipDMcz7STqyrZPY8+V7f853nhQ3tf36w4Eo=;
        b=jxLnSpe2g2CXwpEABsvCcG/D5hiZCew08V58bD7PhSAkOmfZagKHAGD5aCIMPjynpt
         CBA2mfRaXLVPLYmKfjlaYSQHp+XZaUz8OtTslj9e+QNa9qlbVAzORJgxoEPJ+XlwH5ss
         fINz75mMuzOTksrpaKsOy4dNe7oWDWOm9HkHha2dICexFvF68pqQ0JypvY2ZIyG1OSRF
         IsaUBC5G2l2YinAV59TyJWsFjK86DxX02uFYgykkp+a6p5LpabAVD0bSaq6/4LxEaG/i
         5bGa+yEDzK+VR/EBhEOPprvvDORTU15/3wBr8LDdkb+/Ikc82/3vXATvqietN4hGFNm5
         PeLg==
X-Gm-Message-State: AO0yUKXb2MEX/OP6+v+ll/BGANThn7jnA71XSplwIzlKPuEIp2BDfLJy
        Y1Txtf1YykDhowCMiMwAXeK+aA==
X-Google-Smtp-Source: AK7set9dnqk2147Pm0mc3fAGlCuyJDoc1kM1Q9A0N2U32IxhrwhVkkjlG7LBYt4A8Oy8QWwh5NAw0w==
X-Received: by 2002:a5d:6805:0:b0:2c3:eda4:adde with SMTP id w5-20020a5d6805000000b002c3eda4addemr2518807wru.53.1675706890160;
        Mon, 06 Feb 2023 10:08:10 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d18-20020a5d6452000000b002c3f1214e33sm365451wrw.100.2023.02.06.10.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 10:08:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH 2/3] ASoC: dt-bindings: qcom,wcd934x: Describe slim-ifc-dev
Date:   Mon,  6 Feb 2023 19:08:04 +0100
Message-Id: <20230206180805.6621-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206180805.6621-1-krzysztof.kozlowski@linaro.org>
References: <20230206180805.6621-1-krzysztof.kozlowski@linaro.org>
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

The "slim-ifc-dev" property should not be just "true", because it allows
any type.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
index 184e8ccbdd13..39b27126cfc1 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
@@ -28,7 +28,9 @@ properties:
     description: GPIO spec for reset line to use
     maxItems: 1
 
-  slim-ifc-dev: true
+  slim-ifc-dev:
+    description: IFC device interface
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   clocks:
     maxItems: 1
-- 
2.34.1

