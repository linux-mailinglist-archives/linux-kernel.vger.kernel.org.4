Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589EE6D1377
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjC3Xnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjC3Xnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:43:33 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A76ECA31;
        Thu, 30 Mar 2023 16:43:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c18so19641413ple.11;
        Thu, 30 Mar 2023 16:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680219812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NTXaHHO//3z+k+mNK1rkd5Zzs1cpAqfGCFxh55cRSg=;
        b=cp61TQFDfM8o339UtrnDmOFRlj1BU5ivIShulD1ygi1J5PnpYJXTAKVn8hN9LejGVW
         Ng7kmSq/bYlQPWmI1QEdbxdC5EDWye0iplCY3O9vbBJsOQwZagdUuHlwjqnV/1VrZARx
         T8O2yQKlWXJY/Kwocv2EqBMqzZr0DZZoGRgzEZKP+nksqXiVWfgal3cGfC7DoIikBxgR
         RNwzcTe6vYmbYZne8oQqDhiorPu9///1JFlwxwLJ9WDs+nPDLlPtRf+tDbztY+STkrRZ
         Cu3ncFqZlV6bigun6CI5/4+VP19ThctqU3wCM8ikjrXkP7cUgvfmIjbHfIBlZKkGzYM0
         isqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680219812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NTXaHHO//3z+k+mNK1rkd5Zzs1cpAqfGCFxh55cRSg=;
        b=T9dvkEDU4nPevbu+mDSj6LTtOtVpu05OvvgkofFp0G6bW7qQAaZo15OXyZ1xK8ZWKH
         O7I3+BJs0q0abP7rGVKWWVVhdi8fEKKRc1cyKRLzLt/gA1yDzz4Go4OG2ydjAm8MNsMk
         4MP2wgrHDGo0iBRviMLCtAzq5RxdhoEn1jjyOeSclQXLesXK+QwCdVu2OoZXdOeBQgvf
         Hr4mxds5+Kma0cRnDEDcJClruf4jL9s5R9C+nf/k4Zak5y0U5x1GOyNyCruA/+JEMrYE
         51HcxWz7YP8ulAj9BP+VrkeA2AQLMC1OPGkPHIEiOOP613FtpL8PYvVWxosIvA/MRKje
         l6FQ==
X-Gm-Message-State: AAQBX9cAfmFTtaBK1aZgLTumax4utIyiym2ajw9YVWmGv7Nuay3XJ8a9
        aoMIJsIkYOd0f0Q9uIwDyp7x75ZSsZo=
X-Google-Smtp-Source: AKy350bifEk1k722eISf1aA5Ur1irJAuMPL6ctlCNHdxG7TafXssIwk7Fqlxd3SbBqJzN+lYuoGzfg==
X-Received: by 2002:a17:903:1d1:b0:1a1:ad5e:bdbb with SMTP id e17-20020a17090301d100b001a1ad5ebdbbmr32329670plh.36.1680219811790;
        Thu, 30 Mar 2023 16:43:31 -0700 (PDT)
Received: from ryan-ThinkPad-T470.. (c-24-6-63-212.hsd1.ca.comcast.net. [24.6.63.212])
        by smtp.gmail.com with ESMTPSA id k2-20020a170902e90200b001a19cf1b37esm282733pld.40.2023.03.30.16.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 16:43:31 -0700 (PDT)
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
Subject: [PATCH V4 2/2] ASoC: dt-bindings: max98363: add soundwire amplifier
Date:   Thu, 30 Mar 2023 16:43:19 -0700
Message-Id: <20230330234319.6841-2-ryan.lee.analog@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330234319.6841-1-ryan.lee.analog@gmail.com>
References: <20230330234319.6841-1-ryan.lee.analog@gmail.com>
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

Add dt-bindings information for Analog Devices MAX98363 SoundWire Amplifier

Signed-off-by: Ryan Lee <ryans.lee@analog.com>
---
Changes from v1:
  Fixed a syntax error for the 'dt_binding_check' build.
  Removed unnecessary properties.
  Added description about SoundWire device ID of MAX98363
Changes from v2:
  Removed the legacy from i2c/i2s driver and added SoundWire device ID info.
  Added missing information about DAI.
Changes from v3:
  Modified the commit message. Removed "This patch"
  Converted uppercase hex to lowercase hex
  Dropped 'sound-name-prefix'.
  Added unevaluatedProperties instead of additionalProperties

 .../bindings/sound/adi,max98363.yaml          | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,max98363.yaml

diff --git a/Documentation/devicetree/bindings/sound/adi,max98363.yaml b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
new file mode 100644
index 000000000000..a844b63f3930
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
@@ -0,0 +1,60 @@
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
+  SoundWire peripheral device ID of MAX98363 is 0x3*019f836300
+  where * is the peripheral device unique ID decoded from pin.
+  It supports up to 10 peripheral devices(0x0 to 0x9).
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: sdw3019f836300
+
+  reg:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
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
+    soundwire-controller@3250000 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        reg = <0x3250000 0x2000>;
+
+        speaker@0,0 {
+            compatible = "sdw3019f836300";
+            reg = <0 0>;
+            #sound-dai-cells = <0>;
+            sound-name-prefix = "Speaker Left";
+        };
+
+        speaker@0,1 {
+            compatible = "sdw3019f836300";
+            reg = <0 1>;
+            #sound-dai-cells = <0>;
+            sound-name-prefix = "Speaker Right";
+        };
+    };
-- 
2.34.1

