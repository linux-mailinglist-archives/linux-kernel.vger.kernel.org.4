Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976E86DCEDD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjDKBMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjDKBMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:12:51 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E542708
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 18:12:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id c3so7318622pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 18:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1681175569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNC5uGjq/EaYoUGQk88WQh4h6t1BrXL9q1iir73+hnk=;
        b=fQqJmdEo8nL/zUZmMzhCM6OoiK12R+OL9JOXOJovOiHknXYqYr/k0dlcPheUNu6FjE
         REj/4ukYXK36Y7YkgtK3jNs4ts2+GB2kB93AOxHPcWs9NGcOS1MuxNcuhTNZr9ljS0Dx
         HAvq87p8NdDHdifvGLw+O8Hhp/lUFKw/G03PB9CRvbqvb6hvkTxViPYknBHVkEHAfgL1
         dSRJ4HYzS1U81VXZXZeBUC/9i9ZzLfbHUxDpJaFQJIMIpHMia7vpNfND67XOhQ3AWx8/
         2gsBRaJZi0KsTT7xcmKtkJCTkM4FMHJNxTRU7zbK9iU5Wub8E0mhyL28TbIupirpKvUh
         JRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681175569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNC5uGjq/EaYoUGQk88WQh4h6t1BrXL9q1iir73+hnk=;
        b=k1Gh/K726De2j1kfv163ersZX7GoZwAAqlUtbGZVBd52OYZZQrHbNAN2FyL014dtLB
         QJjNkh2Up6iVMX2rM4s0ALDrfKG/W4fLtJLer5TVeXhDl/HDOwNZWfmBgkU3ksL+QBJd
         IjD67Kxlzeli4sn89WIdTidtkUzVG7DQWN3S85ZNQY7SLXKytyTsywqPGpGPyCBs6Oof
         Lj+W6qnO8f9MMExRlLYHplePVPIutAeTcdfzx90Fsth4NhR6Emk3tnIqpiOIUyZJJYpQ
         rMC4rBRSoXrjVqcR8VE3lcMf4VEXYbxr2tNPMptGcDVOGjLW4/z18EfKYL/09vy0b6AC
         3DYQ==
X-Gm-Message-State: AAQBX9cB5jTujYvjhHI5hCF7UPjwFSQTma8u5vfW0YUwfZ4CNthYh9r1
        eUt8i+mSgQld9xqTyhwBAbYyMg==
X-Google-Smtp-Source: AKy350Z0zuYwNHTBzttsPE3n4jOJlS9+Ira6u2N8iikZC9aziKNHlrrd66lN8s1TWUsceKMZmPEL1A==
X-Received: by 2002:a17:90b:3b8d:b0:237:29b1:1893 with SMTP id pc13-20020a17090b3b8d00b0023729b11893mr15872813pjb.46.1681175569098;
        Mon, 10 Apr 2023 18:12:49 -0700 (PDT)
Received: from subhajit-ThinkPad-Yoga-370.. ([124.148.71.115])
        by smtp.gmail.com with ESMTPSA id k91-20020a17090a4ce400b00246b1b4a3ffsm2220957pjh.0.2023.04.10.18.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 18:12:48 -0700 (PDT)
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] dt-bindings: Document APDS9306 Light Sensor bindings
Date:   Tue, 11 Apr 2023 09:12:02 +0800
Message-Id: <20230411011203.5013-2-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for Avago APDS9306 Ambient Light Sensor.

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
 .../bindings/iio/light/avago,apds9306.yaml    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
new file mode 100644
index 000000000000..f0547771bb1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/avago,apds9306.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Avago APDS9306 Ambient Light Sensor
+
+maintainers:
+  - Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
+
+description: |
+  Datasheet at https://docs.broadcom.com/doc/AV02-4755EN
+
+properties:
+  compatible:
+    const: avago,apds9306
+
+  reg:
+    maxItems: 1
+
+  vin-supply:
+    description: Regulator supply to the sensor
+
+  interrupts:
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
+        light-sensor@52 {
+            compatible = "avago,apds9306";
+            reg = <0x52>;
+            interrupt-parent = <&gpiof>;
+            interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+...
-- 
2.34.1

