Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B56B63C1BE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbiK2ODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiK2ODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:03:35 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB4524956
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:03:33 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d18so2689710pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBnRn3HsiMQKAOivFFQlQImQ7gVQuSe6GDXaOHch/qk=;
        b=SdAecOq/4TzlwSvwgp6xy/aimh7kAafCkzi9TimrB1Iua0Ohq4cGKMbU1/v6U3X/v3
         gi1X+nkDc9XNapVheUoQ6MkkEu36/vjaGwpXr6EzpI3wg0R+v+5oDYK3OThVU1F+Gpmr
         7NqAPqXCOvkar4MHdHWh4t8+hDlZHpMnzK1PEuNxAUq1FBAu2zUd1n2v3b0G9SPuJg1i
         x69dq/FDbXbogJnGr6Y63W1nSc49YdnlJqx7DAfespl/CW2c+Uter4eWV4oe2SrJrojb
         l4vrDcOF7w5BvnAz1CWbybwr90Wp4YiX19WR0RVj5tefk+TyX+mq7If5mSnxzx3x0wuL
         jQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBnRn3HsiMQKAOivFFQlQImQ7gVQuSe6GDXaOHch/qk=;
        b=VmcWKY1MwkTprsJS89InkqAtoDETfxvWPe2IOuaJVFRhVZcGCoUa8FOG4WIfSrsO43
         fmpEw5vXgIV2i7ZmSb6SQxayFtTUF4HgUONCKeNGXRyBapbaMawiJDS7jSIfqg1ghXuu
         zdWuE4sVsklgkmxitfTUI+6iB0hwowW0Zpu6trbXoI4YX3xWNemEheH/CMgbIvbtxfhJ
         PiQtSxmeWFBrjR8EIZ62+IXX9vbMym+WZM8jkOgXUMbpisWsXKI0OlKTsvzeF83Qq8GN
         k95+DZU6K0o6jbvp78QCfUSpuZJozpYSD6foyOPbhw8agQ2K+T6hXX9GrJElDzobA9Lf
         290A==
X-Gm-Message-State: ANoB5pkaIyRTbSISMhmC/kQ+I+oU5D1p6zXBNvz/fYvF3FNTr9tg8t1O
        CeCgem560B+IrUgk++3fPLsGoA==
X-Google-Smtp-Source: AA0mqf7CQVolTDUJkjEMu07T8K35tmf5zeTTZTWgV8kSGmu71WQUDzrK2OaCLMTAid4dLV/7s2SwPA==
X-Received: by 2002:a17:90a:b703:b0:20d:7716:b05f with SMTP id l3-20020a17090ab70300b0020d7716b05fmr20514081pjr.104.1669730613158;
        Tue, 29 Nov 2022 06:03:33 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.98])
        by smtp.gmail.com with ESMTPSA id k30-20020aa79d1e000000b00574f83c5d51sm6013747pfp.198.2022.11.29.06.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:03:32 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v4 2/3] dt-bindings: timer: Add bindings for the RISC-V timer device
Date:   Tue, 29 Nov 2022 19:33:12 +0530
Message-Id: <20221129140313.886192-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221129140313.886192-1-apatel@ventanamicro.com>
References: <20221129140313.886192-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add DT bindings for a separate RISC-V timer DT node which can
be used to describe implementation specific behaviour (such as
timer interrupt not triggered during non-retentive suspend).

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/timer/riscv,timer.yaml           | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/riscv,timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/riscv,timer.yaml b/Documentation/devicetree/bindings/timer/riscv,timer.yaml
new file mode 100644
index 000000000000..cf53dfff90bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/riscv,timer.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/riscv,timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V timer
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |+
+  RISC-V platforms always have a RISC-V timer device for the supervisor-mode
+  based on the time CSR defined by the RISC-V privileged specification. The
+  timer interrupts of this device are configured using the RISC-V SBI Time
+  extension or the RISC-V Sstc extension.
+
+  The clock frequency of RISC-V timer device is specified via the
+  "timebase-frequency" DT property of "/cpus" DT node which is described
+  in Documentation/devicetree/bindings/riscv/cpus.yaml
+
+properties:
+  compatible:
+    enum:
+      - riscv,timer
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 4096   # Should be enough?
+
+  riscv,timer-cant-wake-cpu:
+    type: boolean
+    description:
+      If present, the timer interrupt can't wake up the CPU from
+      suspend/idle state.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - interrupts-extended
+
+examples:
+  - |
+    timer {
+      compatible = "riscv,timer";
+      interrupts-extended = <&cpu1intc 5>,
+                            <&cpu2intc 5>,
+                            <&cpu3intc 5>,
+                            <&cpu4intc 5>;
+    };
+...
-- 
2.34.1

