Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695806909E6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBIN2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBIN2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:28:11 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D435EBD3;
        Thu,  9 Feb 2023 05:28:11 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k13so2852298plg.0;
        Thu, 09 Feb 2023 05:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7ennN11gR5+K2GtgSP0Bfl4EWIP5xLL1THmr9tsyNE=;
        b=mDAzKgRS+SrklWXhLJxO+bpNwbPZ7BsYfV0UXt43pvWBSSkJ+TaYYVCRiLLR7Wmnir
         Ph0HVsPa0d5NKOa4FwQ82Pj9YT6Xn1UowPZhuj0Po8YFoxtKzgQ2Vn2GHeXoHNN1Eh0I
         F92uNSYxl6gQ+a+UEjYx/kWLF8khZSnXHkCKTRVmRgmiU7iRdnLG9QmQ6whOgW3ao1FB
         w6RVmkS6bWFav7rY+h1gKtN8sErqzK0M3GYKh3RNH6NIHPFuidEf+t0vbhas5al6yWAC
         lRFKlRPgaD5f/VKAAJf19k/xQSpX7AkuK0q2USOsHXZEoqH9rqahqPAj8Dxq99s9BlPo
         PSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7ennN11gR5+K2GtgSP0Bfl4EWIP5xLL1THmr9tsyNE=;
        b=S66eL4QXziUH9uo/ibTXdIsfEjP6PW2B17PgEqxDfRoBldHpMvmcgnGPUnd14FkF5v
         ZPoIOWApt1LFzgNGFXcZVkJsoVZlTzqpW1xUrzEjUBpdIM0ELteQ3x+4E8gBkU9+NYDr
         qkQo7QJRcAXoA62ozolEr5HaNsVvBZcPOlZUHDhzb/qBL7YQZYBZ9Wu60Tc7+azvKR/Z
         7ADsC41+nWowjfoBRs1FAycVSkA054SEpTgwhKinAK22JyCYZYpShaj+zkZsKtw+eO+Y
         h7Q+mSXkpG7grqYJWPgmBvugqxZVqx8bbfE7APXgFPbdVd/Xqg3WWBzJWHkUP1S+8vsC
         OxXQ==
X-Gm-Message-State: AO0yUKVnO11m9bV3DjaiB/rTrQJ+NTepo/G8GR2er0mcDSvX3CJJoh6u
        Jya1NqBOaHaigmeelHG/atzxznWLYD72sA==
X-Google-Smtp-Source: AK7set8PF+DbhU5+M3DUK+4M9qgN/qveko+tAUYYkzr2udae3vJnNe1w3TLKCptbmqa/EnZ654vfvg==
X-Received: by 2002:a17:903:32cc:b0:19a:5c52:71f with SMTP id i12-20020a17090332cc00b0019a5c52071fmr2060900plr.17.1675949290291;
        Thu, 09 Feb 2023 05:28:10 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (ec2-18-163-35-77.ap-east-1.compute.amazonaws.com. [18.163.35.77])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709029a0c00b0019339f3368asm1493972plp.3.2023.02.09.05.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:28:09 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH V2 1/3] dt-bindings: clock: Add Loongson-1 clock
Date:   Thu,  9 Feb 2023 21:26:12 +0800
Message-Id: <20230209132614.1079198-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209132614.1079198-1-keguang.zhang@gmail.com>
References: <20230209132614.1079198-1-keguang.zhang@gmail.com>
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

Add devicetree binding document and related header file
for the Loongson-1 clock.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: Change to one clock controller
          Add clock-related dt-binding header file
          Fix the warning of dt_binding_check
---
 .../bindings/clock/loongson,ls1x-clk.yaml     | 49 +++++++++++++++++++
 include/dt-bindings/clock/loongson,ls1x-clk.h | 19 +++++++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
 create mode 100644 include/dt-bindings/clock/loongson,ls1x-clk.h

diff --git a/Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml b/Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
new file mode 100644
index 000000000000..a911762dd01a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
@@ -0,0 +1,49 @@
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
+  clock-names:
+    items:
+      - const: xtal
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - "#clock-cells"
+  - compatible
+  - clocks
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
+        clock-names = "xtal";
+        #clock-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/loongson,ls1x-clk.h b/include/dt-bindings/clock/loongson,ls1x-clk.h
new file mode 100644
index 000000000000..579552c5f14b
--- /dev/null
+++ b/include/dt-bindings/clock/loongson,ls1x-clk.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
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

