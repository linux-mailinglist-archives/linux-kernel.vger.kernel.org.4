Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699985F56F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiJEO65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiJEO6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:58:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6217D1E7;
        Wed,  5 Oct 2022 07:58:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id 13so36061707ejn.3;
        Wed, 05 Oct 2022 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ImmpV6nBR3axrQ+CsoksQDBmfqCSG7z7E6j/x4o0FG0=;
        b=nPWqxTArnPtfpiAmk4Eb6+XVVapsXuO5q+8bmGaUKhDR5EPdr0gNGhfB1zxngaLaGr
         DjADGn7XP2uqDx8OQ1DYP3Y3a2g5UjSQXpb0nAn34GU0xijMOGElKiYNnJXNw46FLEPx
         U2xNqPCFKMuDc6dxw+VMaq1Q9Ii8xrBDmcFUrF4Sxl2GvqGJkO52Ab2t8eGxtdpuJmsG
         bTtDPIq4jG6Ge4wB91DlhIzPCzxzlteGu+GgkdacK0CgLN904hZAKJhGa9v9T0l1r/ey
         9XZ+LRiHY9sSSYsc6cjUCFp5ct4mECU5Us2bBEgolfUoZ4Hl2t4f2hTay7gCfTygLhQd
         cOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ImmpV6nBR3axrQ+CsoksQDBmfqCSG7z7E6j/x4o0FG0=;
        b=5Dq5iOSjUQj94GxOBhaewKgHTFV3HozClj0++imGOJMoH4D1Ilv0czF1DFiF5Zk+Zr
         jhTBp0hwahBjqmVPX1GMSruSXsepBK3NBzMsRdC0h1GCpk0jonXUJyussUnSLvH0gOlD
         8FCIz1DtNjmWyjKIsBRIfB2qRWidlpL+yj2jDrlkqpOnVOHLRQRokaBlL+qZ/vH8ujvF
         scu76lakhYaF389o6JtWcY9DTocfAbMOyUJ/k+9jRk8RfJKqv+ao9M6Vc2URmrxKsNhE
         jyykPTjcdaQ54pd1ZyUXqNzLRk/b5iZWPYclqmD7nUni0n7p/6sSvgeGoOYqAzduYJDj
         4log==
X-Gm-Message-State: ACrzQf3PkHfNd4q1utgP7seUlqgVWr3Qh+mxETw6Ew+Kfl1Ug6VMQp9D
        Ra56qHPdimbgmD7ksteiGxE=
X-Google-Smtp-Source: AMsMyM4eEyb/PxSl+suE8e3QB/xio6KselddNr/nODPfHDQELLaOI2roSQegyfiTMwwa/Q0FpMq6rg==
X-Received: by 2002:a17:907:988c:b0:78c:e54b:9030 with SMTP id ja12-20020a170907988c00b0078ce54b9030mr3878ejc.149.1664981881135;
        Wed, 05 Oct 2022 07:58:01 -0700 (PDT)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id m5-20020a50cc05000000b004588ef795easm4023941edi.34.2022.10.05.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:58:00 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        gregkh@linuxfoundation.org, jeffrey.l.hugo@gmail.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, saravanak@google.com,
        mani@kernel.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [RFCv2 PATCH 1/4] dt-bindings: bus: add Wiegand bus dt documentation
Date:   Wed,  5 Oct 2022 16:57:43 +0200
Message-Id: <20221005145746.172138-1-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.37.3
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

This patch documents the devicetree entry for enabling Wiegand
bus driver. The drivers that will use Wiegand bus driver shall
create a sub-node of the documented node.

Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
Hello again,

this is the second round of RFC patches in an attempt to add Wiegand
driver to linux kernel. Thank you for all the issues you have pointed
out in the first round. I have tried to fix all of them and I have
also implemented a Wiegand bus driver, that is now used by the GPIO
driver itself - as suggested by Linus.

Any advice you have for me regarding the patches will be appreciated!

With regards,
Martin Zaťovič
---
 .../devicetree/bindings/bus/wiegand.yaml      | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/wiegand.yaml

diff --git a/Documentation/devicetree/bindings/bus/wiegand.yaml b/Documentation/devicetree/bindings/bus/wiegand.yaml
new file mode 100644
index 000000000000..1ed863ab925c
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/wiegand.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/wiegand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wiegand Bus
+
+maintainers:
+  - Martin Zaťovič <m.zatovic1@gmail.com>
+
+description: |
+  Wiegand interface is a wiring standard popularized in the 1980s. To this day
+  many card readers, fingerprint readers, sensors, etc. use Wiegand interface
+  particularly for access control applications. It utilizes two wires to
+  transmit the data - D0 and D1.
+
+  Both data lines are initially pulled up. To send a bit of value 1, the D1
+  line is set low. Similarly to send a bit of value 0, the D0 line is set low.
+
+properties:
+  $nodename:
+    pattern: "^wiegand(@[0-9a-f]+)?$"
+
+  compatible:
+    contains:
+      const: wiegand
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    wiegand {
+        compatible = "wiegand";
+
+        wiegand-gpio {
+            compatible = "wiegand,wiegand-gpio";
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_uart2_wiegand>;
+            data-hi-gpios = <&gpio 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+            data-lo-gpios = <&gpio 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+        };
+    };
+
+...
-- 
2.37.3

