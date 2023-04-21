Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130D06EAA93
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjDUMmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjDUMmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:42:22 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA4C10240;
        Fri, 21 Apr 2023 05:41:47 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id AE9A740007;
        Fri, 21 Apr 2023 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682080904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eNsCq0s00cdcExGMd2Rls3HSwLDqQCPjKQ7JzV6nFDI=;
        b=QClt+BCDWwhb08qssJkO5Mnz+mTsc0qr/vnqlDJjJEEnPe741wrKNRdxSsaP97cjKQTq8k
        V/t7Ho58TgZ/3/rfOvyfx2K2zkrC2idEVmE770AjuXb762FnlLP9MAkTTviN5KZagfNwAN
        oK/4u1tuS1uddfmahTeg3M9d4IGuyEO6ORp5N2H3V+c/xyAAJAakmemGJQWLKhzwP5Nj2A
        r0/rkKgSUcWd9noVnD5iPj5ExEAS+Obu6XGQxQyMI2zzCgglewV1/4fBWnR8hpL4Sfb89t
        8QMtFhBIq0TcfacVoQzq9qX3RRkxehIi/xuD2p8Anq0GkyVxQaCQhDSjBum9iw==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 1/4] dt-bindings: sound: Add simple-iio-aux
Date:   Fri, 21 Apr 2023 14:41:19 +0200
Message-Id: <20230421124122.324820-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421124122.324820-1-herve.codina@bootlin.com>
References: <20230421124122.324820-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Industrial I/O devices can be present in the audio path.
These devices needs to be viewed as audio components in order to be
fully integrated in the audio path.

simple-iio-aux allows to consider these Industrial I/O devices as
auxliary audio devices.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/sound/simple-iio-aux.yaml        | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/simple-iio-aux.yaml

diff --git a/Documentation/devicetree/bindings/sound/simple-iio-aux.yaml b/Documentation/devicetree/bindings/sound/simple-iio-aux.yaml
new file mode 100644
index 000000000000..fab128fce4fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/simple-iio-aux.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/simple-iio-aux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Simple IIO auxiliary
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description: |
+  Auxiliary device based on Industrial I/O device channels
+
+allOf:
+  - $ref: /schemas/iio/iio-consumer.yaml
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: simple-iio-aux
+
+  io-channels:
+    description:
+      Industrial I/O device channels used
+
+  io-channel-names:
+    description:
+      Industrial I/O channel names related to io-channels.
+      These names are used to provides sound controls, widgets and routes names.
+
+  invert:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      A list of 0/1 flags defining whether or not the related channel is
+      inverted
+    items:
+      enum: [0, 1]
+      default: 0
+      description: |
+        Invert the sound control value compared to the IIO channel raw value.
+          - 1: The related sound control value is inverted meaning that the
+               minimum sound control value correspond to the maximum IIO channel
+               raw value and the maximum sound control value correspond to the
+               minimum IIO channel raw value.
+          - 0: The related sound control value is not inverted meaning that the
+               minimum (resp maximum) sound control value correspond to the
+               minimum (resp maximum) IIO channel raw value.
+
+required:
+  - compatible
+  - io-channels
+  - io-channel-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    aux {
+        compatible = "simple-iio-aux";
+        io-channels = <&iio 0>, <&iio 1>, <&iio 2>, <&iio 3>;
+        io-channel-names = "CH0", "CH1", "CH2", "CH3";
+        /* Invert CH1 and CH2 */
+        invert = <0 1 1>;
+    };
-- 
2.39.2

