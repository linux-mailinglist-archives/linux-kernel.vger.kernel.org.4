Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DAE6DABE3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjDGLA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjDGLAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:00:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A131235AC;
        Fri,  7 Apr 2023 04:00:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v9so3459967pjk.0;
        Fri, 07 Apr 2023 04:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680865250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEKUX88yyRCa/+8I/hmTaP46+2L5p+4mH+ONKNzZlAg=;
        b=i/TpKG12qTFoyL/DdKVSUDakrdaNAucjMlJ0ZO8Bwy1II+ogUtg7AiYz6pXHGeZgf2
         XAW5wEjYv1bLI8H+Cxfk/SWNLxqIhNFjmdsIAgyiT9LYU5agWcY7w9B3WJESWzwA2Ylr
         o2ou8TdB9bwPjW7WW6bOJ9IoQZZQgTJBvmW26rRNnasy6TKjJADBiTvi7pE82tqBMxdS
         lP2a36jDTR/12nMwfNs/lost1AnzVkym4S3gKOZ7tQ05LowQcY9AcwfnE7YiqVdVHxm5
         eK0Vjlf1xZEumCtb9D0oZtGK0QDbSZdrO6I1OULWIsoqzjVgT/45XeMS+7lqcLmnHec3
         HmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680865250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEKUX88yyRCa/+8I/hmTaP46+2L5p+4mH+ONKNzZlAg=;
        b=mJWKnrWWtlRSh+EulPMYv4av52zTiF1pImevL4rJIgTDywqp2qqlrCT6xKbt1raPC4
         ViGIujPoGEDFtCFQydH6PRKd+KQZ4QTRoC9CV2g3MWSI6T6CIY5BmpsDfPbQceYRZhda
         dGRnb0R0bJYUfkBJdslU9TltvthHsF/9zFKkWtdS48F/KzIuZKinVXS7VmPD1l26g5BZ
         J8kdpuYnVAAeMW1pxuPByh/UbGE9bTbnERCb/o3irSOSAVdQo3b3rvOtC0beg/UvGBth
         tnM4gASCcZ8mXeKJ6wmjxUWY9tGumoYaWJjptULmZxwFDfQb2DtFDtAPmXNzMjrTCG9i
         7ctw==
X-Gm-Message-State: AAQBX9e76RXYdweb6pcvvw7g+aZRoaA5+2qrSUcP4LRaqKXSY9CUN5NL
        /4YyTxginz+8ArpaMYJEchFR4vnEMcp3Rw==
X-Google-Smtp-Source: AKy350baDqPde9rbkA1sKyOezf0KszEE4SIVXiUgD/8lly16HNEThGUAj00ng8w2BpdzMNH9eWlHeg==
X-Received: by 2002:a17:902:e745:b0:1a1:cc0c:a5c2 with SMTP id p5-20020a170902e74500b001a1cc0ca5c2mr2228876plf.62.1680865249748;
        Fri, 07 Apr 2023 04:00:49 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.84.161.179])
        by smtp.gmail.com with ESMTPSA id jw1-20020a170903278100b0019ee042602bsm2732005plb.92.2023.04.07.04.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 04:00:49 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Ling <gnaygnil@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 1/2] dt-bindings: watchdog: Add Loongson-1 watchdog
Date:   Fri,  7 Apr 2023 19:00:24 +0800
Message-Id: <20230407110025.516405-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407110025.516405-1-keguang.zhang@gmail.com>
References: <20230407110025.516405-1-keguang.zhang@gmail.com>
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

Add devicetree binding document for Loongson-1 watchdog.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 .../bindings/watchdog/loongson,ls1x-wdt.yaml  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml b/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
new file mode 100644
index 000000000000..203726da14ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
@@ -0,0 +1,40 @@
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
+    const: loongson,ls1x-wdt
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
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/loongson,ls1x-clk.h>
+    watchdog: watchdog@1fe5c060 {
+        compatible = "loongson,ls1x-wdt";
+        reg = <0x1fe5c060 0xc>;
+
+        clocks = <&clkc LS1X_CLKID_APB>;
+    };
-- 
2.34.1

