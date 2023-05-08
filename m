Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CC26F9E00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 05:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjEHDAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 23:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjEHDAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 23:00:10 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7402160B4;
        Sun,  7 May 2023 20:00:02 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-643b60855c8so1846614b3a.2;
        Sun, 07 May 2023 20:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683514801; x=1686106801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LXHrsjdMnFNkpZGHrAjhG2h2gs42q09zVgFGQge6Jw=;
        b=rGaKqOzxlKIYBfWwBA8rteJhGhKJGbS0V+yUxccBN7QifqARNeR80PYh6ljtoPkQl5
         0R3b+l2n4Gp3nzJpYCfG9QeX0dsROFNeVl9p5kylvBmIj45cVOwtfb4czjzC2lyodysB
         HUmeh8k8aL0yTKpD+NgvReeltWSDm9sN0RcImjlgaLA+Z6U6eB0R6pDsE9oLpJHInzid
         SUOero6Wd+P+bNdSmoB2FLn2q/Fu+FE9xQLFCOHcOa46UAUBzvu5LR9bStoF/bL7U+Bl
         E1caP6Hd8BS53rrdj0F5sfdzj+jnl5so03fUEuJKABufbM5bBekWOr5hoWwgKonrs45G
         3X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683514801; x=1686106801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LXHrsjdMnFNkpZGHrAjhG2h2gs42q09zVgFGQge6Jw=;
        b=jTQNdlJ2UAyje/TjGe1suO3cR/h3vvJ3DlIizltQO6htp2GBgELhDLIVLO/Mbvt9e6
         7anYekZctOzcoFRAGMXM9HAA3E80+oVYBsBdAYdk5dCFjQPLVNS047k5MhH8Uf7xTD9u
         yxPpTkT5RZesqaqgmGgRU3K3TDl0s6HaT5OsNl/8wOFyBOH+koaU3Po9VbaHJS62e8qH
         FFbHYmxSEpoi2uo2T7NfErSCPNFPL1yMZ9xy3aF9F0E6twztINEficzi7rEY9KL4t4Pv
         5t0Yi/YsZEHbXOLjq5wdtylxYkyNzrbUwRjMDV3lEanCnNzJ8LI382UIt4ivvtPU450o
         3iKw==
X-Gm-Message-State: AC+VfDxs89IfeG+dYvw3TXTVUNwrxXP8cRTj5VVZvGmmhj3pc9dbzhxD
        TxQTnQt6OcghfQm5rOZqFI4=
X-Google-Smtp-Source: ACHHUZ7/UP4Z8WpOxevFNYBHSUzImAP6YvrjQD4qjQ7hNoC69BzfjrD85Rpj5yuDk2QcTiVwOrXCUg==
X-Received: by 2002:a05:6a00:15ce:b0:635:6603:2534 with SMTP id o14-20020a056a0015ce00b0063566032534mr12960454pfu.14.1683514801257;
        Sun, 07 May 2023 20:00:01 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id y3-20020aa78543000000b0064559b58eb8sm1525422pfn.154.2023.05.07.19.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 20:00:00 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 05/10] dt-bindings: arm: Add initial bindings for Nuvoton platform
Date:   Mon,  8 May 2023 02:59:31 +0000
Message-Id: <20230508025936.36776-6-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508025936.36776-1-ychuang570808@gmail.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Modify Nuvoton NPCM and MA35 platform board bindings
  - Move 'nuvoton,npcm-gcr.yaml' from 'bindings/arm/npcm' to
    'bindings/soc/nuvoton'.
  - Rename the 'bindings/arm/npcm' directory to 'bindings/arm/nuvoton'.
  - Add bindings for ARMv8-based Nuvoton SoCs and platform boards, and
    include the initial bindings for ma35d1 series development boards.

Modify MAINTAINERS
  - Remove the line for 'bindings/arm/npcm/' under ARM/NUVOTON NPCM, as it
    has been renamed.
  - Add ARM/NUVOTON MA35 for Nuvoton MA35 series SoCs maintainer and files.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
 .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
 .../nuvoton/nuvoton,npcm-gcr.yaml}            |  2 +-
 MAINTAINERS                                   | 13 +++++++-
 4 files changed, 44 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
 rename Documentation/devicetree/bindings/arm/{npcm/npcm.yaml => nuvoton/nuvoton,npcm.yaml} (93%)
 rename Documentation/devicetree/bindings/{arm/npcm/nuvoton,gcr.yaml => soc/nuvoton/nuvoton,npcm-gcr.yaml} (93%)

diff --git a/Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml b/Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
new file mode 100644
index 000000000000..fb190db61525
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/nuvoton/nuvoton,ma35d1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35 series SoC based platforms
+
+maintainers:
+  - Jacky Huang <ychuang3@nuvoton.com>
+
+description: |
+  Boards with an ARMv8 based Nuvoton MA35 series SoC shall have
+  the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description: MA35D1 based boards
+        items:
+          - enum:
+              - nuvoton,ma35d1-iot
+              - nuvoton,ma35d1-som
+          - const: nuvoton,ma35d1
+
+additionalProperties: true
+...
diff --git a/Documentation/devicetree/bindings/arm/npcm/npcm.yaml b/Documentation/devicetree/bindings/arm/nuvoton/nuvoton,npcm.yaml
similarity index 93%
rename from Documentation/devicetree/bindings/arm/npcm/npcm.yaml
rename to Documentation/devicetree/bindings/arm/nuvoton/nuvoton,npcm.yaml
index 6871483947c5..d386744c8815 100644
--- a/Documentation/devicetree/bindings/arm/npcm/npcm.yaml
+++ b/Documentation/devicetree/bindings/arm/nuvoton/nuvoton,npcm.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/npcm/npcm.yaml#
+$id: http://devicetree.org/schemas/arm/nuvoton/nuvoton,npcm.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: NPCM Platforms
diff --git a/Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-gcr.yaml
similarity index 93%
rename from Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml
rename to Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-gcr.yaml
index 94e72f25b331..23e7e4ea01ff 100644
--- a/Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml
+++ b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-gcr.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/npcm/nuvoton,gcr.yaml#
+$id: http://devicetree.org/schemas/soc/nuvoton/nuvoton,npcm-gcr.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Global Control Registers block in Nuvoton SoCs
diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..03b85a80b809 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2509,6 +2509,18 @@ F:	drivers/rtc/rtc-ab8500.c
 F:	drivers/rtc/rtc-pl031.c
 F:	drivers/soc/ux500/
 
+ARM/NUVOTON MA35 ARCHITECTURE
+M:	Jacky Huang <ychuang3@nuvoton.com>
+M:	Shan-Chun Hung <schung@nuvoton.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/*/*/*ma35*
+F:	Documentation/devicetree/bindings/*/*ma35*
+F:	arch/arm64/boot/dts/nuvoton/*ma35*
+F:	drivers/*/*/*ma35*
+F:	drivers/*/*ma35*
+K:	ma35d1
+
 ARM/NUVOTON NPCM ARCHITECTURE
 M:	Avi Fishman <avifishman70@gmail.com>
 M:	Tomer Maimon <tmaimon77@gmail.com>
@@ -2520,7 +2532,6 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/*/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
-F:	Documentation/devicetree/bindings/arm/npcm/*
 F:	Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
 F:	arch/arm/boot/dts/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
-- 
2.34.1

