Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9342B63F0B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiLAMkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiLAMkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:40:16 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917655E9E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:40:15 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 6so1560685pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 04:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r4i7sehCVhu19Bc2ExDkPBptLSYwHn3imI/AjglwqI=;
        b=OKQFS1fCAeQkV/0BNjOSr7tN8zS4n/0V4wWf0AdMi8e09DAYc5IWzQHuZFK+kY/X4q
         NfjDOkQniMQzz2gFQw6cvEbkDkeHBgfS+5X4pMOedV75WW287m71fxe9Qt5521/zXhOi
         Ax3g9QtPEZav+7oAtHeWY3wpXnYqbr5M+2fQcCP/WHIIBpzYpqbRFMvBxSGnR1rdmVvE
         EdbGLwmJDnxzDBFfD5xVNOYib/ISLYRbXp165p8ouwG+v5FMreh3lXCtix6bZYUWpYP8
         8meR84QiDKcmKcvGdsoM6/xFApw3pO+orToFQ0/yXCPLpnI7cYVN35aO5cnlZf57dTpL
         ZVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/r4i7sehCVhu19Bc2ExDkPBptLSYwHn3imI/AjglwqI=;
        b=v06QeqwG8VONdaf3EHtv4OaYlxWovojQMThWmhiN4yudwfZpz9Tw5PjNIQ5WG4z+cu
         +YzwyJ3xpfbgZmEuWRANrdCwknkRoQzJObEnAKS0vQ/afaZ4N0P3tTB3pFyRq6BfOxOY
         vnYTDgpfDNsVvGiX6CpNE/33dOGe+cgB2Fxfv7INVU/zDvx3R6wInQHB762Xj2P5A7ei
         0Uu4pHJ2+dAiKVTxVcOnLIBshHHvQSAhnhzcmdk/jGTmw15xE6cogKKeMGHKyZE/wQvY
         D47kqzkAQmcZZQkhkqjnNJ61VTD97D5DRiZaFv7fAFTyHCHIX8mFPENQA6w6mbSBbNbq
         ZewQ==
X-Gm-Message-State: ANoB5pk/Xqqt6a5yIGgiJa8jtFAYE0Nxa3neCqPp4JPbrBKmutfwj3CF
        CYSK1DFhJrM7+pjUWfzyqe0q7Q==
X-Google-Smtp-Source: AA0mqf4MumqWh9DWmlxp8wyZXkYw3o+T4+BNm+mqToROFXbEHsHF/JZa7gEnrjZmBT61BjEXq2BgwQ==
X-Received: by 2002:a63:f406:0:b0:477:cc1f:204 with SMTP id g6-20020a63f406000000b00477cc1f0204mr32700538pgi.592.1669898414932;
        Thu, 01 Dec 2022 04:40:14 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.81.69])
        by smtp.gmail.com with ESMTPSA id b65-20020a62cf44000000b0056f0753390csm3246981pfg.96.2022.12.01.04.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 04:40:14 -0800 (PST)
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
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v5 2/3] dt-bindings: timer: Add bindings for the RISC-V timer device
Date:   Thu,  1 Dec 2022 18:09:53 +0530
Message-Id: <20221201123954.1111603-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221201123954.1111603-1-apatel@ventanamicro.com>
References: <20221201123954.1111603-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
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
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 .../bindings/timer/riscv,timer.yaml           | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/riscv,timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/riscv,timer.yaml b/Documentation/devicetree/bindings/timer/riscv,timer.yaml
new file mode 100644
index 000000000000..38d67e1a5a79
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
+  riscv,timer-cannot-wake-cpu:
+    type: boolean
+    description:
+      If present, the timer interrupt cannot wake up the CPU from one or
+      more suspend/idle states.
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

