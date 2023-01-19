Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C5D672FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 04:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjASDvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 22:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjASDmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:42:07 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755424B4BC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:40:26 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 36so499064pgp.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zmaGlRv0dSbHKLAvH6Xbn1IwDGJLCQgM3m75kMGlPTg=;
        b=o/P1eqJpVBM/pBnCkOovaH3//MBsk8m9xiVa1ycjEfV0L/HDGPPLKmYoQlzh5gINX5
         vK4louBUFwxvS98lIcFDQ0Pxn0FA5/x8V25E9hbw1W46n33/gLdqP6BcU1K9dDKE/pd0
         jQ/gPjir05Ojl8cdOoC5NlWHomZtroZjLIgV1anIAc9YQVE+qaZ55IXofRXoPVyJXjGu
         B/wBq9uXe6/lHMR6Pv294SHmHHJOSeBiMNKQUi8J0uS9ldxp55WIoAmwTU+zVocU1wMY
         9ih1/JZENnal9UG3oe2Dln6td9MrvEnRPgP+oNRmDT+QvoiXeuTLEosm1RtVSgejjM28
         tgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmaGlRv0dSbHKLAvH6Xbn1IwDGJLCQgM3m75kMGlPTg=;
        b=i7yvRVLx1BpRCIfi3cUnjbDcHGG/naUwnz7eG0vSMw56s1/wU6rsXiCaWfhZhCAFbT
         u9seOLVhCJ09cQQPK89WU4EAXsBLyIrC8w6ttAuSfiVAXTh0DvmTCCnI47EqznGHfFgE
         +fP09QLUME2+wt/nWEtgWXvoaxYSHbsyMrU9B64YqLvAPt3tKJdZdONwGRW1Mt2i1VMv
         Kl48OiSqeqzqKZTsAe2DsFq1nMOkV9GfPLltPx6CKIj3jBEED8ExSW+93oN1HXmt0j+X
         dJwvqgWApQw6Xqe5h7b6f6/Re9UmoYAFvuTayIAJc+rGbOqy5ujbYWy3CvGrkcw01UCN
         VMnw==
X-Gm-Message-State: AFqh2krNe1qfygPCX+V83K3/Mi2uy1P8HT8C420RzsglWsVQ+07/FM2A
        YTL/xbaDqiHv5A9o5eq91Hg3Ug==
X-Google-Smtp-Source: AMrXdXst8z0mNuKtmJ7RHKFy/x3tCvCjbWe18XjiFGY+ezd9zRK9F86OhBpcSj14tGqfKHOeW4bV/A==
X-Received: by 2002:aa7:8006:0:b0:58b:cacd:2d12 with SMTP id j6-20020aa78006000000b0058bcacd2d12mr9254828pfi.28.1674099625750;
        Wed, 18 Jan 2023 19:40:25 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:40:25 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
X-Google-Original-From: Brad Larson <blarson@amd.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, blarson@amd.com, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 06/15] dt-bindings: mfd: amd,pensando-elbasr: Add AMD Pensando System Resource chip
Date:   Wed, 18 Jan 2023 19:39:09 -0800
Message-Id: <20230119033918.44117-7-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119033918.44117-1-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the AMD Pensando SoC System Resource chip using the
SPI interface.  The device functions are accessed using four
chip-selects.  This device is present for all Pensando SoC designs.

Signed-off-by: Brad Larson <blarson@amd.com>
---

Changes since v6:
- Instead of four nodes, one per chip-select, a single
  node is used with reset-cells in the parent.
- No MFD API is used anymore in the driver so it made
  sense to move this to drivers/spi.
- This driver is common for all Pensando SoC based designs
  so changed the name to pensando-sr.c to not make it Elba
  SoC specific.
- Added property cs for the chip-select number which is used
  by the driver to create /dev/pensr0.<cs> 

---
 .../bindings/spi/amd,pensando-sr.yaml         | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml

diff --git a/Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml b/Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml
new file mode 100644
index 000000000000..8504652f6e19
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/amd,pensando-sr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando SoC Resource Controller
+
+description: |
+  AMD Pensando SoC Resource Controller is a set of
+  control/status registers accessed on four chip-selects.
+  This device is present in all Pensando SoC based designs.
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - amd,pensando-sr
+
+  reg:
+    minItems: 1
+
+  cs:
+    minItems: 1
+    maxItems: 4
+    description:
+      Device chip select
+
+  '#reset-cells':
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+required:
+  - compatible
+  - cs
+  - spi-max-frequency
+  - '#reset-cells'
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
+            compatible = "amd,pensando-sr";
+            reg = <0>;
+            cs = <0 1 2 3>;
+            spi-max-frequency = <12000000>;
+            interrupt-parent = <&porta>;
+            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+            #reset-cells = <1>;
+        };
+    };
+
+...
-- 
2.17.1

