Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E849D6A6E69
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCAO24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCAO2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:28:53 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA289199C5;
        Wed,  1 Mar 2023 06:28:51 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id i34so54489760eda.7;
        Wed, 01 Mar 2023 06:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qraxm/9HXdh2HNOxnclG1G7KZkQPcMY4/tQTySpYdVE=;
        b=D3i5prvBSoDAcYNiuUu7+Ssu1m/BFGlOVvRWt7XGwrnAZMMjAKCR6v4T/PI3GB76Qs
         Obgw7A4jpZ7PipFKe7tAATehnUfTGpylcNMFettfQpwC13grefuOYknBfcjxCnG3HAeh
         KpSesNJxfIhJhMR+JdvQIfpGA73k3WMIP7a2yw7pgQWxxD79hk9vsGCggOL2cWaSWelE
         LFEBwCSJAXogAJe8o1Jj8/mf2tv0J9KKXchTQ4Z/7US4mrIvauapmIPknTjZYJNUMBp2
         /DLrjfk+FsuD9teHeFW+Y4bP2hf8IG+0gStMWxCl/cIbO7yjcxj3WtsvaYpmb6jVr1Ud
         hNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qraxm/9HXdh2HNOxnclG1G7KZkQPcMY4/tQTySpYdVE=;
        b=SaOVOUxLOQzyrAm/Mid7xuNIssdbnc73fdwW0ioZPTr0EAKnbyIBrG0Qjd8LHGoz9U
         eOEbLXmhPIamRgk7mpu9DOz/tgpFcNlBCiseDI4DUApurvRZk2UE5Ik4kH1mdCcnIRGj
         VKeif3Ew/SENsJ5n8Zzn8BeKHEIEjzQaW+mKkTuFzmT79VCZ0VpKsGAJ/LBLpWGkjssh
         8kBfcEQ4t/gdX854x7scQLz6o2u+K/nvYReWmb01+D0quk3pdeqxmQ8GQsKWOtD/oczy
         4TB8uu3SF5bkpenXEQpSNySf4UtY4zF87tc4SVLjLulg/8uejLjlZpoZnhHCCGHCXP47
         JWWQ==
X-Gm-Message-State: AO0yUKV2HvDoGRYdfzyF3DCz9M80R/NB3ImHIagVj37WkcvoQZqYSfrf
        URcb8TfDUQKToJWP9/WjvxSSppfYugvR+w==
X-Google-Smtp-Source: AK7set9NnnMxq37N5F3qFRyecE7QdE72X972I3zYtHUWUturBwQILj5tB2qap0fhHdzlqow3aMiIow==
X-Received: by 2002:a05:6402:416:b0:4ad:7c30:2599 with SMTP id q22-20020a056402041600b004ad7c302599mr8180696edv.13.1677680930210;
        Wed, 01 Mar 2023 06:28:50 -0800 (PST)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id t8-20020a170906178800b008dcf89a72d7sm5972282eje.147.2023.03.01.06.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 06:28:49 -0800 (PST)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, airlied@redhat.com, dipenp@nvidia.com,
        treding@nvidia.com, mwen@igalia.com, fmdefrancesco@gmail.com,
        arnd@arndb.de, bvanassche@acm.org, ogabbay@kernel.org,
        axboe@kernel.dk, mathieu.poirier@linaro.org, linux@zary.sk,
        masahiroy@kernel.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, jacek.lawrynowicz@linux.intel.com,
        benjamin.tissoires@redhat.com, devicetree@vger.kernel.org,
        furong.zhou@linux.intel.com, andriy.shevchenko@intel.com,
        linus.walleij@linaro.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCHv3 1/4] dt-bindings: wiegand: add Wiegand controller common properties
Date:   Wed,  1 Mar 2023 15:28:32 +0100
Message-Id: <20230301142835.19614-2-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301142835.19614-1-m.zatovic1@gmail.com>
References: <20230301142835.19614-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Wiegand bus is defined by a Wiegand controller node. This node
can contain one or more device nodes for devices attached to
the controller(it is advised to only connect one device as Wiegand
is a point-to-point bus).

Wiegand controller needs to specify several attributes such as
the pulse length in order to function properly. These attributes
are documented here.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../bindings/wiegand/wiegand-controller.yaml  | 39 +++++++++++++++++++
 MAINTAINERS                                   |  5 +++
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml

diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
new file mode 100644
index 000000000000..df985cb3045a
--- /dev/null
+++ b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/wiegand/wiegand-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wiegand Generic Controller Common Properties
+
+maintainers:
+  - Martin Zaťovič <martin.zatovic@tbs-biometrics.com>
+
+description:
+  Wiegand busses can be described with a node for the Wiegand controller device
+  and a set of child nodes for each SPI slave on the bus.
+
+properties:
+  $nodename:
+    pattern: "^wiegand(@.*|-[0-9a-f])?$"
+
+  pulse-len-us:
+    description: |
+      Length of the low pulse in microseconds.
+
+  interval-len-us:
+    description: |
+      Length of a whole bit (both the pulse and the high phase) in microseconds.
+
+  frame-gap-us:
+    description: |
+      Length of the last bit of a frame (both the pulse and the high phase) in
+      microseconds.
+
+required:
+  - compatible
+  - pulse-len-us
+  - interval-len-us
+  - frame-gap-us
+
+additionalProperties: true
diff --git a/MAINTAINERS b/MAINTAINERS
index b0db911207ba..1f6f6d236f0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22512,6 +22512,11 @@ L:	linux-rtc@vger.kernel.org
 S:	Maintained
 F:	drivers/rtc/rtc-sd3078.c
 
+WIEGAND BUS DRIVER
+M:	Martin Zaťovič <m.zatovic1@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
+
 WIIMOTE HID DRIVER
 M:	David Rheinsberg <david.rheinsberg@gmail.com>
 L:	linux-input@vger.kernel.org
-- 
2.39.2

