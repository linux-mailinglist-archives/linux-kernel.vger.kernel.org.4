Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934FC6D00E6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjC3KPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjC3KPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:15:33 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5205026B8;
        Thu, 30 Mar 2023 03:15:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id fb38so12144725pfb.7;
        Thu, 30 Mar 2023 03:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680171331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y17RGlk6CYDHs44iRTMNSfdd0bchfPR1Du5wOHebTrU=;
        b=AmUA7IYtNf8BkpZb8fQAEWNpmGN/mJFNDlx9Vb4QLi3snz1wWCqPvD8AkMaZckXKeB
         5iN0RFFmR3QoZ/90R90b8zrRqQsTN3dPVRh++Sd/RhgkNeMNR1GOB1xDD32K+34N35Qd
         8jj1I4jn/kDXMJ3u+o1vjf4QGefizlaBN7btzbcd2bjLgejFKdvsBzCtD/YggzvfuQY4
         RAZbxkeEEuQvadTVFUHGIsLx6zwfD9PRhOYO8VpXrrRYgtvCzv26GG3lgKWDf6c7VWLN
         CAakHULCq3/0i8hvypQiscPVm8ANSdx2vFbcZLB04tsV8McG8UGi9b9uhq2h2xh+LffG
         nOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680171331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y17RGlk6CYDHs44iRTMNSfdd0bchfPR1Du5wOHebTrU=;
        b=dVxHb/YWmWkldxDniqyiXaGlH1pt0qiEBu+VVu3ZEg37zmdvJ5e0mnxB156QiIyRtw
         H3O08Mia/8mveXOsMp2msX7GjBGcY2JhPKaRtVRSqoxnKI1uQIo5pq+FhBFYPkzaRlCP
         DfgZ6IGaPodwdTm0Aa90IWn577N9VMjZahFG/URVZhET8d0aECug9GWk4WtqOyA5Rue6
         k8WN7+RgVla6d5zuC/kyjQLAuvThR5o3QF4Ftnbvg0E4+zub42wUqEZhxUv2wa+xiQFf
         jMxn0eMVKUValjLEivpduZqGOTDMxeFHiN4Q+urdAUwuioP6yipPL1CMB4E184nQ48GZ
         l+TQ==
X-Gm-Message-State: AAQBX9c2U2dc3UrH2W3dQ/wWoR/Qnb+4zHJ3TMD3++yACdmdrhfK8d8C
        MvkY5umaWAUcL/4e6vhOl+CIZGtcyL+XAQ==
X-Google-Smtp-Source: AKy350ZIfqQWVjhTJ09zRKRIcFc7TkInJgDzQ8CQtD0xLQARk7UEq9gWhHEfLSBGGGCROCCNiVxyjg==
X-Received: by 2002:a62:7b44:0:b0:625:e77b:93b2 with SMTP id w65-20020a627b44000000b00625e77b93b2mr18932440pfc.5.1680171331249;
        Thu, 30 Mar 2023 03:15:31 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id x18-20020aa793b2000000b00627e55f383dsm22469210pff.3.2023.03.30.03.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:15:30 -0700 (PDT)
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
Subject: [PATCH v2 2/3] dt-bindings: timer: Add Loongson-1 clocksource
Date:   Thu, 30 Mar 2023 18:15:05 +0800
Message-Id: <20230330101506.545040-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330101506.545040-1-keguang.zhang@gmail.com>
References: <20230330101506.545040-1-keguang.zhang@gmail.com>
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
V1 -> V2: None
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

