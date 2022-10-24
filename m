Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48E360BA4E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiJXUdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiJXUdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:33:00 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B83BD067;
        Mon, 24 Oct 2022 11:44:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a5so19969014edb.11;
        Mon, 24 Oct 2022 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMhauQ4bglHHby0SI3Wa9kpbiclzAulw2G0WqIC6ZJg=;
        b=oOjW/jF0tJQRyAPO73lcAdZ7584mvc8a+XSN1eaIB9n65olANlWLKuyHhINXtYyOlw
         qaApKoPDe0P8FiofGuu520o9u8twm2fYktwx8GDid1PEIHiCXuZvRMUNY9SQPaZOVlKB
         +hoT8I5CGXfnnX1gR3lU7jCO5Jz/lImft94/4yemyaZkEZxQ+uNteYrmxaT4tYSZDyCT
         XUozIx7F5qlHfiYie4fMMQequjqOZiPB8//jDyIFoM/6VhNfewxBvxqP3jftYkHB4CHM
         EmUeDjgWN/TZDXuGjBt+aosjgrLKgGXVeMxiNwov1XBlQNpUwzo4LfRBlis1nXAOy/cP
         jLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMhauQ4bglHHby0SI3Wa9kpbiclzAulw2G0WqIC6ZJg=;
        b=HvqylfYAUiIysKxBZ6IJhs5/D7WmTDiPsTN3iDuwSTnANXD/aZsfKbSMH8qp4xYxqB
         xzslIS6/RtBFqfBJQQX0N9f1jHU4z+geMLCVJj91tC0lg/p56YPD2o0otdemkoVyuRP1
         5CKezkfZuSc/4GgkeeiLoRIkBLXQNiHpM7dwFSe92TDJzinjQ4zTHDQiiwhJvGn12xU2
         u+RDl7hXF+2FRrXuU80inIGGWqfv5RpN5Zn+/1C8qpSdxKa+rKng76nu9JyiaichGthS
         TuUP03u4sk8Lzuio1zKjG2XJGr+iB/4PtwUUY5Bl5CtWOWp5N/k33P+qCwrXaWMx68C8
         3oog==
X-Gm-Message-State: ACrzQf1JwGAqo6TacAWgIQu5Oja5ncG4Parts6WiFGIN2AW+m+iwuYcg
        w69vme8NSwuXIag0Sw4bBtJGeOa0XKc1tw==
X-Google-Smtp-Source: AMsMyM5vT3YbLQN71xt9DWU18Gtx5Q+siGZwinWWiNVucvEJzWt2fXxibSf2EDlFUMxP6rijFAKIPg==
X-Received: by 2002:a05:6402:3789:b0:461:3ae6:8d73 with SMTP id et9-20020a056402378900b004613ae68d73mr18572013edb.229.1666628821059;
        Mon, 24 Oct 2022 09:27:01 -0700 (PDT)
Received: from 1974459598.wifi.kn.vutbr.cz (nat-kn.net.vutbr.cz. [147.229.117.40])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709064d4e00b0078dd4c89781sm108186ejv.35.2022.10.24.09.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:27:00 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, jeffrey.l.hugo@gmail.com,
        Michael.Srba@seznam.cz, gregkh@linuxfoundation.org,
        elder@linaro.org, hemantk@codeaurora.org, mani@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
Cc:     =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [RFCv3 PATCH 1/2] dt-bindings: bus: add Wiegand bus dt documentation
Date:   Mon, 24 Oct 2022 18:26:49 +0200
Message-Id: <20221024162650.36587-2-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024162650.36587-1-m.zatovic1@gmail.com>
References: <20221024162650.36587-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This patch documents the devicetree entry for a Wiegand bus.
A Wiegand bus follows the Wiegand protocol. The bus claims two GPIO
lines over which the communication is realized. It also introduces
parameters to control the pulse durations and the length of a gap
after finishing sending a frame.

Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../devicetree/bindings/bus/wiegand.yaml      | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/wiegand.yaml

diff --git a/Documentation/devicetree/bindings/bus/wiegand.yaml b/Documentation/devicetree/bindings/bus/wiegand.yaml
new file mode 100644
index 000000000000..cc8d3c46bcde
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/wiegand.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/wiegand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wiegand Bus
+
+maintainers:
+  - Martin Zaťovič <m.zatovic1@gmail.com>
+
+description: |
+  Wiegand interface is a wiring standard popularized in the 1980s. To this day
+  many card readers, fingerprint readers, sensors, etc. use Wiegand interface
+  particularly for access control applications. It utilizes two wires to
+  transmit the data - D0 and D1.
+
+  Both data lines are initially pulled up. To send a bit of value 1, the D1
+  line is set low. Similarly to send a bit of value 0, the D0 line is set low.
+
+properties:
+  $nodename:
+    pattern: "^wiegand(@.*|-[0-9a-f])*$"
+
+  compatible:
+    contains:
+      const: wiegand
+
+  data-hi-gpios:
+    description: GPIO spec for data-hi line to use. This line is initially
+      pulled up to high value. Wiegand write of a bit of value 1 results in
+      this line being pulled down for pulse length duration.
+    maxItems: 1
+
+  data-lo-gpios:
+    description: GPIO spec for data-lo line to use. This line is initially
+      pulled up to high value. Wiegand write of a bit of value 0 results in
+      this line being pulled down for pulse length duration.
+    maxItems: 1
+
+  pulse-len:
+    description: length of the low pulse for both data-lo and data-hi lines.
+    maxItems: 1
+
+  interval-len:
+    description: length of a whole bit (both the pulse and the high phase) for
+      both data-hi and data-lo lines in usecs; defaults to 2000us.
+    maxItems: 1
+
+  frame-gap:
+    description: length of the last bit of a frame (both the pulse and the high
+      phase) in usec; defaults to 2000us.
+    maxItems: 1
+
+required:
+  - compatible
+  - data-hi-gpios
+  - data-lo-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    wiegand {
+        compatible = "wiegand";
+        data-hi-gpios = <&gpio 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+        data-lo-gpios = <&gpio 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+        pulse-len = <100>;
+        interval-len = <2500>;
+        frame-gap = <4000>;
+    };
+
+...
--
2.37.3
