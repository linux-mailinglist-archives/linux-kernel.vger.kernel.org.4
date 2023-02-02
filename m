Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA0A6886B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjBBSiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbjBBSiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:38:14 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892701EBD4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:37:37 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m7so2550026wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZDf/HLHsmXllvXlzMaBba2wF4a3xInBovmR2gll1NE=;
        b=xaYuudaLyB+uAk3PVQ8DP1LP3TKOxSqkpwctcjT4Z0iVbrSjlIK7ROCuOD4TzGetXo
         tgqj0nGRsRQJe072REFgPgVjHQ61dQkyQ5aEa/e1iHKNSevRrsRIF1xECSFXNThvxi8q
         PwFwhy/U4yfMzR+lsF4xgGiPi+SKpVMSj4sxR3WM/+My7FdcSoHpJmJ23HL4wFjcipNM
         JTB+yER/k59c2hjSoR533p4BYEdcUx7B5RLfR0YaDmPSpm/sp83jQTcs18KIfbZhK2du
         ELJ9eRv3HiVXVpuad6m6/Z/hcVB7PWmib8ZJlJvx+Py4/mEjinnOAWxXh9fSxRK0LwYM
         NhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZDf/HLHsmXllvXlzMaBba2wF4a3xInBovmR2gll1NE=;
        b=gZvtT07qkaYXk9w3g5uyl9+WxmyW/yy1cygRreygcnEO5fM861Siipz/8Vnuhbzgih
         j1uE6SIbcd9v35dKxCQRkaPiJvs26Ukh2VKQ7ejWFPqSuBdp0zdu072XEEzqVebN2qEN
         E3unux0M35tLHfZEWSL1mR2V9xIkQXtGqQwSxa+syyDVUr2Ij9/YRPdtfhLZwGYoXeXF
         orSG41FgP9bNiDq8ORwTEQyXxnnM49a5PjJ05tLGH6pxU3e1XhrbCwlMpPdrxUqdakAb
         uYxYAGSwaGB3BURpRIQRBrha/+gqc7bwqUJH4sUKBdQrwPt3cm4y6I3DAU6ftYJDlvoP
         544A==
X-Gm-Message-State: AO0yUKXHR7CpMkVdlwAAMHKRr4sDC99zZDgvAmOmQVx48AqXxPuMVPWC
        FIjl0qorg2soABGQEcAF31bllw==
X-Google-Smtp-Source: AK7set87mrYHNE/0/I372ct8ZaVBEWpNKw4XOYrrrvcmO7iVSYhOhxapZ0+s93W5U33cXIJHeAn8Sg==
X-Received: by 2002:a5d:6da3:0:b0:2bf:ae11:c40c with SMTP id u3-20020a5d6da3000000b002bfae11c40cmr7784287wrs.32.1675363054576;
        Thu, 02 Feb 2023 10:37:34 -0800 (PST)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id p12-20020a5d48cc000000b00241fab5a296sm164664wrs.40.2023.02.02.10.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 10:37:34 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] ASoC: dt-bindings: meson: convert axg tdm interface to schema
Date:   Thu,  2 Feb 2023 19:36:47 +0100
Message-Id: <20230202183653.486216-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202183653.486216-1-jbrunet@baylibre.com>
References: <20230202183653.486216-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the DT binding documentation for the Amlogic tdm interface to
schema.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-tdm-iface.txt  | 22 -------
 .../bindings/sound/amlogic,axg-tdm-iface.yaml | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
deleted file mode 100644
index cabfb26a5f22..000000000000
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* Amlogic Audio TDM Interfaces
-
-Required properties:
-- compatible: 'amlogic,axg-tdm-iface'
-- clocks: list of clock phandle, one for each entry clock-names.
-- clock-names: should contain the following:
-  * "sclk" : bit clock.
-  * "lrclk": sample clock
-  * "mclk" : master clock
-	     -> optional if the interface is in clock slave mode.
-- #sound-dai-cells: must be 0.
-
-Example of TDM_A on the A113 SoC:
-
-tdmif_a: audio-controller@0 {
-	compatible = "amlogic,axg-tdm-iface";
-	#sound-dai-cells = <0>;
-	clocks = <&clkc_audio AUD_CLKID_MST_A_MCLK>,
-		 <&clkc_audio AUD_CLKID_MST_A_SCLK>,
-		 <&clkc_audio AUD_CLKID_MST_A_LRCLK>;
-	clock-names = "mclk", "sclk", "lrclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml
new file mode 100644
index 000000000000..362414fc9a9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Audio TDM Interfaces
+
+maintainers:
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  $nodename:
+    pattern: "^audio-controller-.*"
+
+  compatible:
+    items:
+      - const: 'amlogic,axg-tdm-iface'
+
+  "#sound-dai-cells":
+    const: 0
+
+  clocks:
+    minItems: 2
+    items:
+      - description: Bit clock
+      - description: Sample clock
+      - description: Master clock #optional
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: sclk
+      - const: lrclk
+      - const: mclk
+
+required:
+  - compatible
+  - "#sound-dai-cells"
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/axg-audio-clkc.h>
+
+    tdmif_a: audio-controller-0 {
+        compatible = "amlogic,axg-tdm-iface";
+        #sound-dai-cells = <0>;
+        clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
+                 <&clkc_audio AUD_CLKID_MST_A_LRCLK>,
+                 <&clkc_audio AUD_CLKID_MST_A_MCLK>;
+        clock-names = "sclk", "lrclk", "mclk";
+    };
-- 
2.39.0

