Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9300474737D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjGDN75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjGDN7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:59:49 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD1E10A;
        Tue,  4 Jul 2023 06:59:47 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 1C595120056;
        Tue,  4 Jul 2023 16:59:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1C595120056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688479186;
        bh=jyNhnxKH/UkER4UD50pKQEq3o+4wK8IJLUssC80nzYw=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=UTq3Amm3cVwxraek/UFhC9YTJANjYGkb52Ov4xtwFSfn1nSEZTg0TKDfNfoPPDPyf
         4FlyItqYgp7zNo4IhecNpDExGfeTU+iziwCGY+2OYIX38VuC/LEA9uSS/9ZnR7DR6F
         qcfgxxzz8tGxdC7mThxBzUylcfqpoZiLrTdxcJjnjgZBlqRk+BpgBdHUUhNSGfYOAG
         let0sVMfHu/NnUzSf/paxLiYpvgEAkFVNR0ZzNkehlXrqu62jt2Tm07lEiiuTIGcpR
         ixHBxDDxuQYSkAqMVBmjkdcIXHy5Pcr3qDRp3LYtAhT92+iDAonnVmdNX2/NPD+AJB
         OWos1QKEfSN2g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 16:59:45 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 4 Jul 2023 16:59:35 +0300
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
Subject: [PATCH v1 2/5] tty: serial: meson: redesign the module to platform_driver
Date:   Tue, 4 Jul 2023 16:59:33 +0300
Message-ID: <20230704135936.14697-3-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230704135936.14697-1-ddrokosov@sberdevices.ru>
References: <20230704135936.14697-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178421 [Jul 04 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/04 05:54:00 #21559896
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
 drivers/tty/serial/meson_uart.c | 46 +++++++--------------------------
 1 file changed, 10 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 169f028956ae..87c0eb5f2dba 100644
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
+				      "failed to register meson-uart driver\n");
+	}
+
 	port->iotype = UPIO_MEM;
 	port->mapbase = res_mem->start;
 	port->mapsize = resource_size(res_mem);
@@ -776,6 +774,8 @@ static int meson_uart_remove(struct platform_device *pdev)
 	uart_remove_one_port(&meson_uart_driver, port);
 	meson_ports[pdev->id] = NULL;
 
+	uart_unregister_driver(&meson_uart_driver);
+
 	return 0;
 }
 
@@ -809,33 +809,7 @@ static  struct platform_driver meson_uart_platform_driver = {
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

