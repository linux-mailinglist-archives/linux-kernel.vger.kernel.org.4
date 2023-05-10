Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5116F6FDCA4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbjEJLYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbjEJLYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:24:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A7910D;
        Wed, 10 May 2023 04:24:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3063433fa66so4607027f8f.3;
        Wed, 10 May 2023 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683717856; x=1686309856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwHcYvXNSiIkEgmiMzAyT5dYPdOiZ1yq5rnwE3WjECM=;
        b=etafzyyjY5HoH5GNhxsAhWLc0AdunTvsDBpsmyDkFUZvf6r3tWlUl5xcwDrBn136ST
         NmaCFav62CmE0wTRWyksiz8LLJ0BnpfHnQBwycyp6ajzWtGjYIVACefvt29HskqDG+iL
         7sOqKfcMcQ01IuaLHRdk2NLtRuMRZhs5JLsZR0/4FokbA5fuYlqW6q9PD7VVE2WJfPpy
         AnS5LWJc4jGzvZ6pnuBGnSsZqi2Ao60Z3F0P/pwbgLCDTup+m8OmqmI218yfKFYmOKRv
         FY2G3ECD8ky8S8KvA7xGWyMOXnlrI+18CD/MEYEB6aqqkEEHuEwfi9BBOSAToMYAFbWl
         2w9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683717856; x=1686309856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwHcYvXNSiIkEgmiMzAyT5dYPdOiZ1yq5rnwE3WjECM=;
        b=UOP9c0eoUIKv3b0CB/KXS6nAi0++EffsHLoRNLkvj7V3yOv57S29R/qKrpF2XWfHt6
         3zFpIkoEtHX0S9nDoYPsmzN0mbEMoDl2K/8QKLtRO7PSJQv9TVrwdVxF0lW2rIojbUae
         7m0LtNYRcY+mXF3+/Alx0L0r42Yjk+DijBuLgm4AFyz4HXl0O+U7dYcnh7FQHt5LeV1g
         O4sSLaDLtJodXOvWPG0Q3JA9h/WaC6G3GIZyWito4Obr9IPSsdgY0P4uIbK1GqMStad8
         bhHfBcuXk6TbHo+u0Yfw8eyKx3MR4QGjIKtdTBDww3YqKi5Y24MxVkwmxwKqQ7xEnE2g
         ULWA==
X-Gm-Message-State: AC+VfDz6jxPzskvXb4xBUxIW8UCZntCyBZIKU3SAyRAwYKVhDGSX5lqi
        CEtIFS11LVT+1eA5kJ9LZGs=
X-Google-Smtp-Source: ACHHUZ7jWCjfitHwoaHYCEOoGIp8uZ0yL6uixHMPjQxq8Q1/duU9u6W1fKi51AosmaX/0EHIq/XTUg==
X-Received: by 2002:a05:6000:12d0:b0:304:b1da:77d with SMTP id l16-20020a05600012d000b00304b1da077dmr11326854wrx.52.1683717856204;
        Wed, 10 May 2023 04:24:16 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b003f4069417absm19668802wmz.24.2023.05.10.04.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 04:24:15 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] dt-bindings: ASoC: Add ESS ES9218P codec bindings
Date:   Wed, 10 May 2023 12:23:49 +0100
Message-Id: <20230510112349.939991-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230510112349.939991-1-aidanmacdonald.0x0@gmail.com>
References: <20230510112349.939991-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree bindings for the ESS ES9218P codec, which uses an
I2C control interface.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 .../bindings/sound/ess,es9218p.yaml           | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ess,es9218p.yaml

diff --git a/Documentation/devicetree/bindings/sound/ess,es9218p.yaml b/Documentation/devicetree/bindings/sound/ess,es9218p.yaml
new file mode 100644
index 000000000000..d205b6a8bbb2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ess,es9218p.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ess,es9218p.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ESS ES9218P audio codec
+
+maintainers:
+  - Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
+
+properties:
+  compatible:
+    const: ess,es9218p
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  avdd-supply:
+    description:
+      Definition of the regulator used for digital core power supply.
+
+  vcca-supply:
+    description:
+      Definition of the regulator used for oscillator and DAC power supply.
+
+  avcc3v3-supply:
+    description:
+      Definition of the 3.3V regulator for amplifier, switch, and charge pumps.
+
+  avcc1v8-supply:
+    description:
+      Definition of the 1.8V regulator for amplifier, switch, and charge pumps.
+
+  clocks:
+    items:
+      - description: clock for master clock (MCLK)
+
+  clock-names:
+    items:
+      - const: mclk
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      Pin used for codec hardware reset, corresponds to the RESETB pin.
+
+  ess,max-clock-div:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Sets the maximum MCLK divider for generating the internal CLK.
+      CLK must be at least 20x the I2C bus speed or I2C transactions
+      will fail. The maximum divider should be chosen to ensure that
+      CLK will not fall below the limit.
+    enum:
+      - 1
+      - 2
+      - 4
+      - 8
+    default: 1
+
+  ess,oscillator-pad-bias:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Sets the oscillator pad drive bias. 0 - full bias, 15 - disabled.
+    minimum: 0
+    maximum: 15
+    default: 0
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+  - avdd-supply
+  - vcca-supply
+  - avcc3v3-supply
+  - avcc1v8-supply
+  - clocks
+  - clock-names
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@48 {
+            compatible = "ess,es9218p";
+            reg = <0x48>;
+            #sound-dai-cells = <0>;
+            avdd-supply = <&avdd>;
+            vcca-supply = <&vcca>;
+            avcc3v3-supply = <&avcc3v3>;
+            avcc1v8-supply = <&avcc1v8>;
+            clocks = <&xtal_clock>;
+            clock-names = "mclk";
+            reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.39.2

