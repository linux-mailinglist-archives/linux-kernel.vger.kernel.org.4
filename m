Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDC66EA3B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjDUGTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjDUGSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:18:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBD22123;
        Thu, 20 Apr 2023 23:18:45 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33L6IRw14024623, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33L6IRw14024623
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 21 Apr 2023 14:18:27 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 21 Apr 2023 14:18:27 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Apr 2023 14:18:26 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Fri, 21 Apr 2023 14:18:26 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] dt-bindings: usb: snps,dwc3: Add 'snps,global-regs-starting-offset' quirk
Date:   Fri, 21 Apr 2023 14:18:24 +0800
Message-ID: <20230421061825.2233-2-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421061825.2233-1-stanley_chang@realtek.com>
References: <20230421061825.2233-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new 'snps,global-regs-starting-offset' DT to dwc3 core to remap
the global register start address

The RTK DHC SoCs were designed the global register address offset at
0x8100. The default address offset is constant at DWC3_GLOBALS_REGS_START
(0xc100). Therefore, add the property of device-tree to adjust this
address offset.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
 v2 to v3 change:
1.  Fix the dtschema validation error.

 v1 to v2 change:
1. Change the name of the property "snps,global-regs-starting-offset".
2. Adjust the format of comment.
3. Add initial value of the global_regs_starting_offset
4. Remove the log of dev_info.
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index be36956af53b..4f83fa8cb6cb 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -359,6 +359,14 @@ properties:
     items:
       enum: [1, 4, 8, 16, 32, 64, 128, 256]
 
+  snps,global-regs-starting-offset:
+    description:
+      value for remapping global register start address. For some dwc3
+      controller, the dwc3 global register start address is not at
+      default DWC3_GLOBALS_REGS_START (0xc100). This property is added to
+      adjust the address.
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+
   port:
     $ref: /schemas/graph.yaml#/properties/port
     description:
-- 
2.34.1

