Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ABD669553
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbjAMLQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241317AbjAMLO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:14:56 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74B16D536;
        Fri, 13 Jan 2023 03:12:03 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c85so12638410pfc.8;
        Fri, 13 Jan 2023 03:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNeoiuKmWYrHB6iClN2wcKjKdYKN7BgujLAQ+uo2HLg=;
        b=nWbRid4MyAgUCXz7jJzqhllyWx29F80ANKjZK0bl52UkxgImXb/pIm8WD3OuYbs9Qo
         fkuIZ+5vIXkyD45YgpZyHuGCn1fBFlB7C8rYO4VE9I6sbdoiclTOc8c/QwkJlLxdzZmY
         Ro57+Mpj18ecEtAwBqNehzmvdRfwBY0jkQAr0LNtJqWFGNRNA3mZ8AbkJa0O+K/LH/9Q
         fG8vc7NNUgjcVtxaBMOHb/KXsfbtovxnSQvzgUbDsB9VwW19yd0AJ0u/gJX2SmAqk+OJ
         jMsL0fQYMGCZSdQjeOV6pUSy/MWUUz6ysO+3IyFMGc4eu0UqLE/CpvJGjZ30bdvS7SAz
         prug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNeoiuKmWYrHB6iClN2wcKjKdYKN7BgujLAQ+uo2HLg=;
        b=M/6FM7gPYxL9SdwZn6FBzVX96prc5ktMVIyDAW4m1aguc64rz2RvVemIpvG69t21mT
         XI4HWZ8YX9zxQQVhhpNYM59Ln7JYyIClJmqBURyHYcY3SV0aRVdG+JP9WYcsu5RkpMkx
         AbBijf3GX2V2WVfdpn/AAf2DV7wh4xDRLVbLsb/lqUiufmhr4jd1cSXVmzct0AU5R/2L
         VOAacS/iNMs4ONAe/gIFFzgAFUo/FluxtjBH7nZke+D2W7YQ37WsEJqQ6XWyH+MrKl/Z
         ti66JbbZaZ9N0adgfy6gkzfn66rm4od5TqcBFGVKm0xbWG16p3+5nSqiD5gYVDQPzjeH
         C4Lw==
X-Gm-Message-State: AFqh2kogC+ke6IjwAkSDUt10j4ce5o+oHmnENMNg5mtCc8A60+GjF+lk
        3hMnCKwjECn+xvXmqLrEOnYc+fmr30Kv51oR
X-Google-Smtp-Source: AMrXdXuiFR5xZDpKkbmi7NfqBXIFiGJvF4TgJ8yFD3i01n3lWraTiRUq1PeqXqMwR0xvyjxDSKBhAg==
X-Received: by 2002:a62:1684:0:b0:587:8d47:acdd with SMTP id 126-20020a621684000000b005878d47acddmr16745793pfw.34.1673608322710;
        Fri, 13 Jan 2023 03:12:02 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (ec2-18-163-35-77.ap-east-1.compute.amazonaws.com. [18.163.35.77])
        by smtp.gmail.com with ESMTPSA id x189-20020a6263c6000000b00576259507c0sm13410597pfb.100.2023.01.13.03.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 03:12:02 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 1/2] dt-bindings: clock: Add binding for Loongson-1 clock driver
Date:   Fri, 13 Jan 2023 19:07:37 +0800
Message-Id: <20230113110738.1505973-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113110738.1505973-1-keguang.zhang@gmail.com>
References: <20230113110738.1505973-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding document for the Loongson-1 clock driver.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 .../bindings/clock/loongson,ls1x-clk.yaml     | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml b/Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
new file mode 100644
index 000000000000..4709c6757f1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
@@ -0,0 +1,81 @@
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
+  "#clock-cells":
+    const: 0
+
+  compatible:
+    enum:
+      - loongson,ls1b-clk-pll
+      - loongson,ls1b-clk-cpu
+      - loongson,ls1b-clk-ahb
+      - loongson,ls1c-clk-pll
+      - loongson,ls1c-clk-cpu
+      - loongson,ls1c-clk-ahb
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - "#clock-cells"
+  - compatible
+  - clocks
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    clocks {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        xtal: xtal {
+            compatible = "fixed-clock";
+            #clock-cells = <0>;
+            clock-frequency = <33000000>;
+        };
+
+        pll: pll@1fe78030 {
+            compatible = "loongson,ls1b-clk-pll";
+            #clock-cells = <0>;
+            clocks = <&xtal>;
+            reg = <0x1fe78030 0x4>;
+        };
+
+        cpu_clk: cpu_clk@1fe78034 {
+            compatible = "loongson,ls1b-clk-cpu";
+            #clock-cells = <0>;
+            clocks = <&pll>;
+            reg = <0x1fe78034 0x4>;
+        };
+
+        ahb_clk: ahb_clk@1fe78034 {
+            compatible = "loongson,ls1b-clk-ahb";
+            #clock-cells = <0>;
+            clocks = <&pll>;
+            reg = <0x1fe78034 0x4>;
+        };
+
+        apb_clk: apb_clk {
+            compatible = "fixed-factor-clock";
+            #clock-cells = <0>;
+            clocks = <&ahb_clk>;
+            clock-div = <2>;
+            clock-mult = <1>;
+        };
+    };
+...
-- 
2.34.1

