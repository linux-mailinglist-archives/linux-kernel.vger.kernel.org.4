Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC05747791
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjGDRNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjGDRNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:13:34 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FB610F9;
        Tue,  4 Jul 2023 10:13:29 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 7E528120056;
        Tue,  4 Jul 2023 20:13:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7E528120056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688490807;
        bh=x5+P3mBbHT8h/dCMVR19AT87r5tO9pJjC+bCr6L085w=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=ZItN9dkzQBnkMMIduYiUXs3mFWSrtJDQyUrNru6lKEgiQQeLFooMBGubHPf2YyxeK
         tZnHUJA2dcFBO0LCCSBsQOCs0QbP0gcKpW6tiMMFBj9EmkHSZOlYP1qUTrIbVTNP4D
         U2UFPrIpR+0yoOt8UGRfhwyNLAYvMTIDY6KC5Xa7UHyE+AeCVwv04U/XAabrh9iKum
         JY+8szTJ57jcBlEqlHiWe/tfHZewazHC9viHnmma9I3/fRfevE8ujnW9onf3gLZOYl
         blRxbreBdej3nJz5CYYVlS2OSZOtu7UCRStqUkUKVD+jbCyGhvvLxOiB4JjP5Ikxs8
         oczqbr3tyVxPw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 20:13:27 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 4 Jul
 2023 20:13:15 +0300
Date:   Tue, 4 Jul 2023 20:13:26 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Conor Dooley <conor@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <jirislaby@kernel.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <kelvin.zhang@amlogic.com>,
        <xianwei.zhao@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 3/5] tty: serial: meson: apply ttyS devname instead of
 ttyAML for new SoCs
Message-ID: <20230704171326.tyforkt7z23zmgqa@CAB-WSD-L081021>
References: <20230704135936.14697-1-ddrokosov@sberdevices.ru>
 <20230704135936.14697-4-ddrokosov@sberdevices.ru>
 <20230704-pogo-zeppelin-5fa281f5c9e6@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230704-pogo-zeppelin-5fa281f5c9e6@spud>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178431 [Jul 04 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;libera.irclog.whitequark.org:7.1.1;sberdevices.ru:5.0.1,7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/04 13:59:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/04 13:58:00
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

On Tue, Jul 04, 2023 at 05:57:15PM +0100, Conor Dooley wrote:
> On Tue, Jul 04, 2023 at 04:59:34PM +0300, Dmitry Rokosov wrote:
> > It is worth noting that the devname ttyS is a widely recognized tty name
> > and is commonly used by many uart device drivers. Given the established
> > usage and compatibility concerns, it may not be feasible to change the
> > devname for older SoCs. However, for new definitions, it is acceptable
> > and even recommended to use a new devname to help ensure clarity and
> > avoid any potential conflicts on lower or upper software levels.
> 
> > In
> > addition, modify the meson_uart_dt match data for g12a, a1, and s4 to
> > their appropriate values to ensure proper devname values and
> > functionality.
> 
> IMO, this is a separate change that should be in another patch, had to
> go looking through a several of unrelated $subject patches to understand
> how the binding patch was going to work.

I apologize, but I'm having difficulty understanding your suggestion.
Are you recommending that a distinct binding patch for meson-uart-a1 be
sent as part of a separate patch series? From my perspective, isolating
the binding patch may not provide all the necessary context as it is
reliant on a separate 'compatible' declaration within the meson-uart
driver. However, this declaration is interconnected with the devname
support patchset. Therefore, it seems that all of these patches are
linked together.

> > For more information please refer to IRC discussion at [1].
> > 
> > Links:
> >     [1]: https://libera.irclog.whitequark.org/linux-amlogic/2023-07-03
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >  drivers/tty/serial/meson_uart.c | 33 +++++++++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> > index 87c0eb5f2dba..361f9326b527 100644
> > --- a/drivers/tty/serial/meson_uart.c
> > +++ b/drivers/tty/serial/meson_uart.c
> > @@ -82,6 +82,7 @@ static struct uart_driver meson_uart_driver;
> >  static struct uart_port *meson_ports[AML_UART_PORT_NUM];
> >  
> >  struct meson_uart_data {
> > +	const char *dev_name;
> >  	bool has_xtal_div2;
> >  };
> >  
> > @@ -683,6 +684,7 @@ static int meson_uart_probe_clocks(struct platform_device *pdev,
> >  
> >  static int meson_uart_probe(struct platform_device *pdev)
> >  {
> > +	const struct meson_uart_data *priv_data;
> >  	struct resource *res_mem;
> >  	struct uart_port *port;
> >  	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
> > @@ -729,6 +731,18 @@ static int meson_uart_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >  
> > +	priv_data = device_get_match_data(&pdev->dev);
> > +
> > +	if (priv_data) {
> > +		struct console *cons = meson_uart_driver.cons;
> > +
> > +		meson_uart_driver.dev_name = priv_data->dev_name;
> > +
> > +		if (cons)
> > +			strscpy(cons->name, priv_data->dev_name,
> > +				sizeof(cons->name));
> > +	}
> > +
> >  	if (!meson_uart_driver.state) {
> >  		ret = uart_register_driver(&meson_uart_driver);
> >  		if (ret)
> > @@ -748,7 +762,7 @@ static int meson_uart_probe(struct platform_device *pdev)
> >  	port->x_char = 0;
> >  	port->ops = &meson_uart_ops;
> >  	port->fifosize = fifosize;
> > -	port->private_data = (void *)device_get_match_data(&pdev->dev);
> > +	port->private_data = (void *)priv_data;
> >  
> >  	meson_ports[pdev->id] = port;
> >  	platform_set_drvdata(pdev, port);
> > @@ -780,6 +794,17 @@ static int meson_uart_remove(struct platform_device *pdev)
> >  }
> >  
> >  static struct meson_uart_data meson_g12a_uart_data = {
> > +	.dev_name = "ttyAML",
> > +	.has_xtal_div2 = true,
> > +};
> > +
> > +static struct meson_uart_data meson_a1_uart_data = {
> > +	.dev_name = "ttyS",
> > +	.has_xtal_div2 = false,
> > +};
> > +
> > +static struct meson_uart_data meson_s4_uart_data = {
> > +	.dev_name = "ttyS",
> >  	.has_xtal_div2 = true,
> >  };
> >  
> > @@ -794,7 +819,11 @@ static const struct of_device_id meson_uart_dt_match[] = {
> >  	},
> >  	{
> >  		.compatible = "amlogic,meson-s4-uart",
> > -		.data = (void *)&meson_g12a_uart_data,
> > +		.data = (void *)&meson_s4_uart_data,
> > +	},
> > +	{
> > +		.compatible = "amlogic,meson-a1-uart",
> > +		.data = (void *)&meson_a1_uart_data,
> >  	},
> >  	{ /* sentinel */ },
> >  };
> > -- 
> > 2.36.0
> > 



-- 
Thank you,
Dmitry
