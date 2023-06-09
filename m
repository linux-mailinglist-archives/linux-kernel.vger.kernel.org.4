Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F3572A6D3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjFIXpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjFIXpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:45:11 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B9A3596;
        Fri,  9 Jun 2023 16:45:10 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso1221904a12.1;
        Fri, 09 Jun 2023 16:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686354309; x=1688946309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U4ehiGM/N7IXBZEtRKRapAz9F/jIXPptAjEznsjwM+s=;
        b=Jk555CdL38vJVMgFi47XXE76SZ/mPxkTZqf099CNJxsMmgJ77M9MxzFloXpK9LhWHx
         QxWb27wiCeA3Q0pijWzW2WSACVVdszReILoPyGTReXSOoZFBdN0YcmEhJ+AQ16SaUWAT
         /swLeV+E3dDLYQwrRTfu6E+i8XXpqh30lbfsFTCPuPfjzov6lniKlfMRnAjFuHYj0EOE
         7WRFGlLRUp8Y0aL+AJdLDAOIC+yQKwp6mYjdRs2ix3k/8IhCDmd1JdlnKf6Zf6iow/Ss
         guPT6oJuEb1oE3rm8lSUJsz07e4G6fWsBTwCG0oYbawpcyOZ6wxPxZiPWgBY2ktXRWgj
         Zxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686354309; x=1688946309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4ehiGM/N7IXBZEtRKRapAz9F/jIXPptAjEznsjwM+s=;
        b=V8lzgoKFF1zbeqYZxLUvOOCDYX0vHUOIh0pwxAIoOm/hTnG4UpemW8x+kAtQ2wFnmV
         JbgRKaWCiELNrZUWtXmFgYFQ4iS9paZS7A6eqtnmb5qKlp6SyuF1AeN/T0Wmhx3rYh9v
         mmiCm2w9S5ngWe245pJ+jRyVcuA4J8wr0JApoA6ZUog8ITfMmmgKF0s6rTw073iA4ZVy
         dBZngJZaVDy6Srux+woEIMEYg0FMwN4Dmah1PmpaqHkooQALTSCfJA4czNy3eSd+DQC3
         yNsS9Dv01YIiYcWI/ifL1ujrFRoZVbpsHwqYTxc72/bzjq3CyVHmoyL0zAn9QIqvrN3E
         3oiQ==
X-Gm-Message-State: AC+VfDwZOB/3h5UiKFq1MzZJhF5LfL723903EB19MVZ5vo0nrC+4Z7p8
        W+8tEy0QH5w7Nmn5FvCBFh8=
X-Google-Smtp-Source: ACHHUZ6ik9KXbeoq6kHXhbkYGgL30azjGKOjOQCW0jlcFkK68I/dpIR4ErS1/f7CU9eHrpKz48Khmg==
X-Received: by 2002:a17:903:22c6:b0:1b3:7de7:f845 with SMTP id y6-20020a17090322c600b001b37de7f845mr360467plg.23.1686354309630;
        Fri, 09 Jun 2023 16:45:09 -0700 (PDT)
Received: from ryan-ThinkPad-T470.. (c-24-6-63-212.hsd1.ca.comcast.net. [24.6.63.212])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902ba8900b001a5260a6e6csm3755473pls.206.2023.06.09.16.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 16:45:09 -0700 (PDT)
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
Subject: [PATCH V2 1/2] ASoC: dt-bindings: max98388: add amplifier driver
Date:   Fri,  9 Jun 2023 16:44:16 -0700
Message-Id: <20230609234417.1139839-1-ryan.lee.analog@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Lee <ryans.lee@analog.com>

Add dt-bindings information for Analog Devices MAX98388 I2S Amplifier

Signed-off-by: Ryan Lee <ryans.lee@analog.com>
---
Changes from v1:
  Removed unnecessary blank line and description. Modified quotes.

 .../bindings/sound/adi,max98388.yaml          | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,max98388.yaml

diff --git a/Documentation/devicetree/bindings/sound/adi,max98388.yaml b/Documentation/devicetree/bindings/sound/adi,max98388.yaml
new file mode 100644
index 000000000000..93ccd5905736
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
+
+  reg:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+  adi,vmon-slot-no:
+    description: slot number of the voltage feedback monitor
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  adi,imon-slot-no:
+    description: slot number of the current feedback monitor
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+  - '#sound-dai-cells'
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

base-commit: 53ab6975c12d1ad86c599a8927e8c698b144d669
-- 
2.34.1

