Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BC46EA624
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjDUIoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjDUInx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:43:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E77A5F7;
        Fri, 21 Apr 2023 01:43:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso1455867e87.0;
        Fri, 21 Apr 2023 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682066600; x=1684658600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q07rsXa0P3xMWWHi6ZkgnJ3NXlI5ysIigcoD7BCQBmY=;
        b=PbJFPgJYz2j7H8aC5DGrJSCltkrWgy6Tczn61IFq+5XnUsOWi0Y5rysFYXkGfcn655
         VjqCm8/2asTg3T/IFGQuOh9efjWxyvQkZER7A2shbSxhjCxb9giOOLitDwcHIq0B4euG
         oIe5794WpvAVvpxSUw+Do+pMYzeoLuwnU3azKwo0ptA57BOEtwnnklEyFLly037jrzQZ
         wK9nScxwGkIR4iyd9Aiczjq5+IHdYUsZ/MwspcL01YdS0+pZ56zrb0/bmFJrp4BhLp9c
         LcgEgxkztVVzCIHWSTjyz+dYFB9e/F27Vqs22jMqY8yr0vPjOcj1OVj9VjouZw1RaCXa
         pM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066600; x=1684658600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q07rsXa0P3xMWWHi6ZkgnJ3NXlI5ysIigcoD7BCQBmY=;
        b=aAS6aIlCCoOdfqzD86EnD2m2Q5BHaiq6Tz4mcu7A/A7Npv4Bsh6jBeqyovGP1nHf/C
         zjPC+fYD0HdjWI50c9PhOKAZ+/F8GfR6M04EiTT9+owh/fd1NqTH/YytAYEmrC6IHthu
         Elknaz3fd+efsIV0wnTkihyLkczYdk8auGnjfltZtIu35OdUHtsTYCxEYYIGZrnVRkbE
         DIdG39ekT2+/GdGa8dyH07bO0ivxf6ioqOO5opc0q74o9sdSFk/UZ/VlprlMI6If4tek
         D2ySH2QYZB59wskZzNzJA0gdZoa98RKHzZMi3BngKwc3/Spw8wc6UXnqCR3kH3LbAPTk
         QGkA==
X-Gm-Message-State: AAQBX9fhREsDt5cFqDuDk8vEN7VMQ/EKoC1mXk0+QoDprSgbm0JgBk9W
        lb0WeYmbLy/XbDWRaM55pARDAyAAdVo=
X-Google-Smtp-Source: AKy350Zd2FsPKoohNLaADDdv68ecefoIYa24LgDA2RlBbS9Fy1vzVwkD/aXlpB4D8TlAhGTT9RVYxA==
X-Received: by 2002:a05:6512:376c:b0:4ec:5648:70e4 with SMTP id z12-20020a056512376c00b004ec564870e4mr1183935lft.12.1682066599596;
        Fri, 21 Apr 2023 01:43:19 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id l16-20020ac25550000000b004edc16dbdfasm480721lfk.119.2023.04.21.01.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 01:43:18 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V2 1/3] dt-bindings: nvmem: brcm,nvram: add #nvmem-cell-cells for MACs
Date:   Fri, 21 Apr 2023 10:43:10 +0200
Message-Id: <20230421084312.27932-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

Broadcom's NVRAM contains MACs for Ethernet interfaces. Those MACs are
usually base addresses that are also used for calculating other MACs.

For example if a router vendor decided to use gmac0 it most likely
programmed NVRAM of each unit with a proper "et0macaddr" value. That is
a base.

Ethernet interface is usually connected to switch port. Switch usually
includes few LAN ports and a WAN port. MAC of WAN port gets calculated
as relative address to the interface one. Offset varies depending on
device model.

Wireless MACs may also need to be calculated using relevant offsets.

To support all those scenarios let MAC NVMEM cells be referenced with an
index specifying MAC offset. Disallow additionalProperties while at it.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V2: Add additionalProperties: false
---
 .../devicetree/bindings/nvmem/brcm,nvram.yaml     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
index 36def7128fca..13412af7f046 100644
--- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
+++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
@@ -36,14 +36,29 @@ properties:
   et0macaddr:
     type: object
     description: First Ethernet interface's MAC address
+    properties:
+      "#nvmem-cell-cells":
+        description: The first argument is a MAC address offset.
+        const: 1
+    additionalProperties: false
 
   et1macaddr:
     type: object
     description: Second Ethernet interface's MAC address
+    properties:
+      "#nvmem-cell-cells":
+        description: The first argument is a MAC address offset.
+        const: 1
+    additionalProperties: false
 
   et2macaddr:
     type: object
     description: Third Ethernet interface's MAC address
+    properties:
+      "#nvmem-cell-cells":
+        description: The first argument is a MAC address offset.
+        const: 1
+    additionalProperties: false
 
 unevaluatedProperties: false
 
-- 
2.34.1

