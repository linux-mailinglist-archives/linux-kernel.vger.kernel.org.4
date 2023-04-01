Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311B26D2E04
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 05:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjDAD67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 23:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjDAD6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 23:58:53 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871B5FF0D;
        Fri, 31 Mar 2023 20:58:52 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-17aceccdcf6so25211929fac.9;
        Fri, 31 Mar 2023 20:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680321532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2U2XsDHoLzpn+9gItu80aF7GJfiGDWT6BnwKoZhBKk=;
        b=P17LuxdfVhQ828hU9BHWbH9FWZHsiFYo/ELy7uKQQC40YXCaOVwca1RwfDs/BlQTJs
         Eg9LzC0pNJCFdOxuaS2VJGj35NpWIRjlL/RcM3Yy1gPN+cdEN0zM3ajbxyAOBavK0byu
         c7NBAGqO6LxR0ba5DRdQI7ASh2kcyc+WeVpDj+utfio8F1k7ldyQnp5hUkmmJm9BlWKa
         iuauG7pQ4ERMd11czXkXk5UhxE3qZeZ7tPP0af9hK0WdDIC5RyO619B+PPWImL6eW/bu
         lRs2i5jM9S/y6m+yrfOAh+9EZWPUIGtmDiSfPf9jhxi5DaEdKivJvBdLNV4U9JFqBmOQ
         /Cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680321532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2U2XsDHoLzpn+9gItu80aF7GJfiGDWT6BnwKoZhBKk=;
        b=BEi2nMfR0MViN03clfXqUu/SzD1n6OdXuIXKqrh32r+71n0+tU0q/knDWZO6B/VYpD
         xmZWdOIPSGrhbmoedIATv/BafJLJCUiC06yPqCCh3KKhELh/z8LgJFl45YYbex5Ia9tO
         P8/Ep78A4UVj6o2yX0tL1YNmRktsrI3DRIABt+vySIbIoEHS57oUeJ2XAjKYLOK+dNLu
         +iOEShqhI1/o2KoLThU9Lla72exxZNgNLZGgOO3lrhajYnkLxlU7pOKNke6RXbMwPkJV
         vaiiZzdK7U41TLLh6v5OLOJQKJDZAd4TCguXOD5lBw4Z1qNB/WfnARBfxbSM9O2GSEwp
         vdvQ==
X-Gm-Message-State: AAQBX9cuoKwC2Bx874afQvtQhAVFF5jjJzzjA/N2QSaHoXFaN7/GlPSs
        bIuEk3UAsjCYpcF0/DUtTag=
X-Google-Smtp-Source: AKy350YkXdYUmmYhpswBXz+/2z7ssiOIinB0jx2wQCZKq5zKmY7eC7HkeqBQ+BIXkp8JA6MXqUPuYQ==
X-Received: by 2002:a05:6870:560c:b0:17a:d2ab:aeb8 with SMTP id m12-20020a056870560c00b0017ad2abaeb8mr17985248oao.33.1680321531834;
        Fri, 31 Mar 2023 20:58:51 -0700 (PDT)
Received: from heimdal.localdomain ([2804:431:cfec:79f0:85a3:2af2:a6f4:1842])
        by smtp.gmail.com with ESMTPSA id ug13-20020a0568714d0d00b001727c3bf124sm1593845oab.31.2023.03.31.20.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 20:58:51 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Morishita?= <andremorishita@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        anish kumar <yesanishhere@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mairacanal@riseup.net, dri-devel@lists.freedesktop.org,
        daniel.baluta@nxp.com,
        =?UTF-8?q?Andr=C3=A9=20Morishita?= <andremorishita@gmail.com>
Subject: [PATCH v2] ASoC: dt-bindings: maxim,max98371: DT schema improvement
Date:   Sat,  1 Apr 2023 00:57:54 -0300
Message-Id: <20230401035756.856752-1-andremorishita@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331020527.482991-1-andremorishita@gmail.com>
References: <20230331020527.482991-1-andremorishita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve Maxim Integrated MAX98371 audio codec bindings DT schema conversion

Signed-off-by: André Morishita <andremorishita@gmail.com>
---
Changes in v2
- Generic node names - codec (Krzysztof)
- Drop label max98371 (Krzysztof)
- Add sound-dai-cells in example (Krzysztof)

 .../devicetree/bindings/sound/max98371.txt    | 17 --------
 .../bindings/sound/maxim,max98371.yaml        | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/max98371.txt
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98371.yaml

diff --git a/Documentation/devicetree/bindings/sound/max98371.txt b/Documentation/devicetree/bindings/sound/max98371.txt
deleted file mode 100644
index 8b2b2704b574..000000000000
--- a/Documentation/devicetree/bindings/sound/max98371.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-max98371 codec
-
-This device supports I2C mode only.
-
-Required properties:
-
-- compatible : "maxim,max98371"
-- reg : The chip select number on the I2C bus
-
-Example:
-
-&i2c {
-	max98371: max98371@31 {
-		compatible = "maxim,max98371";
-		reg = <0x31>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/maxim,max98371.yaml b/Documentation/devicetree/bindings/sound/maxim,max98371.yaml
new file mode 100644
index 000000000000..14fba34ef81a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max98371.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/maxim,max98371.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX98371 audio codec
+
+maintainers:
+  - anish kumar <yesanishhere@gmail.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: maxim,max98371
+
+  '#sound-dai-cells':
+    const: 0
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@31 {
+            compatible = "maxim,max98371";
+            reg = <0x31>;
+            #sound-dai-cells = <0>;
+        };
+    };
-- 
2.40.0

