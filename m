Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CF5747529
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjGDPTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjGDPT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:19:28 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15B010E5;
        Tue,  4 Jul 2023 08:19:23 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 31559100073;
        Tue,  4 Jul 2023 18:19:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 31559100073
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688483962;
        bh=Uyt8VRq138eJ4/a7wkqKfGms4nxRLNyIIZsH95EbPkU=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=EYgsSf9gx0p44q303AgDZlNH0+n19dmZ3FlDkIhMi2HZROynu/ru+2jxRnho+S/rP
         OCRl3XKS934GNwKasHD/v8vcI8/d4eNCQM/oXBoytq6F7BgIV2t8y9lzyK8j6Yi03p
         H4yJgn2gmcFSftpO/9HaRVQQQMOlg3Umjln0CXRlmweRkNdZpRxPaG1Z6JUnlHIPFr
         9t6r18lDgedv9KPc7gzcG6KPH+Hec/T327CaA0GyhvJviEmXGeqcYlno2OuXPDwiQp
         T8roDM6n91lbBOPudFiLZvWvi5F1dv72c5bE5kxdQXkZNNu6sGrsIFRcodF5ex+hDA
         wDY/xMnMt/ytw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 18:19:21 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 4 Jul
 2023 18:19:10 +0300
Date:   Tue, 4 Jul 2023 18:19:20 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>
CC:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jbrunet@baylibre.com>, <jirislaby@kernel.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <kelvin.zhang@amlogic.com>, <xianwei.zhao@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 2/5] tty: serial: meson: redesign the module to
 platform_driver
Message-ID: <20230704151920.ryjab2kcux5avwfi@CAB-WSD-L081021>
References: <20230704135936.14697-1-ddrokosov@sberdevices.ru>
 <20230704135936.14697-3-ddrokosov@sberdevices.ru>
 <7b06b8cd-f4c9-7636-0f73-48b2f695d7ba@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7b06b8cd-f4c9-7636-0f73-48b2f695d7ba@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178426 [Jul 04 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
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

On Tue, Jul 04, 2023 at 04:46:40PM +0200, neil.armstrong@linaro.org wrote:
> On 04/07/2023 15:59, Dmitry Rokosov wrote:
> > Actually, the meson_uart module is already a platform_driver, but it is
> > currently registered manually and the uart core registration is run
> > outside the probe() scope, which results in some restrictions. For
> > instance, it is not possible to communicate with the OF subsystem
> > because it requires an initialized device object.
> > 
> > To address this issue, apply module_platform_driver() instead of direct
> > module init/exit routines. Additionally, move uart_register_driver() to
> > the driver probe(), and destroy manual console registration because it's
> > already run in the uart_register_driver() flow.
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >   drivers/tty/serial/meson_uart.c | 46 +++++++--------------------------
> >   1 file changed, 10 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> > index 169f028956ae..87c0eb5f2dba 100644
> > --- a/drivers/tty/serial/meson_uart.c
> > +++ b/drivers/tty/serial/meson_uart.c
> > @@ -621,12 +621,6 @@ static struct console meson_serial_console = {
> >   	.data		= &meson_uart_driver,
> >   };
> > -static int __init meson_serial_console_init(void)
> > -{
> > -	register_console(&meson_serial_console);
> > -	return 0;
> > -}
> > -
> >   static void meson_serial_early_console_write(struct console *co,
> >   					     const char *s,
> >   					     u_int count)
> > @@ -652,9 +646,6 @@ OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
> >   #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
> >   #else
> > -static int __init meson_serial_console_init(void) {
> > -	return 0;
> > -}
> >   #define MESON_SERIAL_CONSOLE	NULL
> >   #endif
> > @@ -738,6 +729,13 @@ static int meson_uart_probe(struct platform_device *pdev)
> >   	if (ret)
> >   		return ret;
> > +	if (!meson_uart_driver.state) {
> > +		ret = uart_register_driver(&meson_uart_driver);
> > +		if (ret)
> > +			return dev_err_probe(&pdev->dev, ret,
> > +				      "failed to register meson-uart driver\n");
> > +	}
> 
> PL010 protects this in a mutex, and I think you should do the same otherwise
> if multiple uart probes at the same it will do weird stuff.
> 

Looks like that not all drivers protect this location with a specialized
mutex object. Firstly, I think it's important to verify parallel probe()
calling and implementing mutex protection at the platform core level.
For example, I've faced with the same problem during regmap mutex based
protection.

> > +
> >   	port->iotype = UPIO_MEM;
> >   	port->mapbase = res_mem->start;
> >   	port->mapsize = resource_size(res_mem);
> > @@ -776,6 +774,8 @@ static int meson_uart_remove(struct platform_device *pdev)
> >   	uart_remove_one_port(&meson_uart_driver, port);
> >   	meson_ports[pdev->id] = NULL;
> > +	uart_unregister_driver(&meson_uart_driver);
> > +
> 
> This is dangerous, it will remove the driver even if some uart are still attached to it.
> 
> You should probably do like in pl010_remove() and remove only if the last one is removed.
> 

Indeed... multiple ports can be registered...

> >   	return 0;
> >   }
> > @@ -809,33 +809,7 @@ static  struct platform_driver meson_uart_platform_driver = {
> >   	},
> >   };
> > -static int __init meson_uart_init(void)
> > -{
> > -	int ret;
> > -
> > -	ret = meson_serial_console_init();
> > -	if (ret)
> > -		return ret;
> > -	
> > -	ret = uart_register_driver(&meson_uart_driver);
> > -	if (ret)
> > -		return ret;
> > -
> > -	ret = platform_driver_register(&meson_uart_platform_driver);
> > -	if (ret)
> > -		uart_unregister_driver(&meson_uart_driver);
> > -
> > -	return ret;
> > -}
> > -
> > -static void __exit meson_uart_exit(void)
> > -{
> > -	platform_driver_unregister(&meson_uart_platform_driver);
> > -	uart_unregister_driver(&meson_uart_driver);
> > -}
> > -
> > -module_init(meson_uart_init);
> > -module_exit(meson_uart_exit);
> > +module_platform_driver(meson_uart_platform_driver);
> 
> Only pl010 uses this scheme, and I don't know why... if it works then it's ok for me.

From my point of view, the "scheme" is using uart driver registration
from the probe() routine. Many drivers are based on such approach:
samsung-tty, timbuart, sprd, max3100, etc. Some of them are platform
drivers as well.

> >   MODULE_AUTHOR("Carlo Caione <carlo@caione.org>");
> >   MODULE_DESCRIPTION("Amlogic Meson serial port driver");
> 

-- 
Thank you,
Dmitry
