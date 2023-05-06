Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FE16F8F04
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 08:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjEFGLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 02:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFGLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 02:11:14 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D89B8A55;
        Fri,  5 May 2023 23:11:12 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-332cc0efe88so10506345ab.0;
        Fri, 05 May 2023 23:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683353472; x=1685945472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VE2YlrUyq5bOerpTSJ4F3tPsUEgEruXEc28cG2wMg3A=;
        b=jzHAeMwNfRTd0NdZ/iG/nzD4VC5m1KPVuLB3sK/Jjb/bDlh//nDvbPLAuEY9j4ehHm
         zcs7hbymYw5mgo+474DHEgkcBXD7W3mYdqqgb1YL82jIyeL5mXjO+d1plbqtksNn/23z
         Sxl9s9cLSSGgrGuFBxl8t5zlFb+hwTUeSgpdcPUayIvlRGPzH1U78/u0Hl8N7rOWi01n
         JQuIk/WLE4XqdPBNeTvYVbvrQi4S7KsOfRCZoxb+bDinjuSEL1Sh37VOI1ZFRwwJpIgi
         xNwWbPiDSfDSEpadl9/paJp2evrY+vi0b7zW7j1gbQicrsPzQ1KFuuN5ESX0HAel1z1K
         8VMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683353472; x=1685945472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VE2YlrUyq5bOerpTSJ4F3tPsUEgEruXEc28cG2wMg3A=;
        b=Km/kUCztKumKuL7AO6bdXACXcRba2EOvMMoMYSF0dktiW1Z93AJFcOEHPzKU5KN4RN
         YmfHNoPIcf9RQxD5XR+XiBYZ4VYTC5QurK7sXRNvSHrIlpTM1A7+cWxzZRoA7cMpH4eS
         rYfaWqUwbZILJgtPSAGuzKMi+vB/TuGbeDxKuUliGRfbzoZME3AQTjwwsp77q/ODJM7P
         GA7OV7wlaEKAX9T69wjtT9SIC52hmQUPE2RbqWa/Dfecx3hVnqzQ9HU4ah/G2wXRiXm2
         XjXemoySwO/VX4io0ozaTryH2eYap+k9e0/qy6vJtPVuMAVToVFurk6Qrb6kR7t6Ug3n
         0PxA==
X-Gm-Message-State: AC+VfDziDw4EaPcGwXLu0uEWkrPEpaiN8pbeP8DCSUgYfFZsArUX3JaU
        qQbCvW3Jhj00Y1H3qBZx3cg=
X-Google-Smtp-Source: ACHHUZ6ZnHVBxAHo7DZR0rRf52cK96e9/U3YCE1XTTh+l9xyr4FPCfqeGMLrwoJoW7Uv32XIJa50bA==
X-Received: by 2002:a92:c60f:0:b0:332:dd0a:c6df with SMTP id p15-20020a92c60f000000b00332dd0ac6dfmr2498088ilm.22.1683353471686;
        Fri, 05 May 2023 23:11:11 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id b16-20020a92c850000000b0032e28db67dcsm413047ilq.84.2023.05.05.23.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 23:11:11 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Andrew Lunn <andrew@lunn.ch>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: Add doc for Fastrhino R66S / R68S
Date:   Sat,  6 May 2023 14:11:06 +0800
Message-Id: <20230506061108.17658-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding documentation for the
Lunzn Fastrhino R66S and R68S boards.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---

Changes in v2:
* Collected Ack-by tag.

---
 Documentation/devicetree/bindings/arm/rockchip.yaml    | 7 +++++++
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ec141c937b8b..b1d271778179 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -562,6 +562,13 @@ properties:
           - const: leez,p710
           - const: rockchip,rk3399
 
+      - description: Lunzn FastRhino R66S / R68S
+        items:
+          - enum:
+              - lunzn,fastrhino-r66s
+              - lunzn,fastrhino-r68s
+          - const: rockchip,rk3568
+
       - description: mqmaker MiQi
         items:
           - const: mqmaker,miqi
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 82d39ab0231b..c3d426509e7e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -781,6 +781,8 @@ patternProperties:
     description: Nanjing Loongmasses Ltd.
   "^lsi,.*":
     description: LSI Corp. (LSI Logic)
+  "^lunzn,.*":
+    description: Shenzhen Lunzn Technology Co., Ltd.
   "^lwn,.*":
     description: Liebherr-Werk Nenzing GmbH
   "^lxa,.*":
-- 
2.40.1

