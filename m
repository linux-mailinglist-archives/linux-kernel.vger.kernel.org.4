Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5CF626079
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiKKReV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbiKKReS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:34:18 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1E263B8F;
        Fri, 11 Nov 2022 09:34:12 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id q9so14247805ejd.0;
        Fri, 11 Nov 2022 09:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sg8vUQYLH6qQ6hP1k9ymeq/CLq0kgDdouy7o+4KV0LE=;
        b=okYUdMdVBuwxBAttFPyzw69Cgqhkovk4+Z4IVbjdXXvMv28xzhzA/StwrHhm6K7bAv
         Cuemha8ynrBIhFj5RttItckgrC15GyYilDzdBZhgiN+Q4W9P0Hdg7K8yxS3mU7sL8C9x
         Y5rUcO3ZspB8WIduNB9eSgOBzxSiIJeKnqh8Gla1J7PhW7sy/AZezpAKZwTQcgzh/ytv
         beycgcAqNTxNe6Av+jK5MkU4CPKz/sPcXHPYNvrvr0DHz1LLCAVKY/Xe/9tBJI8Ofiq4
         nma2+503ShQ6I7uw1Ax5arHEY60qE2e0bnVJP2Djl12H7sFlhcGEsX9ZPZIBo0LpH58Z
         ckyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sg8vUQYLH6qQ6hP1k9ymeq/CLq0kgDdouy7o+4KV0LE=;
        b=kSQg8kgbssSHXyweETB6NYNBzs8ccpx5EuMG8oROr6yRmoieYbJPdJzdaRT/V2aDPI
         ch8yYeWAZFndJMxjm/pG/2TVJc8pWP3AA83BuZWiv/lVVCq0jw7J8YRlRxn5dnNKe0u8
         w0T9tS+8z0gMD0vX09k4c+dq57ISnRxYHiqIS1bWFrvBwIDSH8TD+y1M1pkG1eZ6SCcl
         O+7Ve7AipakdomqO5X8oOYIBB8hnjXn+yTgRKraRKfFS253gV24YLD7TWPFHngFTbvYv
         oer2pYO9E0QxFdcIsD/ES7a5g5fwmm+V13zb15D3hkLqqSfdRBScIRD283eWJC4uO1AT
         Lyag==
X-Gm-Message-State: ANoB5pmhz/LyANQUllJwPJM9QbWnvJZ2Bb7roTTTD/K7dBpr7/F08fLv
        kbiPVjPnoodTvtbkRIA8Iy4=
X-Google-Smtp-Source: AA0mqf7eFwcyXUZdKn3GQ9scJrTpWoiH4VQiki2Gz5ipZtHrb0HyTwYeHdM0YDpCqQ2lq63B1CwjXg==
X-Received: by 2002:a17:906:c18b:b0:789:d2fc:41d1 with SMTP id g11-20020a170906c18b00b00789d2fc41d1mr2642401ejz.642.1668188051450;
        Fri, 11 Nov 2022 09:34:11 -0800 (PST)
Received: from localhost ([85.153.204.139])
        by smtp.gmail.com with UTF8SMTPSA id b19-20020a056402139300b004637489cf08sm1293119edv.88.2022.11.11.09.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 09:34:10 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>,
        Krzyszstof Kozlowski <krzyszstof.kozlowski@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: pwm: Add Apple PWM controller
Date:   Fri, 11 Nov 2022 20:33:45 +0300
Message-Id: <20221111173348.6537-2-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20221111173348.6537-1-fnkl.kernel@gmail.com>
References: <20221111173348.6537-1-fnkl.kernel@gmail.com>
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
Reviewed-by: Krzyszstof Kozlowski <krzyszstof.kozlowski@linaro.org>
Acked-by: Sven Peter <sven@svenpeter.dev>
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
2.38.1

