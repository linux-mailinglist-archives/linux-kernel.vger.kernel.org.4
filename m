Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF2A748BF0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjGESdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjGEScl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:32:41 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D34130;
        Wed,  5 Jul 2023 11:32:39 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 61188120070;
        Wed,  5 Jul 2023 21:18:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 61188120070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688581124;
        bh=CgHHkQaUikVmJKKkBOsrWXHsYXYWRSpDbopAmvzkH28=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=m8bzVULfvgpsjAsLxm1m3ICpSlxMY9LsGIWbgVVbBmSm4Vif3k4o9+HvSuWL8D/pS
         lA7Jqxb50eyjtESVEU65kLxKkKjHj3EYnPv9toJ4XMghjtKwQa5KW2byuuPfEYk4iD
         /9k9nwHZ/IGnJaCbWmRUNw1F5KBdm2TvEyojO1AedN+S3hubWdGraLh16xuDP0XJ/k
         ZUCfLGPUbWpRlg8yN4vwVolYZfgUcxWJt7NO2GGwANFNtiIC3mzwjBt4BQd8XNLlve
         aUJdbmeFgFf+9fRZyxLOJh+BR6xBvtdJuU8SC1vVOxHbtn3AWir3e2f6qbs0Js+YaV
         dYH6gNxDXQoEQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  5 Jul 2023 21:18:44 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 5 Jul 2023 21:18:41 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <jirislaby@kernel.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>
CC:     <kelvin.zhang@amlogic.com>, <xianwei.zhao@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v2 2/7] tty: serial: meson: redesign the module to platform_driver
Date:   Wed, 5 Jul 2023 21:18:28 +0300
Message-ID: <20230705181833.16137-3-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230705181833.16137-1-ddrokosov@sberdevices.ru>
References: <20230705181833.16137-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178461 [Jul 05 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/05 14:57:00 #21566867
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, the meson_uart module is already a platform_driver, but it is
currently registered manually and the uart core registration is run
outside the probe() scope, which results in some restrictions. For
instance, it is not possible to communicate with the OF subsystem
because it requires an initialized device object.

To address this issue, apply module_platform_driver() instead of direct
module init/exit routines. Additionally, move uart_register_driver() to
the driver probe(), and destroy manual console registration because it's
already run in the uart_register_driver() flow.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/tty/serial/meson_uart.c | 51 ++++++++++-----------------------
 1 file changed, 15 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index bca54f3d92a1..dcf994a11a21 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -621,12 +621,6 @@ static struct console meson_serial_console = {
 	.data		= &meson_uart_driver,
 };
 
-static int __init meson_serial_console_init(void)
-{
-	register_console(&meson_serial_console);
-	return 0;
-}
-
 static void meson_serial_early_console_write(struct console *co,
 					     const char *s,
 					     u_int count)
@@ -652,9 +646,6 @@ OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
 
 #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
 #else
-static int __init meson_serial_console_init(void) {
-	return 0;
-}
 #define MESON_SERIAL_CONSOLE	NULL
 #endif
 
@@ -738,6 +729,13 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (!meson_uart_driver.state) {
+		ret = uart_register_driver(&meson_uart_driver);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "can't register uart driver\n");
+	}
+
 	port->iotype = UPIO_MEM;
 	port->mapbase = res_mem->start;
 	port->mapsize = resource_size(res_mem);
@@ -776,6 +774,13 @@ static int meson_uart_remove(struct platform_device *pdev)
 	uart_remove_one_port(&meson_uart_driver, port);
 	meson_ports[pdev->id] = NULL;
 
+	for (int id = 0; id < AML_UART_PORT_NUM; id++)
+		if (meson_ports[id])
+			return 0;
+
+	/* No more available uart ports, unregister uart driver */
+	uart_unregister_driver(&meson_uart_driver);
+
 	return 0;
 }
 
@@ -809,33 +814,7 @@ static  struct platform_driver meson_uart_platform_driver = {
 	},
 };
 
-static int __init meson_uart_init(void)
-{
-	int ret;
-
-	ret = meson_serial_console_init();
-	if (ret)
-		return ret;
-	
-	ret = uart_register_driver(&meson_uart_driver);
-	if (ret)
-		return ret;
-
-	ret = platform_driver_register(&meson_uart_platform_driver);
-	if (ret)
-		uart_unregister_driver(&meson_uart_driver);
-
-	return ret;
-}
-
-static void __exit meson_uart_exit(void)
-{
-	platform_driver_unregister(&meson_uart_platform_driver);
-	uart_unregister_driver(&meson_uart_driver);
-}
-
-module_init(meson_uart_init);
-module_exit(meson_uart_exit);
+module_platform_driver(meson_uart_platform_driver);
 
 MODULE_AUTHOR("Carlo Caione <carlo@caione.org>");
 MODULE_DESCRIPTION("Amlogic Meson serial port driver");
-- 
2.36.0

