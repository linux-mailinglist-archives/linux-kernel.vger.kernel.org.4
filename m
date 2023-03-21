Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590EB6C3026
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjCULTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjCULTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:19:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A342823A;
        Tue, 21 Mar 2023 04:19:02 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so19834487pjt.2;
        Tue, 21 Mar 2023 04:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679397542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juzsey6BtkYlkk4LuUy8+fgjnYLnS28U7SbqKreORUc=;
        b=oet03T1QceFRFBr4xJo6b4vkibTR/uk690YlSqMxORKx411hxa7pA9LXjuZSX+Oadt
         Bsioh8Ohv/RUnylIxoVOyU5each6KMwACJaHrx15BbcuwZjK6pYEUX2FbNty0WN1psiy
         xg30vqdz0bQ4rAAmWe2rHTR5QCLfjSxbvScapi1/SsHLfuymbqjvK3bfyGl/oWgJB1G3
         xUFpKWjbXqYxMIqXDQSbWC/fXFbNXhKk7Q50p/2vm8IwRfvKaoz4IP4UFlqOaVHog20X
         qxwQr52y1g698BK6WngSC9W6qSp6Kxx5iq6zzDPlBks9kB/lQ0zd4hEu4CZgkE2iw60C
         F9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679397542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juzsey6BtkYlkk4LuUy8+fgjnYLnS28U7SbqKreORUc=;
        b=eUB4wp/d0jNcGBKZyNUcE/PBNIbgzUCTCVOW3mzISoXHzx/Jdii0sf8r6yQu/AvTHf
         sjapIOUtE0pekeG6GzUmjCt1c6kkiOgLHzYEN26cYDCNeFnRiLJY2ztC5pSWKOv+SVml
         we4+Qk29iEhXSAqJxFzppc1vlrscfMeR3SNSHHoch56j/fiAW2SJETXkwIn8zXmszuJr
         OwWOG1pFqsa12rcHrdFpn37h/rxnRGGj3bqCYU0rDFuAhiPlqLFy3qgqxI2y4RXO3qiS
         FwIKH4u2TOIpPtiR6KC7wreUXKy/EfMXcUVtngMFW3Ijhwi9tnGKSv9G3RdHO6+feE/T
         vcPA==
X-Gm-Message-State: AO0yUKV88iA/orz6UcJIYmDRAs53N0vMoEvskMESsJoMFRhWXgAqwYes
        OYx2xB2DPlhi39VDqVeuD7d3sFVOWY4=
X-Google-Smtp-Source: AK7set/FLs/votT5onZ126QYcnH2afBQC6wnKFQQGpf9V19oENmey3sigZtZd8ooSwBhLsjB6uAhFw==
X-Received: by 2002:a05:6a20:4f0a:b0:d9:9983:e033 with SMTP id gi10-20020a056a204f0a00b000d99983e033mr1771976pzb.41.1679397541879;
        Tue, 21 Mar 2023 04:19:01 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78804000000b005dd65169628sm8238838pfo.144.2023.03.21.04.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 04:19:01 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/4] dt-bindings: clock: Add Loongson-1 clock
Date:   Tue, 21 Mar 2023 19:18:14 +0800
Message-Id: <20230321111817.71756-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321111817.71756-1-keguang.zhang@gmail.com>
References: <20230321111817.71756-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding document and related header file
for the Loongson-1 clock.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
V4 -> V5: None
V3 -> V4: Add Reviewed-by tag from Krzysztof Kozlowski
V2 -> V3: Add 'reg' property into the 'required' field
          Delete the unnecessary property 'clock-names'
          Use the same license as binding document for the header file.
V1 -> V2: Change to one clock controller (suggested by Krzysztof Kozlowski)
          Add clock-related dt-binding header file
          Fix the warning of dt_binding_check
---
 .../bindings/clock/loongson,ls1x-clk.yaml     | 45 +++++++++++++++++++
 include/dt-bindings/clock/loongson,ls1x-clk.h | 19 ++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
 create mode 100644 include/dt-bindings/clock/loongson,ls1x-clk.h

diff --git a/Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml b/Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
new file mode 100644
index 000000000000..01561a0f35d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/loongson,ls1x-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1 Clock Controller
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - loongson,ls1b-clk
+      - loongson,ls1c-clk
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    clkc: clock-controller@1fe78030 {
+        compatible = "loongson,ls1b-clk";
+        reg = <0x1fe78030 0x8>;
+
+        clocks = <&xtal>;
+        #clock-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/loongson,ls1x-clk.h b/include/dt-bindings/clock/loongson,ls1x-clk.h
new file mode 100644
index 000000000000..d400e9ac6002
--- /dev/null
+++ b/include/dt-bindings/clock/loongson,ls1x-clk.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Loongson-1 clock tree IDs
+ *
+ * Copyright (C) 2023 Keguang Zhang <keguang.zhang@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_LS1X_CLK_H__
+#define __DT_BINDINGS_CLOCK_LS1X_CLK_H__
+
+#define LS1X_CLKID_PLL	0
+#define LS1X_CLKID_CPU	1
+#define LS1X_CLKID_DC	2
+#define LS1X_CLKID_AHB	3
+#define LS1X_CLKID_APB	4
+
+#define CLK_NR_CLKS	(LS1X_CLKID_APB + 1)
+
+#endif /* __DT_BINDINGS_CLOCK_LS1X_CLK_H__ */
-- 
2.34.1

