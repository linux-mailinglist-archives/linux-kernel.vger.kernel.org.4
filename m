Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E4C6EE03D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjDYKZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjDYKY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:24:58 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A571C15B;
        Tue, 25 Apr 2023 03:24:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b70f0b320so7373536b3a.1;
        Tue, 25 Apr 2023 03:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682418286; x=1685010286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gskRV6NZxjvlVPB9LYj3AE/fP6UOn8jR3KRbyAwMrsA=;
        b=LYU+J7kLjdyTtA1B4Wt7jE220ncGn3L0rCt9E7M2pcQyQqJubxX9Yp26Givy6UWSbU
         z0+250aMFzodHBZgl73xz63FjShOEMt7aceqyACVY7ZZ0TWv2tiMxwt6Q/wa7fNx71wm
         F9QY2G+xust1zUuHz3aacIPQaRMmTWNcM3Xge6jtTi9A/b+j/Zm7Nlh7Ngi7Uf6lB8Hv
         RcJhf/9ZVBlAAmDGwWKhTiqCtfOp86twLK30fCAbEaT5VhxZfwy0dBpe3RxkjuNv4Lmm
         Xy9jvJS0cEumFcvePJJADUew48CUTUGwqdK5hzBMWZnievdvf7CsPafNp5rLdKDU9PEM
         L8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682418286; x=1685010286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gskRV6NZxjvlVPB9LYj3AE/fP6UOn8jR3KRbyAwMrsA=;
        b=iCliMa6SNrBa3UwM6lrBCT8BDZeOgfGFGpy0s0zoDdyHtYwRWGXK0Q7S65KGic1M5F
         2ASaIFCjvyKUMCBf+XQAQ1yHK/bOcSqKohGQAtKYjRfphHt92O54QkYjjIdlfxafxuJC
         OVmcRH/DAqSIEALKv9zmoFm/Vo1oyBYTcq/wEIEDZlC7lIlkhkJZdNhh03L3RWrcLje4
         b9k41wN2Hq3fMPqIX4NdocZu2P96T7R6FKkSGydb1y9BbqI+qybsm/oNLxtSkhPsxG75
         yIkELofGQE4zZccf/t34Anf12y2CEBiqthuc8vd/nN+qugLb0GjtlPRzx9s3LKgOEByM
         7Cng==
X-Gm-Message-State: AAQBX9ea7r2qzQwTHMPkZUAK0vzUGJI3EMJCsZIOTPaU5ONUS/wUhtnO
        BxDbSEbiUXlvXctfk0TCgg8=
X-Google-Smtp-Source: AKy350ZfseOiGaHtmJKo+lVwCM2cRKhz0fEdkE2jHJfpZuSTmUIXo1o5W4TXTTADA36+beLmX5M7Pg==
X-Received: by 2002:a05:6a21:999c:b0:f2:88c:d55d with SMTP id ve28-20020a056a21999c00b000f2088cd55dmr21500734pzb.46.1682418285707;
        Tue, 25 Apr 2023 03:24:45 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 30-20020a63125e000000b0051b70c8d446sm7644715pgs.73.2023.04.25.03.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 03:24:45 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 06/11] dt-bindings: serial: Document ma35d1 uart controller
Date:   Tue, 25 Apr 2023 10:24:13 +0000
Message-Id: <20230425102418.185783-7-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425102418.185783-1-ychuang570808@gmail.com>
References: <20230425102418.185783-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add documentation that describes the nuvoton ma35d1 UART driver bindings.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/reset/nuvoton,ma35d1-reset.yaml  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
new file mode 100644
index 000000000000..34c5c1c08ec1
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/nuvoton,ma35d1-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Reset Controller
+
+maintainers:
+  - Chi-Fang Li <cfli0@nuvoton.com>
+  - Jacky Huang <ychuang3@nuvoton.com>
+
+description:
+  The system reset controller can be used to reset various peripheral
+  controllers in MA35D1 SoC.
+
+properties:
+  compatible:
+    items:
+      - const: nuvoton,ma35d1-reset
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  # system reset controller node:
+  - |
+
+    system-management@40460000 {
+        compatible = "nuvoton,ma35d1-reset";
+        reg = <0x40460000 0x200>;
+        #reset-cells = <1>;
+    };
+...
+
-- 
2.34.1

