Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92F75FB0BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 12:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJKKsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 06:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJKKry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:47:54 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CEC8C47E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 03:47:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r14so5181341edc.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 03:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJXaub8jNOSU8CZBAJmxK76v0+6+Br/qqh6c+RTPcf0=;
        b=ZYcK2pTGIRmiDaxuXTZrucM4V4EgBXXBVfx0G/bUiwZMCI9jf6B4ilN8sWzxTyStYz
         Dt1hGywzxKT0U9jhH58NDtvuYMyrlpmsei+tZ4EcbfoBi5J7pOhHPk+QshzHlUhSeESs
         OdIwY1cFDjkxd/+5PsDMtOVXlMfb7cvhNeSmAokfPzcWnJCdMRPkfOU8OrcT2ECUPe5V
         mfBcm009hOBcuX9nL1x73akZX0VyPrtL02KGcJHm8YCEouGNIXr44ek3aeKCm+m1IQGD
         sn3KWY6+F3PBQwCWKydnUCO4hSOR9WK7GdhRFe/gt4aRViqIoZmk7ZUjNLgGgoZvQMez
         AsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJXaub8jNOSU8CZBAJmxK76v0+6+Br/qqh6c+RTPcf0=;
        b=fng99ErlcYMT8/t4T+qRvJCH9U+8zGQgDvvI1mDbpR5pNOS81Auj1hQlCUGZhOWE00
         WGtHjZBvZUA1hzxqXpIeRN3RshCJme7sHH9uq/Dub7S4s2nrHjwfA9vU4fzfkowiTUvv
         0yXI3Lkjun0HBxpnZWoFIMopo031CaCefosZX5mVv5shkezNOYs762IAjb/lVp5AHVlT
         juFKPV0HOyVYTfgxlYf2scpdDzrCd+JI20tgQUOBCNiFfzhYbeY6zWsXZiuTbzCpp3QH
         C4mXWNBuZmMCyobmgGiSzB0oFlmeWPkTPuvVkOff283CqhaaKPAOHlCIq3asIr/IMFPe
         lFAQ==
X-Gm-Message-State: ACrzQf0qF1Rrn2MCqycgiLb56iudprmOgZNZhvG92++Oero86myoJf1/
        b+BMeTnA4FyP4+8NX2KyFl/0dg==
X-Google-Smtp-Source: AMsMyM5RME73O8xHGZ6n8neBjdDQkvEFyKAoAHV+gXrnUIqn5QmrVcLdvrPPu3Aof2+5f9CtiRw9kA==
X-Received: by 2002:a05:6402:2926:b0:459:675b:38a9 with SMTP id ee38-20020a056402292600b00459675b38a9mr22399218edb.60.1665485272208;
        Tue, 11 Oct 2022 03:47:52 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id mf22-20020a1709071a5600b0074136cac2e7sm6753081ejc.81.2022.10.11.03.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 03:47:51 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roland Stigge <stigge@antcom.de>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v2 2/3] dt-bindings: hwmon: Add binding for max6639
Date:   Tue, 11 Oct 2022 12:47:38 +0200
Message-Id: <20221011104739.53262-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011104739.53262-1-Naresh.Solanki@9elements.com>
References: <20221011104739.53262-1-Naresh.Solanki@9elements.com>
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

From: Marcello Sylvester Bauer <sylv@sylv.io>

Add Devicetree binding documentation for Maxim MAX6639 temperature
monitor with PWM fan-speed controller.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 .../bindings/hwmon/maxim,max6639.yaml         | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
new file mode 100644
index 000000000000..bbefb0a57ab3
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim max6639
+
+maintainers:
+  - Roland Stigge <stigge@antcom.de>
+
+description: |
+  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
+  fan-speed controller.  It monitors its own temperature and one external
+  diode-connected transistor or the temperatures of two external diode-connected
+  transistors, typically available in CPUs, FPGAs, or GPUs.
+
+  Datasheets:
+    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max6639
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  "^ot[0-1]_indication$":
+    type: boolean
+    default: false
+    description:
+      If true then enable OT pin indication.
+
+  "^therm[0-1]_indication$":
+    type: boolean
+    default: false
+    description:
+      If true then enable THERM pin indication.
+
+  "^fan@[0-1]$":
+    type: object
+    description: |
+      Represents the two fans and their specific configuration.
+
+    $ref: fan-common.yaml#
+
+    properties:
+      reg:
+        description: |
+          The fan number.
+        items:
+          minimum: 0
+          maximum: 1
+
+      maxim,fan-spin-up:
+        type: boolean
+        description:
+          If true then whnever the fan starts up from zero drive, it
+          is driven with 100% duty cycle for 2s to ensure that it
+          starts.
+
+      maxim,full-speed-on-therm:
+        type: boolean
+        description:
+          If true then force fan to full speed if THERM pin goes low.
+
+      maxim,fanfail_indication:
+        type: boolean
+        description:
+          If true then enable fanfail pin indication.
+    required:
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      max6639@10 {
+        compatible = "maxim,max6639";
+        reg = <0x10>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fan@0 {
+          reg = <0x0>;
+          pulses-per-revolution = <2>;
+          max-rpm = <4000>;
+          pwm-frequency = <25000>;
+        };
+
+        fan@1 {
+          reg = <0x1>;
+          pulses-per-revolution = <2>;
+          max-rpm = <32000>;
+          pwm-frequency = <25000>;
+        };
+      };
+    };
+...
-- 
2.37.3

