Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD66D94B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbjDFLI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDFLI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:08:57 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0212E61BF;
        Thu,  6 Apr 2023 04:08:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h25so50329148lfv.6;
        Thu, 06 Apr 2023 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680779334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/gb/p8Phn+9Nf7rsHXJphZe6NkAx5/VMdhxR1tnG5eo=;
        b=pCQkgJ0DMSDKS7q2DKALshhL0nUMLxnufHTTeu60Vz20LWnRfEVfnKMoYTYj+0aVTC
         8pF9zic8cgYW/s98jAw9oAdccbwJsFZ1vOgO9joDXycTsZQiEzbKPWBSyFcQppuF2rtZ
         pYCphKV+MnEIQOHgFHD4zrWimK+SOYAFKXCck/JJkdyOKjhxZMAwyAWSaCAl/1Ro156l
         /0jsAGKhDjVv0jaMDOX2aRg7nIesUMcgh5A1VUSWQ5gBJEVFum/i7SGI1wXH/CXkU7Vv
         fVG7/YpYzFKE/Z3BxtU1xU9OZ7HEK+FQFKoE3mq0/1Ok2fCQUNglW/Zznq3tFm9tKSen
         9xCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680779334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/gb/p8Phn+9Nf7rsHXJphZe6NkAx5/VMdhxR1tnG5eo=;
        b=kEiAjfhLnxkrrGhjXIhD6tDFhkhf9fzeQh6x/Ezc4y+QYb2ELR65fUullRqyhBbZ1m
         5TBW48mbGivP1RX0HhhfmSMbMSkUFCTg6uHeBXCX6IPLyB2nfulmWGgrun8ZMUrnltGR
         hqJYLaosm7UUV7OsLjAuWKxeO/0Lw5uL7lCowIe90wxM4kAEOBRy6WhOzdQpwpg7/a3A
         36zDYbUszQtgIBHJqoV833mdLijFUh7C+bOJ4GDXB0JNDC/5RUV3+dAk0UDeh371L46s
         c0GYQcmJ75PbFCjzuoY+FbKNQOc6YcN2eWHYxHko1VTl3w0Ldfrbh178ogLz2IhI5FG5
         WC4g==
X-Gm-Message-State: AAQBX9dOlA+fTPuPDVuay6Uc5VjxQX6jMNAioaLmZLelpgKQvZFcSUd/
        Bjga8dCi+0Dm06BwgY4oGB3Cwcp9P54=
X-Google-Smtp-Source: AKy350Ysp6avI4wzgpDGJnJtHgUBZzokgK4EHBgLxVb8sWq9dms3IaDHErcwEi7Hv7EXosqggHnUgg==
X-Received: by 2002:a05:6512:951:b0:4e9:bafc:88d0 with SMTP id u17-20020a056512095100b004e9bafc88d0mr2486708lft.23.1680779333817;
        Thu, 06 Apr 2023 04:08:53 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id r26-20020ac252ba000000b004e048852377sm218667lfm.263.2023.04.06.04.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:08:53 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/3] dt-bindings: nvmem: brcm,nvram: add #nvmem-cell-cells for MACs
Date:   Thu,  6 Apr 2023 13:08:02 +0200
Message-Id: <20230406110804.12024-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index specifying MAC offset.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/nvmem/brcm,nvram.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
index 36def7128fca..a921e05cc544 100644
--- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
+++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
@@ -36,14 +36,26 @@ properties:
   et0macaddr:
     type: object
     description: First Ethernet interface's MAC address
+    properties:
+      "#nvmem-cell-cells":
+        description: The first argument is a MAC address offset.
+        const: 1
 
   et1macaddr:
     type: object
     description: Second Ethernet interface's MAC address
+    properties:
+      "#nvmem-cell-cells":
+        description: The first argument is a MAC address offset.
+        const: 1
 
   et2macaddr:
     type: object
     description: Third Ethernet interface's MAC address
+    properties:
+      "#nvmem-cell-cells":
+        description: The first argument is a MAC address offset.
+        const: 1
 
 unevaluatedProperties: false
 
-- 
2.34.1

