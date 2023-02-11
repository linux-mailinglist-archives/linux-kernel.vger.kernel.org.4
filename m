Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28DC693108
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 13:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjBKMpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 07:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBKMps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 07:45:48 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7044E34C2C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 04:45:47 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j25so7758143wrc.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 04:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYHx+je9LlLLfoWib7qSrz0WDJ+DfqWyBz802fQM5tc=;
        b=ABEP388jR8ol3nzf/5yE5HjAyWnY1m2Dnu4NmnsFgmwV2EDqbDXnmUW39xNLYS8k/Z
         g7NZDVIUmO5paJKeZ5t9hua0eK9M67wAl1+iBKgN+MUBXNjXlQDvaWcDzB6RZSq5mFrS
         jqDU8+WeJH4f+U1iH0Y6HHQP/HFzpkpKCOKiCzAVDn89ecdEr/vTVE3HBv/uCfB8eeEp
         oc15xZD6l4TLwKRhDYURf2dsdCe5d1rAwW6j3Rp8EyOwySaRh3n7RPcFs5C9CRxF5bWL
         mTTVH0n9Bt5V+xSGTethK4iDTWxL/SMyil2XjL1hnLi4o5Nd4QpQMX+840Frec6oRZhV
         LYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYHx+je9LlLLfoWib7qSrz0WDJ+DfqWyBz802fQM5tc=;
        b=1iMobjsXbokhEX3AP8g1aa7IBoXWpixtNjL12gCYgJgOubVBBr6l+MaLjiFy43pLOP
         Y+EbaMbP5Hgr+u7q+IPopdHf4WdPlkpoSZrZV62G3eSzE+lv+0JZyxGTTtfGgh1gyq1O
         UvGY3ZsdA/iHzRVI48usM4kKwDwXqM2WvtVMjX5B8qPSvqm8AeDCyzuNwwfW/MZ/6raq
         3hQheb9FxTAxJdDucz2HvrFU+uk5idRMrC0SotlzISaOyVqVOi837XiOPheQ+YyPKJ8V
         Zi72KHtCEBdV3ToR44rcip20blKbl7gTgQrulfFOZuqMBVS3nVzR9URAJuGfM91DvVb2
         hwFQ==
X-Gm-Message-State: AO0yUKVvDBVayLwfarS8Fa2Cg5KNckKDk+DD+cU3lUa/go5tvKdywSfK
        nWciO4LQQY5t8MkgJJyTZESKOA==
X-Google-Smtp-Source: AK7set9RJ1cqphv9bnbEEOnbi9uyqbV0a9sX1VN/SDIAgwQjL76rxKcql3/X+obdcV8oQ9lG2lGFHg==
X-Received: by 2002:a5d:6b02:0:b0:298:4baf:ac8a with SMTP id v2-20020a5d6b02000000b002984bafac8amr14979618wrw.44.1676119546065;
        Sat, 11 Feb 2023 04:45:46 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d6644000000b002bc7e5a1171sm5918754wrw.116.2023.02.11.04.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 04:45:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] media: dt-bindings: st,stm32-cec: drop obsolete file
Date:   Sat, 11 Feb 2023 13:45:40 +0100
Message-Id: <20230211124540.71208-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The st,stm32-cec.yaml was moved to media/cec directory, however the
"remove" part disappeared during applying.

Fixes: 8f43766211af ("media: dt-bindings: st,stm32-cec: move to cec subfolder")
Link: https://lore.kernel.org/all/20221208103115.25512-3-krzysztof.kozlowski@linaro.org/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/media/st,stm32-cec.yaml          | 53 -------------------
 1 file changed, 53 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/st,stm32-cec.yaml

diff --git a/Documentation/devicetree/bindings/media/st,stm32-cec.yaml b/Documentation/devicetree/bindings/media/st,stm32-cec.yaml
deleted file mode 100644
index 7f545a587a39..000000000000
--- a/Documentation/devicetree/bindings/media/st,stm32-cec.yaml
+++ /dev/null
@@ -1,53 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/media/st,stm32-cec.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: STMicroelectronics STM32 CEC
-
-maintainers:
-  - Yannick Fertre <yannick.fertre@foss.st.com>
-
-properties:
-  compatible:
-    const: st,stm32-cec
-
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
-  clocks:
-    items:
-      - description: Module Clock
-      - description: Bus Clock
-
-  clock-names:
-    items:
-      - const: cec
-      - const: hdmi-cec
-
-required:
-  - compatible
-  - reg
-  - interrupts
-  - clocks
-  - clock-names
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/clock/stm32mp1-clks.h>
-    cec: cec@40006c00 {
-        compatible = "st,stm32-cec";
-        reg = <0x40006c00 0x400>;
-        interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
-        clocks = <&rcc CEC_K>, <&clk_lse>;
-        clock-names = "cec", "hdmi-cec";
-    };
-
-...
-- 
2.34.1

