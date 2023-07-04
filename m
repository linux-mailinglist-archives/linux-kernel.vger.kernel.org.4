Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F04747379
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGDN7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjGDN7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:59:49 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486FBE6D;
        Tue,  4 Jul 2023 06:59:47 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 3F940100069;
        Tue,  4 Jul 2023 16:59:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3F940100069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688479185;
        bh=EtvSf+vqP9FOlSRxzL4nhak0b5LMcwi8O2nGQTCTz7k=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=J4rBARU+YHzxAYxCtemsaSPS7Qar6wgSlFeS9x+sW9lzyNv+/gfusSvbh8iOIIBB7
         cp2zHKoeEa83SVYZvdZp62+eOZ04w5pWKhbja1VwV/o6yZC7aM/zA4tt5eDCjNIHWk
         A70LYMY8abl6YmXHZ1kc4q0Yo7fqep+l8fhlLnNKsUvyXOE9zTJ6ANR01/hUKqglb5
         yRKdvJReN2SAHui+ETNrl553nLXThajwBG++2nCRRN0sPNWOPOFKdFiJ6T+hahIToT
         XyxS0khkyAHENfhxVv6nPULaaSyQ3Y0wDzmkk/mCDom31bExyy60MwW707PjMUsT4u
         VbOVMOKeswFxw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 16:59:45 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 4 Jul 2023 16:59:34 +0300
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
Subject: [PATCH v1 1/5] tty: serial: meson: use dev_err_probe
Date:   Tue, 4 Jul 2023 16:59:32 +0300
Message-ID: <20230704135936.14697-2-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 178420 [Jul 04 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
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

Use dev_err_probe() helper for error checking and standard logging.
It makes the driver's probe() function a little bit shorter.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/tty/serial/meson_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 2501db5a7aaf..169f028956ae 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -726,8 +726,8 @@ static int meson_uart_probe(struct platform_device *pdev)
 	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
 
 	if (meson_ports[pdev->id]) {
-		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
-		return -EBUSY;
+		return dev_err_probe(&pdev->dev, -EBUSY,
+			      "port %d already allocated\n", pdev->id);
 	}
 
 	port = devm_kzalloc(&pdev->dev, sizeof(struct uart_port), GFP_KERNEL);
-- 
2.36.0

