Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC935EAB96
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiIZPsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiIZPsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:48:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A3E5F73;
        Mon, 26 Sep 2022 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664202848; x=1695738848;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CvP6K1Vorsow+70c6DvAAnB16X5penLoTqxCk6a67jA=;
  b=iWxinrSyoQ5sH5ckodMjjP5DJEl1RcsiuwUl5UzmTE7NIr2HVj/N4y5c
   hSKYulxLCT+LES5MHSsu4UdBe4YE5waIWIrmHxJDakplaN9qo5b9uAnk6
   6sToRNHCY57HTLhB80yE95rMcg2WfiVqdO57DyrAuAWW6+iLrV10URoit
   oqgNJyf69Gc6lGxdE4knGSWFH6gBz3Lw+nmoaraeic/oopNb1D673O5IW
   +7JAGLtiDCUVyNQ91FGtUDwk3KR6X4jziOE4VRGSaLc6b+7i8qY+Tvqy6
   940nnZl/8xTQKCvyl2m3q7DPaRK+iFidzZfKTRievNJ1hgRnCMigixdvi
   g==;
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="115431607"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Sep 2022 07:34:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 26 Sep 2022 07:34:03 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 26 Sep 2022 07:34:01 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <sergiu.moga@microchip.com>, <claudiu.beznea@microchip.com>,
        <richard.genoud@gmail.com>, <nicolas.ferre@microchip.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "kernel test robot" <lkp@intel.com>
Subject: [PATCH] tty: serial: atmel: Add COMMON_CLK dependency to SERIAL_ATMEL
Date:   Mon, 26 Sep 2022 17:32:45 +0300
Message-ID: <20220926143244.485578-1-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver makes use of `__clk_is_enabled()` in order to
know whether a `clk_disable_unprepare()` is needed or not on the
GCLK, a new dependency has been introduced: COMMON_CLK. If this
`CONFIG_COMMON_CLK` is not enabled, whatever config may have this
driver enabled without COMMON_CLK then an undefined reference to
`__clk_is_enabled()` will be issued by the linker.

Thus, make sure that, unless `CONFIG_COMMON_CLK` is enabled, this
driver is not compiled.

Fixes: 5e3ce1f26129 ("tty: serial: atmel: Make the driver aware of the existence of GCLK")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a18dd525e42b..1aec3cf002f7 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -127,6 +127,7 @@ config SERIAL_SB1250_DUART_CONSOLE
 
 config SERIAL_ATMEL
 	bool "AT91 on-chip serial port support"
+	depends on COMMON_CLK
 	depends on ARCH_AT91 || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
-- 
2.34.1

