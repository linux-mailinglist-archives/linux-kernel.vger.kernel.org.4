Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6A76BBB1B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjCORnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjCORnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:43:22 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BBF5DEED;
        Wed, 15 Mar 2023 10:43:12 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a32so20271803ljr.9;
        Wed, 15 Mar 2023 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678902191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QOzpvocKnFn0bAY8kRGLV91Cn/phdFGP7VeaxQqiMc4=;
        b=PU6a6Bo1HBsIOsXuNxNPjGHmlOnM3WpM2kO9fAy259HWUtfyjGdYxZEH9ZnYBkpVO5
         kDEEmKGRrjskEwEsKOBIpNobTQVBUfhgjQUGxPl9LWd9iRUo8YUq06Q7PPUYIgZK/Kdx
         ODcxcaefggEbctRVYy+yERJLWEi8azmbt9YFFgrhuuzQVMkOo8Rheo6Tte4ZmcKujJtM
         lJgFaCS0o1yzqPWDb1diMRg5RQPOwmUcNa/Vm/FwIM3SRxwWmaKJuQwjpb4zjqUVnotp
         eeqgpLeOkixV6RQ3MBZvfKkKHE8abN6nlPt4PTMtWgbJqLs4SC5Kmd0zAg3WQ/H429gR
         afNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678902191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOzpvocKnFn0bAY8kRGLV91Cn/phdFGP7VeaxQqiMc4=;
        b=NRuT4BDSr/go/z5JaNPg7TX0tc/RFLaMnVzqv8hCwSmzdPsRx7KvesZXpwK4+neYK4
         X5j3zhTzsH5y+cq8hZZJwvCQHSpL8gaTs2XPOx+Z+JqBjqHIz9AdcAL8dUSHo2ldPei3
         fI44a/enzKhAMgT+si4ShCy+R5Q8gZOuHEPlw1z7bUUTLiLWSQO29XzPKz9/wyCbGyM2
         ZlAvy+v9RK7MZcrPMBaLFdCxuqSKafSUMNFs4eiuNeo73eb5lS78fnAxt/294pFtPo3W
         cp+jGnquUbriD6myZAtWuwU8/7Vb05o/35wMGSUfyqoDrZ0mwIuNiDPt4agIRwfHXnfl
         1MDA==
X-Gm-Message-State: AO0yUKUX9W9eRZVteSHyMglcpoynnceDoLUoZDQmU30211ZqS+ZNERzS
        siGA65rCLI+qYA12F9zsoJE=
X-Google-Smtp-Source: AK7set9BOXMjvo9FUWWObEWS1XtxgqYPJQ6b1AdcZ2lDSva8HdsWyaENajgJqB/WNCNScPJPi6JWKA==
X-Received: by 2002:a2e:a54a:0:b0:298:aa76:2fb8 with SMTP id e10-20020a2ea54a000000b00298aa762fb8mr1439229ljn.12.1678902190973;
        Wed, 15 Mar 2023 10:43:10 -0700 (PDT)
Received: from otabekn-HP-ProBook-650-G4.. ([93.170.231.237])
        by smtp.googlemail.com with ESMTPSA id s25-20020a2e9c19000000b0029870223d23sm927000lji.73.2023.03.15.10.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:43:10 -0700 (PDT)
From:   Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
Cc:     Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: maxim,max9759: Convert to DT schema.
Date:   Thu, 16 Mar 2023 02:33:30 +0900
Message-Id: <20230315173404.7215-1-otabeknazrullaev1998@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Maxim MAX9759 Speaker Amplifier bindings to DT schema.
Add missing gpio header file into examples section

Signed-off-by: Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../bindings/sound/maxim,max9759.txt          | 18 --------
 .../bindings/sound/maxim,max9759.yaml         | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/maxim,max9759.txt
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max9759.yaml

diff --git a/Documentation/devicetree/bindings/sound/maxim,max9759.txt b/Documentation/devicetree/bindings/sound/maxim,max9759.txt
deleted file mode 100644
index 737a996374d3..000000000000
--- a/Documentation/devicetree/bindings/sound/maxim,max9759.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Maxim MAX9759 Speaker Amplifier
-===============================
-
-Required properties:
-- compatible : "maxim,max9759"
-- shutdown-gpios : the gpio connected to the shutdown pin
-- mute-gpios : the gpio connected to the mute pin
-- gain-gpios : the 2 gpios connected to the g1 and g2 pins
-
-Example:
-
-max9759: analog-amplifier {
-	compatible = "maxim,max9759";
-	shutdown-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
-	mute-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
-	gain-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>,
-		     <&gpio3 25 GPIO_ACTIVE_LOW>;
-};
diff --git a/Documentation/devicetree/bindings/sound/maxim,max9759.yaml b/Documentation/devicetree/bindings/sound/maxim,max9759.yaml
new file mode 100644
index 000000000000..a76ee6a635af
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max9759.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/maxim,max9759.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX9759 Speaker Amplifier
+
+maintainers:
+  - Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
+
+properties:
+  compatible:
+    const: maxim,max9759
+
+  shutdown-gpios:
+    maxItems: 1
+    description: the gpio connected to the shutdown pin
+
+  mute-gpios:
+    maxItems: 1
+    description: the gpio connected to the mute pin
+
+  gain-gpios:
+    maxItems: 2
+    description: the 2 gpios connected to the g1 and g2 pins
+
+required:
+  - compatible
+  - shutdown-gpios
+  - mute-gpios
+  - gain-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    amplifier {
+      compatible = "maxim,max9759";
+      shutdown-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
+      mute-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
+      gain-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>,
+             <&gpio3 25 GPIO_ACTIVE_LOW>;
+    };
-- 
2.34.1

