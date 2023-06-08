Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493157276D1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 07:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjFHFna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 01:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjFHFn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:43:28 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F752690;
        Wed,  7 Jun 2023 22:43:27 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-777ac4344f9so6293439f.0;
        Wed, 07 Jun 2023 22:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686203006; x=1688795006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XtolSZaJdXUNvdM4Rjo5o9rL0OX1LHOcqWzmGyfnXNs=;
        b=P3Nk1tOCSxsMZ44I2T6MohGzDc4RG3rvbvMb972fw/dJOnk/VR6+0q5BolxNoYwDP5
         y6PoAzcgjbWC1fPMy+yyx3GtPqFVawlkTap4+2zH71s90sfLrI5a5bbHzq6LG96W0jCe
         laqTn8pVRk7AJnC6AvtZSAteNbRLuaZGLQJQt8mekLc86xCPrtQJYSkJqwcWioxsHJ0p
         tKMxymLw5rrrJCehfxqWZtw8uIrIcnqtbGpRx7xgTqlvzXJCy73FF6h6OvhQqHfNeKGg
         IHDDiYcE11j15RaDfeuonTiUVyXi1voTxODhUh0w+n4YmXNUugjqxQrzflo3O3vrLR1w
         wv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686203006; x=1688795006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XtolSZaJdXUNvdM4Rjo5o9rL0OX1LHOcqWzmGyfnXNs=;
        b=G0fX1DEwj4Vp8e3j+1wq3bDArAb+Eh81InapbR/InrCzrYgr8XlL1QcMnTsseinWGN
         qCrOBl4fv7ErzBS3H85npixNzHW4SGQP1klAEAwrtgtVWQ/mWpj4GDMiKnEaPZZL69lq
         dN0JzwOOi6UZEqSx8wVD+ZmH+c4kH+fFK9SEiyugXKfH0DwZn+u/Hw+iKLdV0OwngiJe
         Z0PYyaZo8HDpGDIf7EQK9b99EhP732qxx36Jsv7qzokx9UeQGVbq03p/wHWwrZjdLDur
         grirk2TipTGA8IEu6Mg3gNTIuNjUIuxwssryaSSkgznozAjYhGA2ojJiCbtekv9YAEAN
         4Z6Q==
X-Gm-Message-State: AC+VfDyVJAdwqaUYjbnlGOGlHXjWq3H/+vNbwHogO/RYOgZJ9FmJFJS9
        tvmQPGST6ECIumrwsCw6dRQ=
X-Google-Smtp-Source: ACHHUZ7+bfFyU+fEd9s1V1vdPHDfQF1iA8u1ua3PGiwhj/TUrkLp6wgyS4cycp/OFscGL5El97acMA==
X-Received: by 2002:a92:da0d:0:b0:335:5bb2:6262 with SMTP id z13-20020a92da0d000000b003355bb26262mr7730875ilm.27.1686203006244;
        Wed, 07 Jun 2023 22:43:26 -0700 (PDT)
Received: from ryan-ThinkPad-T470.. (c-24-6-63-212.hsd1.ca.comcast.net. [24.6.63.212])
        by smtp.gmail.com with ESMTPSA id v24-20020a62a518000000b0064d2ad04cbesm249641pfm.209.2023.06.07.22.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 22:43:25 -0700 (PDT)
From:   =?UTF-8?q?=E2=80=9CRyan?= <ryan.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        rf@opensource.cirrus.com, ryans.lee@analog.com,
        wangweidong.a@awinic.com, shumingf@realtek.com,
        herve.codina@bootlin.com, ckeepax@opensource.cirrus.com,
        doug@schmorgal.com, ajye_huang@compal.corp-partner.google.com,
        kiseok.jo@irondevice.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     venkataprasad.potturu@amd.com
Subject: [PATCH 1/2] ASoC: dt-bindings: max98388: add amplifier driver
Date:   Wed,  7 Jun 2023 22:42:29 -0700
Message-Id: <20230608054230.344014-1-ryan.lee.analog@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Lee <ryans.lee@analog.com>

Add dt-bindings information for Analog Devices MAX98388 I2S Amplifier

Signed-off-by: Ryan Lee <ryans.lee@analog.com>
---
 .../bindings/sound/adi,max98388.yaml          | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,max98388.yaml

diff --git a/Documentation/devicetree/bindings/sound/adi,max98388.yaml b/Documentation/devicetree/bindings/sound/adi,max98388.yaml
new file mode 100644
index 000000000000..fc0ac8d8c3ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,max98388.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/adi,max98388.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX98388 Speaker Amplifier
+
+maintainers:
+  - Ryan Lee <ryans.lee@analog.com>
+
+description:
+  The MAX98388 is a mono Class-D speaker amplifier with I/V feedback.
+  The device provides a PCM interface for audio data and a standard
+  I2C interface for control data communication.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,max98388
+  reg:
+    maxItems: 1
+    description: I2C address of the device.
+
+  '#sound-dai-cells':
+    const: 0
+
+  adi,vmon-slot-no:
+    description: slot number of the voltage feedback monitor
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  adi,imon-slot-no:
+    description: slot number of the current feedback monitor
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 15
+    default: 1
+
+  adi,interleave-mode:
+    description:
+      For cases where a single combined channel for the I/V feedback data
+      is not sufficient, the device can also be configured to share
+      a single data output channel on alternating frames.
+      In this configuration, the current and voltage data will be frame
+      interleaved on a single output channel.
+    type: boolean
+
+  reset-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        max98388: amplifier@39 {
+            compatible = "adi,max98388";
+            reg = <0x39>;
+            #sound-dai-cells = <0>;
+            adi,vmon-slot-no = <0>;
+            adi,imon-slot-no = <1>;
+            adi,interleave-mode;
+            reset-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.34.1

