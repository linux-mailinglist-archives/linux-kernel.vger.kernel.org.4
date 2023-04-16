Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80066E3AA1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjDPRex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDPRer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:34:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDA14495;
        Sun, 16 Apr 2023 10:34:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b73203e0aso2413216b3a.1;
        Sun, 16 Apr 2023 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681666470; x=1684258470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0z1wF+5X+yAytXwzaAl5mkeaCddDJf5iUHO9ZaWYxs=;
        b=kbtSorJPSCjRTWhNRCYKYEFwYmkDV9cdXhE2CLO3Ta8IyyKNITGaY8t7RLY/MIrrRd
         r9AuiAZvcUFANjOBHV4z2sKi0H8lkKPLOHZn+gZOH3KGF03b1Df3OPMqRltwvbRZ//So
         SzYk5An/1ZoAQkZUtxks4d4GtXKVza9dVOuaKAlp8LEfuGFDw0eBC+w31hXzI17G9Z9C
         /MytYoBrGSlz5WnmrBT0EU8QqRrCnaGebQ/QVIYpRK/22cowOyQS3WUMCsEVll42FRO6
         xBr+nMgGQakgM3iIMrdrK+jh8U2LLz3lOdEkqcTxtWwWV+e5ZzHRLP9LJwHQ3MoiACLe
         ew3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681666470; x=1684258470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0z1wF+5X+yAytXwzaAl5mkeaCddDJf5iUHO9ZaWYxs=;
        b=NO6jFxOnADFuCNJ1hfyfK4eN90be5ETds4L+2OcNjKBgt43MALo05xT4AquWvDvZSI
         aMD+ks3NmpibsvOGRfBxU6l+uiUvQhagGVzITjeIbfkV9y9n/TgUW93CYrwhpHfYeoyL
         4/e7swTV216rUzop9uTSK6miKOMwXqigPbQO7hoHixloDgQ3i2010DXh/FNVeJQsdAj1
         zWSNCQKyg4DVu2bnWY8yo9tV+KaZASChgDueplFC/7+pSHLCv74BjBytRb9Aoub50cFw
         CRJSJLxq5oJhlsKgC8ZlH9J5xmG+rHfvingRsVUvkAU5DzGUD8H9zvMEcKViH2XVC/Dh
         1hag==
X-Gm-Message-State: AAQBX9equrLkDoNdkPrhuGzxYSt8nWtf/OGHt5MsetGthJOHU06fXTm7
        7zKjwoetX+c+tKXbMUDK8alwVx3QZ2dna1xZSyk=
X-Google-Smtp-Source: AKy350Y081WFjCQ/S98tKasSk9mCw09G+bfSokw1uESB5OjwcBTZ6OMPc9RSA0iJELGMTBYD5VJeVw==
X-Received: by 2002:aa7:8383:0:b0:635:d9e1:8e1e with SMTP id u3-20020aa78383000000b00635d9e18e1emr17926460pfm.11.1681666470617;
        Sun, 16 Apr 2023 10:34:30 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.200])
        by smtp.gmail.com with ESMTPSA id j22-20020a62b616000000b0062d90f36d16sm6110973pff.88.2023.04.16.10.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 10:34:30 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     devicetree@vger.kernel.org, David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        gate-clock@cc.3
Subject: [PATCH v2 3/4] dt-bindings: clock: Add gate-clock
Date:   Mon, 17 Apr 2023 01:33:01 +0800
Message-Id: <20230416173302.1185683-4-mmyangfl@gmail.com>
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

Add DT bindings documentation for gate-clock, which can gate its output.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 .../devicetree/bindings/clock/gate-clock.yaml | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/gate-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/gate-clock.yaml b/Documentation/devicetree/bindings/clock/gate-clock.yaml
new file mode 100644
index 000000000000..3c993cb7e9bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/gate-clock.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/gate-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock which can gate its output
+
+maintainers:
+  - David Yang <mmyangfl@gmail.com>
+
+description: |
+  Clock which can gate its output.
+
+  The registers map is retrieved from the parental dt-node. So the clock node
+  should be represented as a sub-node of a "clock-controller" node.
+
+  See also: linux/clk-provider.h
+
+properties:
+  compatible:
+    const: gate-clock
+
+  '#clock-cells':
+    const: 0
+
+  clocks:
+    maxItems: 1
+    description: Parent clock.
+
+  offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Offset in the register map for the control register (in bytes).
+
+  bits:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Bit index which controls the output.
+
+  clock-output-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#clock-cells'
+  - offset
+  - bits
+
+additionalProperties: false
+
+examples:
+  - |
+    gate-clock@cc.3 {
+      compatible = "gate-clock";
+      #clock-cells = <0>;
+      offset = <0xcc>;
+      bits = <3>;
+      clock-output-names = "my-clk";
+    };
-- 
2.39.2

