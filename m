Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510DB66E2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjAQPrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjAQPqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:46:15 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B6D4520F;
        Tue, 17 Jan 2023 07:44:18 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id g23so18340993plq.12;
        Tue, 17 Jan 2023 07:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2SWrdPrJQ2dQ91kDOjWJkS+4RqBJUBQfv6QIuLSyM9I=;
        b=UfjBW2gl5PrilCKQ09slxhjentzlYCZijk7sT0uORMq8iF2ZigqnbAhAODxPzcNKjB
         KxRnWaRB7ptoYxd5WEalSKZBqBd9eOMissfzFINSFPPE/+k5h0VVAuMx6gu/kfYcodzp
         fxJGZCQRGS0/vK6phA/fenAyq3s3j2cPgxacNJtXo4qliQVGHEQYvLnH/zPx/DChjmQI
         mgAlkLL+cpEpq3v21frncwWSc68ibctU+1ClyuEiA9esIDuifnaxD8Nfjq+4npOG4XFB
         4v3qik88iMn0OkpQ+ah/pLb2Ox1TPSlx+nZGXC3KFuo37NOYochFyFRtW2YP7572yQz+
         sQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SWrdPrJQ2dQ91kDOjWJkS+4RqBJUBQfv6QIuLSyM9I=;
        b=6Tcq3wJDLezylS5oltETXlv2XPmCga5Oiwj4hlSP4p+RnWRNR5DNmkJA27TjRG1lho
         LeRqqRAa/MK1gfIvgdiOFbK13NPhfEtGs0iy58dkus+G4Lbj3K8pjqu9bwpCVq6YZOkv
         pjgTgXjBIxUGav2e9fXByB+fRonhQQ1lwLvzPoOIIXbUjWRuTekEOOtexrFe6F9INAdH
         tBx5g/9zwKj2HYRigS+U3piVBI4x/CkDnHJ2+BCQhnDf3WbKIjUuFjMQ3fl8dqaGtw6w
         gS7k6WQj5+hA5QtYtbBZjxhjWCPuLw0Q9ye/s12K2E+jxzF4qee8Hx8J0tdugwQAEQya
         dzrQ==
X-Gm-Message-State: AFqh2koWESzHTldFiUbuHBkxxCWrTcDR66b5Oxy/OrTWkJbLroZ9753X
        2BXUBD0pzJdmRHswACH89dY=
X-Google-Smtp-Source: AMrXdXsXbduBfp8s9Wh2MGgxK8AjT98WtiSTSTKmj/6nr5poi1ses823mGd+BrQU9pKF5zWxfoR0fg==
X-Received: by 2002:a17:90a:30d:b0:225:f901:ebf8 with SMTP id 13-20020a17090a030d00b00225f901ebf8mr3436692pje.18.1673970257740;
        Tue, 17 Jan 2023 07:44:17 -0800 (PST)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090aec0e00b0022908f1398dsm8909736pjy.32.2023.01.17.07.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 07:44:17 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-fbdev@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v5 1/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866 backlight
Date:   Tue, 17 Jan 2023 23:44:07 +0800
Message-Id: <20230117154408.1882-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.38.2
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

Add Kinetic KTZ8866 backlight binding documentation.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
Changes in v2:
  - Remove "items" between "compatible" and "const: kinetic,ktz8866"
  - Change "additionalProperties" to "unevaluatedProperties"

Changes in v3:
  - Add Krzysztof's R-b

Changes in v4:
  - Drop Krzysztof's R-b
  - Add some new properties

Changes in v5:
  - Add missing enum under property description.
  - Rename uncorrect properties.

 .../leds/backlight/kinetic,ktz8866.yaml       | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
new file mode 100644
index 000000000000..1efc29b0632f
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktz8866.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kinetic Technologies KTZ8866 backlight
+
+maintainers:
+  - Jianhua Lu <lujianhua000@gmail.com>
+
+description: |
+  The Kinetic Technologies KTZ8866 is a high efficiency 6-sinks led backlight
+  with dual lcd bias power.
+  https://www.kinet-ic.com/ktz8866/
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: kinetic,ktz8866
+
+  current-num-sinks:
+    description: Number of LED current sinks.
+    enum: [1, 2, 3, 4, 5, 6]
+
+  current-ramping-time-us:
+    description: LED current ramping time in microseconds.
+    enum: [2, 4, 8, 16, 32, 64, 128, 192, 256, 320, 384, 448, 512, 576, 640]
+
+  led-ramping-time-us:
+    description: LED on/off ramping time in microseconds.
+    enum: [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384]
+
+  enable-lcd-bias:
+    description: Set if we want to output bias power supply for LCD.
+    type: boolean
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    backlight {
+        compatible = "kinetic,ktz8866";
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&bl_en_default>;
+
+        current-num-sinks = <5>;
+        current-ramping-time-us = <128>;
+        led-ramping-time-us = <1>;
+        enable-lcd-bias;
+    };
-- 
2.38.2

