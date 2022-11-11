Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80D6625F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiKKQ2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiKKQ2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:28:35 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C66FD26;
        Fri, 11 Nov 2022 08:28:34 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id m204so5341992oib.6;
        Fri, 11 Nov 2022 08:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WlWKqilQvfT4UpBgWLtBIrqId5drbsn0GWpy9R/E6MM=;
        b=dL6gAhqUYdsj8+aUkemkN4Ol9grQl2VfX/NHPM9H8/7E1hFY4YFcTg3vL/viPqW2Aa
         U7D/txLVw0N930vQahXbHmq3tV+77F7j1plUNb+h41oTE0QseSf7nfrKhpr4qJiR2TTz
         Jh54uEcWG/SzuOFJfHnNOKR0BzFysZ2WSKCR0+JSmOD1PZlj7y1asgm83ttq4M6TBgUI
         AfS1nDzu/PUUmxqlIlu6b615zQjhcgCzH1Yj0QabMD/lSy0g0rDwveUZ+cmq69h2mchj
         +4g0ZSiEwta3Yhv9TAF8yb+EGN8zBRq5kmHUfvONABaVWT5kUcivZfTR4TC8H6mMleDl
         w2tQ==
X-Gm-Message-State: ANoB5plCpfq2SlsbiLG7ht5Y4KvoJtVkh3hvPwQypeUNHw9NjFrjP3Iu
        JiO/KyY4U3H9seP0m3yS1m0oEoW6Dw==
X-Google-Smtp-Source: AA0mqf4GhyWvktF5Cl6SZWd3YSGG1Wt6QGNqW22NrXhzSOMRuw7mgEK0rV6rDOLgLcKJXrrMvLL79w==
X-Received: by 2002:a05:6808:1813:b0:35a:7300:7208 with SMTP id bh19-20020a056808181300b0035a73007208mr1182508oib.75.1668184113206;
        Fri, 11 Nov 2022 08:28:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fo20-20020a0568709a1400b0013b8b3710bfsm1467802oab.13.2022.11.11.08.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:28:32 -0800 (PST)
Received: (nullmailer pid 3383310 invoked by uid 1000);
        Fri, 11 Nov 2022 16:28:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: thermal-idle: Fix example paths
Date:   Fri, 11 Nov 2022 10:27:29 -0600
Message-Id: <20221111162729.3381835-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference by path (&{/cpus/cpu@101/thermal-idle}) in the example causes
an error with new version of dtc:

FATAL ERROR: Can't generate fixup for reference to path &{/cpus/cpu@100/thermal-idle}

This is because the examples are built as an overlay and absolute paths
are not valid as references must be by label. The path was also not
resolvable because, by default, examples are placed under 'example-N'
nodes.

As the example contains top-level nodes, the root node must be explicit for
the example to be extracted as-is. This changes the indentation for the
whole example, but the existing indentation is a mess of of random amounts.
Clean this up to be 4 spaces everywhere.

Signed-off-by: Rob Herring <robh@kernel.org>
---
The dtc update is in my tree, so I'd prefer to take this via the DT 
tree.

 .../bindings/thermal/thermal-idle.yaml        | 154 +++++++++---------
 1 file changed, 80 insertions(+), 74 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-idle.yaml b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
