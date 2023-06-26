Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CAB73DDD1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjFZLhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjFZLhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:37:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624BDA0;
        Mon, 26 Jun 2023 04:37:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb7589b187so1110077e87.1;
        Mon, 26 Jun 2023 04:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687779448; x=1690371448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jHKe5lG5M490XdynJa/tSmNSdNOnKPsg3CzhJJHwz24=;
        b=C5GlRe75uQd4OzstdlmX6YmpNA8Oqp5MN9SMk34uTEBTGxK9CPbEKj8UiayB9vrukO
         Ao4Oq1hg7Qnh7nar2N60o3uP67d8a9SFi2uYTEtrDLHIEy2oB0KhC7yl/M90BRDQxaYj
         wXbQ/Mf8vN8MOXBQmhMcJoGrnklJBtgRF2wFJvS/xX6+0xiWcV7KBQeG6IanSzzF8QcE
         T8G6j1mwMY/TOvItXw0vw+02zHd/9oMkuFEw34mlbAT85W7N1jh/sWmm5DkMg07ATz+Z
         h0MJei/GZ9oUuACNqAYdh4l0mWAQgHoMidtoAPyFUoDTK7uGpPqf6VXL2aJTdeOaX+vi
         pV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687779448; x=1690371448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHKe5lG5M490XdynJa/tSmNSdNOnKPsg3CzhJJHwz24=;
        b=UQK5RmxIszTMc5d5Nh/ZlbHoXWahM8IHIAuJcB76bH07+Es7DYP6UDjAkTG3nfvF2B
         KQlpqKUjt9I1/KgEBMQNy4RTeop056mCu6yWWwMvZuThgPjUgiGA1kPxteVBt9gwan7G
         MzQn4YZ/u7Cza/+pvMJR23mqi+Et7g3FzhZYZ614veKynIKaq1lLLF0whAtXH4MNriFU
         8ctaxZASzmNJZXe6Cjje5/7mU1eagnA8c8RYjf2puhg/qFkdzHyYRu+sesEevjb401dL
         VcPL0C2x2B3jSrhgIlomtGv2Ulaqu2TPJunhfx5rZBjRDnjc6lTCMBGtrR09k02JNZaA
         /Nvg==
X-Gm-Message-State: AC+VfDzKTtiT6/FsZfqF6A5Y82Z39VsecPuY/Xy41XajD8uBxK1/V2Y0
        kq5hzgnD7RySXlKheenHtTk=
X-Google-Smtp-Source: ACHHUZ6Bi52qruhzhSDdUIjI8u9Fo8/QT9NApiTypTcfMPX0B4+OgUL9UMyJRN/uFTg4JMbdA9HUIA==
X-Received: by 2002:a05:6512:23a4:b0:4fb:18f4:4cd4 with SMTP id c36-20020a05651223a400b004fb18f44cd4mr2195631lfv.55.1687779448264;
        Mon, 26 Jun 2023 04:37:28 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id y24-20020ac24478000000b004f64fb058f7sm1064349lfl.225.2023.06.26.04.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 04:37:27 -0700 (PDT)
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
Subject: [PATCH V2] dt-bindings: nvmem: fixed-cell: add compatible for MAC cells
Date:   Mon, 26 Jun 2023 13:37:16 +0200
Message-Id: <20230626113716.17674-1-zajec5@gmail.com>
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
---
 .../bindings/nvmem/layouts/fixed-cell.yaml    | 26 +++++++++++++++++++
 .../bindings/nvmem/layouts/fixed-layout.yaml  | 12 +++++++++
 .../devicetree/bindings/nvmem/nvmem.yaml      |  5 +++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
index e698098450e1..036a9ed88893 100644
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
+          It can be stored in a plain binary format (cell length 12) or as an
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

