Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C056BCD26
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjCPKrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjCPKrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:47:23 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1022EB8546;
        Thu, 16 Mar 2023 03:47:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id p6so660156pga.0;
        Thu, 16 Mar 2023 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678963640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXbk2lZIcd5a+JHWActNIjFKHObyZS9XKGcRqm46zHI=;
        b=cok2CHhrgobWUZIYSImjC4gu5iigLdxlgWnhCtoKj1XJ7rzAY+86gt5vrSB67oSceA
         1GlVjzlOhkQ1zBd4d0QTUP67VdD3Lv3h9Ki/KVIAkjKnfq/tsgqczOY7CevwtrKt4U/T
         F30w79LbWE7OqFsmqN6jsg0XP+q9rtbiePuYbp6Bhs03tzn9cdPfFDzKS+eAuI9prE4c
         4vzxwqKp6uH4E/avNxc/IDkXJk+HLrzyeom43r9a0AcQH3exRhhzBYBKRwMsz/NYmXAN
         uimVOU+Zn6AEQZty2wc6crhc94fUXqRHBWvxs3ltPLNCrWSSN2v9mI5Q8IDn5ndyw9Ua
         w/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678963640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXbk2lZIcd5a+JHWActNIjFKHObyZS9XKGcRqm46zHI=;
        b=a8d/oyftmgmSK52cE26mcVMGXMyPUZh7rK5Je7XIKZcWA5PkUdhf3cQS+a+3iJ5kS2
         GQP5L427ot8QxXh6mCeTulc/eS0NCjS1YxM211vQlwD8m3Vxr3R/WgMdyuOSnxXfJSDK
         dbHXmfL31q9QoB1NbnQZhnwXxH7eTSsFyNybWssiuGNNdhp5qu6aoqGEa3lix0uImSoL
         s1IaVqC+931XYlEsU+jJpV1Ha4a1LLP1CzJODAeIcHsZB622KKQWIt44wtEqZoQyGk6w
         wuFdykSSHQqbUKCIJum65Ep5rb/qOQiJQnNMtf2K8wHRcvl4iPEw2iAoErrwrRjXqABr
         g6tA==
X-Gm-Message-State: AO0yUKVpyXbXmOEje7AMe8JOAz4sMGf7kckga5NZLruGeE/gdLjqfGD3
        aOjICAqwKefB/e1z/nk4vcoOwuk4E3hwEg==
X-Google-Smtp-Source: AK7set9o4BjX3OUeHgMPqRpt6KMRfbGJ+CeWqivHtUdnJnW8bVIIxfH6jTf3ccQ4kUkrDhx8+iTNQQ==
X-Received: by 2002:a62:5f84:0:b0:625:5aff:37a7 with SMTP id t126-20020a625f84000000b006255aff37a7mr1988753pfb.6.1678963640676;
        Thu, 16 Mar 2023 03:47:20 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id f11-20020aa78b0b000000b005d4e89b69e5sm5143263pfd.127.2023.03.16.03.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 03:47:20 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v3 1/4] dt-bindings: clock: Add Loongson-1 clock
Date:   Thu, 16 Mar 2023 18:47:04 +0800
Message-Id: <20230316104707.236034-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316104707.236034-1-keguang.zhang@gmail.com>
References: <20230316104707.236034-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding document and related header file
for the Loongson-1 clock.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
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