index cc938d7ad1f3..72d85eb64247 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
@@ -48,99 +48,105 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/thermal/thermal.h>
+    /{
+        #include <dt-bindings/thermal/thermal.h>
 
-    // Example: Combining idle cooling device on big CPUs with cpufreq cooling device
-    cpus {
+        compatible = "foo";
+        model = "foo";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        // Example: Combining idle cooling device on big CPUs with cpufreq cooling device
+        cpus {
             #address-cells = <2>;
             #size-cells = <0>;
 
             /* ... */
 
-                 cpu_b0: cpu@100 {
-                         device_type = "cpu";
-                         compatible = "arm,cortex-a72";
-                         reg = <0x0 0x100>;
-                         enable-method = "psci";
-                         capacity-dmips-mhz = <1024>;
-                         dynamic-power-coefficient = <436>;
-                         #cooling-cells = <2>; /* min followed by max */
-                         cpu-idle-states = <&CPU_SLEEP>, <&CLUSTER_SLEEP>;
-                         thermal-idle {
-                                 #cooling-cells = <2>;
-                                 duration-us = <10000>;
-                                 exit-latency-us = <500>;
-                         };
+            cpu_b0: cpu@100 {
+                device_type = "cpu";
+                compatible = "arm,cortex-a72";
+                reg = <0x0 0x100>;
+                enable-method = "psci";
+                capacity-dmips-mhz = <1024>;
+                dynamic-power-coefficient = <436>;
+                #cooling-cells = <2>; /* min followed by max */
+                cpu-idle-states = <&CPU_SLEEP>, <&CLUSTER_SLEEP>;
+                thermal-idle {
+                    #cooling-cells = <2>;
+                    duration-us = <10000>;
+                    exit-latency-us = <500>;
+                };
+            };
+
+            cpu_b1: cpu@101 {
+                device_type = "cpu";
+                compatible = "arm,cortex-a72";
+                reg = <0x0 0x101>;
+                enable-method = "psci";
+                capacity-dmips-mhz = <1024>;
+                dynamic-power-coefficient = <436>;
+                #cooling-cells = <2>; /* min followed by max */
+                cpu-idle-states = <&CPU_SLEEP>, <&CLUSTER_SLEEP>;
+                thermal-idle {
+                    #cooling-cells = <2>;
+                    duration-us = <10000>;
+                    exit-latency-us = <500>;
                 };
+            };
 
-                cpu_b1: cpu@101 {
-                        device_type = "cpu";
-                        compatible = "arm,cortex-a72";
-                        reg = <0x0 0x101>;
-                        enable-method = "psci";
-                        capacity-dmips-mhz = <1024>;
-                        dynamic-power-coefficient = <436>;
-                        #cooling-cells = <2>; /* min followed by max */
-                        cpu-idle-states = <&CPU_SLEEP>, <&CLUSTER_SLEEP>;
-                        thermal-idle {
-                                #cooling-cells = <2>;
-                                duration-us = <10000>;
-                                exit-latency-us = <500>;
-                        };
-                 };
-
-          /* ... */
+            /* ... */
 
-    };
+        };
 
-    /* ... */
+        /* ... */
 
-    thermal_zones {
-         cpu_thermal: cpu {
+        thermal_zones {
+            cpu_thermal: cpu {
                 polling-delay-passive = <100>;
                 polling-delay = <1000>;
 
                 /* ... */
 
                 trips {
-                        cpu_alert0: cpu_alert0 {
-                                    temperature = <65000>;
-                                    hysteresis = <2000>;
-                                    type = "passive";
-                        };
-
-                        cpu_alert1: cpu_alert1 {
-                                    temperature = <70000>;
-                                    hysteresis = <2000>;
-                                    type = "passive";
-                        };
-
-                        cpu_alert2: cpu_alert2 {
-                                    temperature = <75000>;
-                                    hysteresis = <2000>;
-                                    type = "passive";
-                        };
-
-                        cpu_crit: cpu_crit {
-                                    temperature = <95000>;
-                                    hysteresis = <2000>;
-                                    type = "critical";
-                        };
+                    cpu_alert0: cpu_alert0 {
+                        temperature = <65000>;
+                        hysteresis = <2000>;
+                        type = "passive";
+                    };
+
+                    cpu_alert1: cpu_alert1 {
+                        temperature = <70000>;
+                        hysteresis = <2000>;
+                        type = "passive";
+                    };
+
+                    cpu_alert2: cpu_alert2 {
+                        temperature = <75000>;
+                        hysteresis = <2000>;
+                        type = "passive";
+                    };
+
+                    cpu_crit: cpu_crit {
+                        temperature = <95000>;
+                        hysteresis = <2000>;
+                        type = "critical";
+                    };
                 };
 
                 cooling-maps {
-                        map0 {
-                             trip = <&cpu_alert1>;
-                             cooling-device = <&{/cpus/cpu@100/thermal-idle} 0 15 >,
-                                              <&{/cpus/cpu@101/thermal-idle} 0 15>;
-                        };
-
-                        map1 {
-                             trip = <&cpu_alert2>;
-                             cooling-device =
-                                        <&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-                                        <&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-                       };
+                    map0 {
+                        trip = <&cpu_alert1>;
+                        cooling-device = <&cpu_b0 0 15 >,
+                                         <&cpu_b1 0 15>;
+                    };
+
+                    map1 {
+                        trip = <&cpu_alert2>;
+                        cooling-device = <&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+                                         <&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+                    };
                 };
-          };
+            };
+        };
     };
-- 
2.35.1

