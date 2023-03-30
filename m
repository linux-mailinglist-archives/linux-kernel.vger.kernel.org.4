Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE296D027F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjC3LF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjC3LFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:05:52 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8F89EC2;
        Thu, 30 Mar 2023 04:05:45 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u38so12210108pfg.10;
        Thu, 30 Mar 2023 04:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680174344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BNr20qJaVcba2hiwt9P84y8CLqpSucSovVvpA4+RGo=;
        b=ovkm5tX3noRrnrhFCc+lbSTgyCKhqBgeE8XPXa1oCPlFdGHZCiKyDsLcN2A+77sjtV
         VxWed9uLNd3ZwmzhAg1WjpGuxw/HRpFlcavqPWRJItFtJppISpmpIjVEnqHPtGGXPLRs
         F5iVP5nrCsM0rZyzHwNQP33/Y8aw0XNll9LXxyFz2not6VoY8H2llguIlMCCME4yu7xt
         Lm7y/JKyBx/dY8gBcuIYeSh+WEvRTqQ2ij/p1qqQqcrrRHcvtuZe28rgYvh2GfP5yHJN
         BuLmAdQainXAtx3ZKc6udQe1WZIkWP+Syoa5mSVKrxS82yl+cJD8l5cKLZHy37FiwGp1
         C0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680174344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BNr20qJaVcba2hiwt9P84y8CLqpSucSovVvpA4+RGo=;
        b=TgD67FjcLVQYkkwhb93rT/PmhgMIjg0k1p1MK9bLWFi2dvqME6aJ4ZM3aMJLz8VBmu
         OtKuumgU5mdteRyr3PF4qRhShkglUbUsMaTB5OzOQMLMeO/HHOJBYQ3AeD1MCb9k9/jj
         40QbYhE4HBAwETmtrKfy9p/cREtnhmio7wvm2PRpyd5PztvnLh/5ECNYO7AQK05cp4wM
         I2a03OO76dN/pRDjFQ4QQla041O6KzSbung/gYfGphgU7buwhCko0iyCpfjk1lqY5hAR
         0v96WZlkSpz02d8g1CzQ7QToGdKlrZdg6KwlUdqNblGSr6OshyoUyHUbs4DvXcvSIOTM
         gGjQ==
X-Gm-Message-State: AAQBX9dn9dXc+SkriC5y7z58i96DnXnJTCgkrKkHmGXn4mVO5Wuv2QbS
        0UlblF7gRyr5XwBcy0YeWJa39Z6ygWPAaA==
X-Google-Smtp-Source: AKy350ZwhKeMm9SAV+rHXQsOJPsIyWbveVGarVTc+p94AbB11++P5S6N40Q+PrLwkeK83C0F/48h8w==
X-Received: by 2002:a62:8401:0:b0:628:1852:8431 with SMTP id k1-20020a628401000000b0062818528431mr24521434pfd.30.1680174344541;
        Thu, 30 Mar 2023 04:05:44 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id r1-20020a62e401000000b005e4c3e2022fsm24670922pfh.72.2023.03.30.04.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:05:44 -0700 (PDT)
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
Subject: [PATCH v3 2/3] dt-bindings: timer: Add Loongson-1 clocksource
Date:   Thu, 30 Mar 2023 19:05:11 +0800
Message-Id: <20230330110512.549704-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330110512.549704-1-keguang.zhang@gmail.com>
References: <20230330110512.549704-1-keguang.zhang@gmail.com>
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

Add devicetree binding document for Loongson-1 clocksource.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V2 -> V3: None
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

