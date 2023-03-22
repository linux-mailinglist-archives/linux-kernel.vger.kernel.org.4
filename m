Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFC86C4C39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjCVNrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjCVNrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:47:25 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DA659E75;
        Wed, 22 Mar 2023 06:47:19 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 4382320002;
        Wed, 22 Mar 2023 13:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679492838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwfPEx0id9lkmTqeXmonqzG+ttziM1BKTuoeNAq8HFk=;
        b=d25XadhUqVTiT72yzMYftJfPojyWVTfngWDWXxlGdooZE7tDw9U5Z5lOYQbBC81ozu5e3P
        SRd+WBLyUOnCJAkDxSFl2Sk2DN22HLAgpKuVgk3slglRc7NmFrvYEJwJYk8/KGLxVZ+aq/
        2wH7khKxLSRU4AFiGNdenKJUqt21VrRrrHtLCgfeLhkCPs2YZq5NQUVmey0T7sDphGo+Ud
        iHjkz/plns1h0tYaeakO6tCUeYSUEto9yBoS90askUVzVKjmJRLKtAXAR2ox5PZrHOkhBW
        ql7/3H4FNk3nJ3GIzSFQ6pIGtMrU19Ypfo31ocBkaegHpXDmtUuaqLNmW0nugA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 4/6] dt-bindings: sound: Add support for the Lantiq PEF2256 codec
Date:   Wed, 22 Mar 2023 14:46:52 +0100
Message-Id: <20230322134654.219957-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322134654.219957-1-herve.codina@bootlin.com>
References: <20230322134654.219957-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lantiq PEF2256 is a framer and line interface component designed to
fulfill all required interfacing between an analog E1/T1/J1 line and the
digital PCM system highway/H.100 bus.

The codec support allows to use some of the PCM system highway
time-slots as audio channels to transport audio data over the E1/T1/J1
lines.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/sound/lantiq,pef2256-codec.yaml  | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml

diff --git a/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml b/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
new file mode 100644
index 000000000000..da35b70cda99
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/lantiq,pef2256-codec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lantiq PEF2256 codec
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description: |
+  Codec support for PEF2256.
+
+  The Lantiq PEF2256, also known as Infineon PEF2256 or FALC56, is a framer and
+  line interface component designed to fulfill all required interfacing between
+  an analog E1/T1/J1 line and the digital PCM system highway/H.100 bus.
+
+  The codec support allows to use some of the PCM system highway time-slots as
+  audio channels to transport audio data over the E1/T1/J1 lines.
+
+  The time-slots used by the codec must be set and so, the properties
+  'dai-tdm-slot-num', 'dai-tdm-slot-width', 'dai-tdm-slot-tx-mask' and
+  'dai-tdm-slot-rx-mask' must be present in the ALSA sound card node for
+  sub-nodes that involve the codec. The codec uses 8bit time-slots.
+  'dai-tdm-tdm-slot-with' must be set to 8.
+  The tx and rx masks define the PEF2256 time-slots assigned to the codec.
+
+  The PEF2256 codec node should be a child of a PEF2256 node.
+  Refer to the bindings described in
+  Documentation/devicetree/bindings/mfd/lantiq,pef2256.yaml
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: lantiq,pef2256-codec
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - '#sound-dai-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    codec {
+        compatible = "lantiq,pef2256-codec";
+        #sound-dai-cells = <0>;
+    };
-- 
2.39.2

