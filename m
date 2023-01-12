Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126AE66714E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjALLxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjALLwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:52:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3271C921
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673523751; x=1705059751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kbR/Rr1hHSRdYw6eJSne8aqgPO3vKuwNYF/xGLJgTqA=;
  b=WoDh9Fu/CCO9KUc4pNMMTWDIxbyhsow6jic1/0Lhz05jU+CjDdWcKCh6
   eQwXl1e58s1EI9FmnF53HJ8Y3ZKj/UiXOqBmCUyDzp11yqmWfvDzcHjnZ
   XQ92g8lw8zfLdd6ODy+3qqLRWwfD/efTuRUPhgehzjlvjzCcElBPBepa6
   bo5otPnAg1BJmW0ycfUZL2IsZrFghtlSkRds39BhmdzlaO1FE9xqrmzkY
   vJBn3a2tG9xOslnCP5S5n6Sr6+tqvzegjJ5o0CpUL4yGGcAKJkyik8IO9
   p8JWi4eAEdhC/XIRbqAMFDdqgNdt3NrZYcaq2vKws/BcKI+IN5vctjzo+
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,319,1669100400"; 
   d="scan'208";a="131994640"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jan 2023 04:42:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 04:42:29 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 04:42:27 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] clocksource/drivers/timer-microchip-pit64b: move COMPILE_TEST on type definition
Date:   Thu, 12 Jan 2023 13:42:10 +0200
Message-ID: <20230112114212.1161136-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112114212.1161136-1-claudiu.beznea@microchip.com>
References: <20230112114212.1161136-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move COMPILE_TEST to menu type definition. This, along with commit
f611af4c3bfa ("ARM: at91: Kconfig: implement PIT64B selection") and the
next one in this series allows simply for driver to compile only on ARM
based platforms which allows further implementing delay timer on top of
PIT64B.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4469e7f555e9..0e87d478a2fa 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -705,8 +705,8 @@ config INGENIC_OST
 	  Support for the Operating System Timer of the Ingenic JZ SoCs.
 
 config MICROCHIP_PIT64B
-	bool "Microchip PIT64B support"
-	depends on OF || COMPILE_TEST
+	bool "Microchip PIT64B support" if COMPILE_TEST
+	depends on OF
 	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel
-- 
2.34.1

