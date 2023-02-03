Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B80A689972
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjBCNGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjBCNGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:06:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51A723C48
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 05:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675429573; x=1706965573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DyboerXgRrHsXvcYUN4vyeBV/QtD37x9PgW3VZSmE8Y=;
  b=hQYrDnZV6VmA9NbyoRVrIf27vkISZoJ0kORsEpwlT/kaxHv3ea1BrXxz
   om0jz8qmQG32210w//mEeMa9Co16oRAznAv4UcbT2xYwID7ksD+Sm5h/2
   +AMKK5pjTJo9gQmMzd+pokQ5Y08KM5Lhiw1EijjdZc21dmVKTQNhRSbiz
   fvBOQXGLFbgyn6spUFHEGhCnr2L1UICwIxoC5Jz1DjI9Yc4bKIXEXvuyq
   TDH1TEtX9LUBokuA6KJiqtF07aWkM4KfRFzAJdAtI2/aZYmuG4tY6aXid
   AOnNRScziFMUZNiDCciyFFf5h+33cTB9Nq6CV1uoxQj8oYB1fbK2uTdo9
   w==;
X-IronPort-AV: E=Sophos;i="5.97,270,1669100400"; 
   d="scan'208";a="210478738"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Feb 2023 06:06:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 06:06:14 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 06:06:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/2] clocksource/drivers/timer-microchip-pit64b: select driver only on ARM
Date:   Fri, 3 Feb 2023 15:05:36 +0200
Message-ID: <20230203130537.1921608-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203130537.1921608-1-claudiu.beznea@microchip.com>
References: <20230203130537.1921608-1-claudiu.beznea@microchip.com>
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
index 778dad0c06a9..5fc8f0e7fb38 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -706,7 +706,7 @@ config INGENIC_OST
 
 config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
-	depends on OF
+	depends on OF && ARM
 	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel
-- 
2.34.1

