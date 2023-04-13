Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF0F6E0B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDMKJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjDMKJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:09:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B76CAF;
        Thu, 13 Apr 2023 03:09:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33DA8rVB2018677, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33DA8rVB2018677
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 13 Apr 2023 18:08:53 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 13 Apr 2023 18:09:15 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 13 Apr 2023 18:09:15 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Thu, 13 Apr 2023 18:09:15 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] dt-bindings: usb: snps,dwc3: Add 'snps,parkmode-disable-hs-quirk' quirk
Date:   Thu, 13 Apr 2023 18:09:14 +0800
Message-ID: <20230413100914.7890-2-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230413100914.7890-1-stanley_chang@realtek.com>
References: <20230413100914.7890-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new 'snps,parkmode-disable-hs-quirk' DT quirk to dwc3 core for
disable the high-speed parkmode.

For some USB wifi devices, if enable this feature it will reduce the
performance. Therefore, add an option for disabling HS park mode by
device-tree.

In Synopsys's dwc3 data book:
In a few high speed devices when an IN request is sent within 900ns of the
ACK of the previous packet, these devices send a NAK. When connected to
these devices, if required, the software can disable the park mode if you
see performance drop in your system. When park mode is disabled,
pipelining of multiple packet is disabled and instead one packet at a time
is requested by the scheduler. This allows up to 12 NAKs in a micro-frame
and improves performance of these slow devices.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
v2 to v3 change:
1. Add the comment message.
2. cc the right maintainers.
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index be36956af53b..45ca967b8d14 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -232,6 +232,11 @@ properties:
       When set, all SuperSpeed bus instances in park mode are disabled.
     type: boolean
 
+  snps,parkmode-disable-hs-quirk:
+    description:
+      When set, all HighSpeed bus instances in park mode are disabled.
+    type: boolean
+
   snps,dis_metastability_quirk:
     description:
       When set, disable metastability workaround. CAUTION! Use only if you are
-- 
2.34.1

