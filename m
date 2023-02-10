Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0CE691EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjBJL4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjBJL4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:56:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4EFD523
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:56:29 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1pQS0w-00017t-M4; Fri, 10 Feb 2023 12:56:26 +0100
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1pQS0v-0003Fu-41; Fri, 10 Feb 2023 12:56:25 +0100
Date:   Fri, 10 Feb 2023 12:56:25 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mux: mmio: select REGMAP as the code has that dependency
Message-ID: <20230210115625.GA30942@pengutronix.de>
References: <64cf625b-2495-2382-0331-519d1cab0adf@infradead.org>
 <d1a3d8dd-213b-3772-17a7-c08e06cab837@axentia.se>
 <89199aca-5b57-e8df-03ca-b2658ee9d8b3@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89199aca-5b57-e8df-03ca-b2658ee9d8b3@axentia.se>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 11:46:42AM +0100, Peter Rosin wrote:
> If CONFIG_REGMAP is not active, the build errors out like this:

The driver used to have an indirect dependency on CONFIG_REGMAP via
CONFIG_MFD_SYSCON -> CONFIG_REGMAP_MMIO -> CONFIG_REGMAP until
commit 8ecfaca7926f ("mux: mmio: add generic regmap bitfield-based
multiplexer").

> ../drivers/mux/mmio.c: In function ‘mux_mmio_probe’:
> ../drivers/mux/mmio.c:76:34: error: storage size of ‘field’ isn’t known
>    76 |                 struct reg_field field;
>       |                                  ^~~~~
> In file included from ../include/linux/bits.h:21,
>                  from ../include/linux/bitops.h:6,
>                  from ../drivers/mux/mmio.c:8:
> ../include/linux/bits.h:23:28: error: first argument to ‘__builtin_choose_expr’ not a constant
>    23 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>       |                            ^~~~~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:16:62: note: in definition of macro ‘BUILD_BUG_ON_ZERO’
>    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>       |                                                              ^
> ../include/linux/bits.h:37:10: note: in expansion of macro ‘GENMASK_INPUT_CHECK’
>    37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>       |          ^~~~~~~~~~~~~~~~~~~
> ../drivers/mux/mmio.c:96:29: note: in expansion of macro ‘GENMASK’
>    96 |                 if (mask != GENMASK(field.msb, field.lsb)) {
>       |                             ^~~~~~~
> ../include/linux/build_bug.h:16:51: error: bit-field ‘<anonymous>’ width not an integer constant
>    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>       |                                                   ^
> ../include/linux/bits.h:23:10: note: in expansion of macro ‘BUILD_BUG_ON_ZERO’
>    23 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>       |          ^~~~~~~~~~~~~~~~~
> ../include/linux/bits.h:37:10: note: in expansion of macro ‘GENMASK_INPUT_CHECK’
>    37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>       |          ^~~~~~~~~~~~~~~~~~~
> ../drivers/mux/mmio.c:96:29: note: in expansion of macro ‘GENMASK’
>    96 |                 if (mask != GENMASK(field.msb, field.lsb)) {
>       |                             ^~~~~~~
> ../drivers/mux/mmio.c:102:29: error: implicit declaration of function ‘devm_regmap_field_alloc’ [-Werror=implicit-function-declaration]
>   102 |                 fields[i] = devm_regmap_field_alloc(dev, regmap, field);
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/mux/mmio.c:76:34: warning: unused variable ‘field’ [-Wunused-variable]
>    76 |                 struct reg_field field;
>       |                                  ^~~~~
> 

Fixes: 8ecfaca7926f ("mux: mmio: add generic regmap bitfield-based multiplexer")

> Reported by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/lkml/64cf625b-2495-2382-0331-519d1cab0adf@infradead.org/
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/mux/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> Note, there is a patch in linux-next that removes "|| COMPILE_TEST" from depends.
> 
> Cheers,
> Peter
> 
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index 80f015cf6e54..9234f8c400ca 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -48,6 +48,7 @@ config MUX_GPIO
>  config MUX_MMIO
>  	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
>  	depends on OF
> +	select REGMAP

I get a dependency loop with this:

drivers/net/ethernet/arc/Kconfig:19:error: recursive dependency detected!
drivers/net/ethernet/arc/Kconfig:19:symbol ARC_EMAC_CORE is selected by ARC_EMAC
drivers/net/ethernet/arc/Kconfig:26:symbol ARC_EMAC depends on OF_IRQ
drivers/of/Kconfig:69:symbol OF_IRQ depends on IRQ_DOMAIN
kernel/irq/Kconfig:60:symbol IRQ_DOMAIN is selected by REGMAP
drivers/base/regmap/Kconfig:6:symbol REGMAP is selected by MUX_MMIO
drivers/mux/Kconfig:48:symbol MUX_MMIO depends on MULTIPLEXER
drivers	/mux/Kconfig:6:symbol MULTIPLEXER is selected by MDIO_BUS_MUX_MULTIPLEXER
drivers/net/mdio/Kconfig:261:symbol MDIO_BUS_MUX_MULTIPLEXER depends on MDIO_DEVICE
drivers/net/mdio/Kconfig:6:symbol MDIO_DEVICE is selected by PHYLIB
drivers/net/phy/Kconfig:16:symbol PHYLIB is selected by ARC_EMAC_CORE

(on next-20230210).

regards
Philipp
