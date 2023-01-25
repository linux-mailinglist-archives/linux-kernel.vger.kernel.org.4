Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FE767AD55
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjAYJI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjAYJIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:08:55 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB11DC662
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:08:53 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so742044wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sF+NbwG3d0SXyd+w9CGOwS5V+wHVHgGRIB1Vv65RfW4=;
        b=ZWrIKDuUi3xvqvKgoHlNBI3N5mKVytsVXnEpwpDbLuTaqSBniGX+ox9bf938gpk8jt
         H9efII5W8y6VumMOo7nTj2EnIXWml7+JW2SxwQTLXg5W3aKQyLTCQBOZoNxROtjHlp4h
         NMbGirP+YenRX6bdA/md5/UjuzkwkdfUR87pPS5i6uqhn5suxigqU478/Zb2OJIqRvYT
         h/z2c07uxlv8IO4tWj85LYStXlZamuppYXBBObn1JhykQiP8G4fj/TZbJHBJLdyE1bkz
         JlNz4iFeEzqRWuPy8tfWt3tQnn8qvhZ92rIKApzJjLo1EQIge/J3u4FmbhxUJ1jJZDmW
         8IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sF+NbwG3d0SXyd+w9CGOwS5V+wHVHgGRIB1Vv65RfW4=;
        b=IFpPwAzDYKBUiCzBTpQ8ufPchHerbrl5W5A+ZJQh3vUFCjcvyyQ1SYS1KoG3Gg+NoP
         l5hkxvIzVaTqedgjK5/7f8xMrmsM1t5zztEUYEdbkFebiT+H8DTROtPv2ctOL/5FYyoc
         rU+dp/kANU+4+rAfwZyIhtctWBcvKx9ZQOl9KAByiMwtymy42DIXr1ikqU61pEf/u0aw
         HXPXRIkJuHLzddKLI9Ql2R1nIPObXku9Fy37SExBWMTaCKZPr8ZuIhf7fe2q8qfGkno1
         CVgUJgyKg3f+RxFPIVxyuIW6JyjzhI6tp9MWMZk0qNFqJMOSg6qnxkMh+idyfYAKPiMJ
         laAw==
X-Gm-Message-State: AFqh2kpmioBX7CiVQhfwpJw8fVgUIFtlJCoH6DBMMUDrrKd0aBLWI+ly
        oEr2nHiAJ5QJq4tLgXlI/rTtVg==
X-Google-Smtp-Source: AMrXdXvspCLpjak/blAkqScmjuu7tOfRkMdKuuRUnkH3nrmuuQvbcbNJUkPnLwAuNPDyLikW11ck/g==
X-Received: by 2002:a05:600c:35d5:b0:3db:fc4:d018 with SMTP id r21-20020a05600c35d500b003db0fc4d018mr28490606wmq.40.1674637732378;
        Wed, 25 Jan 2023 01:08:52 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c13d300b003daf98d7e35sm1198258wmg.14.2023.01.25.01.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 01:08:51 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: interconnect: samsung,exynos-bus: allow opp-table
Date:   Wed, 25 Jan 2023 10:08:49 +0100
Message-Id: <20230125090849.122189-1-krzysztof.kozlowski@linaro.org>
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

The opp-table can be located in the exynos-bus node which uses it, so
allow such child node.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../interconnect/samsung,exynos-bus.yaml      | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml b/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
index ad9ed596dfef..5e26e48c7217 100644
--- a/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
+++ b/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
@@ -196,6 +196,8 @@ properties:
     maxItems: 2
 
   operating-points-v2: true
+  opp-table:
+    type: object
 
   samsung,data-clock-ratio:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -227,6 +229,31 @@ examples:
         operating-points-v2 = <&bus_dmc_opp_table>;
         devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
         vdd-supply = <&buck1_reg>;
+
+        bus_dmc_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-50000000 {
+                opp-hz = /bits/ 64 <50000000>;
+                opp-microvolt = <800000>;
+            };
+            opp-100000000 {
+                opp-hz = /bits/ 64 <100000000>;
+                opp-microvolt = <800000>;
+            };
+            opp-134000000 {
+                opp-hz = /bits/ 64 <134000000>;
+                opp-microvolt = <800000>;
+            };
+            opp-200000000 {
+                opp-hz = /bits/ 64 <200000000>;
+                opp-microvolt = <825000>;
+            };
+            opp-400000000 {
+                opp-hz = /bits/ 64 <400000000>;
+                opp-microvolt = <875000>;
+            };
+        };
     };
 
     ppmu_dmc0: ppmu@106a0000 {
-- 
2.34.1

