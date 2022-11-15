Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81E6629916
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiKOMmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKOMl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:41:57 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AB8233A9;
        Tue, 15 Nov 2022 04:41:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so941852wmi.1;
        Tue, 15 Nov 2022 04:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XqzQB8TU0zGfIa93TNnmYPi07sqP4CGBe1E2pmqvYX4=;
        b=a/mUQ0gLGJuAG19stPjBzzH4Den3fShFdqMZ1U/H8yyC0N7I7zu431yZmkQb2coYpw
         K0yu703YvxXPJZHFBbNBiTdEBVUgFglZCpi1LvveqHhs0l2vY5NJEFODK7FbE0hKp2EC
         eWblFVm1BKkcOJGxAbnoTp4Rci1MOftkTsATy3Qbp1cwCeTtQ+4CjcTEestHMX2zwk9/
         YrnAylrd8NdPm75ocRiQXm/xHxHRuoHCcARqnXxlBuZNHZv1NwSHMJahTIWLDNNE8b0T
         UbI1nt7phtdDC7LsU35bJs7fVAAo9+P0iay2ageW7ltVb++r6UoDRUJ+iQyaYt8U5Abl
         lJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqzQB8TU0zGfIa93TNnmYPi07sqP4CGBe1E2pmqvYX4=;
        b=pO0+dCpJ46zk5CbqtEOdmwaZ5hGVzRZAMTQevLexcr8an/ck6TY1ThpGvwIIMivK5Q
         jRwm5Dr+HfK75x4j5ktxm+rL2ed50qfLyXvN4I9exF8ftiE0J38vMBCLBLWg4n8cVjWU
         2ebI1oS/6Eyl/+HDc+jpfFPfVUzfAF15rqJ/RIL0oV0Qydpyx1oFoC7VZ8oMX7r3JMk6
         FMGEY56kvZQRGbwssebbkX7N+RbfcP8fthgLoaUr9/ghn4ejbMfcsDDnK5jdFWbY/V8y
         w2HwiUhYkrWFCneaFVT9s2n6qE/KCyczdFcF5ZlRXaDeCc7fEpLXnNd+WZppbb6qVA94
         P1WA==
X-Gm-Message-State: ANoB5pkl6vAamkttnietH73gr6AWM9kbdAdGD/kvVlpjWGM23s04Eg1h
        uRlKbrLffg5TPst4DLVXe20=
X-Google-Smtp-Source: AA0mqf5HicKiWNR7PXFSJbGRfQumgzIaobqjaQy66Kg6o7Mk25VyF/sYgMc3puIZ3JkWiB1kwQFTfg==
X-Received: by 2002:a05:600c:6007:b0:3cf:681a:43e1 with SMTP id az7-20020a05600c600700b003cf681a43e1mr1312440wmb.126.1668516115105;
        Tue, 15 Nov 2022 04:41:55 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:d94a:6345:c378:e255])
        by smtp.gmail.com with ESMTPSA id iz7-20020a05600c554700b003cf894dbc4fsm15737842wmb.25.2022.11.15.04.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:41:54 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/Five SoC
Date:   Tue, 15 Nov 2022 12:41:28 +0000
Message-Id: <20221115124128.1183144-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The ADC block on the RZ/Five SoC is identical to one found on the RZ/G2UL
SoC. "renesas,r9a07g043-adc" compatible string will be used on the RZ/Five
SoC so to make this clear, update the comment to include RZ/Five SoC.

No driver changes are required as generic compatible string
"renesas,rzg2l-adc" will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
index 61c6157cf5a9..8b743742a5f9 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
@@ -19,7 +19,7 @@ properties:
   compatible:
     items:
       - enum:
-          - renesas,r9a07g043-adc   # RZ/G2UL
+          - renesas,r9a07g043-adc   # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-adc   # RZ/G2L
           - renesas,r9a07g054-adc   # RZ/V2L
       - const: renesas,rzg2l-adc
-- 
2.25.1

