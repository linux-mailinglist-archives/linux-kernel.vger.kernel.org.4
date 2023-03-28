Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0636CB3DA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjC1CUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjC1CTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:19:50 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613F62D76;
        Mon, 27 Mar 2023 19:19:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j13so9515236pjd.1;
        Mon, 27 Mar 2023 19:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679969977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jyCpXhdQrRdIItZilRrI84sFNyhhCD7V61mef/guao=;
        b=nG1dUPYlvn/ycTll+sB9SJovsn4+INiDFfdakFCw8UZZ0t5GqvYOZQBmQWKGRyoOtH
         xlJ7KM3LkysX1Ys2CS4e4RHz57RBNcrv6n28N9Hi6t3IxuAkaz9V/B3f/EKx9IRv3wKp
         ujCxKbT5cXO6M+I2J+mGeiXOJ+iV8SGmPENtk0sYjiCctpp6lZrBx/FREBm13kJD9e+T
         CZQ3xcVLsgb489GksxuAbokkMyxyMZYUFGKc/guHpi0G5mlSjKx1wK9NN+9D9OmmEroj
         sQ7h0NrgzMxqWsJYOMWXH8T84hnpP5rlTHnRsRyi3/5MpioR5hHfPVukpPkBP9uMCzPE
         M+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679969977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jyCpXhdQrRdIItZilRrI84sFNyhhCD7V61mef/guao=;
        b=pJaRDghNertJuGI0h34z/eGGnsslfvscIve9qxQ3GI5YSPkggXf8sUCvtaAlpfBpPn
         xRGaefnr4rNxcOTRvnpeNUYWAzZ0eLN6SjXXiFnIVDIVWZuVteoMvpRwqgf/CUgMndTt
         4EJpbPzDYhyEM0a8CfzJvSAyUhKSUno4FEW9QOkVvnea7X8uGr5Qwhwx8X5BT9cbs523
         Db5A5US1GtcLzexz5rbPN4CHiL9ros1uGjD5i3a6PR5ujlLOw5PM1bjYZlD4RvcQTcWX
         Te/PgLfvDON6Y/6OShhQzEpcRVGwLHuI1HJbKGRhxmsxEr0+Gmf5Lijz1B9UMjlpUO48
         hdWg==
X-Gm-Message-State: AAQBX9cKq7qYrNsMqPW2KNriZ6qdZlOjkvUT/8k25HcTvKs1JBGthwO8
        hiDx3j25NVdWo3ceeY8oHkc=
X-Google-Smtp-Source: AKy350Zx7DLve3aH5qT1Wofayb+2R58sClIDBVU3v+M0f8Q6z2BJPjgWqTQPFfCyEZVpt94TPBBtJA==
X-Received: by 2002:a17:90b:350a:b0:23b:4388:7d8a with SMTP id ls10-20020a17090b350a00b0023b43887d8amr14139825pjb.21.1679969977016;
        Mon, 27 Mar 2023 19:19:37 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090ac29100b00232cc61e16bsm5029301pjt.35.2023.03.27.19.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:19:36 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v6 06/12] dt-bindings: arm: Add initial bindings for Nuvoton platform
Date:   Tue, 28 Mar 2023 02:19:06 +0000
Message-Id: <20230328021912.177301-7-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328021912.177301-1-ychuang570808@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Rename the bindings/arm/npcm directory as nuvoton.
Add binding for ARMv8 based Nuvotn SoCs and platform boards.
Add initial bindings for ma35d1 series development boards.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
 .../nuvoton,npcm-gcr.yaml}                    |  2 +-
 .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
 3 files changed, 32 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
 rename Documentation/devicetree/bindings/arm/{npcm/nuvoton,gcr.yaml => nuvoton/nuvoton,npcm-gcr.yaml} (93%)
 rename Documentation/devicetree/bindings/arm/{npcm/npcm.yaml => nuvoton/nuvoton,npcm.yaml} (93%)

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
diff --git a/Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml b/Documentation/devicetree/bindings/arm/nuvoton/nuvoton,npcm-gcr.yaml
similarity index 93%
rename from Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml
rename to Documentation/devicetree/bindings/arm/nuvoton/nuvoton,npcm-gcr.yaml
index 94e72f25b331..1f354aa900ea 100644
--- a/Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml
+++ b/Documentation/devicetree/bindings/arm/nuvoton/nuvoton,npcm-gcr.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/npcm/nuvoton,gcr.yaml#
+$id: http://devicetree.org/schemas/arm/nuvoton/nuvoton,npcm-gcr.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Global Control Registers block in Nuvoton SoCs
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
-- 
2.34.1

