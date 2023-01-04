Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415A965D499
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjADNhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbjADNgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:36:46 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581E93AABC;
        Wed,  4 Jan 2023 05:34:43 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jo4so82614127ejb.7;
        Wed, 04 Jan 2023 05:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsgtBjS68Ohvo1thth+3WmlxZ3oCDpfdMvKjKCDOwTM=;
        b=hXMy5MxKif13gMjlj3n/5ryfal7kMspvOjKlH1P9wVPHCEwWdzydaSRZ1SeEA3dM1s
         SW5e2fPhjOw+O6R2dT62b4G378kF26DJjSX36lbh0HzEG3O+yaLwH8QcM5bGL2Jfn66f
         /zgsUc1tqxiy3z6E4g+zzsnxRkc5YDbaR+D9cLhFMoGnydkKStazzRr9eM/ZDj+efVaU
         63uQBpW/dSKkm7Q6k+lruNBab8pUIdOhREpwcXjoLGI+ZMeejOLuvXFdNN3f2etW05oi
         3CCxmrtjliqAZPip/27yqOCC4XFPwCoU2goMJZ3wWbeaoz0ZH7C5+BMWg8tfxLwerjWS
         LqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsgtBjS68Ohvo1thth+3WmlxZ3oCDpfdMvKjKCDOwTM=;
        b=sV9yNKvaAp2ujDVU9kfu4T1le3JoGbB5Z4TTfYrAxy996SU4YYxzzx3sYLbOi50Dc2
         F2Gcmvu7aTdGd9VBlg0mQ8/kCTApd2Qb+GyUUM7nZWM2tqPRGvOGCKxG0no3d4Vrsu+r
         i4pSp9t5UKhpEdiAproAThjtCUtTU2VTYu7dZzoVF0inCRRsbHAouUvLEFv7CL2X8NW1
         yHxtdq4iTyBDOWVnkh92EcUcWnV49V/WtmH5NNBfvNjITowirdxj4Ip63PxdIr635462
         882t9mALaus+8CgzHmGHN455aa1hX+orWXjD6ATpe0jARVyxxHHv0r9ZQE7BAty/teme
         XhAg==
X-Gm-Message-State: AFqh2krS+dDNTY1CTqvobC4+EamAmEYQpI4KjwmlFPV065otLhH5i3mu
        YeU9N1Nf2rwqhD7SyKHUgyznRAh5SpJgCQ==
X-Google-Smtp-Source: AMrXdXtEtq88qenKCBf1cV3Dphy6g63TjTP4Rnd6crob4VSX0UsXiD7kja8Ihi28R5K7ykKMwQ5UUQ==
X-Received: by 2002:a17:906:354c:b0:7c0:e988:4157 with SMTP id s12-20020a170906354c00b007c0e9884157mr41343157eja.40.1672839273222;
        Wed, 04 Jan 2023 05:34:33 -0800 (PST)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id sb20-20020a170906edd400b0073dbaeb50f6sm15211659ejb.169.2023.01.04.05.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:34:32 -0800 (PST)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mani@kernel.org,
        hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, arnd@arndb.de,
        dipenp@nvidia.com, bvanassche@acm.org, iwona.winiarska@intel.com,
        ogabbay@kernel.org, tzimmermann@suse.de, fmdefrancesco@gmail.com,
        jason.m.bills@linux.intel.com, jae.hyun.yoo@linux.intel.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCH 1/3] dt-bindings: add Wiegand controller dt-binding documentation
Date:   Wed,  4 Jan 2023 14:34:12 +0100
Message-Id: <20230104133414.39305-2-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230104133414.39305-1-m.zatovic1@gmail.com>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
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

A Weigand bus is defined by a Wiegand controller node. This node
can contain one or more device nodes for devices attached to
the controller(it is advised to only connect one device as Wiegand
is a point-to-point bus).

Wiegand controller needs to specify several attributes such as
the pulse length in order to function properly. These attributes
are documented here.

Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../bindings/wiegand/wiegand-controller.yaml  | 83 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml

diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
new file mode 100644
index 000000000000..645306c65d43
--- /dev/null
+++ b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/wiegand/wiegand-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wiegand Controller Generic Binding
+
+maintainers:
+  - Martin Zaťovič <martin.zatovic@tbs-biometrics.com>
+
+description: |
+  Wiegand busses can be described with a node for the Wiegand controller device
+  and a set of child nodes for each SPI slave on the bus.
+
+properties:
+  $nodename:
+    pattern: "^wiegand(@.*|-[0-9a-f])*$"
+
+  compatible:
+    maxItems: 1
+    description: Compatible of the Wiegand controller.
+
+  data-high-gpios:
+    maxItems: 1
+    description: GPIO used as Wiegands data-hi line. This line is initially
+      pulled up to high value. Wiegand write of a bit of value 1 results in
+      this line being pulled down for pulse length duration.
+
+  data-lo-gpios:
+    maxItems: 1
+    description: GPIO used as Wiegands data-lo line. This line is initially
+      pulled up to high value. Wiegand write of a bit of value 0 results in
+      this line being pulled down for pulse length duration.
+
+  pulse-len-us:
+    maxItems: 1
+    description: Length of the low pulse in microseconds.
+
+  interval-len-us:
+    maxItems: 1
+    description: Length of a whole bit (both the pulse and the high phase)
+      in microseconds.
+
+  frame-gap-us:
+    maxItems: 1
+    description: Length of the last bit of a frame (both the pulse and the
+      high phase) in microseconds.
+
+  slave-device:
+    type: object
+
+    properties:
+      compatible:
+        description:
+          Compatible of the Wiegand device.
+
+    required:
+      - compatible
+
+required:
+  - compatible
+  - pulse-len-us
+  - interval-len-us
+  - frame-gap-us
+
+additionalProperties: false
+
+examples:
+  - |
+    wiegand@f00 {
+        compatible = "wiegand-gpio";
+        data-hi-gpios = <&gpio2 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+        data-lo-gpios = <&gpio2 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+        pulse-len-us = <50>;
+        interval-len-us = <2000>;
+        frame-gap-us = <2000>;
+        status = "okay";
+
+        wiegand-foo-device {
+                compatible = "wiegand-foo";
+        };
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
2.38.1

