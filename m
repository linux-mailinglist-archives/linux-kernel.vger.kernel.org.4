Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A16F6164C1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiKBOR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiKBORW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:17:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374C327B32;
        Wed,  2 Nov 2022 07:17:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id f5so24140957ejc.5;
        Wed, 02 Nov 2022 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7CAwgjrcSml/6VQVIiI+9hkAxXqxl9dmDVlzl2TbqA=;
        b=SvQifMPCv1Zm0tJtlh2KK7iWUt24xlxNLrAzzdv8DycRnNF02wjy5ji/02ySYAXmug
         f7OirZXhksnHBFG0Z3HcTZ8/xJhGwMF1zoUVUr1VxOVRRBVQVgWJaIwri+981L7/yu8e
         puIxwx0/ECDmMhS2ucLQ7uWfX6ikOYbynh+9cLQif9P/Kf9Kv0aZJRfxWKAh9DqWWfZO
         o8GWHaZcL8e66mMIBjRVrcFl7aIRhdBBhIKT3CmcqP3Y5XVEcCyNrp6Oaq4nrefewpPt
         oNVgm9khl3cEHV554cJzdY++s/gHoi8XfkZSjhxL+fC4RijkX5cs7TsRKXX2FNn7zSIR
         DnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7CAwgjrcSml/6VQVIiI+9hkAxXqxl9dmDVlzl2TbqA=;
        b=pyhQ1A1wtSqp0KYvPruAa7vs2yoUlpROfFUtMRihAsBBgNUtZGAbaPjVax9IGpiU2X
         n66rQstsdG9bhZ0AHvEAQib1lMQhQ/pw1ctcy5JEQQYwlr3Q2ESfR+07Hf/8eWbtWo3F
         iTQXUveM6peem/hF9PyBskjC6ZbpR4+LcMXQzJml3HqW3z1OkDCPEbBiocfcfE+x96bk
         Xl8w1kAv8w0FawpYzPH3oZ652BsprMUAm486c3M3QplSNzqU8ZW+d1+CUAJb07Z9RIvM
         q1B9K3HK8INF60wh4gDOuZ11leVqR1yH57a+z5Q/YGs6jxiQkGEtNNd92VI3140tQ4OL
         13/Q==
X-Gm-Message-State: ACrzQf3kyFtGrBdRY226o05mIX+s6E97iyeeN0dWyUYmER6g8IbDT4wC
        n3Z/Hbn98V6Fa81DmtPAjX0=
X-Google-Smtp-Source: AMsMyM4g0AgIlCivZHS7wYdviV9ZCChUaGRcHHJAMTYqQFtz7k2phHjMitGG8OdmE4/ZJHVSr6DDEg==
X-Received: by 2002:a17:906:ee81:b0:77e:829a:76e9 with SMTP id wt1-20020a170906ee8100b0077e829a76e9mr24569110ejb.207.1667398635831;
        Wed, 02 Nov 2022 07:17:15 -0700 (PDT)
Received: from localhost ([88.227.60.86])
        by smtp.gmail.com with UTF8SMTPSA id k8-20020a17090632c800b0073d81b0882asm5412397ejk.7.2022.11.02.07.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 07:17:15 -0700 (PDT)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: pwm: Add Apple PWM controller
Date:   Wed,  2 Nov 2022 17:15:10 +0300
Message-Id: <20221102141513.49289-2-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20221102141513.49289-1-fnkl.kernel@gmail.com>
References: <20221102141513.49289-1-fnkl.kernel@gmail.com>
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

Apple SoCs such as the M1 contain a PWM controller used
among other things to control the keyboard backlight.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 .../bindings/pwm/apple,s5l-fpwm.yaml          | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
new file mode 100644
index 000000000000..142157bff0cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/apple,s5l-fpwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple FPWM controller
+
+maintainers:
+  - asahi@lists.linux.dev
+  - Sasha Finkelstein <fnkl.kernel@gmail.com>
+
+description: PWM controller used for keyboard backlight on ARM Macs
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-fpwm
+          - apple,t6000-fpwm
+          - apple,t8112-fpwm
+      - const: apple,s5l-fpwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@235044000 {
+      compatible = "apple,t8103-fpwm", "apple,s5l-fpwm";
+      reg = <0x35044000 0x4000>;
+      power-domains = <&ps_fpwm1>;
+      clocks = <&clkref>;
+      #pwm-cells = <2>;
+    };
-- 
2.37.3

