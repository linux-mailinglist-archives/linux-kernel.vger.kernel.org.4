Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC6F74EA43
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjGKJX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjGKJXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:23:12 -0400
X-Greylist: delayed 81 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 02:19:03 PDT
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5AC44B8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:19:03 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202307110917390949818ac86cb28ad0
        for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jul 2023 11:17:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wE+SEueNbEbwnhCHFDEWPtQJzySe4EclgZMfWR8En/4=;
 b=gt8hEd6JCG6zwuqr5chB1NtzWxJ910wZPCDgmK9GLi8dwDMo+u+xPW84URA2v2SRvoXxx1
 mhwOAdnPpAmEsIYY3ppntPYh6S9DJSqF+lAkkQn6NznpdinLn6Js9cLWAJCe3KmzsGmWKDpo
 6WbeQKTgGX2EFv9tgbyv4OmWsHg/A=;
From:   huaqian.li@siemens.com
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com, Li Hua Qian <huaqian.li@siemens.com>
Subject: [PATCH v2 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support for WDIOF_CARDRESET
Date:   Tue, 11 Jul 2023 17:17:11 +0800
Message-Id: <20230711091713.1113010-2-huaqian.li@siemens.com>
In-Reply-To: <20230711091713.1113010-1-huaqian.li@siemens.com>
References: <20230711091713.1113010-1-huaqian.li@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Hua Qian <huaqian.li@siemens.com>

TI RTI (Real Time Interrupt) Watchdog doesn't support to record the
watchdog cause. Add a reserved memory to know the last reboot was caused
by the watchdog card. In the reserved memory, some specific info will be
saved to indicate whether the watchdog reset was triggered in last
boot.

Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
 .../devicetree/bindings/watchdog/ti,rti-wdt.yaml    | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
index fc553211e42d..f227db08dc70 100644
--- a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
@@ -26,7 +26,18 @@ properties:
       - ti,j7-rti-wdt
 
   reg:
-    maxItems: 1
+    maxItems: 2
+      description:
+	- Contains the address and the size of MCU RTI register.
+	- Contains the address and the size of reserved memory, which
+	  has the pre-stored watchdog reset cause as power-on reason. The
+	  second item is optional.
+	  In the reserved memory, the following values are needed at the
+	  first 12 bytes to tell that last boot was caused by watchdog
+	  reset.
+	  - PON_REASON_SOF_NUM:   0xBBBBCCCC
+	  - PON_REASON_MAGIC_NUM: 0xDDDDDDDD
+	  - PON_REASON_EOF_NUM:   0xCCCCBBBB
 
   clocks:
     maxItems: 1
-- 
2.34.1

