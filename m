Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B45649E42
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiLLLz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiLLLzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:55:38 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496A7F59C;
        Mon, 12 Dec 2022 03:55:37 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n9-20020a05600c3b8900b003d0944dba41so4885803wms.4;
        Mon, 12 Dec 2022 03:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMnDqWizR4FpCmRwJEB60n4DmHPdDgLyTkUCJJGhsBc=;
        b=ekjhveVKUOXmrpDRVx1U++KV4+I6LVh+mv2oU0ILpEI/JUSBcR3FIjKmKCppU+5iBJ
         xK+LTMJG8C299lND/hwdbP495q1EqwLgR8UQT3l4S12e0rQxSJldDNigeyKOa2Bj45Kv
         wWK5g+ICrCw7Su/J0A+e6PWfAOHHjKrc22Sp7sMMn4Wszj7+wRGdEjm6iuaDWxsBalcG
         s4nrWlNaMLNB2QYkedZHuo8wawn0Hh0wuNa04sD9HekIn3PcMyvjtsWV37eepkLGkWl7
         G6thjZHV87Q0snUUxlYUlKeGN3Lbk9xgBbFmuU9BQ6HMzrK1KXTPpThmGGT56ZKGYk2V
         0Qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMnDqWizR4FpCmRwJEB60n4DmHPdDgLyTkUCJJGhsBc=;
        b=NbGGpJKKSkvCFw+5hzXWK9ZVUqaGs2Zpv42+8adlpOHn0BobRl0V1DU9XgwaKLWzxM
         ghrXDfEeZXeS+NEdk5bfkKnXAsvz9g87Y3+8nHh5Z/WtUXsMyguXKPsj3AM44vzkzZus
         Wwm1fLCno1L5BdkIxctYc8dQLq6XrXKZIZTmC6ctFh9XeZxMFNCgHEIqlaPE9aTS/tZl
         ZxROwqVW4jty11LMocBhFXJolrMgankVz/EHz13DymuyBLjwc3flsnF13Wkq1UCDsmMF
         XRrxi+FVL65nhYDD6Kit1zUw380/vzGdC/kE3pTiQ4aUAbEBDokstdGSyuGfFmQ9+9yz
         O6Ng==
X-Gm-Message-State: ANoB5plfyioE+FVM3Zc7+N55yQb5Vs9IlWdZNxLi89HQrtOsn8GBTye/
        XuoOzv9xQKVHRq7B+9bmLHo=
X-Google-Smtp-Source: AA0mqf7lwibhel2vWgKerQ1bnJf9NSlcLw/Qbxd9R83TYmyHVzVWOZKevuphmFrVubfBi/3+/ePz6A==
X-Received: by 2002:a1c:4c0f:0:b0:3d2:139e:f64f with SMTP id z15-20020a1c4c0f000000b003d2139ef64fmr8338067wmf.40.1670846135746;
        Mon, 12 Dec 2022 03:55:35 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1484:ef11:b25c:4612])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b003b4cba4ef71sm9793820wmq.41.2022.12.12.03.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 03:55:35 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 5/6] dt-bindings: cache: r9a07g043f-l2-cache: Add DT binding documentation for L2 cache controller
Date:   Mon, 12 Dec 2022 11:55:04 +0000
Message-Id: <20221212115505.36770-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add DT binding documentation for L2 cache controller found on RZ/Five SoC.

The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
Single) from Andes. The AX45MP core has an L2 cache controller, this patch
describes the L2 cache block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
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
index 000000000000..9f0be4835ad7
--- /dev/null
+++ b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022 Renesas Electronics Corp.
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

