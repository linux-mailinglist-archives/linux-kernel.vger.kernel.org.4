Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFEF715772
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjE3HoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjE3HnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:43:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E1619A;
        Tue, 30 May 2023 00:43:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so2649630a12.0;
        Tue, 30 May 2023 00:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685432566; x=1688024566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjbEkr2tdxA8dndDDvZ9pDY9CzC5KTWSZdvxsZ87FOo=;
        b=EGjqaVmm/OqVd6yff7Vik0yWgk90t5OlVtw6VwmwMACRzPnGPG0OTEdK+ueWDXRNB0
         OcZ3jaxvkzsi8TBxsaCiEPQhEIgDVTBibxYJThz6fNzY21pm3mg/LRDyTEZTtrdYXdj2
         6D4bhKjEis/2I31EHFGZHky5lW+SVuyY/WIj+ki//y3pmFZbKQ4Ty7uXLXz/p1G2Q3kG
         Xzo0DPE+R3124yQyhOkJtmNWeBS1G5yqPsXmcn0tmmJ+rDXBA9CCeLnmjvTqHemWom+2
         DTzE25AK3Lb+2bKrZ81JcWk+TuvaS1LzDnXrTpxF/tuxKtYpb94J76T1+nD0IWJFy9GU
         SQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685432566; x=1688024566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjbEkr2tdxA8dndDDvZ9pDY9CzC5KTWSZdvxsZ87FOo=;
        b=g2Q4pQ+FCFX2lj//oOEf/+gliz6vjkeOyGPN+H8ICh7eNzlKbjdxOfGNFK6zF+yiNE
         2HWtmc4mwEzDSLMXfeDYJd7FjgHPY76MnwlFsjV79Dqkc9hd2SbVRjzjHYOJEMgSN8rA
         IT0OOH3Ndx9JA0VouH01qyeZSeeNMqnsQHe8xjG2Ksx4js5pIXyGjaSfZ1Q3gQ+l0v71
         ocCgyjMDBra538naZ1AmYXaE/cXjfT7AdvqFGpgF92ybOAjYQn1H5oVt60kZyPo3RbLd
         cbrztUZhqX6AnuvFgMijnBYBXIdKp3vjWcNuXduJ+r3IRlF+issbdpi/o2wXiPnJFGGi
         Fmvw==
X-Gm-Message-State: AC+VfDy9BwhOMkdwa28SKUVMFRNMbVV4+iNTHSQknIgqRKxJHFjMnu/d
        IMruKZqadY3f3DjnySW4drA=
X-Google-Smtp-Source: ACHHUZ4oIjTrgq9lgRlAHgXaci5oto+StShkQshQFI6KjQ0DIjWpTtmJTdOGTMQs0yoVYaNH5YR/iA==
X-Received: by 2002:a17:902:e5c9:b0:1ad:bccc:af77 with SMTP id u9-20020a170902e5c900b001adbcccaf77mr11408869plf.18.1685432566132;
        Tue, 30 May 2023 00:42:46 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b001afb96f4b90sm5930793plh.274.2023.05.30.00.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:42:45 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v12 05/10] dt-bindings: arm: Add initial bindings for Nuvoton platform
Date:   Tue, 30 May 2023 07:42:16 +0000
Message-Id: <20230530074221.1031011-6-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530074221.1031011-1-ychuang570808@gmail.com>
References: <20230530074221.1031011-1-ychuang570808@gmail.com>
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
index 250518fc70ff..a530735c9e87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2505,6 +2505,18 @@ F:	drivers/rtc/rtc-ab8500.c
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
@@ -2516,7 +2528,6 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/*/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
-F:	Documentation/devicetree/bindings/arm/npcm/*
 F:	Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
 F:	arch/arm/boot/dts/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
-- 
2.34.1

