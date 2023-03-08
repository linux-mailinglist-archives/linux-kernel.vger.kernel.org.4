Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5768E6B01D9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCHIon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCHIok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:44:40 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980369AFDB;
        Wed,  8 Mar 2023 00:44:36 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id a25so62836838edb.0;
        Wed, 08 Mar 2023 00:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678265075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5IozmuJmXlRY443E7JFFDmGdlSvIWCIn/5kCoULQys=;
        b=FhNheA1Drib+iW621iwSkZPmuZjhpTJBbX+a1a/Ky6IwAFAyfJAM5z1PKLakD1BJ4O
         Vlty+HaKv7xP8yO5adj8hz/5AYILa6UBfeJKoVAanUBwrXRF1s96PmlVmzGLi1Y7+LsM
         hyfM7vMeA6eNcZKxSmS/oX4IR1U4z8SsJqr8R2gpHXcsVjRCLCaYGiMdlHi7qqLh1+ce
         RVev3VQSGS1WtTjhc412Q2jToWZBg0MajsTOY9InERPoXEOFqHHdNKlNJ8Uz6LP8moqq
         I3bHS4BL9vF0ZPfq9NY7EvzA3ytCez7SPtq9G8gLNL/PZIlt9sVzNrKebokZWxOjSdTQ
         3w7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678265075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5IozmuJmXlRY443E7JFFDmGdlSvIWCIn/5kCoULQys=;
        b=X2nKCBQAsyyXLddDkQm+BCTxRh97I/LkkAz4fx9eDA9jRPHGk03o/g1DGIKOWy30lC
         mSmhmUadQPLrk7u58B2zKdnEZNWRa5xj34tJO0T60QFyo5p7AMR54VptqLPfpchKKVuK
         YZaULTl+KmkXRjUhPL4NzWB1wShxqXn6TannQkl6+/aVKVEMus3VU/JGN4iviVbegO8z
         xFFtEX3zrN0WUeXd8RaL/e5aXMVs8hQP/ocKH6VRNShRAqP6yK4S8fyVo2xHH3Q3et2j
         HByX/HgnJZFnioW2QfgfKsuGnqfKkQ4HQgwcvTosOhluKcPLa4oemHGHdo/5PdbBjnBW
         feWg==
X-Gm-Message-State: AO0yUKVZTox+vvZrkxH/5ASxjJ2LWKjg3zN8oN92S1OXqAO6wBQNk0Os
        aHua80RpyWLltiX8I3fzwLg=
X-Google-Smtp-Source: AK7set9ZLL6Pvjw/OPH7rQetV990cjM2XIFvQ8R98/Bhg05wLLlj2XphomIA6l1M3jXztLX35medZg==
X-Received: by 2002:a17:906:b14f:b0:8b1:7de9:b38c with SMTP id bt15-20020a170906b14f00b008b17de9b38cmr16535901ejb.52.1678265075045;
        Wed, 08 Mar 2023 00:44:35 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906838800b008ee95ccfe06sm7163891ejx.119.2023.03.08.00.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:44:34 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] dt-bindings: power: supply: maxim,max17040: update properties
Date:   Wed,  8 Mar 2023 10:44:16 +0200
Message-Id: <20230308084419.11934-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308084419.11934-1-clamor95@gmail.com>
References: <20230308084419.11934-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add simple cell, status, health and temperature properties.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/power/supply/maxim,max17040.yaml | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
index 3a529326ecbd..6f1c25b4729f 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
@@ -55,6 +55,20 @@ properties:
   interrupts:
     maxItems: 1
 
+  monitored-battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the battery node being monitored
+
+  power-supplies: true
+
+  io-channels:
+    items:
+      - description: battery temperature
+
+  io-channel-names:
+    items:
+      - const: temp
+
   wakeup-source:
     type: boolean
     description: |
@@ -95,3 +109,26 @@ examples:
         wakeup-source;
       };
     };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fuel-gauge@36 {
+        compatible = "maxim,max17043";
+        reg = <0x36>;
+
+        interrupt-parent = <&gpio>;
+        interrupts = <144 IRQ_TYPE_EDGE_FALLING>;
+
+        monitored-battery = <&battery>;
+        power-supplies = <&charger>;
+
+        io-channels = <&adc 8>;
+        io-channel-names = "temp";
+
+        maxim,alert-low-soc-level = <10>;
+        wakeup-source;
+      };
+    };
-- 
2.37.2

