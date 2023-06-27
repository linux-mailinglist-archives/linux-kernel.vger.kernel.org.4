Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9023173FC85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjF0NKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjF0NKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:10:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127772941
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:10:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa99742be2so21871575e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687871445; x=1690463445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCk2o78QJovxCBxHGCqUEI7lERo4Q9zzKKe3nZzi7bU=;
        b=qIB71MnZz2fBHr/TcrME+FFc8bjTrtv+3sAOzv7c+IHZ9twL3OOqwoep8s3BWWbJNz
         qQquhfB01FbVIyGv/XeniE1aP0KTJ8Ahyo0cGx1/JMWg2Kvnt9yD93YLe7tVxS/Bj/KS
         ceSeCCbpLG0dvr1fOV/+XbVg1xdIZC+Qv4QY/Z+bIv7rEHV6oODShoVVVVUnMp75cyof
         rPTF/4Sa1TZDYNQclQ3Q6wGdCNwPgO8JB340iW3UXp/D8Y5XUJhHCI56TlYhuHMBvXNY
         UzGHy6UBcv9jS3lLXe+5I/Jw9f/cCx8MwkMNzCynnRmuSfxMcZajbd8pelhECY6ySqo8
         wi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687871445; x=1690463445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCk2o78QJovxCBxHGCqUEI7lERo4Q9zzKKe3nZzi7bU=;
        b=Lz8xGIq6kAoRiACHXVE2kPvmmukvMUFD/EcREqIIPuuyy9G5lzM4S7NxISB08iUhM0
         0Moc8Bap++Luv6QvRo7Z52e8dayD7V7xwhndpHmUSqvgg9NijJtNa93UgePSphVTeGtr
         wX00k3GBJj1vGsI4rZsubCFG5T1uwNRmr9i1jVwnLjzzMjclwuXUU4/LShNHnwUBlv2E
         ucG67C22Ffhnf0HtNzhxKrghASOl3Cw4loBPhEo/0gNPBrt/rO8KiWtMBYp6WGlz/uSm
         rtH+iEVZhsjQjj5riFL+OJHvHmDDJgyMyFvyxVSY/c3s037Q0YEtcSq5/Et0C7Zvd3H2
         RiqQ==
X-Gm-Message-State: AC+VfDwLtq0dh0GHe4lT1mgmIVLtzwN9A/1DU3LhO8sFUw89p7Ipf971
        lH/W65rDYCA2kVGlxqNyG++2mQ==
X-Google-Smtp-Source: ACHHUZ6/7krOTxEO+j2wvtd3gYi+4CLtFtgCZJBgUkA6uMoHAcMhJEfgsz9Jwhx3YvX50/ZuXjl/Yw==
X-Received: by 2002:a7b:c852:0:b0:3fb:415a:d07 with SMTP id c18-20020a7bc852000000b003fb415a0d07mr2552909wml.36.1687871445397;
        Tue, 27 Jun 2023 06:10:45 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id z26-20020a1c4c1a000000b003f91e32b1ebsm1403196wmf.17.2023.06.27.06.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 06:10:45 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/8] dt-bindings: power: Add MT8365 power domains
Date:   Tue, 27 Jun 2023 15:10:33 +0200
Message-Id: <20230627131040.3418538-2-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627131040.3418538-1-msp@baylibre.com>
References: <20230627131040.3418538-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add power domains dt-bindings for MT8365.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../power/mediatek,power-controller.yaml      |  6 ++++++
 .../dt-bindings/power/mediatek,mt8365-power.h | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index c9acef80f452..8985e2df8a56 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -31,6 +31,7 @@ properties:
       - mediatek,mt8188-power-controller
       - mediatek,mt8192-power-controller
       - mediatek,mt8195-power-controller
+      - mediatek,mt8365-power-controller
 
   '#power-domain-cells':
     const: 1
@@ -88,6 +89,7 @@ $defs:
               "include/dt-bindings/power/mediatek,mt8188-power.h" - for MT8188 type power domain.
               "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
               "include/dt-bindings/power/mt8195-power.h" - for MT8195 type power domain.
+              "include/dt-bindings/power/mediatek,mt8365-power.h" - for MT8365 type power domain.
         maxItems: 1
 
       clocks:
@@ -115,6 +117,10 @@ $defs:
         $ref: /schemas/types.yaml#/definitions/phandle
         description: phandle to the device containing the INFRACFG register range.
 
+      mediatek,infracfg-nao:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to the device containing the INFRACFG-NAO register range.
+
       mediatek,smi:
         $ref: /schemas/types.yaml#/definitions/phandle
         description: phandle to the device containing the SMI register range.
diff --git a/include/dt-bindings/power/mediatek,mt8365-power.h b/include/dt-bindings/power/mediatek,mt8365-power.h
new file mode 100644
index 000000000000..e6cfd0ec7871
--- /dev/null
+++ b/include/dt-bindings/power/mediatek,mt8365-power.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8365_POWER_H
+#define _DT_BINDINGS_POWER_MT8365_POWER_H
+
+#define MT8365_POWER_DOMAIN_MM		0
+#define MT8365_POWER_DOMAIN_CONN	1
+#define MT8365_POWER_DOMAIN_MFG		2
+#define MT8365_POWER_DOMAIN_AUDIO	3
+#define MT8365_POWER_DOMAIN_CAM		4
+#define MT8365_POWER_DOMAIN_DSP		5
+#define MT8365_POWER_DOMAIN_VDEC	6
+#define MT8365_POWER_DOMAIN_VENC	7
+#define MT8365_POWER_DOMAIN_APU		8
+
+#endif /* _DT_BINDINGS_POWER_MT8365_POWER_H */
-- 
2.40.1

