Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1AB6BA941
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjCOHbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjCOHa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:30:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CB46A9D1;
        Wed, 15 Mar 2023 00:29:32 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso959537pjb.0;
        Wed, 15 Mar 2023 00:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678865366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6YPhoB5qekiIB/bKEm014j3Zxx30bCFcgqCGfR6z6o=;
        b=KaSZFRDcSfDYojn0W3HzDZomplXOMqkSExLU5RK9/6ItjmFVN6YM1XrO+ffdc1XQom
         ErHjz7FqLMcjZ/Siz6VbHYrjqbkgZsYACbZ1gK4DfBKKJBDNAOyXshyf/GDIcE6IQlMj
         7CHjIOfpS2qNzQl0HvG2fDvtQ8ueNvHON2G/wwXii0HJrcesdXHRfiJcwEYAOLDBpyB6
         D/XB+JltGQdtwd1uo+Mm0l/+t+xcFKccXqJiGbDSK9PL5H91PdZnJdluBY2G7zlgBuOS
         xS2XfqNHkIdJP9/m5KryRgrUJ2/C05XsPFHAljkTmp7lGeiuG3sssuzo9/n8qb2p2SD7
         s4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6YPhoB5qekiIB/bKEm014j3Zxx30bCFcgqCGfR6z6o=;
        b=OwogfGd9G94KiCpFfa6WHNxdI6YaWqXf4dTLhIXy5wa26J2QlUXBO96mSiuH9B4rZJ
         j+o2HsNLGk2RUvz3wiEHgUYl5kW0zRqCWRsXkBE81NkibqdMw9OY3K3BSdJph9bG0gZM
         5KfG4YpzbZlEkqhyt122FgzvWVOMoxV9xqpf8xlhFbJyaEhaHwInTQp4N/uJgnjtg7/M
         jIfM+UKiAsCWiAHZtLAghBAfUdUVV9oL2FQzlpNkC/08hhU0m0zaUzyjZN/e5eDSwTLX
         XHvzqjfM0UoE83DpeDNTaiDvJ3IemiOqHsrHY+/oITz54sigNlqz5nkZD/VGbTSet8Ox
         wfsg==
X-Gm-Message-State: AO0yUKWoeRg1kRve82fvM2sshI1U379PcKGE8geuYtaaIjaM3c4kDn2c
        fxKQfcEcnqeCFdEyFD4JZUU=
X-Google-Smtp-Source: AK7set/b7j+BfnZ03YOFaKwQRt507Sb+df2V7nZpgVaR499M/+nW3gW/5ViTUwamAsa2nFyH4Vczpw==
X-Received: by 2002:a17:902:db05:b0:19c:3d78:6a54 with SMTP id m5-20020a170902db0500b0019c3d786a54mr1521147plx.14.1678865366293;
        Wed, 15 Mar 2023 00:29:26 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id kz11-20020a170902f9cb00b001a0667822c8sm2740003plb.94.2023.03.15.00.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 00:29:26 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 07/15] dt-bindings: arm: Add initial bindings for Nuvoton platform
Date:   Wed, 15 Mar 2023 07:28:54 +0000
Message-Id: <20230315072902.9298-8-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315072902.9298-1-ychuang570808@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add binding for ARMv8 based Nuvotn SoCs and platform boards.
Add initial bindings for ma35d1 series development boards.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../devicetree/bindings/arm/nuvoton.yaml      | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/nuvoton.yaml

diff --git a/Documentation/devicetree/bindings/arm/nuvoton.yaml b/Documentation/devicetree/bindings/arm/nuvoton.yaml
new file mode 100644
index 000000000000..f95e7b30711e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/nuvoton.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/nuvoton.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35 series SoC based platforms
+
+maintainers:
+  - Jacky Huang <ychuang3@nuvoton.com>
+
+description: |
+  Boards with an ARMv8 based Nuvoton MA35 series SoC shall have
+  the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description: MA35D1 based boards
+        items:
+          - enum:
+              - nuvoton,ma35d1-iot
+              - nuvoton,ma35d1-som
+          - const: nuvoton,ma35d1
+
+additionalProperties: true
+...
-- 
2.34.1

