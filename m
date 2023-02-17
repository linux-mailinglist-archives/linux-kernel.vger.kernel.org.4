Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0414C69B043
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjBQQLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjBQQLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:11:16 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB757119F;
        Fri, 17 Feb 2023 08:11:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bw20so1680408wrb.12;
        Fri, 17 Feb 2023 08:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KiQdfcVW5OH9o2jTcH3flkYc6aif9hE1iWB2XGTQUc=;
        b=m3x70UaK+rll5W5hWkxLyAvaKvNHE8cOWar0xmWSedM2gSBWPWJM0PcycxHl2pjm0G
         cu99i63oNy1Di/6aNSK29MMa7rjtSMzTYeJRaNRU/MiebQf2jwk/3URaTA5Ch56V+aCl
         Xk6ucUr0J87nwKlxm3r1F/nWRnPrG7BLIJrs2Wcl6HJt1e8bfUeI7mHMwPpRRBYfwtIh
         g7qzqVLmuGrmQN04lBwZ9lAhvLig/lFtCLVJ6Le1Pe9ZrvVgFEVNXiTN35l8xLsExRtu
         LsHy+xUHmbn1e1urSAeS7tNGCgca+yfybrQFQiD6TFprkE6TEZhhAVjEyhhRs3gGsP9k
         hiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KiQdfcVW5OH9o2jTcH3flkYc6aif9hE1iWB2XGTQUc=;
        b=U8fSRvK6+U7IWiVtoHUNiz8HKs8ueIH5ExwAr2XjSVHS9Pa6vRYUe8woGx1IUHehji
         djq1+A1A1OpWOTZv34FCVtrUsA7CV5XVBL3oOuOQN59LBxQaZ6VuCMcYBXbTYxmUPlDP
         lB4EmUJw0sVv3OqtTXozIBN8sYavj4ZqwbRxSNO/I3t2KkZJ43wrbaIy/VtgZ5heI3O8
         SJmhemEECneTtBfGEHDX6C0BVneYctha7TTU5iTJl2mH7gxXPnAeRiVCt25zE1s1aIqx
         ZoqwvVjt/Mq1rKd5vs3h3+TqAGvnN+TLgXN4ZwYtJ2A3xikO99TY43v1aEMU13zCya5g
         PfaQ==
X-Gm-Message-State: AO0yUKWBALyUjvIH2+gzo+lwO+w6NYK9Fu+oYl6FnWAxxUum7idWA3dI
        X+zmTX2SdmHerDW0FDrpvSc=
X-Google-Smtp-Source: AK7set947Bg/3VSNmJsyBAPLT/gvadF9dbPQPi9vuXmAzlzeg5sEtqE1GruVqdJEQJAr/iFdQ/txUQ==
X-Received: by 2002:a5d:4e0b:0:b0:2c5:5ed5:2e6a with SMTP id p11-20020a5d4e0b000000b002c55ed52e6amr982349wrt.5.1676650265892;
        Fri, 17 Feb 2023 08:11:05 -0800 (PST)
Received: from angelo-ThinkPad-X270.. (host085115199111.static.fidoka.tech. [85.115.199.111])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d5088000000b002c567881dbcsm4609792wrt.48.2023.02.17.08.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 08:11:04 -0800 (PST)
From:   Angelo Compagnucci <angelo.compagnucci@gmail.com>
X-Google-Original-From: Angelo Compagnucci <angelo@amarulasolutions.com>
Cc:     Angelo Compagnucci <angelo@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pwm@vger.kernel.org (open list:GENERIC PWM SERVO DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/3] dt-bindings: misc: servo-pwm: Add new bindings for servo-pwm
Date:   Fri, 17 Feb 2023 17:10:37 +0100
Message-Id: <20230217161038.3130053-3-angelo@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230217161038.3130053-1-angelo@amarulasolutions.com>
References: <20230217161038.3130053-1-angelo@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding describes the binding for controlling servo motors through
pwm.

Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
---
v2:
* Converted old txt to yaml
v3:
* Fixed errors rised by make dt_binding_check 

 .../devicetree/bindings/misc/servo-pwm.yaml   | 57 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/servo-pwm.yaml

diff --git a/Documentation/devicetree/bindings/misc/servo-pwm.yaml b/Documentation/devicetree/bindings/misc/servo-pwm.yaml
new file mode 100644
index 000000000000..73e81b939daf
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/servo-pwm.yaml
@@ -0,0 +1,57 @@
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
+  pwms:
+    maxItems: 1
+
+  pwm-names: true
+
+  degrees:
+    description:
+      How many degrees the motor can move.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  duty-min:
+    description:
+      Duty cycle for position the motor at 0 degrees.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  duty-max:
+    description:
+      Duty cycle for positioning the motor at "degrees" angle.
+    $ref: /schemas/types.yaml#/definitions/uint32
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

