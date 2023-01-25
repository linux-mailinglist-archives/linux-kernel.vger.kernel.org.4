Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB6667BFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbjAYWPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbjAYWP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:15:27 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF4D539AE;
        Wed, 25 Jan 2023 14:15:11 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id r205so17584166oib.9;
        Wed, 25 Jan 2023 14:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kydHOHkThzfzSizXqfzXyfgrYoMvHOc1f6KQpnoHeQ=;
        b=sgNZ52Frs/+AWFjCl3Sl3cKCBDxw51xeCBg1TYkEw5qgAg1OEmCN99Q3Z2cYg9q9ZY
         cO36b/58EJYchQ/5d3FEhuO8D1bhfZ/35tT3oj2KKmPaTHLf5Jnp0LEu6GzXjuRBz49S
         V1PNSwYvv3u4LXqZq6kTF3XC3v68cWfV+uvYk90AI5ZBPKYERz1K7BskMrlO7qPkWqJ7
         3Csze72rx9VwVuSQcAi5Fm9JMNjV7j8zFGlHZjWSNy1w+Lmg8WyX3rLxJb7gEaKd9e8R
         njuWs/1y777eLu7G1ySAbB1ZUTKYJQnkgPEt6NAz6XUrbBkK553cLKsDQ+jhz2cVrEc1
         nskA==
X-Gm-Message-State: AFqh2kpe7eE5rQO3uYbvrA3wl09Uew0gYXsZrhnkDUyFLHZMWHIKhFCe
        qGRJT9pFoedLFRfcCgtI5O3A2TafaA==
X-Google-Smtp-Source: AMrXdXs+xVFknktnwQ/X2fhJYY9w2i57AG8ouSZRbk1qwnBjZgoC3O9AZfv0gwb43xIMGS0zp3OxoQ==
X-Received: by 2002:aca:120a:0:b0:35e:a9d4:30d6 with SMTP id 10-20020aca120a000000b0035ea9d430d6mr27027785ois.44.1674684910602;
        Wed, 25 Jan 2023 14:15:10 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g1-20020a9d5f81000000b0068687c98725sm2667212oti.62.2023.01.25.14.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 14:15:10 -0800 (PST)
Received: (nullmailer pid 3059134 invoked by uid 1000);
        Wed, 25 Jan 2023 22:15:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <devicetree-spec@vger.kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: reserved-memory: Refine 'size' and 'alignment' types
Date:   Wed, 25 Jan 2023 16:14:50 -0600
Message-Id: <20230125221450.3058762-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both 'size' and 'alignment' are single values, but can be 32 or 64 bits.
Use the precise types rather than the 2 32-bit cell encoding.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/reserved-memory/reserved-memory.yaml    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
index 44f72bcf1782..b205215b130d 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
@@ -31,17 +31,17 @@ properties:
   reg: true
 
   size:
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-    minItems: 1
-    maxItems: 2
+    oneOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - $ref: /schemas/types.yaml#/definitions/uint64
     description: >
       Length based on parent's \#size-cells. Size in bytes of memory to
       reserve.
 
   alignment:
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-    minItems: 1
-    maxItems: 2
+    oneOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - $ref: /schemas/types.yaml#/definitions/uint64
     description: >
       Length based on parent's \#size-cells. Address boundary for
       alignment of allocation.
-- 
2.39.0

