Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0670D67D874
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjAZWd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjAZWcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:32:52 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93C371647
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:32:29 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id jr19so2620090qtb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zFvxOAC0q2c06nWzVmCaxdWpCqkl5RVXm0xsv73DMs=;
        b=o7lK4z8o7B55iaeb/QVxMD9CSLSJVLJ+w6AHvvYrEztgbkkhfDpccJL5XYVNWY5yui
         +n0LYYi+DDKn9qEfjUU1fed+Owwzbpf431Fleqr10EISUzsNi/sYpeoW4JW0EdyTnLtA
         mN4zxcQwsQi+LujmWk6kqP5n6TnS4IdRoZidGWsoJuBNKxkooKtpibgK5X67u2OPXYnE
         5aCgFsC39nIysvoepqn5YPwDt3Ba+Mk+ozWkw1JaJ5H5YHRPlouCaLKD/EOIbluy7VQ6
         xHsqrviK+JXTKv8fC6fUqXrOHDIFvipPMtwKDJ7aHmziSOxO6aKbOBnhANESRq/3xpyI
         ejBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zFvxOAC0q2c06nWzVmCaxdWpCqkl5RVXm0xsv73DMs=;
        b=eOVu8Io6lFaAP0Bz2+cNVH/aeDuXMcVY6Abntyhdnj6ySWD9CgvbwJPsD+yMGKx7Jz
         vux9mD/wtXnkwuaLlUyny3a0Ws9uCuqRYy4xNUJbIqSCPYOauuGpGjHAKQ8l/E46Q4dK
         X96wqdDXmYJvA6Rop4Pa0pyvHnrh3Bu19NRlUjsXRMhcOeqsXt1TRwcnDZTKlRMdA5/m
         OGoXpAv/jrsBYZj2CDVWRKbtxWZsCBkBScdbOR7WToa26GaeIvULao4kWHqJemA5fSaP
         Cu38U/czehVHNHgS7ZJ3UW5nE4PeaZfr/PLvR0VCeBks5Uvdj/dBq3vUWeNN5LpyNs/4
         V/pg==
X-Gm-Message-State: AFqh2kqopmlCHQVnsOT5BpArTgmcSHLtlyNqeOl1k5xkWH0ov3B0swbh
        ZFQd95zH/W4EGYMD/SAZkTRSag==
X-Google-Smtp-Source: AMrXdXufwfJoYgTc3AtPHx009XAQsWrjQR/+95PfexQQA6FT3nNVJvVyXh7gdStBGf9RlJoP3weqew==
X-Received: by 2002:a05:622a:1995:b0:3b2:4309:99e with SMTP id u21-20020a05622a199500b003b24309099emr73641310qtc.54.1674772348797;
        Thu, 26 Jan 2023 14:32:28 -0800 (PST)
Received: from [127.0.1.1] (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id m7-20020a05620a220700b006ff8a122a1asm1723091qkh.78.2023.01.26.14.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:32:28 -0800 (PST)
From:   Jonathan Cormier <jcormier@criticallink.com>
Date:   Thu, 26 Jan 2023 17:32:23 -0500
Subject: [PATCH v4 1/5] dt-bindings: hwmon: adi,ltc2945: Add binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230126-b4-ltc2945_shunt_resistor-v4-1-bb913470d8da@criticallink.com>
References: <20230126-b4-ltc2945_shunt_resistor-v4-0-bb913470d8da@criticallink.com>
In-Reply-To: <20230126-b4-ltc2945_shunt_resistor-v4-0-bb913470d8da@criticallink.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>,
        Jonathan Cormier <jcormier@criticallink.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715;
 i=jcormier@criticallink.com; h=from:subject:message-id;
 bh=zommGdK1AE/P2wkRC+Wfs7Ff5ewrg2oHpdh2GCpmvb4=;
 b=owEBbQKS/ZANAwAKAdzX/S4LNuuqAcsmYgBj0v96zdNvjLqjJDJT6uP55wg3FfQKjVKHekgLyJ/H
 g9+UYSiJAjMEAAEKAB0WIQT/MozqCeZtYxNnVN/c1/0uCzbrqgUCY9L/egAKCRDc1/0uCzbrqm5FEA
 CGCashV5T/gehXbDpyC6N+qeRK93QJKBK3yy4ryoch6+CQLU1jV1e2Nm2Lget6jA7r8WvFD/JYiktZ
 EA1YE0dvxdntUT5l92NeBnRsnvF/osVZOWiy//mp363XuQ1XmqWSjdV49lmiEV8U3MtR7T6v3Un3pf
 +qHaF6h9BkSCjoZDuo4yi3ZrWHTHQz7YHPhcRnwo1hJ81wVt0K1+L0Pvch2cK3oWgrqQzto4f2JeBe
 vWuMn528NyfLnC5HJMOc5fjbDUoADlE7dcEmnyitrRTx4xZOHL0V+Y1WeZsdV2OhYLCeHZd2bTS2I0
 1PRBgpUMfDI51vJftqm4DH6BNTDRYF2n0ar9J/7KEA+L32eU+/GhejGGzSONu2rW1/6rQXBxcAJXiE
 OKec5CU7dcXLN0j2RU2qSD6cZpTSRsRlh8aGO6o3lNiBD2rDz0+9+OeN9rDxz0mCBdKVu94zBNdJG3
 VpiUkoaolGWhqWvje6zIb1VCY9u/0i//+6NB/+pofpwFR8XqrDyf0OvRsjIXFH3svI0Y78wwhBpops
 egwbN3FeiEMaa2z5KRrO1iuR46IAoBYDzDsbPiREr4fi7RRMqVHxe3GvlhxMIQu+wtolpWq0U3cVMg
 TUOxQXklybtJEvajU54xYWmzKoC850y9iYg/ZjT2dYI7V9Uu3PV2/+y3ZA2Q==
X-Developer-Key: i=jcormier@criticallink.com; a=openpgp;
 fpr=FF328CEA09E66D63136754DFDCD7FD2E0B36EBAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create initial binding for the LTC2945 I2C power monitor.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 .../devicetree/bindings/hwmon/adi,ltc2945.yaml     | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
new file mode 100644
index 000000000000..5cb66e97e816
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
@@ -0,0 +1,49 @@
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

