Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B415FCCAE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiJLU7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJLU7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:59:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6B810C4DC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:58:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a10so27883194wrm.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+F7MLPYLOWZxZ3MKZlY+4rxKv0W0eAdEZRqEFrEMvwU=;
        b=DO0GvgKMMmaiRezHm/A5DosdpducYU6Zlb+EBx6PjpcZSpYhkMzBVKbjsobWcgi03c
         sXCWGLQ4I3Ko1kkNwwz1AkTmHV+KC6U84KXjdnI9DrFn3SpdK4DmJ9qsapUA3iYsr0wd
         HW+1hHyazZAGPDM+pJQIeGbILVgFrSz8/kSS9Z+UpX5R+P2//pSkhZruw58XZu719Vx9
         jmv1nbxIVSh4aO4oVdCAhpxAmk5Sz0MB9OObFii4snPgXiCYOun8/pOvubK68rXLGsmM
         /AThIHgdBCObhYzU7rcxv7Rzz0Jw/t0xjzeBA2ns2UjRIEL/73h/gyCgSgvidqm0o9zK
         62GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+F7MLPYLOWZxZ3MKZlY+4rxKv0W0eAdEZRqEFrEMvwU=;
        b=oXPm5wjnudcBX1MZkZ+oGe55yP77QaU1vWxFYd8NqFeHdCxMORAE7QXb2fsI1MYLO2
         CWDFNmta+YyCD2rUUNqKSxL93ksmFLeTi5mR/QIuuG23+SUjr42mkloG4iTnE5nqfMnw
         QvHhrfEHk50R5M7wyo/nCsiJzo7I27768KAEIH3tYuz0IqziSDze6WzC0uXc10t6TOmO
         YTl7PCN2X4w/9nbN0WR198zIYWJsh9XiMSN9x4spvajYIqIXPxMvDXVTYnCjPCYRmPXk
         lbmf3lVrn3oEci5wWMobackJBOSntONNWHMnn17beggWlNsPX8IvdmIYAyrPpR6eR2jm
         pNqg==
X-Gm-Message-State: ACrzQf2bapQqdE+64kMp+h1Zp1rBAMQ/0zozQ29b0DUJQIF4IIGLrQqk
        PV5QIeXic769LeFbUzsYTkGsLg==
X-Google-Smtp-Source: AMsMyM5nXFR/cjL45wVWsyusn8J99y4ImRYFxiyqJMCSlpDn08VfzeefM/SOIE4e4kaTCNpPEU6wdw==
X-Received: by 2002:a05:6000:1683:b0:230:d0b5:72c9 with SMTP id y3-20020a056000168300b00230d0b572c9mr10248655wrd.336.1665608262973;
        Wed, 12 Oct 2022 13:57:42 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b003c6cd82596esm3165443wmq.43.2022.10.12.13.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 13:57:42 -0700 (PDT)
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
Subject: [PATCH v3 2/3] dt-bindings: hwmon: Add binding for max6639
Date:   Wed, 12 Oct 2022 22:57:35 +0200
Message-Id: <20221012205736.1231514-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012205736.1231514-1-Naresh.Solanki@9elements.com>
References: <20221012205736.1231514-1-Naresh.Solanki@9elements.com>
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
 .../bindings/hwmon/maxim,max6639.yaml         | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
new file mode 100644
index 000000000000..459647870ebc
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
@@ -0,0 +1,86 @@
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
+      fan-controller@2e {
+        compatible = "maxim,max6639";
+        reg = <0x10>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fan@0 {
+          reg = <0x0>;
+          pulses-per-revolution = <2>;
+          max-rpm = <4000>;
+        };
+
+        fan@1 {
+          reg = <0x1>;
+          pulses-per-revolution = <2>;
+          max-rpm = <8000>;
+        };
+      };
+    };
+...
-- 
2.37.3

