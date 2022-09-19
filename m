Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89875BCA72
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiISLNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiISLNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:13:09 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19A913F78;
        Mon, 19 Sep 2022 04:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663585988;
  x=1695121988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ztqf2NwNv1t+35CYf00l5OZcaluiYfDwfmYhtP8ylqc=;
  b=e5eZH32D34S8GBWDPCIeJNQ9LtRanE2KO4hfFcRksu7BG35mztulToNy
   CK12TwPZgU9gjDbu6bgEv/CmnGpn1uRneA46Xc0yjASogo+zwUtNPaIen
   0ax9NQd1uGkBGnxOY5WDEA3BuP2W6q40lWIg9qOm5d7jA0xh+0yfbq1xU
   2PLziGJC7NplgYtgjKjzPHlCsOFMvLnTqgnn6Bu+XI0vc337JHhHNa5M1
   bvS48wfSj/tPizHENlGgHcCan8edQVwQgodpqEF+SCvySs1L4a/egXGPR
   mGishhNhoU/etcxeKyyUMYRtwG5DYLuHtjfMNmcxA91kVAf1xdwVKBAfz
   w==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dylan Reid <dgreid@chromium.org>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astridr@axis.com>,
        Astrid Rost <astrid.rost@axis.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: sound: ti,s3a227e: add control of debounce
Date:   Mon, 19 Sep 2022 13:12:57 +0200
Message-ID: <20220919111258.3774-3-astrid.rost@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220919111258.3774-1-astrid.rost@axis.com>
References: <20220919111258.3774-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree parameters to control the insertion, release and press
debounce times.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 .../bindings/sound/ti,ts3a227e.yaml           | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
index 327d204cf957..76ce323ce965 100644
--- a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
@@ -41,6 +41,35 @@ properties:
       - 7 # 2.8 V
     default: 1
 
+  ti,debounce-release-ms:
+    description: key release debounce time in ms (datasheet section 9.6.7).
+    enum:
+      - 0  #  0 ms
+      - 20 # 20 ms
+    default: 20
+
+  ti,debounce-press-ms:
+    description: key press debounce time in ms (datasheet section 9.6.7).
+    enum:
+      - 2   #   2 ms
+      - 40  #  40 ms
+      - 80  #  80 ms
+      - 120 # 120 ms
+    default: 80
+
+  ti,debounce-insertion-ms:
+    description: headset insertion debounce time in ms (datasheet section 9.6.5).
+    enum:
+      - 2    #   2 ms
+      - 30   #  30 ms
+      - 60   #  60 ms
+      - 90   #  90 ms
+      - 120  # 120 ms
+      - 150  # 150 ms
+      - 1000 # 1 s
+      - 2000 # 2 s
+    default: 90
+
 required:
   - compatible
   - reg
-- 
2.20.1

