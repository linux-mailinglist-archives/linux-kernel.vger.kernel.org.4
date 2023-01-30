Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476D5681495
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbjA3PRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbjA3PQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:16:49 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159573B676
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:16:28 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k16so8245058wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDzJ19fQHA7Hg3Als9sXt3Vy8GMWCA2KfiCkhNdhAL4=;
        b=gUen5KknnuPWhKVYWbV4vfwt2CtnNkFVI+qeBfQiDKEejjtdyfOpERRG3Ybw2r2wnM
         FVWsXWFFw9cxo/BROT9to3PiVanT67Mn9KKOZQSIeFPQhgu9cJzhFdjavzgYCz41IIM7
         KIzefD0J9918TqX1a/cZr0cMHo0B6pb3FzVR9LtAwQ8ppWaKAOziPZcHvDzzS9v05nmx
         r+OjDSjGY4ENGOYhAsh5FEifrzNTHN/AyG2zEvdXPQ8KDqTGoicZLQLw7XUZQp9QjI7j
         Ux2ZFbAoDL1teqeb4Qw1OP7PunCeoy6Z+n28AW7wyP8LWIBfeXtOoqRp4DEA3sEwyTrA
         oosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDzJ19fQHA7Hg3Als9sXt3Vy8GMWCA2KfiCkhNdhAL4=;
        b=fjaaDVkgGnTDG0NJwHDGoB3Cj1slVtMPMdIpSltd7QDanOTBa5BYibEWkCN3e3OExt
         hpoMv7Gkx72Rg6cW76MvCvZerm04eOh0LNxvoishUlbshhvCtADZv9i8Y6DPXHr2C/zn
         NJ4D4ToPNNKdYUlhM4S7Az45T+GmCy0/7gPWfBffdU3uv79xIJkcdhqXrympIp4gV8M6
         HlIyZw9yCRLc3o6EeHBBazYq24ZFeGK+INammpSEP6er6ap/ZzsI4gBFlY68D+Rnu2aR
         0EbF6u2ln2pq+TBH3AsCwhvdHFLIQmwHiA1XAmgKr2J0fs9zj/rN3B5Ix/DxEldmewRm
         TW2Q==
X-Gm-Message-State: AO0yUKU+r/Imb+Sg6IsvTAJ3LjRAQ03+Rs9xpc7YdcD0QbzOyS6mRzQF
        SvmC3w2eO5E0M2opwpjLrBFdkQ==
X-Google-Smtp-Source: AK7set+TvDU+aj1jWdIKoUfMg03Z+ncqNlEuLJL+MGJ4I5NMt9G18KZSDNdnepUBIaWEtMN0AjG6Lw==
X-Received: by 2002:a1c:7205:0:b0:3dc:523c:229a with SMTP id n5-20020a1c7205000000b003dc523c229amr6086744wmc.7.1675091785552;
        Mon, 30 Jan 2023 07:16:25 -0800 (PST)
Received: from jackdaw.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id u12-20020a05600c19cc00b003db0ee277b2sm18735802wmq.5.2023.01.30.07.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:16:24 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Da Xue <da@lessconfused.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 net-next 1/2] dt-bindings: net: add amlogic gxl mdio multiplexer
Date:   Mon, 30 Jan 2023 16:16:15 +0100
Message-Id: <20230130151616.375168-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230130151616.375168-1-jbrunet@baylibre.com>
References: <20230130151616.375168-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the MDIO bus multiplexer found on the Amlogic GXL
SoC family

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/net/amlogic,gxl-mdio-mux.yaml    | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/amlogic,gxl-mdio-mux.yaml

diff --git a/Documentation/devicetree/bindings/net/amlogic,gxl-mdio-mux.yaml b/Documentation/devicetree/bindings/net/amlogic,gxl-mdio-mux.yaml
new file mode 100644
index 000000000000..27ae004dbea0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/amlogic,gxl-mdio-mux.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/amlogic,gxl-mdio-mux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic GXL MDIO bus multiplexer
+
+maintainers:
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+description:
+  This is a special case of a MDIO bus multiplexer. It allows to choose between
+  the internal mdio bus leading to the embedded 10/100 PHY or the external
+  MDIO bus on the Amlogic GXL SoC family.
+
+allOf:
+  - $ref: mdio-mux.yaml#
+
+properties:
+  compatible:
+    const: amlogic,gxl-mdio-mux
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ref
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
+    eth_phy_mux: mdio@558 {
+      compatible = "amlogic,gxl-mdio-mux";
+      reg = <0x558 0xc>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      clocks = <&refclk>;
+      clock-names = "ref";
+      mdio-parent-bus = <&mdio0>;
+
+      external_mdio: mdio@0 {
+        reg = <0x0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+      };
+
+      internal_mdio: mdio@1 {
+        reg = <0x1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+      };
+    };
-- 
2.39.0

