Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A9773EE29
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjFZWBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjFZWAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:00:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68A359CC;
        Mon, 26 Jun 2023 14:56:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so5223944e87.2;
        Mon, 26 Jun 2023 14:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687816508; x=1690408508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xeTVPn3rI6euHlbfgKeZisbySltCuL+CYAo/n2Br8P4=;
        b=suUjawGReGtdeF23f7YxHAxxvx4UBYVRPpQjYSoxEAXAy/DPD5nCmlYvmlDHJnvDRn
         GZxk2LxL4M3ni62ERZ//rbCu4NxTOHD/tWeJbDG0Bf16zkgrQBNW9E98g9M2yHUdaAXa
         LWA1vl1sG0/X34MirJDAfT6RrX8li1BBmu1Jtk6Ytmhij2CULYz8iyE9N8f5+Hn8Tq7c
         DgmsMyPJMSWv/azjQDRs2ieS6qcziGK0lE2RsbAhfBebM30RY1D5FD1BWZE3jJcypEhM
         lYEAXEDJ2YjDPCgo8Lf0uSH0lDIQV43dV674hMxVR+h6GtqyG77SARE/k42R730slaZS
         p8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687816508; x=1690408508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeTVPn3rI6euHlbfgKeZisbySltCuL+CYAo/n2Br8P4=;
        b=VXSkwoAsrsB+CxZ9KRUMJQqakrjILgNWDNwOGeeqDlzw3YsNEcwDevA9lxUWlXgGL5
         aoNiLpLCCO1aFh9UTg90gSmE5wtB5L9tcyLduafBonAlv0wF5KBjnTsavS0LWCSV3WY8
         FGURXGgCa6Q5Yy6yC1M+kC56WdxKL6mqY71xv6vqucFbYVVv/W4Lsv0GzxwTq76tcNRv
         HBUqXlR2h4Vj75X5n+uxI4U/Jrdgf31Fw0oyNmg+7iRwU654pnCNoQAIn+wMnAo8RYQV
         4IpuWhJ+JOpd3h6xD4vyC+j0J0tYMQAOpEdHz7sIaMOd21hK7JRtL8o/X8hW7GDvTEBb
         AirQ==
X-Gm-Message-State: AC+VfDw+eKcJCNPHeZ2PQFcqyPqMJP6DVrDedzCtEue4kwQ2ILm3/2YS
        XHNMlQdzcS6IMtq6wZaB1Kg=
X-Google-Smtp-Source: ACHHUZ7ACBYjcKdK/Hp0kN+8eoP8jLQOTZ8r0wVecCSNchgJEcJQ/kGsLBF8Zs+uJImWGR2MyWT1iw==
X-Received: by 2002:a05:6512:3f05:b0:4fb:752c:3240 with SMTP id y5-20020a0565123f0500b004fb752c3240mr2276537lfa.68.1687816508041;
        Mon, 26 Jun 2023 14:55:08 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id x20-20020a19f614000000b004f840965b51sm1272837lfe.148.2023.06.26.14.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 14:55:07 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3] dt-bindings: nvmem: fixed-cell: add compatible for MAC cells
Date:   Mon, 26 Jun 2023 23:54:50 +0200
Message-Id: <20230626215450.30573-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

A lot of home routers have NVMEM fixed cells containing MAC address that
need some further processing. In ~99% cases MAC needs to be:
1. Optionally parsed from ASCII format
2. Increased by a vendor-picked value

There was already an attempt to design a binding for that at NVMEM
device level in the past. It wasn't accepted though as it didn't really
fit NVMEM device layer.

The introduction of NVMEM fixed-cells layout seems to be an opportunity
to provide a relevant binding in a clean way.

This commit adds a *generic* compatible string: "mac-base". As always it
needs to be carefully reviewed.

OpenWrt project currently supports ~300 home routers that have NVMEM
cell with binary-stored base MAC.T hose devices are manufactured by
multiple vendors. There are TP-Link devices (76 of them), Netgear (19),
D-Link (11), OpenMesh (9), EnGenius (8), GL.iNet (8), ZTE (7),
Xiaomi (5), Ubiquiti (6) and more. Those devices don't share an
architecture or SoC.

Another 200 devices have base MAC stored in an ASCII format (not all
those devices have been converted to DT though).

It would be impractical to provide unique "compatible" strings for NVMEM
layouts of all those devices. It seems like a valid case for allowing a
generic binding instead. Even if this binding will not be sufficient for
some further devices it seems to be useful enough as it is.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Drop "mac-ascii" as length can be checked instead
    Fix "allOf" by adding required: [ compatible ]
V3: Fix cell length in "description" (thank you Rob!)
---
 .../bindings/nvmem/layouts/fixed-cell.yaml    | 26 +++++++++++++++++++
 .../bindings/nvmem/layouts/fixed-layout.yaml  | 12 +++++++++
 .../devicetree/bindings/nvmem/nvmem.yaml      |  5 +++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
index e698098450e1..ac2381e66027 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
@@ -11,6 +11,15 @@ maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 properties:
+  compatible:
+    oneOf:
+      - const: mac-base
+        description: >
+          Cell with base MAC address to be used for calculating extra relative
+          addresses.
+          It can be stored in a plain binary format (cell length 6) or as an
+          ASCII text like "00:11:22:33:44:55" (cell length 17).
+
   reg:
     maxItems: 1
 
@@ -25,6 +34,23 @@ properties:
         description:
           Size in bit within the address range specified by reg.
 
+allOf:
+  - if:
+      required: [ compatible ]
+    then:
+      if:
+        properties:
+          compatible:
+            contains:
+              const: mac-base
+      then:
+        properties:
+          "#nvmem-cell-cells":
+            description: The first argument is a MAC address offset.
+            const: 1
+        required:
+          - "#nvmem-cell-cells"
+
 required:
   - reg
 
diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
index c271537d0714..b3a09e8864f1 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
@@ -44,6 +44,18 @@ examples:
         #address-cells = <1>;
         #size-cells = <1>;
 
+        mac@100 {
+            compatible = "mac-base";
+            reg = <0x100 0xc>;
+            #nvmem-cell-cells = <1>;
+        };
+
+        mac@110 {
+            compatible = "mac-base";
+            reg = <0x110 0x11>;
+            #nvmem-cell-cells = <1>;
+        };
+
         calibration@4000 {
             reg = <0x4000 0x100>;
         };
diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 980244100690..9f921d940142 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -49,7 +49,10 @@ properties:
 patternProperties:
   "@[0-9a-f]+(,[0-7])?$":
     type: object
-    $ref: layouts/fixed-cell.yaml
+    allOf:
+      - $ref: layouts/fixed-cell.yaml
+      - properties:
+          compatible: false
     deprecated: true
 
 additionalProperties: true
-- 
2.35.3

