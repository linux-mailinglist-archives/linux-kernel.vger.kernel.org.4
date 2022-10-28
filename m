Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4A46113F0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiJ1OEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiJ1OEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:04:33 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C86E90
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:04:30 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id o8so4100826qvw.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bW2zopTlg25jDOdqXgCYa9SYjwIlYLKzQ7Rf0QVa04=;
        b=tRoGixS3L9fuKo5JvypgkaKDRIZhIMHWmSYxz7bwKH7//g7r9C0IeXcbmZJJGWAvwD
         GCUqSeVZiEUtFPvA8CtNRj+Ru9vRDDPo4M3FlV/Om6RkK3gBJWlih/bNjn+V2wjDlg5U
         kVHV1v9hJlZ6Us6Rmt3OnUtal1H7lL8oJXWvZ6+QekHp1Gz6cXIzdtT8XU+5FPtU4YwU
         snbM2BeZSgvGf1cbRlL+IeqEAp0rA6RET1D8NyXIJn9bCBYaKnB8W+GnAJV6CPy9Nrc0
         in2x6ouxSbvQqDeHUNhf4bVSDWz/aq0arwxbap5/srU0v/igfGv/M2hqVEl6BEZLvXYK
         VweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bW2zopTlg25jDOdqXgCYa9SYjwIlYLKzQ7Rf0QVa04=;
        b=dtSpFmxDAZPRu4MlUEV5kvPWEUoQURmWPRSU1tfXQlxKDa6td7K6E7BsGsYvAsqPD4
         hVcMrWvgn96ln1WJjXvls8Wzgn85dBWnCK3fLizK9/RyAXrzaTF6jdCq+XBnBu0eUT1T
         ob1SczHNljZTb0Typ/DS5QjAANCjMNWUlWkcgQeBQdTjDDiumn+lcSRr4Zjeb1cvClkj
         zVkOL51J+MtwMf3EexapQvkvhaxB/9ExRv89oPJEeqcoLyyAO+hSKCqI4o7abfn6WqIP
         nsEBa0vGPPv5YISC7hzXlfWkIWiqHQK9uuBik7XbkhT+kKB034lAmzs9nvrpBoit/kLK
         Itpw==
X-Gm-Message-State: ACrzQf3uiY2bHw++ajNKhLFgfJJ19I6PdBRg15ofPaO9nLTcNuKFYQXh
        jaqdbJ07iuh9YaQH9miFeIj6hQ==
X-Google-Smtp-Source: AMsMyM49sDGd4Fa8wX1KaVJXth7JRPH5eGlWzkuYX3rudY/Vhi5lVq/f8Q8MpgH9RSVOqf5QB9Wpjg==
X-Received: by 2002:a05:6214:1d01:b0:4b0:b782:15a6 with SMTP id e1-20020a0562141d0100b004b0b78215a6mr47232115qvd.43.1666965869069;
        Fri, 28 Oct 2022 07:04:29 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a424800b006ed30a8fb21sm3028252qko.76.2022.10.28.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 07:04:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Martin Botka <martin.botka@somainline.org>,
        Taniya Das <tdas@codeaurora.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Govind Singh <govinds@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: net: constrain number of 'reg' in ethernet ports
Date:   Fri, 28 Oct 2022 10:03:25 -0400
Message-Id: <20221028140326.43470-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028140326.43470-1-krzysztof.kozlowski@linaro.org>
References: <20221028140326.43470-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'reg' without any constraints allows multiple items which is not the
intention for Ethernet controller's port number.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please give it a time for Rob's bot to process this.
---
 Documentation/devicetree/bindings/net/asix,ax88178.yaml       | 4 +++-
 Documentation/devicetree/bindings/net/microchip,lan95xx.yaml  | 4 +++-
 .../devicetree/bindings/net/microchip,lan966x-switch.yaml     | 4 ++--
 .../devicetree/bindings/net/microchip,sparx5-switch.yaml      | 3 ++-
 .../devicetree/bindings/net/mscc,vsc7514-switch.yaml          | 3 ++-
 .../bindings/net/renesas,r8a779f0-ether-switch.yaml           | 4 ++--
 6 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/asix,ax88178.yaml b/Documentation/devicetree/bindings/net/asix,ax88178.yaml
index 1af52358de4c..a81dbc4792f6 100644
--- a/Documentation/devicetree/bindings/net/asix,ax88178.yaml
+++ b/Documentation/devicetree/bindings/net/asix,ax88178.yaml
@@ -27,7 +27,9 @@ properties:
           - usbb95,772b   # ASIX AX88772B
           - usbb95,7e2b   # ASIX AX88772B
 
-  reg: true
+  reg:
+    maxItems: 1
+
   local-mac-address: true
   mac-address: true
 
diff --git a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
index cf91fecd8909..3715c5f8f0e0 100644
--- a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
@@ -39,7 +39,9 @@ properties:
           - usb424,9e08   # SMSC LAN89530 USB Ethernet Device
           - usb424,ec00   # SMSC9512/9514 USB Hub & Ethernet Device
 
-  reg: true
+  reg:
+    maxItems: 1
+
   local-mac-address: true
   mac-address: true
 
diff --git a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
index dc116f14750e..583d70c51be6 100644
--- a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
@@ -83,8 +83,8 @@ properties:
             const: 0
 
           reg:
-            description:
-              Switch port number
+            items:
+              - description: Switch port number
 
           phys:
             description:
diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index 57ffeb8fc876..ccb912561446 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -89,7 +89,8 @@ properties:
 
         properties:
           reg:
-            description: Switch port number
+            items:
+              - description: Switch port number
 
           phys:
             maxItems: 1
diff --git a/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml b/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml
index ee0a504bdb24..1cf82955d75e 100644
--- a/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml
+++ b/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml
@@ -109,7 +109,8 @@ properties:
 
         properties:
           reg:
-            description: Switch port number
+            items:
+              - description: Switch port number
 
           phy-handle: true
 
diff --git a/Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml b/Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml
index 581fff8902f4..0eba66a29c6c 100644
--- a/Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml
@@ -106,8 +106,8 @@ properties:
 
         properties:
           reg:
-            description:
-              Port number of ETHA (TSNA).
+            items:
+              - description: Port number of ETHA (TSNA).
 
           phys:
             maxItems: 1
-- 
2.34.1

