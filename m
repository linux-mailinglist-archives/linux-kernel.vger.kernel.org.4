Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6263567B589
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbjAYPLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbjAYPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:11:08 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BCF577C3;
        Wed, 25 Jan 2023 07:11:05 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so2658571wmq.1;
        Wed, 25 Jan 2023 07:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k6iH6ye4eNPwympT1HKSV19Z/5AZl0oVvTiapSuckY=;
        b=ahtGBzXJtFuPzd0YkuxCd/KNvneyK5hNhBtxCyDok0bmmfzkA61L1PVcwdXDyYVd8j
         ZWhDdz9OXQCZ95mAAk3Sw7HS1SA0qZYOJ75si6XBZ85tW70ux8fwL1xmLi5YplYW9z2a
         PH041UV2DgwwizTC+w20XPFaHaQZUOZiQ9lDUH+jQEaZQptQNcU3Fcl1/0+NDdzMmmte
         7mW/hiIyrLN1j7QGBH+wRbNCOmKP3IsrkUnPah1SGSQ3zYxfGUF2EwuSMrCz0DvHj4bu
         c6Ma6go8K5KIFjNDud9ycHukymznll+Dg9ShlbbSIfTJDCWcvZcman0/qVvK6R3xP87Q
         c9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6k6iH6ye4eNPwympT1HKSV19Z/5AZl0oVvTiapSuckY=;
        b=ZRLSdqKu1+Isq5ik2/3ZBG5xLcUbQZsHvFUDdVMXT/D75EhqGCsyraTGI9HmOUSPxz
         1oCO6y80u4RU5DXPZwm1fN/7P8lybpAkyd1KiCGFbTjmiSDqeJ3QPKjP6NCs7aQLHTNn
         3GfXwmWQ/jmmPCPJz72r44LIFtyS17/epvKbFm0bOmUc50XuJdTHeYM60RWlhfZj9o8b
         NsgLa9dacIlYde++uHOAs2CYXcgwe7ljD7g/OeqhvQxrbEcqMX93XM/+RvZWmfPFTBro
         7aziEKySn73lnl44X3tbJXD1gdD+RN/jMwvLvOJwck8cEx15kEgzaco9w9NOlmFfPTh6
         JTuw==
X-Gm-Message-State: AFqh2krrudE31V3lO4QAdxvccS01l+z3LWTVDAIK07zAcOwLVGyL7/69
        mknNZIZeZ6RYOPWoqk7uRhc=
X-Google-Smtp-Source: AMrXdXvTpleKmDKo3XRUkgwFgruiRcTXHdOiIS+BOchozQho/sHJzli4AG0NzfGbY3k3fda9lkwFoQ==
X-Received: by 2002:a05:600c:310e:b0:3db:eb0:6f6 with SMTP id g14-20020a05600c310e00b003db0eb006f6mr28834474wmo.13.1674659464119;
        Wed, 25 Jan 2023 07:11:04 -0800 (PST)
Received: from localhost ([82.222.96.52])
        by smtp.gmail.com with UTF8SMTPSA id t19-20020a1c7713000000b003c71358a42dsm2528563wmi.18.2023.01.25.07.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 07:11:03 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/5] dt-bindings: pwm: Add Apple PWM controller
Date:   Wed, 25 Jan 2023 18:10:37 +0300
Message-Id: <20230125151041.55483-2-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230125151041.55483-1-fnkl.kernel@gmail.com>
References: <20230125151041.55483-1-fnkl.kernel@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.37.1 (Apple Git-137.1)

