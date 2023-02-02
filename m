Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3DB688033
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjBBOd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjBBOdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:33:23 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DBC70D66;
        Thu,  2 Feb 2023 06:33:13 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id me3so6477014ejb.7;
        Thu, 02 Feb 2023 06:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8r6DkoETWsIgmS/Xmo5gOSzidDMMFOeOxAXjNrOtJE=;
        b=RaocD1pHp6TJyQCWEcVek7fYJPOy+7+RuO0Edq73pthLuJR6LV7KHHywomUoHYd2+l
         X17/W41UsrEAoNleicS34D/rMEYs7+NI5omwaMgYmPNB3XU3faIorut46kHnGmUiKKEF
         jD+FwwXcOvTg3zrVW+u5Zbr+pJSL/LFRzYdKTex0kt71RHSw+b2VvSyAMYvOoo9BL9e0
         0tckVecGLmx91as4l7PE5gKIMRP8MdjPFMeovPgI3QkWCTyijErwTWy/9fE65MWvkXoC
         4/AeMItSxOuARiDOmnD06zyMj6KUSYtw80aAKPveNARuX8+0LpR3HTTdYr8T3TeHsLkJ
         Gsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8r6DkoETWsIgmS/Xmo5gOSzidDMMFOeOxAXjNrOtJE=;
        b=Go/DtK1vlb4rbHHVX4Q7TBk3udp6mcYYkVyYHcn/UlJBin9v3jovOJpninTcFk8nAo
         HC48yrMciMbt9Z6MTzoWe1zo4k6Lt22byjyLZIaWEKOZpUo5DaxXVPeHJhZp2nJc3TSb
         EIrJ9Ihjvd5pLAkDLM6wi8o/L3V0a+6V3cjUVkLAVNxdS4d+7Bqvb5oNBaXi78LiR9xf
         dZfHUuX40o2yfJUFl0jx8+wvuCNbJ6UKgdAs0ABp0ju2uU9jPgCNzexg4Bs9r8uTqtDz
         S2aRyvw48vENkYZWOlTtoYA0cr6mWYlzJtiR8Fipb0RbdbFRqWnwH+4gFsCtwv3BAeNb
         HhgA==
X-Gm-Message-State: AO0yUKWtSKfg/VjDrnjFIJ4Q2QZTorAKjtSRh+oey6P9rQFcr4AV3YTv
        R5qOI52bx/hPagv5jTllFPdAe7abiqT8Wg==
X-Google-Smtp-Source: AK7set+/t/Hvx6HCB5PaEI8Fm9dwFEiyx9wsphAp67ZBEJE/qW5CluXrygKIJbu068bGJxWMPlZAog==
X-Received: by 2002:a17:906:ccce:b0:872:ec40:65e9 with SMTP id ot14-20020a170906ccce00b00872ec4065e9mr6465557ejb.18.1675348391611;
        Thu, 02 Feb 2023 06:33:11 -0800 (PST)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id h17-20020a1709066d9100b0087856bd9dbbsm11814237ejt.97.2023.02.02.06.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 06:33:11 -0800 (PST)
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
Subject: [PATCHv2 1/4] dt-bindings: wiegand: add Wiegand controller common properties
Date:   Thu,  2 Feb 2023 15:33:02 +0100
Message-Id: <20230202143305.21789-2-m.zatovic1@gmail.com>
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

Weigand bus is defined by a Wiegand controller node. This node
can contain one or more device nodes for devices attached to
the controller(it is advised to only connect one device as Wiegand
is a point-to-point bus).

Wiegand controller needs to specify several attributes such as
the pulse length in order to function properly. These attributes
are documented here.

Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../bindings/wiegand/wiegand-controller.yaml  | 50 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml

diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
new file mode 100644
index 000000000000..fed90e01e56f
--- /dev/null
+++ b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
@@ -0,0 +1,50 @@
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
+
+examples:
+  - |
+    wiegand@f00 {
+        compatible = "wiegand-foo";
+        pulse-len-us = <50>;
+        interval-len-us = <2000>;
+        frame-gap-us = <2000>;
+
+        /* devices */
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427..db9624d93af0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22428,6 +22428,11 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-wiimote*
 
+WIEGAND BUS DRIVER
+M:	Martin Zaťovič <m.zatovic1@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
+
 WILOCITY WIL6210 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-- 
2.39.1

