Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285256D1030
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjC3UnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjC3Ums (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:42:48 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D7710ABB;
        Thu, 30 Mar 2023 13:42:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so8811465wmq.3;
        Thu, 30 Mar 2023 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680208964; x=1682800964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7uCU6lf+09VHIoD9fbjjKmUZ8AO643QGh96ltPUUVM=;
        b=KgLs/AOcHwBkcb0V70o429wtpPZUloH+TajIJZog5aPGkpoyHiN4OWNfG8zhF+Oibq
         a98dntpog8JaKywIbdjH2YyAweAOBKoctExgtIMJhlG2WA9nZTRX3CNYAKOe2qTrMqbI
         fdm+G95JNyiwFUNKWQl5xl0om9quujFzvoQNRascn9OgAangMwAW4oiA2vgw7Zg8pb9j
         QYzE3xJNXLD4Zi1GfvkqOzyg2/iRoB5rnC+h53QIpKSHH7EyZScucct4UYWcadAVI3Wo
         IcOZi6/UMx7Eb5lC8hy0+pWU0wOPXixAJmjsnTpp9i8reApBHES9PX31QTHvj9u1fxAC
         xSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680208964; x=1682800964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7uCU6lf+09VHIoD9fbjjKmUZ8AO643QGh96ltPUUVM=;
        b=nTuPUwl+lwS+86phyHhUmUBKdY7rg2NUEcJ+Uw87TAVEUgqF9n2ZNbuVQDHc5fLOaW
         rUC9UmDdcO1m+EXrjbk/O7zwjXexoeYJOC71QSAS/YKwRK3g0aMNIfeV5g80DqGAnMWr
         TpxJN4YWbtAAw1Vli6j2Wf5arcpszzM+Nys8xOMjG/Z5SCbl5fr23SGsa5hWhV32B/o4
         2zecKyC1+AmbEwPyBzf1Z0duEjwfDwZ7qgKq2K0QDAM++QFswoYVLIbJtsuKyABPlRhy
         tNBx86fo+uGWOuSkaJvVIy/2yHS6VLl68XgMKZ/BOQh9SN+1jHd9T8PpTzn1QFt+nTAT
         GrTQ==
X-Gm-Message-State: AAQBX9cFftSVGYm+fbZ2Rq4ejRVFZrtmzQJb6/xpHCetx6EZSqr1F1td
        cnQ0qEi7LxeGn17M4JyhvPk=
X-Google-Smtp-Source: AKy350apQoJSwiW6jYJkrYX2B56tV0H5KyGXJmDXjEu+DANAbRr1LRfENpUrde5LByVQ3CMkV8kejw==
X-Received: by 2002:a05:600c:cc:b0:3f0:3049:b216 with SMTP id u12-20020a05600c00cc00b003f03049b216mr5108217wmm.28.1680208964373;
        Thu, 30 Mar 2023 13:42:44 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:30f2:5b7:ab32:c3f])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d4b0c000000b002cfed482e9asm297981wrq.61.2023.03.30.13.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:42:43 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 4/6] dt-bindings: cache: r9a07g043f-l2-cache: Add DT binding documentation for L2 cache controller
Date:   Thu, 30 Mar 2023 21:42:15 +0100
Message-Id: <20230330204217.47666-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add DT binding documentation for L2 cache controller found on RZ/Five SoC.

The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
Single) from Andes. The AX45MP core has an L2 cache controller, this patch
describes the L2 cache block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v6 -> v7
* No Change

v5 -> v6
* Included RB tag from Rob

v4 -> v5
* Dropped L2 cache configuration properties
* Dropped PMA configuration properties
* Ordered the required list to match the properties list

RFC v3 -> v4
* Dropped l2 cache configuration parameters
* s/larger/large
* Added minItems/maxItems for andestech,pma-regions
---
 .../cache/andestech,ax45mp-cache.yaml         | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml

diff --git a/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
new file mode 100644
index 000000000000..9ab5f0c435d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2023 Renesas Electronics Corp.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cache/andestech,ax45mp-cache.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andestech AX45MP L2 Cache Controller
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description:
+  A level-2 cache (L2C) is used to improve the system performance by providing
+  a large amount of cache line entries and reasonable access delays. The L2C
+  is shared between cores, and a non-inclusive non-exclusive policy is used.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - andestech,ax45mp-cache
+
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: andestech,ax45mp-cache
+      - const: cache
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  cache-line-size:
+    const: 64
+
+  cache-level:
+    const: 2
+
+  cache-sets:
+    const: 1024
+
+  cache-size:
+    enum: [131072, 262144, 524288, 1048576, 2097152]
+
+  cache-unified: true
+
+  next-level-cache: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - cache-line-size
+  - cache-level
+  - cache-sets
+  - cache-size
+  - cache-unified
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    cache-controller@2010000 {
+        compatible = "andestech,ax45mp-cache", "cache";
+        reg = <0x13400000 0x100000>;
+        interrupts = <508 IRQ_TYPE_LEVEL_HIGH>;
+        cache-line-size = <64>;
+        cache-level = <2>;
+        cache-sets = <1024>;
+        cache-size = <262144>;
+        cache-unified;
+    };
-- 
2.25.1

