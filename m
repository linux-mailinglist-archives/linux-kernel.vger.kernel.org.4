Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAEB6FCB7F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjEIQjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjEIQjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:39:16 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF0A421F;
        Tue,  9 May 2023 09:39:12 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1683650348; bh=ABTxy/stFVOVt1ZnRJ5L55xUikl5p+QPvUWPKUSFmjk=;
        h=From:To:Cc:Subject:Date;
        b=nhq0S7wCSrUJDK+cnhpl+JVIGu2eawlnCHn/smmgpzByShlV32rpleACMS0RKmBfV
         Ts4/R/5dLoOUeNQA2j/4I295DWWYEyQF/6Y4zTGVYKYciu8dKj9ypXUNR0/+Z3U/A+
         +gj+p/hOcv+IXy6xyDB29PpJ5drijU/wRkOaib2g=
To:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc:     asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: dt-bindings: Add adi,ssm3515 amp schema
Date:   Tue,  9 May 2023 18:38:27 +0200
Message-Id: <20230509163828.86003-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT schema for the SSM3515 amp by Analog Devices. It's a simple
mono amplifier with digital input.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 .../bindings/sound/adi,ssm3515.yaml           | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,ssm3515.yaml

diff --git a/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml b/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
new file mode 100644
index 000000000000..19b7185ae8e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2019-20 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/sound/adi,ssm3515.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Analog Devices SSM3515 Audio Amplifier
+
+maintainers:
+  - Martin Povišer <povik+lin@cutebit.org>
+
+description: |
+  SSM3515 is a mono Class-D audio amplifier with digital input.
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/SSM3515.pdf
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ssm3515
+
+  reg:
+    maxItems: 1
+
+  adi,ana-gain:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    description: |
+      The value to be set in the ANA_GAIN register field on the codec. This determines
+      the full voltage span of the codec's analog output.
+
+      To quote the datasheet on the available options:
+
+        00: 8.4 V Full-Scale Gain Mapping
+        01: 12.6 V Full-Scale Gain Mapping
+        10: 14 V Full-Scale Gain Mapping
+        11: 15 V Full-Scale Gain Mapping
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - adi,ana-gain
+
+additionalProperties: true
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      codec@14 {
+        compatible = "adi,ssm3515";
+        reg = <0x14>;
+        #sound-dai-cells = <0>;
+        adi,ana-gain = <0>;
+        sound-name-prefix = "Left Tweeter";
+      };
+    };
-- 
2.38.3

