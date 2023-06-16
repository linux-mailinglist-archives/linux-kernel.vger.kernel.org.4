Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D872A7327AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbjFPGdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242794AbjFPGdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:33:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073DB2948
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:33:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b4f8523197so11640155ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1686897201; x=1689489201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+E9GNUVpev13YAg9DBkxIqHR4HyT2vWr1j4jNPBgL6s=;
        b=bZE3yEb4sbWGRu5PWYoEkhv0ZERLgUP1HmCsCGGPh270f/mYXpWtkHpOQtb5eHnQRf
         AfyibpT6bBu0TbdxD6Oy60lR0/Ccf/VOmVii6vt1dCBQT+zqn16499+oMEw75PNVuT6I
         o59WdRbKIO/KexXHUiWXdgmq1OG44e4RnZiU0EH8mKd9pCnqOC+fezodViMU2rEFQVYf
         bdG8TGqnpy4wHXYMPttBzJw8LQE3unM3f9ORI4DL1HfxnWut+AfKirXU1HFOoXCB6j91
         R19uQzzAkEuF1YbyIwkyYv8sy2xOOMyLtdRb3ROivlfTluJYUfdyb9cfrIeUuVnpIzL3
         4nJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686897201; x=1689489201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+E9GNUVpev13YAg9DBkxIqHR4HyT2vWr1j4jNPBgL6s=;
        b=cq4hWJuRtrkm5I0Gfe6kYFFEmVcbD1FA6tmkf7f9HjbY28Nzr6N8QyYc9HDwWz0CpW
         yaGTuffMqGqQIcJZ+6HxywfF3kw4XMKCSQXwyCSApZCaW5BiEu/Hl94uWKn7ULsx/W/O
         +mYhbDjJBYmf7T2Vva/7Nw+I0L8MwYRX+kxDadQ2KSTlGc+bKl1N2s5sA+wQ8qRqb8Vv
         SvbiHNhTCF5bnEtdod4aaJ+wqaGCxvvOxQvJN1mAit/tENLyrxNCrmFkzOtVo2y+OXXj
         KBxGcsP/+VgBFqfQ8mOLl24xt/fS6kDApMr1pEjSccqoYnhQPkgRtuzgg90TTadjcETk
         6Q4g==
X-Gm-Message-State: AC+VfDzb7JvCi4Y8jWyc2pCAsDLHnoQ3zjtilh4YxMF167noK7rqlp1Q
        r0CXnIqWnSl+PP6WZDGrtTb2Dg==
X-Google-Smtp-Source: ACHHUZ5XeuETTVg3HS7ANsWZZaudTqsBAvzVANoKKQGWACp3oqIesLrX/wtyl3tWrLQLkk82CTT+AA==
X-Received: by 2002:a17:90a:ad89:b0:25e:a9d1:8ad4 with SMTP id s9-20020a17090aad8900b0025ea9d18ad4mr1319918pjq.17.1686897201373;
        Thu, 15 Jun 2023 23:33:21 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090a410b00b0025023726fc4sm617596pjf.26.2023.06.15.23.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 23:33:20 -0700 (PDT)
From:   Eric Lin <eric.lin@sifive.com>
To:     conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu, maz@kernel.org,
        chenhuacai@kernel.org, baolu.lu@linux.intel.com, will@kernel.org,
        kan.liang@linux.intel.com, nnac123@linux.ibm.com,
        pierre.gondois@arm.com, huangguangbin2@huawei.com, jgross@suse.com,
        chao.gao@intel.com, maobibo@loongson.cn,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dslin1010@gmail.com
Cc:     Eric Lin <eric.lin@sifive.com>, Zong Li <zong.li@sifive.com>,
        Nick Hu <nick.hu@sifive.com>
Subject: [PATCH 3/3] dt-bindings: riscv: sifive: Add SiFive Private L2 cache controller
Date:   Fri, 16 Jun 2023 14:32:10 +0800
Message-Id: <20230616063210.19063-4-eric.lin@sifive.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616063210.19063-1-eric.lin@sifive.com>
References: <20230616063210.19063-1-eric.lin@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add YAML DT binding documentation for SiFive Private L2
cache controller

Signed-off-by: Eric Lin <eric.lin@sifive.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Nick Hu <nick.hu@sifive.com>
---
 .../bindings/riscv/sifive,pL2Cache0.yaml      | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml

diff --git a/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml b/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
new file mode 100644
index 000000000000..b5d8d4a39dde
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2023 SiFive, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/sifive,pL2Cache0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive Private L2 Cache Controller
+
+maintainers:
+  - Greentime Hu  <greentime.hu@sifive.com>
+  - Eric Lin      <eric.lin@sifive.com>
+
+description:
+  The SiFive Private L2 Cache Controller is per hart and communicates with both the upstream
+  L1 caches and downstream L3 cache or memory, enabling a high-performance cache subsystem.
+  All the properties in ePAPR/DeviceTree specification applies for this platform.
+
+allOf:
+  - $ref: /schemas/cache-controller.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - sifive,pL2Cache0
+          - sifive,pL2Cache1
+
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - sifive,pL2Cache0
+          - sifive,pL2Cache1
+
+  cache-block-size:
+    const: 64
+
+  cache-level:
+    const: 2
+
+  cache-sets:
+    const: 512
+
+  cache-size:
+    const: 262144
+
+  cache-unified: true
+
+  reg:
+    maxItems: 1
+
+  next-level-cache: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - cache-block-size
+  - cache-level
+  - cache-sets
+  - cache-size
+  - cache-unified
+  - reg
+
+examples:
+  - |
+    pl2@10104000 {
+        compatible = "sifive,pL2Cache0";
+        cache-block-size = <64>;
+        cache-level = <2>;
+        cache-sets = <512>;
+        cache-size = <262144>;
+        cache-unified;
+        reg = <0x10104000 0x4000>;
+        next-level-cache = <&L4>;
+    };
-- 
2.40.1

