Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E34E6A6E6D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCAO3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCAO25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:28:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1E21B33E;
        Wed,  1 Mar 2023 06:28:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cq23so54647277edb.1;
        Wed, 01 Mar 2023 06:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIK1zlcDtzGzZUoPfFsY1qnnB3Dv1hWrxQ0eoBZLglg=;
        b=MlmlpzzsYNljnIJffqf1a7CYsFtxeYOiLIphYeOpbxlbZdzzaEBgGcqiuqV7xjX0sb
         Yxq5Gn6LiUFD5pw5Je+lMZgNrfIJZhdLrkuPwDSR2wZaJ4DS2L+CBJP/QU15pMb/Eve8
         H0+iuAzm8LNjJZ6YpxA/UutoOrRN/4KnTqh+4XBBEBabB8E4sW+LIKh7e/AapaMKh2Be
         PlTECaDUk00J5e37Z8k3ZesourLmdpxCaYKulZ2xAGUC5en8sHYpc3ypnEfVV+JK3zGM
         oJnZIhWVmueGQoPqFyBq+dMz/6jTukEXb8OaYrl7O97KhhxIRfjr2mX14RyRaZ30QGAF
         4nMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIK1zlcDtzGzZUoPfFsY1qnnB3Dv1hWrxQ0eoBZLglg=;
        b=N/i6T7Rx57bpLLYCsP1ubf8wBImLhSrzbL94I2wWz0Tqjy9eFQo0Y+kUO2yPwczQCF
         hea4oQG0kzQAcIrHAuxKUjAQ0JAOvcqE07kZKfx11bGOsvvUJrRgwkQQi+BbOyX4SXPB
         aorXkPdVSR5etbSj9F4UL16gzm9RJaESyUoMi+m0cU0Zgaaw6fBhVDjNdSf10FBzb7uo
         mDEMVJwhEiBwgxuFxC+tcwAgpMm7cQ3Cuyzk1eLn4UgEpMl+did6ZekgTox0u5M/SOup
         PamszRe2dfHnhrucEoASLeVvaED1EFA5agitWCDRYhkkXrgS1w3h4IFFw2yjO7zGIEtK
         aS8Q==
X-Gm-Message-State: AO0yUKXfADGsKaJPGulhzz848/Gd0R0POpiFlw+PLBuV8j38qXt7RXTB
        C9vZ+OnBfkM9j/cfojnVMfhBu0SBXe8jJQ==
X-Google-Smtp-Source: AK7set/vm6zpt1cqrr+wCkp29vG2fzKR2+JDt3v9fK6v15rlEFtpTsQ84efvhCy4ehXfZI41Y/s4ZA==
X-Received: by 2002:aa7:c7cc:0:b0:4ac:bbc7:aa8e with SMTP id o12-20020aa7c7cc000000b004acbbc7aa8emr6134099eds.41.1677680934606;
        Wed, 01 Mar 2023 06:28:54 -0800 (PST)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id t8-20020a170906178800b008dcf89a72d7sm5972282eje.147.2023.03.01.06.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 06:28:54 -0800 (PST)
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
Subject: [PATCHv3 3/4] dt-bindings: wiegand: add GPIO bitbanged Wiegand controller
Date:   Wed,  1 Mar 2023 15:28:34 +0100
Message-Id: <20230301142835.19614-4-m.zatovic1@gmail.com>
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

GPIO bitbanged Wiegand controller requires definitions of GPIO
lines to be used on top of the common Wiegand properties. Wiegand
utilizes two such lines - D0(low data line) and D1(high data line).

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../bindings/wiegand/wiegand-gpio.yaml        | 51 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml

diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
new file mode 100644
index 000000000000..df28929f6dae
--- /dev/null
+++ b/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/wiegand/wiegand-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO bitbanged Wiegand interface devicetree bindings
+
+maintainers:
+  - Martin Zaťovič <m.zatovic1@gmail.com>
+
+description:
+  This represents the GPIO lines used for bit-banged Wiegand on dedicated GPIO
+  lines.
+
+allOf:
+  - $ref: /schemas/wiegand/wiegand-controller.yaml#
+
+properties:
+  compatible:
+    const: wiegand-gpio
+
+  data-hi-gpios:
+    description: GPIO used as Wiegands data-hi line.
+    maxItems: 1
+
+  data-lo-gpios:
+    description: GPIO used as Wiegands data-lo line.
+    maxItems: 1
+
+required:
+  - compatible
+  - data-hi-gpios
+  - data-lo-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    wiegand@f00 {
+        compatible = "wiegand-gpio";
+        pulse-len-us = <50>;
+        interval-len-us = <2000>;
+        frame-gap-us = <2000>;
+        data-lo-gpios = <&gpio2 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+        data-hi-gpios = <&gpio2 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+        /* devices */
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 23a67b32f095..91e573466d6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22519,6 +22519,11 @@ F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
 F:	drivers/wiegand/wiegand.c
 F:	include/linux/wiegand.h
 
+WIEGAND GPIO BITBANG DRIVER
+M:	Martin Zaťovič <m.zatovic1@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
+
 WIIMOTE HID DRIVER
 M:	David Rheinsberg <david.rheinsberg@gmail.com>
 L:	linux-input@vger.kernel.org
-- 
2.39.2

