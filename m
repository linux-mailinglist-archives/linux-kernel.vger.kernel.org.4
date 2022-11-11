Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91111626388
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiKKV2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiKKV2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:28:38 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D49B65B1;
        Fri, 11 Nov 2022 13:28:37 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id s206so6061017oie.3;
        Fri, 11 Nov 2022 13:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yofEEgISmTkFd8KNSd67teL9O9R9Xx2fbkwmtcfVezs=;
        b=WYQkfBxq8EZwV+i0hjBrh62vkf8DjdRN92Vg3SdEnQkLhEROs1MeawGc/otL+08M+p
         XHcUoCd2i99JrTwLTp8F8o+VHm17VrpUpCpdVtHDFYdYNDefwqhI5Liczvgk473msud6
         nAAtnUzQCVqPTpHwVIbCjxy4Mb2WIT2VJWgTdvrvgh9M2ARZFWRPUt900lgWly2rxAcq
         gHuVX68Z3Naip2fz+SdFbgZ+1SN33SaAVT8ly/eqibqhDADSB8MDaTUdqhWgJcCqCiwc
         6lsbgPb6imle8pqF3FbHFCOmDZUqwrr3cOxCa7eTbgyzfYjBJ/w5XFK8UE4UA5XH4IGx
         e25A==
X-Gm-Message-State: ANoB5pnOgX1vTOx4UJxQIC4rJMOs0U+C0lapHRMdata4Hxkbn2noRaie
        4vLTLokov3eFdxCv4HiaRw==
X-Google-Smtp-Source: AA0mqf790Zmp5a1ld1rmeQNI84Xp4grv4h7heGc1cG9c8BZByd09XHvvxMJ3yRdHJgda9B+Ui/VlLg==
X-Received: by 2002:aca:210d:0:b0:342:ff90:1867 with SMTP id 13-20020aca210d000000b00342ff901867mr1692144oiz.297.1668202114153;
        Fri, 11 Nov 2022 13:28:34 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f7-20020a9d2c07000000b00660e833baddsm1432403otb.29.2022.11.11.13.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:28:33 -0800 (PST)
Received: (nullmailer pid 4103770 invoked by uid 1000);
        Fri, 11 Nov 2022 21:28:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Mikhail Zhilkin <csharper2005@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mtd: fixed-partitions: Fix 'sercomm,scpart-id' schema
Date:   Fri, 11 Nov 2022 15:28:24 -0600
Message-Id: <20221111212824.4103514-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The schema for 'sercomm,scpart-id' is broken. The 'if' condition is
never true because 'compatible' is in the parent node, not the child
node the sub-schema applies to. The example passes as there are no
constraints on additional/unevaluated properties. That's a secondary
issue which is complicated due to nested partitions.

Drop the if/then schema and the unnecessary 'allOf' so that the
'sercomm,scpart-id' property is at least defined.

Cc: Mikhail Zhilkin <csharper2005@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../mtd/partitions/fixed-partitions.yaml      | 29 +++++++------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index ad3ccd250802..39b715aad2dc 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -31,24 +31,17 @@ properties:
 
 patternProperties:
   "@[0-9a-f]+$":
-    allOf:
-      - $ref: "partition.yaml#"
-      - if:
-          properties:
-            compatible:
-              contains:
-                const: sercomm,sc-partitions
-        then:
-          properties:
-            sercomm,scpart-id:
-              description: Partition id in Sercomm partition map. Mtd
-                parser uses this id to find a record in the partition map
-                containing offset and size of the current partition. The
-                values from partition map overrides partition offset and
-                size defined in reg property of the dts. Frequently these
-                values are the same, but may differ if device has bad
-                eraseblocks on a flash.
-              $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: partition.yaml#
+
+    properties:
+      sercomm,scpart-id:
+        description: Partition id in Sercomm partition map. Mtd parser
+          uses this id to find a record in the partition map containing
+          offset and size of the current partition. The values from
+          partition map overrides partition offset and size defined in
+          reg property of the dts. Frequently these values are the same,
+          but may differ if device has bad eraseblocks on a flash.
+        $ref: /schemas/types.yaml#/definitions/uint32
 
 required:
   - "#address-cells"
-- 
2.35.1

