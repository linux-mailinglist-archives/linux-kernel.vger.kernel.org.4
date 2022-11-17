Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61B62D8BB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbiKQLBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239586AbiKQLAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:00:25 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396E715710
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:58:53 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a15so2209029ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZKW7Ev5+0Dpti/uSPcNCqyxUeFWx9iDTQT51fsveLg=;
        b=quxf3BZ8jVfhc/nH7Y5CE/bla3ULvxP13BfTPHhR3AoxLQqMPtDbabE5WkoJSJVcbT
         Cc5e80IYpH3STs5PcoIK0RvyN6Td6aGkbcH5qPaB/OQ8DRYpdDIvS2yfvMK6SqJrMXuY
         zAWKPkUx+yEOFvHYAc7BtYnrNEQ77G+RkxHmIyPKUeL6nA3wT2yg8Np+o85KGP+YJyXn
         O0sYxV79eU87VZ8VBLsqbnZnfYbRq/3d7uAit2Wj5Wx7wZgDXCSTNDllVWm8AkPVh14T
         0gBkHRNSB+L+muDgNinsqszA43/BKrqUcTAlmn8+oeSa8vKUJVI/LVMM7Gq/rJqqY/QS
         PWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZKW7Ev5+0Dpti/uSPcNCqyxUeFWx9iDTQT51fsveLg=;
        b=DprN50g62d5xA1GZRcgPH8r0bF7yfGeCaF4pVa4fZWsFCDR/MZPdORH9MaGifJ3D+0
         rKIxXbPX3cQuGhycCswACU9fTt3VRwpo9SrYO6W9O4Vtb0ObTMwzuu1byQNrQrOpsKUc
         gEsFCw6g9W6IglWUDE3Rbvva7oMIJHkpNi377otUmbfCViiboOrjX1pLQ/craHLwOKdo
         ym3dexOC1uy3pJwQam5I5WSZEFuWzwOHYz+CCOIwrnjCx/BMzMhGuHMQW2oqiL4xZddq
         w7G5VhSaZcZn07Jhd68oOG59Yx3H7GDWLkykKa5Zy5WBNkw1epLfv+45QbAoNxoAGgsl
         xs4Q==
X-Gm-Message-State: ANoB5pksbeN3CSm2IbU4TqgmktDJj2J/HadN00K8p41NSpjld5bQTYBO
        GfP1HiMz9Z4aVHiWO7UgAE2HhA==
X-Google-Smtp-Source: AA0mqf7W4EMRFi2OnsiKBzqOxyeuq84IcdSi96tags2STd3idC6wFnnCdxHHFXFUUX82J9aujE/fWQ==
X-Received: by 2002:a2e:3819:0:b0:277:2217:9ee2 with SMTP id f25-20020a2e3819000000b0027722179ee2mr761928lja.183.1668682731658;
        Thu, 17 Nov 2022 02:58:51 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id d7-20020a193847000000b00499cf3e3edcsm89123lfj.296.2022.11.17.02.58.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Nov 2022 02:58:51 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: watchdog: Add MSM8994 watchdog timer
Date:   Thu, 17 Nov 2022 11:58:45 +0100
Message-Id: <20221117105845.13644-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221117105845.13644-1-konrad.dybcio@linaro.org>
References: <20221117105845.13644-1-konrad.dybcio@linaro.org>
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

Document the MSM8994 watchdog timer which is already used in DT.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index d8ac0be36e6c..a1f17c9e02db 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -17,6 +17,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - qcom,apss-wdt-msm8994
               - qcom,apss-wdt-qcs404
               - qcom,apss-wdt-sc7180
               - qcom,apss-wdt-sc7280
-- 
2.38.1

