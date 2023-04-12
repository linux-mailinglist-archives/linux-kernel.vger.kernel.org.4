Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D786DEB4C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDLFjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjDLFjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:39:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F975BB0;
        Tue, 11 Apr 2023 22:38:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id ke16so10189129plb.6;
        Tue, 11 Apr 2023 22:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681277929; x=1683869929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i1tMTPZLGuvknLFHUGIb9xYQZ6wKX2msp9z8wX7XkA=;
        b=pWglZOtsTWAZzTMyDXY90AXap17XvPH9MG4Sus7mZNF5t2LYMj7k8aJBbT1Zx3578q
         xp44ApesijBJ2tGNfu9Oig4J6/R2++BTqwh+epd0UGitFn89PEgP+Wx3rgpdoEqrzUUU
         XBSSay7TjvamB7uET7lHNwvzAnJgGOSDfkYjwjWYOkM3TcgMZTmqdQKXiJ6Dfh4jZjDS
         PJQBF6BsuGc38gHNTGg8SIo4u61jF+cnt5Q32d1KRmwsl25A+uoZ2Z6irRQiGrKj0fkV
         otsmrH8PHZaYJcEZUXjLuHIml9EgYZJSXHBdYCP4d5qq3lzWPtSUYcznSLxte9JCcdUR
         bB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681277929; x=1683869929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9i1tMTPZLGuvknLFHUGIb9xYQZ6wKX2msp9z8wX7XkA=;
        b=MTbr6CnG7cCK6EMRNcdj2bJ1jkJEvW5aHE7/zlUY0lGtdYCZTP8fX/QFCFZOPkP3aY
         axQeQ4mhv1R5M8jfv5HnUyKdlxHRPQCXeNVTxrqhlcy8Na6Edx8YHIQc6/xs8zPwn/Hb
         b2XGFO+CZ14wzJFH/kft+Aa+Q8UV+dJVmJA/cb+nUw9LPvm8mIL+0qNYblG2kaUal1WA
         KE3J40zrW1fh05FEPV0245b3B1boJhYdDZpAKrJz4+gWeGz3u69R7B2O1AgQ3SeEXlkG
         BAs+d2FLn1Nb4mqjzTDS6rFxdC7o/xuvt5d2ugs8YjscDuSFnpyGb6LvOaluaEuOsr7+
         z/RA==
X-Gm-Message-State: AAQBX9cnlquiaj/oTTHkhCv7M+B9oxC/xp2a1DRiy8d1+ZmZUbpnv9cg
        5egmoYU5bVb0D8QsHA2hh50=
X-Google-Smtp-Source: AKy350b2WpeiTpBQ8HqyfjA+QmEaSWzC1rv0p+GYwNunkiNcKWUvKQY6uPfhZPcjdpI9op6faZL9Vg==
X-Received: by 2002:a17:903:10b:b0:1a0:65d3:bae4 with SMTP id y11-20020a170903010b00b001a065d3bae4mr17183898plc.38.1681277928821;
        Tue, 11 Apr 2023 22:38:48 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id ix10-20020a170902f80a00b001a64c4023aesm619640plb.36.2023.04.11.22.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 22:38:48 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v7 06/12] dt-bindings: arm: Add initial bindings for Nuvoton platform
Date:   Wed, 12 Apr 2023 05:38:18 +0000
Message-Id: <20230412053824.106-7-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412053824.106-1-ychuang570808@gmail.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Move 'nuvoton,npcm-gcr.yaml' from 'arm/npcm' to 'soc/nuvoton'.
Rename the '/arm/npcm' directory to 'arm/nuvoton'. Additionally, add
bindings for ARMv8-based Nuvoton SoCs and platform boards, and include
the initial bindings for ma35d1 series development boards.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
 .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
 .../nuvoton/nuvoton,npcm-gcr.yaml}            |  2 +-
 3 files changed, 32 insertions(+), 2 deletions(-)
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
-- 
2.34.1

