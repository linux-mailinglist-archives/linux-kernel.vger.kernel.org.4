Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D396E3A8E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjDPRdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPRdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:33:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7217C26B2;
        Sun, 16 Apr 2023 10:33:32 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b4bf2d74aso929363b3a.2;
        Sun, 16 Apr 2023 10:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681666412; x=1684258412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5kIOddp2BM0cA3ov6qyXIiq4ZLBnVdQ+km/uFDAHF0=;
        b=Eeo1XDbbRb9eKnyFHhcSuoLP/sYJbukWB80hLaDCj6j221CKAwA7xYo0eZEVYRONrw
         JlfulZdLJX0jxrkWEgqjZh2Uc1dagl9LHsOcntODS/5hOq+akb4rkb3VUNb1TgoRbrmo
         RR8VSmJ0GaW/m97F9MsE3SkqFn8IY+pmxaY4YYF3UMXoueCNVe7K/YzbLDTKAA28WK4c
         cOaJRyz4uQmNUVCbwoYu76GHpsnzNKy0QJWU1kybfk7F6AO+C1l+NUXEhRJTX+CG/D9J
         QF0CSh9RyhOhtAar7lwudUwjDY+UiUd3bKVhgi3+trt20oooBrYcgsn8YToTmp1aHdko
         TmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681666412; x=1684258412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5kIOddp2BM0cA3ov6qyXIiq4ZLBnVdQ+km/uFDAHF0=;
        b=GMUrrmDrMbWOM2FEROmSSdgUNn18SppJQGMn485UpPYCTndYI4Wk0BQGzIavX1mbp+
         pzSBlhPB6B3cVFiuWSlnkwqjlozZsHZ454z1XF4Gnied32LrkpCLhXWjzuDyu0uUeosr
         bmqHMETUNBeKQrJ+jeSaVu84YZX3FO7/GwPT5ue+vPYvoCEFt/9/QwCnql7lbvzJP6lK
         3lZYwruwTkIKJXzGC2rITCpVdTWtCOcWh1xfAAfsquaAXUDbY9pbtUPx0xMsSy59AN39
         iJ1DAgA92zQvHa8wWFniMgkpdgguTBoSPr0ZVw5RRUXzQ3bUsqV4UEss0JjNA4ySVbUB
         0brA==
X-Gm-Message-State: AAQBX9cYK4p2QpojUVZeDxuwGhgNDbOb2S5vOgUfF0eW+iWWc6lNEwWA
        qUHiDwDm0pmbzqbX1zmxV/4d9J6/k/2tS0je5LA=
X-Google-Smtp-Source: AKy350Y8vu47+r13CkiocfYLaqXrvC4pWA1zaDRkAZ+aTwSsGnTXZMzvHW+YaFLOOUl5PL4FG7cn0A==
X-Received: by 2002:a05:6a00:228e:b0:633:afea:6b1a with SMTP id f14-20020a056a00228e00b00633afea6b1amr17811414pfe.19.1681666411698;
        Sun, 16 Apr 2023 10:33:31 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.200])
        by smtp.gmail.com with ESMTPSA id j22-20020a62b616000000b0062d90f36d16sm6110973pff.88.2023.04.16.10.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 10:33:31 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     devicetree@vger.kernel.org, David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v2 1/4] dt-bindings: clock: Add simple-clock-controller
Date:   Mon, 17 Apr 2023 01:32:57 +0800
Message-Id: <20230416173302.1185683-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416173302.1185683-1-mmyangfl@gmail.com>
References: <20230416173302.1185683-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings documentation for simple-clock-controller, mutex
controller for clocks.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 .../clock/simple-clock-controller.yaml        | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/simple-clock-controller.yaml

diff --git a/Documentation/devicetree/bindings/clock/simple-clock-controller.yaml b/Documentation/devicetree/bindings/clock/simple-clock-controller.yaml
new file mode 100644
index 000000000000..17835aeddb1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/simple-clock-controller.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/simple-clock-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Simple clock controller
+
+maintainers:
+  - David Yang <mmyangfl@gmail.com>
+
+description: |
+  Driver (lock provider) for real clocks.
+
+  Usually one register controls more than one clocks. This controller avoids
+  write conflicts by imposing a write lock, so that two operations on the same
+  register will not happen at the same time.
+
+properties:
+  compatible:
+    items:
+      - oneOf:
+          - const: simple-clock-controller
+          - const: simple-clock-reset-controller
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 2
+
+patternProperties:
+  "clock@.*":
+    type: object
+    description: Clock nodes.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@ffff000 {
+      compatible = "simple-clock-controller", "syscon", "simple-mfd";
+      reg = <0xffff000 0x1000>;
+    };
-- 
2.39.2

