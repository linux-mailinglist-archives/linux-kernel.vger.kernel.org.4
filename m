Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057D864D223
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiLNWHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiLNWHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:07:38 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7041A3D381
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:07:37 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id b16so1520831yba.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTsnKtwUjGvGvHg2cgLs27K7OBIT3pZ3CaoQvqzJL0c=;
        b=JZKbHMNHWpHUcySGjGsvYxjfGwUSv8hucBqoWPOCoBawKS7t/oUstpQqwE5YdOBf3D
         ZjXugiLgsQq4pI+fUbyw9kX6d60EbG306NoTR8w+9HdYjPjE7tqqpLfyPVNUBq/kzsmg
         BMDHvYTiETnkAERnlbOhCM4q9shPEGsIzVcTFuu2GKfocpdo4Uu1OBCaNnmrrKfDPVI5
         4I/kVO19umWdg4V6MDfHHXN8ZBti4HyutIy2N1HkA5JR9mmLWoSPFa1wn+pv54EtAwNg
         rXUegaLEmabg5UxQXlQvPV4B9FLi3HrNxIKlGDNS0RyZVK14/7lqyElThScoldgJmAHS
         S8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTsnKtwUjGvGvHg2cgLs27K7OBIT3pZ3CaoQvqzJL0c=;
        b=IKpLrQP+FSx/42VjJPj9NRgPkttGgAx5fJKZsOQiqeqLOWPwj5yzoc5KVOhZ8WpP17
         OaKaDD6vGvL5ta63zE6dzK1n/j8lkPwt2SIXzRn6mPieXEb398eXPSFz2LXoXrm4Bm3o
         H7AiwAPgkdEIL2IJ1ShVvClHUDuP0xmG0UZCrUPQEnO0zMCcbDusTvJ4l5dDCw+foi9t
         S8SKvG4EYXSL5MX9MBw+FUva3Jr3TpusB7efVJyMdkt7f8v7gscxkxvV9thJy3XARr0z
         xQKUndzLRVamZfg5jNq4jiLp0Q7mXvLSncWAhNglKftvj7xfWE3AxmymFoUWCJ/qX5y9
         sRJw==
X-Gm-Message-State: ANoB5pl7GGG9QLWHIdcVocGibjpqCv6i6Iyz8+5Rfje4sOOEPus3RuMK
        sMQ3RrLKfBlmLIZoPwSduU0bvgVgjiKxvZSe
X-Google-Smtp-Source: AA0mqf45xRGhbBdv3vk0QIaV/NFonkr+kP3v08nsV57J/zqoBTq/ZuiWvJi7baFrRT63fBunEQsi1w==
X-Received: by 2002:a25:7705:0:b0:6f2:97f7:e020 with SMTP id s5-20020a257705000000b006f297f7e020mr23189959ybc.26.1671055656580;
        Wed, 14 Dec 2022 14:07:36 -0800 (PST)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id l24-20020ae9f018000000b006fc2b672950sm10623939qkg.37.2022.12.14.14.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 14:07:36 -0800 (PST)
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
Subject: [PATCH 1/2] dt-bindings: hwmon: adi,ltc2945: Add binding
Date:   Wed, 14 Dec 2022 17:07:26 -0500
Message-Id: <20221214220727.1350784-2-jcormier@criticallink.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221214220727.1350784-1-jcormier@criticallink.com>
References: <20221214220727.1350784-1-jcormier@criticallink.com>
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

Signed-off-by: "Cormier, Jonathan" <jcormier@criticallink.com>
---
 .../bindings/hwmon/adi,ltc2945.yaml           | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
new file mode 100644
index 000000000000..9ca7a886dec8
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
+      - ltc2945
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
+           #address-cells = <1>;
+           #size-cells = <0>;
+
+           ltc2945_i2c: ltc2945@6e {
+              compatible = "ltc2945";
+              reg = <0x6e>;
+              /* 10 milli-Ohm shunt resistor */
+              shunt-resistor-micro-ohms = <10000>;
+           };
+    };
+...
-- 
2.25.1

