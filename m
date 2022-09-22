Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D39E5E618D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiIVLn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiIVLnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:43:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F18E5109;
        Thu, 22 Sep 2022 04:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663846973; x=1695382973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QKOSdHrlA3wS3tOYAGSbN64ZDlbNP+x4BlIl2OTwIls=;
  b=VLcpppXb0udYCUiBPh35vuzWobTHHhgzXosGv2SHA+oBCTUIttrL4/20
   urGuWI3l3jWdSE7EbG31v4FlMUPVJtAFcKancgizOub84pYnAWRCNQHN5
   2ow/W/VocAnY47hG29j6Ez4xfj8+QmZMJPdAt17p6C6BHm6dnbOHurWVa
   2rMYWXOKHkGA5yFvjtskqzgUUjFcFYHjTFjCgQvInHKgX68iXYaC2Q02m
   tReq6r4okk+cj0MwJSlCxP8NymI4Hj/TEVR9RqqLoro72bPOyExu272/k
   yqTkNH7uuX4V5Lz39K+uD1PQdaFiiv0mdaVcizWrDqGO9NP5AYTkhh0uw
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="114897484"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Sep 2022 04:42:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 22 Sep 2022 04:42:51 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 22 Sep 2022 04:42:43 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <kavyasree.kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 5/9] dt-bindings: serial: atmel,at91-usart: Add gclk as a possible USART clock
Date:   Thu, 22 Sep 2022 14:33:43 +0300
Message-ID: <20220922113347.144383-6-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922113347.144383-1-sergiu.moga@microchip.com>
References: <20220922113347.144383-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Devicetree nodes for FLEXCOM's USART can also have an alternative
clock source for the baudrate generator (other than the peripheral
clock), namely the Generick Clock. Thus make the binding aware of
this clock that someone may place in the clock related
properties of the USART node.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---



v1 -> v2:
- Nothing, this patch was not here before


v2 -> v3:
- Nothing, Previously this was [PATCH 13]


v3 -> v4:
- Add A-b tag, this was previously [PATCH 9]



v4 -> v5:
- Nothing



 .../devicetree/bindings/serial/atmel,at91-usart.yaml   | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index 4da642763bef..30b2131b5860 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -36,10 +36,16 @@ properties:
     maxItems: 1
 
   clock-names:
-    const: usart
+    minItems: 1
+    items:
+      - const: usart
+      - const: gclk
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: USART Peripheral Clock
+      - description: USART Generic Clock
 
   dmas:
     items:
-- 
2.34.1

