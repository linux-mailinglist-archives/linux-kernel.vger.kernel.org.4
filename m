Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A6B667151
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbjALLx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjALLwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:52:42 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACFD5F4BA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673523754; x=1705059754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nobcDiLUT9+yL7uqUczxO6o6KxX+J0prL7igRy1oq3I=;
  b=ZsbymbgfBt9Wz24RES0x7E1yUZ5l+93p5ro59TwzsqqWkYp5r2EKTh6I
   aSvKcVwYxmF2LzEQX+T7IGWrMQLi/y7n5rR21mrYkpgBJ+iVwWmNW61M0
   YXXfPXMy9QXggG/Libd/ybvmfG3L+RgUTBTO2ozvsLwKP+u83ftGGS68N
   e3MMe2mfmhDF8adItOab/bdbpO4qX+ThvVR67WxxFxVExHjHWbGdQlJr2
   FSvs4pffDexiIe3FlOfCLBY582ldKU8R2hhX+S31br+SpDTai6J6B7EnS
   0THexxXraZ8Fcv30w2yW+HQbW/nFGeDqJxfKZQJHtXif7JCt/FR2ARCCw
   A==;
X-IronPort-AV: E=Sophos;i="5.97,319,1669100400"; 
   d="scan'208";a="191905709"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jan 2023 04:42:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 04:42:31 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 04:42:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] clocksource/drivers/timer-microchip-pit64b: select driver only on ARM
Date:   Thu, 12 Jan 2023 13:42:11 +0200
Message-ID: <20230112114212.1161136-3-claudiu.beznea@microchip.com>
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

Microchip PIT64B is currently available on ARM based devices. Thus
select it only for ARM. This allows implementing delay timer.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 0e87d478a2fa..d47825e72dc2 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -706,7 +706,7 @@ config INGENIC_OST
 
 config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support" if COMPILE_TEST
-	depends on OF
+	depends on OF && ARM
 	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel
-- 
2.34.1

