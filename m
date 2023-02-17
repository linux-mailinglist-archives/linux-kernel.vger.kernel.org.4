Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894C069AEB5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjBQO6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjBQO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:58:15 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED2B3C2C;
        Fri, 17 Feb 2023 06:57:48 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bw20so1453009wrb.12;
        Fri, 17 Feb 2023 06:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zY7RunGigRI1kAQ2n+Jdn1SXa/ZfrYbFHAjRSPYp6+o=;
        b=WQWeYSqRbvXUegEJBbGyXF+0s8d4S5IQcQgUrwJrxZpENrJKyVc73/7p8JjRLJ99cs
         QOIGFj9VrYyYdDxWiqSZeOozxf0dhMMOle7ycJp9X8GGV0hM4uxey3FvfWE6rz/UeBkS
         eKP/I6Th13y+MKc4G5N2Rk0uys3bwtSyR+RS7i130YAgHjKQ7XDHJt6VrXnUqGnwqhkO
         bJ+d0jjdZuECjGK8x5qXthGjAFKW4jd+3bJqfrWxffCvMCvh1hGTyIMch9912oE3/fVp
         NwXLLdq9N+JrBn7f5iLkeVUpMwFlwWNJjEUj7VaQyn843ccIpwxQmPsI/Urx3isxfAtW
         K/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zY7RunGigRI1kAQ2n+Jdn1SXa/ZfrYbFHAjRSPYp6+o=;
        b=PVlSJmBj1svf1lajbv12GALQnoefh8EqYS10YX+EBpe5I0bAZpNJVvMBuzE59PasDc
         i+3qFtjwGKO6gC0PFPm3iyAgwEy5zXTN+b47NHm9M1VRvInQviw2KK6dYIIJBH55CKg1
         tT0y8i2JgldpGPn8ShMdgEa+/Y7ognHMGhN05NxYgvxVqSDS1RTeE/a91uLe2wAMCZqe
         CgaMy/r8FOY0jPBSkHMHgvgMDGbRylaZxADYATvgdo0AbbWfxsL8Wl/phkYaaasO3fKZ
         6vG3nxcynipKfrDplKQbi8JgEyKW/xMOvGulhsbQF69XlGmXUSjfGFxshXN/NIKqSEwk
         x9dg==
X-Gm-Message-State: AO0yUKXUMf/TL2pAZzC7XhznaTRbDbtZXoruKRKkKKLr33DXO2q5qt5h
        KBs9zB++QHYbjxTHuqWW9us=
X-Google-Smtp-Source: AK7set8XbBX+PfJkKr5DvStn2rjJ+GmUtegv7bAM2XSZp4Q+7scu1v0yqbnpx7vOKxE5cB0OCAv9cw==
X-Received: by 2002:a5d:4f0e:0:b0:2c5:5234:882c with SMTP id c14-20020a5d4f0e000000b002c55234882cmr9168335wru.7.1676645859724;
        Fri, 17 Feb 2023 06:57:39 -0800 (PST)
Received: from angelo-ThinkPad-X270.. (host085115199111.static.fidoka.tech. [85.115.199.111])
        by smtp.gmail.com with ESMTPSA id a17-20020adff7d1000000b002c3d29d83d2sm4434221wrq.63.2023.02.17.06.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 06:57:38 -0800 (PST)
From:   Angelo Compagnucci <angelo.compagnucci@gmail.com>
X-Google-Original-From: Angelo Compagnucci <angelo@amarulasolutions.com>
To:     Angelo Compagnucci <angelo@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: leds: servo-pwm: Add new bindings for servo-pwm
Date:   Fri, 17 Feb 2023 15:57:30 +0100
Message-Id: <20230217145731.3018148-3-angelo@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230217145731.3018148-1-angelo@amarulasolutions.com>
References: <20230217145731.3018148-1-angelo@amarulasolutions.com>
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

This binding describes the binding for controlling servo motors through
pwm.

Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
---
 .../devicetree/bindings/misc/servo-pwm.yaml   | 59 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/servo-pwm.yaml

diff --git a/Documentation/devicetree/bindings/misc/servo-pwm.yaml b/Documentation/devicetree/bindings/misc/servo-pwm.yaml
new file mode 100644
index 000000000000..faa8d4734817
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/servo-pwm.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/servo-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Servo motor connected to PWM
+
+maintainers:
+  - Angelo Compagnucci <angelo@amarulasolutions.com>
+
+description:
+  Each servo is represented as a servo-pwm device.
+  The 20ms period is the accepted standard and so most of the motors
+  support it, while the positioning min/max duty cycle or the motor
+  degrees aperture vary lot between manufacturers.
+  The most common type of servo (SG90) has 180 degrees of movement
+  and moves between 0.5ms and 2.5ms duty cycle.
+
+properties:
+  compatible:
+    const: servo-pwm
+
+patternProperties:
+  properties:
+    pwms:
+      maxItems: 1
+
+    pwm-names: true
+
+    degrees:
+      description:
+        How many degrees the motor can move.
+      $ref: /schemas/types.yaml#/definitions/uint32
+
+    duty-min:
+      description:
+        Duty cycle for position the motor at 0 degrees.
+      $ref: /schemas/types.yaml#/definitions/uint32
+
+    duty-max:
+      description:
+        Duty cycle for positioning the motor at "degrees" angle.
+      $ref: /schemas/types.yaml#/definitions/uint32
+
+additionalProperties: false
+
+examples:
+  - |
+
+    servo: servo@0 {
+      compatible = "servo-pwm";
+      pwms = <&pwm 0 20000000 0>;
+      degrees = <180>;
+      duty-min = <500000>;
+      duty-max = <2500000>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 356daea0861d..8f41daee62fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8742,6 +8742,7 @@ M:	"Angelo Compagnucci" <angelo@amarulasolutions.com>
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-driver-servo-pwm
+F:	Documentation/devicetree/bindings/misc/servo-pwm.yaml
 F:	drivers/misc/servo-pwm.c
 
 GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
-- 
2.34.1

