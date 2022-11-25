Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F2A63889F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiKYLWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiKYLVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:21:40 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60DE27918
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:21:39 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b21so3723186plc.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0TnuhgNTurF6Ds7AQpDNaCEPKEhITVFc7KbMlz7Wws=;
        b=IUt6mjNqfvLPBWph0ZsbRARzlsokmk2fZM/PK9Ux17pbEufTSB0fdGB4L/1rUvGDyu
         8K+kp7ETHm0Czj0vmb/F47Q5JQupZzVyC1v22fnJNdFmiT5DBelkCQJM+jFPjGg+sRUt
         ghfUI1bWGsd5fmTblOzCs4hiquuXSB8hz8lrnQoKjYLyMowOrPvtDk23OL+4HVQsgwdf
         FUEQIaPeOPhoh1vMgMyNnhvgOcrjWBGwty/eeAYbcZjflbKDXoz9XEjF9ygyA933dGHn
         fvbRr9N3WRX7U6wCSaau9lmQDrDBzmUzo+qHJfEzdXXvwOZEHJLWLsySWnKIFS8y0ZdV
         N6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0TnuhgNTurF6Ds7AQpDNaCEPKEhITVFc7KbMlz7Wws=;
        b=Lz/iKyX0kqw3BCTErxsNIcFE4WfnuglQyOPVWHo+sgKoL6P5xpZBgd1aC8qej7uMYm
         dDbcQZVgGiL+1PUHIn00X53eXVubAi5/G8dREu3YBzYSFVhhy8T2b6MiYTbKin1NtXC0
         awSyc152EvOHLL6E3rDUNrn0EjdZyJLErjnwKZ4ru6W/2lRKhe0wWtaInzKxI0De8SJl
         RC6KeD9dtooCBiIIn/2Ow5L24M2/JBIsbtDEdU9IX+rfQua452NzypgkDN9xnoRy7a+l
         WYJuJHOUQYGYLCOn3Mh62L3ROwA4/YqzBzBCQ9Vpgn+f5bIacMiGBxHuX4azS8kvMEuu
         Zzlg==
X-Gm-Message-State: ANoB5pkeyp2v9OZZiWAWJxdIBvL1vvtdKvG70tO3Wnh2Puv+AmY0ZFoT
        /sqrbOFMb9QrgBwmFFVAw8X78A==
X-Google-Smtp-Source: AA0mqf7p52syBNqlzAm7wndp9UugUcKufqi2DHynSY+p5jdvVgwvhqBcU1Sy5MGjIClDucx7bDROZg==
X-Received: by 2002:a17:90a:5d15:b0:213:e74b:b691 with SMTP id s21-20020a17090a5d1500b00213e74bb691mr46264890pji.81.1669375299079;
        Fri, 25 Nov 2022 03:21:39 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id e66-20020a621e45000000b0057488230704sm2834335pfe.219.2022.11.25.03.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:21:38 -0800 (PST)
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
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 2/3] dt-bindings: timer: Add bindings for the RISC-V timer device
Date:   Fri, 25 Nov 2022 16:51:04 +0530
Message-Id: <20221125112105.427045-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125112105.427045-1-apatel@ventanamicro.com>
References: <20221125112105.427045-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add DT bindings for a separate RISC-V timer DT node which can
be used to describe implementation specific behaviour (such as
timer interrupt not triggered during non-retentive suspend).

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
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

