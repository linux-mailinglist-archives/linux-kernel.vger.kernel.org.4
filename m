Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC7D6A1482
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 02:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBXBIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 20:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBXBIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 20:08:35 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1878CDF;
        Thu, 23 Feb 2023 17:08:34 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id i10so6198866plr.9;
        Thu, 23 Feb 2023 17:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEGaxTrptF/i88hDG2ZZPDfmgm+Q0tSvkYEKB/u7k1M=;
        b=YyJtXr4dCPBimtyO0bOKFjj9lpU+V6GliYEV7tT3zN2u+sfwV4sTTMiDL2XR+o7l50
         B+pCrCrnMs2950ptW9F23gafbWVKjWxFhHfA3+HrN5+15ofJTKXD8oQGKnr70/fxFXty
         nvt6zzjPLifLD2ZKoNOjPoudRHzs6P6LWu55Tj8eUGKzgo9d1RkoOscD4v51jfITbo3I
         Y+dPA9ygtTSDnJFyHZMx8HgMPFMqRj5qfp1r6NopPa1grEsWVvsGMoHOkJskZ9vv22pb
         wh5MALsek/GFvAjNFMulQyXMMYRY3tq1/y0c+Pu5XxNDvK2ZKD9W5zC5USIKJ0zjjJWy
         tVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEGaxTrptF/i88hDG2ZZPDfmgm+Q0tSvkYEKB/u7k1M=;
        b=bXHYYaSvDk0Zf1Yw5Ttl9oD31d5YxaZSrjEU4MGZ9YXWmNb7L369LKx++4FW7K1Kew
         CAtc/xJkVptRdjplWxD7VwweX9rcx232jak9w91EgO/wu6WOs3+yoS69n7GkorfdSJjm
         RKmQp+rY5tkBpnLLvqXst7aXAsheB/OBikMqjdDriDBxnPgRuDG5fl2IHV3hL4fv1KLW
         ZTfUFSyS82bEqWvCOhZUJ8TUcVA1CuGKq0TM8t0VM6n+9rsor7ZFnlvmcN00dKU1cuvn
         u8poZxtYCUz/EyQiphWSbUwpM6bm6KvqDCJI7CtXC3f8cbB0Mpz6Y7XdFQ+QsKEThryQ
         DL8w==
X-Gm-Message-State: AO0yUKWq7WkIiUOovlznN5/DMx4gwpKAGsjkUf1flf9w7n5AmEVOCyHO
        Au6XqjA7KLrghTYPS7+L0sU=
X-Google-Smtp-Source: AK7set9Br2M0tdazVDbZiCs0X3VbrL7as0h5R9J9TKRZGADBmXew7lvFqbL+fhZWHf0GFxrQlyz61Q==
X-Received: by 2002:a17:90b:224f:b0:236:9eef:e280 with SMTP id hk15-20020a17090b224f00b002369eefe280mr16311616pjb.46.1677200913497;
        Thu, 23 Feb 2023 17:08:33 -0800 (PST)
Received: from ryan-ThinkPad-T470.. (c-24-6-63-212.hsd1.ca.comcast.net. [24.6.63.212])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902a40500b0019adfb96084sm3821008plq.36.2023.02.23.17.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 17:08:33 -0800 (PST)
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
Subject: [PATCH 2/2] ASoC: dt-bindings: max98363: add soundwire amplifier driver
Date:   Thu, 23 Feb 2023 17:08:14 -0800
Message-Id: <20230224010814.504016-2-ryan.lee.analog@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230224010814.504016-1-ryan.lee.analog@gmail.com>
References: <20230224010814.504016-1-ryan.lee.analog@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../bindings/sound/adi,max98363.yaml          | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,max98363.yaml

diff --git a/Documentation/devicetree/bindings/sound/adi,max98363.yaml b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
new file mode 100644
index 000000000000..fda571d04a64
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
@@ -0,0 +1,53 @@
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
+
+properties:
+  compatible:
+    enum:
+      - adi,max98363
+
+  reg:
+    maxItems: 1
+    description: Peripheral-device unique ID decoded from pin
+
+  vdd-supply:
+    description:
+      A 2.5V to 5.5V supply that powers up the VDD pin.
+
+  dvddio-supply:
+    description:
+      A 1.7V or 1.9V supply that powers up the DVDDIO pin.
+      This property is only needed for MAX98363A/B.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - dvddio-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    soundwire {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        max98363: amplifier@3 {
+            compatible = "adi,max98363";
+            reg = <0x3>;
+            vdd-supply = <&regulator_vdd>;
+            dvddio-supply = <&regulator_1v8>;
+        };
+    };
-- 
2.34.1

