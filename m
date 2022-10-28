Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6B761077F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 03:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiJ1BzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 21:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiJ1BzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 21:55:15 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43B82B60F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:55:08 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id u7so3165939qvn.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2bW2zopTlg25jDOdqXgCYa9SYjwIlYLKzQ7Rf0QVa04=;
        b=uI3ltAYZAP8NoIfYF9BFEMoMJ7D97b1+QqthrWkKCU7dXaoT1abWklIUuN7W1JgOQd
         GjkudrHR5lP10j6XjwqHIIrvISOE+Gh8hx0EolZiPSYHBU/+KaL3/7XNhE7D8kz5bTE9
         CG8Lmy2GhCO1xySyJ8A8zSxkD8wvM+N6jCuc8xB1sBTlXNIbYOXjYQC1NMmpzjH4B6Qu
         RajDjRnp9CkXaRtMHjLDkR7k3hF5xKmhALXHDPueVk1bZ8I3PxOG4uxZWAHrswZrMLXs
         tGN334gJOnp5V3OMr4wKdIx2joqMYF9kbd1iQRH4u91OWC0o/ERNmjeynXomL7iIIFuB
         S5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bW2zopTlg25jDOdqXgCYa9SYjwIlYLKzQ7Rf0QVa04=;
        b=kPP3zQKsqXW+UBhCrFS/sxYTdLQp8RYKorbHYZmQyf1EcNf1tP2iNAIUKXPRYejhdr
         D8XzEk/LLdNj2IM4GL13xJET/CXKzinxq4ciYJ6D7iGzLvR0yILM3Dt31fUVV6wAR4gw
         JCJrgVnZfyKOq9ctohkJtEYbeXpGySv44E2S6Hx3s2UlX2IJNlsYwbMF8yY+GqC3C+ZY
         /koJNgOuxW6SYAADtPbNeETrTsAzeOqgiXvYvhfWxHOYo+jwjJx5jLNEc+ykoqQquFAx
         UTtOpX3yyoE1MWCXoIjVaPpDBHPoYxQfm27e4ijjuG3izk6TcjTR81ZkrSgcaDA6cdgu
         3LfQ==
X-Gm-Message-State: ACrzQf1BIH9eK00xrWVFUhR7WUchHOTRC25p4MNVBW1OtD4s72ZWBegQ
        rpXQg19MV3noxNEZCv562W+Jv/uNZLVrWA==
X-Google-Smtp-Source: AMsMyM75QUav7tBwGMpChuFcCrl4I7ooRQZeT0bj+c7r0BGWeRmtlCvrL6E6OPOdePWKh+nOepUJNw==
X-Received: by 2002:a05:6214:19c9:b0:4b2:fe6f:90f9 with SMTP id j9-20020a05621419c900b004b2fe6f90f9mr43025226qvc.66.1666922097007;
        Thu, 27 Oct 2022 18:54:57 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id l15-20020ac84a8f000000b0035cd6a4ba3csm1714720qtq.39.2022.10.27.18.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 18:54:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: net: constrain number of 'reg' in ethernet ports
Date:   Thu, 27 Oct 2022 21:54:53 -0400
Message-Id: <20221028015453.101251-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

