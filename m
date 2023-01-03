Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F02365C19E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbjACOL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbjACOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:11:26 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFC511175
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:11:24 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p24so10193024plw.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R0kNYBBZe/vkuDeDkbiPp383r6amrw7KjZXH0xUkvc=;
        b=OFhaOPlfE7DOJpUuddUEZC3/8ATvvDpqLP84UGR/FTGAIOOXbQdC2OtwkjIJ/FfzSP
         L0O8+nbI4eQ0g5Rc3poeNfJzz7DefgAhnx0G7wZJoV2ZBgCVUCB5qfRKYAryEY5KpFX1
         8yWqid0CfGvwGzwKEddUl9sDrCVYB1Dk6/r67aU6fHGsRgsz/aUGXjh/Tkx7CO51T2xt
         GCoOf0kwgICFFwFoa4oPHJRGoI94dh1cpJXEGBt7uXgzqDpv3UWene5Gp7PlAItH+BE2
         ZWTIuE3Io70yJdYGQdNtxqWSOmJvwE0kWnZIhii8kQudwhwO+y3owx9FWgKDUaN8wwPU
         KEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6R0kNYBBZe/vkuDeDkbiPp383r6amrw7KjZXH0xUkvc=;
        b=Bskg/h4V2Zip41N8YyG3n61zmI23wDeQ82vDLpaolusjzxqkwEirYgtuHSh8WuHkGJ
         2ZB3uC8o+v3lvgjwX61/GVW8TVTLW4rN7Nf0ElNHbo3bjZobwh95Op+zUceswpdGminq
         QA/kh2L6Jz+6H1q34fE0UULYtMhYxD9Ir/GO13osfn6AV1eG1VDlMdxpq3SAEvCNuHqa
         8is10SHYr8hhdui3WfiIMqDWfq4gMbhtWNnpbCYMx+Rj4U1azfZiYRe6bkKy6QZRNHDQ
         yISfLEMHQUZRY2rIuq9OCBVhs3mcfHje78BLI0wBQLTiNfN+7RznK+YsgVlJb0hhc7Ah
         ZgJg==
X-Gm-Message-State: AFqh2kpm2fwZTFQ4JzPCKCzgcu+77WgN2rEKQdX5Ezz6QCm4aZrQN569
        XlxtizeDNxbOHcxC/YhKwirwjA==
X-Google-Smtp-Source: AMrXdXuRV8ZcjNhMqkH8Au42kuXt+5729hTGbGDYIadFDLBDrkWpQPK41bKXJpCfDqHUhfEzP5P4VQ==
X-Received: by 2002:a17:902:b68c:b0:192:4ed3:e919 with SMTP id c12-20020a170902b68c00b001924ed3e919mr44783370pls.34.1672755083615;
        Tue, 03 Jan 2023 06:11:23 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.241])
        by smtp.gmail.com with ESMTPSA id l3-20020a170902e2c300b00192bf7eaf28sm6146117plc.286.2023.01.03.06.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:11:23 -0800 (PST)
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
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v6 2/3] dt-bindings: timer: Add bindings for the RISC-V timer device
Date:   Tue,  3 Jan 2023 19:41:01 +0530
Message-Id: <20230103141102.772228-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103141102.772228-1-apatel@ventanamicro.com>
References: <20230103141102.772228-1-apatel@ventanamicro.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

