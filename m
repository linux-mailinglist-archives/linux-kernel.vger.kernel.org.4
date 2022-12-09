Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719446483E4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLIOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiLIOiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:38:02 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F2922536;
        Fri,  9 Dec 2022 06:38:00 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v7so6593wmn.0;
        Fri, 09 Dec 2022 06:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCCqc2mN6PDwZNJTpNkZ/sMpb25Tt4lXb3t6nfn4XxQ=;
        b=TjvKSMpvEouDWWWllhaB6LIzYAWG8PCYo5x2O6lPpvyx7Fd9I3iu3L994KkNwFIesN
         63CLF2zm/7O87FcDOadkUnllJvmPSj+2B7Jy7QmRj3wuzb58xg0zK7tWknmRsuD3qecf
         f/czNK4hZsGj+4NxsjtnwuuqWuT8tCKaSKA8BdRqGNfD6C98tzNVKSTacZiJThp8pdhR
         uLJcj2PMWtjaHczK6QswhXzX/tzws7UcwlA5toymcvDeuvYQcuah38xckAbLTcmX8GvP
         cyOIrTTbfdK7gKj2sIvjO1zWA3e5Vn6hvwe/ScC5wjPBrE46i8+e2qcpI+jIJsWRG+K3
         OOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCCqc2mN6PDwZNJTpNkZ/sMpb25Tt4lXb3t6nfn4XxQ=;
        b=39T0s2ts6LiO+uiHpgq7R7N6wL2Y2G6I+A0ZhBUJKhvKeRA7BKTRMm4Ric12AGPZdt
         EAEluQgaG/EvSYqEXP+f+vEv3zE1AJ08Nib00rd8DmR/dLNVgXELQL6GyLE3Qnbsn7IM
         P/BXNEBYGNay19jSRqFv+MN3GaW/tdI0Fo8QBcJk4zjZV626s61K3veaTgzUMJOOJBF5
         rzJYfb/ZSmvE3HEAc/zNyBdMqail9ryYD9rrDfXvOH4Al08q14xZ88MCtcRlqjPJjTAY
         u5laGolB5/Gejlid8X0zATRdUcpdjh79TTpUvkV7ThTSEzLowqy57jEWM25gGLUgaBTz
         q0Ug==
X-Gm-Message-State: ANoB5pmqZPEJRork/sHgoLW9uvzWeic970H+r7J9BtfDvnV5x0K/kEJ6
        ldtYO6jeh8sr208/KD5QjoQ=
X-Google-Smtp-Source: AA0mqf7BASkT3zRFIe3mAU1z1PKk/EXV/a6/KOIaOuG6/qrSBzOxvVqt2oeAW9hsMGeCmT0DefAy6Q==
X-Received: by 2002:a05:600c:4fd0:b0:3cf:d367:274d with SMTP id o16-20020a05600c4fd000b003cfd367274dmr5055660wmq.31.1670596678826;
        Fri, 09 Dec 2022 06:37:58 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id m31-20020a05600c3b1f00b003d1e3b1624dsm9645517wms.2.2022.12.09.06.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:37:58 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Lee Jackson <info@arducam.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] media: dt-bindings: ak7375: Convert to DT schema
Date:   Fri,  9 Dec 2022 17:37:39 +0300
Message-Id: <20221209143741.214242-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209143741.214242-1-y.oudjana@protonmail.com>
References: <20221209143741.214242-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Convert DT bindings document for AKM AK7375 VCM to DT schema
format and add an example.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../devicetree/bindings/media/i2c/ak7375.txt  |  8 ----
 .../media/i2c/asahi-kasei,ak7375.yaml         | 41 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 42 insertions(+), 9 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ak7375.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/ak7375.txt b/Documentation/devicetree/bindings/media/i2c/ak7375.txt
deleted file mode 100644
index aa3e24b41241..000000000000
--- a/Documentation/devicetree/bindings/media/i2c/ak7375.txt
+++ /dev/null
@@ -1,8 +0,0 @@
-Asahi Kasei Microdevices AK7375 voice coil lens driver
-
-AK7375 is a camera voice coil lens.
-
-Mandatory properties:
-
-- compatible: "asahi-kasei,ak7375"
-- reg: I2C slave address
diff --git a/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
new file mode 100644
index 000000000000..22b1251b16ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/asahi-kasei,ak7375.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Asahi Kasei Microdevices AK7375 voice coil lens actuator
+
+maintainers:
+  - Tianshu Qiu <tian.shu.qiu@intel.com>
+
+description:
+  AK7375 is a voice coil motor (VCM) camera lens actuator that
+  is controlled over I2C.
+
+properties:
+  compatible:
+    const: asahi-kasei,ak7375
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ak7375: camera-lens@c {
+            compatible = "asahi-kasei,ak7375";
+            reg = <0x0c>;
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 997e75dbca5c..08d93513e792 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3224,7 +3224,7 @@ M:	Tianshu Qiu <tian.shu.qiu@intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
-F:	Documentation/devicetree/bindings/media/i2c/ak7375.txt
+F:	Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
 F:	drivers/media/i2c/ak7375.c
 
 ASAHI KASEI AK8974 DRIVER
-- 
2.38.1

