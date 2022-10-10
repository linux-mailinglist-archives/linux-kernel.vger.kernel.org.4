Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BFF5F9BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiJJJJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiJJJJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:09:34 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2211C543F2;
        Mon, 10 Oct 2022 02:09:34 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id F26D3100E5F31;
        Mon, 10 Oct 2022 11:09:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CB85D60DC1; Mon, 10 Oct 2022 11:09:30 +0200 (CEST)
Date:   Mon, 10 Oct 2022 11:09:30 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] Revert "serial: fsl_lpuart: Reset prior to registration"
Message-ID: <20221010090930.GA23968@wunner.de>
References: <20220929085318.5268-1-sherry.sun@nxp.com>
 <1265873d-28f9-d39c-5cce-858dbed1e8e8@linux.intel.com>
 <AS8PR04MB84044F397918A3475B5D8D1D92579@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <39c68295-947-2353-d9b-3bd654c38c7@linux.intel.com>
 <AS8PR04MB8404FAD25C9881FAD2754FB192569@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <b4779edd-200-c7df-4bde-7f434fdefa@linux.intel.com>
 <AS8PR04MB84047F39CD10C00CEE29213F92219@AS8PR04MB8404.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB84047F39CD10C00CEE29213F92219@AS8PR04MB8404.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 10:23:13AM +0000, Sherry Sun wrote:
> I am not familiar with 8250 serial, but at least for imx uart driver
> and lpuart driver, the following behavior is same.
> For the "real" consoles (everything which is not a bootconsole),
> the (port)->cons and (port)->cons->index are initialized through
> uart_add_one_port()->uart_configure_port()->register_console()->
> try_enable_new_console(), here the console index is assigned by
> the console cmdline parameters.

Hm, uart_add_one_port() does the following *before* calling
uart_configure_port():

	/*
	 * If this port is in use as a console then the spinlock is already
	 * initialised.
	 */
	if (!uart_console_enabled(uport))
		uart_port_spin_lock_init(uport);

It sounds like in the case of fsl_lpuart.c, the spin lock is *always*
initialized, even though a concurrent lpuart_console_write() may be
holding it.  That's not solved by moving lpuart_global_reset() around.

The problem with performing lpuart_global_reset() after UART registration
is that as soon as uart_add_one_port() returns, the port is available
for user space to use.  So resetting it is a no-go.

Thanks,

Lukas
