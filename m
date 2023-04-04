Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB86D6D6A64
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbjDDRW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbjDDRWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:22:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6EC558F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t10so133431394edd.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd06AIYAawb0fyKtUMKemgYfIsiht0igGFmjHLSBjJg=;
        b=xloKNG8SjT0scLVISJA1hE4At/vDMlLEVvra2ZbDP3VIs3sCzN/UKqExXe39zj4iSe
         JkP4iFJLl651/JiaPWl8OdKqRu8UjM+IT9/qVNglRzfpBEGs7L1nG22VS00ntfOsan3e
         trODDalO7qC/Lz/o3YTwuzlc3dsSqvpWDu55pI7ZPVNOGUCOFo9wsvPvCxkl0beU67le
         jQKTD7RsXmxe/BWlRzED2jJtFESSP03FoO51VjJKxXdKKLA3GcbSJEkbyZu04NdhoxDs
         SYEEz1BZlST8lciC/I8FbAyJnWiSTiCdQRXhXJU/jNqa1LhLK49DUcgaBAUPe2eOp8Tk
         K81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd06AIYAawb0fyKtUMKemgYfIsiht0igGFmjHLSBjJg=;
        b=5QwUJC9a6hldti4BeBm97e7w2BHpfkPIrRkKTkYy/KSVNJH2QcTBYbhDM/EfZDfHOf
         Pb9QH7lhxjnebxxPyHUgYgYPMJTvz3VAw26jsfm5PKj7dDHM60PJVaeu834MEevCGwe+
         P+tAaGlEvztCXanl9iQXJEapJT2tDVQW0sO/pASGLZRiNaV1L11YGYFL1Pd8Nazd01Av
         aAGOtJ1eb+IZMt+wbD/TVUkAjmIZKpTp2z9IS2nHaW3A8meqtomKh7jNvolYZxhAtwI6
         sxBEbsPgl7yHNPCmLfr9oR7xYTVPIA7R6nGYbU+FrLRKxTBtzh4UF7wz/2gmjcB+15Nv
         Ftzw==
X-Gm-Message-State: AAQBX9eSXVgeT93g37XmV2j1hBKBBCHfR365Y8PwJQ/FRPeYSX0dkJxF
        bel+T+PdRgi17v8J1D6GPSihqA==
X-Google-Smtp-Source: AKy350bvEgpwRx08EA1pUHX9PMT5a1mKrEzEZkNsEmCDM8Ku2Ppks4WRI9TgaIxl+sBJXvp6Z6NTDA==
X-Received: by 2002:a17:906:6b84:b0:932:8dc:5bf4 with SMTP id l4-20020a1709066b8400b0093208dc5bf4mr274186ejr.61.1680628945959;
        Tue, 04 Apr 2023 10:22:25 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:25 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/40] dt-bindings: nvmem: convert amlogic-meson-mx-efuse.txt to dt-schema
Date:   Tue,  4 Apr 2023 18:21:12 +0100
Message-Id: <20230404172148.82422-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <neil.armstrong@linaro.org>

Convert the Amlogic Meson6 eFuse bindings to dt-schema.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/amlogic,meson6-efuse.yaml  | 57 +++++++++++++++++++
 .../bindings/nvmem/amlogic-meson-mx-efuse.txt | 22 -------
 2 files changed, 57 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml b/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
new file mode 100644
index 000000000000..84b3dfd21e09
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/amlogic,meson6-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson6 eFuse
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson6-efuse
+      - amlogic,meson8-efuse
+      - amlogic,meson8b-efuse
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: core
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    efuse: efuse@0 {
+        compatible = "amlogic,meson6-efuse";
+        reg = <0x0 0x2000>;
+        clocks = <&clk_efuse>;
+        clock-names = "core";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        ethernet_mac_address: mac@1b4 {
+            reg = <0x1b4 0x6>;
+        };
+
+        temperature_calib: calib@1f4 {
+             reg = <0x1f4 0x4>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt b/Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt
deleted file mode 100644
index a3c63954a1a4..000000000000
--- a/Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Amlogic Meson6/Meson8/Meson8b efuse
-
-Required Properties:
-- compatible: depending on the SoC this should be one of:
-	- "amlogic,meson6-efuse"
-	- "amlogic,meson8-efuse"
-	- "amlogic,meson8b-efuse"
-- reg: base address and size of the efuse registers
-- clocks: a reference to the efuse core gate clock
-- clock-names: must be "core"
-
-All properties and sub-nodes as well as the consumer bindings
-defined in nvmem.txt in this directory are also supported.
-
-
-Example:
-	efuse: nvmem@0 {
-		compatible = "amlogic,meson8-efuse";
-		reg = <0x0 0x2000>;
-		clocks = <&clkc CLKID_EFUSE>;
-		clock-names = "core";
-	};
-- 
2.25.1

