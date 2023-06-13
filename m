Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641FE72D9AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbjFMGKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbjFMGJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:09:56 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7570A0;
        Mon, 12 Jun 2023 23:09:54 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b29b9f5a94so3241566a34.2;
        Mon, 12 Jun 2023 23:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686636594; x=1689228594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qfxDffF4oNGyONCr8odOKoLiVtDni1HDTuQoeb5CKkQ=;
        b=nE3DWJTG1S8ILTVBQZA4FulsRGkRjuh11xmjDFgLfoeU3GEweKE/gkze/JXQEVpk9I
         XcJLGi0RGkGvFAR2WaXVg8qDHD+UHbHIvIzOIqCK80liNco8SkmDXcOLlrS7FE7lLMJf
         lwEYjWiM9Am0rWckiGV75z6OnQutWKUNiXPim9WUEUNhxIJLsT4XPUvTiGzP3+eWTL/+
         gV2Pg5AKhejEwCr8dTNoM6eS7m2rFFv6/JUs8MzrLcoFsaAF8eiombyxAkg/I99g/lx1
         K8wtgE6Sx8MBnUGiH0CVWJeN8CTOylpLQxA9GnqF1f0DC3zg/bgamlXCi7CIvvJec1f/
         RuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686636594; x=1689228594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfxDffF4oNGyONCr8odOKoLiVtDni1HDTuQoeb5CKkQ=;
        b=M//nvPTTQT+qRHytQDJU4NWPTZZ4KwWr/YUfHqEGjxY9VnH5pWAggI1H+U11IQAEdY
         QqY24ee9KvdAkoLMZ1muAruyQrnFX280Seuu2C5jUvDA932XuKRtVZHEek6YrzUf+Z0O
         cJYcqJ8gdH8QeiN0wcsGtpcvUtm3aspThgv7WRgzUWwxu0Q37HUys+CiOCignGYlpXnu
         4BKm+BH3Mj06d2aGTRF1LCJ3uKQHroYIcGhaVUWTS8GkRyrfK9kanexRdbOrHhedJKAN
         zV/EYVRULwOCZIxLDUJDuOiOjubsJwUt1whDf7t+5d4NNXpc/oVj3FndWVPCrAzMsdki
         mDlw==
X-Gm-Message-State: AC+VfDyaeToypLiFokqFlykBca0x34ExvodF/pSLq2vDM6iKpysDlWZA
        j+2TtLpVopZ60jdfl51Wbzg=
X-Google-Smtp-Source: ACHHUZ6YSgQn2bvL4KlRa71K1UtlgfkoGdUXnp2n8S1QyTy7AbJT22tja7f24hm3x7iAgfzub3tbOw==
X-Received: by 2002:a05:6830:1d6d:b0:6b3:477c:c725 with SMTP id l13-20020a0568301d6d00b006b3477cc725mr1662298oti.12.1686636594085;
        Mon, 12 Jun 2023 23:09:54 -0700 (PDT)
Received: from ryan-ThinkPad-T470.. (c-24-6-63-212.hsd1.ca.comcast.net. [24.6.63.212])
        by smtp.gmail.com with ESMTPSA id z17-20020a631911000000b00548fb73874asm7009529pgl.37.2023.06.12.23.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 23:09:53 -0700 (PDT)
From:   =?UTF-8?q?=E2=80=9CRyan?= <ryan.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        shumingf@realtek.com, povik+lin@cutebit.org,
        herve.codina@bootlin.com, ryans.lee@analog.com,
        wangweidong.a@awinic.com, ckeepax@opensource.cirrus.com,
        ajye_huang@compal.corp-partner.google.com,
        sebastian.reichel@collabora.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     venkataprasad.potturu@amd.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 1/2] ASoC: dt-bindings: max98388: add amplifier driver
Date:   Mon, 12 Jun 2023 23:09:44 -0700
Message-Id: <20230613060945.183128-1-ryan.lee.analog@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes from v1:
  Removed unnecessary blank line and description. Modified quotes.

Changes from v2:
  No change.  

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

