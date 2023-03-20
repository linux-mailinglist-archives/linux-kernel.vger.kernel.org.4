Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E176C0F76
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjCTKm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjCTKm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:42:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD4527984;
        Mon, 20 Mar 2023 03:40:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so11907205pjz.1;
        Mon, 20 Mar 2023 03:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679308814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75J77OlCxIbJelG0MwDOIWwbmsn/FP3deFC9Rlc5+kQ=;
        b=WqhD2YTOp1rM5KBEoWoJDGPbel7mmzKaacsbJvf40c9fNoniOjn0LYcH8HQyAaxun6
         3lVfwMqPmIX51uzCAQHFIfn1yt4kU+Wape0F0CqOxV1GO+Dt6mbwprU1WO4XVL4yrITu
         owNc8b6yr7sgvmkUHd/hksC6p2puhP/5tdtkmU0aYXrRKyFwKD54U2Irp1Bny6g4uOIt
         nxEFhjNVYbH4uw+/Jg6KT6o+XT2eb2SCc0v+2c3YnhysYTLHjuc65YlCXT4oIxAT+OHY
         CrpiD8flM4ZM2fhQjPNxWvGWGDdJFqWyw3/GgZB+ixEcvHj+4x3mhnm83nSlNwYEbSBz
         Oo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75J77OlCxIbJelG0MwDOIWwbmsn/FP3deFC9Rlc5+kQ=;
        b=UBk33JErVMA7Ffj5TnP9cwSTDnD9NjserzWviqCd0dbCO1HTS2RbROJoUJGJENTKFG
         M8tGla3HplyEQUvWXXl9+x70EtzLlMwtRI2jERE/qCkQFNsDNcSBDz1OtwJln305VjC+
         DD0cz+LLJWA02YPR30lsiHMNBeSCjybySAFWasVM4jb+tWlh9EsrrR0pJAVr+FBttvKs
         moIldR8mf4k7EN2XLXE4IHjcdHXaSwwvIHK4SdWrHR58+Ad3zoSG67dKXskC/x4bgrjJ
         IACye01mo3tAV6wsupGZpipBPKn1TWwwCc9XeKhTFIqPJt2eUgzp3XSzqTyRqBjl4Bdz
         DTVA==
X-Gm-Message-State: AO0yUKV0OOGS/QQgvTuDaiIE2iPpfqQvUuOz8ZIzJYwUkCQbwyLZCRyG
        iBL2B3RMqwNamX+dm9Kn8mIUYYb98rQ=
X-Google-Smtp-Source: AK7set/6Tn4IVfpc9L7QcjF92JK2j1fDiKhIPvNxCzfwnzyjp9kvDKMDhwpekQSNvGRR3OG3G2hOhQ==
X-Received: by 2002:a05:6a20:4c1f:b0:d6:80a4:f0b6 with SMTP id fm31-20020a056a204c1f00b000d680a4f0b6mr15232373pzb.6.1679308814198;
        Mon, 20 Mar 2023 03:40:14 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id e17-20020a63ee11000000b00478c48cf73csm5922535pgi.82.2023.03.20.03.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 03:40:13 -0700 (PDT)
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
Subject: [PATCH v4 1/4] dt-bindings: clock: Add Loongson-1 clock
Date:   Mon, 20 Mar 2023 18:40:00 +0800
Message-Id: <20230320104003.407844-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320104003.407844-1-keguang.zhang@gmail.com>
References: <20230320104003.407844-1-keguang.zhang@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
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

