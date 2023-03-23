Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F336C6FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCWRxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjCWRxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:53:04 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2F31993;
        Thu, 23 Mar 2023 10:53:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c4so13796946pfl.0;
        Thu, 23 Mar 2023 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679593983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNlU/dImMAR9PDxxI0s95TJ5dyS1Y5Lepeba170fA/o=;
        b=L+NEcWGjZ/go6ert+EXlAxDJQnO06RSthhAMwsWd7rmvImymaL+4KN8NFxdrw8GLob
         HHE9dKnnd8BKaQ0JZaAVkh7U0vAyOT9U0x8S0MSShwIbt6PJOimRhT2Dj98tbIOECiGl
         5ZHFJJGF63W4PAzFhHvPr0e5soCYrCdWi6fx0GUuGvoe9zYMbRycvd+tk/NBnBPWPCh6
         F7+zi3O5+ooxvsNQsXKlVI0Jm1w56HdPpk6qy6OdpLWEbdoeaphDQLSBK/dslMNSpmBe
         +db93Fi9h7bq5eBCpiD3ngTAwAOkkh/KEb0R6TtJM+yrdMcwN2GlHv0ufT8vuDnDeXDU
         pXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679593983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNlU/dImMAR9PDxxI0s95TJ5dyS1Y5Lepeba170fA/o=;
        b=D3VYDTev6EQL6uCz72QpBa9YNfLKqfjNcf+zo6VVgqGqsetJawlje4DJe5QBmu96iJ
         CGewOhhJrpy4crsc30co7RyTiWplIXhGcGbbAMZzISKYlAKnufUw8SFkxCGp4/zZrOch
         qUk5RuIw20dPZWfAcqkD+8qA6Z39owF6P/akMtjWpOwfckg47sz6QRpvDJaP1JUZzk2w
         v84LWe6Oys1ZOjkquzspJTP63LiYxIdtX1nbCqhEfEUKkoiilD3Bqh6T/infHuVwOSFh
         iDROMWgvusVpKKcNj1B1h77WY/Sa3HY/N662Qe5Yo25OPDzavXJCwyoXr/X9NedGORVE
         chPQ==
X-Gm-Message-State: AO0yUKXM041giEHIVXFiq9H7VBKzkZFwzPbtCR9M3OrHBslupLkusIFu
        UwHKIGJ60ClE5mQzBNmn/OI=
X-Google-Smtp-Source: AK7set9IWYkq8vOqWDrw2argZnBJ+KtjvpJcDPy+i5/sNZPDv/rFGbOe/tskaGFQHckkuiBG3yNsmw==
X-Received: by 2002:aa7:9e04:0:b0:625:500c:35bd with SMTP id y4-20020aa79e04000000b00625500c35bdmr6854610pfq.6.1679593983704;
        Thu, 23 Mar 2023 10:53:03 -0700 (PDT)
Received: from ryan-ThinkPad-T470.. (c-24-6-63-212.hsd1.ca.comcast.net. [24.6.63.212])
        by smtp.gmail.com with ESMTPSA id k17-20020a63d111000000b004fbb4a55b64sm11761040pgg.86.2023.03.23.10.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:53:03 -0700 (PDT)
From:   =?UTF-8?q?=E2=80=9CRyan?= <ryan.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, krzysztof.kozlowski@linaro.org,
        rf@opensource.cirrus.com, ckeepax@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com, herve.codina@bootlin.com,
        wangweidong.a@awinic.com, james.schulman@cirrus.com,
        ajye_huang@compal.corp-partner.google.com, shumingf@realtek.com,
        povik+lin@cutebit.org, flatmax@flatmax.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        ryans.lee@analog.com
Subject: [PATCH V3 2/2] ASoC: dt-bindings: max98363: add soundwire amplifier
Date:   Thu, 23 Mar 2023 10:52:56 -0700
Message-Id: <20230323175256.2606939-2-ryan.lee.analog@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323175256.2606939-1-ryan.lee.analog@gmail.com>
References: <20230323175256.2606939-1-ryan.lee.analog@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Lee <ryans.lee@analog.com>

This patch adds dt-bindings information for Analog Devices MAX98363
SoundWire Amplifier.

Signed-off-by: Ryan Lee <ryans.lee@analog.com>
---
Changes from v1:
  Fixed a syntax error for the 'dt_binding_check' build.
  Removed unnecessary properties.
  Added description about SoundWire device ID of MAX98363
Changes from v2:
  Removed the legacy from i2c/i2s driver and added SoundWire device ID info.
  Added missing information about DAI.

 .../bindings/sound/adi,max98363.yaml          | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,max98363.yaml

diff --git a/Documentation/devicetree/bindings/sound/adi,max98363.yaml b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
new file mode 100644
index 000000000000..92352a23e1cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/adi,max98363.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX98363 SoundWire Amplifier
+
+maintainers:
+  - Ryan Lee <ryans.lee@analog.com>
+
+description:
+  The MAX98363 is a SoundWire input Class D mono amplifier that
+  supports MIPI SoundWire v1.2-compatible digital interface for
+  audio and control data.
+  SoundWire peripheral device ID of MAX98363 is 0x3X019F836300
+  where X is the peripheral device unique ID decoded from pin.
+  It supports up to 10 peripheral devices(0x0 to 0x9).
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: sdw3019F836300
+
+  reg:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+  sound-name-prefix: true
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    soundwire-controller@3250000 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        reg = <0x3250000 0x2000>;
+
+        speaker@0,0 {
+            compatible = "sdw3019F836300";
+            reg = <0 0>;
+            #sound-dai-cells = <0>;
+            sound-name-prefix = "Speaker Left";
+        };
+
+        speaker@0,1 {
+            compatible = "sdw3019F836300";
+            reg = <0 1>;
+            #sound-dai-cells = <0>;
+            sound-name-prefix = "Speaker Right";
+        };
+    };
-- 
2.34.1

