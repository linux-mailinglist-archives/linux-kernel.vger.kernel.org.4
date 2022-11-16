Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101BC62C915
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiKPTjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiKPTjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:39:48 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4101ECDD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:39:47 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id v3so17660402pgh.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TYG9zd1SkfmMYicbzm8Ol8B8CN6QOjjc2uOytgz/8Xs=;
        b=UlYgZ/EzU9GVL7Uh/9ksDCzs5d3bvFSgcvFRNGw6NqEaTwt2lWJJ59YkRZl82XuKyE
         kmds1haWzWCAiHnomQk3Q615/xBXQlkhLLus966tJQSwIkpLKgq/W6YRv753D/sbTvbK
         RPVhxmpP/JmOh5qUMcjtNJPYmDGA9XcCP2hGdlcT9v1ninKb857HTsfzjjZ1SgMo/fz+
         ooTn1yKJSxeq0JmpvwmZIFDL+pXmaQs5Ue3NeYz+JH8PmKRs584ieAVuAos2vmRaKHdM
         /guVwC9x/I/Masy8tdofgr5WiW7vfOG7rUP5EMbyf7U9oTcYWgPBryHfh0pe6q8EnPGP
         97lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYG9zd1SkfmMYicbzm8Ol8B8CN6QOjjc2uOytgz/8Xs=;
        b=QBKN418u2wxYPx5SgI1spYkvPfVZUsAO94aYF1feh/ycqBVwpByZlE/x31TsGurIoN
         BMYRCSGmbqmLgWMPWx2Jpi+VyzKwWQI+Fa5FAcmdBU+jwnLKU+SUZUNKnfbSmyoD8v4K
         osmqutHN09WmX7/zGNfL4IoSVgR34D96Anz/skGtsFTgObDaWD2yijbGGFWIPj/wiaDA
         Rlyn7/9QBfWfHaH1O8pfuZzbuxmKPxtBdnsTX+WLkQMYHe7bAr1a33gSwT4id1t5JLt/
         kPFA9lWf3a28RUogiJ+Yryzv2mgNWwS9hjNVwo9c52/2hmkmnfHJcBenu9D23mfu6omD
         +k3A==
X-Gm-Message-State: ANoB5pnJHF5vp0LBnqshELzJJ5Wf8p+4QRqwiHCy+VebkwnbAojs1BuV
        MS9LcZMlI+Oy9+bgdqeczRkwOA==
X-Google-Smtp-Source: AA0mqf5sMpU2cMuunjlhRBO2+RAWdqDpUt2K0HWiDkWR0BGa3tibxSbZPMntL147nciYqsIMM4WEkg==
X-Received: by 2002:a63:62c4:0:b0:476:f43d:ed4f with SMTP id w187-20020a6362c4000000b00476f43ded4fmr2315289pgb.16.1668627586805;
        Wed, 16 Nov 2022 11:39:46 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id b129-20020a62cf87000000b0056bad6ff1b8sm11211536pfg.101.2022.11.16.11.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:39:46 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
X-Google-Original-From: Brad Larson <blarson@amd.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, blarson@amd.com,
        brad@pensando.io, brijeshkumar.singh@amd.com, broonie@kernel.org,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        fancer.lancer@gmail.com, gerg@linux-m68k.org, gsomlo@gmail.com,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        p.yadav@ti.com, p.zabel@pengutronix.de, piotrs@cadence.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org,
        yamada.masahiro@socionext.com
Subject: [PATCH v8 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD Pensando Elba System Resource chip
Date:   Wed, 16 Nov 2022 11:39:40 -0800
Message-Id: <20221116193940.67445-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <e9d8c14d-38b3-0401-7bfc-b2bd7ab36c52@linaro.org>
References: <e9d8c14d-38b3-0401-7bfc-b2bd7ab36c52@linaro.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the AMD Pensando Elba SoC System Resource chip
using the SPI interface.

Signed-off-by: Brad Larson <blarson@amd.com>
---

v8:
 - Apply review request changes and picked the two unique examples
   for the 4 chip-selects as one has the reset control support and
   the other an interrupt.  Missed the --in-reply-to in git
   send-email for v7, included in this update.

v7:
 - Use system-controller for the device with four chip-selects
   connected over spi.
 - Delete child by moving reset-controller into the parent.
 - Updated and used dtschema-2022.11 and yamllint-1.28.0

v6:
 - Expand description, rename nodes and change compatible usage

v5:
 - Change to AMD Pensando instead of Pensando

v4:
 - Change Maintained to Supported

 .../bindings/mfd/amd,pensando-elbasr.yaml     | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml

diff --git a/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
new file mode 100644
index 000000000000..622c93402a86
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/amd,pensando-elbasr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando Elba SoC Resource Controller
+
+description: |
+  AMD Pensando Elba SoC Resource Controller functions are
+  accessed with four chip-selects.  Reset control is on CS0.
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  compatible:
+    enum:
+      - amd,pensando-elbasr
+
+  "#reset-cells":
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        num-cs = <4>;
+
+        system-controller@0 {
+            compatible = "amd,pensando-elbasr";
+            reg = <0>;
+            spi-max-frequency = <12000000>;
+            #reset-cells = <1>;
+        };
+
+        system-controller@2 {
+            compatible = "amd,pensando-elbasr";
+            reg = <2>;
+            spi-max-frequency = <12000000>;
+            interrupt-parent = <&porta>;
+            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
-- 
2.17.1

