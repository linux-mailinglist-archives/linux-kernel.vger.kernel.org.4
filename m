Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C178970DFF6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbjEWPMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbjEWPMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:12:35 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0243BFA;
        Tue, 23 May 2023 08:12:32 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 43971C0002;
        Tue, 23 May 2023 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684854751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyTXVmL/5teIh8xuYTUUi3ltQcCGVDf6AcEbfADS6og=;
        b=lWPvq8cHwMHdAVLda4Fk0kYQp99VhMod7NzwHN7h56uzv3+/D0DlZbDz13zNPwM2YrzGCd
        OtRfdXy/i4wOdaa6ba+WNUEAuFl9vAZ1Pe4xzCgsOBnWQKGu7uESCYVfm0DyEF8/7ELdGf
        tlRHgkS3twGReZMKIDkZLvLssgthcUV3phHWcU0gTfeek7p2DVaVJjFOcaaVQzpKazHq1U
        sOVJ3/gP1i/mOimYgjbGMqJB6pWCiQkyKxmyB98bChgTXQnW4StIpZ3Mlxp6Hv/Q7MipUZ
        8xuXSd1oGp8rjcWTT4Nj0FajGz9JkgIri0PP+quO25k8G/bMyJAD0+O4P/fo6w==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 1/9] ASoC: dt-bindings: Add audio-iio-aux
Date:   Tue, 23 May 2023 17:12:15 +0200
Message-Id: <20230523151223.109551-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523151223.109551-1-herve.codina@bootlin.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Industrial I/O devices can be present in the audio path.
These devices needs to be viewed as audio components in order to be
fully integrated in the audio path.

audio-iio-aux allows to consider these Industrial I/O devices as
auxliary audio devices.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/sound/audio-iio-aux.yaml         | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/audio-iio-aux.yaml

diff --git a/Documentation/devicetree/bindings/sound/audio-iio-aux.yaml b/Documentation/devicetree/bindings/sound/audio-iio-aux.yaml
new file mode 100644
index 000000000000..d3cc1ea4a175
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/audio-iio-aux.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/audio-iio-aux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Audio IIO auxiliary
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description:
+  Auxiliary device based on Industrial I/O device channels
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: audio-iio-aux
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
+  snd-control-invert-range:
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
+    iio-aux {
+        compatible = "audio-iio-aux";
+        io-channels = <&iio 0>, <&iio 1>, <&iio 2>, <&iio 3>;
+        io-channel-names = "CH0", "CH1", "CH2", "CH3";
+        /* Invert CH1 and CH2 */
+        snd-control-invert-range = <0 1 1 0>;
+    };
-- 
2.40.1

