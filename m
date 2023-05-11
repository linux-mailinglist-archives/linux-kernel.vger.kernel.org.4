Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD1F6FF148
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbjEKMNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbjEKMNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:13:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26217DC5F;
        Thu, 11 May 2023 05:12:19 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-643990c5319so6089756b3a.2;
        Thu, 11 May 2023 05:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683807130; x=1686399130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=On9N88gLZYLQdmk44hl2omlUa9IquKB2qRmA2LW1HWU=;
        b=d35w62FiWW+qfRxGM8hF+yB2bqN2tcjRlz+/iPMb0V5w91Lp1+zEg0zVpash66eENR
         7iuWZZ1i/5ZvlC0nLuxoRaPIqNlpucJRT5CSju71MP9tL1CyI27mMG8/j151ojpRiRGy
         hkrPa3oJ8Vxa5CAAUUPChg2OpsUg1ulgd68kixNK196FPzHz36hgHLOcu/Z2CH8eRW15
         6+cg7MmyIx1xiBe7e/UlJppt4J9l28D4eupyPIyhhBtdnHoE/px7Y0AWe4+xYgBiLyK6
         Zz2dNg9viicG9gW+sy0DqaK3qyQBqp9BqREKb2c0TRKxpOdy5qj87aF1iit6HPhqDQqV
         +Tgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683807130; x=1686399130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=On9N88gLZYLQdmk44hl2omlUa9IquKB2qRmA2LW1HWU=;
        b=aGc0UaJRT4a/5vmh2/j4wZpHfEdNuhDuH93AFyxPsTIBTnlWevp2UoNnEi26g6bIOx
         thL2GXEQcBQ6YuDSPTWctI/jJD4xLMS2iUuzon9f8WeyT6je82BLmubMZUhF2tgjMLlm
         BpWq3csXICSH1tBoYtBUM/B33q6Kt1HN98ShLvZJJCxP4PjxxSFUVSb7ITculsIqU6gq
         yXCO8YjT67kaXVBhyA6q9pmJboyVv6L4XdWi+92bnNQPErNgR4VMy2iFD2HjejRomLUj
         im2BNQT1VLDXr4IjM5yKpgJVIgmGo7kGh1HjeJDZApiHC4LaeRYdyURbus4uRpCbUyEQ
         moQg==
X-Gm-Message-State: AC+VfDy13o53RGjofOeoj/m69SmpcI5kEqa9TA50VMu6H9IfNZLGP06j
        nKyFtO09Z1MpF3SqVSH6XORwu+konj2+1Qg1
X-Google-Smtp-Source: ACHHUZ5rp26Wy86X1QU+wEviKpLLY368Nc/vPuxsCQmHAc014wFabt/bchsPdzM1N1/YtFxNXiC+QQ==
X-Received: by 2002:a05:6a00:17a3:b0:643:aa8d:8cd7 with SMTP id s35-20020a056a0017a300b00643aa8d8cd7mr30016691pfg.32.1683807129844;
        Thu, 11 May 2023 05:12:09 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id j10-20020a62e90a000000b0063f16daf7dbsm5134562pfh.55.2023.05.11.05.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 05:12:09 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Ling <gnaygnil@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: watchdog: Add Loongson-1 watchdog
Date:   Thu, 11 May 2023 20:11:58 +0800
Message-Id: <20230511121159.463645-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511121159.463645-1-keguang.zhang@gmail.com>
References: <20230511121159.463645-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding document for Loongson-1 watchdog.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: Replaced the wildcard compatible string with specific ones
          Use unevaluatedProperties instead of additionalProperties
          (suggested by Krzysztof Kozlowski)
---
 .../bindings/watchdog/loongson,ls1x-wdt.yaml  | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml b/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
new file mode 100644
index 000000000000..81690d4b62a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/loongson,ls1x-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1 Watchdog Timer
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    enum:
+      - loongson,ls1b-wdt
+      - loongson,ls1c-wdt
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/loongson,ls1x-clk.h>
+    watchdog: watchdog@1fe5c060 {
+        compatible = "loongson,ls1b-wdt";
+        reg = <0x1fe5c060 0xc>;
+
+        clocks = <&clkc LS1X_CLKID_APB>;
+    };
-- 
2.39.2

