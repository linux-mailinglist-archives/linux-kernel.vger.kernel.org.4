Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2630E65314E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiLUNHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLUNGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:06:55 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B9D123398;
        Wed, 21 Dec 2022 05:06:49 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1p7yo2-0008Uq-01; Wed, 21 Dec 2022 14:06:46 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 4F28CC254F; Wed, 21 Dec 2022 14:06:39 +0100 (CET)
Date:   Wed, 21 Dec 2022 14:06:39 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-mips@vger.kernel.org, john@phrozen.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ralink: mt7621: avoid to init common ralink reset
 controller
Message-ID: <20221221130639.GB6643@alpha.franken.de>
References: <20221217074806.3225150-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217074806.3225150-1-sergio.paracuellos@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 08:48:06AM +0100, Sergio Paracuellos wrote:
> Commit 38a8553b0a22 ("clk: ralink: make system controller node a reset provider")
> make system controller a reset provider for mt7621 ralink SoCs. Ralink init code
> also tries to start previous common reset controller which at the end tries to
> find device tree node 'ralink,rt2880-reset'. mt7621 device tree file is not
> using at all this node anymore. Hence avoid to init this common reset controller
> for mt7621 ralink SoCs to avoid 'Failed to find reset controller node' boot
> error trace error.
> 
> Fixes: 64b2d6ffff86 ("staging: mt7621-dts: align resets with binding documentation")
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  arch/mips/ralink/of.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
> index ea8072acf8d9..01c132bc33d5 100644
> --- a/arch/mips/ralink/of.c
> +++ b/arch/mips/ralink/of.c
> @@ -21,6 +21,7 @@
>  #include <asm/bootinfo.h>
>  #include <asm/addrspace.h>
>  #include <asm/prom.h>
> +#include <asm/mach-ralink/ralink_regs.h>
>  
>  #include "common.h"
>  
> @@ -81,7 +82,8 @@ static int __init plat_of_setup(void)
>  	__dt_register_buses(soc_info.compatible, "palmbus");
>  
>  	/* make sure that the reset controller is setup early */
> -	ralink_rst_init();
> +	if (ralink_soc != MT762X_SOC_MT7621AT)
> +		ralink_rst_init();
>  
>  	return 0;
>  }
> -- 
> 2.25.1

applied.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
