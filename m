Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF385651702
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 01:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiLTAFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 19:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiLTAFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 19:05:46 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57858B19
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 16:05:44 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id l17so5063321vkk.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 16:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G59VUoYCYBv5qqU0FdCva5W7yGEol89ZbTDgHWp0E9c=;
        b=kDGDteB5WOxEchK4gxDFhktVnxnr/Tpl/pqw7FQIf7ZksP/JUXPMxV3UygnBcu7eJc
         6PiE+rvGqhG/EYXR9RjbMcICv68jocI/wgZgs+9U+ViiZCVKPopHJXYX429QcC38algI
         93AXg33hENRyzvNuUampu9TV0RrfUAp8SREVAV4tIwjg9Lx4c6wYQ9L0MV5+XeAvT8E8
         vcW1iI1dzuihxd2UgCWOelipEVe187KUlCy8OlrDHpxBN74UFMpojSINk0coyKrRFm/Q
         Q0S+hm1y5fKP7uObK2x9toZM4Cz+XPuX3lw+G8tEHXdbeUt7XtV0JUrVD0EhRW7tXXBI
         uLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G59VUoYCYBv5qqU0FdCva5W7yGEol89ZbTDgHWp0E9c=;
        b=fPrYFerE2OEZQuN3Ky4t8YM3koG1ixOJtaCH9qBwxIhO2/UhoONue+taFuTga8UMDs
         rr+5pVlfitNwrDA7nQPQmCeS0UvQCm6Q9XiuP6THQcGaZNWMUfgWk8fgPWCvncy/HUED
         ruENgdvewJY+BdK6lV/9Ud4mynDB/pL97q3kY1fOfMw/KedMmWvAsF3x4QnWEEFxiRJx
         QfapxzpE0EMet0PTuwPcWb/TOBZpfI4CpmUXVGCifvLlQCFNFblCUBsLw44DQKrAVXik
         xCPrk6s5X4KQsBvy7haj2F4O8qI/N2b/E96PhjDVzrTeiAe4AQ4UX/YVbheYz0txvJb4
         f3Sw==
X-Gm-Message-State: ANoB5pm+XotfiElEpdvJuX8gDLZQ5eTTnp1BoQU8s9g1+XBAt0RNd2w7
        vIfVioRhKlFWBGcKxgwvXRPx6SSFN0iUc+9u
X-Google-Smtp-Source: AA0mqf6nr9rPIT/93wH9Wwojg6ZgmajQ77U368ipgDhyVv57qjtoc6a7dYHFA0JFocabVfPzGN997A==
X-Received: by 2002:a1f:ab85:0:b0:3c0:f9ac:51e1 with SMTP id u127-20020a1fab85000000b003c0f9ac51e1mr20909923vke.1.1671494743378;
        Mon, 19 Dec 2022 16:05:43 -0800 (PST)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id o70-20020a374149000000b006e702033b15sm7721430qka.66.2022.12.19.16.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 16:05:42 -0800 (PST)
From:   "Cormier, Jonathan" <jcormier@criticallink.com>
To:     linux-hwmon@vger.kernel.org
Cc:     "Cormier, Jonathan" <jcormier@criticallink.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
Subject: [PATCH v2 1/4] dt-bindings: hwmon: adi,ltc2945: Add binding
Date:   Mon, 19 Dec 2022 19:04:54 -0500
Message-Id: <20221220000457.1163446-2-jcormier@criticallink.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221220000457.1163446-1-jcormier@criticallink.com>
References: <20221214220727.1350784-1-jcormier@criticallink.com>
 <20221220000457.1163446-1-jcormier@criticallink.com>
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

Create initial binding for the LTC2945 I2C power monitor.
Also adds shunt-resistor-micro-ohms parameter

Signed-off-by: "Cormier, Jonathan" <jcormier@criticallink.com>
---
 .../bindings/hwmon/adi,ltc2945.yaml           | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
new file mode 100644
index 000000000000..f90d40919ee6
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/adi,ltc2945.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices LTC2945 wide range i2c power monitor
+
+maintainers:
+  - Guenter Roeck <linux@roeck-us.net>
+
+description: |
+  Analog Devices LTC2945 wide range i2c power monitor over I2C.
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/LTC2945.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ltc2945
+
+  reg:
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    description:
+      Shunt resistor value in micro-Ohms
+    default: 1000
+
+required:
+  - compatible
+  - reg
+
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        power-monitor@6e {
+            compatible = "adi,ltc2945";
+            reg = <0x6e>;
+            /* 10 milli-Ohm shunt resistor */
+            shunt-resistor-micro-ohms = <10000>;
+        };
+    };
+...
--
2.25.1
