Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FFC688037
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjBBOdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjBBOdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:33:32 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177896F210;
        Thu,  2 Feb 2023 06:33:17 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id dr8so6401225ejc.12;
        Thu, 02 Feb 2023 06:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYfcce3tKsjP0K5Vg/OUHjCofLEX8tvrmEMZwYBrXQ0=;
        b=gEutbN+MF4m4qaELiNNglwGbzC1VylJ47LcnFiIK5ddNzC5op+2YwKTH9PwoxRksf+
         35HIdaRfNi83DlZAzs1C4m2wPaF4iXYgCmkA0CU3scVDQkvsT6SskgvsHmvLoeewOYFk
         EEy33QrwSqhz3ytvc1UN+5CR8Xzr7cIgrwq8NhUHXFkGOjwcIP2nKPXcfXZ8Cgxc3GTW
         rRLcrjcGlM79R8ji69ldJpaqg/im4dkPiKknODwvqspZrbSeae7fMgm5qUy1l5zlbkLS
         auk5+XBWO5eyHhVroYIhT7y15DpJvd+PhMX4KhD43rvEPagoy9ugnEjr4Zl810rrJ3bb
         kwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYfcce3tKsjP0K5Vg/OUHjCofLEX8tvrmEMZwYBrXQ0=;
        b=sDr3MiKGOQlcf4u1UiGjUEnUxNdO49UIVCW5JtGI1XaWyBZpOOIjC7JeiMpKLZFT2L
         PerVV+trnVo/qeG114LvvsEjpG81J+vmPmlfHa3x2XaYbdGcVRqyHmWfnWejbxAHKGZd
         LnymVwHDt/ouSMaHh09xWpuzoh9EG72alMykZ2QI2oU9KN2tyruhHUDv3URgA1q/K43h
         t0F9jEAiRP78J9OcRYOjXgGkvSjNOvqsBeUDQ7+5bFTP8xi/Qr6B2DBG90eUuoyuFnzE
         RWUlPCO1DBXnI+yWKwXjStKIp2g49nBPBW8PMTLP7Km45aqVVUEeSAGPk+usm8qUEmgC
         nzzA==
X-Gm-Message-State: AO0yUKW2zY5cH2EKosfQZHdBKxLvUt2FYdGETkTkIs+F15ZyTzRMJNf/
        Gp3MLrVBKfTzqrPMCQtjprICR/8XLAEUxA==
X-Google-Smtp-Source: AK7set/Kgr2nQMlW35aLy1lEEoMCc8D7NmzmXdcscytYTJ0NEYyV7i4D4w0Q714bbCtHIdQOEqMd0g==
X-Received: by 2002:a17:906:f913:b0:878:711f:f3d0 with SMTP id lc19-20020a170906f91300b00878711ff3d0mr5545741ejb.4.1675348395498;
        Thu, 02 Feb 2023 06:33:15 -0800 (PST)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id h17-20020a1709066d9100b0087856bd9dbbsm11814237ejt.97.2023.02.02.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 06:33:15 -0800 (PST)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, martin.petersen@oracle.com,
        beanhuo@micron.com, arnd@arndb.de, avri.altman@wdc.com,
        iwona.winiarska@intel.com, fmdefrancesco@gmail.com,
        dipenp@nvidia.com, ogabbay@kernel.org, bvanassche@acm.org,
        mathieu.poirier@linaro.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCHv2 3/4] dt-bindings: wiegand: add GPIO bitbanged Wiegand documentation
Date:   Thu,  2 Feb 2023 15:33:04 +0100
Message-Id: <20230202143305.21789-4-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202143305.21789-1-m.zatovic1@gmail.com>
References: <20230202143305.21789-1-m.zatovic1@gmail.com>
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

Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../bindings/wiegand/wiegand-gpio.yaml        | 51 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml

diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
new file mode 100644
index 000000000000..3af0b7e04b3a
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
+  - $ref: "/schemas/wiegand/wiegand-controller.yaml#"
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
index 8119d12dac41..54d61d95a1ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22435,6 +22435,11 @@ F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
 F:	drivers/wiegand/wiegand.c
 F:	include/linux/wiegand.h
 
+WIEGAND GPIO BITBANG DRIVER
+M:	Martin Zaťovič <m.zatovic1@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
+
 WILOCITY WIL6210 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-- 
2.39.1

