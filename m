Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE966E7846
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjDSLL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjDSLLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:11:20 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6193B13F9F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:38 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b73203e0aso15253989b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902630; x=1684494630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6zQom7c9ZPxaL0AlvEMhKoZ47HVwA0KXR3RYZHyFgk=;
        b=way4ScdIS96YRKdHcgBpyse+tOSSXOie7JmzQ3ruykWd+bvImdobFO37hhT77+L3/U
         kaqojTkCN3wGLtbhwA90MgVOAgFVGf4Dedela1TNzHBvJRZjXQSXWFwPwduhVj6TPdzX
         GIc+Nuk7F+h6MKBmdyl2qvDlk02/j2I47Ppo5mo1ZpuQIvpD572EFN7U+sOSUY8XSxOw
         WOi4FCrreEQEdHwpWijIg+JK2+Lnl3ALjpm7l3mTxtaHBsOCVR7Bn5fo01aFxF/GJUow
         MnGtG2IiDAagEyhqLKjTxyj+uGdYLVG4BA2My74jN6jA7ZYKA/Gg5Wy1kJphb7t+NVe8
         GiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902630; x=1684494630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6zQom7c9ZPxaL0AlvEMhKoZ47HVwA0KXR3RYZHyFgk=;
        b=Fw6yQt10IeI7NtFy+ZHFZSQ3V6hWjQpRbrL/3ftJRYBKF0BGxeZzGpbx9L3l1zKc5a
         r79WBkjbVPppV0tCtcRQm/qGiPS35/8TmPqlPT8efRJMYGvtL+6NZM2pNh1IaY1EEQSP
         a1UrNUD52AnH/gw7m6s107Tl+WBRc+sz8sXS6/b6iwmgR2EEBXRTMaJINUCp0cgSiv9U
         7N638RPC/l+kbgQRHi97hCuLfP9AcLR+FAZR7UeEW1b8hHGwDuMh2+a/0cHMaiJ6Epd4
         EnsGm+rGLle0UrcRlDSK6VjUnXCVvHz1RwtW0KlLNwn+MpfpIHVcZlr8E0Qv//4vLuX3
         hcSQ==
X-Gm-Message-State: AAQBX9frQqR6Y8662fCT5ZaCPk1aXUm7yW3pet4rBFhn8GAeU8dwGKYF
        j2qtgUERXCGaipORU5yy9IGmlQ==
X-Google-Smtp-Source: AKy350ZMyASO/6WHrB2YnJ1c5qAAic0H4uqyutx85aVkcy8OYWscNutmT//7hNt7yI5Yb0peas0zAA==
X-Received: by 2002:a17:902:dad0:b0:1a2:a904:c42e with SMTP id q16-20020a170902dad000b001a2a904c42emr1574829plx.24.1681902630432;
        Wed, 19 Apr 2023 04:10:30 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:29 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ved Shanbhogue <ved@rivosinc.com>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Peter Newman <peternewman@google.com>, x86@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [RFC PATCH 14/21] DO_NOT_MERGE dt-bindings: soc: add Foobar SoC cache controller
Date:   Wed, 19 Apr 2023 04:11:04 -0700
Message-Id: <20230419111111.477118-15-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419111111.477118-1-dfustini@baylibre.com>
References: <20230419111111.477118-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for an example SoC cache controller that implements CBQRI.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 .../soc/foobar/foobar,cache-controller.yaml   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/foobar/foobar,cache-controller.yaml

diff --git a/Documentation/devicetree/bindings/soc/foobar/foobar,cache-controller.yaml b/Documentation/devicetree/bindings/soc/foobar/foobar,cache-controller.yaml
new file mode 100644
index 000000000000..6348483bbe09
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/foobar/foobar,cache-controller.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/foobar/foobar,cache-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Foobar SoC Cache Controller
+
+maintainers:
+  - Drew Fustini <dfustini@baylibre.com>
+
+description:
+  Foobar SoC cache controller implements the RISC-V CBQRI interface for
+  capacity allocaiton and usage monitoring.
+
+allOf:
+  - $ref: /schemas/cache-controller.yaml#
+  - $ref: /schemas/riscv/riscv,cbqri.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: foobar,cache-controller
+  reg:
+    maxItems: 1
+    description: A memory region containing registers as defined in CBQRI spec
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+
+    cache-controller@fff12000 {
+        compatible = "foobar,cache-controller";
+        reg = <0xfff12000 0x2000>;
+        cache-level = <2>;
+        riscv,cbqri-rcid = <64>;
+        riscv,cbqri-mcid = <256>;
+    };
+
+...
-- 
2.34.1

