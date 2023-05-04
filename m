Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901BE6F6389
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjEDDic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjEDDiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:38:15 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC201BFA;
        Wed,  3 May 2023 20:37:52 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so5483519a12.1;
        Wed, 03 May 2023 20:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683171471; x=1685763471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppElbYTnZchKdSmIsJKcoQirj/HKgvW6OZ3OLbm7LFM=;
        b=prKHhAVy4fptTTqyNWxK3tYULiQPGQTyGkMd4YUaj5S9zc/vi5MPj4Y5X6C9Smd0Bm
         sxlMmMydhLSH9+JV7CZPrBlV7zGS5fT4bYQSfngyds/acN8N/hohEPycMpIYUeinI113
         E4Xzp724/aOjA9LlPRFFHA2cxpkSWtOGWYq2iuYeqJiZ8N2DarN+7FGKHyRrzxxQ/yQ6
         bj7NmFKNofLaenGVx4apqk9e9UQkCD2yEAtHSOcNl0L28Wx0ZB8X8hnVLpA0YdttIWwY
         DQz+U4Zhu8nM42joSEFr0biGidpL5Vdk/VsSoIrw1iMNeruC+WWQT1shmdQjO5etrmz5
         MDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683171471; x=1685763471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppElbYTnZchKdSmIsJKcoQirj/HKgvW6OZ3OLbm7LFM=;
        b=kzYObCL/UGzuaESkKLQaC09RLg1rzfOUGKSJwGfu9mBe9m7fYGAptPKaA6uO3I4bZq
         WMOY0CNzxFhF85wS22C+tHiXcyJOhteYywLlCzG8AHrZZU7jFOY23084HjS3fOni/aJW
         3m9b+aP1UCPJLG60Fd/dZJghF7c3iCtxaIw28V4zeEq5wALkGluhUe9nn4sJ8aHjBtTD
         JBmkRZKFeVa7ctcB9tsmotoxHOlNUEKCz8vX9akJTZIdFGL41TInqBKLhWGfeKgHhR4U
         LRgLpP6Jd5pncPjqpMKJ+nHEIiQP5jYKfU2dtj0eHMx0ojbYIBQDXgr3EWgVNO/yqt95
         xC/w==
X-Gm-Message-State: AC+VfDwNc4LRbFf8lbAb3Ht1YbfqeNZ6johzMOwpmvxYeMhefkl3Ao7O
        lcNqVXefgKt5/gWb/QO6f1uemSoEHkfEzw==
X-Google-Smtp-Source: ACHHUZ576hc7PoaR6wnk+u7G0bkgD0zadEzuQpePHPpQt9y0O8SslwT7NW3NW9V9XQvt8c7r3rtQOQ==
X-Received: by 2002:a17:902:6947:b0:1ab:1b8:8a5f with SMTP id k7-20020a170902694700b001ab01b88a5fmr2169326plt.33.1683171470039;
        Wed, 03 May 2023 20:37:50 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jj3-20020a170903048300b001ab849b46d3sm468761plb.178.2023.05.03.20.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 20:37:49 -0700 (PDT)
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
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 05/10] dt-bindings: arm: Add initial bindings for Nuvoton platform
Date:   Thu,  4 May 2023 03:37:21 +0000
Message-Id: <20230504033726.93-6-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504033726.93-1-ychuang570808@gmail.com>
References: <20230504033726.93-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index c0cde28c62c6..cf19d3915451 100644
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

