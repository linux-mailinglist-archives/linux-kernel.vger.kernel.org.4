Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C610B6C9D27
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjC0IGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjC0IGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:06:32 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD5C49C6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:06:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ew6so32180903edb.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679904389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BiNqTeeVrWQOzoZkyp1Ne+Y+AeYFGXw/DSHUvZsNi9U=;
        b=utB9KGwJVl/qvFQcQXspBeh++ITcLsDKWbbjzrzuwn/GC0zRL2hy7sGeyOnBYi/5lW
         DrRsnGJZfcnLQkp8hQORJditRaSdg6E6/cEKxRRBJ3laWqglnzjZry2m+dH8hd+iRYDb
         NEP9Rf11RdBQQv4pwTToD6ETSScvKCYbyPg84X7Yo50Y4h5DEv83QbKpsBtlZQQIdsqs
         uolsxwmg7mneol3mTflcsX+3fSrBjMv1uNuCvn38IWeyDvru2b6X2i+PXwyzkET6meYY
         +x7Sa1qDCYUj7Q0wjwS5FcUJRWnDUQmOo9VkNlfIWQTWVGSkAzz5/2MZD1ivHo7jofO4
         DVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679904389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiNqTeeVrWQOzoZkyp1Ne+Y+AeYFGXw/DSHUvZsNi9U=;
        b=714V5IdyS6Ye4xGkhMmxVkTmbQo+xQ9lJbTgs6X0IOx0+JCG3B/efmE8ypGNvARyXa
         2TjFHf2ITjcvw3pcj9oqLkRe+VqXNEwv+DxjKc0l57qF3dOKDjeAdgr03AqYjrvOfSU4
         BHMFmUrHcTZYVX7CBUTI0sLjanosMYs4tK3bXJV8nzhevjVlEzQueZjCEEDAHwpzUnap
         KPIkDsJ/f2KQVIyD3lq5mWbPr1CDgepoKPaUaecy4shXM98qgcy7iWXaRB6siy6WXDcu
         fylZMx/uXp22pUcpPss2u9WvZcQ0g2+ySzFH1pYfPCnEeneE9LqdX7SJwuvlyJXljbsA
         /SmA==
X-Gm-Message-State: AAQBX9f5Y8fVwTtN5gdFJkxM0JEnI+M0vwiBt7ZiWVCEX+DPlUIhn1PV
        tEkITAYz9+W1gJIcUBJz/jb/SA==
X-Google-Smtp-Source: AKy350aKdFA5s1jscL7nmuT5RTgLChtp8awsB8wJKDz650hj2LinA+5B0TsFuxXFzF60aarWBrE2SQ==
X-Received: by 2002:a05:6402:1002:b0:501:c547:2135 with SMTP id c2-20020a056402100200b00501c5472135mr10258056edu.36.1679904389024;
        Mon, 27 Mar 2023 01:06:29 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:198e:c1a5:309b:d678])
        by smtp.gmail.com with ESMTPSA id f3-20020a50d543000000b00501d51c23fbsm9764527edj.6.2023.03.27.01.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 01:06:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>, Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH 1/2] regulator: dt-bindings: qcom,rpmh: Correct PM8550 family supplies
Date:   Mon, 27 Mar 2023 10:06:25 +0200
Message-Id: <20230327080626.24200-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PM8550 is different than PM8550VE/VS, because the latter has much
smaller amount of supplies (l1-3 and s1-6) and regulators.  The PM8550
has on the other hand one pin for vdd-l1-l4-l10 supplies.  Correct the
if:then: clause with their supplies.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/qcom,rpmh-regulator.yaml  | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index a765837dc069..74e3acf92d21 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -308,19 +308,29 @@ allOf:
         compatible:
           enum:
             - qcom,pm8550-rpmh-regulators
-            - qcom,pm8550ve-rpmh-regulators
-            - qcom,pm8550vs-rpmh-regulators
     then:
       properties:
+        vdd-l1-l4-l10-supply: true
         vdd-l2-l13-l14-supply: true
         vdd-l5-l16-supply: true
         vdd-l6-l7-supply: true
         vdd-l8-l9-supply: true
       patternProperties:
-        "^vdd-l([1-4]|1[0-7])-supply$": true
+        "^vdd-l(3|1[1-7])-supply$": true
         "^vdd-s[1-6]-supply$": true
         "^vdd-bob[1-2]-supply$": true
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm8550ve-rpmh-regulators
+            - qcom,pm8550vs-rpmh-regulators
+    then:
+      patternProperties:
+        "^vdd-l[1-3]-supply$": true
+        "^vdd-s[1-6]-supply$": true
+
   - if:
       properties:
         compatible:
-- 
2.34.1

