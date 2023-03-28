Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5332B6CBE8D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjC1MF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjC1MFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:05:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B9693C8;
        Tue, 28 Mar 2023 05:05:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w4so11389716plg.9;
        Tue, 28 Mar 2023 05:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680005126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InVcb9dEGuOqkJ5tQQiGYBoCBqQROtEgUWP5Mr1cBac=;
        b=ijDg7+6b3/4eD/hrDqw/dshDiZdKfi/l9LVbQa/VgmDkor0MZIR6CMxyufZ4dSlrKz
         MLqFIIuDE41e/wIv2/lL/IvuXqC8Yh4SN0idxNKRi0Mbbpq8NEEIXLfuLrLwMTJAG3Gp
         +Nnb7M4fly0m+xxTOE0mAuFGPLLVK8rYAvZOFfm4lAuMNs0FnX28UD70XxgkcuGZJYYQ
         IoPzuMigfSh2v+5mTUZumXPlIpnmj+zAHTgiHYORBvbcPA/jYfRv/0RmvtLmBZswLYPe
         kpzFlQ1/MAFeRvvlTHxutb7N8SsLV2o6cReMXNSL6pkr/9LAqf9ZCwn2tfsNZmQDQ/iR
         2H5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680005126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InVcb9dEGuOqkJ5tQQiGYBoCBqQROtEgUWP5Mr1cBac=;
        b=q2Htea2TrE0/KhLMSz2EkSRMBHbIxIl0i7CzenLnxW69VNGlpaYARjZiV+40NvFuEe
         6jXg80MFQqPqlHTvKeBknGCnMljAfXfTf9OAFySg77Y6yakdjrhmHTKv0nU8kxIa7TvG
         CeegvGR7qoH1L2JOz4MM0836bbND0v9XBEFUeH6OveWTYgeSv1fdffhHtzSMX0Vp4K3c
         SYvQwGOFSTB5JFooLMdhBGluIYpHTei2h9aRulYR9yOdjaWhidK/O5Ak1Q99ov8SpWvu
         DldCUDK835TGURx7oA978MQHcNGrhy8LH+mwqktUuqn4XIMeef4Jc3aT+zT0YNftlCle
         hKrg==
X-Gm-Message-State: AAQBX9feApyu8OgRhDeTUR9S418FN3xExoHjbVNipxrn13Agou0yuJ2F
        LnJ5zMn4o08qNhU+Mutu2jkFV02T5jlITQ==
X-Google-Smtp-Source: AKy350atFytskDWjRzoiPrurLXOuGMqctYkYrfjQAp4QSh8NYsw9JADGValSwDko5qcJblVEh7ph9A==
X-Received: by 2002:a17:902:e851:b0:1a0:549d:399e with SMTP id t17-20020a170902e85100b001a0549d399emr16605781plg.21.1680005126587;
        Tue, 28 Mar 2023 05:05:26 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id ju10-20020a170903428a00b0019a83f2c99bsm21013956plb.28.2023.03.28.05.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 05:05:26 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 2/3] dt-bindings: timer: Add Loongson-1 clocksource
Date:   Tue, 28 Mar 2023 20:05:05 +0800
Message-Id: <20230328120506.375864-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328120506.375864-1-keguang.zhang@gmail.com>
References: <20230328120506.375864-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding document for Loongson-1 clocksource.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 .../timer/loongson,ls1x-pwmtimer.yaml         | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml

diff --git a/Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml b/Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml
new file mode 100644
index 000000000000..c4771aab8d75
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/loongson,ls1x-pwmtimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1 PWM timer
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+description:
+  Loongson-1 PWM timer can be used for system clock source
+  and clock event timers.
+
+properties:
+  compatible:
+    const: loongson,ls1x-pwmtimer
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/loongson,ls1x-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    clocksource: timer@1fe5c030 {
+        compatible = "loongson,ls1x-pwmtimer";
+        reg = <0x1fe5c030 0x10>;
+
+        clocks = <&clkc LS1X_CLKID_APB>;
+        interrupt-parent = <&intc0>;
+        interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.34.1

