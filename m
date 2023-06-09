Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC7A729C65
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbjFIOJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240985AbjFIOIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:08:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EF74205
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:08:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so2374951e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686319671; x=1688911671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PhmYSawgzNKNuzax3sHGLO9z0mLewXtxDLqfsn2NEbU=;
        b=yVYQDbwdGODQAV9l/6RLa8KOyLe/vy44PIuB0JRMlCHt4fnOSKH90tpE2Ipe2qOJiQ
         ROXxOFDQnAfUALLsN2nEGXwgKxnN0CNhjLKAhOrG8rK332AYFoR65uOENP/3ut+mw1iR
         7CvDmLsHHZhOHWpGH7gHnq7AuRelBbgz1R6G+6wWDf6wAoL6nyvc8v/LmhA6IGGl/3nq
         rBiuE2P4/HOUKs/ir4NxxsXkgol1UwQ1z7/pW1lqeinxHKZbwQ7JHEsCUE1+3eMuJETO
         r98cayRSIeSvzq8qU1hc/opJ7PYPedmpSA/gjqAwNIWNXPk2kO3QB/+vQtJQwvoz4vF3
         OJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319671; x=1688911671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PhmYSawgzNKNuzax3sHGLO9z0mLewXtxDLqfsn2NEbU=;
        b=WYaryzd5b0IvShcEzbW5FRVzbvpI92K1h/nvINAdYL0O0/sqwBifB4HMPIJuqPOGt8
         0AH2511pU8Uoie4+JUTc8o85Xuv+rCRFuAPyQhhD2RA55KTIm6PWT4/ddPGRciQ/8UXW
         y3Wg7iCFsNgW0cCdKkqQ6Vff46usxgq1qzcTAwzb0qMUHUIMX4qFguNOzP+Ht0GsFHT5
         4wNEVx9Tr4AKiUTj8H3yiIV2xKWrZ/A48p/StkE1J1zo4zl+9J72EAnO17c0+3zWLQLE
         VFQpvIWC8ZKycTb3O93lyk88Uwa+2PcGd95gQM/2hVP3LaIsDfnpBh45rDCncDk/w1cm
         rM2g==
X-Gm-Message-State: AC+VfDz0SOYBWN2cRkAxZnkucQ7IgWowGbGl6gBLN9jK3h0MLlhH+Plr
        2TEUdC0wVWzK55x/uwm8bx5DbA==
X-Google-Smtp-Source: ACHHUZ4PvtEyG18pr/mFyuRrrJIhvCWT2a8D1K+v89rtkxVCZhj+RkR1AZX8GfuaCJNDru40yZWA7A==
X-Received: by 2002:a19:5f16:0:b0:4f6:25a3:95ab with SMTP id t22-20020a195f16000000b004f625a395abmr962129lfb.25.1686319671453;
        Fri, 09 Jun 2023 07:07:51 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z10-20020aa7c64a000000b00514bcbfd9e0sm1826855edr.46.2023.06.09.07.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:07:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: firmware: arm,scmi: drop unneeded quotes and use absolute /schemas path
Date:   Fri,  9 Jun 2023 16:07:49 +0200
Message-Id: <20230609140749.65102-1-krzysztof.kozlowski@linaro.org>
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

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.  Also absolute path
starting with /schemas is preferred.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index ad776911f990..b138f3d23df8 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -218,7 +218,7 @@ properties:
         patternProperties:
           '^regulator@[0-9a-f]+$':
             type: object
-            $ref: "../regulator/regulator.yaml#"
+            $ref: /schemas/regulator/regulator.yaml#
             unevaluatedProperties: false
 
             properties:
-- 
2.34.1

